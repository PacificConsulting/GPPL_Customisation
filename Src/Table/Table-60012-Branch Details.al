table 60012 "Branch Details"
{

    fields
    {
        field(1; "Branch Code"; Code[20])
        {
        }
        field(2; "Branch Name"; Text[30])
        {
        }
        field(3; Address; Text[50])
        {
        }
        field(4; Address2; Text[50])
        {
        }
        field(5; "Post Code/City"; Code[20])
        {
        }
        field(6; "Phone No."; Integer)
        {
        }
        field(7; "Fax No."; Text[30])
        {
        }
        field(8; "Email Id"; Code[20])
        {
        }
        field(9; "PF No."; Text[30])
        {
        }
        field(10; "ESI No."; Text[30])
        {
        }
        field(11; "PAN No."; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Branch Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

