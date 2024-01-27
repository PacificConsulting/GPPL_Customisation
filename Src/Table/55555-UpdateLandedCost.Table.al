table 55555 "Update Landed Cost"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Location Code"; Code[20])
        {
        }
        field(3; "Landed Rate"; Decimal)
        {
        }
        field(10; Updated; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

