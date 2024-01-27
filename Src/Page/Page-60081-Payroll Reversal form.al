page 60081 "Payroll Reversal form"
{
    PageType = Card;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            field(YEAR1; YEAR1)
            {
                ApplicationArea = all;
                Caption = 'YEAR';
            }
            field(MONTH1; MONTH1)
            {
                ApplicationArea = all;
                Caption = 'MONTH';
            }
            field(ALL; ALL)
            {
                Caption = 'ALL';
                Visible = true;
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    IF ALL THEN BEGIN
                        employeeNo := '';
                        EMPEditable := FALSE;
                    END
                    ELSE
                        EMPEditable := TRUE;
                end;
            }
            field(EMP; employeeNo)
            {
                Caption = 'Employee Code';
                Editable = EMPEditable;
                ApplicationArea = all;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    IF PAGE.RUNMODAL(60005, employee) = ACTION::LookupOK THEN BEGIN
                        IF ALL THEN
                            employeeNo := ''
                        ELSE
                            employeeNo := employee."No.";
                    END;
                end;

                trigger OnValidate()
                begin
                    IF ALL THEN BEGIN
                        employeeNo := '';
                        EMPEditable := FALSE;
                    END
                    ELSE
                        EMPEditable := TRUE;
                end;
            }
            field(Docno; Docno)
            {
                Caption = 'Document No.';
                ApplicationArea = all;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    GlEntry.RESET;
                    GlEntry.SETCURRENTKEY("Journal Batch Name");
                    GlEntry.SETRANGE("Journal Batch Name", 'PAYROLL');
                    IF PAGE.RUNMODAL(0, GlEntry) = ACTION::LookupOK THEN
                        Docno := GlEntry."Document No.";
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Reverse Transaction")
            {
                Caption = 'Reverse Transaction';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    IF (YEAR1 = 0) THEN
                        ERROR('Enter year');
                    IF (MONTH1 = 0) THEN
                        ERROR('Enter Month');
                    IF (ALL = FALSE) AND (employeeNo = '') THEN
                        ERROR('Enter Employe No or Select all');
                    IF Docno = '' THEN
                        ERROR('Document No. Should not be Empty...');
                    IF employeeNo = '' THEN
                        ERROR('Employee No. Should not be Empty...');

                    IF Docno = '' THEN BEGIN
                        ProcessedSalary3.RESET;
                        IF NOT ALL THEN BEGIN
                            ProcessedSalary3.SETRANGE("Pay Slip Month", MONTH1);
                            ProcessedSalary3.SETRANGE(Year, YEAR1);
                            ProcessedSalary3.SETRANGE("Employee Code", employeeNo);
                            ProcessedSalary3.SETRANGE(Reversed, FALSE);
                            IF ProcessedSalary3.FIND('-') THEN BEGIN

                                Docno := ProcessedSalary3."Document No";
                                getdocno;
                            END ELSE
                                MESSAGE('Check the inputs');
                        END
                        ELSE BEGIN
                            ProcessedSalary3.RESET;
                            ProcessedSalary3.SETRANGE("Pay Slip Month", MONTH1);
                            ProcessedSalary3.SETRANGE(Year, YEAR1);
                            ProcessedSalary3.SETRANGE(Reversed, FALSE);
                            IF ProcessedSalary3.FIND('-') THEN
                                REPEAT

                                    Docno := ProcessedSalary3."Document No";
                                    getdocno;
                                UNTIL ProcessedSalary3.NEXT = 0;
                        END;
                    END ELSE
                        getdocno;

                    IF flag THEN
                        MESSAGE(Text003);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        EMPEditable := TRUE;
    end;

    var
        GlEntry: Record 17;
        Docno: Code[50];
        employeeNo: Code[50];
        employee: Record 60019;
        Entryno: Integer;
        TransNo: Integer;
        ReversalEntry: Record 179;
        Text000: Label 'Reverse Transaction Entries';
        Text001: Label 'Reverse Register Entries';
        Text002: Label 'Do you want to reverse the entries?';
        Text003: Label 'The entries were successfully reversed.';
        Text004: Label 'To reverse these entries, the program will post correcting entries.';
        Text005: Label 'Do you want to reverse the entries and print the report?';
        Text006: Label 'There is nothing to reverse.';
        ReversalEntry1: Record 179;
        ProcessedSalary: Record 60038;
        ProcessedSalary1: Record 60038 temporary;
        Lineno: Integer;
        ProcessedSalary3: Record 60038;
        ProcessedSalary2: Record 60038;
        postedotherpay: Record 60036;
        ln: Integer;
        ALL: Boolean;
        YEAR1: Integer;
        MONTH1: Integer;
        flag1: Boolean;
        Lno: Integer;
        MonthlyAtt1: Record 60029 temporary;
        flag: Boolean;
        //[InDataSet]
        EMPEditable: Boolean;

    //  [Scope('Internal')]
    procedure Post12(PrintRegister: Boolean; var REVERSAL: Record 179)
    var
        GLReg: Record 45;
        GenJnlTemplate: Record 80;
        //GenJnlPostLine: Codeunit  12;
        Txt: Text[250];
    begin
        REVERSAL.FIND('-');
        ReversalEntry1 := REVERSAL;
        IF REVERSAL."Reversal Type" = REVERSAL."Reversal Type"::Transaction THEN BEGIN
            CurrPage.CAPTION := Text000;
            ReversalEntry1.SetReverseFilter(ReversalEntry1."Transaction No.", REVERSAL."Reversal Type");
        END ELSE BEGIN
            CurrPage.CAPTION := Text001;
            ReversalEntry1.SetReverseFilter(ReversalEntry1."G/L Register No.", REVERSAL."Reversal Type");
        END;



        IF NOT REVERSAL.FIND('-') THEN
            ERROR(Text006);
        IF PrintRegister THEN
            Txt := Text004 + '\' + Text005
        ELSE
            Txt := Text004 + '\' + Text002;

        BEGIN
            ReversalEntry1.CheckEntries;
            //GenJnlPostLine.Reverse(ReversalEntry1,REVERSAL);  //RSPL-TC

            IF PrintRegister THEN BEGIN
                GenJnlTemplate.VALIDATE(Type);
                IF GenJnlTemplate."Posting Report ID" <> 0 THEN BEGIN
                    IF GLReg.FIND('+') THEN BEGIN
                        GLReg.SETRECFILTER;
                        REPORT.RUN(GenJnlTemplate."Posting Report ID", FALSE, FALSE, GLReg);
                    END;
                END;
            END;
            ReversalEntry1.DELETEALL;
        END;
    end;

    //  [Scope('Internal')]
    procedure PostedOterpayrevers()
    var
        postedotherpay1: Record 60036;
        postedotherpay2: Record 60036;
    begin
        postedotherpay1.INIT;
        ProcessedSalary3.INIT;
        postedotherpay.INIT;
        postedotherpay.SETRANGE("Employee No.", employeeNo);
        postedotherpay.SETRANGE(Month, ProcessedSalary."Pay Slip Month");
        postedotherpay.SETRANGE(Year, ProcessedSalary.Year);
        IF postedotherpay.FIND('-') THEN BEGIN
            postedotherpay1.SETRANGE("Employee No.", employeeNo);
            postedotherpay1.SETRANGE(Month, ProcessedSalary."Pay Slip Month");
            postedotherpay1.SETRANGE(Year, ProcessedSalary.Year);
            postedotherpay1.SETRANGE("Pay Element Code", postedotherpay."Pay Element Code");
            IF postedotherpay1.FIND('+') THEN BEGIN
                ln := postedotherpay1.LineNo + 10000;
                postedotherpay1.Reversed := TRUE;
                postedotherpay1.MODIFY;
            END;
            postedotherpay2.TRANSFERFIELDS(postedotherpay);
            postedotherpay2.Amount := -(postedotherpay.Amount);
            postedotherpay2.Reversed := TRUE;
            postedotherpay2.LineNo := ln;
            postedotherpay2.INSERT;
        END;
    end;

    //  [Scope('Internal')]
    procedure TOGETTRANSNO()
    begin

        CLEAR(ReversalEntry);
        IF GlEntry.Reversed THEN
            ReversalEntry.AlreadyReversedEntry(GlEntry.TABLECAPTION, GlEntry."Entry No.");
        IF GlEntry."Journal Batch Name" = '' THEN
            ReversalEntry.TestFieldError;

        //ReversalEntry.DirectReversefunc(TransNo);

        ProcessedSalary.INIT;
        ProcessedSalary.SETRANGE("Document No", Docno);
        ProcessedSalary.SETRANGE("Employee Code", employeeNo);

        ProcessedSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);

        ProcessedSalary2.INIT;
        ProcessedSalary2.COPYFILTERS(ProcessedSalary);
        IF ProcessedSalary2.FIND('+') THEN
            Lineno := ProcessedSalary2."Line No." + 10000
        ELSE
            Lineno := 10000;



        IF ProcessedSalary.FIND('-') THEN
            REPEAT
                ProcessedSalary1.TRANSFERFIELDS(ProcessedSalary);
                ProcessedSalary1."Earned Amount" := -(ProcessedSalary."Earned Amount");
                ProcessedSalary1."Co. Contributions" := -(ProcessedSalary."Co. Contributions");
                ProcessedSalary1."Co. Contribution2" := -(ProcessedSalary."Co. Contribution2");
                ProcessedSalary1.Salary := -(ProcessedSalary.Salary);
                ProcessedSalary1."Bonus/Exgratia" := -(ProcessedSalary."Bonus/Exgratia");
                ProcessedSalary1."Arrear Amount" := -(ProcessedSalary."Arrear Amount");
                ProcessedSalary1."PF Admin Charges" := -(ProcessedSalary."PF Admin Charges");
                ProcessedSalary1."EDLI Charges" := -(ProcessedSalary."EDLI Charges");
                ProcessedSalary1."RIFA Charges" := -(ProcessedSalary."RIFA Charges");
                ProcessedSalary1."Arrear Co. Contribution" := -(ProcessedSalary."Arrear Co. Contribution");
                ProcessedSalary1."Arrear Co. Contribution2" := -(ProcessedSalary."Arrear Co. Contribution2");
                ProcessedSalary1."Arrear Salary" := -(ProcessedSalary."Arrear Salary");
                ProcessedSalary1.Reversed := TRUE;
                ProcessedSalary1."Line No." := Lineno;
                ProcessedSalary1.INSERT;
                ProcessedSalary.Reversed := TRUE;
                ProcessedSalary.MODIFY;
                PostedOterpayrevers;
                Lineno += 10000;
            UNTIL ProcessedSalary.NEXT = 0;

        IF ProcessedSalary1.FIND('-') THEN
            REPEAT
                ProcessedSalary.TRANSFERFIELDS(ProcessedSalary1);
                ProcessedSalary.INSERT;
            UNTIL ProcessedSalary1.NEXT = 0;
        ProcessedSalary1.DELETEALL;

        MonthlyAttReverseTransa;
    end;

    //   [Scope('Internal')]
    procedure getdocno()
    begin
        IF Docno = '' THEN BEGIN
            /*  //RSPL-TC
             ledgDim.INIT;
             GlEntry.INIT;
             ledgDim.SETCURRENTKEY("Dimension Value Code");
             ledgDim.SETRANGE("Dimension Value Code",ProcessedSalary3."Employee Code");
             IF ledgDim.FIND('-') THEN
                REPEAT
                   Entryno:=ledgDim."Entry No.";
                   GlEntry.SETRANGE("Entry No.",Entryno);
                   GlEntry.SETRANGE(Reversed,FALSE);
                   IF GlEntry.FIND('-') THEN
                     IF GlEntry."Document No."=Docno THEN
                        BEGIN
                           TransNo:=GlEntry."Transaction No.";
                           TOGETTRANSNO;
                           flag:=TRUE;
                           ledgDim.FINDLAST;
                        END;
                UNTIL  ledgDim.NEXT=0;
          END ELSE
          BEGIN
             ledgDim.INIT;
             GlEntry.INIT;
             ledgDim.SETCURRENTKEY("Dimension Value Code");
             ledgDim.SETRANGE("Dimension Value Code",employeeNo);
             IF ledgDim.FIND('-') THEN
                REPEAT
                   Entryno:=ledgDim."Entry No.";
                   GlEntry.SETRANGE("Entry No.",Entryno);
                   GlEntry.SETRANGE(Reversed,FALSE);
                   IF GlEntry.FIND('-') THEN
                     IF GlEntry."Document No." = Docno THEN
                        BEGIN
                           TransNo := GlEntry."Transaction No.";
                           TOGETTRANSNO;
                           flag:=TRUE;
                           ledgDim.FINDLAST;
                        END;
                UNTIL  ledgDim.NEXT=0;
        */
        END;

    end;

    // [Scope('Internal')]

    procedure MonthlyAttReverseTransa()
    var
        MonthlyAtt: Record 60029;
        MonthlyAtt2: Record 60029;
    begin
        MonthlyAtt.INIT;
        MonthlyAtt.SETRANGE("Employee Code", employeeNo);
        MonthlyAtt.SETRANGE("Pay Slip Month", MONTH1);
        MonthlyAtt.SETRANGE(MonthlyAtt.Year, YEAR1);
        MonthlyAtt.SETRANGE(Reversed, FALSE);
        MonthlyAtt.SETRANGE(Posted, TRUE);


        MonthlyAtt2.INIT;
        MonthlyAtt2.COPYFILTERS(MonthlyAtt);
        IF MonthlyAtt2.FIND('+') THEN
            Lno := MonthlyAtt."Line No." + 10000
        ELSE
            Lno := 10000;


        MonthlyAtt1.INIT;
        IF MonthlyAtt.FIND('-') THEN
            REPEAT
                MonthlyAtt1.TRANSFERFIELDS(MonthlyAtt);
                MonthlyAtt1."Net Salary" := -(MonthlyAtt."Net Salary");
                MonthlyAtt1."Remaining Amount" := -(MonthlyAtt."Remaining Amount");
                MonthlyAtt1."Line No." := Lno;
                MonthlyAtt1.Reversed := TRUE;
                MonthlyAtt1."Reversal Entries" := TRUE;
                MonthlyAtt1.INSERT;
                MonthlyAtt.Reversed := TRUE;
                MonthlyAtt.Posted := FALSE;
                MonthlyAtt.MODIFY;
                Lno += 10000;
            UNTIL MonthlyAtt.NEXT = 0;

        IF MonthlyAtt1.FIND('-') THEN
            REPEAT
                MonthlyAtt.TRANSFERFIELDS(MonthlyAtt1);
                MonthlyAtt.INSERT;
            UNTIL MonthlyAtt1.NEXT = 0;
        MonthlyAtt1.DELETEALL;
    end;
}

