tableextension 50070 TransferReceiptHeaderextCstm extends "Transfer Receipt Header"
{
    fields
    {
        field(50008; "Transfer From User City"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = "Form Update sales Invoice";
        }
        field(50009; "Transfer From User Sate"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = State;
        }
        field(50010; "Transfer From User Zone"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = "Vehicle Capacity";
        }
        field(50011; "Transfer To User City"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = "Form Update sales Invoice";
        }
        field(50012; "Transfer To User Sate"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = State;
        }
        field(50013; "Transfer To User Zone"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = "Vehicle Capacity";
        }
        field(50030; "Empty Vehicle Weight"; Decimal)
        {
        }
        field(50031; "Vehicle Weight After loading"; Decimal)
        {
        }
        field(50032; "Net Weight of the Truck"; Decimal)
        {
        }
        field(50033; "WH Bill Entry No."; Code[20])
        {
        }
        field(50034; "Time In/Out"; Time)
        {
        }
        field(50035; "Debond Bill Entry No."; Code[20])
        {
        }
        field(50036; "Transfer Indent No."; Code[20])
        {
            Description = 'EBT STIVAN (29/05/2012)';
            Editable = false;
        }
        field(59995; "Road Permit No."; Code[20])
        {
            Description = 'EBT STIVAN (11-12-2012)';
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