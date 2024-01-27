tableextension 50080 WarehouseShipmentHeaderExtCstm extends "Warehouse Shipment Header"
{
    fields
    {
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                EBTlocation: Record Location;
            begin
                EBTlocation.RESET;
                EBTlocation.SETRANGE(EBTlocation.Code, "Location Code");
                EBTlocation.SETRANGE(EBTlocation.Closed, TRUE);
                IF EBTlocation.FINDFIRST THEN BEGIN
                    ERROR('You are not allowed the select this Location as it is Closed');
                END;
            end;
        }
        field(50000; Approve; Boolean)
        {
            Description = 'EBT STIVAN - 11122012 - Approval Process';

            trigger OnValidate()
            begin
                //EBT STIVAN---(11/12/2012)---To Capture Approval USer ID ----START
                IF Approve = TRUE THEN BEGIN
                    "Approval User ID" := USERID
                END ELSE
                    "Approval User ID" := '';
                //EBT STIVAN---(11/12/2012)---To Capture Approval USer ID ------END
            end;
        }
        field(50001; "Approval User ID"; Code[50])
        {
            Description = 'EBT STIVAN - 11122012 - Approval Process';
        }
        field(50002; "Created By User ID"; Code[50])
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
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        //EBT STIVAN---(11/12/2012)---To Capture Created USer ID ----START
        "Created By User ID" := USERID;
        //EBT STIVAN---(11/12/2012)---To Capture Created USer ID ------END
    end;

    var
        myInt: Integer;
}