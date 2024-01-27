tableextension 50071 WarehouseRequestExxtCstm extends "Warehouse Request"
{
    fields
    {
        field(50000; "Vendor Name"; Text[100])
        {
            Description = 'EBT0001';
        }
        field(50001; "Gate Entry No."; Code[20])
        {
            Description = 'EBT0001';
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