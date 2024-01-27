
tableextension 50057 DimensionValueExtCstm extends 349
{
    fields
    {
        field(50000; "Short Close Days"; Integer)
        {
            Description = 'RSPLSUM 15May2020';
        }
        field(50001; "Mintifi Email"; Text[100])
        {
            Description = 'RSPLSUM27527';
        }
        field(50002; "Email PDF of SO"; Boolean)
        {
            Description = 'RSPLSUM 20Jan21';
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}