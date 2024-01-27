// page 50013 "Sales Debit Memo"
// {
//     // Date        Version      Remarks
//     // .....................................................................................
//     // 05Jul2018   RB-N         Due Date GP Calculation

//     Caption = 'Sales Debit Memo';
//     PageType = Document;
//     PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
//     RefreshOnActivate = true;
//     SourceTable = 36;
//     SourceTableView = WHERE("Document Type" = FILTER(Invoice),
//                             "Debit Memo" = CONST(true));

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

//                         //>>05Jul2018
//                         DueDateGP;
//                         //<<05Jul2018
//                     end;
//                 }
//                 field("Sell-to Contact No."; rec."Sell-to Contact No.")
//                 {
//                     Editable = false;
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
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Sell-to Address"; rec."Sell-to Address")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Sell-to Address 2"; rec."Sell-to Address 2")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Sell-to Post Code"; rec."Sell-to Post Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Sell-to City"; rec."Sell-to City")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Sell-to Contact"; rec."Sell-to Contact")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Structure; rec.Structure)
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;
//                 }
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Importance = Promoted;
//                 }
//                 field("Document Date"; rec."Document Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date GP"; rec."Date GP")
//                 {
//                     ApplicationArea = all;
//                     Enabled = false;
//                     Visible = false;
//                 }
//                 field("External Document No."; rec."External Document No.")
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;
//                     ShowMandatory = ExternalDocNoMandatory;
//                 }
//                 field("Salesperson Code"; rec."Salesperson Code")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         SalespersonCodeOnAfterValidate;
//                     end;
//                 }
//                 field("Campaign No."; rec."Campaign No.")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
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
//                     Style = Attention;
//                     StyleExpr = TRUE;
//                 }
//                 field("Posting No. Series"; rec."Posting No. Series")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             part(SalesLines; 47)
//             {
//                 SubPageLink = "Document No." = FIELD("No.");
//                 ApplicationArea = all;
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
//                     Editable = false;
//                 }
//                 field("Bill-to Name"; rec."Bill-to Name")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Bill-to Address"; rec."Bill-to Address")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Bill-to Address 2"; rec."Bill-to Address 2")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Bill-to Post Code"; rec."Bill-to Post Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Bill-to City"; rec."Bill-to City")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Bill-to Contact"; rec."Bill-to Contact")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
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
//                     Importance = Promoted;
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
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

//                     trigger OnValidate()
//                     begin
//                         //>>05Jul2018
//                         DueDateGP;
//                         //<<05Jul2018
//                     end;
//                 }
//                 field("Direct Debit Mandate ID"; rec."Direct Debit Mandate ID")
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
//                 field("Credit Card No."; rec."Credit Card No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(GetCreditcardNumber; rec.GetCreditcardNumber)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Cr. Card Number (Last 4 Digits)';
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
//                     Editable = false;
//                 }
//                 field("Ship-to Address"; rec."Ship-to Address")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Ship-to Address 2"; rec."Ship-to Address 2")
//                 {
//                     Editable = false;
//                     Importance = Additional;
//                     ApplicationArea = all;
//                 }
//                 field("Ship-to Post Code"; rec."Ship-to Post Code")
//                 {
//                     Editable = false;
//                     Importance = Promoted;
//                     ApplicationArea = all;
//                 }
//                 field("Ship-to City"; rec."Ship-to City")
//                 {
//                     Editable = false;
//                     ApplicationArea = all;
//                 }
//                 field("Ship-to Contact"; rec."Ship-to Contact")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Importance = Additional;
//                 }
//                 field("Road Permit No."; rec."Road Permit No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Location Code"; rec."Location Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Shipment Method Code"; rec."Shipment Method Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Shipping Agent Code"; rec."Shipping Agent Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Package Tracking No."; rec."Package Tracking No.")
//                 {
//                     ApplicationArea = all;
//                     Importance = Additional;
//                 }
//                 field("Shipment Date"; rec."Shipment Date")
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;
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

//                 field(Trading; rec.Trading)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Transit Document"; rec."Transit Document")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("TDS Certificate Receivable"; rec."TDS Certificate Receivable")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Export or Deemed Export"; rec."Export or Deemed Export")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("VAT Exempted"; rec."VAT Exempted")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Calc. Inv. Discount (%)"; rec."Calc. Inv. Discount (%)")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Free Supply"; rec."Free Supply")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("ST Pure Agent"; rec."ST Pure Agent")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Bill Of Export No."; rec."Bill Of Export No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Bill Of Export Date"; rec."Bill Of Export Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Re-Dispatch"; rec."Re-Dispatch")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         IF rec."Re-Dispatch" THEN
//                             ReturnOrderNoEnable := TRUE
//                         ELSE
//                             ReturnOrderNoEnable := FALSE;
//                     end;
//                 }
//                 field(ReturnOrderNo; rec."Return Re-Dispatch Rcpt. No.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Return Receipt No.';
//                     Enabled = ReturnOrderNoEnable;
//                     Visible = ReturnOrderNoVisible;
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
//                 field("Service Tax Rounding Precision"; rec."Service Tax Rounding Precision")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Service Tax Rounding Type"; rec."Service Tax Rounding Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Time of Removal"; rec."Time of Removal")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Time of Removal';
//                 }
//                 field("Mode of Transport"; rec."Mode of Transport")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Mode of Transport';
//                 }
//                 field("Vehicle No."; rec."Vehicle No.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Vehicle No.';
//                 }
//                 field("LR/RR No."; rec."LR/RR No.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'LR/RR No.';
//                 }
//                 field("LR/RR Date"; rec."LR/RR Date")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'LR/RR Date';
//                 }
//                 field(PoT; rec.PoT)
//                 {
//                     ApplicationArea = all;
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
//                 SubPageLink = "No." = FIELD("Sell-to Customer No.");
//                 Visible = false;
//             }
//             part(part3; 9081)
//             {
//                 SubPageLink = "No." = FIELD("Bill-to Customer No.");
//                 Visible = false;
//             }
//             part(part4; 9082)
//             {
//                 SubPageLink = "No." = FIELD("Bill-to Customer No.");
//                 Visible = true;
//             }
//             part(part5; 9084)
//             {
//                 SubPageLink = "No." = FIELD("Sell-to Customer No.");
//                 Visible = true;
//             }
//             part(part6; 9087)
//             {
//                 Provider = SalesLines;
//                 SubPageLink = "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("Document No."),
//                               "Line No." = FIELD("Line No.");
//                 Visible = false;
//             }
//             part(part7; 9089)
//             {
//                 Provider = SalesLines;
//                 SubPageLink = "No." = FIELD("No.");
//                 Visible = true;
//             }
//             part(IncomingDocAttachFactBox; 193)
//             {
//                 ShowFilter = false;
//                 Visible = false;
//             }
//             part(part8; 9092)
//             {
//                 SubPageLink = "Table ID" = CONST(36),
//                              "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("No.");
//                 Visible = false;
//             }
//             part(part9; 9108)
//             {
//                 Provider = SalesLines;
//                 SubPageLink = "No." = FIELD("No.");
//                 Visible = false;
//             }
//             part(WorkflowStatus; 1528)
//             {
//                 Editable = false;
//                 Enabled = false;
//                 ShowFilter = false;
//                 Visible = ShowWorkflowStatus;
//             }
//             systempart(sys1; Links)
//             {
//                 Visible = false;
//             }
//             systempart(sys2; Notes)
//             {
//                 Visible = true;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("&Invoice")
//             {
//                 Caption = '&Invoice';
//                 Image = Invoice;
//                 action(Statistics)
//                 {
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = Category8;
//                     ShortCutKey = 'F7';
//                     ApplicationArea = all;

//                     trigger OnAction()
//                     begin
//                         SalesSetup.GET;
//                         CALCFIELDS("Price Inclusive of Taxes");
//                         IF SalesSetup."Calc. Inv. Discount" AND (NOT "Price Inclusive of Taxes") THEN BEGIN
//                             CalcInvDiscForHeader;
//                             COMMIT;
//                         END;
//                         IF "Price Inclusive of Taxes" THEN BEGIN
//                             SalesLine.InitStrOrdDetail(Rec);
//                             SalesLine.GetSalesPriceExclusiveTaxes(Rec);
//                             SalesLine.UpdateSalesLinesPIT(Rec);
//                             COMMIT;
//                         END;

//                         IF Structure <> '' THEN BEGIN
//                             SalesLine.CalculateStructures(Rec);
//                             SalesLine.AdjustStructureAmounts(Rec);
//                             SalesLine.UpdateSalesLines(Rec);
//                             SalesLine.CalculateTCS(Rec);
//                             COMMIT;
//                         END ELSE BEGIN
//                             SalesLine.CalculateTCS(Rec);
//                             COMMIT;
//                         END;
//                         PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec);
//                         SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 action(Dimensions)
//                 {
//                     AccessByPermission = TableData 348 = R;
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     Promoted = true;
//                     PromotedCategory = Category8;
//                     ShortCutKey = 'Shift+Ctrl+D';
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         ShowDocDim;
//                         CurrPage.SAVERECORD;
//                     end;
//                 }
//                 action(Invoice_CustomerCard)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Customer';
//                     Image = Customer;
//                     RunObject = Page "Customer Card";
//                     RunPageLink = "No." = FIELD("Sell-to Customer No.");
//                     ShortCutKey = 'Shift+F7';
//                 }
//                 action(Approvals)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Approvals';
//                     Image = Approvals;

//                     trigger OnAction()
//                     var
//                         ApprovalEntries: Page "Approval Entries";
//                     begin
//                         ApprovalEntries.Setfilters(DATABASE::"Sales Header", rec."Document Type", rec."No.");
//                         ApprovalEntries.RUN;
//                     end;
//                 }
//                 action("Co&mments")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     Promoted = true;
//                     PromotedCategory = Category8;
//                     RunObject = Page "Sales Comment Sheet";
//                     RunPageLink = "Document Type" = FIELD("Document Type"),
//                                   "No." = FIELD("No."),
//                                   "Document Line No." = CONST(0);
//                 }
//                 separator(sep1)
//                 {
//                 }
//             }
//             group("Credit Card")
//             {
//                 Caption = 'Credit Card';
//                 Image = CreditCardLog;
//                 action("Credit Cards Transaction Lo&g Entries")
//                 {
//                     Caption = 'Credit Cards Transaction Lo&g Entries';
//                     Image = CreditCardLog;
//                     RunObject = Page 829;
//                     RunPageLink = "Document Type" = FIELD("Document Type"),
//                                   "Document No." = FIELD("No."),
//                                   "Customer No." = FIELD("Bill-to Customer No.");
//                     ApplicationArea = all;
//                 }
//                 action("St&ructure")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'St&ructure';
//                     Image = Hierarchy;
//                     RunObject = Page 16305;
//                     RunPageLink = Type = CONST(Sale),
//                                   "Document Type" = FIELD("Document Type"),
//                                   "Document No." = FIELD(No.),
//                                   "Structure Code"=FIELD(Structure),
//                                   "Document Line No."=FILTER(0);
//                 }
//                 action("Transit Documents")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Transit Documents';
//                     Image = TransferOrder;
//                     RunObject = Page 13705;
//                                     RunPageLink = Type=CONST(Sale),
//                                   "PO / SO No."=FIELD("No."),
//                                   "Vendor / Customer Ref."=FIELD("Sell-to Customer No.");
//                 }
//                 action("Detailed GST")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Detailed GST';
//                     Image = ServiceTax;
//                     RunObject = Page "Detailed GST Entry Buffer";
//                                     RunPageLink = "Transaction Type"=FILTER(Sales),
//                                   "Document Type"=FIELD("Document Type"),
//                                   "Document No."=FIELD("No.");
//                 }
//                 action("Detailed &Tax")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Detailed &Tax';
//                     Image = TaxDetail;
//                     RunObject = Page 16342;
//                                     RunPageLink = "Document Type"=FIELD("Document Type"),
//                                   "Document No."=FIELD("No."),
//                                   "Transaction Type"=CONST(Sale);
//                 }
//             }
//             group("&Line")
//             {
//                 Caption = '&Line';
//                 Image = Line;
//                 action(Structure)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Structure';
//                     Image = Hierarchy;

//                     trigger OnAction()
//                     begin
//                         CurrPage.SalesLines.PAGE.ShowStrOrderDetailsPITForm;
//                     end;
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
//                     PromotedCategory = Category5;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'Ctrl+F9';

//                     trigger OnAction()
//                     var
//                         ReleaseSalesDoc: Codeunit 414;
//                     begin

//                         //EBT STIVAN ---(08/11/2012)--- Error Message POP UP if Location Code is Blank -------START
//                         IF "Location Code" = '' THEN
//                         ERROR('Location Code is Blank');
//                         //EBT STIVAN ---(08/11/2012)--- Error Message POP UP if Location Code is Blank ---------END

//                         //EBT STIVAN ---(08/11/2012)--- Error Message Pop if Posting No. Series is Blank ---START
//                         IF "Posting No. Series" = '' THEN
//                         ERROR('Please Select Posting No. Series');
//                         //EBT STIVAN ---(08/11/2012)--- Error Message Pop if Posting No. Series is Blank -----END

//                         //EBT STIVAN ---(24/08/2012)--- Release Rights as per Sales Approval Setup ----------------------START
//                         recSalesApproval.RESET;
//                         recSalesApproval.SETRANGE(recSalesApproval."Approvar ID",USERID);
//                         IF recSalesApproval.FINDFIRST THEN
//                         BEGIN
//                         ReleaseSalesDoc.PerformManualRelease(Rec);
//                         END ELSE
//                         ERROR('You are not authorised to Release the Supplimentary Invoice');
//                         //EBT STIVAN ---(24/08/2012)--- Release Rights as per Sales Approval Setup ------------------------END
//                     end;
//                 }
//                 action(Reopen)
//                 {
//                     Caption = 'Re&open';
//                     Image = ReOpen;
//                     Promoted = true;
//                     PromotedCategory = Category5;
//                     PromotedIsBig = true;
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
//                     AccessByPermission = TableData 19=R;
//                     Caption = 'Calculate &Invoice Discount';
//                     Image = CalculateInvoiceDiscount;
//                     Promoted = true;
//                     PromotedCategory = Category7;

//                     trigger OnAction()
//                     begin
//                         CALCFIELDS("Price Inclusive of Taxes");
//                         IF NOT "Price Inclusive of Taxes" THEN
//                           ApproveCalcInvDisc
//                         ELSE
//                           ERROR(STRSUBSTNO(Text16500,FIELDCAPTION("Price Inclusive of Taxes")));
//                         SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action("Get St&d. Cust. Sales Codes")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Get St&d. Cust. Sales Codes';
//                     Ellipsis = true;
//                     Image = CustomerCode;
//                     Promoted = true;
//                     PromotedCategory = Category7;

//                     trigger OnAction()
//                     var
//                         StdCustSalesCode: Record "172";
//                     begin
//                         StdCustSalesCode.InsertSalesLines(Rec);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action("Copy Document")
//                 {
//                     Caption = 'Copy Document';
//                     Ellipsis = true;
//                     Image = CopyDocument;
//                     Promoted = true;
//                     PromotedCategory = Category7;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         CopySalesDoc.SetSalesHeader(Rec);
//                         CopySalesDoc.RUNMODAL;
//                         CLEAR(CopySalesDoc);
//                         IF GET("Document Type","No.") THEN;
//                     end;
//                 }
//                 action("Move Negative Lines")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Move Negative Lines';
//                     Ellipsis = true;
//                     Image = MoveNegativeLines;
//                     Promoted = true;
//                     PromotedCategory = Category7;

//                     trigger OnAction()
//                     begin
//                         CLEAR(MoveNegSalesLines);
//                         MoveNegSalesLines.SetSalesHeader(Rec);
//                         MoveNegSalesLines.RUNMODAL;
//                         MoveNegSalesLines.ShowDocument;
//                     end;
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
//                     begin
//                         ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
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
//                             IncomingDocument: Record "130";
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
//                             IncomingDocument: Record "130";
//                         begin
//                             VALIDATE("Incoming Document Entry No.",IncomingDocument.SelectIncomingDocument("Incoming Document Entry No."));
//                         end;
//                     }
//                     action(IncomingDocAttachFile)
//                     {
//                         Caption = 'Create Incoming Document from File';
//                         Ellipsis = true;
//                         Enabled = NOT HasIncomingDocument;
//                         Image = Attach;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';
// ApplicationArea = all;
//                         trigger OnAction()
//                         var
//                             IncomingDocumentAttachment: Record "133";
//                         begin
//                             IncomingDocumentAttachment.NewAttachmentFromSalesDocument(Rec);
//                         end;
//                     }
//                     action(RemoveIncomingDoc)
//                     {
//                         Caption = 'Remove Incoming Document';
//                         Enabled = HasIncomingDocument;
//                         Image = RemoveLine;
//                         //The property 'ToolTip' cannot be empty.
//                         //ToolTip = '';
// ApplicationArea = all;
//                         trigger OnAction()
//                         begin
//                             "Incoming Document Entry No." := 0;
//                         end;
//                     }
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
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         Void;
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action("Calculate Str&ucture Values")
//                 {
//                     Caption = 'Calculate Str&ucture Values';
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
//                     Caption = 'Calculate TCS';
//                     Image = CalculateCollectedTax;
// ApplicationArea = all;
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
//             group("P&osting")
//             {
//                 Caption = 'P&osting';
//                 Image = Post;
//                 action(Post)
//                 {
//                     Caption = 'P&ost';
//                     Image = PostOrder;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F9';
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         Post(CODEUNIT::"Sales-Post (Yes/No)");
//                     end;
//                 }
//                 action("Test Report")
//                 {
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;
//                     Promoted = true;
//                     PromotedCategory = Category6;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         ReportPrint.PrintSalesHeader(Rec);
//                     end;
//                 }
//                 action(PostAndSend)
//                 {
//                     Caption = 'Post and &Send';
//                     Ellipsis = true;
//                     Image = PostSendTo;
//                     Promoted = true;
//                     PromotedCategory = Category6;
//                     PromotedIsBig = true;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         SendToPosting(CODEUNIT::"Sales-Post and Send");
//                     end;
//                 }
//                 action("Post and &Print")
//                 {
//                     Caption = 'Post and &Print';
//                     Image = PostPrint;
//                     //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedCategory = Category6;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = true;
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
//                     Image = PostMail;
// ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         SalesPostPrint: Codeunit 82;
//                     begin
//                         SalesPostPrint.PostAndEmail(Rec);
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
//                         REPORT.RUNMODAL(REPORT::"Batch Post Sales Invoices",TRUE,TRUE,Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Remove From Job Queue")
//                 {
//                     Caption = 'Remove From Job Queue';
//                     Image = RemoveLine;
//                     Visible = "Job queue Status" = "Job Queue Status"::"Scheduled for Posting";
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         CancelBackgroundPosting;
//                     end;
//                 }
//                 action(Preview)
//                 {
//                     Caption = 'Preview Posting';
//                     Image = ViewPostedOrder;
// ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         ShowPreview;
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
//         IF "Re-Dispatch" THEN
//           ReturnOrderNoVisible := TRUE
//         ELSE
//           ReturnOrderNoVisible := FALSE;
//         /*
//         //EBT0001
//         IF "Posting Date" <> TODAY THEN
//            "Posting Date" := TODAY;
//         IF "Shipment Date" <> TODAY THEN
//            "Shipment Date" := TODAY;
//         //EBT0001
//         */

//     end;

//     trigger OnDeleteRecord(): Boolean
//     begin
//         CurrPage.SAVERECORD;
//         EXIT(ConfirmDeletion);
//     end;

//     trigger OnInit()
//     begin
//         SetExtDocNoMandatoryCondition;
//         ReturnOrderNoEnable := TRUE;
//         ReturnOrderNoVisible := TRUE;
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         CheckCreditMaxBeforeInsert;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         "Document Type" := "Document Type" :: Invoice;
//         "Responsibility Center" := UserMgt.GetSalesFilter;
//         "Supplimentary Invoice" := FALSE;
//         "Debit Memo" := TRUE;//11Apr2019
//     end;

//     trigger OnOpenPage()
//     begin
//         /*
//         CSOMapping2.RESET;
//         CSOMapping2.SETRANGE(CSOMapping2."User Id",UPPERCASE(USERID));
//         IF CSOMapping2.FINDFIRST THEN
//           BEGIN
//           //FILTERGROUP(2);
//           SuppInv.RESET;
//           SuppInv.SETRANGE(SuppInv."Document Type","Document Type");
//           SuppInv.SETFILTER(SuppInv."Short Close",'%1',FALSE);
//           IF SuppInv.FINDSET THEN
//           REPEAT
//             CSOMapping.RESET;
//             CSOMapping.SETRANGE(CSOMapping."User Id",UPPERCASE(USERID));
//             CSOMapping.SETRANGE(CSOMapping.Type,CSOMapping.Type::"Responsibility Center");
//             CSOMapping.SETRANGE(CSOMapping.Value,SuppInv."Responsibility Center");
//             IF CSOMapping.FINDFIRST THEN
//                SuppInv.MARK := TRUE
//             ELSE
//             BEGIN
//               CSOMapping1.RESET;
//               CSOMapping1.SETRANGE("User Id",UPPERCASE(USERID));
//               CSOMapping1.SETRANGE(Type,CSOMapping.Type::Location);
//               CSOMapping1.SETRANGE(Value,SuppInv."Location Code");
//               IF CSOMapping1.FINDFIRST THEN
//                  SuppInv.MARK := TRUE
//              END;
//           UNTIL SuppInv.NEXT = 0;
//           SuppInv.MARKEDONLY(TRUE);
//           COPY(SuppInv);
//           //FILTERGROUP(0);
//         END
//         ELSE
//         BEGIN
//           IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
//             FILTERGROUP(2);
//             SETRANGE("Responsibility Center",UserMgt.GetSalesFilter());
//             FILTERGROUP(0);
//           END;
//         END;
//         */

//         //>>Robosoft\Migration
//         IF "No." <>'' THEN BEGIN
//           IF "Posting Date" <> TODAY THEN
//           BEGIN
//             "Posting Date" :=  TODAY;
//             MODIFY;
//           END;

//           IF "Shipment Date" <> TODAY THEN
//           BEGIN
//             "Shipment Date" :=  TODAY;
//             SalesLine1.RESET;
//             SalesLine1.SETCURRENTKEY("Document Type","Document No.","Line No.");
//             SalesLine1.SETRANGE("Document Type","Document Type");
//             SalesLine1.SETRANGE("Document No.","No.");
//             IF SalesLine1.FINDSET THEN REPEAT
//               SalesLine1."Shipment Date" := TODAY;
//               SalesLine1.MODIFY;
//             UNTIL SalesLine1.NEXT =0;
//             MODIFY;
//           END;
//         END;
//         //>>

//         //>>05Jul2018
//         DueDateGP;
//         //<<05Jul2018

//         //--RSPLSUM 04Apr2020--SETRANGE("Supplimentary Invoice",FALSE);
//         SETRANGE("Debit Memo",TRUE);//RSPLSUM 04Apr20
//         SetDocNoVisible;

//     end;

//     var

//         SalesSetup: Record 311;
//         ChangeExchangeRate: Page "Change Exchange Rate";
//                                 CopySalesDoc: Report 292;
//                                 MoveNegSalesLines: Report 6699;
//                                 ReportPrint: Codeunit 228;
//                                 UserMgt: Codeunit "5700";
//                                 SalesCalcDiscountByType: Codeunit 56;
//                                 ApprovalsMgmt: Codeunit 1535;
//                                 HasIncomingDocument: Boolean;
//                                 DocNoVisible: Boolean;
//                                 ExternalDocNoMandatory: Boolean;
//                                 OpenApprovalEntriesExistForCurrUser: Boolean;
//                                 OpenApprovalEntriesExist: Boolean;
//                                 ShowWorkflowStatus: Boolean;
//                                 SalesLine: Record 37;
//                                 Text16500: Label 'To calculate invoice discount, check Cal. Inv. Discount on header when Price Inclusive of Tax = Yes.\This option cannot be used to calculate invoice discount when Price Inclusive Tax = Yes.';
//         [InDataSet]
//         ReturnOrderNoVisible: Boolean;
//         [InDataSet]
//         ReturnOrderNoEnable: Boolean;
//         CSOMapping2: Record 50006;
//         SuppInv: Record 36;
//         CSOMapping: Record 50006;
//         CSOMapping1: Record 50006;
//         recSalesApproval: Record 50008;
//         SalesLine1: Record 37;
//         "-----------05Jul2018": Integer;
//         PayTerm05: Record 3;
//         Cust05: Record 18;

//     local procedure Post(PostingCodeunitID: Integer)
//     begin
//         SendToPosting(PostingCodeunitID);
//         IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
//           CurrPage.CLOSE;
//         CurrPage.UPDATE(FALSE);
//     end;

//     local procedure ApproveCalcInvDisc()
//     begin
//         CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
//     end;

//     local procedure SelltoCustomerNoOnAfterValidat()
//     begin
//         IF GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
//           IF "Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
//             SETRANGE("Sell-to Customer No.");
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

//     local procedure SetDocNoVisible()
//     var
//         DocumentNoVisibility: Codeunit 1400;
//         DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
//     begin
//         DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Invoice,"No.");
//     end;

//     local procedure SetExtDocNoMandatoryCondition()
//     var
//         SalesReceivablesSetup: Record "311";
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

//     local procedure SetControlAppearance()
//     var
//         ApprovalsMgmt: Codeunit 1535;
//     begin
//         HasIncomingDocument := "Incoming Document Entry No." <> 0;
//         SetExtDocNoMandatoryCondition;

//         OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
//         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
//     end;

//     local procedure DueDateGP()
//     begin
//         //>>05Jul2018 RB-N
//         IF ("No." <> '') THEN
//         BEGIN
//           "Date GP" := TODAY;
//           IF ("Payment Terms Code" <> '') THEN
//           BEGIN
//             PayTerm05.GET("Payment Terms Code");
//             "Due Date" := CALCDATE(PayTerm05."Due Date Calculation","Date GP");
//           END;
//           IF "Sell-to Customer No." <> '' THEN
//           BEGIN
//             Cust05.RESET;
//             IF Cust05.GET("Sell-to Customer No.") THEN;
//             "Due Date" := CALCDATE(Cust05."Approved Payment Days","Due Date");
//           END;
//           MODIFY;
//         END;
//         //<<05Jul2018 RB-N
//     end;
// }

