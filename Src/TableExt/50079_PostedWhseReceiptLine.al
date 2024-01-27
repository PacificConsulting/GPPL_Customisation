tableextension 50079 PostedWhseReceiptLineExtCstm extends "Posted Whse. Receipt Line"
{
    fields
    {
        field(50000; "QC Applicable"; Boolean)
        {
            Description = 'EBT/QC Func/0001';
            Editable = false;
        }
        field(50001; "QC Approved"; Boolean)
        {
            Description = 'EBT/QC Func/0001';
            Editable = false;
        }
        field(50002; "Gross Weight"; Decimal)
        {
            Description = 'EBT/LR/0001';
        }
        field(50003; "Net Weight of Vehicle"; Decimal)
        {
            Description = 'EBT/LR/0001';
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