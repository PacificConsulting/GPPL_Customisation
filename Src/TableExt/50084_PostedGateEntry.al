tableextension 50084 PostedGateentryExtCstm extends "Posted Gate Entry Line"
{
    fields
    {
        field(50001; Quantity; Decimal)
        {
            Description = 'RSPL-CAS-06789-V4F4X7';
        }
        field(50002; "Packing Material Weight"; Decimal)
        {
            DecimalPlaces = 0 : 4;
            Description = 'RSPL-CAS-07525-J5Y1V1';
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