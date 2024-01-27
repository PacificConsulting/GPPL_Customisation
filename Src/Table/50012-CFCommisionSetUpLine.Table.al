table 50012 "C&F Commision SetUp Line"
{

    fields
    {
        field(1; "Commision Code"; Code[10])
        {
        }
        field(2; "Sales Volume From"; Decimal)
        {
        }
        field(3; "Sales Volume To"; Decimal)
        {
        }
        field(4; "Re - Imbursement"; Decimal)
        {
        }
        field(5; "Other Expenses"; Decimal)
        {
        }
        field(6; "Handling Charges"; Decimal)
        {
        }
        field(7; Calculate; Boolean)
        {
        }
        field(8; "Line No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Commision Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

