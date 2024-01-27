table 60027 "Temp Calendar"
{

    fields
    {
        field(1; Date; Date)
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Non-Working"; Boolean)
        {
        }
        field(4; Holiday; Integer)
        {
        }
        field(5; WeeklyOff; Integer)
        {
        }
        field(6; "Day No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

