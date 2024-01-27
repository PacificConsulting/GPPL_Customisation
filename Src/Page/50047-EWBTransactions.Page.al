// page 50047 "EWB - Transactions"
// {
//     Caption = 'EWB - Transactions';
//     DelayedInsert = false;
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     Permissions = TableData 18005 = rm;
//     SourceTable = 18005;

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Entry No."; rec."Entry No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Document No."; rec."Document No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Document Type"; rec."Document Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Transaction Type"; rec."Transaction Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("GST Base Amount"; rec."GST Base Amount")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Source Type"; rec."Source Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Source No."; rec."Source No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("User ID"; rec."User ID")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Source Code"; rec."Source Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Reason Code"; rec."Reason Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Purchase Group Type"; rec."Purchase Group Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Transaction No."; rec."Transaction No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("External Document No."; rec."External Document No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("GST Component Code"; rec."GST Component Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("GST on Advance Payment"; rec."GST on Advance Payment")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Reverse Charge"; rec."Reverse Charge")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("GST Amount"; rec."GST Amount")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Currency Code"; rec."Currency Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Currency Factor"; rec."Currency Factor")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Reversed; rec.Reversed)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Reversed Entry No."; rec."Reversed Entry No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Reversed by Entry No."; rec."Reversed by Entry No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(UnApplied; rec.UnApplied)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Entry Type"; rec."Entry Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Payment Type"; rec."Payment Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Input Service Distribution"; rec."Input Service Distribution")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Availment; rec.Availment)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Account No."; rec."Account No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Bal. Account No."; rec."Bal. Account No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Bal. Account No. 2"; rec."Bal. Account No. 2")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Account No. 2"; rec."Account No. 2")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("E-Way Bill No."; rec."E-Way Bill No.")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group("Demo - E-Way Bill")
//             {
//                 Caption = 'Demo - E-Way Bill';
//                 action("Generate E-Way Bill")
//                 {
//                     Image = AddWatch;
//                     InFooterBar = true;
//                     Promoted = true;
//                     PromotedIsBig = true;
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         alert: Text;
//                         ewayBillDate: Text;
//                         ewayBillNo: Text;
//                         validUpto: Text;
//                         GSTLedgerEntry: Record "Detailed GST Ledger Entry";
//                         ShippingAgent: Record 291;
//                         SalInvHead: Record 112;
//                         RecTrShipHdr: Record 5744;
//                         RecLocation: Record 14;
//                     begin
//                         CLEARALL;
//                         //AKT_EWB 10202020
//                         DetailedGSTLedgerEntry1.RESET;
//                         DetailedGSTLedgerEntry1.SETRANGE("Document No.", "Document No.");
//                         DetailedGSTLedgerEntry1.SETRANGE("Document Type", Rec."Document Type");
//                         IF DetailedGSTLedgerEntry1.FINDFIRST THEN BEGIN
//                             GSTRegNo := DetailedGSTLedgerEntry1."Location  Reg. No.";
//                         END;
//                         //AKT_EWB 10202020

//                         GeneralLedgerSetup.GET;
//                         LocRec.GET(DetailedGSTLedgerEntry1."Location Code");

//                         /*
//                         cuEwayBill.GenEWB(alert,ewayBillDate,ewayBillNo,validUpto, "Document No.",GSTRegNo,AccessKey
//                                               ,GeneralLedgerSetup."EWB UserName", GeneralLedgerSetup."EWB Password");     //AKT 03102019 Comment
//                         */
//                         TESTFIELD("Distance in kms");//DJ 15042021
//                         cuEwayBill.GenEWB(alert, ewayBillDate, ewayBillNo, validUpto, "Document No.", GSTRegNo, AccessKey
//                                               , LocRec."EWB UserName", LocRec."EWB Password");     //AKT 03102019 Comment


//                         IF ewayBillNo <> '' THEN BEGIN
//                             GSTLedgerEntry.RESET;
//                             GSTLedgerEntry.SETRANGE("Document No.", "Document No.");
//                             GSTLedgerEntry.SETRANGE("Document Type", "Document Type");
//                             GSTLedgerEntry.SETRANGE("Transaction Type", "Transaction Type");
//                             GSTLedgerEntry.MODIFYALL("E-Way Bill No.", ewayBillNo);

//                             DetailedEWayBill.INIT;
//                             DetailedEWayBill."Document No." := "Document No.";
//                             DetailedEWayBill."EWB No." := ewayBillNo;
//                             EVALUATE(DetailedEWayBill."EWB Valid Upto", validUpto);
//                             EVALUATE(DetailedEWayBill."EWB Updated Date", ewayBillDate);
//                             DetailedEWayBill."EWB Creation date" := TODAY;
//                             DetailedEWayBill."Created By User" := USERID;
//                             DetailedEWayBill."GST Ledg. Entry No." := "Entry No.";
//                             IF SalInvHead.GET("Document No.") THEN BEGIN
//                                 DetailedEWayBill."Vehicle No." := SalInvHead."Vehicle No.";
//                                 IF ShippingAgent.GET(SalInvHead."Shipping Agent Code") THEN BEGIN
//                                     DetailedEWayBill."Transporter Code" := ShippingAgent."GST Registration No.";
//                                     DetailedEWayBill."Transporter Name" := ShippingAgent.Name;
//                                 END;
//                                 DetailedEWayBill."Trans. Doc. No." := SalInvHead."LR/RR No.";//RSPLSUM BEGIN>>
//                                 DetailedEWayBill."Trans. Doc. Date" := FORMAT(SalInvHead."LR/RR Date");
//                                 RecLocation.RESET;
//                                 IF RecLocation.GET(SalInvHead."Location Code") THEN
//                                     DetailedEWayBill."From Place" := RecLocation.City;
//                             END ELSE
//                                 IF RecTrShipHdr.GET("Document No.") THEN BEGIN
//                                     DetailedEWayBill."Vehicle No." := RecTrShipHdr."Vehicle No.";
//                                     IF ShippingAgent.GET(RecTrShipHdr."Shipping Agent Code") THEN BEGIN
//                                         DetailedEWayBill."Transporter Code" := ShippingAgent."GST Registration No.";
//                                         DetailedEWayBill."Transporter Name" := ShippingAgent.Name;
//                                     END;
//                                     DetailedEWayBill."Trans. Doc. No." := RecTrShipHdr."LR/RR No.";
//                                     DetailedEWayBill."Trans. Doc. Date" := FORMAT(RecTrShipHdr."LR/RR Date");
//                                     RecLocation.RESET;
//                                     IF RecLocation.GET(RecTrShipHdr."Transfer-from Code") THEN
//                                         DetailedEWayBill."From Place" := RecLocation.City;
//                                 END;//RSPLSUM END<<
//                             DetailedEWayBill.INSERT;
//                         END;

//                     end;
//                 }
//                 action("Generate Consolidate E-Way Bill")
//                 {
//                     Promoted = true;
//                     PromotedCategory = Category7;
//                 }
//             }
//             group(Update)
//             {
//                 Caption = 'Update';
//                 action("Update Vehicle")
//                 {
//                     Image = Timeline;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     var
//                         pgRespectivePage: Page 50017;
//                         "------------": Integer;
//                         "-----------": Integer;
//                         EwbNo: Text;
//                         VehicleNo: Text;
//                         FromPlace: Text;
//                         FromState: Text;
//                         ReasonCode: Text;
//                         ReasonCodeFinal: Text;
//                         ReasonRem: Text;
//                         TransDocNo: Text;
//                         TransDocDate: Date;
//                         TransMode: Option Road,Rail,Air,Ship;
//                         TransModeFinal: Text;
//                         Boolean: Boolean;
//                         VehUpdDate: Text;
//                         VehvalidUpto: Text;
//                         TransShpHead: Record 5744;
//                     begin
//                         CLEARALL;
//                         //EwbNo,VehicleNo,FromPlace,FromState,ReasonCode,ReasonRem,TransDocNo,TransDocDate,TransMode
//                         //AKT_EWB 28082019

//                         SalesInvoiceHeader.RESET;
//                         SalesInvoiceHeader.SETRANGE("No.", TransDocNo);
//                         IF SalesInvoiceHeader.FINDFIRST THEN;

//                         PurchInvoiceHeader.RESET;
//                         PurchInvoiceHeader.SETRANGE("No.", TransDocNo);
//                         IF PurchInvoiceHeader.FINDFIRST THEN;

//                         DetailedGSTLedgerEntry.RESET;
//                         //RSPLSUM--DetailedGSTLedgerEntry.SETRANGE("Entry No.","Entry No.");
//                         //RSPLSUM BEGIN>>
//                         DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
//                         DetailedGSTLedgerEntry.SETRANGE("Document Type", "Document Type");
//                         DetailedGSTLedgerEntry.SETRANGE("Transaction Type", "Transaction Type");
//                         DetailedGSTLedgerEntry.SETRANGE("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
//                         //RSPLSUM END<<
//                         IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
//                             IF DetailedGSTLedgerEntry."Source Type" = DetailedGSTLedgerEntry."Source Type"::Customer THEN BEGIN
//                                 cdShipToCode := SalesInvoiceHeader."Ship-to Code";

//                                 IF cdShipToCode <> '' THEN
//                                     ShipToAddress.GET("Source No.", cdShipToCode)
//                                 ELSE
//                                     Customer.GET("Source No.")
//                             END ELSE
//                                 IF "Source Type" = "Source Type"::Vendor THEN BEGIN
//                                     cdOrderAddressCode := PurchInvoiceHeader."Order Address Code";
//                                     IF cdOrderAddressCode <> '' THEN
//                                         OrderAddress.GET("Source No.", cdOrderAddressCode)
//                                     ELSE
//                                         Vendor.GET("Source No.");

//                                     CompanyInformation.GET;
//                                 END;
//                             IF "Source Type" = "Source Type"::Customer THEN
//                                 IF DetailedGSTLedgerEntry."Location Code" <> '' THEN
//                                     Location.GET(DetailedGSTLedgerEntry."Location Code")
//                                 ELSE
//                                     CompanyInformation.GET;

//                             WITH DetailedGSTLedgerEntry DO BEGIN
//                                 IF "Source Type" = "Source Type"::Vendor THEN BEGIN
//                                     IF recState.GET(Vendor."State Code") THEN;
//                                     //FromPlace := recState."State Code (GST Reg. No.)";//DJ09122020
//                                 END;
//                                 IF "Source Type" = "Source Type"::Customer THEN BEGIN
//                                     IF SalesInvoiceHeader."Ship-to Code" <> '' THEN BEGIN
//                                         recState.GET(ShipToAddress.State);
//                                         //FromPlace := recState."State Code (GST Reg. No.)";
//                                     END ELSE BEGIN
//                                         IF recState.GET(Customer."State Code") THEN;
//                                         //FromPlace := recState."State Code (GST Reg. No.)";//DJ09122020
//                                     END;
//                                 END;
//                             END;
//                             IF recState.GET(DetailedGSTLedgerEntry."Location State Code") THEN;
//                             FromState := recState."State Code (GST Reg. No.)";

//                         END;

//                         GSTLedgerEntry.RESET;
//                         GSTLedgerEntry.SETRANGE("Entry No.", "Entry No.");
//                         IF GSTLedgerEntry.FINDFIRST THEN BEGIN
//                             ReasonCode := FORMAT(GSTLedgerEntry."Reason Code");
//                             ReasonRem := 'vehicle broke down';
//                             //TransDocDate:=  FORMAT(GSTLedgerEntry."Posting Date",10,'<Day,2>/<Month,2>/<Year4>'); // DJ comment 05/08/2020
//                             //TransDocNo:=GSTLedgerEntry."Document No."; // DJ comment 05/08/2020
//                             EwbNo := GSTLedgerEntry."E-Way Bill No.";
//                             IF TransShpHead.GET(GSTLedgerEntry."Document No.") THEN BEGIN
//                                 TransDocDate := TransShpHead."LR/RR Date"; // DJ 05/08/2020
//                                 TransDocNo := TransShpHead."LR/RR No."; // DJ 05/08/2020
//                             END ELSE BEGIN
//                                 SalesInvoiceHeader.RESET;
//                                 SalesInvoiceHeader.SETRANGE("No.", GSTLedgerEntry."Document No.");// DJ 05/08/2020
//                                 //SalesInvoiceHeader.SETRANGE("No.",TransDocNo);// DJ comment 05/08/2020
//                                 IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
//                                     TransDocDate := SalesInvoiceHeader."LR/RR Date"; // DJ 05/08/2020
//                                     TransDocNo := SalesInvoiceHeader."LR/RR No."; // DJ 05/08/2020
//                                     VehicleNo := SalesInvoiceHeader."Vehicle No.";
//                                     IF TransportMethod.GET(SalesInvoiceHeader."Transport Method") THEN;
//                                     TransMode := TransportMethod."Trans Mode";
//                                 END;
//                             END;
//                         END;

//                         pgRespectivePage.SetData(EwbNo, VehicleNo, FromPlace, FromState, ReasonCode, ReasonRem, TransDocNo, TransDocDate, TransMode, "Document No.");

//                         pgRespectivePage.RUNMODAL;
//                     end;
//                 }
//                 action("Update Transporter")
//                 {
//                     Image = "Action";
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     var
//                         pgRespectivePage: Page 50143;
//                         EwbNo: Text;
//                     begin
//                         pgRespectivePage.SetData("E-Way Bill No.", "Document No.");
//                         pgRespectivePage.RUNMODAL;
//                     end;
//                 }
//                 action("Cancel E-Way Bill")
//                 {
//                     Image = CancelLine;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     applicationarea = all;
//                     trigger OnAction()
//                     var
//                         pgRespectivePage: Page 50016;
//                         "------------": Integer;
//                         "-----------": Integer;
//                         EwbNo: Text;
//                         cancelRsnCode: Text;
//                         cancelRmrk: Text;
//                         cancelDate: Text;
//                         ewayBillNo: Text;
//                         cancelRsnCodeFinal: Text;
//                     begin
//                         CLEARALL;

//                         GSTLedgerEntry.RESET;
//                         GSTLedgerEntry.SETRANGE("Entry No.", "Entry No.");
//                         IF GSTLedgerEntry.FINDFIRST THEN BEGIN
//                             cancelRsnCode := GSTLedgerEntry."Reason Code";
//                             EwbNo := GSTLedgerEntry."E-Way Bill No.";
//                             cancelRmrk := '';
//                         END;
//                         //pgRespectivePage.SetData('301001898235','2','Cancelled the order');
//                         pgRespectivePage.SetData(EwbNo, cancelRsnCode, cancelRmrk, "Document No.");
//                         pgRespectivePage.RUNMODAL;
//                     end;
//                 }
//                 action("E-Way Bill Extend Validity")
//                 {
//                     Image = Text;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     applicationarea = all;
//                     applicationarea = all;
//                     trigger OnAction()
//                     var
//                         pgRespectivePage: Page 50018;
//                         "------------": Integer;
//                         "-----------": Integer;
//                         EwbNo: Text;
//                         vehicleNo: Text;
//                         fromPlace: Text;
//                         fromStateCode: Text;
//                         fromState: Text;
//                         remainingDistance: Text;
//                         transDocNo: Text;
//                         transDocDate: Text;
//                         TransMode: Option Road,Rail,Air,Ship;
//                         extnRsnCode: Text;
//                         extnRemarks: Text;
//                         updatedDate: Text;
//                         validUpto: Text;
//                         Vendor: Record 23;
//                         Customer: Record 18;
//                         Location: Record 14;
//                         TransportMethod: Record 259;
//                     begin
//                         //AKT_EWB Add 28082019
//                         CLEARALL;
//                         //AKT_EWB 28082019
//                         DetailedGSTLedgerEntry.RESET;
//                         DetailedGSTLedgerEntry.SETRANGE("Entry No.", rec."Entry No.");
//                         IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
//                             //
//                             //     ,Bill-to Address,Ship-to Address,Location Address
//                             //
//                             CASE DetailedGSTLedgerEntry."GST Place of Supply" OF
//                                 DetailedGSTLedgerEntry."GST Place of Supply"::" ":
//                                     BEGIN
//                                         IF Vendor.GET("Source No.") THEN BEGIN

//                                         END;

//                                     END;
//                                 DetailedGSTLedgerEntry."GST Place of Supply"::"Bill-to Address":
//                                     BEGIN


//                                     END;
//                                 DetailedGSTLedgerEntry."GST Place of Supply"::"Location Address":
//                                     BEGIN


//                                     END;
//                                 DetailedGSTLedgerEntry."GST Place of Supply"::"Ship-to Address":
//                                     BEGIN


//                                     END;
//                             END;


//                             Location.GET(DetailedGSTLedgerEntry."Location Code");
//                             recState.GET(Location."State Code");
//                             //fromPlace := recState."State Code (GST Reg. No.)";
//                             fromState := recState."State Code (GST Reg. No.)";
//                             fromStateCode := fromState;
//                         END;

//                         GSTLedgerEntry.RESET;
//                         GSTLedgerEntry.SETRANGE("Entry No.", "Entry No.");
//                         IF GSTLedgerEntry.FINDFIRST THEN BEGIN
//                             "Reason Code" := GSTLedgerEntry."Reason Code";
//                             transDocDate := FORMAT(GSTLedgerEntry."Posting Date", 10, '<Day,2>/<Month,2>/<Year4>');
//                             //FORMAT(GSTLedgerEntry."Posting Date");
//                             transDocNo := GSTLedgerEntry."Document No.";
//                             EwbNo := GSTLedgerEntry."E-Way Bill No.";

//                             SalesInvoiceHeader.RESET;
//                             SalesInvoiceHeader.SETRANGE("No.", transDocNo);
//                             IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
//                                 vehicleNo := SalesInvoiceHeader."Vehicle No.";
//                                 //transMode:=SalesInvoiceHeader."Transport Method";
//                                 IF TransportMethod.GET(SalesInvoiceHeader."Transport Method") THEN;
//                                 TransMode := TransportMethod."Trans Mode";
//                             END;
//                         END;

//                         //remainingDistance:='30';
//                         //extnRsnCode:='TT';
//                         //extnRemarks:='efghi';

//                         DetailedEWayBill.SETRANGE("Document No.", "Document No.");
//                         DetailedEWayBill.SETRANGE("EWB No.", EwbNo);
//                         IF DetailedEWayBill.FINDLAST THEN
//                             vehicleNo := DetailedEWayBill."Vehicle No.";

//                         pgRespectivePage.SetData(EwbNo, vehicleNo, fromPlace, fromStateCode, fromState, remainingDistance, transDocNo, transDocDate, TransMode, extnRsnCode, extnRemarks, "Document No.");

//                         pgRespectivePage.RUNMODAL;
//                     end;
//                 }
//                 action("Update EWB Detail")
//                 {
//                     Image = timeline;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     var
//                         ewayBillDate: Text;
//                         ewayBillNo: Text;
//                         validUpto: Text;
//                         cuEwayBill: Codeunit 50012;
//                         GSTLedgerEntry: Record 16418;
//                         DetailedEWayBill: Record 50044;
//                         ShipAgent: Record 291;
//                         RecLoc: Record 14;
//                         FromPlace: Text[30];
//                         SalesInvHeader: Record 112;
//                         TransShipHdr: Record 5744;
//                         DocType: Text;
//                         LRNo: Text;
//                         LRDate: Text;
//                         VehicleNo: Text;
//                     begin
//                         CLEAR(FromPlace);
//                         IF SalesInvHeader.GET("Document No.") THEN BEGIN
//                             RecLoc.GET(SalesInvHeader."Location Code");
//                             FromPlace := RecLoc.City;
//                             DocType := 'INV';
//                             IF ShipAgent.GET(SalesInvHeader."Shipping Agent Code") THEN;
//                             LRNo := SalesInvHeader."LR/RR No.";
//                             LRDate := FORMAT(SalesInvHeader."LR/RR Date");
//                             VehicleNo := SalesInvHeader."Vehicle No.";
//                         END ELSE
//                             IF TransShipHdr.GET("Document No.") THEN BEGIN
//                                 RecLoc.GET(TransShipHdr."Transfer-from Code");
//                                 FromPlace := RecLoc.City;
//                                 DocType := 'INV';
//                                 IF ShipAgent.GET(TransShipHdr."Shipping Agent Code") THEN;
//                                 LRNo := TransShipHdr."LR/RR No.";
//                                 LRDate := FORMAT(TransShipHdr."LR/RR Date");
//                                 VehicleNo := TransShipHdr."Vehicle No.";
//                             END;
//                         cuEwayBill.GetEwayBillByDocument("Document No.", DocType, ewayBillNo, ewayBillDate, validUpto, 'GPNAV2016', RecLoc."GST Registration No."
//                         , RecLoc."EWB UserName", RecLoc."EWB Password");

//                         IF ewayBillNo <> '' THEN BEGIN
//                             DetailedEWayBill.INIT;
//                             DetailedEWayBill."Document No." := "Document No.";
//                             DetailedEWayBill."EWB No." := ewayBillNo;
//                             EVALUATE(DetailedEWayBill."EWB Valid Upto", validUpto);
//                             EVALUATE(DetailedEWayBill."EWB Updated Date", ewayBillDate);
//                             DetailedEWayBill."EWB Creation date" := TODAY;
//                             DetailedEWayBill."Created By User" := USERID;
//                             DetailedEWayBill."GST Ledg. Entry No." := "Entry No.";
//                             DetailedEWayBill."Vehicle No." := VehicleNo;
//                             DetailedEWayBill."Transporter Code" := ShipAgent."GST Registration No.";
//                             DetailedEWayBill."Transporter Name" := ShipAgent.Name;
//                             DetailedEWayBill."Trans. Doc. No." := LRNo;//RSPLSUM
//                             DetailedEWayBill."Trans. Doc. Date" := LRDate;//RSPLSUM
//                             DetailedEWayBill."From Place" := FromPlace;//RSPLSUM
//                             IF NOT DetailedEWayBill.INSERT THEN;
//                             GSTLedgerEntry.RESET;
//                             GSTLedgerEntry.SETRANGE("Document No.", "Document No.");
//                             IF GSTLedgerEntry.FINDSET THEN BEGIN
//                                 GSTLedgerEntry.MODIFYALL("E-Way Bill No.", ewayBillNo);
//                             END;
//                         END;
//                         //DJ 26631 24/02/20 END
//                     end;
//                 }
//             }
//             group(UpdateMulti)
//             {
//                 Caption = 'UpdateMulti';
//                 action(InitiateMultiVehicle)
//                 {
//                     Image = Timeline;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     var
//                         pgRespectivePage: Page 50078;
//                         ewbNo: Text;
//                         groupNo: Text;
//                         oldvehicleNo: Text;
//                         newVehicleNo: Text;
//                         oldTranNo: Text;
//                         newTranNo: Text;
//                         fromPlace: Text;
//                         fromState: Text;
//                         reasonCode: Text;
//                         reasonRem: Text;
//                         vehUpdDate: Text;
//                         ToState: Text;
//                         ToPlace: Text;
//                         TotalQty: Text;
//                         TrMode: Text;
//                         UnitCode: Text;
//                         CreatedDate: Text;
//                     begin
//                         CLEARALL;
//                         //EwbNo,VehicleNo,FromPlace,FromState,ReasonCode,ReasonRem,TransDocNo,TransDocDate,TransMode
//                         //AKT_EWB 28082019

//                         SalesInvoiceHeader.RESET;
//                         SalesInvoiceHeader.SETRANGE("No.", newTranNo);    //AKT
//                         IF SalesInvoiceHeader.FINDFIRST THEN;

//                         PurchInvoiceHeader.RESET;
//                         PurchInvoiceHeader.SETRANGE("No.", newTranNo);     //AKT
//                         IF PurchInvoiceHeader.FINDFIRST THEN;

//                         DetailedGSTLedgerEntry.RESET;
//                         //RSPLSUM--DetailedGSTLedgerEntry.SETRANGE("Entry No.","Entry No.");
//                         //RSPLSUM BEGIN>>
//                         DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
//                         DetailedGSTLedgerEntry.SETRANGE("Document Type", "Document Type");
//                         DetailedGSTLedgerEntry.SETRANGE("Transaction Type", "Transaction Type");
//                         DetailedGSTLedgerEntry.SETRANGE("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
//                         //RSPLSUM END<<
//                         IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
//                             IF DetailedGSTLedgerEntry."Source Type" = DetailedGSTLedgerEntry."Source Type"::Customer THEN BEGIN
//                                 cdShipToCode := SalesInvoiceHeader."Ship-to Code";

//                                 IF cdShipToCode <> '' THEN
//                                     ShipToAddress.GET("Source No.", cdShipToCode)
//                                 ELSE
//                                     Customer.GET("Source No.")
//                             END ELSE
//                                 IF "Source Type" = "Source Type"::Vendor THEN BEGIN
//                                     cdOrderAddressCode := PurchInvoiceHeader."Order Address Code";
//                                     IF cdOrderAddressCode <> '' THEN
//                                         OrderAddress.GET("Source No.", cdOrderAddressCode)
//                                     ELSE
//                                         Vendor.GET("Source No.");

//                                     CompanyInformation.GET;
//                                 END;
//                             IF "Source Type" = "Source Type"::Customer THEN
//                                 IF DetailedGSTLedgerEntry."Location Code" <> '' THEN
//                                     Location.GET(DetailedGSTLedgerEntry."Location Code")
//                                 ELSE
//                                     CompanyInformation.GET;

//                             WITH DetailedGSTLedgerEntry DO BEGIN
//                                 IF "Source Type" = "Source Type"::Vendor THEN BEGIN
//                                     IF recState.GET(Vendor."State Code") THEN;
//                                     //fromPlace := recState."State Code (GST Reg. No.)";//DJ09122020
//                                 END;
//                                 IF "Source Type" = "Source Type"::Customer THEN BEGIN
//                                     IF SalesInvoiceHeader."Ship-to Code" <> '' THEN BEGIN
//                                         recState.GET(ShipToAddress.State);
//                                         //fromPlace := recState."State Code (GST Reg. No.)";//DJ09122020
//                                     END ELSE BEGIN
//                                         IF recState.GET(Customer."State Code") THEN;
//                                         //fromPlace := recState."State Code (GST Reg. No.)";//DJ09122020
//                                     END;
//                                 END;
//                             END;
//                             IF recState.GET(DetailedGSTLedgerEntry."Location State Code") THEN;
//                             fromState := recState."State Code (GST Reg. No.)";

//                         END;
//                         //AKT_EWB 25888 21012020
//                         WITH DetailedGSTLedgerEntry DO BEGIN
//                             IF "Source Type" = "Source Type"::Customer THEN BEGIN
//                                 IF SalesInvoiceHeader."Ship-to Code" <> '' THEN BEGIN
//                                     recState.GET(ShipToAddress.State);
//                                     //ToPlace := recState."State Code (GST Reg. No.)";//DJ09122020
//                                 END ELSE BEGIN
//                                     IF recState.GET(Customer."State Code") THEN;
//                                     //ToPlace := recState."State Code (GST Reg. No.)";
//                                 END;
//                             END;
//                         END;
//                         IF recState.GET(DetailedGSTLedgerEntry."Location State Code") THEN;
//                         ToState := recState."State Code (GST Reg. No.)";

//                         SalInvLin.RESET;
//                         SalInvLin.SETRANGE("Document No.", "Document No.");
//                         IF SalInvLin.FINDFIRST THEN BEGIN
//                             TotalQty := FORMAT(SalInvLin.Quantity);
//                             UnitCode := FORMAT(SalInvLin."Unit of Measure Code");

//                         END;
//                         SalInvHd.RESET;
//                         SalInvHd.SETRANGE("No.", "Document No.");
//                         IF SalInvHd.FINDFIRST THEN BEGIN
//                             TrMode := SalInvHd."Mode of Transport";
//                         END;
//                         //AKT_EWB 25888 21012020
//                         //END;


//                         GSTLedgerEntry.RESET;
//                         GSTLedgerEntry.SETRANGE("Entry No.", "Entry No.");
//                         IF GSTLedgerEntry.FINDFIRST THEN BEGIN
//                             reasonCode := FORMAT(GSTLedgerEntry."Reason Code");
//                             reasonRem := 'vehicle broke down';
//                             vehUpdDate := FORMAT(GSTLedgerEntry."Posting Date", 10, '<Day,2>/<Month,2>/<Year4>'); //AKT
//                             newTranNo := GSTLedgerEntry."Document No.";//AKT
//                             ewbNo := GSTLedgerEntry."E-Way Bill No.";
//                             SalesInvoiceHeader.RESET;
//                             SalesInvoiceHeader.SETRANGE("No.", newTranNo); //AKT
//                             IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
//                                 newVehicleNo := SalesInvoiceHeader."Vehicle No.";//AKT
//                                 IF TransportMethod.GET(SalesInvoiceHeader."Transport Method") THEN;
//                                 //TransMode:= TransportMethod."Trans Mode";//AKT
//                             END;
//                         END;
//                         /*groupNo := 'A';
//                         oldvehicleNo :='12345';
//                         oldTranNo :='12';
//                         newVehicleNo :='0';*/
//                         //pgRespectivePage.SetData('361001898233','PQR9877','BANGALORE','29','1','vehicle broke down','1234','12/10/2017' ,'1'); //AKT_EWB Comment 28082019


//                         //pgRespectivePage.SetData(EwbNo,VehicleNo,FromPlace,FromState,ReasonCode,ReasonRem,TransDocNo,TransDocDate,TransMode,"Document No.");     AKT
//                         //pgRespectivePage.SetData(ewbNo,groupNo,newVehicleNo,oldvehicleNo,fromPlace,fromState,reasonCode,reasonRem,oldTranNo,newTranNo,vehUpdDate); //Working fine
//                         pgRespectivePage.SetData(ewbNo, reasonCode, reasonRem, fromPlace, fromState, ToState, ToPlace, TotalQty, TrMode, UnitCode, "Document No.");
//                         pgRespectivePage.RUNMODAL;

//                     end;
//                 }
//                 action(MultivehMovementAddToGroup)
//                 {
//                     Image = Timeline;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     var
//                         pgRespectivePage: Page 50090;
//                         ewbNo: Text;
//                         groupNo: Text;
//                         vehicleNo: Text;
//                         transDocNo: Text;
//                         transDocDate: Text;
//                         quantity: Text;
//                         vehAddedDate: Text;
//                     begin
//                         CLEARALL;
//                         //EwbNo,VehicleNo,FromPlace,FromState,ReasonCode,ReasonRem,TransDocNo,TransDocDate,TransMode
//                         //AKT_EWB 28082019

//                         SalesInvoiceHeader.RESET;
//                         SalesInvoiceHeader.SETRANGE("No.", transDocNo);    //AKT
//                         IF SalesInvoiceHeader.FINDFIRST THEN;

//                         PurchInvoiceHeader.RESET;
//                         PurchInvoiceHeader.SETRANGE("No.", transDocNo);     //AKT
//                         IF PurchInvoiceHeader.FINDFIRST THEN;

//                         DetailedGSTLedgerEntry.RESET;
//                         //RSPLSUM--DetailedGSTLedgerEntry.SETRANGE("Entry No.","Entry No.");
//                         //RSPLSUM BEGIN>>
//                         DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
//                         DetailedGSTLedgerEntry.SETRANGE("Document Type", "Document Type");
//                         DetailedGSTLedgerEntry.SETRANGE("Transaction Type", "Transaction Type");
//                         DetailedGSTLedgerEntry.SETRANGE("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
//                         //RSPLSUM END<<
//                         IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
//                             IF DetailedGSTLedgerEntry."Source Type" = DetailedGSTLedgerEntry."Source Type"::Customer THEN BEGIN
//                                 cdShipToCode := SalesInvoiceHeader."Ship-to Code";

//                                 IF cdShipToCode <> '' THEN
//                                     ShipToAddress.GET("Source No.", cdShipToCode)
//                                 ELSE
//                                     Customer.GET("Source No.")
//                             END ELSE
//                                 IF "Source Type" = "Source Type"::Vendor THEN BEGIN
//                                     cdOrderAddressCode := PurchInvoiceHeader."Order Address Code";
//                                     IF cdOrderAddressCode <> '' THEN
//                                         OrderAddress.GET("Source No.", cdOrderAddressCode)
//                                     ELSE
//                                         Vendor.GET("Source No.");

//                                     CompanyInformation.GET;
//                                 END;
//                             IF "Source Type" = "Source Type"::Customer THEN
//                                 IF DetailedGSTLedgerEntry."Location Code" <> '' THEN
//                                     Location.GET(DetailedGSTLedgerEntry."Location Code")
//                                 ELSE
//                                     CompanyInformation.GET;

//                             WITH DetailedGSTLedgerEntry DO BEGIN
//                                 IF "Source Type" = "Source Type"::Vendor THEN BEGIN
//                                     IF recState.GET(Vendor."State Code") THEN;
//                                     //fromPlace := recState."State Code (GST Reg. No.)";
//                                 END;
//                                 IF "Source Type" = "Source Type"::Customer THEN BEGIN
//                                     IF SalesInvoiceHeader."Ship-to Code" <> '' THEN BEGIN
//                                         recState.GET(ShipToAddress.State);
//                                         //fromPlace := recState."State Code (GST Reg. No.)";
//                                     END ELSE BEGIN
//                                         IF recState.GET(Customer."State Code") THEN;
//                                         //fromPlace := recState."State Code (GST Reg. No.)";
//                                     END;
//                                 END;
//                             END;
//                             IF recState.GET(DetailedGSTLedgerEntry."Location State Code") THEN;
//                             // fromState := recState."State Code (GST Reg. No.)";

//                         END;

//                         GSTLedgerEntry.RESET;
//                         GSTLedgerEntry.SETRANGE("Entry No.", "Entry No.");
//                         IF GSTLedgerEntry.FINDFIRST THEN BEGIN
//                             //reasonCode:=FORMAT(GSTLedgerEntry."Reason Code");
//                             //reasonRem:='vehicle broke down';
//                             transDocDate := FORMAT(GSTLedgerEntry."Posting Date", 10, '<Day,2>/<Month,2>/<Year4>'); //AKT
//                             transDocNo := GSTLedgerEntry."Document No.";//AKT
//                             ewbNo := GSTLedgerEntry."E-Way Bill No.";
//                             SalesInvoiceHeader.RESET;
//                             SalesInvoiceHeader.SETRANGE("No.", transDocNo); //AKT
//                             IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
//                                 vehicleNo := SalesInvoiceHeader."Vehicle No.";//AKT
//                                 IF TransportMethod.GET(SalesInvoiceHeader."Transport Method") THEN;
//                                 //TransMode:= TransportMethod."Trans Mode";//AKT
//                             END;
//                             SalesInvoiceLine2.RESET;
//                             SalesInvoiceLine2.SETRANGE("Document No.", transDocNo);
//                             IF SalesInvoiceLine2.FINDFIRST THEN BEGIN
//                                 quantity := FORMAT(SalesInvoiceLine2.Quantity);
//                             END;
//                             PurchnvLine2.RESET;
//                             PurchnvLine2.SETRANGE("Document No.", transDocNo);
//                             IF PurchnvLine2.FINDFIRST THEN BEGIN
//                                 quantity := FORMAT(PurchnvLine2.Quantity);
//                             END;
//                         END;
//                         groupNo := '1';
//                         vehAddedDate := '01/01/2019';
//                         //pgRespectivePage.SetData(PrewbNo,PrgroupNo,PrvehicleNo,PrtransDocNo,PrtransDocDate,Prquantity,PrvehAddedDate); //working fine line
//                         pgRespectivePage.SetData(ewbNo, groupNo, vehicleNo, transDocNo, transDocDate, quantity, vehAddedDate);
//                         pgRespectivePage.RUNMODAL;
//                     end;
//                 }
//                 action("UpdateVehicle(MultiUpdate)")
//                 {
//                     Image = Timeline;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     var
//                         pgRespectivePage: Page 50064;
//                         ewbNo: Text;
//                         groupNo: Text;
//                         oldvehicleNo: Text;
//                         newVehicleNo: Text;
//                         oldTranNo: Text;
//                         newTranNo: Text;
//                         fromPlace: Text;
//                         fromState: Text;
//                         reasonCode: Text;
//                         reasonRem: Text;
//                         vehUpdDate: Text;
//                     begin
//                         CLEARALL;
//                         //EwbNo,VehicleNo,FromPlace,FromState,ReasonCode,ReasonRem,TransDocNo,TransDocDate,TransMode
//                         //AKT_EWB 28082019

//                         SalesInvoiceHeader.RESET;
//                         SalesInvoiceHeader.SETRANGE("No.", newTranNo);    //AKT
//                         IF SalesInvoiceHeader.FINDFIRST THEN;

//                         PurchInvoiceHeader.RESET;
//                         PurchInvoiceHeader.SETRANGE("No.", newTranNo);     //AKT
//                         IF PurchInvoiceHeader.FINDFIRST THEN;

//                         DetailedGSTLedgerEntry.RESET;
//                         //RSPLSUM--DetailedGSTLedgerEntry.SETRANGE("Entry No.","Entry No.");
//                         //RSPLSUM BEGIN>>
//                         DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
//                         DetailedGSTLedgerEntry.SETRANGE("Document Type", "Document Type");
//                         DetailedGSTLedgerEntry.SETRANGE("Transaction Type", "Transaction Type");
//                         DetailedGSTLedgerEntry.SETRANGE("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
//                         //RSPLSUM END<<
//                         IF DetailedGSTLedgerEntry.FINDFIRST THEN BEGIN
//                             IF DetailedGSTLedgerEntry."Source Type" = DetailedGSTLedgerEntry."Source Type"::Customer THEN BEGIN
//                                 cdShipToCode := SalesInvoiceHeader."Ship-to Code";

//                                 IF cdShipToCode <> '' THEN
//                                     ShipToAddress.GET("Source No.", cdShipToCode)
//                                 ELSE
//                                     Customer.GET("Source No.")
//                             END ELSE
//                                 IF "Source Type" = "Source Type"::Vendor THEN BEGIN
//                                     cdOrderAddressCode := PurchInvoiceHeader."Order Address Code";
//                                     IF cdOrderAddressCode <> '' THEN
//                                         OrderAddress.GET("Source No.", cdOrderAddressCode)
//                                     ELSE
//                                         Vendor.GET("Source No.");

//                                     CompanyInformation.GET;
//                                 END;
//                             IF "Source Type" = "Source Type"::Customer THEN
//                                 IF DetailedGSTLedgerEntry."Location Code" <> '' THEN
//                                     Location.GET(DetailedGSTLedgerEntry."Location Code")
//                                 ELSE
//                                     CompanyInformation.GET;

//                             WITH DetailedGSTLedgerEntry DO BEGIN
//                                 IF "Source Type" = "Source Type"::Vendor THEN BEGIN
//                                     IF recState.GET(Vendor."State Code") THEN;
//                                     //fromPlace := recState."State Code (GST Reg. No.)";
//                                 END;
//                                 IF "Source Type" = "Source Type"::Customer THEN BEGIN
//                                     IF SalesInvoiceHeader."Ship-to Code" <> '' THEN BEGIN
//                                         recState.GET(ShipToAddress.State);
//                                         //fromPlace := recState."State Code (GST Reg. No.)";
//                                     END ELSE BEGIN
//                                         IF recState.GET(Customer."State Code") THEN;
//                                         //fromPlace := recState."State Code (GST Reg. No.)";
//                                     END;
//                                 END;
//                             END;
//                             IF recState.GET(DetailedGSTLedgerEntry."Location State Code") THEN;
//                             fromState := recState."State Code (GST Reg. No.)";

//                         END;

//                         GSTLedgerEntry.RESET;
//                         GSTLedgerEntry.SETRANGE("Entry No.", "Entry No.");
//                         IF GSTLedgerEntry.FINDFIRST THEN BEGIN
//                             reasonCode := FORMAT(GSTLedgerEntry."Reason Code");
//                             reasonRem := 'vehicle broke down';
//                             vehUpdDate := FORMAT(GSTLedgerEntry."Posting Date", 10, '<Day,2>/<Month,2>/<Year4>'); //AKT
//                             newTranNo := GSTLedgerEntry."Document No.";//AKT
//                             ewbNo := GSTLedgerEntry."E-Way Bill No.";
//                             SalesInvoiceHeader.RESET;
//                             SalesInvoiceHeader.SETRANGE("No.", newTranNo); //AKT
//                             IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
//                                 newVehicleNo := SalesInvoiceHeader."Vehicle No.";//AKT
//                                 IF TransportMethod.GET(SalesInvoiceHeader."Transport Method") THEN;
//                                 //TransMode:= TransportMethod."Trans Mode";//AKT
//                                 // END;
//                             END;
//                             groupNo := '1';
//                             oldvehicleNo := SalesInvoiceHeader."Vehicle No.";
//                             oldTranNo := '12';
//                             newVehicleNo := SalesInvoiceHeader."Vehicle No.";
//                         END;
//                         //pgRespectivePage.SetData('361001898233','PQR9877','BANGALORE','29','1','vehicle broke down','1234','12/10/2017' ,'1'); //AKT_EWB Comment 28082019


//                         //pgRespectivePage.SetData(EwbNo,VehicleNo,FromPlace,FromState,ReasonCode,ReasonRem,TransDocNo,TransDocDate,TransMode,"Document No.");     AKT
//                         //pgRespectivePage.SetData(ewbNo,groupNo,newVehicleNo,oldvehicleNo,fromPlace,fromState,reasonCode,reasonRem,oldTranNo,newTranNo,vehUpdDate); //Working fine
//                         //pgRespectivePage.SetData(ewbNo,groupNo,oldvehicleNo,newVehicleNo,oldTranNo,newTranNo,fromPlace,fromState,reasonCode,reasonRem,vehUpdDate);      //09122019
//                         pgRespectivePage.SetData(ewbNo, groupNo, oldvehicleNo, newVehicleNo, oldTranNo, newTranNo, fromPlace, fromState, reasonCode, reasonRem, vehUpdDate);
//                         pgRespectivePage.RUNMODAL;
//                     end;
//                 }
//             }
//             group(Get)
//             {
//                 Caption = 'Get';
//                 action("Get Eway Bill Details")
//                 {
//                     Image = GetSourceDoc;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     applicationarea = all;
//                     trigger OnAction()
//                     begin
//                         //AKT_EWB 10202020
//                         DetailedGSTLedgerEntry1.RESET;
//                         DetailedGSTLedgerEntry1.SETRANGE("Document No.", "Document No.");
//                         //DetailedGSTLedgerEntry1.SETRANGE("Document Type", "Document Type"::Invoice);
//                         IF DetailedGSTLedgerEntry1.FINDFIRST THEN BEGIN
//                             GSTRegNo := DetailedGSTLedgerEntry1."Location  Reg. No.";
//                         END;
//                         //AKT_EWB 10202020

//                         GeneralLedgerSetup.GET;
//                         LocRec.GET(DetailedGSTLedgerEntry1."Location Code");
//                         //GSTRegNo  :=  LocRec."EWB UserName";

//                         /*
//                         cuEwayBill.GetEWBDetail("E-Way Bill No.",GSTRegNo,AccessKey
//                                               ,GeneralLedgerSetup."EWB UserName", GeneralLedgerSetup."EWB Password");
//                         */
//                         cuEwayBill.GetEWBDetail("E-Way Bill No.", GSTRegNo, AccessKey
//                                               , LocRec."EWB UserName", LocRec."EWB Password");

//                     end;
//                 }
//                 action("Get GSTIN Details")
//                 {
//                     Description = 'Get';
//                     Ellipsis = true;
//                     Image = GetSourceDoc;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     var
//                         pgRespectivePage: Page 50058;
//                         GSTINNo: Text;
//                     begin
//                         //pgRespectivePage.SetData(GSTINNo);
//                         pgRespectivePage.SetData('05AAACG2115R1ZN', "Document No.", "Transaction Type");

//                         pgRespectivePage.RUNMODAL;
//                     end;
//                 }
//                 action("Get HSN Details")
//                 {
//                     Description = 'Get';
//                     Ellipsis = true;
//                     Image = GetSourceDoc;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     applicationarea = all;
//                     trigger OnAction()
//                     var
//                         pgRespectivePage: Page 50061;
//                         GSTINNo: Text;
//                     begin
//                         //pgRespectivePage.SetData(GSTINNo);
//                         pgRespectivePage.SetData('', "Document No.", "Transaction Type");

//                         pgRespectivePage.RUNMODAL;
//                     end;
//                 }
//                 action("Print E-Way Bill")
//                 {
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedIsBig = true;
//                     Visible = true;
//                     applicationarea = all;
//                     trigger OnAction()
//                     var
//                         // EWPrint: Report 50118;
//                         recGstLedEntry: Record "GST Ledger Entry";
//                         RecSIH: Record "112";
//                     begin
//                         /*
//                         recGstLedEntry.RESET;
//                         recGstLedEntry.SETRANGE("Entry No.",  "Entry No.");
//                         IF recGstLedEntry.FINDFIRST THEN
//                           REPORT.RUNMODAL(50118, TRUE,TRUE,recGstLedEntry);
//                         */
//                         RecSIH.RESET;
//                         RecSIH.SETCURRENTKEY("No.", "No.");
//                         RecSIH.SETRANGE("No.", "Document No.");
//                         IF RecSIH.FINDFIRST THEN
//                             REPORT.RUNMODAL(50118, TRUE, TRUE, RecSIH);

//                     end;
//                 }
//                 action("Print E-Way Bill Transfer")
//                 {
//                     Promoted = true;
//                     PromotedCategory = "Report";
//                     PromotedIsBig = true;
//                     Visible = true;
//                     applicationarea = all;
//                     trigger OnAction()
//                     var
//                         //EWPrint: Report 50118;
//                         recGstLedEntry: Record "GST Ledger Entry";
//                         RecTSH: Record 5744;
//                     begin
//                         /*
//                         recGstLedEntry.RESET;
//                         recGstLedEntry.SETRANGE("Entry No.",  "Entry No.");
//                         IF recGstLedEntry.FINDFIRST THEN
//                           REPORT.RUNMODAL(50118, TRUE,TRUE,recGstLedEntry);
//                         */
//                         RecTSH.RESET;
//                         RecTSH.SETCURRENTKEY("No.", "No.");
//                         RecTSH.SETRANGE("No.", rec."Document No.");
//                         IF RecTSH.FINDFIRST THEN
//                             REPORT.RUNMODAL(50234, TRUE, TRUE, RecTSH);

//                     end;
//                 }
//             }
//             group(group2)
//             {
//                 action("Test Eway XMLPorrt")
//                 {
//                     applicationarea = all;
//                     trigger OnAction()
//                     var
//                         //TempBlob2: Record TempBlob temporary;
//                         txtJsonRequest: Text;
//                     begin
//                         /*
//                                                 CLEARALL;
//                         cuEwayBill.TestReturnGenEBWJson(TempBlob2, "Document No.");

//                         txtJsonRequest := cuEwayBill.ReadAsText('', TempBlob2);//('',TEXTENCODING::UTF8);
//                         txtJsonRequest := cuEwayBill.ReplaceString(txtJsonRequest, '"itemList": {', '"itemList": [{');
//                         txtJsonRequest := cuEwayBill.ReplaceString(txtJsonRequest, '}}', '}]}');

//                         MESSAGE(txtJsonRequest);
//                         */
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         cuEwayBill: Codeunit 50012;
//         GSTLedgerEntry: Record "GST Ledger Entry";
//         DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
//         SalesInvoiceHeader: Record 112;
//         PurchInvoiceHeader: Record 122;
//         ReasonCode2: Record 231;
//         ReasonCode1: Code[20];
//         boolean: Boolean;
//         Vendor: Record 23;
//         Customer: Record 18;
//         ShipToAddress: Record 222;
//         Location: Record 14;
//         CompanyInformation: Record 79;
//         LocationRegNo: Code[15];
//         SourceType: Option " ",Customer,Vendor;
//         SourceNo: Code[20];
//         TransType1: Option " ",Sales,Purchase,Transfers;
//         SupplyType1: Option I,O;
//         SubType1: Option " ",Sply,Expt,JbWk,RectNtKnw,Impt,"Jb Wrk Retrn",SalRetrn,Other;
//         DocType1: Option " ","Tx Inv",BillofSply,BillofEnty,DeliChlan,CreNot,Othe;
//         SupplyType: Text;
//         OrderAddress: Record 224;
//         TransferShipmentHeader: Record 5744;
//         DetailedEWayBill: Record 50044;
//         recState: Record State;
//         TransportMethod: Record 259;
//         cdShipToCode: Code[50];
//         cdOrderAddressCode: Code[50];
//         SalesInvoiceLine2: Record 113;
//         PurchnvLine2: Record 123;
//         MultipleDetailedEWayBill: Record 50044;
//         cuEwayBill1: Codeunit 50012;
//         SalInvLin: Record 113;
//         SalInvHd: Record 112;
//         GSTRegNo: Code[20];
//         DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
//         AccessKey: Label 'sd321e213213';
//         AccessKey1: Text;
//         GeneralLedgerSetup: Record 98;
//         LocRec: Record 14;

//     local procedure OnQueryCloseForm(): Boolean
//     begin
//     end;
// }

