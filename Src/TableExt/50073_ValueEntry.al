tableextension 50073 ValueEntryExtcstm extends "Value Entry"
{
    fields
    {
        field(50000; "OLD Cost Posted to G/L"; Decimal)
        {
            Description = 'RSPL-PA';
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