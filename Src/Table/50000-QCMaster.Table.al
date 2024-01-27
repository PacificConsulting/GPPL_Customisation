table 50000 "QC Master"
{
    DrillDownPageID = 50000;
    LookupPageID = 50000;

    fields
    {
        field(1; "Inventory Posting Group"; Code[20])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(2; "Parameter Code"; Code[30])
        {
        }
        field(3; "Test Methods"; Text[30])
        {
        }
        field(4; "Specifications Minimum"; Text[30])
        {
        }
        field(5; "Specifications Maximum"; Text[30])
        {
        }
        field(6; Description; Text[50])
        {
        }
        field(7; "Typical Value"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Inventory Posting Group", "Parameter Code", "Test Methods")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

