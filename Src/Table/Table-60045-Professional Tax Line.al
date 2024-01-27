table 60045 "Professional Tax Line"
{
    //DrillDownPageID = 70230;
    //LookupPageID = 70230;

    fields
    {
        field(1; "Branch Code"; Code[20])
        {
        }
        field(2; "Effective Date"; Date)
        {

            trigger OnValidate()
            begin
                IF "Effective Date" <> 0D THEN BEGIN
                    Month := DATE2DMY("Effective Date", 2);
                    Year := DATE2DMY("Effective Date", 3);
                END;
            end;
        }
        field(3; "Line No."; Integer)
        {
        }
        field(4; "Income From"; Decimal)
        {

            trigger OnValidate()
            begin
                PT.SETRANGE("Branch Code", "Branch Code");
                PT.SETRANGE("Effective Date", "Effective Date");
                IF PT.FIND('+') THEN BEGIN
                    IF "Income From" <= PT."Income To" THEN
                        ERROR(Text000, "Income From", PT."Income To");
                END;
            end;
        }
        field(5; "Income To"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "Income To" < "Income From" THEN
                    ERROR(Text001);
            end;
        }
        field(7; "Tax Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "Tax Amount" >= "Income From" THEN
                    ERROR(Text002);
            end;
        }
        field(9; Month; Integer)
        {
        }
        field(10; Year; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Branch Code", "Effective Date", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Branch Code", Year, Month, "Income From", "Income To")
        {
            SumIndexFields = "Tax Amount";
        }
    }

    fieldgroups
    {
    }

    var
        PT: Record 60045;
        Text000: Label '%1 Should be greater than %2';
        Text001: Label 'IncomeTo amount should be greater than IncomeFrom amount';
        Text002: Label 'Tax amount should be less than IncomeFrom amount';
}

