page 60064 "Pay Salary"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = 60029;
    SourceTableView = WHERE(Posted = FILTER(true));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrentYear; CurrentYear)
                {
                    Caption = 'Year';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrentYearOnAfterValidate;
                    end;
                }
                field(CurrentMonth; CurrentMonth)
                {
                    ApplicationArea = all;
                    Caption = 'Month';
                    //ValuesAllowed = 1;2;3;4;5;6;7;8;9;10;11;12;

                    trigger OnValidate()
                    begin
                        CurrentMonthOnAfterValidate;
                    end;
                }
                field(CurrentCadre; CurrentCadre)
                {
                    Caption = 'Pay Cadre';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Lookup.SETRANGE("LookupType Name", 'PAY CADRE');
                        IF PAGE.RUNMODAL(0, Lookup) = ACTION::LookupOK THEN BEGIN
                            CurrentCadre := Lookup."Lookup Name";
                        END;
                        SelectPayCadre;
                    end;

                    trigger OnValidate()
                    begin
                        CurrentCadreOnAfterValidate;
                    end;
                }
                field(PaymentMethod; PaymentMethod)
                {
                    ApplicationArea = all;
                    Caption = 'Payment Method';
                }
                field(AccType; AccType)
                {
                    Caption = 'Account Type';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        AccNo := '';
                    end;
                }
                field(ShowAll; ShowAll)
                {
                    Caption = 'Show All';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        ShowAllOnAfterValidate;
                    end;
                }
                field(AccNo; AccNo)
                {
                    Caption = 'Account No.';
                    Lookup = true;
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF AccType = AccType::"G/L Account" THEN BEGIN
                            IF PAGE.RUNMODAL(0, GLAcc) = ACTION::LookupOK THEN
                                AccNo := GLAcc."No.";
                        END ELSE
                            /*IF AccType = AccType:: Customer THEN
                            BEGIN
                              IF FORM.RUNMODAL(0,Customer)=ACTION::LookupOK THEN
                                AccNo := Customer."No.";
                            END ELSE
                            IF AccType = AccType:: Vendor THEN
                            BEGIN
                                IF FORM.RUNMODAL(0,Vend)=ACTION::LookupOK THEN
                                   AccNo := Vend."No.";
                            END ELSE */
                            IF AccType = AccType::"Bank Account" THEN BEGIN
                                IF PAGE.RUNMODAL(0, BankAcc) = ACTION::LookupOK THEN
                                    AccNo := BankAcc."No.";
                                /*END ELSE
                                IF AccType = AccType:: "Fixed Asset" THEN
                                BEGIN
                                   IF FORM.RUNMODAL(0,FA)=ACTION::LookupOK THEN
                                       AccNo := FA."No.";
                                END ELSE
                                IF AccType = AccType:: "IC Partner" THEN
                                BEGIN
                                   IF FORM.RUNMODAL(0,ICP)=ACTION::LookupOK THEN
                                       AccNo := ICP.Code; */
                            END;

                    end;
                }
                field("Employee Code1"; Empcode)
                {
                    Enabled = "Employee Code1Enable";
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //EBT Paramita
                        IF PAGE.RUNMODAL(60005, Employee) = ACTION::LookupOK THEN
                            Empcode := Employee."No.";
                        Rec.RESET;
                        SelectYear;
                        SelectMonth;

                        rec.SETRANGE("Employee Code", Empcode);
                        CurrPage.UPDATE(FALSE);


                        //EBT paramita
                    end;

                    trigger OnValidate()
                    begin
                        EmpcodeOnAfterValidate;
                    end;
                }
                field(ChequeNo; ChequeNo)
                {
                    ApplicationArea = all;
                    Caption = 'Cheque No.';
                }
                field(ChequeDate; ChequeDate)
                {
                    ApplicationArea = all;
                    Caption = 'Cheque Date';
                }
                field("Chque Filter"; "Chque Filter")
                {
                    Caption = 'Cheque Filter';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        rec.SETRANGE("Cheque No.", "Chque Filter");
                    end;
                }
            }
            repeater(control1)
            {
                field("Employee Code"; rec."Employee Code")
                {
                    ApplicationArea = all;
                    Caption = 'Employee No';
                    Editable = false;
                }
                field("Employee Name"; rec."Employee Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Gross Salary"; rec."Gross Salary")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Cheque No."; rec."Cheque No.")
                {
                    ApplicationArea = all;
                }
                field(Deductions; rec.Deductions)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Net Salary"; rec."Net Salary")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Paid Amount"; rec."Paid Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pay Amount"; rec."Pay Amount")
                {
                    ApplicationArea = all;
                }
            }
            group(Postings)
            {
                Caption = 'Postings';
                field(TempBatch; TempBatch)
                {
                    Caption = 'Journal Batch Name';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        JournalTemplate.RESET;
                        JournalTemplate.SETRANGE(Name, 'PAYROLL');
                        IF JournalTemplate.FIND('-') THEN
                            JournalBatch.SETRANGE("Journal Template Name", JournalTemplate.Name);
                        IF PAGE.RUNMODAL(251, JournalBatch) = ACTION::LookupOK THEN BEGIN
                            TempBatch := JournalBatch.Name;
                            TempJournal := JournalBatch."Journal Template Name";
                            PostDate := WORKDATE;
                        END;

                        JournalBatch.SETRANGE(Name, TempBatch);
                        IF JournalBatch.FIND('-') THEN
                            NoSeries.SETRANGE(Code, JournalBatch."No. Series");
                        IF NoSeries.FIND('-') THEN
                            "DocNo." := NoSeriesMgt.TryGetNextNo(JournalBatch."No. Series", WORKDATE);
                        //"DocNo." :=  NoSeriesMgt.GetNextNo(NoSeries.Code,WORKDATE,TRUE);
                    end;
                }
                field(PostDate; PostDate)
                {
                    ApplicationArea = all;
                    Caption = 'PostDate';
                }
                field("DocNo."; "DocNo.")
                {
                    ApplicationArea = all;
                    Caption = 'Document No.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action("Processed &Salary")
                {
                    ApplicationArea = all;
                    Caption = 'Processed &Salary';
                    RunObject = Page 60031;
                    //RunPageLink= 
                    //RunPageLink = "Employee Code" = FIELD("Employee Code"), Year = FIELD(Year),"Pay Slip Month" = FIELD("Pay Slip Month");
                }
            }
        }
        area(processing)
        {
            action(Previous)
            {

                ApplicationArea = all;
                Caption = 'Previous';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Previous';

                trigger OnAction()
                begin
                    IF CurrentMonth = 1 THEN
                        rec.Year := CurrentYear - 1
                    ELSE
                        rec.Year := CurrentYear;

                    IF CurrentMonth = 1 THEN
                        Month := 12
                    ELSE
                        Month := CurrentMonth - 1;

                    Navigate.SETRANGE(Year, Year);
                    Navigate.SETRANGE("Pay Slip Month", Month);
                    IF Navigate.FIND('-') THEN BEGIN
                        CurrentYear := rec.Year;
                        CurrentMonth := Month;
                        SelectYear;
                        SelectMonth;
                    END ELSE
                        ERROR(Text002);
                end;
            }
            action(Next)
            {
                ApplicationArea = all;
                Caption = 'Next';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Next';

                trigger OnAction()
                begin
                    IF CurrentMonth = 12 THEN
                        rec.Year := CurrentYear + 1
                    ELSE
                        rec.Year := CurrentYear;

                    IF CurrentMonth = 12 THEN
                        Month := 1
                    ELSE
                        Month := CurrentMonth + 1;

                    Navigate.SETRANGE(Year, rec.Year);
                    Navigate.SETRANGE("Pay Slip Month", Month);
                    IF Navigate.FIND('-') THEN BEGIN
                        CurrentYear := rec.Year;
                        CurrentMonth := Month;
                        SelectYear;
                        SelectMonth;
                    END ELSE
                        ERROR(Text002);
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Update Amounts")
                {
                    Caption = 'Update Amounts';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        IF Empcode = '' THEN //Ve-026
                        BEGIN
                            MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
                            MonAttendance.SETRANGE(Year, CurrentYear);
                            MonAttendance.SETRANGE(Posted, TRUE);
                            IF MonAttendance.FIND('-') THEN
                                REPEAT
                                    MonAttendance.CALCFIELDS("Paid Amount");
                                    IF MonAttendance."Paid Amount" = 0 THEN BEGIN
                                        MonAttendance."Pay Amount" := MonAttendance."Net Salary";
                                        MonAttendance.MODIFY;
                                    END ELSE BEGIN
                                        MonAttendance."Pay Amount" := 0;
                                        MonAttendance.MODIFY;
                                    END;
                                UNTIL MonAttendance.NEXT = 0;
                        END ELSE
                        //Ve-026>>
                        BEGIN
                            MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
                            MonAttendance.SETRANGE(Year, CurrentYear);
                            MonAttendance.SETRANGE(Posted, TRUE);
                            MonAttendance.SETRANGE("Employee Code", Empcode);
                            IF MonAttendance.FIND('-') THEN
                                MonAttendance."Pay Amount" := MonAttendance."Net Salary";
                            MonAttendance.MODIFY;
                        END;
                        //Ve-026<<
                    end;
                }
                action("&Post Salary")
                {
                    Caption = '&Post Salary';
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        PostSalary: Record 60009;
                        TotalAmt: Decimal;
                        Amount: Decimal;
                        GenJournalLine: Record 81;
                        GenJnlPostLine: Codeunit 12;
                        DimMgt: Codeunit 408;
                        MonAttendance2: Record 60029;
                        RemainingAmt: Decimal;
                        PaidAmt: Decimal;
                        LineNo: Integer;
                        PayrollJnlBatch: Record 232;
                        GenJournalLine2: Record 81;
                        GenJnlLineNo: Integer;
                        MonattDim: Record 60055;
                    begin
                        CLEAR(GenJnlLineNo);
                        IF TempBatch = '' THEN
                            ERROR('Journal Batch Name should not be Empty...');
                        IF PostDate = 0D THEN
                            ERROR('Posting Date Should not be Empty...');
                        IF "DocNo." = '' THEN
                            ERROR('Document No. Should Not be Empty...');

                        HRSetup.GET;
                        GenJournalLine2.RESET;
                        GenJournalLine2.SETRANGE("Journal Template Name", HRSetup."Payroll Journal Template");
                        GenJournalLine2.SETRANGE("Journal Batch Name", TempBatch);
                        IF GenJournalLine2.FIND('+') THEN
                            GenJnlLineNo := GenJournalLine2."Line No." + 10000
                        ELSE
                            GenJnlLineNo := 10000;

                        MonAttendance.INIT;
                        MonAttendance.RESET;
                        IF CurrentCadre <> '' THEN
                            MonAttendance.SETRANGE(PayCadre, CurrentCadre);
                        MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
                        MonAttendance.SETRANGE(Year, CurrentYear);
                        MonAttendance.SETRANGE(Posted, TRUE);
                        MonAttendance.SETRANGE("Reversal Entries", FALSE);
                        CLEAR(PayAmt);
                        CLEAR(Flag);
                        //VE-026<<
                        IF Empcode <> '' THEN
                            MonAttendance.SETRANGE("Employee Code", Empcode);
                        MonAttendance.SETFILTER("Pay Amount", '<>%1', 0);
                        IF "Chque Filter" <> '' THEN
                            MonAttendance.SETRANGE("Cheque No.", "Chque Filter");

                        //VE-026>>

                        Win.OPEN('Processing....\' + Text009);
                        Win.UPDATE(2, MonAttendance.COUNT);
                        CLEAR(CurrCount);
                        IF MonAttendance.FIND('-') THEN
                            REPEAT
                                Amount := MonAttendance."Pay Amount";
                                IF Employee.GET(MonAttendance."Employee Code") THEN
                                    IF NOT Employee."Stop Payment" THEN BEGIN
                                        IF MonAttendance."Pay Amount" <> 0 THEN BEGIN
                                            //VE-003 >>
                                            CurrCount += 1;
                                            Win.UPDATE(1, CurrCount);
                                            MonAttendance."Pay Method" := PaymentMethod;
                                            //EBT Paramita
                                            IF AccType = AccType::"G/L Account" THEN
                                                MonAttendance."Account Type" := MonAttendance."Account Type"::"G/L Account"
                                            ELSE
                                                IF AccType = AccType::"Bank Account" THEN
                                                    MonAttendance."Account Type" := MonAttendance."Account Type"::"Bank Account";
                                            //EBT Paramita

                                            MonAttendance."Account No." := AccNo;
                                            //MonAttendance."Cheque No." := ChequeNo;
                                            MonAttendance."Cheque Date" := PostDate;
                                            MonAttendance.MODIFY;
                                            PayAmt := PayAmt + MonAttendance."Pay Amount";
                                            //VE-003 <<

                                            GenJnlLine.RESET;
                                            GenJnlLine."Journal Template Name" := HRSetup."Payroll Journal Template";
                                            GenJnlLine."Journal Batch Name" := TempBatch;
                                            GenJnlLine."Document No." := "DocNo.";
                                            GenJnlLine."Line No." := GenJnlLineNo;
                                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                                            Employee.SETRANGE("No.", MonAttendance."Employee Code");
                                            IF Employee.FIND('-') THEN BEGIN
                                                IF EmpPostingGroup.GET(Employee."Emp Posting Group") THEN
                                                    GenJnlLine."Account No." := EmpPostingGroup."Salary Payable Acc.";
                                            END;
                                            GenJnlLine.VALIDATE("Account No.");

                                            GenJnlLine."Posting Date" := PostDate;

                                            //ve-003 >>
                                            GenJnlLine.Description :=
                                            MonAttendance."Employee Code" + ' ' + 'Sal Paid for the Month of' + ' ' +
                                            ReturnMonth(CurrentMonth) + '/' +
                                            FORMAT(CurrentYear);
                                            //EBT Paramita
                                            IF MonAttendance."Account Type" = MonAttendance."Account Type"::"Bank Account" THEN
                                                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account"
                                            ELSE
                                                IF MonAttendance."Account Type" = MonAttendance."Account Type"::"G/L Account" THEN
                                                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                                            //EBT Paramita

                                            GenJnlLine."Bal. Account No." := MonAttendance."Account No.";
                                            GenJnlLine.VALIDATE("Bal. Account No.");
                                            //GenJnlLine.Description :=
                                            //MonAttendance."Employee Code"+' '+GenJnlLine.Description+' '+
                                            //ReturnMonth(CurrentMonth)+' '+
                                            //FORMAT(CurrentYear);
                                            //VE-003 <<

                                            GenJnlLine.VALIDATE(Amount, Amount);
                                            GenJnlLine."Source Code" := 'PAYMENTJNL';
                                            //GenJnlLine."Cheque No." := MonAttendance."Cheque No.";
                                            //GenJnlLine."Cheque Date" := PostDate;
                                            GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", Employee."Global Dimension 1 Code");
                                            GenJnlLine.INSERT(TRUE); //VE-003
                                                                     //GenJnlPostLine.RunWithCheck(GenJnlLine,TempJnlLineDim); //VE-003

                                            //VE-003 >>
                                            //JnlLineDim.INIT;
                                            //JnlLineDim.RESET;
                                            MonattDim.INIT;
                                            MonattDim.RESET;
                                            MonattDim.SETRANGE("Employee Code", MonAttendance."Employee Code");
                                            MonattDim.SETRANGE(Month, MonAttendance."Pay Slip Month");
                                            MonattDim.SETRANGE(Year, MonAttendance.Year);
                                            MonattDim.SETRANGE("Dimension Code", 'EMPLOYEE');
                                            IF MonattDim.FIND('-') THEN
                                                REPEAT
                                                /*JnlLineDim."Table ID" := 81;
                                                JnlLineDim."Journal Template Name" := HRSetup."Payroll Journal Template";
                                                JnlLineDim."Journal Batch Name" := TempBatch;
                                                JnlLineDim."Journal Line No." := GenJnlLineNo;
                                                JnlLineDim."Dimension Code" := MonattDim."Dimension Code";
                                                JnlLineDim."Dimension Value Code" := MonattDim."Dimension Value Code";
                                                JnlLineDim.INSERT; */
                                                UNTIL MonattDim.NEXT = 0;
                                            //VE-003 <<
                                        END;
                                        /* //RSPL-TC
                                        // ebt dime begins
                                             JnlLineDim.RESET;
                                             JnlLineDim.SETRANGE("Journal Template Name","Journal Template Name");
                                             JnlLineDim.SETRANGE("Journal Batch Name","Journal Batch Name");
                                             JnlLineDim.SETRANGE("Journal Line No.",GenJnlLine."Line No.");
                                             IF JnlLineDim.FIND('-') THEN
                                                REPEAT
                                                JnlLineDim1.INIT;
                                                JnlLineDim1.TRANSFERFIELDS(JnlLineDim);
                                                JnlLineDim1."Journal Template Name":=TempJournal;
                                                JnlLineDim1."Journal Batch Name":=TempBatch;
                                                JnlLineDim1."Journal Line No.":=GenJnlLine."Line No.";
                        
                                                JnlLineDim1.INSERT;
                                                UNTIL JnlLineDim.NEXT=0;
                                        // ebt dim ends
                                        */

                                        PostSalary.INIT;
                                        PostSalary."Employee Code" := MonAttendance."Employee Code";
                                        PostSalary.Month := MonAttendance."Pay Slip Month";
                                        PostSalary.Year := MonAttendance.Year;
                                        PostSalary."Posting Date" := PostDate;
                                        PostSalary."Document No" := "DocNo.";
                                        PostSalary."Net Salary" := MonAttendance."Net Salary";
                                        PostSalary."Salary Paid" := MonAttendance."Pay Amount";
                                        MonAttendance.CALCFIELDS("Gross Salary");
                                        PostSalary."Total Additions" := MonAttendance."Gross Salary";
                                        MonAttendance.CALCFIELDS(Deductions);
                                        PostSalary."Total Deductions" := MonAttendance.Deductions;
                                        PostSalary.INSERT;

                                        //VE-003 >>
                                        MonAttendance."Remaining Amount" := MonAttendance."Net Salary" - MonAttendance."Pay Amount";
                                        //VE-003 <<
                                        MonAttendance."Pay Amount" := 0;
                                        MonAttendance.MODIFY;
                                        GenJnlLineNo += 10000;
                                        Flag := TRUE;
                                    END;
                            UNTIL MonAttendance.NEXT = 0;
                        Win.CLOSE;
                        //VE-003 >>
                        IF Flag THEN
                            MESSAGE('Transferred to GenJnl Successfully....');


                        GenJnlLine.RESET;
                        GenJnlLine.SETRANGE("Journal Template Name", TempJournal);
                        GenJnlLine.SETRANGE("Journal Batch Name", TempBatch);
                        GenJnlLine.SETRANGE("Document No.", "DocNo.");

                        IF GenJnlLine.FIND('-') THEN
                            REPEAT
                                "GenJnl-Post".RUN(GenJnlLine);
                            UNTIL GenJnlLine.NEXT = 0;

                        //VE-003 <<

                        LastNoSeriseNo := NoSeriesMgt.GetNextNo(JournalBatch."No. Series", WORKDATE, FALSE); //Paramita

                    end;
                }
                action("&Update Balance Amount")
                {
                    ApplicationArea = all;
                    Caption = '&Update Balance Amount';
                    //ApplicationArea = all;
                    trigger OnAction()
                    begin
                        //VE-026>>
                        MonthlyAttendance1.RESET;
                        MonthlyAttendance1.SETRANGE("Pay Slip Month", CurrentMonth);
                        MonthlyAttendance1.SETRANGE(Year, CurrentYear);
                        MonthlyAttendance1.SETRANGE(Posted, TRUE);
                        IF MonthlyAttendance1.FIND('-') THEN
                            REPEAT
                                MonthlyAttendance1.CALCFIELDS("Paid Amount");
                                //MonthlyAttendance1."Balance To Pay" := MonthlyAttendance1."Net Salary" - MonthlyAttendance1."Paid Amount";
                                MonthlyAttendance1.MODIFY;
                            UNTIL MonthlyAttendance1.NEXT = 0;

                        //SETFILTER("Balance To Pay",'<>%1',0);
                    end;
                }
                separator("-------------------")
                {
                    Caption = '-------------------';
                }
                action("Update &Cheque Details")
                {
                    Caption = 'Update &Cheque Details';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        MonAtt: Record 60029;
                        CurrCount: Integer;
                    begin
                        MonAtt.RESET;
                        MonAtt.SETRANGE(Year, CurrentYear);
                        MonAtt.SETRANGE("Pay Slip Month", CurrentMonth);
                        MonAtt.SETRANGE(Posted, TRUE);
                        MonAtt.SETRANGE(Reversed, FALSE);
                        MonAtt.SETRANGE("Cheque No.", '');
                        Win.OPEN('Updating Cheque Details.....\' + Text009);
                        Win.UPDATE(2, MonAtt.COUNT);
                        CurrCount := 0;
                        IF MonAtt.FIND('-') THEN
                            REPEAT
                                CurrCount += 1;
                                Win.UPDATE(1, CurrCount);
                                MonAtt."Cheque No." := ChequeNo;
                                MonAtt."Cheque Date" := ChequeDate;
                                MonAtt.MODIFY;
                            UNTIL MonAtt.NEXT = 0;

                        Win.CLOSE;
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        "Employee Code1Enable" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        rec."Employee Code" := '';
        IF HRSetup.FIND('-') THEN BEGIN
            CurrentYear := HRSetup."Salary Processing Year";
            CurrentMonth := HRSetup."Salary Processing month";
        END;
        SelectYear;
        SelectMonth;
        SelectPayCadre;
    end;

    var
        Lookup: Record 60018;
        HRSetup: Record 60016;
        Employee: Record 60019;
        EmpPostingGroup: Record 60056;
        Navigate: Record 60029;
        Text001: Label 'Processing is Completed.';
        Text002: Label 'There are no records with in these filters.';
        ProcessedSalary: Record 60038;
        CurrentCadre: Code[30];
        CurrentMonth: Integer;
        CurrentYear: Integer;
        Text003: Label 'Attendance Processing is Completed.';
        Month: Integer;
        Year: Integer;
        StartingDate: Date;
        EndingDate: Date;
        ShowAll: Boolean;
        Window: Dialog;
        "---Postings---": Integer;
        GenJnlLine: Record 81;
        NoSeries: Record 308;
        JournalTemplate: Record 80;
        JournalBatch: Record 232;
        MonAttendance: Record 60029;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PayrollProcess: Codeunit 60018;
        TempJournal: Code[20];
        TempBatch: Code[20];
        Text004: Label 'Re Processing is Completed.';
        PostDate: Date;
        Text005: Label 'Salary Posted.';
        Text006: Label 'Posted records shouldn''t allowed to reprocess.';
        Text007: Label 'Employee No..... #1######################\ ';
        LastNoSeriseNo: Code[20];
        Answer: Boolean;
        Text008: Label 'Do you want to Post';
        "-------------": Integer;
        PaymentMethod: Option Cash,Cheque,"Bank Transfer";
        AccType: Option "G/L Account","Bank Account";
        AccNo: Code[20];
        Customer: Record Customer;//18;
        GLAcc: Record 15;
        BankAcc: Record 270;
        Vend: Record 23;
        FA: Record 5600;
        ICP: Record 413;
        PayAmt: Decimal;
        ChequeNo: Code[10];
        ChequeDate: Date;
        "GenJnl-Post": Codeunit 231;
        Flag: Boolean;
        "DocNo.": Code[20];
        Win: Dialog;
        Text009: Label 'Processing #1#### of #2#####';
        CurrCount: Integer;
        MonthlyAttendance1: Record 60029;
        Empcode: Code[30];
        "Chque Filter": Code[30];
        // [InDataSet]
        "Employee Code1Enable": Boolean;

    // [Scope('Internal')]
    procedure SelectYear()
    begin
        rec.SETRANGE(Year, CurrentYear);
        rec.SETRANGE(Posted, TRUE);
        rec.SETRANGE("Reversal Entries", FALSE);
        CurrPage.UPDATE(FALSE);
    end;

    //[Scope('Internal')]
    procedure SelectMonth()
    begin
        rec.SETRANGE("Pay Slip Month", CurrentMonth);
        rec.SETRANGE("Reversal Entries", FALSE);
        CurrPage.UPDATE(FALSE);
    end;

    // [Scope('Internal')]
    procedure SelectStartingDate()
    begin
    end;

    // [Scope('Internal')]
    procedure SelectEndingDate()
    begin
    end;

    // [Scope('Internal')]
    procedure SelectPayCadre()
    begin
        rec.SETRANGE(PayCadre, CurrentCadre);
        rec.SETRANGE("Reversal Entries", FALSE);
        CurrPage.UPDATE(FALSE);
    end;

    // [Scope('Internal')]
    procedure ReturnMonth(Month: Integer): Code[20]
    begin
        IF Month = 1 THEN
            EXIT('Jan')
        ELSE
            IF Month = 2 THEN
                EXIT('Febuary')
            ELSE
                IF Month = 3 THEN
                    EXIT('March')
                ELSE
                    IF Month = 4 THEN
                        EXIT('April')
                    ELSE
                        IF Month = 5 THEN
                            EXIT('May')
                        ELSE
                            IF Month = 6 THEN
                                EXIT('June')
                            ELSE
                                IF Month = 7 THEN
                                    EXIT('July')
                                ELSE
                                    IF Month = 8 THEN
                                        EXIT('August')
                                    ELSE
                                        IF Month = 9 THEN
                                            EXIT('Septmeber')
                                        ELSE
                                            IF Month = 10 THEN
                                                EXIT('October')
                                            ELSE
                                                IF Month = 11 THEN
                                                    EXIT('November')
                                                ELSE
                                                    IF Month = 12 THEN
                                                        EXIT('December');
    end;

    local procedure CurrentYearOnAfterValidate()
    begin
        SelectYear;
    end;

    local procedure CurrentMonthOnAfterValidate()
    begin
        SelectMonth;
    end;

    local procedure CurrentCadreOnAfterValidate()
    begin
        SelectPayCadre;
    end;

    local procedure ShowAllOnAfterValidate()
    begin
        IF ShowAll THEN BEGIN
            Empcode := '';
            "Employee Code1Enable" := FALSE;
            Rec.RESET;
            SelectYear;
            SelectMonth;

        END ELSE BEGIN
            SelectYear;
            SelectMonth;
            SelectPayCadre;
            "Employee Code1Enable" := TRUE;
        END;
    end;

    local procedure EmpcodeOnAfterValidate()
    begin
        //Ve-026<<
        Rec.RESET;
        SelectYear;
        SelectMonth;

        rec.SETRANGE("Employee Code", Empcode);
        CurrPage.UPDATE(FALSE);
        //Ve-026>>
    end;
}

