table 50048 "Specification Master"
{
    Caption = 'Specification Master';
    DataCaptionFields = "Code", Specification;
    DrillDownPageID = 50130;
    LookupPageID = 50130;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Specification; Text[100])
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
        fieldgroup(DropDown; "Code", Specification)
        {
        }
    }
}

