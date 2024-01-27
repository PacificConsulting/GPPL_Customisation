table 50038 "Headquarter Location"
{
    LookupPageID = 50065;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Name; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Code", Name)
        {
            Clustered = true;
        }
        key(Key2; Name)
        {
        }
    }

    fieldgroups
    {
    }
}

