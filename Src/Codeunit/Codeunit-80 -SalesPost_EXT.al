codeunit 50016 SalesPostExtCstm
{
    trigger OnRun()

    begin

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostSalesDoc, '', false, false)]
    local procedure OnBeforePostSalesDoc(var Sender: Codeunit "Sales-Post"; var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean; var CalledBy: Integer);
    var
        NoSeriesLine: Record "No. Series Line";
        RecNoSeriesLine: Record "No. Series Line";
        Invoice: Boolean;
        // InvoicedSaleLine: Record "Sales Line";
        // InvoicedErr: Label 'This Document is already Posted.';
        RecSLNew: Record "Sales Line";
        RecSaleLines: Record "Sales Line";
        SalesLineEBT: Record "Sales Line";
        totalqty: Decimal;
        totalamt: Decimal;
        Itm24: Record Item;
        SL18: Record "Sales Line";
        SalesSetup1: Record "Sales & Receivables Setup";
        PostingDate: Date;
        PostingDateExists: Boolean;
        ReplacePostingDate: Boolean;
        ReplaceDocumentDate: Boolean;
        SIH26: Record "Sales Invoice Header";
        PostingDate26: Date;
        TempSalesLine: Record "Sales Line" temporary;
        MRPMaster: Record "MRP Master";
        MRPMaster1: Record "MRP Master";
        CreateMRPMaster: Boolean;
    begin
        //EBT/RELEASEBEFOREPOST/0001
        SalesHeader.TESTFIELD(Status, SalesHeader.Status::Released);
        //EBT/RELEASEBEFOREPOST/0001

        //RSPLSUM 12Dec2020>>
        NoSeriesLine.RESET;
        NoSeriesLine.SETCURRENTKEY("Series Code", "Starting Date");
        NoSeriesLine.SETRANGE("Series Code", SalesHeader."Posting No. Series");
        NoSeriesLine.SETRANGE("Starting Date", 0D, WORKDATE);
        IF NoSeriesLine.FINDLAST THEN BEGIN
            RecNoSeriesLine.SETRANGE("Series Code", NoSeriesLine."Series Code");
            RecNoSeriesLine.SETRANGE("Starting Date", NoSeriesLine."Starting Date");
            RecNoSeriesLine.SETRANGE(Open, TRUE);
            IF RecNoSeriesLine.FINDFIRST THEN BEGIN
                IF SalesHeader."Posting Date" < RecNoSeriesLine."Last Date Used" THEN
                    ERROR('You cannot post document before %1', RecNoSeriesLine."Last Date Used");
            END;
        END;
        //RSPLSUM 12Dec2020<<

        //RSPLSUM 09Oct20>>
        IF Invoice AND (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]) THEN BEGIN
            IF SalesHeader."GST Customer Type" = "GST Customer Type"::Export THEN BEGIN
                SalesHeader.TESTFIELD("Bill Of Export No.");
                SalesHeader.TESTFIELD("Bill Of Export Date");
            END;
        END;
        //RSPLSUM 09Oct20<<

        //RSPLSUM 03Dec20>>
        RecSLNew.RESET;//RSPLSUM 05Dec2020>>
        RecSLNew.SETRANGE("Document No.", SalesHeader."No.");
        RecSLNew.SETRANGE("Document Type", SalesHeader."Document Type");
        RecSLNew.SETFILTER(Quantity, '<>%1', 0);
        RecSLNew.SETRANGE("Free of Cost", FALSE);
        IF RecSLNew.FINDFIRST THEN BEGIN//RSPLSUM 05Dec2020<<
            RecSaleLines.RESET;//RSPLSUM 19Dec2020>>
            RecSaleLines.SETRANGE("Document No.", SalesHeader."No.");
            RecSaleLines.SETRANGE("Document Type", SalesHeader."Document Type");
            RecSaleLines.SETFILTER("Inventory Posting Group", '<>%1', 'MERCH');
            IF RecSaleLines.FINDFIRST THEN BEGIN
                //RSPLSUM 19Dec2020<<
                // RecDetGSTEntBuff.RESET;
                // RecDetGSTEntBuff.SETRANGE("Transaction Type", RecDetGSTEntBuff."Transaction Type"::Sales);
                // RecDetGSTEntBuff.SETRANGE("Document Type", "Document Type");
                // RecDetGSTEntBuff.SETRANGE("Document No.", "No.");
                // IF NOT RecDetGSTEntBuff.FINDFIRST THEN
                ERROR('Detailed GST Entry Buffer does not exist, Please calculate structure values.');
            END;
        END;
        //RSPLSUM 03Dec20<<


        //>>03Oct2019
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
            IF SalesHeader."Shortcut Dimension 1 Code" <> 'DIV-14' THEN//RSPLSUM 29May2020
                SalesHeader.TESTFIELD("Shipping Agent Code");
        //<<03Oct2019
        IF SalesHeader."Location Code" <> 'BOND0001' THEN BEGIN
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
                IF NOT SalesHeader."CT3 Order" THEN
                    IF SalesHeader.Trading THEN BEGIN
                        SalesLineEBT.RESET;
                        SalesLineEBT.SETRANGE(SalesLineEBT."Document No.", SalesHeader."No.");
                        SalesLineEBT.SETRANGE(SalesLineEBT.Type, SalesLineEBT.Type::Item);
                        IF SalesLineEBT.FINDSET THEN
                            REPEAT
                                IF ((SalesLineEBT."Lot No." <> '') AND (NOT SalesLineEBT."Structure Calculated")) THEN
                                    ERROR('Structure calculation is pending for Line No. %1', SalesLineEBT."Line No.");
                                IF (SalesLineEBT."Qty. to Ship" <> 0) THEN
                                    IF (SalesLineEBT."Free of Cost" = FALSE) AND (SalesLineEBT."Amount To Customer" = 0) THEN   //RSPL-CAS-04788-L3W7L3
                                        ERROR('Amount To Customer cannot be zero for Line No.%1', SalesLineEBT."Line No.");
                                IF SalesLineEBT."Amount To Customer" < 0 THEN                                             //RSPL-CAS-04788-L3W7L3
                                    ERROR('Amount To Customer cannot be less than zero for Line No.%1', SalesLineEBT."Line No.");

                            UNTIL SalesLineEBT.NEXT = 0;
                    END;
        END;
        //EBT0001
        //EBT0002
        IF SalesHeader."Location Code" <> 'BOND0001' THEN BEGIN
            IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) THEN BEGIN
                SalesLineEBT.RESET;
                SalesLineEBT.SETRANGE(SalesLineEBT."Document No.", SalesHeader."No.");
                SalesLineEBT.SETFILTER(SalesLineEBT."Qty. to Ship", '<>%1', 0);
                IF SalesLineEBT.FINDSET THEN
                    REPEAT
                        //>>24Oct2018
                        Itm24.RESET;
                        IF Itm24.GET(SalesLineEBT."No.") THEN
                            IF Itm24."Item Tracking Code" <> '' THEN BEGIN
                                IF SalesLineEBT."Amount To Customer" < 0 THEN
                                    ERROR('Amount to customer cannot be negetive for Item No. %1', SalesLineEBT."No.");
                                //IF SalesLineEBT."Qty. to Ship" <> 0 THEN
                                IF SalesLineEBT."Lot No." = '' THEN

                                    //mayuri
                                    IF (SalesLineEBT."Inventory Posting Group" = 'AUTOOILS') OR
        (SalesLineEBT."Inventory Posting Group" = 'INDOILS') OR (SalesLineEBT."Inventory Posting Group" = 'BOILS')
        OR (SalesLineEBT."Inventory Posting Group" = 'TOILS') OR (SalesLineEBT."Inventory Posting Group" = 'RPO')
        OR (SalesLineEBT."Inventory Posting Group" = 'REPSOL') THEN
                                        ERROR('Lot No. cannot be blank');
                            END;//24Oct2018
                    UNTIL SalesLineEBT.NEXT = 0;
            END;
        END;
        //EBT/LOCALINTERCITY/0001
        //EBT 0003
        totalqty := 0;
        totalamt := 0;
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order") AND (SalesHeader."Location Code" <> 'PLANT01') THEN BEGIN
            SalesLineEBT.RESET;
            SalesLineEBT.SETRANGE("Document No.", SalesHeader."No.");
            SalesLineEBT.SETRANGE(Type, SalesLineEBT.Type::Item);
            IF SalesLineEBT.FINDSET THEN
                REPEAT
                    totalqty += SalesLineEBT."Return Qty. to Receive";
                    totalamt += SalesLineEBT."Amount To Customer";
                UNTIL SalesLineEBT.NEXT = 0;
            //  IF ((totalamt = 0) OR (totalqty = 0)) THEN

            IF NOT SalesHeader.FOC THEN //RSPL/CUST/FOC/RET001
                IF (totalamt = 0) THEN   // Commented by milan 270214
                    ERROR('Quantity or Value cannot be zero');
        END;
        //EBT 0003

        // EBT MILAN 171213...To Mandatory For Exp TPT Cost and Vehiacle Capacity.........................................START
        //>>18May2017 Allow MERCH Inventory Posting Group as 0 TPT Cost

        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN BEGIN
            SL18.RESET; //18May2017
            SL18.SETRANGE("Document No.", SalesHeader."No."); //18May2017
            IF SL18.FINDFIRST THEN //18May2017
                REPEAT //18May2017
                    IF SL18."Inventory Posting Group" <> 'MERCH' THEN //18May2017
                    BEGIN //18May2017
                        IF (SalesHeader."Freight Type" = SalesHeader."Freight Type"::PAID) OR (SalesHeader."Freight Type" = SalesHeader."Freight Type"::"PAY & ADD IN BILL") THEN BEGIN
                            IF SalesHeader."Transport Type" = SalesHeader."Transport Type"::Intercity THEN BEGIN
                                IF SalesHeader."Expected TPT Cost" = 0 THEN
                                    ERROR('Please Specify Expected TPT Cost');

                                IF SalesHeader."Vehicle Capacity" = '' THEN
                                    ERROR('Please Specify Vehical Capacity');
                            END;

                            IF SalesHeader."Transport Type" = SalesHeader."Transport Type"::"Local+Intercity" THEN BEGIN
                                IF SalesHeader."Expected TPT Cost" = 0 THEN
                                    ERROR('Please Specify Expected TPT Cost');

                                IF SalesHeader."Vehicle Capacity" = '' THEN
                                    ERROR('Please Specify Vehical Capacity');

                                IF SalesHeader."Local Expected TPT Cost" = 0 THEN
                                    ERROR('Please Specify Local Expected TPT Cost');

                                IF SalesHeader."Local Vehicle Capacity" = '' THEN
                                    ERROR('Please Specify Local Vehical Capacity');
                            END;
                        END;
                    END;
                UNTIL SL18.NEXT = 0; //18May2017
        END; //18May2017


        //<<18May2017
        // EBT MILAN 171213...To Mandatory For Exp TPT Cost and Vehiacle Capacity...........................................END

        // recGateEntryLoc.RESET;
        // recGateEntryLoc.SETRANGE("Entry Type", recGateEntryLoc."Entry Type"::Outward);
        // recGateEntryLoc.SETRANGE("Location Code", "Location Code");
        // IF recGateEntryLoc.FINDFIRST THEN
        //     IF recGateEntryLoc."Posting No. Series" = '' THEN
        //         ERROR('No.series does not exist in Gate Entry - Location setup against Outward:%1', "Location Code");
        //EBT/LOCALINTERCITY/0001


        //EBT/CANINV/0001
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" THEN BEGIN
            IF SalesHeader."Cancelled Invoice" THEN BEGIN
                SalesSetup1.GET;
                IF SalesHeader."Posting No. Series" = '' THEN
                    SalesHeader."Posting No. Series" := SalesSetup1."Posted Cancelled Invoice Nos.";
                IF SalesHeader."Shipping No. Series" = '' THEN
                    SalesHeader."Shipping No. Series" := SalesSetup1."Posted Cancelled.Shipment Nos.";
                SalesHeader.MODIFY;
            END;
        END;
        //EBT/CANINV/0001
        IF PostingDateExists AND (ReplacePostingDate OR (SalesHeader."Posting Date" = 0D)) THEN BEGIN
            SalesHeader."Posting Date" := PostingDate;
            SalesHeader.VALIDATE("Currency Code");
        END;
        //>>RSPl-Rahul***Code added to catch Posting Date
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) THEN
            IF SalesHeader."Shortcut Dimension 1 Code" <> 'DIV-14' THEN//RSPLSUM 28May2020
                SalesHeader.TESTFIELD("Posting Date", TODAY);
        //<<
        IF PostingDateExists AND (ReplaceDocumentDate OR (SalesHeader."Document Date" = 0D)) THEN
            SalesHeader.VALIDATE("Document Date", PostingDate);


        //>>26July2017 SalesReturnOrder
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order") AND (SalesHeader."Applies-to Doc. No." <> '') THEN BEGIN
            CLEAR(PostingDate26);
            SIH26.RESET;
            SIH26.SETCURRENTKEY("No.");
            SIH26.SETRANGE("No.", SalesHeader."Applies-to Doc. No.");
            IF SIH26.FINDFIRST THEN BEGIN
                PostingDate26 := SIH26."Posting Date";
            END;
        END;

        IF (SalesHeader."Document Type" <> SalesHeader."Document Type"::"Return Order") THEN
            PostingDate26 := SalesHeader."Posting Date";
        //<<26July2017 SalesReturnOrder

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterInsertReturnReceiptHeader, '', false, false)]
    local procedure OnAfterInsertReturnReceipt(var SalesHeader: Record "Sales Header"; var ReturnReceiptHeader: Record "Return Receipt Header");

    var
        CreateMRPMaster: Boolean;
        TempSalesLine: Record "Sales Line" temporary;
        MRPMaster: Record "MRP Master";
        MRPMaster1: Record "MRP Master";
        SalesInvLine: Record "Sales Invoice Line";
        ItemJnlLine: Record "Item Journal Line";
    begin

        //EBT 0002
        IF SalesHeader."Last Year Sales Return" THEN BEGIN
            CreateMRPMaster := FALSE;
            IF TempSalesLine."Qty. per Unit of Measure" <= 25 THEN
                CreateMRPMaster := TRUE;
            IF TempSalesLine."Qty. per Unit of Measure" = 1 THEN
                CreateMRPMaster := FALSE;
            IF CreateMRPMaster THEN BEGIN
                IF (TempSalesLine."Inventory Posting Group" = 'AUTOOILS')
                OR (TempSalesLine."Inventory Posting Group" = 'REPSOL') THEN//RSPL-Sourav091215
                BEGIN
                    MRPMaster.RESET;
                    MRPMaster.SETRANGE(MRPMaster."Item No.", TempSalesLine."No.");
                    MRPMaster.SETRANGE(MRPMaster."Lot No.", TempSalesLine."Lot No.");
                    IF NOT MRPMaster.FINDFIRST THEN BEGIN
                        MRPMaster1.INIT;
                        MRPMaster1."Item No." := TempSalesLine."No.";
                        MRPMaster1."Lot No." := TempSalesLine."Lot No.";
                        MRPMaster1."Posting Date" := TODAY;
                        MRPMaster1.MRP := TRUE;
                        //  MRPMaster1."MRP Price" := TempSalesLine."MRP Price";
                        //  MRPMaster1."Stock Transfer Price" := TempSalesLine."Assessable Value" * TempSalesLine."Qty. per Unit of Measure";
                        MRPMaster1."Unit Of Measure" := TempSalesLine."Unit of Measure Code";
                        MRPMaster1."Sales price" := TempSalesLine."Unit Price Per Lt" * TempSalesLine."Qty. per Unit of Measure";
                        // MRPMaster1."Assessable Value" := TempSalesLine."Assessable Value";
                        MRPMaster1."Qty. per Unit of Measure" := TempSalesLine."Qty. per Unit of Measure";
                        MRPMaster1.INSERT;
                    END;
                END;
            END;
        END;
        //EBT 0002

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPurchRcptHeaderInsert, '', false, false)]
    local procedure OnAfterPurchRcptHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; PurchaseHeader: Record "Purchase Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean);

    var
        PurchOrderLine: Record "Purchase Line";
        DropShipPostBuffer: Record "Drop Shpt. Post. Buffer";
        RecSalesInvLine: Record "Sales Invoice Line";
        vtotPriceSupport: Decimal;
        GenJnlLineDocNo: Code[20];

    begin

        PurchOrderLine."Qty. to Receive" := DropShipPostBuffer.Quantity;
        PurchOrderLine."Qty. to Receive (Base)" := DropShipPostBuffer."Quantity (Base)";

        //RSPL-Sourav
        vtotPriceSupport := 0;
        RecSalesInvLine.RESET;
        RecSalesInvLine.SETRANGE("Document No.", GenJnlLineDocNo);
        RecSalesInvLine.SETFILTER("Price Support Per Ltr", '<>%1', 0);
        IF RecSalesInvLine.FINDSET THEN
            REPEAT
                vtotPriceSupport := RecSalesInvLine."Price Support Per Ltr" * RecSalesInvLine."Quantity (Base)";
                RecSalesInvLine."Price Support Amount" := vtotPriceSupport;
                RecSalesInvLine.MODIFY;
            UNTIL RecSalesInvLine.NEXT = 0;
        //RSPL-Sourav

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostItemJnlLine, '', false, false)]
    local procedure OnBeforePostItemJnlLine(var Sender: Codeunit "Sales-Post"; SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var QtyToBeShipped: Decimal; var QtyToBeShippedBase: Decimal; var QtyToBeInvoiced: Decimal; var QtyToBeInvoicedBase: Decimal; var ItemLedgShptEntryNo: Integer; var ItemChargeNo: Code[20]; var TrackingSpecification: Record "Tracking Specification"; var IsATO: Boolean; CommitIsSuppressed: Boolean; var IsHandled: Boolean; var Result: Integer; var TempTrackingSpecification: Record "Tracking Specification" temporary; var TempHandlingSpecification: Record "Tracking Specification" temporary; var TempValueEntryRelation: Record "Value Entry Relation" temporary; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line");

    var
        GenJnlLine: Record "Gen. Journal Line";
        InvPostingBuffer: array[2] of Record "Invoice Posting Buffer" temporary;
        Dim1: Code[10];
        Dim2: Code[10];
        GLSetupEBT: Record "General Ledger Setup";
        SrcCode: code[10];
        GenJnlLineDocNo: Code[20];
        GenJnlLineExtDocNo: Code[50];
        GenJnlLineDocType: Integer;
        RefundAcc: Boolean;
        TotalGSTAmount: Decimal;
        TotalGSTAmountLCY: Decimal;
        TotalSalesLine: Decimal;
        SalesInvHeader: Record "Sales Invoice Header";
        recTransportDetails: Record "Transport Details";
        EBTSalesInvLine: Record "Sales Invoice Line";
        UOMTrans: Text[20];
        recShippingAgent: Record "Shipping Agent";
        recvendor: Record Vendor;
        recLoc: Record Location;
        recSIL: Record "Sales Invoice Line";
        RecSalesInvLine: Record "Sales Invoice Line";
        Item: Record 27;
        ItemUOM: Record "Item Unit of Measure";
        RecSalesInvHeader: Record "Sales Invoice Header";
        ValueEntry: Record "Value Entry";
        RecSalesShpmntLine: Record "Sales Shipment Line";
        RecILE: Record "Item Ledger Entry";
        RecILE1: Record "Item Ledger Entry";
        rempRecILE: Record "Item Ledger Entry";
        RecSIHAddInfo: Record "Sales Invoice Header- Add Info";
        RecSHAddInfo: Record "Sales Invoice Header- Add Info";
        RecSalInvLine: Record "Sales Invoice Line";
        RecSalShipHdr: Record "Sales Shipment Header";
        RecSalesHdr: Record "Sales Header";
        RecDimValueNew: Record "Dimension Value";
        Invoice: Boolean;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin

        //GenJnlLine.Amount := InvPostingBuffer[1].Amount;  //RSPL
        // Transport Subsidy Discount added to sales    //TSD12042012
        GenJnlLine.Amount := InvPostingBuffer[1].Amount + InvPostingBuffer[1]."Transport Subsidy (%)" + InvPostingBuffer[1]."Price Support"; //EBT;//RSPL

        //------------EBT-------------------------
        Dim1 := GenJnlLine."Shortcut Dimension 1 Code";
        //------------EBT-------------------------
        Dim2 := GenJnlLine."Shortcut Dimension 2 Code";


        GenJnlLine."IC Partner Code" := SalesHeader."Sell-to IC Partner Code";

        //RSPL-Sourav-------------------------------------
        IF InvPostingBuffer[1]."Price Support" <> 0 THEN BEGIN
            GenJnlLine.INIT;
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Posting Date" := SalesHeader."Posting Date";
            GenJnlLine."Document Date" := SalesHeader."Document Date";
            //  GenJnlLine."Document Type" := GenJnlLineDocType;
            GenJnlLine.VALIDATE("Account No.", '75003040');
            GenJnlLine.VALIDATE(GenJnlLine.Amount, InvPostingBuffer[1]."Price Support" * -1);
            GenJnlLine."System-Created Entry" := TRUE;
            GenJnlLine.Description := SalesHeader."Posting Description";
            GenJnlLine."Reason Code" := SalesHeader."Reason Code";
            GenJnlLine."Document No." := GenJnlLineDocNo;
            GenJnlLine."External Document No." := GenJnlLineExtDocNo;
            GenJnlLine."Source Currency Code" := SalesHeader."Currency Code";
            GenJnlLine."Source Code" := SrcCode;
            GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", InvPostingBuffer[1]."Global Dimension 1 Code");
            GenJnlLine.VALIDATE("Shortcut Dimension 2 Code", InvPostingBuffer[1]."Global Dimension 2 Code");
            GenJnlLine."Dimension Set ID" := InvPostingBuffer[1]."Dimension Set ID";
            //RunGenJnlPostLine(GenJnlLine,InvPostingBuffer[1]."Dimension Entry No.");  //RSPL-TC
            // RunGenJnlPostLine(GenJnlLine); //RSPL-TC
        END;
        //--------------------------------------------------------------------------

        //----------Post Transport Subsidy Discount In Diffrent account  --------EBT TSD12042012----------------------
        IF InvPostingBuffer[1]."Transport Subsidy (%)" <> 0 THEN BEGIN
            GLSetupEBT.RESET;
            GLSetupEBT.FINDFIRST;
            GLSetupEBT.TESTFIELD(GLSetupEBT."Transport Subsidy Acc");
            GenJnlLine.INIT;
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."Posting Date" := SalesHeader."Posting Date";
            GenJnlLine."Document Date" := SalesHeader."Document Date";
            //  GenJnlLine."Document Type" := GenJnlLineDocType;
            GenJnlLine.VALIDATE("Account No.", GLSetupEBT."Transport Subsidy Acc");
            GenJnlLine.VALIDATE(GenJnlLine.Amount, -1 * InvPostingBuffer[1]."Transport Subsidy (%)");
            GenJnlLine."System-Created Entry" := TRUE;
            GenJnlLine.Description := SalesHeader."Posting Description";
            GenJnlLine."Reason Code" := SalesHeader."Reason Code";
            GenJnlLine."Document No." := GenJnlLineDocNo;
            GenJnlLine."External Document No." := GenJnlLineExtDocNo;
            GenJnlLine."Source Currency Code" := SalesHeader."Currency Code";
            GenJnlLine."Source Code" := SrcCode;
            GenJnlLine."Shortcut Dimension 1 Code" := InvPostingBuffer[1]."Global Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := InvPostingBuffer[1]."Global Dimension 2 Code";
            GenJnlLine."Dimension Set ID" := InvPostingBuffer[1]."Dimension Set ID";
            //RunGenJnlPostLine(GenJnlLine,InvPostingBuffer[1]."Dimension Entry No."); //RSPL-TC
            //RunGenJnlPostLine(GenJnlLine); //RSPL-TC
        END;
        //--------------------------------------------------------------------------

        // GenJnlLine."Job No." := "Job No.";
        // GenJnlLine."Gen. Posting Type" := 0;

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
        END;
        //EBT STIVAN ---(02/05/2013)---Code to Update the Transport Details Table--------------------------END

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

        //RSPLSUM 08May2020>>
        IF SalesInvHeader."Order No." <> '' THEN BEGIN
            RecSIHAddInfo.RESET;
            RecSIHAddInfo.SETRANGE("No.", SalesInvHeader."No.");
            IF NOT (RecSIHAddInfo.FINDFIRST) THEN BEGIN
                RecSHAddInfo.RESET;
                IF RecSHAddInfo.GET(RecSHAddInfo."Pre-Document Type"::Order, SalesHeader."No.") THEN BEGIN
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
                                IF RecSHAddInfo.GET(RecSHAddInfo."Pre-Document Type"::Order, RecSalesHdr."No.") THEN BEGIN
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
        IF (Invoice) AND (SalesInvHeader."No." <> '') THEN BEGIN
            IF SalesInvHeader."Mintifi Channel Finance" = SalesInvHeader."Mintifi Channel Finance"::Yes THEN BEGIN
                RecDimValueNew.RESET;
                RecDimValueNew.SETRANGE("Dimension Code", 'DIVISION');
                RecDimValueNew.SETRANGE(Code, SalesInvHeader."Shortcut Dimension 1 Code");
                RecDimValueNew.SETFILTER("Mintifi Email", '<>%1', '');
                //  IF RecDimValueNew.FINDFIRST THEN
                //   MintifiEmailNotification(SalesInvHeader);  /// start with new smtp
            END;
        END;
        //RSPLSUM27527 END>>

        //EBT STIVAN ---(26/07/2012)--- To Capture the Credit Memo NO. after Posting --------START
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN BEGIN
            MESSAGE('Credit Memo No Posted is %1', SalesCrMemoHeader."No.")
        END;
        //EBT STIVAN ---(26/07/2012)--- To Capture the Credit Memo NO. after Posting ----------END

        //EBT STIVAN ---(26/07/2012)--- To Capture the Debit Memo NO. after Posting --------START
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) AND (SalesHeader."Supplimentary Invoice" = FALSE) THEN BEGIN
            MESSAGE('Debit Memo No Posted is %1', SalesInvHeader."No.")
        END;
        //EBT STIVAN ---(26/07/2012)--- To Capture the Debit Memo NO. after Posting ----------END

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostItemJnlLine, '', false, false)]
    local procedure OnAfterPostItemJnlLine(var Sender: Codeunit "Sales-Post"; var ItemJournalLine: Record "Item Journal Line"; SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; var WhseJnlPostLine: Codeunit "Whse. Jnl.-Register Line"; OriginalItemJnlLine: Record "Item Journal Line"; var ItemShptEntryNo: Integer; IsATO: Boolean; var TempHandlingSpecification: Record "Tracking Specification"; var TempATOTrackingSpecification: Record "Tracking Specification"; TempWarehouseJournalLine: Record "Warehouse Journal Line" temporary; ShouldPostItemJnlLine: Boolean);
    var
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforeInsertInvoiceHeader, '', false, false)]
    local procedure OnBeforeInsertInvoiceHeader(SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header"; var IsHandled: Boolean);
    var

        SalesShptHeader: Record "Sales Shipment Header";
    begin

        //EBT STIVAN--(11122012)--To Update Road Permit No-----------START
        SalesShptHeader."Road Permit No." := SalesHeader."Road Permit No.";
        //EBT STIVAN--(11122012)--To Update Road Permit No-------------END


    end;




    var
        myInt: Integer;

}