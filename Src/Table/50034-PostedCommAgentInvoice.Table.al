table 50034 "Posted Comm. Agent Invoice"
{
    DrillDownPageID = 50059;
    LookupPageID = 50059;

    fields
    {
        field(1; "Posted Sales Inv. No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Customer No."; Code[10])
        {
            TableRelation = Customer."No.";
        }
        field(4; "Posting Date"; Date)
        {
        }
        field(5; "Item No."; Code[10])
        {
            TableRelation = Item."No.";
        }
        field(6; "Commission Agent No."; Code[10])
        {
            TableRelation = "Revaluation Jounal Upload"."Journal Template Name";
        }
        field(7; Quantity; Decimal)
        {
        }
        field(8; "Quantity (Base)"; Decimal)
        {
        }
        field(9; "Commission Amount"; Decimal)
        {
        }
        field(10; "Invoice Created"; Boolean)
        {
            Editable = true;
        }
        field(11; "Purch. Inv. No."; Code[20])
        {
        }
        field(12; "Posted Purch. Inv. No."; Code[20])
        {
        }
        field(13; "Posted Purch. Inv. Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Posted Sales Inv. No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Commission Agent No.")
        {
        }
        key(Key3; "Commission Agent No.", "Purch. Inv. No.", "Posted Sales Inv. No.", "Customer No.", "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }
}

