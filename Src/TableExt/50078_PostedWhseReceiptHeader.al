tableextension 50078 PostedWhseReceiptHeaderExtCstm extends "Posted Whse. Receipt Header"
{
    fields
    {
        field(50001; "Density Factor"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50002; "Vendor Quantity"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50003; "Gross Weight"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50004; "Tare Weight"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50005; "Gate Entry No."; Code[20])
        {
            Description = 'EBT/PO Dens Func/0001';
            //TableRelation = "Posted Gate Entry Header"."No." WHERE ("Entry Type"=FILTER('Inward'));
        }
        field(50006; "Net Weight"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
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