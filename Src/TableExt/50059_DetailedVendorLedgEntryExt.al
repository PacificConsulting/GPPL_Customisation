tableextension 50059 DetailedVendorLedgEntryExtCstm extends 380
{
    fields
    {
        field(50000; "Check Print Name"; Text[100])
        {
            Description = 'EBT STIVAN - 09042012 - Added Field For Check Printing';
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