codeunit 50015 AllEventSubscriberCustm
{
    trigger OnRun()
    begin

    end;

    var
        ItemRec: Record 27;
        recItemJrnl: Record 83;
        recItemUOM: Record 5404;
        recItem: Record 27;
        "recIVP-Result": Record 50015;
        VersionCode: Code[10];
        "recProd.Order": Record 5405;
        "recProd.OrderLine": Record 5406;
        Text50000: Label 'Item %1 is not on inventory.';
        ReservationEntry: Record 337;
        RecILEApplied: Record 32;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeManualReleasePurchaseDoc', '', false, false)]
    local procedure Onbefore(var PurchaseHeader: Record "Purchase Header")
    var
        recPurchLine11: Record "Purchase Line";
        HSNSAC: Record "HSN/SAC";
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
    begin


        // //RSPL robotdsAM--
        // IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) THEN BEGIN
        //     recPurchLine11.RESET;
        //     recPurchLine11.SETRANGE("Document No.", PurchaseHeader."No.");
        //     IF recPurchLine11.FINDFIRST THEN
        //         REPEAT
        //             IF HSNSAC.GET(recPurchLine11."GST Group Code", recPurchLine11."HSN/SAC Code") THEN BEGIN
        //                 IF HSNSAC.Type = HSNSAC.Type::HSN THEN BEGIN
        //                     IF recPurchLine11."Gen. Bus. Posting Group" <> '' THEN BEGIN
        //                         IF GenBusinessPostingGroup.GET(recPurchLine11."Gen. Bus. Posting Group") THEN BEGIN
        //                             IF GenBusinessPostingGroup."TDS Mandatory" THEN BEGIN
        //                                 IF recPurchLine11."TDS Nature of Deduction" = '' THEN
        //                                     recPurchLine11.TESTFIELD(recPurchLine11."TDS Nature of Deduction");
        //                             END;
        //                         END;
        //                     END;
        //                 END;
        //             END;
        //         UNTIL recPurchLine11.NEXT = 0;
        // END;
        // //RSPL robotdsAM++
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnCreateEntrySummary2OnBeforeInsertOrModify', '', false, false)]
    local procedure TempGlobalEntrySummary(var TempGlobalEntrySummary: Record "Entry Summary" temporary; TempReservEntry: Record "Reservation Entry" temporary; TrackingSpecification: Record "Tracking Specification")
    var
        ILE18: Record "Item Ledger Entry";
        MRPMaster: Record "MRP Master";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        QtyPerUOM: Decimal;
    begin
        //EBT0001
        IF ItemRec.GET(TrackingSpecification."Item No.") THEN;
        IF ItemUnitofMeasure.GET(ItemRec."No.", ItemRec."Sales Unit of Measure") THEN;
        QtyPerUOM := ItemUnitofMeasure."Qty. per Unit of Measure";
        //EBT0001
        //EBT0001
        if QtyPerUOM > 0 then
            TempGlobalEntrySummary."Quantity in Sales UOM" := TempGlobalEntrySummary."Total Quantity" / QtyPerUOM;
        MRPMaster.RESET;
        MRPMaster.SETRANGE(MRPMaster."Item No.", ItemRec."No.");
        MRPMaster.SETRANGE(MRPMaster."Lot No.", TempGlobalEntrySummary."Lot No.");
        IF MRPMaster.FINDFIRST THEN BEGIN
            TempGlobalEntrySummary."MRP Price" := MRPMaster."MRP Price";
            TempGlobalEntrySummary."List Price" := MRPMaster."Sales price" / QtyPerUOM;
            //TempGlobalEntrySummary."List Price" := (MRPMaster."Sales price" - MRPMaster."Product Discount")/QtyPerUOM;//23Oct2018
        END;
        //EBT0001
        //        RB-N 18Nov2017 Manufacturing Date
        ILE18.RESET;
        ILE18.SETCURRENTKEY("Lot No.");
        ILE18.SETRANGE("Lot No.", TempGlobalEntrySummary."Lot No.");
        ILE18.SETRANGE("Item No.", TrackingSpecification."Item No.");
        ILE18.SETRANGE("Entry Type", ILE18."Entry Type"::Output);
        IF ILE18.FINDFIRST THEN BEGIN
            TempGlobalEntrySummary."Manufacturing Date" := ILE18."Posting Date";
        END;
        //        RB-N 18Nov2017 Manufacturing Date
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnBeforeChangeStatusOnProdOrder', '', false, false)]
    local procedure CheckingQcTest(var ProductionOrder: Record "Production Order")
    begin
        if ProductionOrder.Status = ProductionOrder.Status::Released then /// MY PC added on 29 01 2024
            ProductionOrder.TESTFIELD(ProductionOrder."QC Tested");   //EBT/QC Func/0001
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnTransProdOrderOnBeforeToProdOrderInsert', '', false, false)]
    local procedure Totrapro(FromProdOrder: Record "Production Order"; var ToProdOrder: Record "Production Order"; NewPostingDate: Date)
    begin
        ToProdOrder."Order Type" := FromProdOrder."Order Type";   //EBT/QC Func/0001
        if FromProdOrder.Status = FromProdOrder.Status::Finished then begin

            ToProdOrder."Finished Date" := NewPostingDate;
            ToProdOrder."Finished Time" := Time;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Create Source Document", 'OnBeforePurchLine2ReceiptLine', '', false, false)]
    local procedure PurchLine2ReceiptLine(var PurchLine: Record "Purchase Line"; WhseReceiptHeader: Record "Warehouse Receipt Header")
    var
        UnitPrice: Decimal;
    begin
        //EBT/PO Dens Func/0001
        IF PurchLine."Density Factor Applicable" THEN BEGIN
            IF WhseReceiptHeader."Density Factor" = 0 THEN
                ERROR('You need to put the Density factor in Warehouse Receipt %1', WhseReceiptHeader."No.");
            IF WhseReceiptHeader."Vendor Quantity" = 0 THEN
                ERROR('You need to put the Vendor Quantity in Warehouse Receipt %1', WhseReceiptHeader."No.");
            IF WhseReceiptHeader."Gate Entry No." = '' THEN
                ERROR('You need to put the Gate Entry No. in Warehouse Receipt %1', WhseReceiptHeader."No.");
            IF WhseReceiptHeader."Gross Weight" = 0 THEN
                ERROR('You need to put the Gross Weight in Warehouse Receipt %1', WhseReceiptHeader."No.");
            IF WhseReceiptHeader."Tare Weight" = 0 THEN
                ERROR('You need to put the Tare Weight in Warehouse Receipt %1', WhseReceiptHeader."No.")
            ELSE BEGIN
                UnitPrice := (PurchLine."Direct Unit Cost" *
                 (WhseReceiptHeader."Vendor Quantity" / WhseReceiptHeader."Net Weight"));
                PurchLine."Modify Through WH" := TRUE;
                //PurchLine.VALIDATE(PurchLine."Density Factor",WhseReceiptHeader."Density Factor");
                PurchLine.VALIDATE(PurchLine."Direct Unit Cost", UnitPrice);

                PurchLine.MODIFY;
            END;

        END;
        //EBT/PO Dens Func/0001        
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', false, false)]
    local procedure ExpDate(ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry")
    begin
        ItemLedgerEntry."Expire Date" := ItemJournalLine."Expire Date";
        ItemLedgerEntry."Density Factor" := ItemJournalLine."Density Factor";
        //RSPL-CAS-1116-H6V0X4 --Start
        IF ItemLedgerEntry.Open THEN
            IF (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Sale) AND (ItemLedgerEntry.Quantity < 0) THEN
                ERROR(Text50000 + ' ,Location Code %2', ItemLedgerEntry."Item No.", ItemLedgerEntry."Location Code");

        IF ItemLedgerEntry.Open THEN
            IF (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::"Negative Adjmt.") AND
                                                             (ItemLedgerEntry.Quantity < 0) THEN
                ERROR(Text50000 + ' ,Location Code %2', ItemLedgerEntry."Item No.", ItemLedgerEntry."Location Code");

        IF ItemLedgerEntry.Open THEN
            IF (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Transfer) AND
                                                             (ItemLedgerEntry.Quantity < 0) THEN
                ERROR(Text50000 + ' ,Location Code %2', ItemLedgerEntry."Item No.", ItemLedgerEntry."Location Code");

        IF ItemLedgerEntry.Open THEN
            IF (ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Purchase Return Shipment") AND
                                                              (ItemLedgerEntry.Quantity < 0) THEN
                ERROR(Text50000 + ' ,Location Code %2', ItemLedgerEntry."Item No.", ItemLedgerEntry."Location Code");
        //RSPL-CAS-1116-H6V0X4 ---End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnPostOutputOnAfterCreateWhseJnlLine', '', false, false)]
    local procedure Onafterpost(var ItemJournalLine: Record "Item Journal Line")
    var
        ProdOrder: Record 5405;
        ProdOrderLine1: Record "Prod. Order Line";
        ItemRec: Record Item;
        MRPMaster: Record "50013";
        SalesPrice: Record "7002";
        ItemVersionParameter: Record "50015";
        QCCertificate: Record "50016";
        MRPMaster1: Record "50013";
        QCCertificate1: Record "50016";
        CreateMRPMaster: Boolean;
        ItemUOMEBT: Record "5404";
        MfgItem: Record Item;
    begin
        // start radhesh 26-10-12
        CreateMRPMaster := FALSE;
        ItemRec.GET(ItemJournalLine."Item No.");
        ItemUOMEBT.GET(ItemJournalLine."Item No.", ItemRec."Sales Unit of Measure");
        IF ItemUOMEBT."Qty. per Unit of Measure" <= 25 THEN
            CreateMRPMaster := TRUE;
        IF ItemUOMEBT."Qty. per Unit of Measure" = 1 THEN
            CreateMRPMaster := FALSE;

        //>>RB-N 22Sep2017
        IF (ItemRec."Gen. Prod. Posting Group" = 'AUTOLUBES') OR (ItemRec."Gen. Prod. Posting Group" = 'REPSOL') THEN
            IF ItemUOMEBT."Qty. per Unit of Measure" = 1 THEN
                CreateMRPMaster := TRUE;

        //<<RB-N 22Sep2017

        IF CreateMRPMaster THEN BEGIN
            IF ItemJournalLine."Lot No." <> '' THEN BEGIN
                ItemRec.GET(ItemJournalLine."Item No.");
                IF (ItemRec."Gen. Prod. Posting Group" = 'AUTOLUBES') OR (ItemRec."Gen. Prod. Posting Group" = 'REPSOL') THEN BEGIN
                    SalesPrice.RESET;
                    SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::"All Customers");
                    SalesPrice.SETRANGE("Item No.", ItemJournalLine."Item No.");
                    SalesPrice.SETRANGE("Unit of Measure Code", MfgItem."Sales Unit of Measure");
                    SalesPrice.SETFILTER("Starting Date", '<=%1', ItemJournalLine."Posting Date");
                    //SalesPrice.SETRANGE(MRP, TRUE);
                    IF SalesPrice.FINDLAST THEN BEGIN
                        MRPMaster1.RESET;
                        MRPMaster1.SETRANGE("Item No.", ItemJournalLine."Item No.");
                        MRPMaster1.SETRANGE("Lot No.", ItemJournalLine."Lot No.");
                        IF NOT MRPMaster1.FINDFIRST THEN BEGIN
                            MRPMaster.RESET;
                            MRPMaster.INIT;
                            MRPMaster."Item No." := ItemJournalLine."Item No.";
                            MRPMaster."Lot No." := ItemJournalLine."Lot No.";
                            MRPMaster."Posting Date" := ItemJournalLine."Posting Date";
                            MRPMaster.MRP := TRUE;
                            //MRPMaster."MRP Price" := SalesPrice."MRP Price";
                            MRPMaster."Stock Transfer Price" := SalesPrice."Transfer Price";
                            MRPMaster."Unit Of Measure" := SalesPrice."Unit of Measure Code";
                            MRPMaster."Sales price" := SalesPrice."Unit Price";
                            MRPMaster."Assessable Value" := SalesPrice."Assessable Value";
                            MRPMaster."National Discount" := SalesPrice."National Discount";   //EBT0002
                            MRPMaster."Price Support" := SalesPrice."Price Support";//RSPL-CAS-03500-H4N0R8

                            //EBT STIVAN ---(16102012)--- To Update the Qty per UOM Field in MRP Master Table--------START
                            MRPMaster."Qty. per Unit of Measure" := ItemUOMEBT."Qty. per Unit of Measure";
                            //EBT STIVAN ---(16102012)--- To Update the Qty per UOM Field in MRP Master Table----------END
                            MRPMaster.INSERT;
                        END;
                    END;
                END;
            END; // radhesh end
        END;
        //EBTMRP0001
    END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertTransferEntry', '', false, false)]
    local procedure Trnline(var ItemJournalLine: Record "Item Journal Line"; var NewItemLedgerEntry: Record "Item Ledger Entry"; var OldItemLedgerEntry: Record "Item Ledger Entry")
    var
        TransLine: Record "Transfer Line";
    begin
        TransLine.GET(ItemJournalLine."Order No.", ItemJournalLine."Document Line No.");
        TransLine."Lot No." := NewItemLedgerEntry."Lot No.";//RSPL
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnPostOutputOnBeforePostItem', '', false, false)]
    local procedure checkingQC(var ItemJournalLine: Record "Item Journal Line"; var ProdOrderLine: Record "Prod. Order Line")
    var
        ProdOrder: Record 5405;
        ProdOrderLine1: Record "Prod. Order Line";
        ItemRec: Record Item;
        MRPMaster: Record "50013";
        SalesPrice: Record "7002";
        ItemVersionParameter: Record "50015";
        QCCertificate: Record "50016";
        MRPMaster1: Record "50013";
        QCCertificate1: Record "50016";
        CreateMRPMaster: Boolean;
        ItemUOMEBT: Record "5404";
    begin
        //EBT/QC Func/0001
        ProdOrder.RESET;
        ProdOrder.SETRANGE(ProdOrder.Status, ProdOrder.Status::Released);
        ProdOrder.SETRANGE(ProdOrder."No.", ItemJournalLine."Document No.");
        IF ProdOrder.FINDFIRST THEN BEGIN
            ProdOrderLine1.RESET;
            ProdOrderLine1.SETRANGE(ProdOrderLine1."Prod. Order No.", ProdOrder."No.");
            //EBT STIVAN ---(27122012)---QC Should not be Mandatory for CAPCON Location------START
            ProdOrderLine1.SETFILTER(ProdOrderLine1."Location Code", '%1', 'CAPCON');
            //EBT STIVAN ---(27122012)---QC Should not be Mandatory for CAPCON Location--------END
            IF ProdOrderLine1.FINDFIRST THEN
                REPEAT
                    ItemRec.GET(ProdOrderLine1."Item No.");
                    IF ItemRec."QC Applicable" THEN
                        ProdOrder.TESTFIELD(ProdOrder."QC Tested");
                UNTIL ProdOrderLine1.NEXT = 0;
        END;
        //EBT/QC Func/0001

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeOnRun', '', false, false)]
    local procedure CheckOnbefore(var TransferHeader: Record "Transfer Header")
    var
        RecLocNew: Record Location;
        RecTL: Record "Transfer Line";
        RecDetGSTEntBuff: Record "Detailed GST Entry Buffer";
        TransLine: Record "Transfer Line";
        recLocation: Record Location;
        TL18: Record "Transfer Line";
        InvtSetup: Record "Inventory Setup";

    begin
        TransferHeader.TESTFIELD(Status, TransferHeader.Status::Released);  //EBT STIVAN (17/04/2013)-Error Message Pop is Status is not Released
        TransferHeader.TESTFIELD(TransferHeader."Shipment Method Code");//RSPLSUM 10Nov2020
        //RSPLSUM BEGIN>>
        IF (TransferHeader."Transfer-from Code" <> 'CAPCON') AND (TransferHeader."Transfer-to Code" <> 'CAPCON') THEN BEGIN//RSPLSUM 12Dec2020
            RecLocNew.RESET;
            IF RecLocNew.GET(TransferHeader."Transfer-from Code") THEN BEGIN
                IF RecLocNew."Location Type" <> RecLocNew."Location Type"::Bonded THEN BEGIN
                    RecTL.RESET;
                    RecTL.SETRANGE("Document No.", TransferHeader."No.");
                    RecTL.SETFILTER("Inventory Posting Group", '%1', 'BULK');
                    IF NOT RecTL.FINDFIRST THEN BEGIN
                        RecDetGSTEntBuff.RESET;
                        RecDetGSTEntBuff.SETRANGE("Transaction Type", RecDetGSTEntBuff."Transaction Type"::Transfer);
                        RecDetGSTEntBuff.SETRANGE("Document Type", RecDetGSTEntBuff."Document Type"::Quote);
                        RecDetGSTEntBuff.SETRANGE("Document No.", TransferHeader."No.");
                        IF NOT RecDetGSTEntBuff.FINDFIRST THEN
                            ERROR('Detailed GST Entry Buffer does not exist, Please calculate structure values.');
                    END;
                END;
            END;
        END;//RSPLSUM 12Dec2020
            //RSPLSUM END<<
            //EBT/LOCALINTERCITY/0001
        recLocation.RESET;
        recLocation.SETRANGE(recLocation.Code, TransferHeader."Transfer-from Code");
        IF recLocation.FINDFIRST THEN
            IF (recLocation."Require Receive" = FALSE) OR (recLocation."Require Shipment" = FALSE) THEN
                IF (TransferHeader."Transport Type" = 0) THEN
                    ERROR('You must specify the Transport Type');

        //EBT::For change dimension::start
        //>>18May2017
        TL18.RESET; //18May2017
        TL18.SETRANGE("Document No.", TransferHeader."No."); //18May2017
        IF TL18.FINDFIRST THEN //18May2017
            REPEAT //18May2017
                IF TL18."Inventory Posting Group" <> 'MERCH' THEN //18May2017
                BEGIN //18May2017

                    IF (TransferHeader."Frieght Type" = TransferHeader."Frieght Type"::PAID) OR
                     (TransferHeader."Frieght Type" = TransferHeader."Frieght Type"::"PAY & ADD IN BILL") OR
                     (TransferHeader."Frieght Type" = TransferHeader."Frieght Type"::"TO PAY") THEN BEGIN

                        IF TransferHeader."Transport Type" = TransferHeader."Transport Type"::Intercity THEN BEGIN
                            IF TransferHeader."Expected TPT Cost" = 0 THEN
                                ERROR('Please Specify Expected TPT Cost');

                            IF TransferHeader."Vehicle Capacity" = '' THEN
                                ERROR('Please Specify Vehical Capacity');
                        END;

                        IF TransferHeader."Transport Type" = TransferHeader."Transport Type"::"Local+Intercity" THEN BEGIN
                            IF TransferHeader."Expected TPT Cost" = 0 THEN
                                ERROR('Please Specify Expected TPT Cost');

                            IF TransferHeader."Vehicle Capacity" = '' THEN
                                ERROR('Please Specify Vehical Capacity');

                            IF TransferHeader."Local Expected TPT Cost" = 0 THEN
                                ERROR('Please Specify Local Expected TPT Cost');

                            IF TransferHeader."Local Vehicle Capacity" = '' THEN
                                ERROR('Please Specify Local Vehical Capacity');

                        END;

                    END;
                END;//18May2017

            UNTIL TL18.NEXT = 0; //18May2017
                                 //<<18May2017

        recLocation.GET(TransferHeader."Transfer-from Code");
        InvtSetup.GET;
        InvtSetup."Updating Dimension While Post" := TRUE;
        InvtSetup.MODIFY;
        //VALIDATE("Shortcut Dimension 1 Code",recLocation."Global Dimension 1 Code");  //TC RSPL
        TransferHeader.VALIDATE("Shortcut Dimension 2 Code", recLocation."Global Dimension 2 Code");
        InvtSetup.GET;
        InvtSetup."Updating Dimension While Post" := FALSE;
        InvtSetup.MODIFY;
        // recGateEntryLoc.RESET;
        // recGateEntryLoc.SETRANGE("Entry Type", recGateEntryLoc."Entry Type"::Outward);
        // recGateEntryLoc.SETRANGE("Location Code", "Transfer-from Code");
        // IF recGateEntryLoc.FINDFIRST THEN
        //     IF recGateEntryLoc."Posting No. Series" = '' THEN
        //         ERROR('No.series does not exist in Gate Entry - Location setup against Outward:%1', "Transfer-from Code");
        // //EBT/LOCALINTERCITY/0001



    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptHeader', '', false, false)]
    local procedure OnbegoreshpInsert(TransHeader: Record "Transfer Header"; var TransShptHeader: Record "Transfer Shipment Header")
    var
        recPostedGateEntry: Record "Posted Gate Entry Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    //recGateLocSetup:Record
    begin
        //EBT STIVAN ---(04052012)--- To Capture Transporter Name in Shipment------------START
        TransShptHeader."Transporter Name" := TransHeader."Transporter Name";
        //EBT STIVAN ---(04052012)--- To Capture Transporter Name in Shipment--------------END
        //EBT STIVAN ---(29052012)--- To Capture Transfer Indent No in Shipment------------START
        TransShptHeader."Transfer Indent No." := TransHeader."Transfer Indent No";
        //EBT STIVAN ---(29052012)--- To Capture Transfer Indent No in Shipment--------------END

        TransShptHeader."Distance in kms" := TransHeader."Distance in kms";//DJ 17/03/20
        TransShptHeader."EWB Transaction Type" := TransHeader."EWB Transaction Type";//RSPLSUM 23Jun2020
                                                                                     //EBT STIVAN ---(29062012)--- To Update the Form Code in Transfer Shipment Header -----START
                                                                                     //TransShptHeader."Form Code" := TransHeader."Form Code";
                                                                                     //EBT STIVAN ---(29062012)--- To Update the Form Code in Transfer Shipment Header -------END

        //EBT STIVAN--(05122012)--To Update BRT PRINT TIME-----------START
        TransShptHeader."BRT Print Time" := TIME;
        //EBT STIVAN--(05122012)--To Update BRT PRINT TIME-------------END

        //EBT STIVAN--(11122012)--To Update Road Permit No-----------START
        TransShptHeader."Road Permit No." := TransHeader."Road Permit No.";
        //EBT STIVAN--(11122012)--To Update Road Permit No-------------END

        //EBT STIVAN--(21062013)--To Update Expected TPT Cost-----------START
        TransShptHeader."Expected TPT Cost" := TransHeader."Expected TPT Cost";
        //EBT STIVAN--(21062013)--To Update Expected TPT Cost-------------END

        //EBT STIVAN--(31072013)--To Update Local Expected TPT Cost-----------START
        TransShptHeader."Local Expected TPT Cost" := TransHeader."Local Expected TPT Cost";
        //EBT STIVAN--(31072013)--To Update Local Expected TPT Cost-------------END

        //EBT STIVAN--(23072013)--To Update Freight Type-----------START
        TransShptHeader."Frieght Type" := TransHeader."Frieght Type";
        //EBT STIVAN--(23072013)--To Update Freight Type-------------END

        //EBT/LOCALINTERCITY/0001
        // IF TransHeader."Transport Type" = TransHeader."Transport Type"::Intercity THEN BEGIN
        //     IF TransHeader."Transfer-from Code" <> 'PLANT01' THEN BEGIN
        //         recPostedGateEntry.RESET;
        //         recPostedGateEntry.INIT;
        //         recPostedGateEntry."Entry Type" := recPostedGateEntry."Entry Type"::Outward;
        //         recGateLocSetup.GET(1, TransHeader."Transfer-from Code");
        //         recPostedGateEntry."No. Series" := recGateLocSetup."Posting No. Series";
        //         recPostedGateEntry."No." := NoSeriesMgt.GetNextNo(recGateLocSetup."Posting No. Series", TransHeader."Posting Date", TRUE);
        //         recPostedGateEntry."Gate Entry No." := TransShptHeader."No.";
        //         recPostedGateEntry."Location Code" := TransHeader."Transfer-from Code";
        //         recPostedGateEntry."LR/RR No." := TransHeader."LR/RR No.";
        //         recPostedGateEntry."LR/RR Date" := TransHeader."LR/RR Date";
        //         recPostedGateEntry.Transporter := TransHeader."Shipping Agent Code";
        //         recPostedGateEntry."Posting Date" := TODAY;
        //         recPostedGateEntry."Posting Time" := TIME;
        //         recPostedGateEntry."Vehicle No." := TransHeader."Vehicle No.";
        //         recPostedGateEntry."Driver's Name" := TransHeader."Driver's Name";
        //         recPostedGateEntry."Driver's License No." := TransHeader."Driver's License No.";
        //         recPostedGateEntry."Driver's Mobile No." := TransHeader."Driver's Mobile No.";
        //         recPostedGateEntry."Vehicle Capacity" := TransHeader."Vehicle Capacity";
        //         recPostedGateEntry.INSERT;
        //     END;
        //     TransHeader."LR/RR No." := '';
        //     TransHeader."LR/RR Date" := 0D;
        //     TransHeader."Vehicle No." := '';
        //     TransHeader."Driver's Name" := '';
        //     TransHeader."Driver's License No." := '';
        //     TransHeader."Driver's Mobile No." := '';
        //     TransHeader."Vehicle Capacity" := '';

        // END;
        // IF TransHeader."Transport Type" = TransHeader."Transport Type"::"Local+Intercity" THEN BEGIN
        //     IF TransHeader."Transfer-from Code" <> 'PLANT01' THEN BEGIN
        //         recPostedGateEntry.RESET;
        //         recPostedGateEntry.INIT;
        //         recPostedGateEntry."Entry Type" := recPostedGateEntry."Entry Type"::Outward;
        //         recGateLocSetup.GET(1, TransHeader."Transfer-from Code");
        //         recPostedGateEntry."No. Series" := recGateLocSetup."Posting No. Series";
        //         recPostedGateEntry."No." := NoSeriesMgt.GetNextNo(recGateLocSetup."Posting No. Series", TransHeader."Posting Date", TRUE);
        //         recPostedGateEntry."Gate Entry No." := TransHeader."No.";
        //         recPostedGateEntry."Location Code" := TransHeader."Transfer-from Code";
        //         recPostedGateEntry."LR/RR No." := TransHeader."Local LR No.";
        //         recPostedGateEntry."LR/RR Date" := TransHeader."Local LR Date";
        //         recPostedGateEntry.Transporter := TransHeader."Shipping Agent Code";
        //         recPostedGateEntry."Posting Date" := TODAY;
        //         recPostedGateEntry."Posting Time" := TIME;
        //         recPostedGateEntry."Vehicle No." := TransHeader."Local Vehicle No.";
        //         recPostedGateEntry."Driver's Name" := TransHeader."Local Driver's Name";
        //         recPostedGateEntry."Driver's License No." := TransHeader."Local Driver's License No.";
        //         recPostedGateEntry."Driver's Mobile No." := TransHeader."Local Driver's Mobile No.";
        //         recPostedGateEntry."Vehicle Capacity" := TransHeader."Local Vehicle Capacity";
        //         recPostedGateEntry.INSERT;
        //     END;
        //     TransHeader."Local LR No." := '';
        //     TransHeader."Local LR Date" := 0D;
        //     TransHeader."Local Vehicle No." := '';
        //     TransHeader."Local Driver's Name" := '';
        //     TransHeader."Local Driver's License No." := '';
        //     TransHeader."Local Driver's Mobile No." := '';
        //     TransHeader."Local Vehicle Capacity" := '';
        //     TransHeader."Time In/Out" := 0T;
        //     TransHeader."Empty Vehicle Weight" := 0;
        //     TransHeader."Vehicle Weight After loading" := 0;
        //     TransHeader."Net Weight of the Truck" := 0;
        //     TransHeader."WH Bill Entry No." := '';
        //     TransHeader."Debond Bill Entry No." := '';

        // END;
        // //EBT/LOCALINTERCITY/0001


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptLine', '', false, false)]
    local procedure OnbeforeshpLineInsert(TransLine: Record "Transfer Line"; var TransShptLine: Record "Transfer Shipment Line")
    var
    begin
        TransShptLine."Transfer Indent No." := TransLine."Transfer Indent No.";             //EBT/TROIndent/0001
        TransShptLine."Transfer Indent Line No." := TransLine."Transfer Indent Line No.";   //EBT/TROIndent/0001
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterTransferOrderPostShipment', '', false, false)]
    local procedure Insertingtransfer(var TransferHeader: Record "Transfer Header"; var TransferShipmentHeader: Record "Transfer Shipment Header")
    var
        transtorespcenter: Record Location;
        transfromrespcenter: Record Location;
        recTransportDetails: Record 50020;
        TransShptLine: Record "Transfer Shipment Line";
        UOMTrans: Text;
        recShippingAgent: Record "Shipping Agent";
        recvendor: Record Vendor;
        recLoc: Record Location;
        recTSL: Record "Transfer Shipment Line";
        recTrnsfShpmnLine: Record "Transfer Shipment Line";
        Item: Record Item;
        ItemUOM: Record "Item Unit of Measure";
        RecILE: Record "Item Ledger Entry";
        RecILE1: Record "Item Ledger Entry";
    begin
        //EBT STIVAN ---(10/06/2013)---Code to Update the Transport Details Table------------------------START
        //EBT MILAN -----(070214)-----Not to post in transport detail if resp. center is same------------START
        transtorespcenter.RESET;
        transtorespcenter.SETRANGE(transtorespcenter.Code, TransferShipmentHeader."Transfer-from Code");
        IF transtorespcenter.FINDFIRST THEN;

        transfromrespcenter.RESET;
        transfromrespcenter.SETRANGE(transfromrespcenter.Code, TransferShipmentHeader."Transfer-to Code");
        IF transfromrespcenter.FINDFIRST THEN;

        IF transtorespcenter."Global Dimension 2 Code" <> transfromrespcenter."Global Dimension 2 Code" THEN BEGIN

            IF NOT ((TransferShipmentHeader."Transfer-from Code" = 'CAPCON') OR
                       (TransferShipmentHeader."Transfer-to Code" = 'CAPCON') OR
                       //RSPL-Sourav010415
                       (TransferShipmentHeader."Transfer-from Code" = 'INVADJ0001') OR (TransferShipmentHeader."Transfer-to Code" = 'INVADJ0001')) THEN
               //RSPL-Sourav010415
               BEGIN
                recTransportDetails.RESET;
                recTransportDetails.SETRANGE(recTransportDetails."Invoice No.", TransferShipmentHeader."No.");
                IF NOT (recTransportDetails.FINDFIRST) THEN BEGIN

                    recTransportDetails."Invoice No." := TransferShipmentHeader."No.";
                    recTransportDetails."Invoice Date" := TransferShipmentHeader."Posting Date";
                    recTransportDetails."Shortcut Dimension 1 Code" := TransferShipmentHeader."Shortcut Dimension 1 Code";
                    TransShptLine.RESET;
                    TransShptLine.SETRANGE(TransShptLine."Document No.", TransferShipmentHeader."No.");
                    IF TransShptLine.FINDFIRST THEN BEGIN
                        IF (TransShptLine."Unit of Measure" = 'LTRS') OR (TransShptLine."Unit of Measure" = 'KGS') THEN
                            UOMTrans := TransShptLine."Unit of Measure"
                        ELSE
                            UOMTrans := '';
                    END;
                    recTransportDetails.UOM := UOMTrans;
                    recTransportDetails.Type := recTransportDetails.Type::Transfer;


                    IF TransferShipmentHeader."Transport Type" = TransferShipmentHeader."Transport Type"::Intercity THEN BEGIN
                        recTransportDetails."LR No." := TransferShipmentHeader."LR/RR No.";
                        recTransportDetails."LR Date" := TransferShipmentHeader."LR/RR Date";
                        recTransportDetails."Vehicle No." := TransferShipmentHeader."Vehicle No.";
                    END;

                    IF TransferShipmentHeader."Transport Type" = TransferShipmentHeader."Transport Type"::"Local+Intercity" THEN BEGIN
                        //recTransportDetails."LR No." := TransferShipmentHeader."Local LR No.";
                        //recTransportDetails."LR Date" := TransferShipmentHeader."Local LR Date";
                        //recTransportDetails."Vehicle No." := TransferShipmentHeader."Local Vehicle No.";
                        recTransportDetails."Local LR No." := TransferShipmentHeader."Local LR No.";
                        recTransportDetails."Local LR Date" := TransferShipmentHeader."Local LR Date";
                        recTransportDetails."Local Vehicle No." := TransferShipmentHeader."Local Vehicle No.";

                        //recTransportDetails."Local Shipment Agent Code" := TransferShipmentHeader."Shipping Agent Code";

                        //recShippingAgent.RESET;
                        //recShippingAgent.SETRANGE(recShippingAgent.Code,TransferShipmentHeader."Shipping Agent Code");
                        //IF recShippingAgent.FINDFIRST THEN
                        //BEGIN
                        // recTransportDetails."Local Shipment Agent Name" := recShippingAgent.Name;
                        //END;
                    END;

                    IF NOT ((TransferShipmentHeader."Transport Type" = TransferShipmentHeader."Transport Type"::Intercity) OR
                             (TransferShipmentHeader."Transport Type" = TransferShipmentHeader."Transport Type"::"Local+Intercity")) THEN BEGIN
                        recTransportDetails."LR No." := '';
                        recTransportDetails."LR Date" := 0D;
                        recTransportDetails."Vehicle No." := '';
                        recTransportDetails."Local LR No." := '';
                        recTransportDetails."Local LR Date" := 0D;
                        recTransportDetails."Local Vehicle No." := '';
                    END;

                    recTransportDetails."Shipping Agent Code" := TransferShipmentHeader."Shipping Agent Code";

                    recShippingAgent.RESET;
                    recShippingAgent.SETRANGE(recShippingAgent.Code, TransferShipmentHeader."Shipping Agent Code");
                    IF recShippingAgent.FINDFIRST THEN BEGIN
                        recTransportDetails."Shipping Agent Name" := recShippingAgent.Name;
                    END;

                    IF (TransferShipmentHeader."Shipping Agent Code" <> '') THEN BEGIN
                        recvendor.RESET;
                        recvendor.SETRANGE(recvendor."Shipping Agent Code", TransferShipmentHeader."Shipping Agent Code");
                        IF recvendor.FINDFIRST THEN BEGIN
                            recTransportDetails."Vendor Code" := recvendor."No.";
                            recTransportDetails."Vendor Name" := recvendor."Full Name";
                        END;
                    END;

                    recTransportDetails."From Location Code" := TransferShipmentHeader."Transfer-from Code";

                    recLoc.RESET;
                    recLoc.SETRANGE(recLoc.Code, TransferShipmentHeader."Transfer-from Code");
                    IF recLoc.FINDFIRST THEN BEGIN
                        recTransportDetails."From Location Name" := recLoc.Name;
                    END;

                    recTransportDetails.Destination := TransferHeader."Transfer-to Name";   // EBT MILAN 270214

                    recTransportDetails."Expected TPT Cost" := TransferShipmentHeader."Expected TPT Cost";

                    recTransportDetails."Local Expected TPT Cost" := TransferShipmentHeader."Local Expected TPT Cost";

                    //RSPLSUM 12July2019>>
                    recTransportDetails."Expected Loading" := TransferHeader."Expected Loading";
                    recTransportDetails."Expetced Unloading" := TransferHeader."Expected Unloading";
                    //RSPLSUM 12July2019>>

                    // EBT MILAN 171213
                    recTransportDetails."Vehicle Capacity" := TransferShipmentHeader."Vehicle Capacity";
                    recTransportDetails."Local Vehicle Capacity" := TransferShipmentHeader."Local Vehicle Capacity";

                    recTSL.RESET;
                    recTSL.SETRANGE(recTSL."Document No.", TransferShipmentHeader."No.");
                    recTSL.SETFILTER(recTSL.Quantity, '<>%1', 0);
                    IF recTSL.FINDFIRST THEN
                        REPEAT
                            recTransportDetails.Quantity += recTSL."Quantity (Base)";
                        UNTIL recTSL.NEXT = 0;

                    //>> RB-N 14Nov2017 Transport Details---No. of Packs
                    recTSL.RESET;
                    recTSL.SETRANGE(recTSL."Document No.", TransferShipmentHeader."No.");
                    recTSL.SETFILTER(recTSL.Quantity, '<>%1', 0);
                    IF recTSL.FINDFIRST THEN
                        REPEAT
                            recTransportDetails."No. of Packs" += recTSL.Quantity;
                        UNTIL recTSL.NEXT = 0;
                    //>> RB-N 14Nov2017 Transport Details---No. of Packs



                    recTransportDetails."To Location Code" := TransferShipmentHeader."Transfer-to Code";

                    recLoc.RESET;
                    recLoc.SETRANGE(recLoc.Code, TransferShipmentHeader."Transfer-to Code");
                    IF recLoc.FINDFIRST THEN BEGIN
                        recTransportDetails."To Location Name" := recLoc.Name;
                    END;

                    recTransportDetails."Freight Type" := TransferShipmentHeader."Frieght Type";
                    recTransportDetails.Open := TRUE;
                    recTransportDetails.INSERT;
                END;
            END;
        END;
        //EBT STIVAN ---(10/06/2013)---Code to Update the Transport Details Table--------------------------END
        //RSPL-CAS-07045-Y1L4CB
        recTransportDetails.RESET;
        recTransportDetails.SETRANGE(recTransportDetails."Invoice No.", TransferShipmentHeader."No.");
        IF (recTransportDetails.FINDFIRST) THEN BEGIN

            recTrnsfShpmnLine.RESET;
            recTrnsfShpmnLine.SETRANGE("Document No.", TransferShipmentHeader."No.");
            IF recTrnsfShpmnLine.FINDSET THEN
                REPEAT
                    IF Item.GET(recTrnsfShpmnLine."Item No.") THEN BEGIN
                        IF Item."Base Unit of Measure" = 'LTRS' THEN BEGIN
                            ItemUOM.RESET;
                            ItemUOM.SETRANGE(ItemUOM."Item No.", recTrnsfShpmnLine."Item No.");
                            ItemUOM.SETRANGE(ItemUOM.Code, recTrnsfShpmnLine."Unit of Measure Code");
                            IF ItemUOM.FINDFIRST THEN BEGIN
                                recTransportDetails."Quantity in Ltrs." += recTrnsfShpmnLine.Quantity * ItemUOM."Qty. per Unit of Measure";
                                RecILE.RESET;
                                RecILE.SETRANGE(RecILE."Item No.", recTrnsfShpmnLine."Item No.");
                                RecILE.SETRANGE(RecILE."Document No.", recTrnsfShpmnLine."Document No.");
                                IF RecILE.FINDSET THEN BEGIN
                                    RecILE1.SETRANGE(RecILE1."Lot No.", RecILE."Lot No.");
                                    RecILE1.SETRANGE(RecILE1."Item No.", RecILE."Item No.");
                                    RecILE1.SETRANGE(RecILE1."Entry Type", RecILE1."Entry Type"::Output);
                                    IF RecILE1.FINDFIRST THEN
                                        recTransportDetails."Total Quantity in(Kg)" += recTrnsfShpmnLine.Quantity * ItemUOM."Qty. per Unit of Measure"
                                        * RecILE1."Density Factor";
                                END;
                            END;
                        END;
                        IF Item."Base Unit of Measure" = 'KGS' THEN BEGIN
                            ItemUOM.RESET;
                            ItemUOM.SETRANGE(ItemUOM."Item No.", recTrnsfShpmnLine."Item No.");
                            ItemUOM.SETRANGE(ItemUOM.Code, recTrnsfShpmnLine."Unit of Measure Code");
                            IF ItemUOM.FINDSET THEN BEGIN
                                recTransportDetails."Quantity in KGS" += recTrnsfShpmnLine.Quantity * ItemUOM."Qty. per Unit of Measure";
                                recTransportDetails."Total Quantity in(Kg)" += recTransportDetails."Quantity in KGS";
                            END;
                        END;
                    END;
                UNTIL recTrnsfShpmnLine.NEXT = 0;
            recTransportDetails.MODIFY;
        END;
        //RSPL-CAS-07045-Y1L4CB
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeOnRun', '', false, false)]
    local procedure Onbeforeruntrrc(var TransferHeader2: Record "Transfer Header")
    var
        AccessControl: Record "Access Control";
        CSOMapping: Record 50006;
        InvtSetup: Record "Inventory Setup";
        RecLocation: Record Location;
    begin
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETRANGE("Role ID", '%1', 'SUPER');
        IF NOT (AccessControl.FINDFIRST) THEN //RSPL-TC -
        BEGIN
            CSOMapping.RESET;
            CSOMapping.SETRANGE(CSOMapping.Type, CSOMapping.Type::Location);
            CSOMapping.SETRANGE(CSOMapping."User Id", USERID);
            CSOMapping.SETRANGE(CSOMapping.Value, TransferHeader2."Transfer-to Code");
            IF NOT (CSOMapping.FINDFIRST) THEN BEGIN
                ERROR('You can not Receive other then your Location');
            END;
        END;
        //EBT::For change dimension::start
        InvtSetup.GET;
        InvtSetup."Updating Dimension While Post" := TRUE;
        InvtSetup.MODIFY;
        RecLocation.GET(TransferHeader2."Transfer-to Code");
        //VALIDATE("Shortcut Dimension 1 Code",RecLocation."Global Dimension 1 Code");  //TC RSPL
        TransferHeader2.VALIDATE("Shortcut Dimension 2 Code", RecLocation."Global Dimension 2 Code");
        InvtSetup.GET;
        InvtSetup."Updating Dimension While Post" := FALSE;
        InvtSetup.MODIFY;

        //EBT::For change dimension::end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeInsertTransRcptHeader', '', false, false)]
    local procedure OnbeforeInsTrRcptHdr(TransHeader: Record "Transfer Header"; var TransRcptHeader: Record "Transfer Receipt Header")
    var
    begin

        //EBT STIVAN ---(29052012)--- To Capture Transfer Indent No in Receipt------------START
        TransRcptHeader."Transfer Indent No." := TransHeader."Transfer Indent No";
        //EBT STIVAN ---(29052012)--- To Capture Transfer Indent No in Receipt--------------END

        //EBT STIVAN--(11122012)--To Update Road Permit No-----------START
        TransRcptHeader."Road Permit No." := TransHeader."Road Permit No.";
        //EBT STIVAN--(11122012)--To Update Road Permit No-----------START

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInitGLEntry', '', false, false)]
    local procedure checkprint(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    var
        pp: Page "Journal Voucher";
    begin
        GLEntry."Check Print Name" := GenJournalLine."Check Print Name"; //SUDIP Please complie removing the comment
        GLEntry."Exp/Purchase Invoice Doc. No." := GenJournalLine."Exp/Purchase Invoice Doc. No."; //SUDIP Please complie removing the commentend;
        GLEntry."Creation Date" := CURRENTDATETIME; // DJ 25Nov2019

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldVendLedgEntry', '', false, false)]
    local procedure checkprintDtvendledet(var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; GenJournalLine: Record "Gen. Journal Line")
    var
    begin
        //EBT STIVAN -(09/04/2012)- For Cheque Printing ---Start
        DtldVendLedgEntry."Check Print Name" := GenJournalLine."Check Print Name"; //SUDIP Please complie removing the comment
        //EBT STIVAN -(09/04/2012)- For Cheque Printing ----END
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitBankAccLedgEntry', '', false, false)]
    local procedure checkprintvend(GenJournalLine: Record "Gen. Journal Line"; var BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    var
        BankVendorLedgerENtry: Record "Vendor Ledger Entry";
        BPDocumentNo: Code[20];
        AppliedDocNo: Code[20];
        EBTVendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        //EBT STIVAN (09042012)---For Check printing-------------------------------------------------------START
        BPDocumentNo := BankAccountLedgerEntry."Document No.";
        BankVendorLedgerENtry.RESET;
        BankVendorLedgerENtry.SETRANGE("Document No.", BPDocumentNo);
        IF BankVendorLedgerENtry.FINDFIRST THEN BEGIN

            EBTVendorLedgerEntry.RESET;
            EBTVendorLedgerEntry.SETRANGE("Entry No.", BankVendorLedgerENtry."Closed by Entry No.");
            IF EBTVendorLedgerEntry.FINDFIRST THEN BEGIN
                AppliedDocNo := EBTVendorLedgerEntry."Applied Bank Payment Doc .No"; //SUDIP Please complie removing the comment
            END;

            IF AppliedDocNo <> '' THEN
                EBTVendorLedgerEntry.RESET;
            EBTVendorLedgerEntry.SETRANGE(EBTVendorLedgerEntry."Applied Bank Payment Doc .No", AppliedDocNo);
            IF EBTVendorLedgerEntry.FINDFIRST THEN
                REPEAT
                    EBTVendorLedgerEntry."Applied Bank Payment Doc .No" := BankVendorLedgerENtry."Document No."; //
                    EBTVendorLedgerEntry.MODIFY;
                UNTIL EBTVendorLedgerEntry.NEXT = 0;


            EBTVendorLedgerEntry.RESET;
            EBTVendorLedgerEntry.SETRANGE("Closed by Entry No.", BankVendorLedgerENtry."Entry No.");
            IF EBTVendorLedgerEntry.FINDFIRST THEN
                REPEAT
                    EBTVendorLedgerEntry."Applied Bank Payment Doc .No" := BankVendorLedgerENtry."Document No.";
                    EBTVendorLedgerEntry.MODIFY;
                UNTIL EBTVendorLedgerEntry.NEXT = 0;

        END;

        //EBT STIVAN (09042012)---For Check printing---------------------------------------------------------END
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostCustOnBeforeInitCustLedgEntry', '', false, false)]
    local procedure checkingcreidnotre(var CustLedgEntry: Record "Cust. Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgEntry."Credit Checking Not Required" := GenJournalLine."Credit Checking Not Required";//RSPLSUM-BUNKER
    end;
    //OnPostLedgerEntryOnBeforeGenJnlPostLine
    //OnPostLedgerEntryOnBeforeGenJnlPostLine 
    // OnBeforePostCustomerEntry
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostCustomerEntry', '', false, false)]
    local procedure UdatingfCustledentry(var GenJnlLine: Record "Gen. Journal Line"; var SalesHeader: Record "Sales Header")
    begin
        GenJnlLine."Credit Checking Not Required" := SalesHeader."Credit Checking Not Required";//RSPLSUM-BUNKER
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'PostCustomerEntry', '', '', false, false)]
    // local procedure UdatingfCustledentry()
    // var
    // begin


    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
    local procedure Udatingfullname(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    var
        recTransportDetails: Record 50020;
        EBTSalesInvLine: Record "Sales Invoice Line";
        UOMTrans: Text;
        recShippingAgent: Record "Shipping Agent";
        recvendor: Record Vendor;
        recLoc: Record Location;
        recSIL: Record "Sales Invoice Line";
        RecSalesInvLine: Record "Sales Invoice Line";
        Item: Record Item;
        ItemUOM: Record "Item Unit of Measure";
        RecSalesInvHeader: Record "Sales Invoice Header";
        ValueEntry: Record "Value Entry";
        rempRecILE: Record "Item Ledger Entry";
        RecSalesShpmntLine: Record "Sales Shipment Line";
        RecILE: Record "Item Ledger Entry";
        RecILE1: Record "Item Ledger Entry";
        RecSIHAddInfo: Record 50054;
        RecSHAddInfo: Record 50053;
        RecSalInvLine: Record "Sales Invoice Line";
        RecSalShipHdr: Record "Sales Shipment Header";
        RecSalesHdr: Record "Sales Header";
        RecDimValueNew: Record 349;
    begin
        //EBT STIVAN ---(02/05/2013)---Code to Update the Transport Details Table------------------------START
        IF (SalesInvHeader."Order No." <> '') AND (SalesInvHeader."Supplimentary Invoice" = FALSE) THEN BEGIN
            recTransportDetails.RESET;
            recTransportDetails.SETRANGE(recTransportDetails."Invoice No.", SalesInvHeader."No.");
            IF NOT (recTransportDetails.FINDFIRST) THEN BEGIN

                recTransportDetails."Invoice No." := SalesInvHeader."No.";
                recTransportDetails."Invoice Date" := SalesInvHeader."Posting Date";
                // EBT MILAN (030214)----TO Update Customer Name in Transport Detail table ----------------------------------START
                recTransportDetails."Customer Name" := SalesInvHeader."Sell-to Customer Name";
                // EBT MILAN (030214)----TO Update Customer Name in Transport Detail table ------------------------------------END
                // EBT MILAN (11122013)----TO Update Dicvision in Transport Detail table in all case-------------------------START
                recTransportDetails."Shortcut Dimension 1 Code" := SalesInvHeader."Shortcut Dimension 1 Code";
                // EBT MILAN (11122013)----TO Update Dicvision in Transport Detail table in all case---------------------------END
                EBTSalesInvLine.RESET;
                EBTSalesInvLine.SETRANGE(EBTSalesInvLine."Document No.", SalesInvHeader."No.");
                EBTSalesInvLine.SETRANGE(EBTSalesInvLine.Type, EBTSalesInvLine.Type::Item);
                IF EBTSalesInvLine.FINDSET THEN
                    REPEAT
                        IF (EBTSalesInvLine."Unit of Measure" = 'Litres') OR (EBTSalesInvLine."Unit of Measure" = 'KGS') THEN BEGIN
                            UOMTrans := EBTSalesInvLine."Unit of Measure"
                        END
                        ELSE
                            UOMTrans := '';
                    UNTIL EBTSalesInvLine.NEXT = 0;
                recTransportDetails.UOM := UOMTrans;
                recTransportDetails.Type := recTransportDetails.Type::Invoice;

                IF SalesInvHeader."Transport Type" = SalesInvHeader."Transport Type"::"Local+Intercity" THEN BEGIN
                    recTransportDetails."LR No." := '';
                    recTransportDetails."LR Date" := 0D;
                    recTransportDetails."Vehicle No." := '';
                    recTransportDetails."Local LR No." := SalesInvHeader."LR/RR No.";
                    recTransportDetails."Local LR Date" := SalesInvHeader."LR/RR Date";
                    recTransportDetails."Local Vehicle No." := SalesInvHeader."Vehicle No.";
                    recTransportDetails."Local Vehicle Capacity" := SalesInvHeader."Local Vehicle Capacity";  // EBT MILAN 171213
                    recTransportDetails."Vehicle Capacity" := SalesInvHeader."Vehicle Capacity";
                    // recTransportDetails."Local Shipment Agent Name" := recShippingAgent.Name;
                    //END;

                END
                ELSE BEGIN
                    recTransportDetails."LR No." := SalesInvHeader."LR/RR No.";
                    recTransportDetails."LR Date" := SalesInvHeader."LR/RR Date";
                    recTransportDetails."Vehicle No." := SalesInvHeader."Vehicle No.";
                    recTransportDetails."Local LR No." := '';
                    recTransportDetails."Local LR Date" := 0D;
                    recTransportDetails."Local Vehicle No." := '';
                    recTransportDetails."Local Vehicle Capacity" := SalesInvHeader."Local Vehicle Capacity";  // EBT MILAN 171213
                    recTransportDetails."Vehicle Capacity" := SalesInvHeader."Vehicle Capacity";

                END;

                recTransportDetails."Shipping Agent Code" := SalesInvHeader."Shipping Agent Code";

                recShippingAgent.RESET;
                recShippingAgent.SETRANGE(recShippingAgent.Code, SalesInvHeader."Shipping Agent Code");
                IF recShippingAgent.FINDFIRST THEN BEGIN
                    recTransportDetails."Shipping Agent Name" := recShippingAgent.Name;
                END;

                IF SalesInvHeader."Shipping Agent Code" <> '' THEN BEGIN
                    recvendor.RESET;
                    recvendor.SETRANGE(recvendor."Shipping Agent Code", SalesInvHeader."Shipping Agent Code");
                    IF recvendor.FINDFIRST THEN BEGIN
                        recTransportDetails."Vendor Code" := recvendor."No.";
                        recTransportDetails."Vendor Name" := recvendor."Full Name";
                    END;
                END;

                recTransportDetails."From Location Code" := SalesInvHeader."Location Code";

                recLoc.RESET;
                recLoc.SETRANGE(recLoc.Code, SalesInvHeader."Location Code");
                IF recLoc.FINDFIRST THEN BEGIN
                    recTransportDetails."From Location Name" := recLoc.Name;
                END;

                recTransportDetails.Destination := SalesInvHeader."Ship-to City";


                recTransportDetails."Expected TPT Cost" := SalesInvHeader."Expected TPT Cost";

                recTransportDetails."Local Expected TPT Cost" := SalesInvHeader."Local Expected TPT Cost";

                //RSPLSUM 12July2019>> 
                recTransportDetails."Expected Loading" := SalesHeader."Expected Loading";
                //RSPLSUM 12July2019<<

                recSIL.RESET;
                recSIL.SETRANGE(recSIL."Document No.", SalesInvHeader."No.");
                recSIL.SETRANGE(recSIL.Type, recSIL.Type::Item);
                recSIL.SETFILTER(recSIL.Quantity, '<>%1', 0);
                IF recSIL.FINDFIRST THEN
                    REPEAT
                        recTransportDetails.Quantity += recSIL."Quantity (Base)";
                    UNTIL recSIL.NEXT = 0;

                //>> RB-N 14Nov2017 Transport Details---No. of Packs
                recSIL.RESET;
                recSIL.SETRANGE(recSIL."Document No.", SalesInvHeader."No.");
                recSIL.SETRANGE(recSIL.Type, recSIL.Type::Item);
                recSIL.SETFILTER(recSIL.Quantity, '<>%1', 0);
                IF recSIL.FINDFIRST THEN
                    REPEAT
                        recTransportDetails."No. of Packs" += recSIL.Quantity;
                    UNTIL recSIL.NEXT = 0;
                //>> RB-N 14Nov2017 Transport Details---No. of Packs


                recTransportDetails."Freight Type" := SalesInvHeader."Freight Type";

                recTransportDetails.Open := TRUE;

                recTransportDetails.INSERT;
            END;


            //RSPL-CAS-07045-Y1L4CB
            recTransportDetails.RESET;
            recTransportDetails.SETRANGE(recTransportDetails."Invoice No.", SalesInvHeader."No.");
            IF recTransportDetails.FINDFIRST THEN BEGIN
                RecSalesInvLine.RESET;
                RecSalesInvLine.SETRANGE(RecSalesInvLine."Document No.", recTransportDetails."Invoice No.");
                IF RecSalesInvLine.FINDSET THEN
                    REPEAT
                        IF Item.GET(RecSalesInvLine."No.") THEN BEGIN
                            IF Item."Base Unit of Measure" = 'LTRS' THEN BEGIN
                                ItemUOM.RESET;
                                ItemUOM.SETRANGE(ItemUOM."Item No.", RecSalesInvLine."No.");
                                ItemUOM.SETRANGE(ItemUOM.Code, RecSalesInvLine."Unit of Measure Code");
                                IF ItemUOM.FINDFIRST THEN
                                    recTransportDetails."Quantity in Ltrs." += RecSalesInvLine.Quantity * ItemUOM."Qty. per Unit of Measure";
                                RecSalesInvHeader.GET(RecSalesInvLine."Document No.");
                                ValueEntry.RESET;
                                ValueEntry.SETCURRENTKEY("Document No.");
                                ValueEntry.SETRANGE("Document No.", RecSalesInvLine."Document No.");
                                ValueEntry.SETRANGE("Document Type", ValueEntry."Document Type"::"Sales Invoice");
                                ValueEntry.SETRANGE("Document Line No.", RecSalesInvLine."Line No.");
                                IF ValueEntry.FINDFIRST THEN
                                    REPEAT
                                        rempRecILE.GET(ValueEntry."Item Ledger Entry No.");
                                        RecSalesShpmntLine.RESET;
                                        RecSalesShpmntLine.SETRANGE(RecSalesShpmntLine."Document No.", rempRecILE."Document No.");
                                        RecSalesShpmntLine.SETRANGE(RecSalesShpmntLine."Line No.", rempRecILE."Document Line No.");
                                        IF RecSalesShpmntLine.FINDSET THEN
                                            REPEAT
                                                RecILE.RESET;
                                                RecILE.SETRANGE(RecILE."Item No.", RecSalesShpmntLine."No.");
                                                RecILE.SETRANGE(RecILE."Document No.", RecSalesShpmntLine."Document No.");
                                                IF RecILE.FINDSET THEN BEGIN
                                                    RecILE1.SETRANGE(RecILE1."Lot No.", RecILE."Lot No.");
                                                    RecILE1.SETRANGE(RecILE1."Item No.", RecILE."Item No.");
                                                    RecILE1.SETRANGE(RecILE1."Entry Type", RecILE1."Entry Type"::Output);
                                                    IF RecILE1.FINDFIRST THEN
                                                        recTransportDetails."Total Quantity in(Kg)" += RecSalesInvLine.Quantity * ItemUOM."Qty. per Unit of Measure"
                                                       * RecILE1."Density Factor";
                                                END;
                                            UNTIL RecSalesShpmntLine.NEXT = 0;
                                    UNTIL ValueEntry.NEXT = 0;
                            END;
                        END;
                    UNTIL RecSalesInvLine.NEXT = 0;
                //RSPL-CAS-07045-Y1L4CB
                RecSalesInvLine.RESET;
                RecSalesInvLine.SETRANGE(RecSalesInvLine."Document No.", recTransportDetails."Invoice No.");
                IF RecSalesInvLine.FINDSET THEN
                    REPEAT
                        Item.RESET;
                        Item.SETRANGE(Item."No.", RecSalesInvLine."No.");
                        IF Item.FINDSET THEN BEGIN
                            IF Item."Base Unit of Measure" = 'KGS' THEN BEGIN
                                ItemUOM.RESET;
                                ItemUOM.SETRANGE(ItemUOM."Item No.", RecSalesInvLine."No.");
                                ItemUOM.SETRANGE(ItemUOM.Code, RecSalesInvLine."Unit of Measure Code");
                                IF ItemUOM.FINDSET THEN BEGIN
                                    recTransportDetails."Quantity in KGS" += RecSalesInvLine.Quantity * ItemUOM."Qty. per Unit of Measure";
                                    recTransportDetails."Total Quantity in(Kg)" += RecSalesInvLine.Quantity * ItemUOM."Qty. per Unit of Measure";
                                END;
                            END;
                        END;
                    UNTIL RecSalesInvLine.NEXT = 0;
                recTransportDetails.MODIFY;
            END;
            //RSPL-CAS-07045-Y1L4CB
        END;

        //RSPLSUM 08May2020>>
        IF SalesInvHeader."Order No." <> '' THEN BEGIN
            RecSIHAddInfo.RESET;
            RecSIHAddInfo.SETRANGE("No.", SalesInvHeader."No.");
            IF NOT (RecSIHAddInfo.FINDFIRST) THEN BEGIN
                RecSHAddInfo.RESET;
                IF RecSHAddInfo.GET(RecSHAddInfo."Document Type"::Order, SalesHeader."No.") THEN BEGIN
                    RecSIHAddInfo.INIT;
                    RecSIHAddInfo.TRANSFERFIELDS(RecSHAddInfo);
                    RecSIHAddInfo."No." := SalesInvHeader."No.";
                    RecSIHAddInfo.INSERT;
                END;
            END;
        END ELSE BEGIN
            RecSalInvLine.RESET;
            RecSalInvLine.SETRANGE(RecSalInvLine."Document No.", SalesInvHeader."No.");
            RecSalInvLine.SETRANGE(RecSalInvLine.Type, RecSalInvLine.Type::Item);
            RecSalInvLine.SETFILTER(RecSalInvLine.Quantity, '<>%1', 0);
            IF RecSalInvLine.FINDFIRST THEN BEGIN
                IF RecSalInvLine."Shipment No." <> '' THEN BEGIN
                    RecSalShipHdr.RESET;
                    RecSalShipHdr.SETRANGE("No.", RecSalInvLine."Shipment No.");
                    RecSalShipHdr.SETFILTER("Order No.", '<>%1', '');
                    IF RecSalShipHdr.FINDFIRST THEN BEGIN
                        RecSalesHdr.RESET;
                        IF RecSalesHdr.GET(RecSalesHdr."Document Type"::Order, RecSalShipHdr."Order No.") THEN BEGIN
                            RecSIHAddInfo.RESET;
                            RecSIHAddInfo.SETRANGE("No.", SalesInvHeader."No.");
                            IF NOT (RecSIHAddInfo.FINDFIRST) THEN BEGIN
                                RecSHAddInfo.RESET;
                                IF RecSHAddInfo.GET(RecSHAddInfo."Document Type"::Order, RecSalesHdr."No.") THEN BEGIN
                                    RecSIHAddInfo.INIT;
                                    RecSIHAddInfo.TRANSFERFIELDS(RecSHAddInfo);
                                    RecSIHAddInfo."No." := SalesInvHeader."No.";
                                    RecSIHAddInfo.INSERT;
                                END;
                            END;
                        END;
                    END;
                END;
            END;
        END;
        //RSPLSUM 08May2020<<

        //RSPLSUM27527 BEGIN>>
        IF (SalesInvHeader."No." <> '') THEN BEGIN
            IF SalesInvHeader."Mintifi Channel Finance" = SalesInvHeader."Mintifi Channel Finance"::Yes THEN BEGIN
                RecDimValueNew.RESET;
                RecDimValueNew.SETRANGE("Dimension Code", 'DIVISION');
                RecDimValueNew.SETRANGE(Code, SalesInvHeader."Shortcut Dimension 1 Code");
                RecDimValueNew.SETFILTER("Mintifi Email", '<>%1', '');
                IF RecDimValueNew.FINDFIRST THEN
                    MintifiEmailNotification(SalesInvHeader);
            END;
        END;
        //RSPLSUM27527 END>>

        //EBT STIVAN ---(02/05/2013)---Code to Update the Transport Details Table--------------------------END

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure Validation(var PurchaseHeader: Record "Purchase Header")
    var
        Ven14: Record Vendor;
        PostedGateEntry: Record "Posted Gate Entry Header";
        EBTPurchaseLine: Record "Purchase Line";
        QCTestResult: Record "QC Test Result";
        GSTAmountLoaded: Decimal;
        GSTCreditAmount: Decimal;
        GSTReverseChargeVendType: Boolean;
        TotalGSTAmount: Decimal;
        GSTStateCode: Code[10];
        TotalGSTAmountLCY: Decimal;
        CustomDuty: Decimal;
        //EBTPurchaseLine: Record "39";
        //QCTestResult: Record "50002";
        //PostedGateEntry: Record "16555";
        TransactionNo: Integer;
        //ServTaxMgmt: Codeunit "Service Tax Management";
        PH: Record "38";
        PL: Record "39";
        Qty2Receive: Decimal;
        PostedCAInvoices: Record "50034";
        recTransportDetails: Record "50020";
        recPIH: Record "122";
        "----------14May2018": Integer;
        //Ven14: Record "23";
        recVendor: Record "23";
        recVendorPostingGroup: Record "93";
        recPurchLine11: Record "39";
        GenBusinessPostingGroup: Record "250";
        HSNSAC: Record "HSN/SAC";
        WhseRcptLine1: Record "7317";
        ExpireDate: Date;
    //GSTApplicationManagement: Codeunit "GST Application Management";
    begin
        //EBT STIVAN ---(31/08/2012)--- Error message POP if Status is not Released ----------START
        PurchaseHeader.TESTFIELD(Status, PurchaseHeader.Status::Released);
        //EBT STIVAN ---(31/08/2012)--- Error message POP if Status is not Released ------------END
        // DJ 170621
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" THEN
            PurchaseHeader.TESTFIELD("Payment Method Code");
        // DJ 170621
        //EBT/ORDERCLOSE/0001
        IF PurchaseHeader.Closed = TRUE THEN
            ERROR('You cannot post a closed order.');
        //EBT/ORDERCLOSE/0001

        //>>14May2018
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice THEN BEGIN
            Ven14.RESET;
            IF Ven14.GET(PurchaseHeader."Buy-from Vendor No.") THEN
                IF Ven14.Transporter THEN BEGIN
                    PurchaseHeader.TESTFIELD("Invoice Received By Finance")
                END;
        END;
        //<<14May2018

        //EBT/QC Func/0001
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order THEN BEGIN
            EBTPurchaseLine.RESET;
            EBTPurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            EBTPurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            EBTPurchaseLine.SETRANGE("QC Applicable", TRUE);
            IF EBTPurchaseLine.FINDSET THEN
                REPEAT
                    //RSPLSUM 25Aug2020--EBTPurchaseLine.TESTFIELD(EBTPurchaseLine."QC Approved");
                    IF EBTPurchaseLine."Quantity Received" = 0 THEN BEGIN
                        QCTestResult.RESET;
                        QCTestResult.SETRANGE("Order No.", EBTPurchaseLine."Document No.");
                        QCTestResult.SETRANGE("Line No.", EBTPurchaseLine."Line No.");
                        IF QCTestResult.FINDFIRST THEN
                            IF QCTestResult."Qty to Approve" < EBTPurchaseLine."Qty. to Receive" THEN;
                        //ERROR('You cannot Receive quantity more than QC Approved quantity');
                    END
                    ELSE
                        IF ((EBTPurchaseLine."Quantity Received" <> 0) AND (EBTPurchaseLine."Qty. to Receive" <> 0)) THEN
                            ERROR('Partial Recieving is not allowed for QC Items.');
                UNTIL EBTPurchaseLine.NEXT = 0;
        END;
        //EBT/QC Func/0001

        //EBT/LR/0001
        IF ((PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) AND PurchaseHeader."LR Details Required") THEN BEGIN
            PurchaseHeader.TESTFIELD("LR Invoice No.");
            PostedGateEntry.RESET;
            PostedGateEntry.SETRANGE(PostedGateEntry."Entry Type", PostedGateEntry."Entry Type"::Outward);
            PostedGateEntry.SETRANGE(PostedGateEntry.Invoice, TRUE);
            PostedGateEntry.SETRANGE(PostedGateEntry."Invoice No.", PurchaseHeader."No.");
            IF NOT PostedGateEntry.FINDFIRST THEN
                ERROR('You have not attached any LR Details for this Transporter Invoice');
        END;
        //EBT/LR/0001
        // //robotdsAM--
        // IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) AND PurchaseHeader.Receive AND PurchaseHeader.Invoice THEN BEGIN
        //     recPurchLine11.RESET;
        //     recPurchLine11.SETRANGE("Document No.", PurchaseHeader."No.");
        //     IF recPurchLine11.FINDFIRST THEN
        //         REPEAT
        //             IF HSNSAC.GET(recPurchLine11."GST Group Code", recPurchLine11."HSN/SAC Code") THEN BEGIN
        //                 IF HSNSAC.Type = HSNSAC.Type::HSN THEN BEGIN
        //                     IF recPurchLine11."Gen. Bus. Posting Group" <> '' THEN BEGIN
        //                         IF GenBusinessPostingGroup.GET(recPurchLine11."Gen. Bus. Posting Group") THEN BEGIN
        //                             IF GenBusinessPostingGroup."TDS Mandatory" THEN BEGIN
        //                                // IF recPurchLine11."TDS Nature of Deduction" = '' THEN
        //                                  //   recPurchLine11.TESTFIELD(recPurchLine11."TDS Nature of Deduction");
        //                             END;
        //                         END;
        //                     END;
        //                 END;
        //             END;
        //         UNTIL recPurchLine11.NEXT = 0;
        // END ELSE
        //     IF ("Document Type" = "Document Type"::Order) AND Invoice THEN BEGIN
        //         recPurchLine11.RESET;
        //         recPurchLine11.SETRANGE("Document No.", "No.");
        //         IF recPurchLine11.FINDFIRST THEN
        //             REPEAT
        //                 IF HSNSAC.GET(recPurchLine11."GST Group Code", recPurchLine11."HSN/SAC Code") THEN BEGIN
        //                     IF HSNSAC.Type = HSNSAC.Type::HSN THEN BEGIN
        //                         IF recPurchLine11."Gen. Bus. Posting Group" <> '' THEN BEGIN
        //                             IF GenBusinessPostingGroup.GET(recPurchLine11."Gen. Bus. Posting Group") THEN BEGIN
        //                                 IF GenBusinessPostingGroup."TDS Mandatory" THEN BEGIN
        //                                     IF recPurchLine11."TDS Nature of Deduction" = '' THEN
        //                                         recPurchLine11.TESTFIELD(recPurchLine11."TDS Nature of Deduction");
        //                                 END;
        //                             END;
        //                         END;
        //                     END;
        //                 END;
        //             UNTIL recPurchLine11.NEXT = 0;
        //     END ELSE
        //         IF ("Document Type" = "Document Type"::Invoice) THEN BEGIN
        //             recPurchLine11.RESET;
        //             recPurchLine11.SETRANGE("Document No.", "No.");
        //             IF recPurchLine11.FINDFIRST THEN
        //                 REPEAT
        //                     IF HSNSAC.GET(recPurchLine11."GST Group Code", recPurchLine11."HSN/SAC Code") THEN BEGIN
        //                         IF HSNSAC.Type = HSNSAC.Type::HSN THEN BEGIN
        //                             IF recPurchLine11."Gen. Bus. Posting Group" <> '' THEN BEGIN
        //                                 IF GenBusinessPostingGroup.GET(recPurchLine11."Gen. Bus. Posting Group") THEN BEGIN
        //                                     IF GenBusinessPostingGroup."TDS Mandatory" THEN BEGIN
        //                                         IF recPurchLine11."TDS Nature of Deduction" = '' THEN
        //                                             recPurchLine11.TESTFIELD(recPurchLine11."TDS Nature of Deduction");
        //                                     END;
        //                                 END;
        //                             END;
        //                         END;
        //                     END;
        //                 UNTIL recPurchLine11.NEXT = 0;
        //         END;
        // //robotdsAM++

        //>>12Jan2018 NewCode as per UNNI SIR
        // IF PurchaseHeader."GST Vendor Type" <> "GST Vendor Type"::Unregistered THEN
        //     GSTApplicationManagement.CheckGSTPurchCrMemoValidations(Rec);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure AfterPostPurcDox(var PurchaseHeader: Record "Purchase Header"; PurchInvHdrNo: Code[20])
    var
        recPIH: Record "Purch. Inv. Header";
        recTransportDetails: Record "Transport Details";
        PostedGateEntry: Record "Posted Gate Entry Header";
    begin
        //EBT STIVAN ---(27/04/2012)--- To Capture the GRN AND INVOICE NO.after Posting --------START

        //EBT STIVAN ---(27/04/2012)--- To Capture the GRN AND INVOICE NO.after Posting ----------END

        //EBT STIVAN---(12062013)---To Update the Applied Document NO,Posted and Open Field in transport Details Table----START
        recPIH.RESET;
        recPIH.SETRANGE(recPIH."No.", PurchInvHdrNo);
        IF recPIH.FINDFIRST THEN BEGIN
            //EBT/LR/0001
            IF PurchaseHeader."LR Details Required" THEN BEGIN
                PostedGateEntry.RESET;
                PostedGateEntry.SETRANGE(PostedGateEntry.Invoice, TRUE);
                PostedGateEntry.SETRANGE(PostedGateEntry."Invoice No.", PurchaseHeader."LR Invoice No.");
                IF PostedGateEntry.FINDSET THEN
                    REPEAT
                        PostedGateEntry.Invoiced := TRUE;
                        PostedGateEntry.MODIFY;
                    UNTIL PostedGateEntry.NEXT = 0;
            END;
            //EBT/LR/0001
            recTransportDetails.RESET;
            recTransportDetails.SETRANGE(recTransportDetails.Applied, TRUE);
            recTransportDetails.SETRANGE(recTransportDetails."Applied Document No.", recPIH."Pre-Assigned No.");
            IF recTransportDetails.FINDFIRST THEN
                REPEAT
                    recTransportDetails."Applied Document No." := recPIH."No.";
                    recTransportDetails.Posted := TRUE;
                    recTransportDetails.Open := FALSE;
                    recTransportDetails.MODIFY;
                UNTIL recTransportDetails.NEXT = 0;
        END;
        //EBT STIVAN---(12062013)---To Update the Applied Document NO,Posted and Open Field in transport Details Table------END

    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', false, false)]
    local procedure updateingpaymentmethodcode(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
        GLEntry."Payment Method Code" := GenJournalLine."Payment Method Code";
        GLEntry."Currency Code" := GenJournalLine."Currency Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeSetBillToCustomerNo', '', false, false)]
    local procedure updateingsalesline(var Cust: Record Customer; var SalesHeader: Record "Sales Header")
    begin
        SalesHeader."RWR Salesperson" := Cust."RWR Salesperson";//YSR30847
    end;


    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure updateingChequedate(GenJournalLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgerEntry."Cheque Date" := GenJournalLine."Cheque Date";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure updateingCheckprin(GenJournalLine: Record "Gen. Journal Line"; var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        VendorLedgerEntry."Check Print Name" := GenJournalLine."Check Print Name";
    end;


    [EventSubscriber(ObjectType::Table, Database::"Bank Account Ledger Entry", 'OnAfterCopyFromGenJnlLine', '', false, false)]
    local procedure updateingCheckprinBnk(GenJournalLine: Record "Gen. Journal Line"; var BankAccountLedgerEntry: Record "Bank Account Ledger Entry")
    begin
        BankAccountLedgerEntry."Check Print Name" := GenJournalLine."Check Print Name";
        //RSPL
        IF BankAccountLedgerEntry."Currency Factor" <> 0 THEN
            BankAccountLedgerEntry."Amount (FCY)" := BankAccountLedgerEntry.Amount / BankAccountLedgerEntry."Currency Factor"
        ELSE
            BankAccountLedgerEntry."Amount (FCY)" := 0;
        //
    end;


    [EventSubscriber(ObjectType::Table, Database::"Invoice Posting Buffer", 'OnBeforePrepareSales', '', false, false)]
    local procedure updateingPresales(var SalesLine: Record "Sales Line"; var InvoicePostingBuffer: Record "Invoice Posting Buffer" temporary)
    begin
        //Sourav
        InvoicePostingBuffer."Price Support" := SalesLine."Price Support Per Ltr" * SalesLine."Qty. to Invoice (Base)";
        //Sourav
    end;



    var
        myInt: Integer;

    LOCAL procedure MintifiEmailNotification(SalesInvHdrP: Record "Sales Invoice Header")
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        Instr: InStream;
        EmailMsg: Codeunit "Email Message";
        EmailObj: Codeunit Email;
        RecipientType: Enum "Email Recipient Type";
        FileName: Text;
        // SMTPMail: Codeunit "400";
        UserSetupRec: Record 91;
        MintifiEmail: Text;
        ServerTempFile: Text;
        FileMgmt: Codeunit 419;
        EmailSent: Label 'Mintifi Email has been sent';
        RecDimVal: Record 349;
        ToEmailID: array[20] of Text[100];
        String: Text[100];
        SubString: Text[5];
        i: Integer;
        j: Integer;
        RecSalesInvHdr: Record 112;
        ReportIndAutoGSTLogo: Report 70077;
        RecCustomer: Record 18;
        CustFullName: Text[105];
    begin


        //SMTPMailSetup.GET;//RSPLSUM02Apr21

        //RSPLSUM27527 BEGIN>>
        //CLEAR(SMTPMail);
        CLEAR(MintifiEmail);

        //ServerTempFile := FileMgmt.ServerTempFileName('pdf');

        RecSalesInvHdr.RESET;
        RecSalesInvHdr.SETRANGE("No.", SalesInvHdrP."No.");
        IF RecSalesInvHdr.FINDFIRST THEN BEGIN
            CLEAR(ReportIndAutoGSTLogo);
            Clear(TempBlob);
            TempBlob.CreateOutStream(OutStr);

            ReportIndAutoGSTLogo.SetParams(RecSalesInvHdr."No.", TRUE);
            //IF ReportIndAutoGSTLogo.SAVEASPDF(ServerTempFile) THEN BEGIN
            if ReportIndAutoGSTLogo.SaveAs('', ReportFormat::Pdf, OutStr) then begin
                //IF REPORT.SAVEASPDF(50077, ServerTempFile, RecSalesInvHdr) THEN BEGIN
                //IF DIALOG.CONFIRM('Do you want to send Mintifi email') THEN BEGIN
                UserSetupRec.RESET;
                IF UserSetupRec.GET(USERID) THEN;

                CLEAR(ToEmailID);
                CLEAR(String);
                RecDimVal.RESET;
                RecDimVal.SETRANGE("Dimension Code", 'DIVISION');
                RecDimVal.SETRANGE(Code, RecSalesInvHdr."Shortcut Dimension 1 Code");
                RecDimVal.SETFILTER("Mintifi Email", '<>%1', '');
                IF RecDimVal.FINDFIRST THEN BEGIN
                    String := RecDimVal."Mintifi Email";
                    SubString := '|';
                    i := 1;

                    WHILE STRPOS(String, SubString) > 0 DO BEGIN
                        ToEmailID[i] := COPYSTR(String, 1, STRPOS(String, SubString) - 1);
                        String := COPYSTR(String, STRPOS(String, SubString) + STRLEN(SubString));
                        i += 1;
                    END;
                END;

                CLEAR(CustFullName);
                RecCustomer.RESET;
                IF RecCustomer.GET(RecSalesInvHdr."Sell-to Customer No.") THEN
                    CustFullName := ' - ' + RecCustomer."Full Name";

                //RSPLSUM 11Jan21--SMTPMail.CreateMessage('',UserSetupRec."E-Mail",String,'Invoice Automotive GST - LOGO1','',TRUE);
                //RSPLSUM02Apr21--SMTPMail.CreateMessage('',UserSetupRec."E-Mail",String,FORMAT(RecSalesInvHdr."No.")+' - '
                //RSPLSUM02Apr21--+FORMAT(RecSalesInvHdr."Sell-to Customer No." + CustFullName),'',TRUE);
                //SMTPMail.CreateMessage('', SMTPMailSetup."User ID", String, FORMAT(RecSalesInvHdr."No.") + ' - '//RSPLSUM02Apr21
                //                      + FORMAT(RecSalesInvHdr."Sell-to Customer No." + CustFullName), '', TRUE);//RSPLSUM02Apr21
                EmailMsg.Create(String, FORMAT(RecSalesInvHdr."No.") + ' - ' + FORMAT(RecSalesInvHdr."Sell-to Customer No." + CustFullName), '', true);
                FOR j := 1 TO i - 1 DO
                    //EmailMsg.AddRecipients(ToEmailID[j]);
                    EmailMsg.AddRecipient(RecipientType::"To", ToEmailID[j]);

                EmailMsg.AppendToBody('Dear Sir/Madam,');
                EmailMsg.AppendToBody('<br><br>');
                EmailMsg.AppendToBody('Mintifi Invoice generated for Document No.= ' + RecSalesInvHdr."No." + ' and Customer No.= ' + RecSalesInvHdr."Sell-to Customer No.");
                EmailMsg.AppendToBody('<br><br>');
                EmailMsg.AppendToBody('<HR>');
                EmailMsg.AppendToBody('This is a system generated mail.');

                //SMTPMail.AddAttachment(ServerTempFile, 'Invoice Automotive GST - LOGO1.pdf');
                TempBlob.CreateInStream(InStr);
                EmailMsg.AddAttachment('Invoice Automotive GST - LOGO1', '.pdf', InStr);
                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
                //SMTPMail.Send;

                //MESSAGE(EmailSent);
                //END;
            END;// ELSE
                //ERROR('Error while saving report as PDF');
        END;
    end;
    //RSPLSUM27527 END<<

}