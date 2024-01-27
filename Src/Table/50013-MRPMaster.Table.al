table 50013 "MRP Master"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                /*
                recItemUOM.RESET;
                recItemUOM.SETRANGE(recItemUOM."Item No.","Item No.");
                recItemUOM.SETRANGE(recItemUOM.Code,"Unit Of Measure");
                IF recItemUOM.FINDFIRST THEN
                BEGIN
                 "Qty. per Unit of Measure" := recItemUOM."Qty. per Unit of Measure";
                END;
                */

            end;
        }
        field(2; "Lot No."; Code[20])
        {
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; MRP; Boolean)
        {
        }
        field(5; "MRP Price"; Decimal)
        {
        }
        field(6; "Stock Transfer Price"; Decimal)
        {
        }
        field(7; "Unit Of Measure"; Code[20])
        {
            Description = 'EBT0001';
            TableRelation = "Unit of Measure";
        }
        field(8; "Sales price"; Decimal)
        {
        }
        field(9; "Assessable Value"; Decimal)
        {
        }
        field(10; "Applicable Date"; Date)
        {
            Description = 'EBT 0003';
        }
        field(50000; "Qty. per Unit of Measure"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Description = 'EBT STIVAN 16102012';
        }
        field(50001; "National Discount"; Decimal)
        {
            Description = 'EBT0002';
        }
        field(50002; "Price Support"; Decimal)
        {
            Description = 'RSPL-CAS-03500-H4N0R8';
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

    var
        recItemUOM: Record 5404;
}

