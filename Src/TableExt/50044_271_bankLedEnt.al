tableextension 50044 BankLedEntExtCutm extends 271
{
    fields
    {
        field(50000; "Check Print Name"; Text[100])
        {
            Description = 'EBT STIVAN - 09042012 - Added Field For Check Printing';
        }
        field(50001; "Currency Factor"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Description = 'RSPL-Rahul';
        }
        field(50002; "Amount (FCY)"; Decimal)
        {
            Description = 'RSPL';
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