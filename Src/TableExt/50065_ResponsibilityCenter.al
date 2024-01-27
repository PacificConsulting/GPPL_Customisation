tableextension 50065 ResponsibilityCenterExtCstm extends "Responsibility Center"
{
    fields
    {
        field(50000; "City for Sales"; Code[10])
        {
            Description = 'EBT/APV/0001';
            TableRelation = "Form Update sales Invoice";
        }
        field(50001; State; Code[10])
        {
            Description = 'EBT/APV/0001';
            TableRelation = State;

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