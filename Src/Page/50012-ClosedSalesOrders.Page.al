// page 50012 "Closed Sales Orders"
// {
//     // EBT/SHORTCLOSE/0001        Pratyusha   14/02/2012   For Short Close Functionality
//     // 06/03/2012 EBT/OVERDUE/APV/0001 codes added for Cr. Limit Approval Functionalilty
//     // EBT/USERMAPPING/0002      Pratyusha    13-04-2012   For User-Mapping Functionality for CSO.
//     // EBT01                     Rakshitha    14-05-2012   For Autoclosing the CSO after 30 Days from the date of creation
//     // //RSPL/CUST/MERCH/001     Sourav Dey   24-09-2015   For Merchandizing product there would be these exceptions
//     // //RSPL008                 Shaik Noor   15-04-2016   A validation is added for MERCH items through which dimension wise inventory can
//     //                                                                                                         not go negative.
//     // 
//     // //RSPL022 01/06/2016 -- Credit Limit Functionality -----------Code written at Re-Open,Approve,Credit for Approval
//     // 
//     // //IPOL/OVERDUE/01 >>>>  Over Due Order Approval based User setup Rights    ON 09

//     Caption = 'Closed Sales Orders';
//     PageType = Document;
//     PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
//     RefreshOnActivate = true;
//     SourceTable = 36;
//     SourceTableView = WHERE("Document Type" = FILTER(Order),
//                             "Short Close" = CONST(true));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; rec."No.")
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
//                 field("Sell-to Customer No."; rec."Sell-to Customer No.")
//                 {
//                     Importance = Promoted;
//                     ShowMandatory = true;
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         SelltoCustomerNoOnAfterValidat;
//                     end;
//                 }
//                 field("Sell-to Contact No."; rec."Sell-to Contact No.")
//                 {
//                     Importance = Additional;

//                     ApplicationArea = all;
//                     trigger OnValidate()
//                     begin
//                         IF GETFILTER("Sell-to Contact No.") = xRec."Sell-to Contact No." THEN
//                             IF "Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
//                                 SETRANGE("Sell-to Contact No.");
//                     end;
//                 }
//                 field("Sell-to Customer Name"; rec."Sell-to Customer Name")
//                 {
//                     QuickEntry = false;
//                     ApplicationArea = all;

//                 }
//                 field("Sell-to Address"; rec."Sell-to Address")
//                 {
//                     ApplicationArea = all;

//                     Importance = Additional;
//                 }
//                 field("Sell-to Address 2"; rec."Sell-to Address 2")
//                 {
//                     ApplicationArea = all;

//                     Importance = Additional;
//                 }
//                 field("Sell-to Post Code"; rec."Sell-to Post Code")
//                 {
//                     ApplicationArea = all;

//                     Importance = Additional;
//                 }
//                 field("Sell-to City"; rec."Sell-to City")
//                 {
//                     ApplicationArea = all;

//                     QuickEntry = false;
//                 }
//                 field("Sell-to Contact"; rec."Sell-to Contact")
//                 {
//                     ApplicationArea = all;


//                     Importance = Additional;
//                 }
//                 field("No. of Archived Versions"; rec."No. of Archived Versions")
//                 {
//                     ApplicationArea = all;

//                     Importance = Additional;
//                 }
//                 field(Structure; rec.Structure)
//                 {
//                     ApplicationArea = all;

//                     Importance = Promoted;
//                 }
//                 field("Short Close"; rec."Short Close")
//                 {
//                     ApplicationArea = all;

//                 }
//                 field("Short Close Date"; rec."Short Close Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     QuickEntry = false;
//                 }
//                 field("Order Date"; rec."Order Date")
//                 {
//                     ApplicationArea = all;

//                     Caption = 'External Document Date';
//                     Importance = Promoted;
//                     QuickEntry = false;
//                 }
//                 field("Document Date"; rec."Document Date")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Sales Order Date';
//                     QuickEntry = false;
//                 }
//                 field("Requested Delivery Date"; rec."Requested Delivery Date")
//                 {
//                     ApplicationArea = all;

//                 }
//                 field("Promised Delivery Date"; rec."Promised Delivery Date")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("External Document No."; rec."External Document No.")
//                 {
//                     Importance = Promoted;
//                     ApplicationArea = all;

//                     ShowMandatory = ExternalDocNoMandatory;
//                 }
//                 field("Quote No."; rec."Quote No.")
//                 {
//                     Importance = Additional;
//                     Visible = false;
//                     ApplicationArea = all;
//                 }
//                 field("Salesperson Code"; rec."Salesperson Code")
//                 {
//                     Editable = SalesPerCodeEditable;
//                     QuickEntry = false;
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         SalespersonCodeOnAfterValidate;
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
//                 field(Status; rec.Status)
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;
//                     QuickEntry = false;
//                 }
//             }
//             part(SalesLines; 46)
//             {
//                 ApplicationArea = all;
//                 Editable = DynamicEditable;
//                 SubPageLink = "Document No." = FIELD("No.");
//                 UpdatePropagation = Both;
//             }
//             group(Invoicing)
//             {
//                 Caption = 'Invoicing';
//                 field("Bill-to Customer No."; rec."Bill-to Customer No.")
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         BilltoCustomerNoOnAfterValidat;
//                     end;
//                 }
//                 field("Bill-to Contact No."; rec."Bill-to Contact No.")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Bill-to Name"; rec."Bill-to Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Bill-to Address"; rec."Bill-to Address")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Bill-to Address 2"; rec."Bill-to Address 2")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Bill-to Post Code"; rec."Bill-to Post Code")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Bill-to City"; rec."Bill-to City")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Bill-to Contact"; rec."Bill-to Contact")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
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
//                 field("Cr. Approved"; rec."Cr. Approved")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
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
//                     Editable = false;
//                     Importance = Promoted;
//                     ApplicationArea = all;
//                 }
//                 field("Due Date"; "Due Date")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                     ApplicationArea = all;
//                 }
//                 field("Payment Discount %"; "Payment Discount %")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pmt. Discount Date"; "Pmt. Discount Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Payment Method Code"; rec."Payment Method Code")
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
//                 field("Credit Card No."; rec."Credit Card No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(GetCreditcardNumber; rec.GetCreditcardNumber)
//                 {
//                     Caption = 'Cr. Card Number (Last 4 Digits)';
//                     ApplicationArea = all;
//                 }
//                 field(Amount; rec.Amount)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Posting No. Series"; rec."Posting No. Series")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Posting No."; rec."Posting No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Direct Debit Mandate ID"; rec."Direct Debit Mandate ID")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//             }
//             group(Shipping)
//             {
//                 Caption = 'Shipping';
//                 field("Ship-to Code"; rec."Ship-to Code")
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;
//                 }
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
//                     Importance = Promoted;
//                 }
//                 field("Ship-to City"; rec."Ship-to City")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ship-to Contact"; rec."Ship-to Contact")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Free Supply"; rec."Free Supply")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Location Code"; rec."Location Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Outbound Whse. Handling Time"; rec."Outbound Whse. Handling Time")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Shipment Method Code"; rec."Shipment Method Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Shipping Agent Code"; rec."Shipping Agent Code")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Shipping Time"; rec."Shipping Time")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Late Order Shipping"; rec."Late Order Shipping")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Package Tracking No."; rec."Package Tracking No.")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Shipment Date"; rec."Shipment Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Shipping Advice"; rec."Shipping Advice")
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         IF rec."Shipping Advice" <> xRec."Shipping Advice" THEN
//                             IF NOT CONFIRM(Text001, FALSE, rec.FIELDCAPTION(rec."Shipping Advice")) THEN
//                                 ERROR(Text002);
//                     end;
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
//                         SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);
//                     end;
//                 }
//                 field("EU 3-Party Trade"; rec."EU 3-Party Trade")
//                 {
//                     ApplicationArea = all;
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
//                 field("Exit Point"; rec."Exit Point")
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

//             }
//             group("Tax Information")
//             {
//                 Caption = 'Tax Information';
//                 field("Transit Document"; rec."Transit Document")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Free Supply2"; rec."Free Supply")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("TDS Certificate Receivable"; rec."TDS Certificate Receivable")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Calc. Inv. Discount (%)"; rec."Calc. Inv. Discount (%)")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Export or Deemed Export"; rec.rec."Export or Deemed Export")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("VAT Exempted"; rec."VAT Exempted")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Trading; rec.Trading)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("ST Pure Agent"; rec."ST Pure Agent")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Re-Dispatch"; rec."Re-Dispatch")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         ReDispatchOnPush;
//                         IF NOT rec."Re-Dispatch" AND (rec."Return Re-Dispatch Rcpt. No." <> '') THEN
//                             ERROR(Text16500);
//                         IF rec."Re-Dispatch" THEN BEGIN
//                             ReturnOrderNoVisible := TRUE;
//                         END ELSE
//                             ReturnOrderNoVisible := FALSE;
//                     end;
//                 }
//                 field(PoT; rec.PoT)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(ReturnOrderNo; rec."Return Re-Dispatch Rcpt. No.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Return Receipt No.';
//                     Visible = ReturnOrderNoVisible;
//                 }
//                 field("Road Permit No."; rec."Road Permit No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("LC No."; rec."LC No.")
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
//                 field("Posting Date2"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Date of Removal';
//                 }
//                 field("Time of Removal1"; rec."Time of Removal")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Mode of Transport"; rec."Mode of Transport")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Mode of Transport';
//                 }
//                 field("Service Tax Rounding Precision"; rec."Service Tax Rounding Precision")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Service Tax Rounding Type"; rec."Service Tax Rounding Type")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group("LR Details")
//             {
//                 Caption = 'LR Details';
//                 field("Transport Type"; rec."Transport Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 group("Local+Intercity Details")
//                 {
//                     Caption = 'Local+Intercity Details';
//                     field("Local LR No."; rec."Local LR No.")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Local LR Date"; rec."Local LR Date")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Local Vehicle No."; rec."Local Vehicle No.")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Local Driver's Name"; rec."Local Driver's Name")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Local Driver's License No."; rec."Local Driver's License No.")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Local Driver's Mobile No."; rec."Local Driver's Mobile No.")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Local Vehicle Capacity"; rec."Local Vehicle Capacity")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Local Expected TPT Cost"; rec."Local Expected TPT Cost")
//                     {
//                         ApplicationArea = all;
//                     }
//                 }
//                 group("Intercity Details")
//                 {
//                     Caption = 'Intercity Details';
//                     field("LR/RR No."; rec."LR/RR No.")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'LR/RR No.';
//                     }
//                     field("LR/RR Date"; rec."LR/RR Date")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'LR/RR Date';
//                     }
//                     field("Vehicle No."; rec."Vehicle No.")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Vehicle No.';
//                     }
//                     field("Driver's Name"; rec."Driver's Name")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Driver's License No."; rec."Driver's License No.")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Driver's Mobile No."; rec."Driver's Mobile No.")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Vehicle Capacity"; rec."Vehicle Capacity")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Expected TPT Cost"; rec."Expected TPT Cost")
//                     {
//                         ApplicationArea = all;
//                     }
//                 }
//                 group(Others)
//                 {
//                     Caption = 'Others';
//                     field("Posting Date3"; rec."Posting Date")
//                     {
//                         Editable = false;
//                         ApplicationArea = all;
//                     }
//                     field("Time of Removal"; rec."Time of Removal")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Freight Type"; rec."Freight Type")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Freight Charges"; rec."Freight Charges")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Export Under Rebate"; rec."Export Under Rebate")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Under Rebate"; rec."Under Rebate")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Export Under Rebate Check';
//                     }
//                     field("Export Under LUT"; rec."Export Under LUT")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Under LUT"; rec."Under LUT")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Export Under LUT Check';
//                     }
//                     field("Ex-Factory"; rec."Ex-Factory")
//                     {
//                         ApplicationArea = all;
//                     }
//                 }
//                 group("CT3 Details")
//                 {
//                     Caption = 'CT3 Details';
//                     Visible = false;
//                     field("CT3 Order"; rec."CT3 Order")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("CT3 No."; rec."CT3 No.")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("CT3 Date"; rec."CT3 Date")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("ARE3 No."; rec."ARE3 No.")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("ARE3 Date"; rec."ARE3 Date")
//                     {
//                         ApplicationArea = all;
//                     }
//                 }
//                 group("CT1 Details")
//                 {
//                     Caption = 'CT1 Details';
//                     Visible = false;
//                     field("CT1 Order"; rec."CT1 Order")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("CT1 No."; rec."CT1 No.")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("CT1 Date"; rec."CT1 Date")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("ARE1 No."; rec."ARE1 No.")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("ARE1 Date"; rec."ARE1 Date")
//                     {
//                         ApplicationArea = all;
//                     }
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part(part1; 9103)
//             {
//                 SubPageLink = "Table ID" = CONST(36),
//                               "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("No.");
//                 Visible = OpenApprovalEntriesExistForCurrUser;
//                 ApplicationArea = all;
//             }
//             part(part2; 9080)
//             {
//                 SubPageLink = "No".=FIELD("Sell-to Customer No.");
//                     Visible = true;
//                     ApplicationArea = all;
//             }
//             part(part3; 9082)
//             {
//                 SubPageLink = "No." = FIELD("Bill-to Customer No.");
//                 Visible = false;
//                 ApplicationArea = all;
//             }
//             part(part4; 9084)
//             {
//                 SubPageLink = "No." = FIELD("Sell-to Customer No.");
//                 Visible = false;
//                 ApplicationArea = all;
//             }
//             part(part5; 9087)
//             {
//                 Provider = SalesLines;
//                 SubPageLink = "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("Document No."),
//                               "Line No." = FIELD("Line No.");
//                 Visible = true;
//                 ApplicationArea = all;
//             }
//             part(part6; 9089)
//             {
//                 Provider = SalesLines;
//                 SubPageLink = "No." = FIELD("No.");
//                 Visible = false;
//                 ApplicationArea = all;
//             }
//             part(part7; 9092)
//             {
//                 SubPageLink = "Table ID" = CONST(36),
//                               "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("No.");
//                 Visible = false;
//                 ApplicationArea = all;
//             }
//             part(IncomingDocAttachFactBox; 193)
//             {
//                 ShowFilter = false;
//                 Visible = false;
//                 ApplicationArea = all;
//             }
//             part(part8; 9108)
//             {
//                 Provider = SalesLines;
//                 SubPageLink = "No." = FIELD("No.");
//                 Visible = false;
//                 ApplicationArea = all;
//             }
//             part(part9; 9109)
//             {
//                 Provider = SalesLines;
//                 SubPageLink = "No." = FIELD("No.");
//                 Visible = false;
//                 ApplicationArea = all;
//             }
//             part(part10; 9081)
//             {
//                 SubPageLink = "No." = FIELD("Bill-to Customer No.");
//                 Visible = false;
//                 ApplicationArea = all;
//             }
//             part(WorkflowStatus; 1528)
//             {
//                 Editable = false;
//                 Enabled = false;
//                 ShowFilter = false;
//                 Visible = ShowWorkflowStatus;
//                 ApplicationArea = all;
//             }
//             systempart(part11; Links)
//             {
//                 Visible = false;
//                 ApplicationArea = all;
//             }
//             systempart(part12; Notes)
//             {
//                 Visible = true;
//                 ApplicationArea = all;
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
//                 action(Statistics)
//                 {
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ShortCutKey = 'F7';
//                     ApplicationArea = all;

//                     trigger OnAction()
//                     begin
//                         OpenSalesOrderStatistics;
//                         SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 action(Card)
//                 {
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page 21;
//                     RunPageLink = "No." = FIELD("Sell-to Customer No.");
//                     ShortCutKey = 'Shift+F7';
//                     ApplicationArea = all;
//                 }
//                 action(Dimensions)
//                 {
//                     AccessByPermission = TableData 348 = R;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     ShortCutKey = 'Shift+Ctrl+D';
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         ShowDocDim;
//                         CurrPage.SAVERECORD;
//                     end;
//                 }
//                 action("A&pprovals")
//                 {
//                     Caption = 'A&pprovals';
//                     Image = Approvals;
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page 658;
//                     begin
//                         ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
//                         ApprovalEntries.RUN;
//                     end;
//                 }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page 67;
//                     RunPageLink = "Document Type" = FIELD("Document Type"),
//                                   "No." = FIELD("No."),
//                                   "Document Line No." = CONST(0);
//                     ApplicationArea = all;
//                 }
//                 action("Credit Cards Transaction Lo&g Entries")
//                 {
//                     Caption = 'Credit Cards Transaction Lo&g Entries';
//                     Image = CreditCardLog;
//                     RunObject = Page 829;
//                     RunPageLink = Document Type=FIELD(Document Type),
//                                   Document No.=FIELD(No.),
//                                   Customer No.=FIELD(Bill-to Customer No.);
//                     Visible = false;
//                 }
//                 separator()
//                 {
//                 }
//                 action("St&ructure")
//                 {
//                     Caption = 'St&ructure';
//                     Image = Hierarchy;
//                     RunObject = Page 16305;
//                                     RunPageLink = Type=CONST(Sale),
//                                   "Document Type"=FIELD("Document Type"),
//                                   "Document No."=FIELD("No."),
//                                   "Structure Code"=FIELD(Structure),
//                                   "Document Line No."=FILTER(0);
//                                   ApplicationArea = all;
//                 }
//                 action("Transit Documents")
//                 {
//                     Caption = 'Transit Documents';
//                     Image = TransferOrder;
//                     RunObject = Page 13705;
//                                     RunPageLink = Type=CONST(Sale),
//                                   "PO / SO No."=FIELD("No."),
//                                   "Vendor / Customer Ref."=FIELD("Sell-to Customer No."),
//                                   State=FIELD(State);
//                                   ApplicationArea = all;
//                 }
//                 action("Detailed &Tax")
//                 {
//                     Caption = 'Detailed &Tax';
//                     Image = TaxDetail;
//                     RunObject = Page 16342;
//                                     RunPageLink = "Document Type"=FIELD("Document Type"),
//                                   "Document No."=FIELD("No."),
//                                   "Transaction Type"=CONST(Sale);
//                                   ApplicationArea = all;
//                 }
//                 action("Assembly Orders")
//                 {
//                     AccessByPermission = TableData 90=R;
//                     Caption = 'Assembly Orders';
//                     Image = AssemblyOrder;
// ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         AssembleToOrderLink: Record 904;
//                     begin
//                         AssembleToOrderLink.ShowAsmOrders(Rec);
//                     end;
//                 }
//             }
//             group(ActionGroupCRM)
//             {
//                 Caption = 'Dynamics CRM';
//                 Visible = CRMIntegrationEnabled;
//                 action(CRMGoToSalesOrder)
//                 {
//                     Caption = 'Sales Order';
//                     Enabled = CRMIntegrationEnabled AND CRMIsCoupledToRecord;
//                     Image = CoupledOrder;
//                     ToolTip = 'Open the coupled Microsoft Dynamics CRM sales order.';
// ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         CRMIntegrationManagement: Codeunit 5330;
//                     begin
//                         CRMIntegrationManagement.ShowCRMEntityFromRecordID(RECORDID);
//                     end;
//                 }
//             }
//             group(Documents)
//             {
//                 Caption = 'Documents';
//                 Image = Documents;
//                 action("S&hipments")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'S&hipments';
//                     Image = Shipment;
//                     RunObject = Page 142;
//                                     RunPageLink = "Order No."=FIELD("No.");
//                     RunPageView = SORTING("Order No.");
//                 }
//                 action(Invoices)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Invoices';
//                     Image = Invoice;
//                     RunObject = Page 143;
//                                     RunPageLink = "Order No."=FIELD("No.");
//                     RunPageView = SORTING("Order No.");
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 action("In&vt. Put-away/Pick Lines")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'In&vt. Put-away/Pick Lines';
//                     Image = PickLines;
//                     RunObject = Page 5774;
//                                     RunPageLink = "Source Document"=CONST("Sales Order"),
//                                   "Source No."=FIELD("No.");
//                     RunPageView = SORTING("Source Document","Source No.","Location Code");
//                 }
//                 action("Whse. Shipment Lines")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Whse. Shipment Lines';
//                     Image = ShipmentLines;
//                     RunObject = Page 7341;
//                                     RunPageLink = "Source Type"=CONST(37),
//                                   "Source Subtype"=FIELD("Document Type"),
//                                   "Source No."=FIELD("No.");
//                     RunPageView = SORTING("Source Type","Source Subtype","Source No.","Source Line No.");
//                 }
//             }
//             group(Prepayment)
//             {
//                 Caption = 'Prepayment';
//                 Image = Prepayment;
//                 action(PagePostedSalesPrepaymentInvoices)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Prepa&yment Invoices';
//                     Image = PrepaymentInvoice;
//                     RunObject = Page 143;
//                                     RunPageLink = "Prepayment Order No."=FIELD("No.");
//                     RunPageView = SORTING("Prepayment Order No.");
//                     Visible = false;
//                 }
//                 action(PagePostedSalesPrepaymentCrMemos)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Prepayment Credi&t Memos';
//                     Image = PrepaymentCreditMemo;
//                     RunObject = Page 144;
//                                     RunPageLink = "Prepayment Order No."=FIELD("No.");
//                     RunPageView = SORTING("Prepayment Order No.");
//                     Visible = false;
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
//                         ReleaseSalesDoc: Codeunit 414;
//                     begin
//                         ReleaseSalesDoc.PerformManualRelease(Rec);
//                     end;
//                 }
//                 action("Re&open")
//                 {
//                     Caption = 'Re&open';
//                     Image = ReOpen;
//                     Promoted = true;
//                     PromotedCategory = Process;
// ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         ReleaseSalesDoc: Codeunit 414;
//                     begin
//                         ReleaseSalesDoc.PerformManualReopen(Rec);
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
//                     Caption = 'Calculate &Invoice Discount';
//                     Image = CalculateInvoiceDiscount;

//                     trigger OnAction()
//                     begin
//                         CALCFIELDS("Price Inclusive of Taxes");
//                         IF NOT "Price Inclusive of Taxes" THEN
//                           ApproveCalcInvDisc
//                         ELSE
//                           ERROR(STRSUBSTNO(Text16501,FIELDCAPTION("Price Inclusive of Taxes")));
//                         SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 action("Get St&d. Cust. Sales Codes")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Get St&d. Cust. Sales Codes';
//                     Ellipsis = true;
//                     Image = CustomerCode;
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         StdCustSalesCode: Record 172;
//                     begin
//                         StdCustSalesCode.InsertSalesLines(Rec);
//                     end;
//                 }
//                 action(CopyDocument)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Copy Document';
//                     Ellipsis = true;
//                     Image = CopyDocument;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         CopySalesDoc.SetSalesHeader(Rec);
//                         CopySalesDoc.RUNMODAL;
//                         CLEAR(CopySalesDoc);
//                         IF GET("Document Type","No.") THEN;
//                     end;
//                 }
//                 action(MoveNegativeLines)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Move Negative Lines';
//                     Ellipsis = true;
//                     Image = MoveNegativeLines;

//                     trigger OnAction()
//                     begin
//                         CLEAR(MoveNegSalesLines);
//                         MoveNegSalesLines.SetSalesHeader(Rec);
//                         MoveNegSalesLines.RUNMODAL;
//                         MoveNegSalesLines.ShowDocument;
//                     end;
//                 }
//                 action("Archive Document")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Archi&ve Document';
//                     Image = Archive;

//                     trigger OnAction()
//                     begin
//                         ArchiveManagement.ArchiveSalesDocument(Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Send IC Sales Order Cnfmn.")
//                 {
//                     ApplicationArea = all;
//                     AccessByPermission = TableData 410=R;
//                     Caption = 'Send IC Sales Order Cnfmn.';
//                     Image = IntercompanyOrder;
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         ICInOutboxMgt: Codeunit 427;
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
//                           ICInOutboxMgt.SendSalesDoc(Rec,FALSE);
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
//                         ApplicationArea = all;
//                         AccessByPermission = TableData 130=R;
//                         Caption = 'Select Incoming Document';
//                         Image = SelectLineToApply;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

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
//                             IncomingDocumentAttachment.NewAttachmentFromSalesDocument(Rec);
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
//             group(Plan)
//             {
//                 Caption = 'Plan';
//                 Image = Planning;
//                 action("Order &Promising")
//                 {
//                     ApplicationArea = all;
//                     AccessByPermission = TableData 99000880=R;
//                     Caption = 'Order &Promising';
//                     Image = OrderPromising;

//                     trigger OnAction()
//                     var
//                         OrderPromisingLine: Record "99000880" temporary;
//                     begin
//                         OrderPromisingLine.SETRANGE("Source Type","Document Type");
//                         OrderPromisingLine.SETRANGE("Source ID","No.");
//                         PAGE.RUNMODAL(PAGE::"Order Promising Lines",OrderPromisingLine);
//                     end;
//                 }
//                 action("Demand Overview")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Demand Overview';
//                     Image = Forecast;

//                     trigger OnAction()
//                     var
//                         DemandOverview: Page 5830;
//                     begin
//                         DemandOverview.SetCalculationParameter(TRUE);
//                         DemandOverview.Initialize(0D,1,"No.",'','');
//                         DemandOverview.RUNMODAL;
//                     end;
//                 }
//                 action("Pla&nning")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Pla&nning';
//                     Image = Planning;

//                     trigger OnAction()
//                     var
//                         SalesPlanForm: Page 99000883;
//                     begin
//                         SalesPlanForm.SetSalesOrder("No.");
//                         SalesPlanForm.RUNMODAL;
//                     end;
//                 }
//             }
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 Image = SendApprovalRequest;
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
//                         IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
//                           ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
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
//                         ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
//                     end;
//                 }
//             }
//             group("Credit Card")
//             {
//                 Caption = 'Credit Card';
//                 Image = AuthorizeCreditCard;
//                 action(Authorize)
//                 {
//                     Caption = 'Authorize';
//                     Image = AuthorizeCreditCard;
//                     Visible = false;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         Authorize;
//                     end;
//                 }
//                 action("Void A&uthorize")
//                 {
//                     Caption = 'Void A&uthorize';
//                     Image = VoidCreditCard;
//                     Visible = false;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         Void;
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action("Calc&ulate Structure Values")
//                 {
//                     Caption = 'Calc&ulate Structure Values';
//                     Image = CalculateHierarchy;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         CALCFIELDS("Price Inclusive of Taxes");
//                         IF "Price Inclusive of Taxes" THEN BEGIN
//                           SalesLine.InitStrOrdDetail(Rec);
//                           SalesLine.GetSalesPriceExclusiveTaxes(Rec);
//                           SalesLine.UpdateSalesLinesPIT(Rec);
//                         END;
//                         SalesLine.CalculateStructures(Rec);
//                         SalesLine.AdjustStructureAmounts(Rec);
//                         SalesLine.UpdateSalesLines(Rec);
//                     end;
//                 }
//                 action("Calculate TCS")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Calculate TCS';
//                     Image = CalculateCollectedTax;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         SalesLine.CalculateStructures(Rec);
//                         SalesLine.AdjustStructureAmounts(Rec);
//                         SalesLine.UpdateSalesLines(Rec);
//                         SalesLine.CalculateTCS(Rec);
//                     end;
//                 }
//                 action("Direct Debit To PLA / RG")
//                 {
//                     Caption = 'Direct Debit To PLA / RG';
//                     Image = Change;
//                     Visible = false;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         SalesLine.CalculateStructures(Rec);
//                         SalesLine.AdjustStructureAmounts(Rec);
//                         SalesLine.UpdateSalesLines(Rec);
//                         OpenExciseCentvatClaimForm;
//                     end;
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 action("Create Inventor&y Put-away/Pick")
//                 {
//                     AccessByPermission = TableData 7342=R;
//                     Caption = 'Create Inventor&y Put-away/Pick';
//                     Ellipsis = true;
//                     Image = CreateInventoryPickup;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     Visible = false;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         CreateInvtPutAwayPick;

//                         IF NOT FIND('=><') THEN
//                           INIT;
//                     end;
//                 }
//                 action("Create &Whse. Shipment")
//                 {
//                     AccessByPermission = TableData 7320=R;
//                     Caption = 'Create &Whse. Shipment';
//                     Image = NewShipment;
// ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         GetSourceDocOutbound: Codeunit 5752;
//                     begin
//                         GetSourceDocOutbound.CreateFromSalesOrder(Rec);

//                         IF NOT FIND('=><') THEN
//                           INIT;
//                     end;
//                 }
//             }
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 Image = Post;
//                 action(Post)
//                 {
//                     Caption = 'P&ost';
//                     Ellipsis = true;
//                     Image = PostOrder;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F9';
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin

//                         //PM 01 ---Start---//
//                         /*IF ("LR/RR No."='') OR ("LR/RR Date"=0D) OR ("Vehicle No."='') OR ("Driver Name"='') OR ("Phone No"='') THEN
//                           ERROR('LR Details Mandatory'); */
//                         //PM 01 ----Stop---//
//                         Post(CODEUNIT::"Sales-Post (Yes/No)");

//                     end;
//                 }
//                 action("Post and &Print")
//                 {
//                     Caption = 'Post and &Print';
//                     Ellipsis = true;
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Shift+F9';
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         Post(CODEUNIT::"Sales-Post + Print");
//                     end;
//                 }
//                 action("Post and Email")
//                 {
//                     Caption = 'Post and Email';
//                     Ellipsis = true;
//                     Image = PostMail;
// ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         SalesPostPrint: Codeunit 82;
//                     begin
//                         SalesPostPrint.PostAndEmail(Rec);
//                     end;
//                 }
//                 action("Test Report")
//                 {
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         ReportPrint.PrintSalesHeader(Rec);
//                     end;
//                 }
//                 action("Post &Batch")
//                 {
//                     Caption = 'Post &Batch';
//                     Ellipsis = true;
//                     Image = PostBatch;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders",TRUE,TRUE,Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Remove From Job Queue")
//                 {
//                     Caption = 'Remove From Job Queue';
//                     Image = RemoveLine;
//                     Visible = JobQueueVisible;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         CancelBackgroundPosting;
//                     end;
//                 }
//                 action(PreviewPosting)
//                 {
//                     Caption = 'Preview Posting';
//                     Image = ViewPostedOrder;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         ShowPreview;
//                     end;
//                 }
//                 group("Prepa&yment")
//                 {
//                     Caption = 'Prepa&yment';
//                     Image = Prepayment;
//                     action("Prepayment &Test Report")
//                     {
//                         Caption = 'Prepayment &Test Report';
//                         Ellipsis = true;
//                         Image = PrepaymentSimulation;
// ApplicationArea = all;
//                         trigger OnAction()
//                         begin
//                             ReportPrint.PrintSalesHeaderPrepmt(Rec);
//                         end;
//                     }
//                     action(PostPrepaymentInvoice)
//                     {
//                         Caption = 'Post Prepayment &Invoice';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;
// ApplicationArea = all;
//                         trigger OnAction()
//                         var
//                             SalesPostYNPrepmt: Codeunit "443";
//                         begin
//                             IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
//                               SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec,FALSE);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Invoic&e")
//                     {
//                         Caption = 'Post and Print Prepmt. Invoic&e';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;
// ApplicationArea = all;
//                         trigger OnAction()
//                         var
//                             SalesPostYNPrepmt: Codeunit 443;
//                         begin
//                             IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
//                               SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec,TRUE);
//                         end;
//                     }
//                     action(PostPrepaymentCreditMemo)
//                     {
//                         Caption = 'Post Prepayment &Credit Memo';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;
// ApplicationArea = all;
//                         trigger OnAction()
//                         var
//                             SalesPostYNPrepmt: Codeunit 443;
//                         begin
//                             IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
//                               SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec,FALSE);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Cr. Mem&o")
//                     {
//                         Caption = 'Post and Print Prepmt. Cr. Mem&o';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;
// ApplicationArea = all;
//                         trigger OnAction()
//                         var
//                             SalesPostYNPrepmt: Codeunit 443;
//                         begin
//                             IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
//                               SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec,TRUE);
//                         end;
//                     }
//                 }
//             }
//             group("&Print")
//             {
//                 Caption = '&Print';
//                 Image = Print;
//                 action("Pick Instruction")
//                 {
//                     Caption = 'Pick Instruction';
//                     Image = Print;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintSalesOrder(Rec,Usage::"Pick Instruction");
//                     end;
//                 }
//             }
//             group("&Order Confirmation")
//             {
//                 Caption = '&Order Confirmation';
//                 Image = Email;
//                 action("Order Confirmation")
//                 {
//                     Caption = 'Order Confirmation';
//                     Ellipsis = true;
//                     Image = Print;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintSalesOrder(Rec,Usage::"Order Confirmation");
//                     end;
//                 }
//                 action("Work Order")
//                 {
//                     Caption = 'Work Order';
//                     Ellipsis = true;
//                     Image = Print;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintSalesOrder(Rec,Usage::"Work Order");
//                     end;
//                 }
//                 action("Email Confirmation")
//                 {
//                     Caption = 'Email Confirmation';
//                     Ellipsis = true;
//                     Image = Email;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         DocPrint.EmailSalesHeader(Rec);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     var
//         CRMCouplingManagement: Codeunit 5331;
//     begin
//         DynamicEditable := CurrPage.EDITABLE;
//         CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
//         CRMIsCoupledToRecord := CRMIntegrationEnabled AND CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
//         ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         SetControlVisibility;
//         IF "Re-Dispatch" THEN
//           ReturnOrderNoVisible := TRUE
//         ELSE
//           ReturnOrderNoVisible := FALSE;
//     end;

//     trigger OnDeleteRecord(): Boolean
//     begin
//         CurrPage.SAVERECORD;
//         EXIT(ConfirmDeletion);
//     end;

//     trigger OnInit()
//     begin
//         ReturnOrderNoVisible := TRUE;
//         SetExtDocNoMandatoryCondition;
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         CheckCreditMaxBeforeInsert;
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         IF "Re-Dispatch" THEN
//           ReturnOrderNoVisible := TRUE
//         ELSE
//           ReturnOrderNoVisible := FALSE;
//         // CurrForm.SalesLines.PAGE.UPDATECONTROLS;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         "Responsibility Center" := UserMgt.GetSalesFilter;
//     end;

//     trigger OnOpenPage()
//     var
//         CRMIntegrationManagement: Codeunit 5330;
//     begin
//         IF UserMgt.GetSalesFilter <> '' THEN BEGIN
//           FILTERGROUP(2);
//           SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
//           FILTERGROUP(0);
//         END;

//         SETRANGE("Date Filter",0D,WORKDATE - 1);
//         SetDocNoVisible;

//         CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
//     end;

//     var
//         CopySalesDoc: Report 292;
//                           MoveNegSalesLines: Report 6699;
//                           ApprovalsMgmt: Codeunit 1535;
//                           ReportPrint: Codeunit 228;
//                           DocPrint: Codeunit 229;
//                           ArchiveManagement: Codeunit 5063;
//                           SalesCalcDiscountByType: Codeunit 56;
//                           SalesSetup: Record 311;
//                           ChangeExchangeRate: Page 511;
//                           UserMgt: Codeunit 5700;
//                           Usage: Option "Order Confirmation","Work Order","Pick Instruction";
//                           SalesLine: Record 37;
//                           Text16500: Label 'You can not uncheck Re-Dispatch until Return Receipt No. is Blank.';
//         Text16501: Label 'To calculate invoice discount, check Cal. Inv. Discount on header when Price Inclusive of Tax = Yes.\This option cannot be used to calculate invoice discount when Price Inclusive Tax = Yes.';
//         [InDataSet]
//         ReturnOrderNoVisible: Boolean;
//         [InDataSet]
//         JobQueueVisible: Boolean;
//         Text001: Label 'Do you want to change %1 in all related records in the warehouse?';
//         Text002: Label 'The update has been interrupted to respect the warning.';
//         DynamicEditable: Boolean;
//         HasIncomingDocument: Boolean;
//         DocNoVisible: Boolean;
//         ExternalDocNoMandatory: Boolean;
//         OpenApprovalEntriesExistForCurrUser: Boolean;
//         OpenApprovalEntriesExist: Boolean;
//         CRMIntegrationEnabled: Boolean;
//         CRMIsCoupledToRecord: Boolean;
//         ShowWorkflowStatus: Boolean;
//         SalesPerCodeEditable: Boolean;
//         SalesHead: Record 36;
//         ReservEntr: Record 337;
//         recDetailRG23D: Record 16533;
//         SalesHead1: Record 36;
//         ShortCloseEdtiable: Boolean;
//         User: Record 91;
//         recSalesApprovalEntry1: Record 50009;
//         recSalesApprovalEntry: Record 50009;
//         recSalesApproval: Record 50008;
//         ApprovalStatus: Text[30];
//         StateDesc: Text[30];
//         Ship2StateDesc: Text[30];
//         recState: Record 13762;
//         recState1: Record 13762;
//         Ship2Add: Record 222;
//         SaleLineNew: Record 37;
//         SalesApprovalEntry: Record 50009;
//         recSalLine: Record 37;
//         vInventQty: Decimal;
//         recIlentry: Record 32;
//         recsalesLineTable: Record 37;
//         ResEntryQty: Decimal;
//         recResEntry: Record 337;
//         recCust: Record 18;
//         CustState: Code[10];
//         recLoc: Record 14;
//         LocState: Code[10];
//         recShiptoAdd: Record 222;
//         ShiptoCodeState: Code[10];
//         FormAvCrd: Page "50069";
//                        recSL: Record 37;
//                        SalesApproval: Record 50008;
//                        Saaleslinerec: Record 37;
//                        SH: Record 36;

//     local procedure Post(PostingCodeunitID: Integer)
//     begin
//         SendToPosting(PostingCodeunitID);
//         IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
//             CurrPage.CLOSE;
//         CurrPage.UPDATE(FALSE);
//     end;

//     local procedure ApproveCalcInvDisc()
//     begin
//         CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
//     end;

//     local procedure SelltoCustomerNoOnAfterValidat()
//     begin
//         IF GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
//             IF "Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
//                 SETRANGE("Sell-to Customer No.");
//         CurrPage.UPDATE;
//     end;

//     local procedure SalespersonCodeOnAfterValidate()
//     begin
//         CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
//     end;

//     local procedure BilltoCustomerNoOnAfterValidat()
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

//     local procedure ReDispatchOnPush()
//     begin
//         IF "Re-Dispatch" THEN
//             CurrPage.SalesLines.PAGE.MakeVisibleLineControl
//         ELSE
//             CurrPage.SalesLines.PAGE.MakeInvisibleLineControl;
//     end;

//     local procedure SetDocNoVisible()
//     var
//         DocumentNoVisibility: Codeunit 1400;
//         DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
//     begin
//         DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Order, "No.");
//     end;

//     local procedure SetExtDocNoMandatoryCondition()
//     var
//         SalesReceivablesSetup: Record 311;
//     begin
//         SalesReceivablesSetup.GET;
//         ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory"
//     end;

//     local procedure ShowPreview()
//     var
//         SalesPostYesNo: Codeunit 81;
//     begin
//         SalesPostYesNo.Preview(Rec);
//     end;

//     local procedure SetControlVisibility()
//     var
//         ApprovalsMgmt: Codeunit "1535";
//     begin
//         JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
//         HasIncomingDocument := "Incoming Document Entry No." <> 0;
//         SetExtDocNoMandatoryCondition;

//         OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
//         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
//     end;
// }

