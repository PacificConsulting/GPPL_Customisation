codeunit 54555 UpdateGPPM
{

    trigger OnRun()
    begin
        recPostedGateEntry.RESET;
        recPostedGateEntry.SETRANGE(recPostedGateEntry."Gate Entry No.", 'V/OW/1215/0012');
        IF recPostedGateEntry.FINDSET THEN
            REPEAT
                IF recPostedGateEntry."Source Type" = recPostedGateEntry."Source Type"::"Transfer Shipment" THEN BEGIN
                    recPostedGateEntry."Packing Material Weight" := 0;
                    TransferShipmentLine.RESET;
                    TransferShipmentLine.SETRANGE("Document No.", recPostedGateEntry."Source No.");
                    IF TransferShipmentLine.FINDSET THEN
                        REPEAT
                            RecILE.RESET;
                            RecILE.SETRANGE(RecILE."Document No.", TransferShipmentLine."Document No.");
                            RecILE.SETRANGE(RecILE."Document Line No.", TransferShipmentLine."Line No.");
                            RecILE.SETRANGE(RecILE."Location Code", TransferShipmentLine."Transfer-from Code");
                            IF RecILE.FINDSET THEN
                                REPEAT
                                    RecILE1.RESET;
                                    RecILE1.SETRANGE("Lot No.", RecILE."Lot No.");
                                    RecILE1.SETRANGE("Item No.", RecILE."Item No.");
                                    RecILE1.SETRANGE(RecILE1."Entry Type", RecILE1."Entry Type"::Output);
                                    IF RecILE1.FINDLAST THEN BEGIN
                                        RecILE3.RESET;
                                        RecILE3.SETRANGE(RecILE3."Document No.", RecILE1."Document No.");
                                        RecILE3.SETRANGE(RecILE3."Entry Type", RecILE3."Entry Type"::Consumption);
                                        IF RecILE3.FINDSET THEN
                                            REPEAT
                                                Item.GET(RecILE3."Item No.");
                                                IF (Item."Item Category Code" = 'CAT08') OR (Item."Item Category Code" = 'CAT04') THEN BEGIN
                                                    ItemRec.GET(RecILE1."Item No.");
                                                    ItemUOM.GET(ItemRec."No.", ItemRec."Sales Unit of Measure");
                                                    OutPutQty := RecILE1.Quantity / ItemUOM."Qty. per Unit of Measure";
                                                    PerQtyPM := ABS(RecILE3.Quantity) / OutPutQty;
                                                    recPostedGateEntry."Packing Material Weight" += Item."Packing Material Weight in KG" * TransferShipmentLine.Quantity
                                                    * PerQtyPM;
                                                END;
                                            UNTIL RecILE3.NEXT = 0;
                                    END;
                                UNTIL RecILE.NEXT = 0;
                        UNTIL TransferShipmentLine.NEXT = 0;
                END
                ELSE
                    /*
                        IF recPostedGateEntry."Source Type" = recPostedGateEntry."Source Type"::"Sales Invoice" THEN BEGIN
                            recPostedGateEntry."Packing Material Weight" := 0;
                            RecSalesInvLine.RESET;
                            RecSalesInvLine.SETRANGE(RecSalesInvLine."Document No.", recPostedGateEntry."Source No.");
                            IF RecSalesInvLine.FINDSET THEN
                                REPEAT
                                    ValueEntry.RESET;
                                    ValueEntry.SETCURRENTKEY("Document No.");
                                    ValueEntry.SETRANGE("Document No.", RecSalesInvLine."Document No.");
                                    ValueEntry.SETRANGE("Document Type", ValueEntry."Document Type"::"Sales Invoice");
                                    ValueEntry.SETRANGE("Document Line No.", RecSalesInvLine."Line No.");
                                    IF ValueEntry.FINDFIRST THEN BEGIN
                                        ILE1.GET(ValueEntry."Item Ledger Entry No.");
                                        RecSalesShpmntLine.RESET;
                                        RecSalesShpmntLine.SETRANGE(RecSalesShpmntLine."Document No.", ILE1."Document No.");
                                        RecSalesShpmntLine.SETRANGE(RecSalesShpmntLine."Line No.", ILE1."Document Line No.");
                                        IF RecSalesShpmntLine.FINDSET THEN BEGIN
                                            RecILE.RESET;
                                            RecILE.SETRANGE(RecILE."Document No.", RecSalesShpmntLine."Document No.");
                                            RecILE.SETRANGE(RecILE."Document Line No.", RecSalesShpmntLine."Line No.");
                                            IF RecILE.FINDSET THEN
                                                REPEAT
                                                    RecILE1.RESET;
                                                    RecILE1.SETRANGE("Lot No.", RecILE."Lot No.");
                                                    RecILE1.SETRANGE("Item No.", RecILE."Item No.");
                                                    RecILE1.SETRANGE(RecILE1."Entry Type", RecILE1."Entry Type"::Output);
                                                    IF RecILE1.FINDLAST THEN BEGIN
                                                        RecILE3.RESET;
                                                        RecILE3.SETRANGE(RecILE3."Document No.", RecILE1."Document No.");
                                                        RecILE3.SETRANGE(RecILE3."Entry Type", RecILE3."Entry Type"::Consumption);
                                                        IF RecILE3.FINDSET THEN
                                                            REPEAT
                                                                Item.GET(RecILE3."Item No.");
                                                                IF (Item."Item Category Code" = 'CAT08') OR (Item."Item Category Code" = 'CAT04') THEN BEGIN
                                                                    ItemRec.GET(RecILE1."Item No.");
                                                                    ItemUOM.GET(ItemRec."No.", ItemRec."Sales Unit of Measure");
                                                                    OutPutQty := RecILE1.Quantity / ItemUOM."Qty. per Unit of Measure";
                                                                    PerQtyPM := ABS(RecILE3.Quantity) / OutPutQty;
                                                                    recPostedGateEntry."Packing Material Weight" += Item."Packing Material Weight in KG" * RecSalesInvLine.Quantity
                                                                    * PerQtyPM;
                                                                END;
                                                            UNTIL RecILE3.NEXT = 0;
                                                    END;
                                                UNTIL RecILE.NEXT = 0;
                                        END;
                                    END;
                                UNTIL RecSalesInvLine.NEXT = 0;
                        END;
                        */
                recPostedGateEntry.MODIFY;
            UNTIL recPostedGateEntry.NEXT = 0;
        MESSAGE('Done');
    end;

    var
        recPostedGateEntry: Record "Posted Gate Entry Line";
        TransferShipmentLine: Record 5745;
        RecILE: Record 32;
        RecILE1: Record 32;
        RecILE3: Record 32;
        Item: Record 27;
        PerQtyPM: Decimal;
        OutPutQty: Decimal;
        ItemRec: Record 27;
        ItemUOM: Record 5404;
        RecSalesInvLine: Record 113;
        ValueEntry: Record 5802;
        ILE1: Record 32;
        RecSalesShpmntLine: Record 111;
}

