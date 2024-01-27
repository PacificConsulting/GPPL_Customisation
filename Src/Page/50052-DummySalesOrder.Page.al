// page 50052 "Dummy Sales Order"
// {
//     // 
//     // EBT/SHORTCLOSE/0001        Pratyusha   14/02/2012   For Short Close Functionality
//     // 06/03/2012 EBT/OVERDUE/APV/0001 codes added for Cr. Limit Approval Functionalilty
//     // EBT/SOTYPE/0001           Pratyusha    28/03/2012   For Sales order type functionality

//     Caption = 'Dummy Sales Order';
//     PageType = Document;
//     PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
//     RefreshOnActivate = true;
//     SourceTable = 36;
//     SourceTableView = WHERE("Document Type" = FILTER(Order),
//                             "Sales Order Type" = FILTER(Dummy));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; rec."No.")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Promoted;
//                     Visible = DocNoVisible;

//                     trigger OnAssistEdit()
//                     begin
//                         IF rec.AssistEdit(xRec) THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Sell-to Customer No."; rec."Sell-to Customer No.")
//                 {
//                     applicationarea = all;
//                     Importance = Promoted;
//                     ShowMandatory = true;

//                     trigger OnValidate()
//                     begin
//                         SelltoCustomerNoOnAfterValidat;
//                     end;
//                 }
//                 field("Sell-to Contact No."; rec."Sell-to Contact No.")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;

//                     trigger OnValidate()
//                     begin
//                         IF GETFILTER("Sell-to Contact No.") = xRec."Sell-to Contact No." THEN
//                             IF "Sell-to Contact No." <> xRec."Sell-to Contact No." THEN
//                                 SETRANGE("Sell-to Contact No.");
//                     end;
//                 }
//                 field("Sell-to Customer Name"; rec."Sell-to Customer Name")
//                 {
//                     Editable = false;
//                     QuickEntry = false;
//                 }
//                 field("Sell-to Address"; rec."Sell-to Address")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Sell-to Address 2"; rec."Sell-to Address 2")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Sell-to Post Code"; rec."Sell-to Post Code")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Sell-to City"; rec."Sell-to City")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     QuickEntry = false;
//                 }
//                 field("Sell-to Contact"; rec."Sell-to Contact")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("No. of Archived Versions"; rec."No. of Archived Versions")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                 }
//                 // field(Structure; rec.Structure)
//                 // {
//                 //     applicationarea = all;
//                 //     Importance = Promoted;
//                 // }
//                 field("Short Close"; rec."Short Close")
//                 {
//                     applicationarea = all;
//                     Editable = ShortCloseEdtiable;
//                 }
//                 field("Short Close Date"; rec."Short Close Date")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Sales Order Type"; rec."Sales Order Type")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                 }
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     QuickEntry = false;
//                 }
//                 field("Order Date"; rec."Order Date")
//                 {
//                     applicationarea = all;
//                     Caption = 'External Document Date';
//                     Importance = Promoted;
//                     QuickEntry = false;
//                 }
//                 field("Document Date"; rec."Document Date")
//                 {
//                     applicationarea = all;
//                     Caption = 'Sales Order Date';
//                     QuickEntry = false;
//                 }
//                 field("Requested Delivery Date"; rec."Requested Delivery Date")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Promised Delivery Date"; rec."Promised Delivery Date")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                 }
//                 field("Quote No."; rec."Quote No.")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                     Visible = false;
//                 }
//                 field("External Document No."; rec."External Document No.")
//                 {
//                     applicationarea = all;
//                     Importance = Promoted;
//                     ShowMandatory = ExternalDocNoMandatory;

//                     trigger OnValidate()
//                     begin
//                         //RSPL-TC +
//                         IF "External Document No." <> '' THEN
//                             IF STRLEN("External Document No.") > 20 THEN
//                                 ERROR('External Document No. should not more then 20 characters');
//                         //RSPL-TC -
//                     end;
//                 }
//                 field("Salesperson Code"; rec."Salesperson Code")
//                 {
//                     applicationarea = all;
//                     Editable = SalesPerCodeEditable;
//                     QuickEntry = false;

//                     trigger OnValidate()
//                     begin
//                         SalespersonCodeOnAfterValidate;
//                     end;
//                 }
//                 field("Campaign No."; rec."Campaign No.")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                     Visible = false;
//                 }
//                 field("Opportunity No."; rec."Opportunity No.")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                     Visible = false;
//                 }
//                 field("Responsibility Center"; rec."Responsibility Center")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                 }
//                 field("Assigned User ID"; rec."Assigned User ID")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                 }
//                 field(Status; rec.Status)
//                 {
//                     applicationarea = all;
//                     Importance = Promoted;
//                     QuickEntry = false;
//                 }
//                 field("Job Queue Status"; rec."Job Queue Status")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                     Visible = false;
//                 }
//             }
//             part(SalesLines; 46)
//             {
//                 applicationarea = all;
//                 Editable = DynamicEditable;
//                 SubPageLink = "Document No." = FIELD("No.");
//                 UpdatePropagation = Both;
//             }
//             group(Invoicing)
//             {
//                 Caption = 'Invoicing';
//                 field("Bill-to Customer No."; rec."Bill-to Customer No.")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         BilltoCustomerNoOnAfterValidat;
//                     end;
//                 }
//                 field("Bill-to Contact No."; rec."Bill-to Contact No.")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                 }
//                 field("Bill-to Name"; rec."Bill-to Name")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                 }
//                 field("Bill-to Address"; rec."Bill-to Address")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Bill-to Address 2"; rec."Bill-to Address 2")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Bill-to Post Code"; rec."Bill-to Post Code")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Bill-to City"; rec."Bill-to City")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                 }
//                 field("Bill-to Contact"; rec."Bill-to Contact")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Applies-to Doc. Type"; rec."Applies-to Doc. Type")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Applies-to Doc. No."; rec."Applies-to Doc. No.")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Applies-to ID"; rec."Applies-to ID")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Cr. Approved"; rec."Cr. Approved")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                 }
//                 field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
//                 {
//                     applicationarea = all;

//                     trigger OnValidate()
//                     begin
//                         //EBT STIVAN ---(21062012)--- To make SalesPerson Code Editable if Division is DIV-03 ----------START
//                         //CurrForm."Salesperson Code".EDITABLE := "Shortcut Dimension 1 Code" = 'DIV-03';
//                         //RSPL-TC +
//                         IF "Shortcut Dimension 1 Code" = 'DIV-03' THEN
//                             SalesPerCodeEditable := TRUE;
//                         //EBT STIVAN ---(21062012)--- To make SalesPerson Code Editable if Division is DIV-03 ------------END
//                         //RSPL-TC -
//                         ShortcutDimension1CodeOnAfterV;
//                     end;
//                 }
//                 field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
//                 {
//                     applicationarea = all;

//                     trigger OnValidate()
//                     begin
//                         ShortcutDimension2CodeOnAfterV;
//                     end;
//                 }
//                 field("Payment Terms Code"; rec."Payment Terms Code")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Payment Discount %"; rec."Payment Discount %")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Pmt. Discount Date"; rec."Pmt. Discount Date")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Payment Method Code"; rec."Payment Method Code")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Prices Including VAT"; rec."Prices Including VAT")
//                 {
//                     applicationarea = all;

//                     trigger OnValidate()
//                     begin
//                         PricesIncludingVATOnAfterValid;
//                     end;
//                 }
//                 field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
//                 {
//                     applicationarea = all;
//                     Visible = false;
//                 }
//                 field("Credit Card No."; rec."Credit Card No.")
//                 {
//                     applicationarea = all;
//                 }
//                 field(GetCreditcardNumber; rec.GetCreditcardNumber)
//                 {
//                     applicationarea = all;
//                     Caption = 'Cr. Card Number (Last 4 Digits)';
//                 }
//                 field(Amount; rec.Amount)
//                 {
//                     applicationarea = all;
//                 }
//                 field("Posting No. Series"; rec."Posting No. Series")
//                 {
//                     applicationarea = all;
//                     Visible = false;
//                 }
//                 field("Posting No."; rec."Posting No.")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Direct Debit Mandate ID"; rec."Direct Debit Mandate ID")
//                 {
//                     applicationarea = all;
//                     Visible = false;
//                 }
//             }
//             group(Shipping)
//             {
//                 Caption = 'Shipping';
//                 field("Ship-to Code"; rec."Ship-to Code")
//                 {
//                     applicationarea = all;
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         //EBT STIVAN ---(18102012)--- To Update the Sell to State Desc and Ship to State Desc on Form Level------START
//                         IF "Ship-to Code" <> '' THEN BEGIN
//                             Ship2Add.RESET;
//                             Ship2Add.SETRANGE(Ship2Add."Customer No.", "Sell-to Customer No.");
//                             Ship2Add.SETRANGE(Ship2Add.Code, "Ship-to Code");
//                             IF Ship2Add.FINDFIRST THEN BEGIN
//                                 CLEAR(Ship2StateDesc);
//                                 recState1.RESET;
//                                 recState1.SETRANGE(recState1.Code, Ship2Add.State);
//                                 IF recState1.FINDFIRST THEN BEGIN
//                                     Ship2StateDesc := recState1.Description;
//                                 END;
//                             END;
//                         END ELSE BEGIN
//                             CLEAR(Ship2StateDesc);
//                             recState1.RESET;
//                             recState1.SETRANGE(recState1.Code, State);
//                             IF recState1.FINDFIRST THEN BEGIN
//                                 Ship2StateDesc := recState1.Description;
//                             END;
//                         END;
//                         //EBT STIVAN ---(18102012)--- To Update the Sell to State Desc and Ship to State Desc on Form Level--------END
//                     end;
//                 }
//                 field("Ship-to Name"; rec."Ship-to Name")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                 }
//                 field("Ship-to Address"; rec."Ship-to Address")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Ship-to Address 2"; rec."Ship-to Address 2")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Ship-to Post Code"; rec."Ship-to Post Code")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Ship-to City"; rec."Ship-to City")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                 }
//                 field(Ship2StateDesc; rec.Ship2StateDesc)
//                 {
//                     applicationarea = all;
//                     Caption = 'Ship-to State';
//                     Editable = false;
//                 }
//                 field("Ship-to Contact"; rec."Ship-to Contact")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Free Supply"; rec."Free Supply")
//                 {
//                     applicationarea = all;
//                     Visible = false;
//                 }
//                 field("Location Code"; rec."Location Code")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Outbound Whse. Handling Time"; rec."Outbound Whse. Handling Time")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                 }
//                 field("Shipment Method Code"; rec."Shipment Method Code")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Shipping Agent Code"; rec."Shipping Agent Code")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                 }
//                 field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                 }
//                 field("Shipping Time"; rec."Shipping Time")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Late Order Shipping"; rec."Late Order Shipping")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                 }
//                 field("Package Tracking No."; rec."Package Tracking No.")
//                 {
//                     applicationarea = all;
//                     Importance = Additional;
//                 }
//                 field("Shipment Date"; rec."Shipment Date")
//                 {
//                     applicationarea = all;
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Shipping Advice"; rec."Shipping Advice")
//                 {
//                     applicationarea = all;
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         IF "Shipping Advice" <> xRec."Shipping Advice" THEN
//                             IF NOT CONFIRM(Text001, FALSE, FIELDCAPTION("Shipping Advice")) THEN
//                                 ERROR(Text002);
//                     end;
//                 }
//             }
//             group("Foreign Trade")
//             {
//                 Caption = 'Foreign Trade';
//                 field("Currency Code"; rec."Currency Code")
//                 {
//                     Importance = Promoted;
//                     applicationarea = all;

//                     trigger OnAssistEdit()
//                     begin
//                         CLEAR(ChangeExchangeRate);
//                         IF "Posting Date" <> 0D THEN
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
//                     applicationarea = all;
//                 }
//                 field("Transaction Type"; rec."Transaction Type")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Transaction Specification"; rec."Transaction Specification")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Transport Method"; rec."Transport Method")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Exit Point"; rec."Exit Point")
//                 {
//                     applicationarea = all;
//                 }
//                 field(Area1; rec.Area)
//                 {
//                     applicationarea = all;
//                 }
//             }
//             group(Prepayment)
//             {
//                 Caption = 'Prepayment';
//                 field("Prepayment %"; rec."Prepayment %")
//                 {
//                     applicationarea = all;
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         Prepayment37OnAfterValidate;
//                     end;
//                 }
//                 field("Compress Prepayment"; rec."Compress Prepayment")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Prepmt. Payment Terms Code"; rec."Prepmt. Payment Terms Code")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Prepayment Due Date"; rec."Prepayment Due Date")
//                 {
//                     applicationarea = all;
//                     Importance = Promoted;
//                 }
//                 field("Prepmt. Payment Discount %"; rec."Prepmt. Payment Discount %")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Prepmt. Pmt. Discount Date"; rec."Prepmt. Pmt. Discount Date")
//                 {
//                     applicationarea = all;
//                 }
//             }
//             group("Tax Information")
//             {
//                 Caption = 'Tax Information';
//                 field("Transit Document"; rec."Transit Document")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Free Supply2"; rec."Free Supply")
//                 {
//                     applicationarea = all;
//                 }
//                 field("TDS Certificate Receivable"; rec."TDS Certificate Receivable")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Calc. Inv. Discount (%)"; rec."Calc. Inv. Discount (%)")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Export or Deemed Export"; rec."Export or Deemed Export")
//                 {
//                     applicationarea = all;
//                 }
//                 field("VAT Exempted"; rec."VAT Exempted")
//                 {
//                     applicationarea = all;
//                 }
//                 field(Trading; rec.Trading)
//                 {
//                     applicationarea = all;
//                 }
//                 field("ST Pure Agent"; rec."ST Pure Agent")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Re-Dispatch"; rec."Re-Dispatch")
//                 {
//                     applicationarea = all;

//                     trigger OnValidate()
//                     begin
//                         ReDispatchOnPush;
//                         IF NOT "Re-Dispatch" AND ("Return Re-Dispatch Rcpt. No." <> '') THEN
//                             ERROR(Text16500);
//                         IF "Re-Dispatch" THEN BEGIN
//                             ReturnOrderNoVisible := TRUE;
//                         END ELSE
//                             ReturnOrderNoVisible := FALSE;
//                     end;
//                 }
//                 field(PoT; rec.PoT)
//                 {
//                     applicationarea = all;
//                 }
//                 field(ReturnOrderNo; rec."Return Re-Dispatch Rcpt. No.")
//                 {
//                     applicationarea = all;
//                     Caption = 'Return Receipt No.';
//                     Visible = ReturnOrderNoVisible;
//                 }
//                 field("Road Permit No."; rec."Road Permit No.")
//                 {
//                     applicationarea = all;
//                     Visible = false;
//                 }
//                 field("LC No."; rec."LC No.")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Form Code"; rec."Form Code")
//                 {
//                     applicationarea = all;
//                     Importance = Promoted;
//                 }
//                 field("Form No."; rec."Form No.")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Posting Date2"; rec."Posting Date")
//                 {
//                     applicationarea = all;
//                     Caption = 'Date of Removal';
//                 }
//                 field("Time of Removal1"; rec."Time of Removal")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Mode of Transport"; rec."Mode of Transport")
//                 {
//                     applicationarea = all;
//                     Caption = 'Mode of Transport';
//                 }
//                 field("Service Tax Rounding Precision"; rec."Service Tax Rounding Precision")
//                 {
//                     applicationarea = all;
//                 }
//                 field("Service Tax Rounding Type"; rec."Service Tax Rounding Type")
//                 {
//                     applicationarea = all;
//                 }
//             }
//             group("LR Details")
//             {
//                 Caption = 'LR Details';
//                 field("Transport Type"; rec."Transport Type")
//                 {
//                     applicationarea = all;
//                 }
//                 group("Local+Intercity Details")
//                 {
//                     Caption = 'Local+Intercity Details';
//                     field("Local LR No."; rec."Local LR No.")
//                     {
//                         applicationarea = all;
//                         Editable = LocalLRNoEditable;
//                     }
//                     field("Local LR Date"; rec."Local LR Date")
//                     {
//                         applicationarea = all;
//                         Editable = LocalLRDateEditable;
//                     }
//                     field("Local Vehicle No."; rec."Local Vehicle No.")
//                     {
//                         applicationarea = all;
//                         Editable = LocalVehicaleNoEditable;
//                     }
//                     field("Local Driver's Name"; rec."Local Driver's Name")
//                     {
//                         applicationarea = all;
//                         Editable = LocalDrivNameEditable;
//                     }
//                     field("Local Driver's License No."; rec."Local Driver's License No.")
//                     {
//                         applicationarea = all;
//                         Editable = LocalDrivLicNoEditable;
//                     }
//                     field("Local Driver's Mobile No."; rec."Local Driver's Mobile No.")
//                     {
//                         applicationarea = all;
//                         Editable = LocalDrivMobNoEditable;
//                     }
//                     field("Local Vehicle Capacity"; rec."Local Vehicle Capacity")
//                     {
//                         applicationarea = all;
//                         Editable = LocalVechCapEtdiable;
//                     }
//                     field("Local Expected TPT Cost"; rec."Local Expected TPT Cost")
//                     {
//                         applicationarea = all;
//                         Editable = LocalExpTPTCostEditable;
//                         Visible = false;
//                     }
//                 }
//                 group("Intercity Details")
//                 {
//                     Caption = 'Intercity Details';
//                     field("LR/RR No."; rec."LR/RR No.")
//                     {
//                         applicationarea = all;
//                         Caption = 'LR/RR No.';
//                         Editable = "LR/RRNoEditable";
//                     }
//                     field("LR/RR Date"; rec."LR/RR Date")
//                     {
//                         applicationarea = all;
//                         Caption = 'LR/RR Date';
//                         Editable = "LR/RRDateEditable";
//                     }
//                     field("Vehicle No."; rec."Vehicle No.")
//                     {
//                         applicationarea = all;
//                         Caption = 'Vehicle No.';
//                         Editable = VehicaleNoEditable;
//                     }
//                     field("Driver's Name"; rec."Driver's Name")
//                     {
//                         applicationarea = all;
//                         Editable = DrivNameEditable;
//                     }
//                     field("Driver's License No."; rec."Driver's License No.")
//                     {
//                         applicationarea = all;
//                         Editable = DrivLicNoEditable;
//                     }
//                     field("Driver's Mobile No."; rec."Driver's Mobile No.")
//                     {
//                         applicationarea = all;
//                         Editable = DrivMobNoEditable;
//                     }
//                     field("Vehicle Capacity"; rec."Vehicle Capacity")
//                     {
//                         applicationarea = all;
//                         Editable = VechCapEtdiable;
//                     }
//                     field("Expected TPT Cost"; rec."Expected TPT Cost")
//                     {
//                         applicationarea = all;
//                         Editable = ExpTPTCostEditable;
//                         Visible = false;
//                     }
//                 }
//                 group(Others)
//                 {
//                     Caption = 'Others';
//                     field("Posting Date3"; rec."Posting Date")
//                     {
//                         applicationarea = all;
//                         Editable = false;
//                     }
//                     field("Time of Removal"; rec."Time of Removal")
//                     {
//                         applicationarea = all;
//                     }
//                     field("Freight Type"; rec."Freight Type")
//                     {
//                         applicationarea = all;
//                         Editable = FreightTypeEditable;
//                     }
//                     field("Freight Charges"; rec."Freight Charges")
//                     {
//                         applicationarea = all;
//                         Editable = FreightChargesEditable;
//                     }
//                     field("Export Under Rebate"; rec."Export Under Rebate")
//                     {
//                         applicationarea = all;
//                     }
//                     field("Under Rebate"; rec."Under Rebate")
//                     {
//                         applicationarea = all;
//                         Caption = 'Export Under Rebate Check';
//                     }
//                     field("Export Under LUT"; rec."Export Under LUT")
//                     {
//                         applicationarea = all;
//                     }
//                     field("Under LUT"; rec."Under LUT")
//                     {
//                         applicationarea = all;
//                         Caption = 'Export Under LUT Check';
//                     }
//                     field("Ex-Factory"; rec."Ex-Factory")
//                     {
//                         applicationarea = all;
//                     }
//                 }
//                 group("CT3 Details")
//                 {
//                     Caption = 'CT3 Details';
//                     field("CT3 Order"; rec."CT3 Order")
//                     {
//                         applicationarea = all;
//                     }
//                     field("CT3 No."; rec."CT3 No.")
//                     {
//                         applicationarea = all;
//                     }
//                     field("CT3 Date"; rec."CT3 Date")
//                     {
//                         applicationarea = all;
//                     }
//                     field("ARE3 No."; rec."ARE3 No.")
//                     {
//                         applicationarea = all;
//                     }
//                     field("ARE3 Date"; rec."ARE3 Date")
//                     {
//                         applicationarea = all;
//                     }
//                 }
//                 group("CT1 Details")
//                 {
//                     Caption = 'CT1 Details';
//                     field("CT1 Order"; rec."CT1 Order")
//                     {
//                         applicationarea = all;
//                     }
//                     field("CT1 No."; rec."CT1 No.")
//                     {
//                         applicationarea = all;
//                     }
//                     field("CT1 Date"; rec."CT1 Date")
//                     {
//                         applicationarea = all;
//                     }
//                     field("ARE1 No."; rec."ARE1 No.")
//                     {
//                         applicationarea = all;
//                     }
//                     field("ARE1 Date"; rec."ARE1 Date")
//                     {
//                         applicationarea = all;
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
//             }
//             part(part2; 9080)
//             {
//                 SubPageLink = "No." = FIELD("Sell-to Customer No.");
//                 Visible = true;
//             }
//             part(part3; 9082)
//             {
//                 SubPageLink = "No." = FIELD("Bill-to Customer No.");
//                 Visible = false;
//             }
//             part(part4; 9084)
//             {
//                 SubPageLink = "No." = FIELD("Sell-to Customer No.");
//                 Visible = false;
//             }
//             part(part5; 9087)
//             {
//                 Provider = SalesLines;
//                 SubPageLink = "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("Document No."),
//                               "Line No." = FIELD("Line No.");
//                 Visible = true;
//             }
//             part(part6; 9089)
//             {
//                 Provider = SalesLines;
//                 SubPageLink = "No." = FIELD("No.");
//                 Visible = false;
//             }
//             part(part7; 9092)
//             {
//                 SubPageLink = "Table ID" = CONST(36),
//                               "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("No.");
//                 Visible = false;
//                 applicationarea = all;
//             }
//             part(IncomingDocAttachFactBox; 193)
//             {
//                 ShowFilter = false;
//                 Visible = false;
//                 applicationarea = all;
//             }
//             part(part8; 9108)
//             {
//                 Provider = SalesLines;
//                 SubPageLink = "No." = FIELD("No.");
//                 Visible = false;
//                 applicationarea = all;
//             }
//             part(part9; 9109)
//             {
//                 Provider = SalesLines;
//                 SubPageLink = "No." = FIELD("No.");
//                 Visible = false;
//                 applicationarea = all;
//             }
//             part(part10; 9081)
//             {
//                 SubPageLink = "No." = FIELD("Bill-to Customer No.");
//                 Visible = false;
//                 applicationarea = all;
//             }
//             part(WorkflowStatus; 1528)
//             {
//                 Editable = false;
//                 Enabled = false;
//                 ShowFilter = false;
//                 Visible = ShowWorkflowStatus;
//                 applicationarea = all;
//             }
//             systempart(sys1; Links)
//             {
//                 Visible = false;
//                 applicationarea = all;
//             }
//             systempart(sys2; Notes)
//             {
//                 Visible = true;
//                 applicationarea = all;
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
//                     applicationarea = all;

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
//                     RunObject = Page "Customer Card";
//                     RunPageLink = "No." = FIELD("Sell-to Customer No.");
//                     ShortCutKey = 'Shift+F7';
//                 }
//                 action(Dimensions)
//                 {
//                     AccessByPermission = TableData 348 = R;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     ShortCutKey = 'Shift+Ctrl+D';
//                     applicationarea = all;

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
//                     applicationarea = all;

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
//                     RunObject = Page "Sales Comment Sheet";
//                     RunPageLink = "Document Type" = FIELD("Document Type"),
//                                   "No." = FIELD("No."),
//                                   "Document Line No." = CONST(0);
//                     applicationarea = all;
//                 }
//                 action("Credit Cards Transaction Lo&g Entries")
//                 {
//                     Caption = 'Credit Cards Transaction Lo&g Entries';
//                     Image = CreditCardLog;
//                     RunObject = Page 829;
//                     RunPageLink = "Document Type" = FIELD("Document Type"),
//                                   "Document No." = FIELD("No."),
//                                   "Customer No." = FIELD("Bill-to Customer No.");
//                     Visible = false;
//                     applicationarea = all;
//                 }
//                 separator(sep1)
//                 {
//                 }
//                 action("St&ructure")
//                 {
//                     Caption = 'St&ructure';
//                     Image = Hierarchy;
//                     RunObject = Page 16305;
//                     RunPageLink = Type = CONST(Sale),
//                                   Document Type=FIELD(Document Type),
//                                   Document No.=FIELD(No.),
//                                   Structure Code=FIELD(Structure),
//                                   Document Line No.=FILTER(0);
//                 }
//                 action("Transit Documents")
//                 {
//                     Caption = 'Transit Documents';
//                     Image = TransferOrder;
//                     RunObject = Page 13705;
//                                     RunPageLink = Type=CONST(Sale),
//                                   PO / SO No.=FIELD(No.),
//                                   Vendor / Customer Ref.=FIELD(Sell-to Customer No.),
//                                   State=FIELD(State);
//                                   applicationarea = all;
//                 }
//                 action("Detailed &Tax")
//                 {
//                     Caption = 'Detailed &Tax';
//                     Image = TaxDetail;
//                     RunObject = Page 16342;
//                                     RunPageLink = Document Type=FIELD(Document Type),
//                                   Document No.=FIELD(No.),
//                                   Transaction Type=CONST(Sale);
//                                   applicationarea = all;
//                 }
//                 action("Assembly Orders")
//                 {
//                     AccessByPermission = TableData 90=R;
//                     Caption = 'Assembly Orders';
//                     Image = AssemblyOrder;
//                     applicationarea = all;

//                     trigger OnAction()
//                     var
//                         AssembleToOrderLink: Record "904";
//                     begin
//                         AssembleToOrderLink.ShowAsmOrders(Rec);
//                     end;
//                 }
//             }
//             group(ActionGroupCRM)
//             {
//                 Caption = 'Dynamics CRM';
//                 Visible = CRMIntegrationEnabled;
//                 applicationarea = all;
//                 action(CRMGoToSalesOrder)
//                 {
//                     Caption = 'Sales Order';
//                     Enabled = CRMIntegrationEnabled AND CRMIsCoupledToRecord;
//                     Image = CoupledOrder;
//                     ToolTip = 'Open the coupled Microsoft Dynamics CRM sales order.';

//                     trigger OnAction()
//                     var
//                         CRMIntegrationManagement: Codeunit "5330";
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
//                     Caption = 'S&hipments';
//                     Image = Shipment;
//                     RunObject = Page 142;
//                                     RunPageLink = Order No.=FIELD(No.);
//                     RunPageView = SORTING(Order No.);
//                     applicationarea = all;
//                 }
//                 action(Invoices)
//                 {
//                     Caption = 'Invoices';
//                     Image = Invoice;
//                     RunObject = Page 143;
//                                     RunPageLink = Order No.=FIELD(No.);
//                     RunPageView = SORTING(Order No.);
//                     applicationarea = all;
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 action("In&vt. Put-away/Pick Lines")
//                 {
//                     Caption = 'In&vt. Put-away/Pick Lines';
//                     Image = PickLines;
//                     RunObject = Page 5774;
//                                     RunPageLink = Source Document=CONST(Sales Order),
//                                   Source No.=FIELD(No.);
//                     RunPageView = SORTING(Source Document,Source No.,Location Code);
//                     applicationarea = all;
//                 }
//                 action("Whse. Shipment Lines")
//                 {
//                     Caption = 'Whse. Shipment Lines';
//                     Image = ShipmentLines;
//                     RunObject = Page 7341;
//                                     RunPageLink = Source Type=CONST(37),
//                                   Source Subtype=FIELD(Document Type),
//                                   Source No.=FIELD(No.);
//                     RunPageView = SORTING(Source Type,Source Subtype,Source No.,Source Line No.);
//                     applicationarea = all;
//                 }
//             }
//             group(Prepayment)
//             {
//                 Caption = 'Prepayment';
//                 Image = Prepayment;
//                 action(PagePostedSalesPrepaymentInvoices)
//                 {
//                     Caption = 'Prepa&yment Invoices';
//                     Image = PrepaymentInvoice;
//                     RunObject = Page 143;
//                                     RunPageLink = Prepayment Order No.=FIELD(No.);
//                     RunPageView = SORTING(Prepayment Order No.);
//                     Visible = false;
//                     applicationarea = all;
//                 }
//                 action(PagePostedSalesPrepaymentCrMemos)
//                 {
//                     Caption = 'Prepayment Credi&t Memos';
//                     Image = PrepaymentCreditMemo;
//                     RunObject = Page 144;
//                                     RunPageLink = Prepayment Order No.=FIELD(No.);
//                     RunPageView = SORTING(Prepayment Order No.);
//                     Visible = false;
//                     applicationarea = all;
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
//                     Caption = 'Approve';
//                     Image = Approve;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     PromotedIsBig = true;
//                     Visible = OpenApprovalEntriesExistForCurrUser;
// applicationarea = all;
//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
//                     end;
//                 }
//                 action(Reject)
//                 {
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
//                     Caption = 'Comments';
//                     Image = ViewComments;
//                     Promoted = true;
//                     PromotedCategory = Category4;
//                     Visible = OpenApprovalEntriesExistForCurrUser;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
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
//                     Caption = 'Re&lease';
//                     Image = ReleaseDoc;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ShortCutKey = 'Ctrl+F9';
// applicationarea = all;
//                     trigger OnAction()
//                     var
//                         ReleaseSalesDoc: Codeunit "414";
//                     begin

//                         //EBT/OVERDUE/APV/0001
//                         IF "Required MD Approval" THEN
//                            ERROR('Document No %1 must be approved by MD as Customer No. %2 has excceded his Credit Tolarance Level.',"No.",
//                                   "Sell-to Customer No.");
//                         IF "Cust. Overdue Balance"  THEN
//                         BEGIN
//                           IF NOT "Cr. Approved" THEN
//                              ERROR('Sales Order %1 must be approved for Overdue/Cr. Limit',"No.");
//                         END;
//                         //EBT/OVERDUE/APV/0001
//                         ReleaseSalesDoc.PerformManualRelease(Rec);
//                     end;
//                 }
//                 action("Re&open")
//                 {
//                     Caption = 'Re&open';
//                     Image = ReOpen;
//                     Promoted = true;
//                     PromotedCategory = Process;
// applicationarea = all;
//                     trigger OnAction()
//                     var
//                         ReleaseSalesDoc: Codeunit "414";
//                     begin
//                         ReleaseSalesDoc.PerformManualReopen(Rec);

//                         //EBT/OVERDUE/APV/0001
//                         SalesApprovalEntry.RESET;
//                         SalesApprovalEntry.SETRANGE(SalesApprovalEntry."Document No.","No.");
//                         IF SalesApprovalEntry.FINDFIRST THEN
//                         BEGIN
//                           SalesApprovalEntry.DELETE;
//                         END;
//                         "Cr. Approved" := FALSE;
//                         "Sent For Approval" := FALSE;

//                         MODIFY;
//                         //EBT/OVERDUE/APV/0001
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action("Send For Authorization")
//                 {
//                     applicationarea = all;

//                     trigger OnAction()
//                     begin

//                         //EBT/OVERDUE/APV/0001
//                         IF NOT "Sent For Approval" THEN
//                         BEGIN
//                           SalesApproval.RESET;
//                           SalesApproval.SETRANGE(SalesApproval."User ID",USERID);
//                           IF SalesApproval.FINDSET THEN
//                           BEGIN
//                             REPEAT
//                               SalesApprovalEntry.INIT;
//                               SalesApprovalEntry."Document Type" := SalesApprovalEntry."Document Type" :: "Sales Order";
//                               SalesApprovalEntry."Document No." := "No.";
//                               SalesApprovalEntry."User ID" := USERID;
//                               SalesApprovalEntry."Approvar ID" := SalesApproval."Approvar ID";
//                               SalesApprovalEntry."Mandatory ID" := SalesApproval.Mandatory;
//                               SalesApprovalEntry.INSERT;
//                             UNTIL SalesApproval.NEXT = 0;
//                             MESSAGE('Document No. %1 has been sent for Approval',"No.");
//                           END
//                           ELSE
//                             ERROR('Sales Approval setup does not exists for User %1',USERID);
//                         END
//                         ELSE
//                           ERROR('Document No. %1 has already been sent for approval');
//                         //EBT/OVERDUE/APV/0001
//                     end;
//                 }
//                 action(Approval)
//                 {
// applicationarea = all;
//                     trigger OnAction()
//                     begin

//                         //EBT/OVERDUE/APV/0001
//                         IF "Required MD Approval" THEN
//                         BEGIN
//                           SalesApproval.RESET;
//                           SalesApproval.SETRANGE(SalesApproval."User ID",'');
//                           SalesApproval.SETRANGE(SalesApproval.MD,TRUE);
//                           SalesApproval.SETRANGE(SalesApproval."Approvar ID",USERID);
//                           IF SalesApproval.FINDFIRST THEN
//                           BEGIN
//                             "Cr. Approved" := TRUE;
//                             Status := Status :: Released;
//                             MODIFY;
//                           END;
//                              EXIT;
//                         END;
//                         IF "Cr. Approved" THEN
//                            ERROR('Document No. %1 has already been Approved');
//                         SalesApprovalEntry.RESET;
//                         SalesApprovalEntry.SETRANGE("Document No.","No.");
//                         SalesApprovalEntry.SETRANGE("Approvar ID",USERID);
//                         IF SalesApprovalEntry.FINDFIRST THEN
//                         BEGIN
//                           SalesApprovalEntry.Approved := TRUE;
//                           SalesApprovalEntry.MODIFY;
//                           IF SalesApprovalEntry."Mandatory ID" THEN
//                           BEGIN
//                             "Cr. Approved" := TRUE;
//                             Status := Status :: Released;
//                           END;
//                           MODIFY;
//                           MESSAGE('Approved');
//                         END;
//                         //EBT/OVERDUE/APV/0001
//                     end;
//                 }
//                 action("Short Close CSO")
//                 {
// applicationarea = all;
//                     trigger OnAction()
//                     begin

//                         //EBT/SHORTCLOSE/0001
//                         IF CONFIRM('Do you want to short close the sales order?',TRUE) THEN BEGIN
//                             "Short Close":=TRUE;
//                             "Short Close Date":=TODAY;
//                             MODIFY;
//                             SalesLineRec.RESET;
//                             SalesLineRec.SETRANGE(SalesLineRec."Document No.","No.");
//                             SalesLineRec.SETRANGE(SalesLineRec.Closed,FALSE);
//                             IF SalesLineRec.FINDSET THEN
//                             REPEAT
//                                SalesLineRec.Closed:=TRUE;
//                                SalesLineRec."Closed Date":=TODAY;
//                                SalesLineRec.MODIFY;
//                             UNTIL SalesLineRec.NEXT = 0;
//                         END;
//                         //EBT/SHORTCLOSE/0001
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//             }
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action(CalculateInvoiceDiscount)
//                 {
//                     applicationarea = all;
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
//                     applicationarea = all;
//                     Caption = 'Get St&d. Cust. Sales Codes';
//                     Ellipsis = true;
//                     Image = CustomerCode;
//                     Visible = false;

//                     trigger OnAction()
//                     var
//                         StdCustSalesCode: Record "172";
//                     begin
//                         StdCustSalesCode.InsertSalesLines(Rec);
//                     end;
//                 }
//                 action(CopyDocument)
//                 {
//                     applicationarea = all;
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
//                     applicationarea = all;
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
//                     applicationarea = all;
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
//                         applicationarea = all;
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
//                         applicationarea = all;
//                         AccessByPermission = TableData 130=R;
//                         Caption = 'Select Incoming Document';
//                         Image = SelectLineToApply;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         trigger OnAction()
//                         var
//                             IncomingDocument: Record "130";
//                         begin
//                             VALIDATE("Incoming Document Entry No.",IncomingDocument.SelectIncomingDocument("Incoming Document Entry No."));
//                         end;
//                     }
//                     action(IncomingDocAttachFile)
//                     {
//                         applicationarea = all;
//                         Caption = 'Create Incoming Document from File';
//                         Ellipsis = true;
//                         Enabled = NOT HasIncomingDocument;
//                         Image = Attach;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';

//                         trigger OnAction()
//                         var
//                             IncomingDocumentAttachment: Record "133";
//                         begin
//                             IncomingDocumentAttachment.NewAttachmentFromSalesDocument(Rec);
//                         end;
//                     }
//                     action(RemoveIncomingDoc)
//                     {
//                         applicationarea = all;
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
//                     applicationarea = all;
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
//                     applicationarea = all;
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
//                     applicationarea = all;
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
//                     applicationarea = all;
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
//                     applicationarea = all;
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
//                     applicationarea = all;
//                     Caption = 'Authorize';
//                     Image = AuthorizeCreditCard;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         Authorize;
//                     end;
//                 }
//                 action("Void A&uthorize")
//                 {
//                     applicationarea = all;
//                     Caption = 'Void A&uthorize';
//                     Image = VoidCreditCard;
//                     Visible = false;

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
//                     applicationarea = all;
//                     Caption = 'Calc&ulate Structure Values';
//                     Image = CalculateHierarchy;

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
//                     applicationarea = all;
//                     Caption = 'Calculate TCS';
//                     Image = CalculateCollectedTax;

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
//                     applicationarea = all;
//                     Caption = 'Direct Debit To PLA / RG';
//                     Image = Change;

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
//                     applicationarea = all;
//                     AccessByPermission = TableData 7342=R;
//                     Caption = 'Create Inventor&y Put-away/Pick';
//                     Ellipsis = true;
//                     Image = CreateInventoryPickup;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     Visible = false;

//                     trigger OnAction()
//                     begin
//                         CreateInvtPutAwayPick;

//                         IF NOT FIND('=><') THEN
//                           INIT;
//                     end;
//                 }
//                 action("Create &Whse. Shipment")
//                 {
//                     applicationarea = all;
//                     AccessByPermission = TableData 7320=R;
//                     Caption = 'Create &Whse. Shipment';
//                     Image = NewShipment;

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
//                     applicationarea = all;
//                     Caption = 'P&ost';
//                     Ellipsis = true;
//                     Image = PostOrder;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin

//                         //EBT/SOTYPE/0001
//                         IF "Sales Order Type" = "Sales Order Type" :: Dummy THEN
//                           ERROR('You cannot post a dummy order.');
//                         //EBT/SOTYPE/0001
//                         Post(CODEUNIT::"Sales-Post (Yes/No)");
//                     end;
//                 }
//                 action("Post and &Print")
//                 {
//                     applicationarea = all;
//                     Caption = 'Post and &Print';
//                     Ellipsis = true;
//                     Image = PostPrint;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Shift+F9';

//                     trigger OnAction()
//                     begin
//                         Post(CODEUNIT::"Sales-Post + Print");
//                     end;
//                 }
//                 action("Post and Email")
//                 {
//                     applicationarea = all;
//                     Caption = 'Post and Email';
//                     Ellipsis = true;
//                     Image = PostMail;

//                     trigger OnAction()
//                     var
//                         SalesPostPrint: Codeunit 82;
//                     begin
//                         SalesPostPrint.PostAndEmail(Rec);
//                     end;
//                 }
//                 action("Test Report")
//                 {
//                     applicationarea = all;
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;

//                     trigger OnAction()
//                     begin
//                         ReportPrint.PrintSalesHeader(Rec);
//                     end;
//                 }
//                 action("Post &Batch")
//                 {
//                     applicationarea = all;
//                     Caption = 'Post &Batch';
//                     Ellipsis = true;
//                     Image = PostBatch;

//                     trigger OnAction()
//                     begin
//                         REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders",TRUE,TRUE,Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Remove From Job Queue")
//                 {
//                     applicationarea = all;
//                     Caption = 'Remove From Job Queue';
//                     Image = RemoveLine;
//                     Visible = JobQueueVisible;

//                     trigger OnAction()
//                     begin
//                         CancelBackgroundPosting;
//                     end;
//                 }
//                 action(PreviewPosting)
//                 {
//                     applicationarea = all;
//                     Caption = 'Preview Posting';
//                     Image = ViewPostedOrder;

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
//                         applicationarea = all; 
//                         Caption = 'Prepayment &Test Report';
//                         Ellipsis = true;
//                         Image = PrepaymentSimulation;

//                         trigger OnAction()
//                         begin
//                             ReportPrint.PrintSalesHeaderPrepmt(Rec);
//                         end;
//                     }
//                     action(PostPrepaymentInvoice)
//                     {
//                         applicationarea = all; 
//                         Caption = 'Post Prepayment &Invoice';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;

//                         trigger OnAction()
//                         var
//                             SalesPostYNPrepmt: Codeunit 443;
//                         begin
//                             IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
//                               SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec,FALSE);
//                         end;
//                     }
//                     action("Post and Print Prepmt. Invoic&e")
//                     {
//                         applicationarea = all; 
//                         Caption = 'Post and Print Prepmt. Invoic&e';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;

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
//                         applicationarea = all; 
//                         Caption = 'Post Prepayment &Credit Memo';
//                         Ellipsis = true;
//                         Image = PrepaymentPost;

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
//                         applicationarea = all; 
//                         Caption = 'Post and Print Prepmt. Cr. Mem&o';
//                         Ellipsis = true;
//                         Image = PrepaymentPostPrint;

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
//                 action("Order Confirmation")
//                 {
//                     applicationarea = all; 
//                     Caption = 'Order Confirmation';
//                     Ellipsis = true;
//                     Image = Print;

//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintSalesOrder(Rec,Usage::"Order Confirmation");
//                     end;
//                 }
//                 action("Work Order")
//                 {
//                     applicationarea = all; 
//                     Caption = 'Work Order';
//                     Ellipsis = true;
//                     Image = Print;

//                     trigger OnAction()
//                     begin
//                         DocPrint.PrintSalesOrder(Rec,Usage::"Work Order");
//                     end;
//                 }
//                 action("Email Confirmation")
//                 {
//                     applicationarea = all; 
//                     Caption = 'Email Confirmation';
//                     Ellipsis = true;
//                     Image = Email;

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
//         //EBT/SOTYPE/0001
//         SalesSetup.GET;
//         IF SalesSetup."Dummy Order" = FALSE THEN BEGIN
//           SalesSetup."Dummy Order" := TRUE;
//           SalesSetup.MODIFY;
//         END;
//         //EBT/SOTYPE/0001
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
//         "Sales Order Type" := "Sales Order Type" :: Dummy;    //EBT/SOTYPE/0001
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
//                           SalesLine: Record  37;
//                           Text16500: Label 'You can not uncheck Re-Dispatch until Return Receipt No. is Blank.';
//         Text16501: Label 'To calculate invoice discount, check Cal. Inv. Discount on header when Price Inclusive of Tax = Yes.\This option cannot be used to calculate invoice discount when Price Inclusive Tax = Yes.';
//          // [InDataSet]
//         ReturnOrderNoVisible: Boolean;
//          // [InDataSet]
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
//         CSOMapping2: Record 50006;
//         CSO: Record 36;
//         CSOMapping: Record 50006;
//         CSOMapping1: Record 50006;
//         recSalesApprovalEntry: Record 50009;
//         recSalesApproval: Record 50008;
//         AppDescEditable: Boolean;
//         FreightTypeEditable: Boolean;
//         FreightChargesEditable: Boolean;
//         RecordMarked: Boolean;
//         ApprovalStatus: Text[30];
//         StateDesc: Text[30];
//         Ship2StateDesc: Text[30];
//         recState: Record 13762;
//         recState1: Record 13762;
//         "LR/RRNoEditable": Boolean;
//         "LR/RRDateEditable": Boolean;
//         VehicaleNoEditable: Boolean;
//         DrivNameEditable: Boolean;
//         DrivLicNoEditable: Boolean;
//         DrivMobNoEditable: Boolean;
//         VechCapEtdiable: Boolean;
//         ExpTPTCostEditable: Boolean;
//         LocalLRNoEditable: Boolean;
//         LocalLRDateEditable: Boolean;
//         LocalVehicaleNoEditable: Boolean;
//         LocalVechCapEtdiable: Boolean;
//         LocalDrivNameEditable: Boolean;
//         LocalDrivLicNoEditable: Boolean;
//         LocalDrivMobNoEditable: Boolean;
//         LocalExpTPTCostEditable: Boolean;
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
//         FormAvCrd: Page 50069;
//                        recSL: Record 37;
//                        SalesApproval: Record 50008;
//                        Saaleslinerec: Record 37;
//                        SalesLineRec: Record 37;
//                        SH: Record "36";

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
//         ApprovalsMgmt: Codeunit 1535;
//     begin
//         JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
//         HasIncomingDocument := "Incoming Document Entry No." <> 0;
//         SetExtDocNoMandatoryCondition;

//         OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
//         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
//     end;

//     //[Scope('Internal')]
//     procedure GetNoSeriesCode(): Code[10]
//     begin
//         EXIT(SalesSetup."Dummy Sales Order Nos.");
//     end;
// }

