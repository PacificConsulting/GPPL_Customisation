table 50037 "PM Weight"
{

    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "Packing Material Weight in KG"; Decimal)
        {
        }
        field(4; uPDATE; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

