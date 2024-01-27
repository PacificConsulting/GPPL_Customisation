codeunit 50021 ItemJnlPostExtCstm
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterPostOutput, '', false, false)]
    local procedure OnAfterPostOutput(var ItemLedgerEntry: Record "Item Ledger Entry"; var ProdOrderLine: Record "Prod. Order Line"; var ItemJournalLine: Record "Item Journal Line");
    var
        ProdOrder: Record "Production Order";
        ProdOrderLine1: Record "Prod. Order Line";
        ItemRec: Record Item;
        itemJnLine: Record "Item Journal Line";
        CreateMRPMaster: Boolean;
        ItemUOMEBT: Record "Item Unit of Measure";
        MRPMaster: Record "MRP Master";
        MRPMaster1: Record "MRP Master";
        "recProd.Order": Record "Production Order";
        "recProd.OrderLine": Record "Prod. Order Line";
        QCCertificate: Record "QC Certifcate Details";
        QCCertificate1: Record "QC Certifcate Details";
        ItemVersionParameter: Record "Item Version Parameters-Result";
        recItem: Record item;
        ItemJnlLine: Record "Item Journal Line";
        "recIVP-Result": Record "Item Version Parameters-Result";
        VersionCode: code[10];
    // SalesPrice: Record 7002;
    // SalesPrice: Record sales pr

    begin
        //EBT/QC Func/0001
        ProdOrder.RESET;
        ProdOrder.SETRANGE(ProdOrder.Status, ProdOrder.Status::Released);
        ProdOrder.SETRANGE(ProdOrder."No.", itemJnLine."Document No.");
        IF ProdOrder.FINDFIRST THEN BEGIN
            ProdOrderLine1.RESET;
            ProdOrderLine1.SETRANGE(ProdOrderLine1."Prod. Order No.", ProdOrder."No.");
            //EBT STIVAN ---(27122012)---QC Should not be Mandatory for CAPCON Location------START
            ProdOrderLine1.SETFILTER(ProdOrderLine1."Location Code", '<>%1', 'CAPCON');
            //EBT STIVAN ---(27122012)---QC Should not be Mandatory for CAPCON Location--------END
            IF ProdOrderLine1.FINDFIRST THEN
                REPEAT
                    ItemRec.GET(ProdOrderLine1."Item No.");
                    IF ItemRec."QC Applicable" THEN
                        ProdOrder.TESTFIELD(ProdOrder."QC Tested");
                UNTIL ProdOrderLine1.NEXT = 0;
        END;
        //EBT/QC Func/0001


        //EBTMRP0001

        // start radhesh 26-10-12
        CreateMRPMaster := FALSE;
        ItemRec.GET(itemJnLine."Item No.");
        ItemUOMEBT.GET(itemJnLine."Item No.", ItemRec."Sales Unit of Measure");
        IF ItemUOMEBT."Qty. per Unit of Measure" <= 25 THEN
            CreateMRPMaster := TRUE;
        IF ItemUOMEBT."Qty. per Unit of Measure" = 1 THEN
            CreateMRPMaster := FALSE;

        //>>RB-N 22Sep2017
        IF (ItemRec."Gen. Prod. Posting Group" = 'AUTOLUBES') OR (ItemRec."Gen. Prod. Posting Group" = 'REPSOL') THEN
            IF ItemUOMEBT."Qty. per Unit of Measure" = 1 THEN
                CreateMRPMaster := TRUE;


        //<<RB-N 22Sep2017

        // IF CreateMRPMaster THEN BEGIN
        //     IF "Lot No." <> '' THEN BEGIN
        //         ItemRec.GET("Item No.");
        //         IF (ItemRec."Gen. Prod. Posting Group" = 'AUTOLUBES') OR (ItemRec."Gen. Prod. Posting Group" = 'REPSOL') THEN BEGIN
        //             SalesPrice.RESET;
        //             SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::"All Customers");
        //             SalesPrice.SETRANGE("Item No.", "Item No.");
        //             SalesPrice.SETRANGE("Unit of Measure Code", MfgItem."Sales Unit of Measure");
        //             SalesPrice.SETFILTER("Starting Date", '<=%1', "Posting Date");
        //             SalesPrice.SETRANGE(MRP, TRUE);
        //             IF SalesPrice.FINDLAST THEN BEGIN
        //                 MRPMaster1.RESET;
        //                 MRPMaster1.SETRANGE("Item No.", "Item No.");
        //                 MRPMaster1.SETRANGE("Lot No.", "Lot No.");
        //                 IF NOT MRPMaster1.FINDFIRST THEN BEGIN
        //                     MRPMaster.RESET;
        //                     MRPMaster.INIT;
        //                     MRPMaster."Item No." := "Item No.";
        //                     MRPMaster."Lot No." := "Lot No.";
        //                     MRPMaster."Posting Date" := "Posting Date";
        //                     MRPMaster.MRP := TRUE;
        //                     MRPMaster."MRP Price" := SalesPrice."MRP Price";
        //                     MRPMaster."Stock Transfer Price" := SalesPrice."Transfer Price";
        //                     MRPMaster."Unit Of Measure" := SalesPrice."Unit of Measure Code";
        //                     MRPMaster."Sales price" := SalesPrice."Unit Price";
        //                     MRPMaster."Assessable Value" := SalesPrice."Assessable Value";
        //                     MRPMaster."National Discount" := SalesPrice."National Discount";   //EBT0002
        //                     MRPMaster."Price Support" := SalesPrice."Price Support";//RSPL-CAS-03500-H4N0R8
        //                                                                             //EBT STIVAN ---(16102012)--- To Update the Qty per UOM Field in MRP Master Table--------START
        //                     MRPMaster."Qty. per Unit of Measure" := ItemUOMEBT."Qty. per Unit of Measure";
        //                     //EBT STIVAN ---(16102012)--- To Update the Qty per UOM Field in MRP Master Table----------END
        //                     MRPMaster.INSERT;
        //                 END;
        //             END;
        //         END;
        //     END; // radhesh end
        // END;
        // //EBTMRP0001

        //end;
        //QC Test
        //EBT/QC Func/0001
        ItemVersionParameter.RESET;
        ItemVersionParameter.SETRANGE(ItemVersionParameter."Item No.", ItemJnlLine."Item No.");
        ItemVersionParameter.SETRANGE(ItemVersionParameter."Blend Order No", ItemJnlLine."Document No.");
        IF ItemVersionParameter.FINDSET THEN BEGIN
            REPEAT
                ItemVersionParameter."Batch No./DC No" := ItemJnlLine."Lot No.";
                ItemVersionParameter.MODIFY;
            UNTIL ItemVersionParameter.NEXT = 0;
            QCCertificate1.RESET;
            QCCertificate1.SETRANGE(QCCertificate1."Certificate No.", ItemVersionParameter."Certificate No.");
            QCCertificate1.SETRANGE(QCCertificate1."Item No.", ItemVersionParameter."Item No.");
            QCCertificate1.SETRANGE(QCCertificate1."Blend Order No.", ItemJnlLine."Document No.");
            IF NOT QCCertificate1.FINDFIRST THEN BEGIN
                QCCertificate.RESET;
                QCCertificate.INIT;
                QCCertificate."Certificate No." := ItemVersionParameter."Certificate No.";
                QCCertificate."Item No." := ItemVersionParameter."Item No.";
                QCCertificate."Posting Date" := WORKDATE;
                QCCertificate."Batch No." := ItemJnlLine."Lot No.";
                QCCertificate."Blend Order No." := ItemJnlLine."Document No.";
                //EBT STIVAN ---(16102012)--- To Update the Item Description Field in QC Certificate Details Table--------START
                recItem.GET(ItemVersionParameter."Item No.");
                QCCertificate."Item Description" := recItem.Description;
                //EBT STIVAN ---(16102012)--- To Update the Item Description Field in QC Certificate Details Table----------END
                //EBT STIVAN ---(16102012)--- To Update the Location Code Field in QC Certificate Details Table--------START
                QCCertificate."Location Code" := ProdOrder."Location Code";
                //EBT STIVAN ---(16102012)--- To Update the Location Code Field in QC Certificate Details Table----------END
                //EBT STIVAN ---(25107013)--- To Update the Tentative Batch No. Field in QC Certificate Details Table--------START
                QCCertificate."Tentative Batch No." := ProdOrder."Description 2";
                //EBT STIVAN ---(25107013)--- To Update the Tentative Batch No. Field in QC Certificate Details Table----------END
                QCCertificate.INSERT;
            END;
        END;
        //EBT/QC Func/0001

        //EBT STIVAN---(131212)---To Capture Version Code for Secondary Order Type while POsting Production Journal----START
        "recProd.Order".RESET;
        "recProd.Order".SETRANGE("recProd.Order"."No.", ProdOrder."No.");
        "recProd.Order".SETRANGE("recProd.Order"."Order Type", "recProd.Order"."Order Type"::Secondary);
        IF "recProd.Order".FINDFIRST THEN BEGIN
            "recIVP-Result".RESET;
            "recIVP-Result".SETRANGE("recIVP-Result"."Blend Order No", "recProd.Order"."No.");
            IF "recIVP-Result".FINDFIRST THEN BEGIN
                VersionCode := "recIVP-Result"."Version Code";
            END;
            "recProd.OrderLine".RESET;
            "recProd.OrderLine".SETRANGE("recProd.OrderLine"."Prod. Order No.", "recProd.Order"."No.");
            IF "recProd.OrderLine".FINDFIRST THEN BEGIN
                "recProd.OrderLine"."Production BOM Version Code" := VersionCode;
                "recProd.OrderLine".MODIFY;
            END;
        END;
        //EBT STIVAN---(131212)---To Capture Version Code for Secondary Order Type while POsting Production Journal------END

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterItemQtyPosting, '', false, false)]
    local procedure OnAfterItemQtyPosting(ItemJournalLine: Record "Item Journal Line");
    var
    begin
        IF ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Positive Adjmt." THEN;
        //  ExciseInsertRGRegisters.InitRG23DPostive(ItemJnlLine, 1, 1, 3, '', ItemJnlLine."Document No.", 6);    //EBT0001

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterInsertTransferEntry, '', false, false)]
    local procedure OnAfterInsertTransferEntry(var ItemJournalLine: Record "Item Journal Line"; NewItemLedgerEntry: Record "Item Ledger Entry"; OldItemLedgerEntry: Record "Item Ledger Entry");
    var
        TransLine: Record "Transfer Line";
    begin
        //TransLine."Qty. to Receive" := NewItemLedgEntry.Quantity;  //  RSPL RG 23 D UOM issue
        TransLine."Lot No." := NewItemLedgerEntry."Lot No.";//RSPL
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterInitItemLedgEntry, '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer);
    begin
        NewItemLedgEntry."Expire Date" := ItemJournalLine."Expire Date";//RSPLAM30180
        NewItemLedgEntry."Density Factor" := ItemJournalLine."Density Factor";   //EBT 0003
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeInsertItemLedgEntry, '', false, false)]
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line");
    var

        Text50000: Label 'Item %1 is not on inventory.';
    begin
        //RSPL-CAS-1116-H6V0X4 --Start
        IF ItemLedgerEntry.Open THEN
            IF (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Sale) AND (ItemLedgerEntry.Quantity < 0) THEN
                ERROR(Text50000 + ' ,Location Code %2', ItemLedgerEntry."Item No.", ItemJournalLine."Location Code");

        IF ItemLedgerEntry.Open THEN
            IF (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::"Negative Adjmt.") AND
                                                             (ItemLedgerEntry.Quantity < 0) THEN
                ERROR(Text50000 + ' ,Location Code %2', ItemLedgerEntry."Item No.", ItemJournalLine."Location Code");

        IF ItemLedgerEntry.Open THEN
            IF (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Transfer) AND
                                                             (ItemLedgerEntry.Quantity < 0) THEN
                ERROR(Text50000 + ' ,Location Code %2', ItemLedgerEntry."Item No.", ItemJournalLine."Location Code");

        IF ItemLedgerEntry.Open THEN
            IF (ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Purchase Return Shipment") AND
                                                              (ItemLedgerEntry.Quantity < 0) THEN
                ERROR(Text50000 + ' ,Location Code %2', ItemLedgerEntry."Item No.", ItemJournalLine."Location Code");
        //RSPL-CAS-1116-H6V0X4 ---End
    end;


    var
        myInt: Integer;
}