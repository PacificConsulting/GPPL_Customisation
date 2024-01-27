table 59992 "Ext Doc No"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Doc No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

