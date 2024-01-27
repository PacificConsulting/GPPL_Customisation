table 70000 "Inventory Upload"
{

    fields
    {
        field(1; "Location Code"; Code[20])
        {
            TableRelation = Location;
        }
        field(2; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(3; "Lot No."; Code[20])
        {
        }
        field(4; "Unit of Measure"; Code[20])
        {
            TableRelation = "Item Unit of Measure" WHERE("Item No." = FIELD("Item No."));

            trigger OnValidate()
            begin
                ItemUnitOfMeasure.RESET;
                ItemUnitOfMeasure.SETRANGE(ItemUnitOfMeasure."Item No.", "Item No.");
                ItemUnitOfMeasure.SETRANGE(ItemUnitOfMeasure.Code, "Unit of Measure");
                IF ItemUnitOfMeasure.FINDFIRST THEN
                    "Qty Per Unit of Measure" := ItemUnitOfMeasure."Qty. per Unit of Measure";
            end;
        }
        field(5; "Qty Per Unit of Measure"; Decimal)
        {
        }
        field(6; Quantity; Decimal)
        {
        }
        field(7; "MRP Price"; Decimal)
        {
        }
        field(8; "Sales Price"; Decimal)
        {
        }
        field(9; "Transfer Price"; Decimal)
        {
        }
        field(10; Division; Code[10])
        {
        }
        field(11; "Assessable Value"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Location Code", "Item No.", "Lot No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ItemUnitOfMeasure: Record 5404;
}

