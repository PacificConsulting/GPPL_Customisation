table 50025 "Item Version Parameters"
{
    LookupPageID = 50031;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(2; "Version Code"; Code[10])
        {
            TableRelation = "Production BOM Version"."Version Code" WHERE("Production BOM No." = FIELD("Item No."));
        }
        field(3; Parameter; Code[80])
        {
            TableRelation = "Quality Parameters";
        }
        field(4; "Typical Value"; Code[120])
        {
        }
        field(10; "Min Value"; Code[30])
        {
        }
        field(11; "Max Value"; Code[30])
        {
        }
        field(20; Mandatory; Boolean)
        {
        }
        field(21; Result; Code[100])
        {
            Description = 'Added to Store the Value into Another Table';
        }
        field(22; "Test Method"; Code[50])
        {
            TableRelation = "Test Methods";
        }
        field(23; "Blend Order No."; Code[20])
        {
            TableRelation = "Production Order"."No.";
        }
        field(50001; "Line No."; Integer)
        {
            MinValue = 10000;
        }
        field(50002; "Version Descrption"; Text[50])
        {
        }
        field(50003; "Test Result Approved"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Item No.", Parameter, "Test Method", "Version Code", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Item No.", "Version Code", "Line No.", "Version Descrption")
        {
        }
    }

    fieldgroups
    {
    }
}

