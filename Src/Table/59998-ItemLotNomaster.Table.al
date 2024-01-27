table 59998 "Item Lot No master"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
        }
        field(6; MRP; Decimal)
        {
        }
        field(7; "Transfer Price"; Decimal)
        {
        }
        field(8; "Sales Price"; Decimal)
        {
        }
        field(9; "Ass Value"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

