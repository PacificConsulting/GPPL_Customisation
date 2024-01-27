table 50101 "Delete Log"
{

    fields
    {
        field(1; "Table No."; Integer)
        {
            Editable = false;
        }
        field(2; "Entry No."; Integer)
        {
            Editable = false;
        }
        field(3; "Document No."; Code[20])
        {
            Editable = false;
        }
        field(4; "User ID"; Code[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Table No.", "Entry No.", "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

