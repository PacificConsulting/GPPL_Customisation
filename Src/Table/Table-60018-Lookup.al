table 60018 Lookup
{
    // B2B Software Technologies
    // ------------------------------
    // Project : Human Resource
    // B2B
    // No. sign      Date
    // ------------------------------
    // 01   B2B    13-dec-05
    // ---------------------------------------------------------------------------------------------------------------------------
    // Description: We will get different kinds of Lookupids, LookTypes.
    // ---------------------------------------------------------------------------------------------------------------------------

    Caption = 'Lookup';
    DrillDownPageID = 60003;
    LookupPageID = 60003;

    fields
    {
        field(1; "Lookup Id"; Integer)
        {
            Caption = 'Lookup ID';
        }
        field(2; "Lookup Name"; Code[30])
        {
            Caption = 'Lookup Name';

            trigger OnValidate()
            begin
                IF "System Defined" THEN
                    ERROR(Text000);
            end;
        }
        field(3; "Lookup Type"; Integer)
        {
            Caption = 'Lookup Type';
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(6; "LookupType Name"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Lookup Type".Name WHERE("No." = FIELD("Lookup Type")));
            Caption = 'LookupType Name';
            Editable = false;

        }
        field(12; Remarks; Text[250])
        {
        }
        field(13; "Add/Deduct"; Option)
        {
            OptionMembers = " ",Addition,Deduction;

            trigger OnValidate()
            begin
                IF "System Defined" THEN
                    ERROR(Text000);
            end;
        }
        field(15; "Applicable for OT"; Boolean)
        {

            trigger OnValidate()
            begin
                PayElement.RESET;
                PayElement.SETRANGE("Pay Element Code", "Lookup Name");
                IF PayElement.FIND('-') THEN
                    REPEAT
                        PayElement."Applicable for OT" := "Applicable for OT";
                        PayElement.MODIFY;
                    UNTIL PayElement.NEXT = 0;

                PayCadrePayElement.RESET;
                PayCadrePayElement.SETRANGE("Pay Element Code", "Lookup Name");
                IF PayCadrePayElement.FIND('-') THEN
                    REPEAT
                        PayCadrePayElement."Applicable for OT" := "Applicable for OT";
                        PayCadrePayElement.MODIFY;
                    UNTIL PayCadrePayElement.NEXT = 0;
            end;
        }
        field(16; ESI; Option)
        {
            OptionMembers = " ","Regular Element","Irregular Element";

            trigger OnValidate()
            begin
                PayElement.RESET;
                PayElement.SETRANGE("Pay Element Code", "Lookup Name");
                IF PayElement.FIND('-') THEN
                    REPEAT
                        PayElement.ESI := ESI;
                        PayElement.MODIFY;
                    UNTIL PayElement.NEXT = 0;

                PayCadrePayElement.RESET;
                PayCadrePayElement.SETRANGE("Pay Element Code", "Lookup Name");
                IF PayCadrePayElement.FIND('-') THEN
                    REPEAT
                        PayCadrePayElement.ESI := ESI;
                        PayCadrePayElement.MODIFY;
                    UNTIL PayCadrePayElement.NEXT = 0;
            end;
        }
        field(17; PF; Boolean)
        {

            trigger OnValidate()
            begin
                PayElement.RESET;
                PayElement.SETRANGE("Pay Element Code", "Lookup Name");
                IF PayElement.FIND('-') THEN
                    REPEAT
                        PayElement.PF := PF;
                        PayElement.MODIFY;
                    UNTIL PayElement.NEXT = 0;

                PayCadrePayElement.RESET;
                PayCadrePayElement.SETRANGE("Pay Element Code", "Lookup Name");
                IF PayCadrePayElement.FIND('-') THEN
                    REPEAT
                        PayCadrePayElement.PF := PF;
                        PayCadrePayElement.MODIFY;
                    UNTIL PayCadrePayElement.NEXT = 0;
            end;
        }
        field(18; "Leave Encashment"; Boolean)
        {

            trigger OnValidate()
            begin
                PayElement.RESET;
                PayElement.SETRANGE("Pay Element Code", "Lookup Name");
                IF PayElement.FIND('-') THEN
                    REPEAT
                        PayElement."Leave Encashment" := "Leave Encashment";
                        PayElement.MODIFY;
                    UNTIL PayElement.NEXT = 0;

                PayCadrePayElement.RESET;
                PayCadrePayElement.SETRANGE("Pay Element Code", "Lookup Name");
                IF PayCadrePayElement.FIND('-') THEN
                    REPEAT
                        PayCadrePayElement."Leave Encashment" := "Leave Encashment";
                        PayCadrePayElement.MODIFY;
                    UNTIL PayCadrePayElement.NEXT = 0;
            end;
        }
        field(19; Type; Option)
        {
            OptionMembers = Loan;
        }
        field(20; "Loan Interest Type"; Option)
        {
            OptionMembers = "Interest Free","Yearly Reducing";
        }
        field(21; "Interest Percent"; Decimal)
        {
        }
        field(22; Priority; Integer)
        {

            trigger OnValidate()
            begin
                IF Loan.FIND('-') THEN BEGIN
                    REPEAT
                        Loan.Priority := Priority;
                        Loan.MODIFY;
                    UNTIL Loan.NEXT = 0;
                END;
            end;
        }
        field(30; "Payroll Prod. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(31; "System Defined"; Boolean)
        {
        }
        field(32; "Period Start Date"; Date)
        {

            trigger OnValidate()
            var
                HRSetup: Record "60016";
                CheckDate: Date;
            begin
                IF HRSetup.FIND('-') THEN BEGIN
                    IF "Period Start Date" <> 0D THEN BEGIN
                        CheckDate := DMY2DATE(1, HRSetup."Salary Processing month", HRSetup."Salary Processing Year");
                        "Period End Date" := (CALCDATE('1M', "Period Start Date") - 1);
                        IF (DATE2DMY("Period End Date", 2) <> HRSetup."Salary Processing month") OR
                           (DATE2DMY("Period End Date", 3) <> HRSetup."Salary Processing Year")
                        THEN
                            ERROR(Text001, "Period End Date", HRSetup."Salary Processing month", HRSetup."Salary Processing Year")
                        ELSE BEGIN
                        END;
                    END ELSE
                        "Period End Date" := 0D;
                END;
            end;
        }
        field(33; "Period End Date"; Date)
        {
        }
        field(34; "Min Salary"; Decimal)
        {
        }
        field(35; "Loan Priority No."; Integer)
        {

            trigger OnValidate()
            begin
                Loan.RESET;
                Loan.SETRANGE("Loan Type", "Lookup Name");
                IF Loan.FIND('-') THEN BEGIN
                    REPEAT
                        Loan."Loan Priority No" := "Loan Priority No.";
                        Loan.MODIFY;
                    UNTIL Loan.NEXT = 0;
                END;
            end;
        }
        field(36; Probation; Boolean)
        {
        }
        field(37; "Bonus/Exgratia"; Option)
        {
            OptionMembers = " ",Bonus,"Ex-gratia",Both;

            trigger OnValidate()
            begin
                PayElement.RESET;
                PayElement.SETRANGE("Pay Element Code", "Lookup Name");
                IF PayElement.FIND('-') THEN
                    REPEAT
                        PayElement."Bonus/Exgratia" := "Bonus/Exgratia";
                        PayElement.MODIFY;
                    UNTIL PayElement.NEXT = 0;

                PayCadrePayElement.RESET;
                PayCadrePayElement.SETRANGE("Pay Element Code", "Lookup Name");
                IF PayCadrePayElement.FIND('-') THEN
                    REPEAT
                        PayCadrePayElement."Bonus/Exgratia" := "Bonus/Exgratia";
                        PayCadrePayElement.MODIFY;
                    UNTIL PayCadrePayElement.NEXT = 0;
            end;
        }
        field(38; "Incentive Applicable"; Option)
        {
            OptionMembers = " ",Bonus,"Ex-gratia";
        }
        field(39; "Per Meal Rate"; Decimal)
        {
        }
        field(40; Grade; Code[30])
        {
            Caption = 'Pay Cadre';
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
        }
        field(41; "Max.Amt"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "Max.Amt.Type" = "Max.Amt.Type"::" " THEN
                    ERROR(Text002);
            end;
        }
        field(42; "Max.No. of instalments"; Integer)
        {
        }
        field(44; Gratuity; Boolean)
        {

            trigger OnValidate()
            begin
                PayElement.RESET;
                PayElement.SETRANGE("Pay Element Code", "Lookup Name");
                IF PayElement.FIND('-') THEN
                    REPEAT
                        PayElement.Gratuity := Gratuity;
                        PayElement.MODIFY;
                    UNTIL PayElement.NEXT = 0;

                PayCadrePayElement.RESET;
                PayCadrePayElement.SETRANGE("Pay Element Code", "Lookup Name");
                IF PayCadrePayElement.FIND('-') THEN
                    REPEAT
                        PayCadrePayElement.Gratuity := Gratuity;
                        PayCadrePayElement.MODIFY;
                    UNTIL PayCadrePayElement.NEXT = 0;
            end;
        }
        field(45; "Holiday Compensation"; Boolean)
        {
        }
        field(46; PT; Boolean)
        {

            trigger OnValidate()
            begin
                PayElement.RESET;
                PayElement.SETRANGE("Pay Element Code", "Lookup Name");
                IF PayElement.FIND('-') THEN
                    REPEAT
                        PayElement.PT := PT;
                        PayElement.MODIFY;
                    UNTIL PayElement.NEXT = 0;

                PayCadrePayElement.RESET;
                PayCadrePayElement.SETRANGE("Pay Element Code", "Lookup Name");
                IF PayCadrePayElement.FIND('-') THEN
                    REPEAT
                        PayCadrePayElement.PT := PT;
                        PayCadrePayElement.MODIFY;
                    UNTIL PayCadrePayElement.NEXT = 0;
            end;
        }
        field(47; Recruitment; Boolean)
        {
        }
        field(49; "Bonus Adjust"; Boolean)
        {
        }
        field(50; "All Grades"; Boolean)
        {
            Caption = 'All Pay Cadre';
        }
        field(51; "Max.Amt.Type"; Option)
        {
            OptionMembers = " ",Amount,"Gross Salary";
        }
        field(100; "Print in Pay Register"; Boolean)
        {
        }
        field(101; "Order in Pay Register"; Integer)
        {
        }
        field(102; DA; Integer)
        {
        }
        field(103; Lodging; Integer)
        {
        }
        field(104; "Lodging Maj.Town"; Integer)
        {
        }
        field(105; Bike; Decimal)
        {
        }
        field(106; Car; Decimal)
        {
        }
        field(107; Date; Date)
        {
            Description = 'VE-003';
        }
        field(108; "DA Normal"; Decimal)
        {
            Description = 'VE-003';
        }
        field(109; "DA NightOut"; Decimal)
        {
            Description = 'VE-003';
        }
        field(110; "DA StateOffice"; Decimal)
        {
            Description = 'VE-003';
        }
        field(111; "DM's DA Normal"; Decimal)
        {
        }
        field(112; "DM's DA NightOut"; Decimal)
        {
        }
        field(113; "DM's DA StateOffice"; Decimal)
        {
        }
        field(114; "DM's Car"; Decimal)
        {
        }
        field(115; "DM's Bike"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Lookup Id", "Lookup Name")
        {
            Clustered = true;
        }
        key(Key2; "Lookup Name")
        {
        }
        key(Key3; "Lookup Type")
        {
        }
        key(Key4; "Lookup Name", "Lookup Type")
        {
        }
        key(Key5; "Order in Pay Register")
        {
        }
        key(Key6; "Add/Deduct")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF "System Defined" THEN
            ERROR(Text000);
    end;

    trigger OnInsert()
    begin
        IF Lookup.FIND('+') THEN
            "Lookup Id" := Lookup."Lookup Id" + 1
        ELSE
            "Lookup Id" := 1;
    end;

    trigger OnRename()
    begin
        IF "System Defined" THEN
            ERROR(Text000);
    end;

    var
        PayElement: Record 60025;
        PayCadrePayElement: Record 60026;
        Loan: Record 60039;
        Lookup: Record 60018;
        Text000: Label 'You cannot modify/delete the system defined record';
        Text001: Label 'Month and Year in the ending date %1, should be equal to salary processing month %2 and year %3 ';
        Text002: Label 'Select Maximum Amount Type.';
}

