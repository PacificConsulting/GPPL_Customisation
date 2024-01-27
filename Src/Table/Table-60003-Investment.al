table 60003 Investment
{
    DrillDownPageID = 60085;
    LookupPageID = 60085;

    fields
    {
        field(1; "Investment Plan"; Code[50])
        {
        }
        field(2; Description; Text[60])
        {
        }
        field(3; Section; Option)
        {
            OptionCaption = '80C,80D,80E';
            OptionMembers = "80C","80D","80E";
        }
    }

    keys
    {
        key(Key1; "Investment Plan")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

