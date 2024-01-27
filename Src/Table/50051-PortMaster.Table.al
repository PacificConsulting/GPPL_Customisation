table 50051 "Port Master"
{
    Caption = 'Port Master';
    LookupPageID = 50124;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; "Port Description"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Port Description")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", "Port Description")
        {
        }
    }
}

