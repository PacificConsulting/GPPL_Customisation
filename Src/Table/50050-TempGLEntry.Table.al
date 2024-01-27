table 50050 "Temp GL Entry"
{

    fields
    {
        field(1; "Entry no."; Integer)
        {
        }
        field(2; "Transaction No."; Integer)
        {
        }
        field(3; "New Transaction No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Entry no.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

