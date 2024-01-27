tableextension 50011 ILEEXTCustm extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Original Quantity"; Decimal)
        {
        }
        field(50001; "Quantity in Sales UOM"; Decimal)
        {
        }
        field(50011; "Density Factor"; Decimal)
        {
        }
        field(50600; "Expire Date"; Date)
        {
            Description = 'RSPLAM30180';
            Editable = false;
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