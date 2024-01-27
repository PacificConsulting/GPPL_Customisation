table 60046 "Emp TDS Deduction"
{
    // 14-Feb-06

    DrillDownPageID = 60044;
    LookupPageID = 60044;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = Employee_;

            trigger OnValidate()
            begin
                IF PayYear.FIND('-') THEN BEGIN
                    PayYear.SETRANGE("Year Type", 'FINANCIAL YEAR');
                    PayYear.SETRANGE(Closed, FALSE);
                    IF PayYear.FIND('-') THEN BEGIN
                        "Year Starting Date" := PayYear."Year Start Date";
                        "Year Ending Date" := PayYear."Year End Date";
                        Days := "Year Ending Date" - "Year Starting Date";
                        "Remaining Months" := Days DIV 30;
                    END;
                END;
            end;
        }
        field(2; "Year Starting Date"; Date)
        {
        }
        field(3; "Year Ending Date"; Date)
        {

            trigger OnValidate()
            begin
                Days := "Year Ending Date" - "Year Starting Date";
                "Remaining Months" := Days DIV 30;
            end;
        }
        field(4; "Gross Salary"; Decimal)
        {
        }
        field(5; "Professional Tax"; Decimal)
        {
            MinValue = 0;
        }
        field(6; "Gross Total Income"; Decimal)
        {
            MinValue = 0;
        }
        field(7; "Tax Liability"; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                IF "Tax Liability after savings" <> 0 THEN BEGIN
                    IF "Tax Liability after savings" > "Tax Liability" THEN
                        ERROR(Text000);
                END;
            end;
        }
        field(8; "Planned Savings"; Decimal)
        {
            MinValue = 0;
        }
        field(9; "Tax Liability after savings"; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                IF "Tax Liability" <> 0 THEN BEGIN
                    IF "Tax Liability after savings" > "Tax Liability" THEN
                        ERROR(Text000);
                END;

                IF ("Tax Liability after savings" <> 0) AND ("Remaining Months" <> 0) THEN
                    "Tax Per Month" := ("Tax Liability after savings" - "Tax Already Deducted") / "Remaining Months";
            end;
        }
        field(10; "Tax Already Deducted"; Decimal)
        {

            trigger OnValidate()
            begin
                IF ("Tax Liability after savings" <> 0) AND ("Remaining Months" <> 0) THEN
                    "Tax Per Month" := ("Tax Liability after savings" - "Tax Already Deducted") / "Remaining Months";
            end;
        }
        field(11; "Remaining Months"; Decimal)
        {

            trigger OnValidate()
            begin
                IF ("Tax Liability after savings" <> 0) AND ("Remaining Months" <> 0) THEN
                    "Tax Per Month" := ("Tax Liability after savings" - "Tax Already Deducted") / "Remaining Months";
            end;
        }
        field(12; "Tax Per Month"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
        field(13; "Reported Savings"; Decimal)
        {
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Year Starting Date", "Year Ending Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TDSSchedule.SETRANGE("Employee No.", "Employee No.");
        IF TDSSchedule.FIND('-') THEN
            TDSSchedule.DELETEALL;

        ExpSalaryComp.SETRANGE("Employee Code", "Employee No.");
        IF ExpSalaryComp.FIND('-') THEN
            ExpSalaryComp.DELETEALL;
    end;

    var
        TDSSchedule: Record 60047;
        ExpSalaryComp: Record 60014;
        Text000: Label 'Tax liability after savings should be less than Tax liability';
        PayYear: Record 60020;
        Days: Decimal;
}

