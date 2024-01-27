// page 50011 "Closed Purchase Orders"
// {
//     // 
//     // 02/01/2012 //EBT/QC Func/0001 Code Added for QC Functionality
//     // 
//     // EBT/ORDERCLOSE/0001 - Pratyusha - 14/02/2012  For Order Close Functionality. To update Closed TRUE and Closing Date in Purch.Header.
//     // EBT/ARCH/0001 - Pratyusha - 14/02/2012  To automatically create an archive version of order when released is selected.

//     Caption = 'Closed Purchase Orders';
//     Editable = false;
//     PageType = Document;
//     PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
//     RefreshOnActivate = true;
//     SourceTable = "Purchase Header";
//     SourceTableView = WHERE("Document Type" = FILTER(Order),
//                             Subcontracting = FILTER(false),
//ApplicationArea = all;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No.1"; rec."No.")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                     Visible = DocNoVisible;
//                     ApplicationArea = all;

//                     trigger OnAssistEdit()
//                     begin
//                         IF rec.AssistEdit(xRec) THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
//                 {
//                     Importance = Promoted;
//                     ShowMandatory = true;
//                     ApplicationArea = all;
//                     trigger OnValidate()
//                     begin
//                         BuyfromVendorNoOnAfterValidate;
//                     end;
//                 }
//                 field("Buy-from Contact No."; rec."Buy-from Contact No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Buy-from Address"; rec."Buy-from Address")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Buy-from Address 2"; rec."Buy-from Address 2")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Buy-from Post Code"; rec."Buy-from Post Code")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Buy-from City"; rec."Buy-from City")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Buy-from Contact"; rec."Buy-from Contact")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("No. of Archived Versions"; rec."No. of Archived Versions")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 /*  field(Structure; rec.Structure) //pcpl-064 13dec2023
//                  {
//                      ApplicationArea = all;
//                      Importance = Promoted;
//                  } */
//                 field("Full Name"; rec."Full Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Closed; rec.Closed)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Closing Date"; rec."Closing Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Order Date"; rec."Order Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Document Date"; rec."Document Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Quote No."; rec."Quote No.")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Vendor Order No."; rec."Vendor Order No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Vendor Shipment No."; rec."Vendor Shipment No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Vendor Invoice No."; rec."Vendor Invoice No.")
//                 {
//                     ApplicationArea = all;
//                     ShowMandatory = VendorInvoiceNoMandatory;
//                 }
//                 field("Order Address Code"; rec."Order Address Code")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Purchaser Code"; rec."Purchaser Code")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;

//                     trigger OnValidate()
//                     begin
//                         PurchaserCodeOnAfterValidate;
//                     end;
//                 }
//                 field("Responsibility Center"; rec."Responsibility Center")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Assigned User ID"; rec."Assigned User ID")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Job Queue Status"; rec."Job Queue Status")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                     Visible = false;
//                 }
//                 field(Status; rec.Status)
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;
//                 }
//             }
//             part(PurchLines; 54)
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "Document No." = FIELD("No.");
//                 UpdatePropagation = Both;
//             }
//             group(Invoicing)
//             {
//                 Caption = 'Invoicing';
//                 field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         PaytoVendorNoOnAfterValidate;
//                     end;
//                 }
//                 field("Pay-to Contact No."; rec."Pay-to Contact No.")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Pay-to Name"; rec."Pay-to Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pay-to Address"; rec."Pay-to Address")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Pay-to Address 2"; rec."Pay-to Address 2")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Pay-to Post Code"; rec."Pay-to Post Code")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Pay-to City"; rec."Pay-to City")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pay-to Contact"; rec."Pay-to Contact")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field(Remarks; rec.Remarks)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Receiving Date"; rec."Receiving Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension1CodeOnAfterV;
//                     end;
//                 }

//                 field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
//                 {
//                     ApplicationArea = all;
//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension2CodeOnAfterV;
//                     end;
//                 }
//                 field("Payment Terms Code"; rec."Payment Terms Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;
//                 }
//                 field("Payment Discount %"; rec."Payment Discount %")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pmt. Discount Date"; rec."Pmt. Discount Date")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Payment Method Code"; rec."Payment Method Code")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Payment Reference"; rec."Payment Reference")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Creditor No."; rec."Creditor No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("On Hold"; rec."On Hold")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Prices Including VAT"; rec."Prices Including VAT")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         PricesIncludingVATOnAfterValid;
//                     end;
//                 }
//                 field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(Shipping)
//             {
//                 Caption = 'Shipping';
//                 field("Ship-to Name"; rec."Ship-to Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ship-to Address"; rec."Ship-to Address")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Ship-to Address 2"; rec."Ship-to Address 2")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Ship-to Post Code"; rec."Ship-to Post Code")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Ship-to Contact"; rec."Ship-to Contact")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ship-to City"; rec."Ship-to City")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Location Code"; rec."Location Code")
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;
//                 }
//                 field("Inbound Whse. Handling Time"; rec."Inbound Whse. Handling Time")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Shipping Agent Code"; rec."Shipping Agent Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Shipment Method Code"; rec."Shipment Method Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Lead Time Calculation"; rec."Lead Time Calculation")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Requested Receipt Date"; rec."Requested Receipt Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Promised Receipt Date"; rec."Promised Receipt Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Expected Receipt Date"; rec."Expected Receipt Date")
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;
//                 }
//                 field("Sell-to Customer No."; rec."Sell-to Customer No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ship-to Code"; rec."Ship-to Code")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group("Foreign Trade")
//             {
//                 Caption = 'Foreign Trade';
//                 field("Currency Code"; rec."Currency Code")
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;

//                     trigger OnAssistEdit()
//                     begin
//                         CLEAR(ChangeExchangeRate);
//                         IF rec."Posting Date" <> 0D THEN
//                             ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date")
//                         ELSE
//                             ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", WORKDATE);
//                         IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
//                             VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
//                             CurrPage.UPDATE;
//                         END;
//                         CLEAR(ChangeExchangeRate);
//                     end;

//                     trigger OnValidate()
//                     begin
//                         CurrPage.UPDATE;
//                         PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
//                     end;
//                 }
//                 field("Transaction Type"; rec."Transaction Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Transaction Specification"; rec."Transaction Specification")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Transport Method"; rec."Transport Method")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Entry Point"; rec."Entry Point")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Area1; rec.Area)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(Prepayment)
//             {
//                 Caption = 'Prepayment';
//                 field("Prepayment %"; rec."Prepayment %")
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         Prepayment37OnAfterValidate;
//                     end;
//                 }
//                 field("Compress Prepayment"; rec."Compress Prepayment")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Prepmt. Payment Terms Code"; rec."Prepmt. Payment Terms Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Prepayment Due Date"; rec."Prepayment Due Date")
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;
//                 }
//                 field("Prepmt. Payment Discount %"; rec."Prepmt. Payment Discount %")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Prepmt. Pmt. Discount Date"; rec."Prepmt. Pmt. Discount Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Vendor Cr. Memo No."; rec."Vendor Cr. Memo No.")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(Application)
//             {
//                 Caption = 'Application';
//                 field("Applies-to Doc. Type"; rec."Applies-to Doc. Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Applies-to Doc. No."; rec."Applies-to Doc. No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Applies-to ID"; rec."Applies-to ID")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group("Tax Information")
//             {
//                 Caption = 'Tax Information';
//                 field("Service Type (Rev. Chrg.)"; rec."Service Type (Rev. Chrg.)")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Consignment Note No."; rec."Consignment Note No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Declaration Form (GTA)"; rec."Declaration Form (GTA)")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Input Service Distribution"; rec."Input Service Distribution")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Transit Document"; rec."Transit Document")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Trading; rec.Trading)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("C Form"; rec."C Form")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Form Code"; rec."Form Code")
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;
//                 }
//                 field("Form No."; rec."Form No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("LC No."; rec."LC No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Service Tax Rounding Precision"; rec."Service Tax Rounding Precision")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Service Tax Rounding Type"; rec."Service Tax Rounding Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(PoT; rec.PoT)
//                 {
//                     ApplicationArea = all;
//                 }
//                 group("Manufacturer Detail")
//                 {
//                     Caption = 'Manufacturer Detail';
//                     field("Manufacturer E.C.C. No."; rec."Manufacturer E.C.C. No.")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Manufacturer Name"; rec."Manufacturer Name")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Manufacturer Address"; rec."Manufacturer Address")
//                     {
//                         ApplicationArea = all;
//                     }
//                 }
//             }
//             group(Density)
//             {
//                 Caption = 'Density';
//                 Visible = false;
//                 field("Vendor Quantity"; rec."Vendor Quantity")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Density Factor"; rec."Density Factor")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Gross Weight"; rec."Gross Weight")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Tare Weight"; rec."Tare Weight")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Net Weight"; rec."Net Weight")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//             }
//             group(Other)
//             {
//                 Caption = 'Other';
//                 Visible = false;
//                 field("Freight Type"; rec."Freight Type")
//                 {
//                     ApplicationArea = all;
//                     Enabled = false;
//                 }
//                 field("Exp. TPT Cost"; rec."Exp. TPT Cost")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part(Part1; 9103)
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "Table ID" = CONST(38),
//                              "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("No.");
//                 Visible = OpenApprovalEntriesExistForCurrUser;
//             }
//             part(Part2; 9090)
//             {
//                 ApplicationArea = all;
//                 Provider = PurchLines;
//                 SubPageLink = "No." = FIELD("No.");
//                 Visible = false;
//             }
//             part(Part3; 9092)
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "Table ID" = CONST(38),
//                               "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("No.");
//                 Visible = false;
//             }
//             part(Part4; 9093)
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "No." = FIELD("Buy-from Vendor No.");
//                 Visible = false;
//             }
//             part(Part5; 9094)
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "No." = FIELD("Pay-to Vendor No.");
//                 Visible = true;
//             }
//             part(IncomingDocAttachFactBox; 193)
//             {
//                 ApplicationArea = all;
//                 ShowFilter = false;
//                 Visible = false;
//             }
//             part(part6; 9095)
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "No." = FIELD("Buy-from Vendor No.");
//                 Visible = true;
//             }
//             part(part7; 9096)
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "No." = FIELD("Pay-to Vendor No.");
//                 Visible = false;
//             }
//             part(part8; 9100)
//             {
//                 ApplicationArea = all;
//                 Provider = PurchLines;
//                 SubPageLink = "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("Document No."),
//                               "Line No." = FIELD("Line No.");
//             }
//             part(WorkflowStatus; 1528)
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 Enabled = false;
//                 ShowFilter = false;
//                 Visible = ShowWorkflowStatus;
//             }
//             systempart(part9; Links)
//             {
//                 ApplicationArea = all;
//                 Visible = false;
//             }
//             systempart(part10; Notes)
//             {
//                 ApplicationArea = all;
//                 Visible = true;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("O&rder")
//             {
//                 Caption = 'O&rder';
//                 Image = "Order";
//                 action(Dimensions)
//                 {
//                     ApplicationArea = all;
//                     AccessByPermission = TableData 348 = R;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     Promoted = false;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = false;
//                     ShortCutKey = 'Shift+Ctrl+D';

//                     trigger OnAction()
//                     begin
//                         ShowDocDim;
//                         CurrPage.SAVERECORD;
//                     end;
//                 }
//                 action(Statistics)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F7';

//                     trigger OnAction()
//                     begin
//                         OpenPurchaseOrderStatistics;
//                         PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     Promoted = false;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = false;
//                     RunObject = Page 26;
//                     RunPageLink = "No." = FIELD("Buy-from Vendor No.");
//                     ShortCutKey = 'Shift+F7';
//                 }
//                 action(Approvals)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Approvals';
//                     Image = Approvals;

//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page 658;
//                     begin
//                         //ApprovalEntries.SetFilters(DATABASE::"Purchase Header", rec."Document Type", rec."No."); //pcpl-064 12dec2023 
//                         ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", rec."Document Type", rec."No.");
//                         ApprovalEntries.RUN;
//                     end;
//                 }
//                 action("Co&mments")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page 66;
//                     RunPageLink = "Document Type" = FIELD("Document Type"),
//                                   "No." = FIELD("No."),
//                                   "Document Line No." = CONST(0);
//                 }
//             }
//             group(Documents)
//             {

//                 Caption = 'Documents';
//                 Image = Documents;
//                 action(Receipts)
//                 {
//                     Caption = 'Receipts';
//                     Image = PostedReceipts;
//                     RunObject = Page 145;
//                     RunPageLink = "Order No." = FIELD("No.");
//                     RunPageView = SORTING("Order No.");
//                 }
//                 action(Invoices)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Invoices';
//                     Image = Invoice;
//                     Promoted = false;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = false;
//                     RunObject = Page 146;
//                     RunPageLink = "Order No." = FIELD("No.");
//                     RunPageView = SORTING("Order No.");
//                 }
//                 action(PostedPrepaymentInvoices)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Prepa&yment Invoices';
//                     Image = PrepaymentInvoice;
//                     RunObject = Page 146;
//                     RunPageLink = "Prepayment Order No." = FIELD("No.");
//                     RunPageView = SORTING("Prepayment Order No.");
//                 }
//                 action(PostedPrepaymentCrMemos)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Prepayment Credi&t Memos';
//                     Image = PrepaymentCreditMemo;
//                     RunObject = Page 147;
//                     RunPageLink = "Prepayment Order No." = FIELD("No.");
//                     RunPageView = SORTING("Prepayment Order No.");
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 separator(sep1)
//                 {
//                 }
//                 action("In&vt. Put-away/Pick Lines")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'In&vt. Put-away/Pick Lines';
//                     Image = PickLines;
//                     RunObject = Page 5774;
//                     RunPageLink = "Source Document" = CONST("Purchase Order"),
//                                   "Source No." = FIELD("No.");
//                     RunPageView = SORTING("Source Document", "Source No.", "Location Code");
//                 }
//                 action("Whse. Receipt Lines")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Whse. Receipt Lines';
//                     Image = ReceiptLines;
//                     RunObject = Page 7342;
//                     RunPageLink = "Source Type" = CONST(39),
//                                   "Source Subtype" = FIELD("Document Type"),
//                                   "Source No." = FIELD("No.");
//                     RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
//                 }
//                 separator(sep2)
//                 {
//                 }
//                 group("Dr&op Shipment1")
//                 {
//                     Caption = 'Dr&op Shipment';
//                     Image = Delivery;
//                     action(Warehouse_GetSalesOrder)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";
//                         RunObject = Codeunit 76;
//                     }
//                 }
//                 group("Speci&al Order1")
//                 {
//                     Caption = 'Speci&al Order';
//                     Image = SpecialOrder;
//                     action("Get &Sales Order1")
//                     {
//                         ApplicationArea = all;
//                         AccessByPermission = TableData 110 = R;
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";

//                         trigger OnAction()
//                         var
//                             PurchHeader: Record 38;
//                             DistIntegration: Codeunit 5702;
//                         begin
//                             PurchHeader.COPY(Rec);
//                             DistIntegration.GetSpecialOrders(PurchHeader);
//                             Rec := PurchHeader;
//                         end;
//                     }
//                 }
//             }
//         }
//         area(processing)
//         {
//             group(Approval)
//             {
//                 Caption = 'Approval';
//                 action(Approve)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Approve';
//                     Image = Approve;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
//                     end;
//                 }
//                 action(Reject)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Reject';
//                     Image = Reject;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
//                     end;
//                 }
//                 action(Delegate)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Delegate';
//                     Image = Delegate;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
//                     end;
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comments';
//                     Image = ViewComments;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         ApprovalsMgmt.GetApprovalComment(Rec);
//                     end;
//                 }
//             }
//             group(Release)
//             {
//                 Caption = 'Release';
//                 Image = ReleaseDoc;
//                 separator()
//                 {
//                 }
//                 action(Release)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Re&lease';
//                     Image = ReleaseDoc;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ShortCutKey = 'Ctrl+F9';

//                     trigger OnAction()
//                     var
//                         ReleasePurchDoc: Codeunit 415;
//                     begin
//                         ReleasePurchDoc.PerformManualRelease(Rec);

//                         //EBT/ARCH/0001
//                         IF Status <> Status::Open THEN BEGIN
//                             ArchiveManagement.ArchPurchDocumentNoConfirm(Rec);
//                             CurrPage.UPDATE(FALSE);
//                         END;
//                         //EBT/ARCH/0001
//                     end;
//                 }
//                 action(Reopen)
//                 {
//                     Caption = 'Re&open';
//                     Image = ReOpen;
//                     ApplicationArea = all;

//                     trigger OnAction()
//                     var
//                         ReleasePurchDoc: Codeunit "Release Purchase Document";
//                     begin
//                         ReleasePurchDoc.PerformManualReopen(Rec);
//                     end;
//                 }
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action(CalculateInvoiceDiscount)
//                 {
//                     ApplicationArea = all;
//                     AccessByPermission = TableData 24 = R;
//                     Caption = 'Calculate &Invoice Discount';
//                     Image = CalculateInvoiceDiscount;

//                     trigger OnAction()
//                     begin
//                         ApproveCalcInvDisc;
//                         PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action("Get St&d. Vend. Purchase Codes")
//                 {
//                     Caption = 'Get St&d. Vend. Purchase Codes';
//                     Ellipsis = true;
//                     Image = VendorCode;
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         StdVendPurchCode: Record 175;
//                     begin
//                         StdVendPurchCode.InsertPurchLines(Rec);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action(CopyDocument)
//                 {
//                     Caption = 'Copy Document';
//                     Ellipsis = true;
//                     Image = CopyDocument;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         CopyPurchDoc.SetPurchHeader(Rec);
//                         CopyPurchDoc.RUNMODAL;
//                         CLEAR(CopyPurchDoc);
//                         IF GET("Document Type", "No.") THEN;
//                     end;
//                 }
//                 action(MoveNegativeLines)
//                 {
//                     Caption = 'Move Negative Lines';
//                     Ellipsis = true;
//                     Image = MoveNegativeLines;
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         CLEAR(MoveNegPurchLines);
//                         MoveNegPurchLines.SetPurchHeader(Rec);
//                         MoveNegPurchLines.RUNMODAL;
//                         MoveNegPurchLines.ShowDocument;
//                     end;
//                 }
//                 group("Dr&op Shipment")
//                 {
//                     Caption = 'Dr&op Shipment';
//                     Image = Delivery;
//                     action(Functions_GetSalesOrder)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";
//                         RunObject = Codeunit 76;
//                     }
//                 }
//                 group("Speci&al Order")
//                 {
//                     Caption = 'Speci&al Order';
//                     Image = SpecialOrder;
//                     action("Get &Sales Order")
//                     {
//                         ApplicationArea = all;
//                         AccessByPermission = TableData 110 = R;
//                         Caption = 'Get &Sales Order';
//                         Image = "Order";

//                         trigger OnAction()
//                         var
//                             DistIntegration: Codeunit 5702;
//                             PurchHeader: Record "38";
//                         begin
//                             PurchHeader.COPY(Rec);
//                             DistIntegration.GetSpecialOrders(PurchHeader);
//                             Rec := PurchHeader;
//                         end;
//                     }
//                 }
//                 separator()
//                 {
//                 }
//                 action("St&ructure")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'St&ructure';
//                     Image = Hierarchy;
//                     RunObject = Page 16305;
//                     RunPageLink = Type = CONST(Purchase),
//                                   "Document Type" = FIELD("Document Type"),
//                                   "Document No." = FIELD("No.");
//                 }
//                 action("Transit Documents")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Transit Documents';
//                     Image = TransferOrder;
//                     RunObject = Page 13705;
//                     RunPageLink = Type = CONST(Purchase),
//                                   PO / SO No.=FIELD(No.),
//                                   Vendor / Customer Ref.=FIELD("Buy-from Vendor No."),
//                                   State=FIELD(State);
//                 }
//                 action("Deferment Schedule")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Deferment Schedule';
//                     Image = Installments;
//                     RunObject = Page 16558;
//                                     RunPageLink = "Document No."=FIELD("No.");
//                 }
//                 action("Attached Gate Entry")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Attached Gate Entry';
//                     Image = InwardEntry;
//                     RunObject = Page 16481;
//                                     RunPageLink = "Source No."=FIELD("No."),
//                                   Source Type=CONST("Purchase Order"),
//                                   Entry Type=CONST(Inward);
//                 }
//                 action("Detailed &Tax")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Detailed &Tax';
//                     Image = TaxDetail;
//                     RunObject = Page 16341;
//                                     RunPageLink = "Document Type"=FIELD("Document Type"),
//                                   "Document No."=FIELD("No."),
//                                   "Transaction Type"=CONST(Purchase);
//                 }
//                 action("Archive Document")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Archi&ve Document';
//                     Image = Archive;

//                     trigger OnAction()
//                     begin
//                         ArchiveManagement.ArchivePurchDocument(Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Send IC Purchase Order")
//                 {
//                     ApplicationArea = all;
//                     AccessByPermission = TableData 410=R;
//                     Caption = 'Send IC Purchase Order';
//                     Image = IntercompanyOrder;

//                     trigger OnAction()
//                     var
//                         ICInOutboxMgt: Codeunit 427;
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
//                           ICInOutboxMgt.SendPurchDoc(Rec,FALSE);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action("Calc&ulate Structure Values")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Calc&ulate Structure Values';
//                     Image = CalculateHierarchy;

//                     trigger OnAction()
//                     begin
//                         PurchLine.CalculateStructures(Rec);
//                         PurchLine.AdjustStructureAmounts(Rec);
//                         PurchLine.UpdatePurchLines(Rec);
//                     end;
//                 }
//                 action("Calculate TDS")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Calculate TDS';
//                     Image = CalculateVATExemption;

//                     trigger OnAction()
//                     begin
//                         PurchLine.CalculateTDS(Rec);
//                     end;
//                 }
//                 group(IncomingDocument)
//                 {
//                     Caption = 'Incoming Document';
//                     Image = Documents;
//                     action(IncomingDocCard)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'View Incoming Document';
//                         Enabled = HasIncomingDocument;
//                         Image = ViewOrder;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         trigger OnAction()
//                         var
//                             IncomingDocument: Record 130;
//                         begin
//                             IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
//                         end;
//                     }
//                     action(SelectIncomingDoc)
//                     {
//                         AccessByPermission = TableData 130=R;
//                         Caption = 'Select Incoming Document';
//                         Image = SelectLineToApply;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';
// ApplicationArea = all;
//                         trigger OnAction()
//                         var
//                             IncomingDocument: Record 130;
//                         begin
//                             VALIDATE("Incoming Document Entry No.",IncomingDocument.SelectIncomingDocument("Incoming Document Entry No."));
//                         end;
//                     }
//                     action(IncomingDocAttachFile)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Create Incoming Document from File';
//                         Ellipsis = true;
//                         Enabled = NOT HasIncomingDocument;
//                         Image = Attach;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         trigger OnAction()
//                         var
//                             IncomingDocumentAttachment: Record 133;
//                         begin
//                             IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
//                         end;
//                     }
//                     action(RemoveIncomingDoc)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Remove Incoming Document';
//                         Enabled = HasIncomingDocument;
//                         Image = RemoveLine;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         trigger OnAction()
//                         begin
//                             "Incoming Document Entry No." := 0;
//                         end;
//                     }
//                 }
//             }
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 action(SendApprovalRequest)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Send A&pproval Request';
//                     Enabled = NOT OpenApprovalEntriesExist;
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category9;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         IF ApprovalsMgmt.CheckPurchaseApprovalsWorkflowEnabled(Rec) THEN
//                           ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = OpenApprovalEntriesExist;
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category9;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
//                     end;
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 action("Create &Whse. Receipt")
//                 {
//                     ApplicationArea = all;
//                     AccessByPermission = TableData 7316=R;
//                     Caption = 'Create &Whse. Receipt';
//                     Image = NewReceipt;

//                     trigger OnAction()
//                     var
//                         GetSourceDocInbound: Codeunit 5751;
//                     begin
//                         GetSourceDocInbound.CreateFromPurchOrder(Rec);

//                         IF NOT FIND('=><') THEN
//                           INIT;
//                     end;
//                 }
//                 action("Create Inventor&y Put-away/Pick")
//                 {
//                     ApplicationArea = all;
//                     AccessByPermission = TableData 7340=R;
//                     Caption = 'Create Inventor&y Put-away/Pick';
//                     Ellipsis = true;
//                     Image = CreateInventoryPickup;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         CreateInvtPutAwayPick;

//                         IF NOT FIND('=><') THEN
//                           INIT;
//                     end;
//                 }
//                 action("Get Gate Entry Lines")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Get Gate Entry Lines';
//                     Image = GetLines;

//                     trigger OnAction()
//                     begin
//                         GetGateEntryLines;
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//             }
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 Image = Post;
//                 action(Post)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'P&ost';
//                     Ellipsis = true;
//                     Image = PostOrder;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin
//                         Post(CODEUNIT::"Purch.-Post (Yes/No)");
//                     end;
//                 }
//                 action(Preview)
//                 {
//                     Caption = 'Preview Posting';
//                     Image = ViewPostedOrder;
// ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         PurchPostYesNo: Codeunit 91;
//                     begin
//                         PurchPostYesNo.Preview(Rec);
//                     end;
//                 }
//                 action("Post and &Print")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Post and &Print';
//                     Ellipsis = true;
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Shift+F9';

//                     trigger OnAction()
//                     begin
//                         Post(CODEUNIT::"Purch.-Post + Print");
//                     end;
//                 }
//                 action("Test Report")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;

//                     trigger OnAction()
//                     begin
//                         ReportPrint.PrintPurchHeader(Rec);
//                     end;
//                 }
//                 action("Post &Batch")
//                 {

//                     Caption = 'Post &Batch';
//                     Ellipsis = true;
//                     Image = PostBatch;

//                     trigger OnAction()
//                     begin

//                         REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders",TRUE,TRUE,Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Print Deferment Schedule")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Print Deferment Schedule';
//                     Image = PrintInstallments;

//                     trigger OnAction()
//                     begin
//                         DefermentBuffer.RESET;
//                         DefermentBuffer.SETRANGE("Document No.","No.");
//                         REPORT.RUNMODAL(16543,TRUE,TRUE,DefermentBuffer);
//                     end;
//                 }
//                 action("Remove From Job Queue")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Remove From Job Queue';
//                     Image = RemoveLine;
//                     Visible = JobQueueVisible;

//                     trigger OnAction()
//                     begin
//                         CancelBackgroundPosting;
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 group("Prepa&yment")
//                 {
//                     Caption = 'Prepa&yment';
//                     Image = Prepayment;
//                     action("Prepayment Test &Report")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Prepayment Test &Report';
//                         Ellipsis = true;
//                         Image = PrepaymentSimulation;

//                         trigger OnAction()
//                         begin
//                             ReportPrint.PrintPurchHeaderPrepmt(Rec);
//                         end;
//                     }
//                     action(PostPrepaymentInvoice)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Post Prepayment &Invoice';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;

//                         trigger OnAction()
//                         var
//                             ApprovalsMgmt: Codeunit 1535;
//                             PurchPostYNPrepmt: Codeunit 445;
//                         begin
//                             IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
//                               PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec,FALSE);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Invoic&e")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Post and Print Prepmt. Invoic&e';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;

//                         trigger OnAction()
//                         var
//                             ApprovalsMgmt: Codeunit 1535;
//                             PurchPostYNPrepmt: Codeunit 445;
//                         begin
//                             IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
//                               PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec,TRUE);
//                         end;
//                     }
//                     action(PostPrepaymentCreditMemo)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Post Prepayment &Credit Memo';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;

//                         trigger OnAction()
//                         var
//                             ApprovalsMgmt: Codeunit 1535;
//                             PurchPostYNPrepmt: Codeunit 445;
//                         begin
//                             IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
//                               PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec,FALSE);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Cr. Mem&o")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Post and Print Prepmt. Cr. Mem&o';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;

//                         trigger OnAction()
//                         var
//                             ApprovalsMgmt: Codeunit 1535;
//                             PurchPostYNPrepmt: Codeunit 445;
//                         begin
//                             IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
//                               PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec,TRUE);
//                         end;
//                     }
//                 }
//             }
//             group(Print)
//             {
//                 Caption = 'Print';
//                 Image = Print;
//                 action("&Print")
//                 {
//                     ApplicationArea = all;
//                     Caption = '&Print';
//                     Ellipsis = true;
//                     Image = Print;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintPurchHeader(Rec);
//                     end;
//                 }
//                 action("Purchase Order - &Regular")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;

//                     trigger OnAction()
//                     begin

//                         IF "Payment Terms Code" = '' THEN
//                         ERROR('Payment Terms Code is Blank');

//                         //EBT STIVAN ---(1307012)-----------------------------------------------------START
//                         IF "Order Address Code" <> '' THEN
//                         BEGIN
//                          PurchLine.RESET;
//                          PurchLine.SETRANGE(PurchLine."Document No.","No.");
//                          IF PurchLine.FINDSET THEN
//                          IF (PurchLine."Tax Amount" <> 0)THEN
//                          BEGIN
//                           IF "Vendor TIN No." = '' THEN
//                           BEGIN
//                            OrderAddress.GET("Buy-from Vendor No.","Order Address Code");
//                            IF (OrderAddress."L.S.T. No." = '') THEN
//                            ERROR ('TIN No. is Blank');
//                            //MESSAGE('TIN No. is Blank');
//                           END;
//                          END;
//                         END;

//                         IF "Order Address Code" = '' THEN
//                         BEGIN
//                          PurchLine.RESET;
//                          PurchLine.SETRANGE(PurchLine."Document No.","No.");
//                          IF PurchLine.FINDSET THEN
//                          IF (PurchLine."Tax Amount" <> 0)THEN
//                          BEGIN
//                          IF "Vendor TIN No." = '' THEN
//                          BEGIN
//                            Vendor.GET("Buy-from Vendor No.");
//                            IF (Vendor."L.S.T. No." = '') THEN
//                            ERROR ('TIN No. is Blank');
//                            //MESSAGE('TIN No. is Blank');
//                           END;
//                          END;
//                         END;
//                         //EBT STIVAN ---(13072012)-------------------------------------------------------END

//                         DocPrint.PrintPurchHeader(Rec);
//                     end;
//                 }
//                 action("Purchase Order - &Import")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         CurrPage.SETSELECTIONFILTER(Rec);

//                         REPORT.RUNMODAL(50054,TRUE,FALSE,Rec)
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
//         ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         SetControlAppearance;
//     end;

//     trigger OnDeleteRecord(): Boolean
//     begin
//         CurrPage.SAVERECORD;
//         EXIT(ConfirmDeletion);
//     end;

//     trigger OnInit()
//     begin
//         SetExtDocNoMandatoryCondition;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         "Responsibility Center" := UserMgt.GetPurchasesFilter;
//     end;

//     trigger OnOpenPage()
//     begin
//         SetDocNoVisible;

//         IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
//           FILTERGROUP(2);
//           SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
//           FILTERGROUP(0);
//         END;
//     end;

//     var
//         PurchSetup: Record 312;
//         ChangeExchangeRate: Page "Change Exchange Rate";
//                                 CopyPurchDoc: Report 492;
//                                 MoveNegPurchLines: Report 6698;
//                                 ReportPrint: Codeunit 228;
//                                 DocPrint: Codeunit 229;
//                                 UserMgt: Codeunit 5700;
//                                 ArchiveManagement: Codeunit 5063;
//                                 PurchCalcDiscByType: Codeunit 66;
//                                 PurchLine: Record 39;
//                                 DefermentBuffer: Record 16532;


//                                 JobQueueVisible: Boolean;
//                                 HasIncomingDocument: Boolean;
//                                 DocNoVisible: Boolean;
//                                 VendorInvoiceNoMandatory: Boolean;
//                                 OpenApprovalEntriesExistForCurrUser: Boolean;
//                                 OpenApprovalEntriesExist: Boolean;
//                                 ShowWorkflowStatus: Boolean;
//                                 OrderAddress: Record 224;
//                                 Vendor: Record 23;
//                                 Created: Boolean;
//                                 PurchaseLineRec: Record 39;
//                                 QcTestResult: Record 50002;
//                                 QcTestResult1: Record 50002;
//                                 QCParameter: Record 50001;
//                                 QCMaster: Record 50000;
//                                 Item: Record 27;

//     local procedure Post(PostingCodeunitID: Integer)
//     begin
//         SendToPosting(PostingCodeunitID);
//         IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
//             CurrPage.CLOSE;
//         CurrPage.UPDATE(FALSE);
//     end;

//     local procedure ApproveCalcInvDisc()
//     begin
//         CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
//     end;

//     local procedure BuyfromVendorNoOnAfterValidate()
//     begin
//         IF rec.GETFILTER(rec."Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
//             IF "Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
//                 SETRANGE("Buy-from Vendor No.");
//         CurrPage.UPDATE;
//     end;

//     local procedure PurchaserCodeOnAfterValidate()
//     begin
//         CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
//     end;

//     local procedure PaytoVendorNoOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure ShortcutDimension1CodeOnAfterV()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure ShortcutDimension2CodeOnAfterV()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure PricesIncludingVATOnAfterValid()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure Prepayment37OnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure SetDocNoVisible()
//     var
//         DocumentNoVisibility: Codeunit 1400;
//         DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
//     begin
//         DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Order, "No.");
//     end;

//     local procedure SetExtDocNoMandatoryCondition()
//     var
//         PurchasesPayablesSetup: Record "312";
//     begin
//         PurchasesPayablesSetup.GET;
//         VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
//     end;

//     local procedure SetControlAppearance()
//     var
//         ApprovalsMgmt: Codeunit 1535;
//     begin
//         JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
//         HasIncomingDocument := "Incoming Document Entry No." <> 0;
//         SetExtDocNoMandatoryCondition;
//         OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
//         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
//     end;

//     //  [Scope('Internal')]
//     procedure CreateQCTestResult()
//     begin
//         //EBT/QC Func/0001
//         Created := FALSE;
//         PurchaseLineRec.RESET;
//         PurchaseLineRec.SETRANGE("Document Type", "Document Type");
//         PurchaseLineRec.SETRANGE("Document No.", "No.");
//         PurchaseLineRec.SETRANGE("QC Applicable", TRUE);
//         PurchaseLineRec.SETRANGE("QC Approved", FALSE);
//         IF PurchaseLineRec.FINDSET THEN
//             REPEAT
//                 QcTestResult.RESET;
//                 QcTestResult.SETRANGE("Order No.", PurchaseLineRec."Document No.");
//                 QcTestResult.SETRANGE("Line No.", PurchaseLineRec."Line No.");
//                 QcTestResult.SETRANGE("Item No.", PurchaseLineRec."No.");
//                 IF NOT QcTestResult.FINDFIRST THEN BEGIN
//                     QCParameter.RESET;
//                     QCParameter.SETRANGE("Item No.", PurchaseLineRec."No.");
//                     IF QCParameter.FINDSET THEN
//                         REPEAT
//                             QcTestResult1.INIT;
//                             QcTestResult1."Order No." := PurchaseLineRec."Document No.";
//                             QcTestResult1."Line No." := PurchaseLineRec."Line No.";
//                             QcTestResult1."Item No." := PurchaseLineRec."No.";
//                             QcTestResult1.Parameter := QCParameter."Parameter Code";
//                             Item.GET(PurchaseLineRec."No.");
//                             QCMaster.RESET;
//                             QCMaster.SETRANGE("Inventory Posting Group", Item."Inventory Posting Group");
//                             QCMaster.SETRANGE("Parameter Code", QCParameter."Parameter Code");
//                             IF QCMaster.FINDFIRST THEN BEGIN
//                                 QcTestResult1."Min Range" := QCMaster."Specifications Minimum";
//                                 QcTestResult1."Max Range" := QCMaster."Specifications Maximum";
//                             END;
//                             IF QcTestResult1.INSERT THEN
//                                 Created := TRUE;
//                         UNTIL QCParameter.NEXT = 0;
//                 END;
//             UNTIL PurchaseLineRec.NEXT = 0
//         ELSE
//             ERROR('There are no pending QC for testing');
//         /*IF Created THEN
//            MESSAGE('QC Test data has been created'); */
//         //EBT/QC Func/0001

//     end;
// }

