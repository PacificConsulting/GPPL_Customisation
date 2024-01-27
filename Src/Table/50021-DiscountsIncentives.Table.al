table 50021 "Discounts & Incentives"
{

    fields
    {
        field(1; "Invoice No."; Code[20])
        {
            TableRelation = "Sales Invoice Header";
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Invoice Date"; Date)
        {
        }
        field(4; "Item No."; Code[10])
        {
            TableRelation = Item;
        }
        field(5; "Packing Size"; Decimal)
        {
        }
        field(6; Quantity; Decimal)
        {
        }
        field(7; "Quantity (Base)"; Decimal)
        {
        }
        field(8; "MRP Price"; Decimal)
        {
        }
        field(9; "List Price"; Decimal)
        {
        }
        field(10; "AVP Discount"; Decimal)
        {
        }
        field(11; "Spot Discount"; Decimal)
        {
        }
        field(12; "Special Mgm Discount"; Decimal)
        {
        }
        field(13; "Price Difference"; Decimal)
        {
        }
        field(14; "Total Discount Per Unit"; Decimal)
        {
        }
        field(15; "Total Amount"; Decimal)
        {
        }
        field(16; "Customer No."; Code[10])
        {
        }
        field(17; "Total AVP Discount"; Decimal)
        {
        }
        field(18; "Total Spot Discount"; Decimal)
        {
        }
        field(19; "Total Spcl Mgm Disc"; Decimal)
        {
        }
        field(20; "Total Price Diff"; Decimal)
        {
        }
        field(21; "Credit Memo Created"; Boolean)
        {
        }
        field(22; "Credit Memo No."; Code[20])
        {
        }
        field(23; "Create Credit Memo"; Boolean)
        {
        }
        field(24; "Item Name"; Text[50])
        {
        }
        field(25; "Unit Of Measure"; Code[10])
        {
            TableRelation = "Item Unit of Measure" WHERE("Item No." = FIELD("Item No."));
        }
    }

    keys
    {
        key(Key1; "Invoice No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

