codeunit 50019 PurchasePostExtCstm
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePostPurchaseDoc, '', false, false)]
    local procedure OnBeforePostPurchaseDoc(var Sender: Codeunit "Purch.-Post"; var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var HideProgressWindow: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; var IsHandled: Boolean);
    begin

        //EBT STIVAN ---(31/08/2012)--- Error message POP if Status is not Released ----------START
        PurchaseHeader.TESTFIELD(Status, PurchaseHeader.Status::Released);
        //EBT STIVAN ---(31/08/2012)--- Error message POP if Status is not Released ------------END
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePostCommitPurchaseDoc, '', false, false)]
    local procedure OnBeforePostCommitPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; ModifyHeader: Boolean; var CommitIsSupressed: Boolean; var TempPurchLineGlobal: Record "Purchase Line" temporary);

    var
        PurchLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        Ven14: Record Vendor;
        EBTPurchaseLine: Record "Purchase Line";
        QCTestResult: Record "QC Test Result";
        PostedGateEntry: Record "Posted Gate Entry Header";
        recPurchLine11: Record "Purchase Line";
        HSNSAC: Record "HSN/SAC";
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        //  GSTApplicationManagement: Codeunit 
        SalesOrderLine: Record "Sales Line";
        Text002: Label 'A drop shipment from a purchase order cannot be received and invoiced at the same time.';
        Text003: Label 'You cannot invoice this purchase order before the associated sales orders have been invoiced. ';
        Text004: Label 'Please invoice sales order %1 before invoicing this purchase order.';
        Receive: Boolean;
        Invoice: Boolean;

    begin

        // DJ 170621
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" THEN
            PurchaseHeader.TESTFIELD("Payment Method Code");
        // DJ 170621
        //EBT/ORDERCLOSE/0001
        IF PurchHeader.Closed = TRUE THEN
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


        //robotdsAM--
        IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) AND Receive AND Invoice THEN BEGIN
            recPurchLine11.RESET;
            recPurchLine11.SETRANGE("Document No.", PurchaseHeader."No.");
            IF recPurchLine11.FINDFIRST THEN
                REPEAT
                    IF HSNSAC.GET(recPurchLine11."GST Group Code", recPurchLine11."HSN/SAC Code") THEN BEGIN
                        IF HSNSAC.Type = HSNSAC.Type::HSN THEN BEGIN
                            IF recPurchLine11."Gen. Bus. Posting Group" <> '' THEN BEGIN
                                IF GenBusinessPostingGroup.GET(recPurchLine11."Gen. Bus. Posting Group") THEN BEGIN
                                    IF GenBusinessPostingGroup."TDS Mandatory" THEN BEGIN
                                        //  IF recPurchLine11."TDS Nature of Deduction" ='' THEN
                                        //    recPurchLine11.TESTFIELD(recPurchLine11."TDS Nature of Deduction");
                                    END;
                                END;
                            END;
                        END;
                    END;
                UNTIL recPurchLine11.NEXT = 0;
        END ELSE
            IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) AND Invoice THEN BEGIN
                recPurchLine11.RESET;
                recPurchLine11.SETRANGE("Document No.", PurchaseHeader."No.");
                IF recPurchLine11.FINDFIRST THEN
                    REPEAT
                        IF HSNSAC.GET(recPurchLine11."GST Group Code", recPurchLine11."HSN/SAC Code") THEN BEGIN
                            IF HSNSAC.Type = HSNSAC.Type::HSN THEN BEGIN
                                IF recPurchLine11."Gen. Bus. Posting Group" <> '' THEN BEGIN
                                    IF GenBusinessPostingGroup.GET(recPurchLine11."Gen. Bus. Posting Group") THEN BEGIN
                                        IF GenBusinessPostingGroup."TDS Mandatory" THEN BEGIN
                                            //  IF recPurchLine11."TDS Nature of Deduction" ='' THEN
                                            //    recPurchLine11.TESTFIELD(recPurchLine11."TDS Nature of Deduction");
                                        END;
                                    END;
                                END;
                            END;
                        END;
                    UNTIL recPurchLine11.NEXT = 0;
            END ELSE
                IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) THEN BEGIN
                    recPurchLine11.RESET;
                    recPurchLine11.SETRANGE("Document No.", PurchaseHeader."No.");
                    IF recPurchLine11.FINDFIRST THEN
                        REPEAT
                            IF HSNSAC.GET(recPurchLine11."GST Group Code", recPurchLine11."HSN/SAC Code") THEN BEGIN
                                IF HSNSAC.Type = HSNSAC.Type::HSN THEN BEGIN
                                    IF recPurchLine11."Gen. Bus. Posting Group" <> '' THEN BEGIN
                                        IF GenBusinessPostingGroup.GET(recPurchLine11."Gen. Bus. Posting Group") THEN BEGIN
                                            IF GenBusinessPostingGroup."TDS Mandatory" THEN BEGIN
                                                //  IF recPurchLine11."TDS Nature of Deduction" ='' THEN
                                                //   recPurchLine11.TESTFIELD(recPurchLine11."TDS Nature of Deduction");
                                            END;
                                        END;
                                    END;
                                END;
                            END;
                        UNTIL recPurchLine11.NEXT = 0;
                END;
        //robotdsAM++

        //GSTApplicationManagement.CheckGSTPurchCrMemoValidations(Rec);
        //>>12Jan2018 NewCode as per UNNI SIR
        //  IF PurchaseHeader."GST Vendor Type" <> "GST Vendor Type"::Unregistered THEN // Manish Pacific
        //    GSTApplicationManagement.CheckGSTPurchCrMemoValidations(PurchaseHeader); // Manish Pacific
        //>>12Jan2018 NewCode as per UNNI SIR

        IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) THEN BEGIN
            PurchLine.RESET;
            PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchLine.SETFILTER("Sales Order Line No.", '<>0');
            IF PurchLine.FINDSET THEN
                REPEAT
                    SalesOrderLine.GET(
                      SalesOrderLine."Document Type"::Order,
                      PurchLine."Sales Order No.", PurchLine."Sales Order Line No.");
                    IF Receive AND
                       Invoice AND
                       (PurchLine."Qty. to Invoice" <> 0) AND
                       (PurchLine."Qty. to Receive" <> 0)
                    THEN
                        ERROR(Text002);
                    IF ABS(PurchLine."Quantity Received" - PurchLine."Quantity Invoiced") <
                       ABS(PurchLine."Qty. to Invoice")
                    THEN BEGIN
                        PurchLine."Qty. to Invoice" := PurchLine."Quantity Received" - PurchLine."Quantity Invoiced";
                        PurchLine."Qty. to Invoice (Base)" := PurchLine."Qty. Received (Base)" - PurchLine."Qty. Invoiced (Base)";
                    END;
                    IF ABS(PurchLine.Quantity - (PurchLine."Qty. to Invoice" + PurchLine."Quantity Invoiced")) <
                       ABS(SalesOrderLine.Quantity - SalesOrderLine."Quantity Invoiced")
                    THEN
                        ERROR(
                          Text003 +
                          Text004,
                          PurchLine."Sales Order No.");
                UNTIL PurchLine.NEXT = 0;
        END;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterPostPurchaseDoc, '', false, false)]
    local procedure OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean);

    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        recPIH: Record "Purch. Inv. Header";
        recTransportDetails: Record "Transport Details";
        ItemJnlLine: Record "Item Journal Line";
        ExpireDate: Date;
    begin

        //EBT STIVAN ---(27/04/2012)--- To Capture the GRN AND INVOICE NO.after Posting --------START
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order THEN
            MESSAGE('GRN No Posted is %1', PurchRcptHeader."No.");

        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice THEN
            MESSAGE('Invoice No Posted is %1', PurchInvHeader."No.");

        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" THEN//RSPLSUM 11Aug2020
            MESSAGE('Credit Memo No Posted is %1', PurchCrMemoHeader."No.");//RSPLSUM 11Aug2020

        //EBT STIVAN ---(27/04/2012)--- To Capture the GRN AND INVOICE NO.after Posting ----------END

        //EBT STIVAN---(12062013)---To Update the Applied Document NO,Posted and Open Field in transport Details Table----START
        recPIH.RESET;
        recPIH.SETRANGE(recPIH."No.", PurchInvHeader."No.");
        IF recPIH.FINDFIRST THEN BEGIN
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



        //RSPLAM30180 ++
        ItemJnlLine."Expire Date" := ExpireDate;
        //RSPLAM30180 --

    end;




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterInsertInvoiceHeader, '', false, false)]
    local procedure OnAfterInsertInvoiceHeader(var PurchaseHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header");
    var
        PostedGateEntry: Record "Posted Gate Entry Header";
    begin
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

    end;





    var
        myInt: Integer;
}