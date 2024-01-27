table 56667 "Cust Dim"
{

    fields
    {
        field(1; Cust; Code[20])
        {
        }
        field(2; Dim; Code[20])
        {
        }
        field(3; Done; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Cust)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

