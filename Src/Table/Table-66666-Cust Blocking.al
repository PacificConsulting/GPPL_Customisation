table 66666 "Cust Blocking"
{

    fields
    {
        field(1; "Cust No."; Code[20])
        {
        }
        field(2; Blocked; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Cust No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

