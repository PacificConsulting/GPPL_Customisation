tableextension 50046 CustomerBankAccountExtCutm extends 287
{
    fields
    {
        field(50000; "SWIFT Code Number"; Code[20])
        {
            Caption = 'SWIFT Code Number';
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