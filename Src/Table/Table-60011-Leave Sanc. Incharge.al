table 60011 "Leave Sanc. Incharge"
{
    DrillDownPageID = 60070;
    LookupPageID = 60070;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = Employee_;
        }
        field(2; "Sanctioning Incharge"; Code[20])
        {
            TableRelation = Employee_;
        }
        field(3; Hierarchy; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Sanctioning Incharge")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

