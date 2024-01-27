table 55558 "UpDate Transport Det"
{

    fields
    {
        field(1; "InvNo."; Code[20])
        {
        }
        field(2; applDocNo; Code[20])
        {
        }
        field(3; AppDate; Date)
        {
        }
        field(10; Done; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "InvNo.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

