table 50004 "Vehicle Capacity"
{
    DrillDownPageID = 50049;
    LookupPageID = 50049;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; Value; Decimal)
        {
        }
        field(4; "Value in Ltr"; Decimal)
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

