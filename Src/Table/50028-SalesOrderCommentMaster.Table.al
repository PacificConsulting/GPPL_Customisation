table 50028 "Sales Order Comment Master"
{
    DrillDownPageID = 50053;
    LookupPageID = 50053;

    fields
    {
        field(1; "Record ID"; Integer)
        {
        }
        field(2; Comment; Text[240])
        {
        }
    }

    keys
    {
        key(Key1; "Record ID", Comment)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

