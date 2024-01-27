tableextension 50072 ItemChargeextCstm extends "Item Charge"
{
    fields
    {
        field(50000; "Sub Expense"; Boolean)
        {
            Description = 'RB-N 30Aug2018';
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