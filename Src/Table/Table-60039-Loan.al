table 60039 Loan
{
    // B2B Software Technologies
    // --------------------------------
    // Project : Human Resource
    // B2B
    // No. sign      Date
    // --------------------------------
    // 01   B2B    14-dec-05

    DrillDownPageID = 60033;
    LookupPageID = 60033;

    fields
    {
        field(1; Id; Code[20])
        {
        }
        field(2; "Employee Code"; Code[20])
        {
            TableRelation = Employee_;
        }
        field(3; "Loan Type"; Code[50])
        {

            trigger OnLookup()
            begin
                Lookup3.DELETEALL;

                Employee.SETRANGE("No.", "Employee Code");
                IF Employee.FIND('-') THEN BEGIN
                    Lookup2.RESET;
                    Lookup2.SETRANGE("LookupType Name", 'LOAN TYPES');
                    IF Lookup2.FIND('-') THEN BEGIN
                        REPEAT
                            IF (Lookup2.Grade = Employee."Pay Cadre") OR (Lookup2."All Grades" = TRUE) THEN BEGIN
                                Lookup3.INIT;
                                Lookup3.TRANSFERFIELDS(Lookup2);
                                Lookup3.INSERT;
                            END;
                        UNTIL Lookup2.NEXT = 0;
                    END;
                END;

                IF Lookup3.FIND('-') THEN BEGIN
                    IF PAGE.RUNMODAL(0, Lookup3) = ACTION::LookupOK THEN
                        "Loan Type" := Lookup3."Lookup Name";
                END ELSE
                    ERROR(Text000);
            end;

            trigger OnValidate()
            begin
                Lookup3.DELETEALL;

                Lookup.RESET;
                Lookup.SETRANGE("LookupType Name", 'LOAN TYPES');
                Lookup.SETRANGE("Lookup Name", "Loan Type");
                IF Lookup.FIND('-') THEN
                    "Loan Priority No" := Lookup."Loan Priority No.";
            end;
        }
        field(4; "Loan Amount"; Decimal)
        {
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            var
                GrossAmount: Decimal;
            begin
                PayElements.RESET;
                IF PayElements.FIND('-') THEN
                    REPEAT
                        PayElements.Processed := FALSE;
                        PayElements.MODIFY;
                    UNTIL PayElements.NEXT = 0;

                Employee.RESET;
                Employee.SETRANGE("No.", "Employee Code");
                IF Employee.FIND('-') THEN BEGIN
                    Lookup.RESET;
                    Lookup.SETRANGE("LookupType Name", 'LOAN TYPES');
                    Lookup.SETRANGE("Lookup Name", "Loan Type");
                    IF Lookup.FIND('-') THEN BEGIN
                        IF Lookup."Max.Amt.Type" = Lookup."Max.Amt.Type"::Amount THEN BEGIN
                            IF "Loan Amount" > Lookup."Max.Amt" THEN
                                ERROR(Text001, Lookup."Max.Amt");
                        END ELSE
                            IF Lookup."Max.Amt.Type" = Lookup."Max.Amt.Type"::"Gross Salary" THEN BEGIN
                                GrossAmount := CalcGrossAmount(Employee) * Lookup."Max.Amt";
                                IF "Loan Amount" > GrossAmount THEN
                                    ERROR(Text001, GrossAmount);
                            END;
                    END;
                END;

                "Loan Balance" := "Loan Amount";
            end;
        }
        field(5; "Loan Balance"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(6; "Interest Method"; Option)
        {
            OptionMembers = "Interest Free","Flat Rate","Dimnishing Rate";
        }
        field(7; "Loan Start Date"; Date)
        {

            trigger OnValidate()
            var
                Months: DateFormula;
                MonthinText: Text[30];
                EndDate: Date;
            begin
                //EBT Paramita
                IF "Loan Start Date" <> 0D THEN BEGIN
                    PayRollYear.RESET;
                    PayRollYear.SETRANGE("Year Type", 'LEAVE YEAR');
                    PayRollYear.SETFILTER("Year Start Date", '<=%1', "Loan Start Date");
                    PayRollYear.SETRANGE(PayRollYear.Closed, TRUE);
                    IF NOT PayRollYear.FINDFIRST THEN
                        ERROR('You can not create any loan in this date because this Payroll Year does not exist');
                END;
                IF "Loan Start Date" <> 0D THEN BEGIN
                    PayRollYear.RESET;
                    PayRollYear.SETRANGE("Year Type", 'LEAVE YEAR');
                    PayRollYear.SETFILTER("Year Start Date", '<=%1', "Loan Start Date");
                    PayRollYear.SETRANGE(PayRollYear.Closed, FALSE);
                    IF NOT PayRollYear.FINDFIRST THEN
                        ERROR('You can not create any loan in this date because this Payroll Year has been closed');
                END;

                //EBT Paramita
                MonthinText := FORMAT("No of Installments");
                EVALUATE(Months, MonthinText + 'M');
                IF "Loan Start Date" <> 0D THEN BEGIN
                    IF "No of Installments" = 0 THEN
                        "Loan End Date" := "Loan Start Date"
                    ELSE BEGIN
                        EndDate := CALCDATE(Months, "Loan Start Date");
                        "Loan End Date" := CALCDATE('-1M', EndDate);
                    END;
                END;
            end;
        }
        field(8; "No Deduction Request"; Boolean)
        {
        }
        field(9; "Carry Over"; Boolean)
        {
        }
        field(10; "Partial Deduction"; Boolean)
        {
        }
        field(11; "Is it in Carry"; Boolean)
        {
        }
        field(12; "Loan Priority No"; Integer)
        {
        }
        field(13; "Loan From"; Text[50])
        {
        }
        field(14; "Loan Ref No."; Code[50])
        {
        }
        field(15; "Loan Ref Date"; Date)
        {
        }
        field(16; "Effective Amount"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(17; "Actual Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Loan Details"."EMI Amount" WHERE("Employee No." = FIELD("Employee Code"),
                                                                 "Loan Code" = FIELD("Loan Type"),
                                                                 Month = FIELD(Month),
                                                                 Year = FIELD(Year)));

        }
        field(19; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(20; "Installment Amount"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(22; Type; Option)
        {
            OptionMembers = " ",Loan;
        }
        field(23; "Interest Rate"; Decimal)
        {
        }
        field(24; "No of Installments"; Integer)
        {

            trigger OnValidate()
            var
                Months: DateFormula;
                MoninText: Text[30];
                EndDate: Date;
            begin
                Employee.RESET;
                Employee.SETRANGE("No.", "Employee Code");
                IF Employee.FIND('-') THEN BEGIN
                    Lookup.RESET;
                    Lookup.SETRANGE("LookupType Name", 'LOAN TYPES');
                    Lookup.SETRANGE(Grade, Employee."Pay Cadre");
                    Lookup.SETRANGE("Lookup Name", "Loan Type");
                    IF Lookup.FIND('-') THEN BEGIN
                        IF "No of Installments" > Lookup."Max.No. of instalments" THEN
                            ERROR(Text002, Lookup."Max.No. of instalments");
                    END;
                END;


                MoninText := FORMAT("No of Installments");
                EVALUATE(Months, MoninText + 'M');
                IF "Loan Start Date" <> 0D THEN BEGIN
                    EndDate := CALCDATE(Months, "Loan Start Date");
                    "Loan End Date" := CALCDATE('-1M', EndDate);
                END;
            end;
        }
        field(25; "Loan End Date"; Date)
        {
        }
        field(26; Closed; Boolean)
        {
        }
        field(27; "Total Loan Payable"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(28; "Total Interest Amount"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(29; Month; Integer)
        {
        }
        field(30; Year; Integer)
        {
        }
        field(31; Priority; Integer)
        {
        }
        field(32; "Loan Posting Group"; Code[20])
        {
            TableRelation = "Loan Posting Groups";
        }
    }

    keys
    {
        key(Key1; Id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF Id = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup.Loan);
            //NoSeriesMgt.InitSeries(HRSetup.Loan, xRec."No. Series", 0D, Id, "No. Series");
        END;

        Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
        Lookup.SETRANGE("Lookup Name", 'Loan');
        IF Lookup.FIND('-') THEN
            Priority := Lookup.Priority;
    end;

    var
        HRSetup: Record 60016;
        Lookup: Record 60018;
        Lookup2: Record 60018;
        Lookup3: Record 60018 temporary;
        Employee: Record 60019;
        PayElements: Record 60025;
        //NoSeriesMgt: Codeunit 396;
        Text000: Label 'There are no  loan types for this Pay Cadre.';
        Text001: Label 'Loan amount should not be greater than %1';
        Text002: Label 'Loan installments should not be greater than %1';
        PayRollYear: Record 60020;

    //[Scope('Internal')]
    procedure AssistEdit(OldLoan: Record 60039): Boolean
    var
        Loan: Record 60039;
    begin
        WITH Loan DO BEGIN
            Loan := Rec;
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup.Loan);
            /*
            IF NoSeriesMgt.SelectSeries(HRSetup.Loan, OldLoan."No. Series", "No. Series") THEN BEGIN
                HRSetup.GET;
                HRSetup.TESTFIELD(Loan);
                NoSeriesMgt.SetSeries(Id);
                Rec := Loan;
                EXIT(TRUE);
            END;
            */
        END;
    end;

    //  [Scope('Internal')]
    procedure CalcGrossAmount(Employee: Record 60019): Decimal
    var
        PayElements: Record 60025;
        PayElements2: Record 60025;
        Total: Decimal;
        TotalAmt: Decimal;
        Basic: Decimal;
        DA: Decimal;
    begin
        TotalAmt := 0;
        Total := 0;
        PayElements.SETRANGE("Employee Code", Employee."No.");
        PayElements.SETRANGE("Add/Deduct", PayElements."Add/Deduct"::Addition);
        PayElements.SETRANGE(Processed, FALSE);
        IF PayElements.FIND('-') THEN BEGIN
            REPEAT
                PayElements2.SETRANGE("Employee Code", PayElements."Employee Code");
                PayElements2.SETRANGE("Pay Element Code", PayElements."Pay Element Code");
                IF PayElements2.FIND('-') THEN BEGIN
                    REPEAT
                        PayElements2.Processed := TRUE;
                        PayElements2.MODIFY;
                        IF PayElements2."Effective Start Date" <= TODAY THEN BEGIN
                            IF (PayElements2."Fixed/Percent" = PayElements2."Fixed/Percent"::Fixed) THEN BEGIN
                                Total := PayElements2."Amount / Percent";
                                IF PayElements2."Pay Element Code" = 'BASIC' THEN
                                    Basic := Total
                                ELSE
                                    IF PayElements2."Pay Element Code" = 'DA' THEN
                                        DA := Total;
                            END ELSE
                                IF (PayElements2."Fixed/Percent" = PayElements2."Fixed/Percent"::Percent) AND
                                   (PayElements2."Computation Type" = 'AFTER BASIC')
                       THEN
                                    Total := (PayElements2."Amount / Percent" * Basic) / 100
                                ELSE
                                    IF (PayElements2."Fixed/Percent" = PayElements2."Fixed/Percent"::Percent) AND
                                       (PayElements2."Computation Type" = 'AFTER BASIC AND DA')
                               THEN
                                        Total := (PayElements2."Amount / Percent" * (Basic + DA)) / 100;
                        END;
                    UNTIL PayElements2.NEXT = 0;
                    TotalAmt := TotalAmt + Total;
                END;
            UNTIL PayElements.NEXT = 0;
            EXIT(TotalAmt);
        END;
    end;
}

