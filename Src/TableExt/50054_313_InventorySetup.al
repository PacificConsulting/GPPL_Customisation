tableextension 50054 InventorySetupExtCust extends 313
{
    fields
    {
        field(50000; "Transfer Indent No Series"; Code[10])
        {
            Description = 'EBT/TROIndent/0001';
            TableRelation = "No. Series";
        }
        field(50001; "Updating Dimension While Post"; Boolean)
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