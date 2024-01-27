table 50019 "Report Buffer Table1"
{

    fields
    {
        field(1; "Sr. No."; Integer)
        {
        }
        field(2; "Document No."; Code[50])
        {
        }
        field(3; "Net Amount"; Decimal)
        {
        }
        field(4; "Invoice No."; Code[50])
        {
        }
        field(5; Date; Date)
        {
        }
        field(6; "TDS Amount"; Decimal)
        {
        }
        field(7; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Sr. No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

