tableextension 50042 TranspotMetExtCutm extends 259
{
    fields
    {
        field(50000; "Trans Mode"; Option)
        {
            Caption = 'Trans Mode';
            Description = 'YSR_EWB';
            OptionCaption = 'Road,Rail,Air,Ship';
            OptionMembers = Road,Rail,Air,Ship;
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