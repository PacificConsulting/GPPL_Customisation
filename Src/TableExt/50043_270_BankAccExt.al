tableextension 50043 BankAccExtCutm extends 270

{
    fields
    {
        field(50000; "Full Name"; Text[30])
        {
        }
        field(50001; "Cheque No. Series"; Code[20])
        {
            Description = 'RSPLSUM 21Feb2020';
            TableRelation = "No. Series";
        }
        field(50002; "Swift Code Number"; Code[20])
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50003; "Corresponding Bank"; Text[50])
        {
            Description = 'RSPLSUM-BUNKER';
        }
        // field(50004; "IFSC Code"; Code[20])
        // {
        //     Description = 'RSPLSUM-BUNKER 28May2020';
        // }
        field(50005; "Account Type"; Text[30])
        {
            Description = 'RSPLSUM-BUNKER 28May2020';
        }
        field(50006; "Corresponding Bank Account No."; Text[30])
        {
            Description = 'RSPLSUM-BUNKER 29May2020';
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