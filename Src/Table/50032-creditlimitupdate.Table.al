table 50032 creditlimit_update
{

    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; Name; Text[60])
        {
        }
        field(3; "Credit Limit"; Decimal)
        {
        }
        field(4; Update; Boolean)
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

