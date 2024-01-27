tableextension 50089 "Gate Entry LineExtcstm" extends "Gate Entry Line"
{
    fields
    {
        field(50000; "Blanket Order No."; Code[20])
        {
            Description = 'EBT 0003';
            Editable = false;
        }
        field(50001; Quantity; Decimal)
        {
            Description = 'RSPL-CAS-06789-V4F4X7';
            Editable = false;
        }
        field(50002; "Packing Material Weight"; Decimal)
        {
            DecimalPlaces = 0 : 4;
            Description = 'RSPL-CAS-07525-J5Y1V1';
            Editable = false;
        }
        modify("Source No.")
        {
            trigger OnAfterValidate()
            var
                GateEntryHeader: Record "Gate Entry Header";
                SalesInvHeader: Record "Sales Invoice Header";
                TransShptHeader: Record "Transfer Shipment Header";
                PurchHeader: Record 38;
                SalesShipHeader: Record 110;
                TransHeader: Record 5740;
                SalesHeader: Record 36;
                ReturnShipHeader: Record 6650;
                Text16500: Label 'Source Type must not be blank in %1 %2.';
                TransReptHeader: Record 5746;
                PurchReceiptHd: Record 120;
                PurchReceiptLn: Record 121;
                PurchReceiptHd1: Record 120;
                PurchReceiptHd2: Record 120;
                Gateentrylinerec: Record "Gate Entry Line";
                salesinvheader1: Record 112;
                TransShptHeader1: Record 5744;
                Qty: Decimal;
                Qtyperunit: Decimal;
                SalesInvoiceLine: Record 113;
                SalesLine: Record 37;
                PurchLine: Record 39;
                ReturnShipmntLine: Record 6651;
                RecILE: Record 32;
                RecILE1: Record 32;
                RecSalesInvHeader: Record 112;
                RecSalesInvLine: Record 113;
                RecSalesShpmntLine: Record 111;
                TransferShipmentLine: Record 5745;
                TransferShipmentHeader: Record 5744;
                qtyuom: Decimal;
                ProductionBOM: Record 99000772;
                Item: Record 27;
                PMWeight: Decimal;
                recItem: Record 27;
                ValueEntry: Record 5802;
                ILE1: Record 32;
                RecILE2: Record 32;
                RecILE3: Record 32;
                ItemRec: Record 27;
                ItemUOM: Record 5404;
                OutPutQty: Decimal;
                PerQtyPM: Decimal;
                PG: Page "Sales Return Order";
            begin
                //RSPLSUM 06Dec19>>
                GateEntryHeader.GET("Entry Type", "Gate Entry No.");
                CASE "Source Type" OF
                    "Source Type"::"Sales Shipment":
                        BEGIN
                            SalesInvHeader.RESET;
                            SalesInvHeader.SETRANGE("No.", "Source No.");
                            SalesInvHeader.SETRANGE(SalesInvHeader."Cancelled Invoice", FALSE);
                            SalesInvHeader.SETRANGE("Location Code", GateEntryHeader."Location Code");
                            //        SalesInvHeader.SETRANGE(SalesInvHeader."Shipping Agent Code",GateEntryHeader.Transporter); // Removed on 20012014
                            SalesInvHeader.SETFILTER(SalesInvHeader."Posting Date", '%1..%2', CALCDATE('-1D', TODAY), TODAY);
                            //       SalesInvHeader.SETFILTER(SalesInvHeader."Posting Date",'%1..%2',GateEntryHeader."Document Date",TODAY);
                            IF NOT SalesInvHeader.FINDFIRST THEN
                                ERROR('Invoice posting date is not in a range');
                        END;


                    "Source Type"::"Transfer Shipment":
                        BEGIN
                            TransShptHeader.RESET;
                            TransShptHeader.SETRANGE(TransShptHeader."Transfer-from Code", GateEntryHeader."Location Code");
                            TransShptHeader.SETFILTER(TransShptHeader."Posting Date", '%1..%2', CALCDATE('-1D', TODAY), TODAY);
                            IF NOT TransShptHeader.FINDFIRST THEN
                                ERROR('Transfer Shipment posting date is not in a range');
                        END;

                END;
                //RSPLSUM 06Dec19<<
                //RSPL-CAS-06789-V4F4X7
                Qty := 0;
                Qtyperunit := 0;
                IF "Source No." = '' THEN
                    Quantity := 0;

                CASE "Source Type" OF
                    "Source Type"::"Sales Shipment":
                        BEGIN
                            SalesInvoiceLine.RESET;
                            SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", "Source No.");
                            IF SalesInvoiceLine.FINDSET THEN
                                REPEAT
                                    Qty += SalesInvoiceLine.Quantity;
                                UNTIL SalesInvoiceLine.NEXT = 0;
                        END;

                    "Source Type"::"Sales Return Order":
                        BEGIN
                            SalesLine.RESET;
                            SalesLine.SETRANGE(SalesLine."Document No.", "Source No.");
                            IF SalesLine.FINDSET THEN
                                REPEAT
                                    Qty += SalesLine.Quantity;
                                UNTIL SalesLine.NEXT = 0;
                        END;

                    "Source Type"::"Purchase Order":
                        BEGIN
                            PurchLine.RESET;
                            PurchLine.SETRANGE(PurchLine."Document No.", "Source No.");
                            IF PurchLine.FINDSET THEN
                                REPEAT
                                    Qty += PurchLine.Quantity;
                                UNTIL PurchLine.NEXT = 0;
                        END;

                    "Source Type"::"Transfer Shipment":
                        BEGIN
                            TransferShipmentLine.RESET;
                            TransferShipmentLine.SETRANGE(TransferShipmentLine."Document No.", "Source No.");
                            IF TransferShipmentLine.FINDSET THEN
                                REPEAT
                                    Qty += TransferShipmentLine.Quantity;
                                UNTIL TransferShipmentLine.NEXT = 0;
                        END;

                    "Source Type"::"Purchase Return Shipment":
                        BEGIN
                            ReturnShipmntLine.RESET;
                            ReturnShipmntLine.SETRANGE(ReturnShipmntLine."Document No.", "Source No.");
                            IF ReturnShipmntLine.FINDSET THEN
                                REPEAT
                                    Qty += ReturnShipmntLine.Quantity;
                                UNTIL ReturnShipmntLine.NEXT = 0;
                        END;
                END;

                qtyuom := 0;

                IF "Source Type" = "Source Type"::"Transfer Shipment" THEN BEGIN
                    TransferShipmentLine.RESET;
                    TransferShipmentLine.SETRANGE("Document No.", "Source No.");
                    IF TransferShipmentLine.FINDSET THEN
                        REPEAT
                            recItem.GET(TransferShipmentLine."Item No.");
                            IF recItem."Inventory Posting Group" <> 'MERCH' THEN BEGIN
                                qtyuom := TransferShipmentLine.Quantity * TransferShipmentLine."Qty. per Unit of Measure";
                                RecILE.RESET;
                                RecILE.SETRANGE(RecILE."Document No.", TransferShipmentLine."Document No.");
                                RecILE.SETRANGE(RecILE."Document Line No.", TransferShipmentLine."Line No.");
                                RecILE.SETRANGE(RecILE."Location Code", TransferShipmentLine."Transfer-from Code");
                                IF RecILE.FINDSET THEN
                                    REPEAT
                                        RecILE1.SETRANGE("Lot No.", RecILE."Lot No.");
                                        RecILE1.SETRANGE("Item No.", RecILE."Item No.");
                                        RecILE1.SETRANGE(RecILE1."Entry Type", RecILE1."Entry Type"::Output);
                                        IF RecILE1.FINDFIRST THEN
                                            Quantity += qtyuom * RecILE1."Density Factor"
                                        ELSE
                                            Quantity += qtyuom;
                                    UNTIL RecILE.NEXT = 0;
                            END;
                        UNTIL TransferShipmentLine.NEXT = 0;
                END;

                IF "Source Type" = "Source Type"::"Transfer Shipment" THEN BEGIN
                    TransferShipmentLine.RESET;
                    TransferShipmentLine.SETRANGE("Document No.", "Source No.");
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
                                                    "Packing Material Weight" += Item."Packing Material Weight in KG" * TransferShipmentLine.Quantity
                                                    * PerQtyPM;
                                                END;
                                            UNTIL RecILE3.NEXT = 0;
                                    END;
                                UNTIL RecILE.NEXT = 0;
                        UNTIL TransferShipmentLine.NEXT = 0;

                    /*TransferShipmentLine.RESET;
                    TransferShipmentLine.SETRANGE("Document No.","Source No.");
                    IF TransferShipmentLine.FINDSET THEN REPEAT
                      RecILE.RESET;
                      RecILE.SETRANGE(RecILE."Document No.",TransferShipmentLine."Document No.");
                      RecILE.SETRANGE(RecILE."Document Line No.",TransferShipmentLine."Line No.");
                      RecILE.SETRANGE(RecILE."Location Code",TransferShipmentLine."Transfer-from Code");
                      IF RecILE.FINDSET THEN REPEAT
                        RecILE1.RESET;
                        RecILE1.SETRANGE("Lot No.",RecILE."Lot No.");
                        RecILE1.SETRANGE("Item No.",RecILE."Item No.");
                        RecILE1.SETRANGE(RecILE1."Entry Type",RecILE1."Entry Type"::Output);
                        IF RecILE1.FINDLAST THEN BEGIN
                          RecILE3.SETRANGE(RecILE3."Document No.",RecILE1."Document No.");
                          RecILE3.SETRANGE(RecILE3."Entry Type",RecILE3."Entry Type"::Consumption);
                          IF RecILE3.FINDSET THEN REPEAT
                           Item.GET(RecILE3."Item No.");
                           IF (Item."Item Category Code"='CAT08' )OR (Item."Item Category Code"='CAT04') THEN BEGIN
                             "Packing Material Weight"+=Item."Packing Material Weight in KG"*TransferShipmentLine.Quantity;
                           END;
                          UNTIL RecILE3.NEXT=0;
                        END;
                      UNTIL RecILE.NEXT=0;
                    UNTIL TransferShipmentLine.NEXT=0; */
                END;

                IF "Source Type" = "Source Type"::"Sales Shipment" THEN BEGIN
                    RecSalesInvLine.RESET;
                    RecSalesInvLine.SETRANGE(RecSalesInvLine."Document No.", "Source No.");
                    IF RecSalesInvLine.FINDSET THEN
                        REPEAT
                            IF recItem.GET(RecSalesInvLine."No.") THEN;
                            IF recItem."Inventory Posting Group" <> 'MERCH' THEN BEGIN
                                RecSalesInvHeader.GET(RecSalesInvLine."Document No.");
                                IF RecSalesInvLine."Unit of Measure" <> 'Kgs' THEN BEGIN
                                    ValueEntry.RESET;
                                    ValueEntry.SETCURRENTKEY("Document No.");
                                    ValueEntry.SETRANGE(ValueEntry."Document No.", RecSalesInvLine."Document No.");
                                    ValueEntry.SETRANGE(ValueEntry."Document Type", ValueEntry."Document Type"::"Sales Invoice");
                                    ValueEntry.SETRANGE(ValueEntry."Document Line No.", RecSalesInvLine."Line No.");
                                    IF ValueEntry.FINDSET THEN BEGIN
                                        ILE1.GET(ValueEntry."Item Ledger Entry No.");
                                        RecSalesShpmntLine.RESET;
                                        RecSalesShpmntLine.SETRANGE(RecSalesShpmntLine."Document No.", ILE1."Document No.");
                                        RecSalesShpmntLine.SETRANGE(RecSalesShpmntLine."Line No.", ILE1."Document Line No.");
                                        IF RecSalesShpmntLine.FINDSET THEN BEGIN
                                            Qtyperunit := RecSalesShpmntLine.Quantity * RecSalesShpmntLine."Qty. per Unit of Measure";
                                            RecILE.RESET;
                                            RecILE.SETRANGE(RecILE."Item No.", RecSalesShpmntLine."No.");
                                            RecILE.SETRANGE(RecILE."Document No.", RecSalesShpmntLine."Document No.");
                                            RecILE.SETRANGE("Document Line No.", RecSalesShpmntLine."Line No.");
                                            IF RecILE.FINDSET THEN
                                                REPEAT
                                                    RecILE1.RESET;
                                                    RecILE1.SETRANGE(RecILE1."Lot No.", RecILE."Lot No.");
                                                    RecILE1.SETRANGE("Item No.", RecILE."Item No.");
                                                    RecILE1.SETRANGE("Entry Type", RecILE1."Entry Type"::Output);
                                                    IF RecILE1.FINDLAST THEN BEGIN
                                                        Quantity += Qtyperunit * RecILE1."Density Factor";
                                                    END;
                                                UNTIL RecILE.NEXT = 0;
                                        END;
                                    END;
                                END ELSE
                                    Quantity += RecSalesInvLine.Quantity * RecSalesInvLine."Qty. per Unit of Measure";
                            END;
                        UNTIL RecSalesInvLine.NEXT = 0;
                END;
                //RSPL-CAS-07525-J5Y1V1
                IF "Source Type" = "Source Type"::"Sales Shipment" THEN BEGIN
                    RecSalesInvLine.RESET;
                    RecSalesInvLine.SETRANGE(RecSalesInvLine."Document No.", "Source No.");
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
                                                            "Packing Material Weight" += Item."Packing Material Weight in KG" * RecSalesInvLine.Quantity
                                                            * PerQtyPM;
                                                        END;
                                                    UNTIL RecILE3.NEXT = 0;
                                            END;
                                        UNTIL RecILE.NEXT = 0;
                                END;
                            END;
                        UNTIL RecSalesInvLine.NEXT = 0;
                END;
                /*
                  RecSalesInvLine.RESET;
                  RecSalesInvLine.SETRANGE(RecSalesInvLine."Document No.","Source No.");
                  IF RecSalesInvLine.FINDSET THEN REPEAT
                    RecSalesInvHeader.GET(RecSalesInvLine."Document No.");
                    ValueEntry.RESET;
                    ValueEntry.SETCURRENTKEY("Document No.");
                    ValueEntry.SETRANGE("Document No.",RecSalesInvLine."Document No.");
                    ValueEntry.SETRANGE("Document Type",ValueEntry."Document Type"::"Sales Invoice");
                    ValueEntry.SETRANGE("Document Line No.",RecSalesInvLine."Line No.");
                    IF  ValueEntry.FINDFIRST THEN BEGIN
                     ILE1.GET(ValueEntry."Item Ledger Entry No.");
                     RecSalesShpmntLine.RESET;
                     RecSalesShpmntLine.SETRANGE(RecSalesShpmntLine."Document No.",ILE1."Document No.");
                     RecSalesShpmntLine.SETRANGE(RecSalesShpmntLine."Line No.",ILE1."Document Line No.");
                     IF RecSalesShpmntLine.FINDSET THEN BEGIN
                       RecILE.RESET;
                       RecILE.SETRANGE(RecILE."Item No.",RecSalesShpmntLine."No.");
                       RecILE.SETRANGE(RecILE."Document No.",RecSalesShpmntLine."Document No.");
                       RecILE.SETRANGE("Document Line No.",RecSalesShpmntLine."Line No.");
                       IF RecILE.FINDSET THEN REPEAT
                         RecILE1.RESET;
                         RecILE1.SETRANGE(RecILE1."Lot No.",RecILE."Lot No.");
                         RecILE1.SETRANGE("Item No.",RecILE."Item No.");
                         RecILE1.SETRANGE("Entry Type",RecILE1."Entry Type"::Output);
                         IF RecILE1.FINDLAST THEN BEGIN
                           RecILE2.RESET;
                           RecILE2.SETRANGE(RecILE2."Document No.",RecILE1."Document No.");
                           RecILE2.SETRANGE(RecILE2."Entry Type",RecILE2."Entry Type"::Consumption);
                           IF RecILE2.FINDSET THEN REPEAT
                            Item.GET(RecILE2."Item No.");
                            IF (Item."Item Category Code"='CAT08' )OR (Item."Item Category Code"='CAT04') THEN BEGIN
                              "Packing Material Weight"+=Item."Packing Material Weight in KG"*RecSalesInvLine.Quantity;
                            END;
                           UNTIL RecILE2.NEXT=0;
                         END;
                       UNTIL RecILE.NEXT=0;
                     END;
                    END;
                  UNTIL RecSalesInvLine.NEXT=0;
                
                END;*/
                //RSPL-CAS-06789-V4F4X7


            end;
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