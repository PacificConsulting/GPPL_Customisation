table 54545 "Headq location update"
{

    fields
    {
        field(1; custno; Code[20])
        {
        }
        field(2; HQLoc; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; custno)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

