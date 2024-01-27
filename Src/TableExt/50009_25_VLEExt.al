tableextension 50009 VLEEXTcustm extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "Check Print Name"; Text[100])
        {
            Description = 'EBT STIVAN - 09042012 - Added Field For Check Printing';
        }
        field(50013; "Applied Bank Payment Doc .No"; Code[20])
        {
            Description = 'EBT STIVAN - 09042012 -To capture Applied Bank Payment Document No';
        }
        field(50014; "Applied Amount of Bank Payment"; Decimal)
        {
            Description = 'EBT STIVAN - 09042012 -To capture appllied amount';

            trigger OnValidate()
            begin
                //EBT STIVAN ---(09042012)---To Update Applied AMOUNT-------START
                "Applied Amount of Bank Payment" := "Amount to Apply";
                //EBT STIVAN ---(09042012)---To Update Applied AMOUNT---------END
            end;
        }
        field(50202; "Purchase order No."; Code[50])
        {
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