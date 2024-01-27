tableextension 50081 PostedWhseShipHdrExtCstm extends "Posted Whse. Shipment Header"
{
    fields
    {
        field(50000; Approve; Boolean)
        {
            Description = 'EBT STIVAN - 11122012 - Approval Process';
        }
        field(50001; "Approval User ID"; Code[10])
        {
            Description = 'EBT STIVAN - 11122012 - Approval Process';
        }
        field(50002; "Created By User ID"; Code[10])
        {
            Description = 'EBT STIVAN - 11122012 - Approval Process';
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