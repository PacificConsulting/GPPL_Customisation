tableextension 50075 SalesPriceExtcstm extends "Sales Price"
{
    fields
    {
        field(50000; "Transfer Price"; Decimal)
        {

            trigger OnValidate()
            begin
                "Transfer Price" := "Transfer Price" * ItemUnitOfMeasure."Qty. per Unit of Measure";
            end;
        }
        field(50001; "Basic Price"; Decimal)
        {

            trigger OnValidate()
            begin
                TESTFIELD("Unit of Measure Code");
                ItemUnitOfMeasure.RESET;
                ItemUnitOfMeasure.SETRANGE(ItemUnitOfMeasure."Item No.", "Item No.");
                ItemUnitOfMeasure.SETRANGE(ItemUnitOfMeasure.Code, "Unit of Measure Code");
                IF ItemUnitOfMeasure.FINDFIRST THEN BEGIN
                    "Unit Price" := "Basic Price" * ItemUnitOfMeasure."Qty. per Unit of Measure";
                    //"Transfer Price" := "Transfer Price" * ItemUnitOfMeasure."Qty. per Unit of Measure";
                    //"Assessable Value" := "Basic Price";
                    /*MRP := TRUE;
                    IF "MRP Price" = 0 THEN
                       "MRP Price" := "Basic Price"; */
                END;

            end;
        }
        field(50002; "Assessable Value"; Decimal)
        {
        }
        field(50003; "National Discount"; Decimal)
        {
            Description = 'EBT0002';
        }
        field(50004; "Price Support"; Decimal)
        {
            Description = 'RSPL-CAS-03500-H4N0R8';
        }
        field(50005; "Promo Scheme"; Text[20])
        {
            Description = 'RSPLSUM03Mar21';
        }
        field(50006; "MRP per Carton"; Decimal)
        {
            Description = 'RSPLSUM03Mar21';
        }
        field(50007; "Qty. per Pack"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'RSPLSUM04Mar21';

            trigger OnValidate()
            begin
                //"MRP per Pack" := "MRP Price" * "Qty. per Pack";//RSPLSUM04Mar21
            end;
        }
        field(50008; "MRP per Pack"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Description = 'RSPLSUM04Mar21';
        }
        field(50009; "No. Of Packs"; Decimal)
        {
            Description = 'DJ28883';

            trigger OnValidate()
            begin
                //DJ 28883
                "MRP per Carton" := "MRP per Pack" * "No. Of Packs";
                //DJ 28883
            end;
        }
        field(50010; "Stockist Unit Price %"; Decimal)
        {
            Description = 'RSPLSUM30Mar21';
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
        ItemUnitOfMeasure: Record 5404;
}