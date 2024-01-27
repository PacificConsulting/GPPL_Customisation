tableextension 50047 VendorBankAccountExtCutm extends 288

{
    fields
    {
        field(50000; "SWIFT Code Number"; Code[20])
        {
            Caption = 'SWIFT Code Number';
        }
        field(50001; Blocked; Boolean)
        {
            Description = 'RSPLSUM 23Jul2020';
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