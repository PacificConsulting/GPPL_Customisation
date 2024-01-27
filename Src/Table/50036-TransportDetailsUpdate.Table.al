table 50036 "TransportDetails Update"
{

    fields
    {
        field(1; "Invoice no"; Code[20])
        {
        }
        field(2; Updated; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Invoice no")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

