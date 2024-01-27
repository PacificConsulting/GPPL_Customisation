table 50027 "User LoginCstm"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "User ID"; Code[50])
        {
        }
        field(3; "Login Date Time"; DateTime)
        {
        }
        field(4; "Logout Date Time"; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

