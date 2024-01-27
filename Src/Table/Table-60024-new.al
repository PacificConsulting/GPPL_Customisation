table 60024 new
{

    fields
    {
        field(1; "Code"; Code[30])
        {
        }
        field(2; Description; Text[80])
        {
        }
        field(10; "ISI Test Method"; Code[20])
        {
        }
        field(11; "ASTM Test Method"; Code[20])
        {
        }
        field(12; "IP Test Method"; Code[20])
        {
        }
        field(13; "Other Test Method"; Code[20])
        {
        }
        field(20; "Outsourced Tests"; Boolean)
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
    }
}

