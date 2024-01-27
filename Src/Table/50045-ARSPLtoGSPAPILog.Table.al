table 50045 A_RSPLtoGSPAPILog
{
    DataPerCompany = false;

    fields
    {
        field(1; id; Integer)
        {
            AutoIncrement = true;
        }
        field(2; GSTNo; Text[50])
        {
        }
        field(3; CustId; Text[50])
        {
        }
        field(4; Method; Text[100])
        {
        }
        field(5; EWBNo; Text[50])
        {
        }
        field(6; EWBDate; Text[50])
        {
        }
        field(7; EwbValidUptoDate; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

