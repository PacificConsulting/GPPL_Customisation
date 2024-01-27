table 50040 "Item Update table"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Blocked; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

