table 50018 "Import Excise Accounting"
{

    fields
    {
        field(2; "Entry Type"; Option)
        {
            OptionCaption = ' ,Transfer Shipment,Transfer Receipt';
            OptionMembers = " ","Transfer Shipment","Transfer Receipt";
        }
        field(3; "Ecess Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(4; "She Cess"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(5; "Custom Ecess Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(6; "Custom She Cess Acc"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(7; "ADE Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(8; "CVD Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(9; "BCD Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(10; "Excise Payable Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(11; "BED Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(12; "Inv. Posting Group"; Code[20])
        {
            TableRelation = "Inventory Posting Group".Code;
        }
        field(13; "Excise Control Acc"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(16; "Custom Ecess Upload Inv"; Boolean)
        {
        }
        field(17; "Cust She Cess Upload Inv"; Boolean)
        {
        }
        field(18; "ADE Upload Inv"; Boolean)
        {
        }
        field(19; "CVD Upload Inv"; Boolean)
        {
        }
        field(20; "BCD Upload Inv"; Boolean)
        {
        }
        field(21; "DCA Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Entry Type", "Inv. Posting Group")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

