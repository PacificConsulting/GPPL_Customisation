table 59999 "Opening Balance"
{

    fields
    {
        field(1; "Posting Date"; Date)
        {
        }
        field(2; "Document No."; Code[20])
        {
        }
        field(3; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(4; "Lot No."; Code[20])
        {
        }
        field(5; Division; Code[10])
        {
        }
        field(6; "Resp Center"; Code[10])
        {
        }
        field(7; "Location Code"; Code[10])
        {
        }
        field(8; "Unit Cost"; Decimal)
        {
        }
        field(9; "Phys. Inventory"; Decimal)
        {
        }
        field(10; "Transfer From Loc"; Code[10])
        {
        }
        field(11; "Bin Code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Item No.", "Lot No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

