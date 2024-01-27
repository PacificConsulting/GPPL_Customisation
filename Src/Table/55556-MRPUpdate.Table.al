table 55556 "MRP Update"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
        }
        field(2; Lot; Code[20])
        {
        }
        field(3; "Prod Disc"; Decimal)
        {
        }
        field(4; "Sales Price"; Decimal)
        {
        }
        field(5; "Stock Transfer Price"; Decimal)
        {
        }
        field(50000; Updated; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Item No.", Lot)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

