tableextension 50053 PurchasesPayablesSetupExtcustm extends 312
{
    fields
    {
        field(50000; "Email Alert on Blanket PO"; Boolean)
        {
            Description = 'RB-N 15May2018';
        }
        field(50001; "Email Alert on GatePass"; Boolean)
        {
            Description = 'RB-N 17Mar2019';
        }
        field(50002; "Requistion GatePass Nos"; Code[10])
        {
            Description = 'RB-N 17Mar2019';
            TableRelation = "No. Series";
        }
        field(50003; "Posted GatePass Nos"; Code[10])
        {
            Description = 'RB-N 17Mar2019';
            TableRelation = "No. Series";
        }
        field(50004; "QC Approval Email Alert"; Boolean)
        {
            Description = 'RSPLSUM28688 18Feb21';
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