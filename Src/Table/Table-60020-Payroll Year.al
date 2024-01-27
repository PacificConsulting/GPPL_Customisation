table 60020 "Payroll Year"
{
    // Date: 05-Jan-06

    LookupPageID = 60006;

    fields
    {
        field(2; "Year Type"; Code[50])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('PAYROLL YEARS'));
        }
        field(3; "Year Start Date"; Date)
        {
        }
        field(4; "Year End Date"; Date)
        {
        }
        field(5; Closed; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Year Type", "Year Start Date", "Year End Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

