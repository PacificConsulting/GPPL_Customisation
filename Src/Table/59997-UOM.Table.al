table 59997 UOM
{

    fields
    {
        field(1; "Old UOM"; Code[20])
        {
        }
        field(2; "New UOM"; Code[10])
        {
        }
        field(3; Qty; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Old UOM")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

