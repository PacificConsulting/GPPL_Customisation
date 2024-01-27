table 50039 "RG 23 D Copy Transfer Price"
{

    fields
    {
        field(1; "Item No"; Code[20])
        {
        }
        field(2; "Batch No"; Code[20])
        {
        }
        field(3; "Location Code"; Code[20])
        {
        }
        field(4; "Transfer Price"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Item No", "Batch No", "Location Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

