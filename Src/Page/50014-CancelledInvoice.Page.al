// page 50014 "Cancelled Invoice"
// {
//     // RSPL/CUST/FOC/RET001    Sourav Dey           Customization added to avoid the Applies to ID in return order incase of FOC

//     Caption = 'Cancelled Invoice';
//     PageType = Document;
//     PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
//     RefreshOnActivate = true;
//     SourceTable = 36;
//     SourceTableView = WHERE("Document Type" = FILTER("Return Order"),
//                             "Cancelled Invoice" = FILTER(true),
//                             "Short Close" = CONST(false));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; rec."No.")
//                 {
//                     ApplicationArea = all;
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
//                     ApplicationArea = all;
//                     Importance = Promoted;
//                     ShowMandatory = true;

//                     trigger OnValidate()
//                     begin
//                         SelltoCustomerNoOnAfterValidat;
//                     end;
//                 }
//                 field("Sell-to Contact No."; rec."Sell-to Contact No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;

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
//                     QuickEntry = false;
//                 }
//                 field("Sell-to Address"; rec."Sell-to Address")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Sell-to Address 2"; rec."Sell-to Address 2")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Sell-to Post Code"; rec."Sell-to Post Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Sell-to City"; rec."Sell-to City")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     QuickEntry = false;
//                 }
//                 field("Sell-to Contact"; rec."Sell-to Contact")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Structure; rec.Structure)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Cancelled Invoice"; rec."Cancelled Invoice")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;
//                     QuickEntry = false;

//                     trigger OnValidate()
//                     begin
//                         //RSPLSUM 10Jun2020>>
//                         IF "Shortcut Dimension 1 Code" = 'DIV-14' THEN BEGIN
//                             IF "Posting Date" < "Shipment Date" THEN
//                                 ERROR('Please enter date greater than or equal to shipment date');
//                         END;
//                         //RSPLSUM 10Jun2020<<
//                     end;
//                 }
//                 field("Order Date"; rec."Order Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = EditBunkerFields;
//                     Importance = Promoted;
//                     QuickEntry = false;
//                 }
//                 field("Document Date"; rec."Document Date")
//                 {
//                     ApplicationArea = all;
//                     QuickEntry = false;
//                 }
//                 field("Created Date"; rec."Created Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("External Document No."; rec."External Document No.")
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;
//                 }
//                 field("Salesperson Code"; rec."Salesperson Code")
//                 {
//                     ApplicationArea = all;
//                     QuickEntry = false;

//                     trigger OnValidate()
//                     begin
//                         SalespersonCodeOnAfterValidate;
//                     end;
//                 }
//                 field("Campaign No."; rec."Campaign No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Responsibility Center"; rec."Responsibility Center")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Assigned User ID"; rec."Assigned User ID")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Status; rec.Status)
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;
//                     QuickEntry = false;
//                     Style = Attention;
//                     StyleExpr = TRUE;
//                 }
//                 part(SalesLines; 6631)
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "Document No." = FIELD("No.");
//                     UpdatePropagation = Both;
//                 }
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
//                 }
//                 field("Bill-to Address 2"; rec."Bill-to Address 2")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Bill-to Post Code"; rec."Bill-to Post Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Bill-to City"; rec."Bill-to City")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Bill-to Contact"; rec."Bill-to Contact")
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
//                 field("Applies-to Doc. Type"; rec."Applies-to Doc. Type")
//                 {
//                     ApplicationArea = all;
//                     Importance = Promoted;
//                 }
//                 field("Applies-to Doc. No."; rec."Applies-to Doc. No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     var
//                         InvoiceDateTime: DateTime;
//                         DurationInvAndCancel: Duration;
//                         DurationInHours: Decimal;
//                     begin

//                         //EBT STIVAN (20062012)--- To Capture the Applies To Document Nos Date -------------START
//                         recSIL.RESET;
//                         recSIL.SETRANGE(recSIL."Document No.", rec."Applies-to Doc. No.");
//                         IF recSIL.FINDFIRST THEN BEGIN
//                             AppliedDocDate := recSIL."Posting Date";
//                         END;
//                         //EBT STIVAN (20062012)--- To Capture the Applies To Document Nos Date ---------------END

//                         //EBT STIVAN (20062012)--- validation if Invoice Date and today date is not equal -------------START
//                         //RSPL Temp Comment 12012021  ++
//                         IF "Applies-to Doc. No." <> '' THEN BEGIN
//                             PostedInv.RESET;
//                             PostedInv.SETRANGE(PostedInv."No.", "Applies-to Doc. No.");
//                             PostedInv.SETRANGE(PostedInv."Posting Date", TODAY);
//                             IF NOT PostedInv.FINDFIRST THEN
//                                 ERROR('The Invoice you are trying to cancel is not of Current Date');
//                         END;
//                         //EBT STIVAN (20062012)--- validation if Invoice Date and today date is not equal ---------------END

//                         //RSPLSUM 13Jan21>>
//                         CLEAR(InvoiceDateTime);
//                         CLEAR(DurationInvAndCancel);
//                         CLEAR(DurationInHours);
//                         IF "Applies-to Doc. No." <> '' THEN BEGIN
//                             PostedInv.RESET;
//                             IF PostedInv.GET("Applies-to Doc. No.") THEN BEGIN
//                                 PostedInv.CALCFIELDS(IRN);
//                                 InvoiceDateTime := CREATEDATETIME(PostedInv."Posting Date", PostedInv."Invoice Print Time");
//                                 DurationInvAndCancel := CURRENTDATETIME - InvoiceDateTime;
//                                 DurationInHours := ((DurationInvAndCancel / 1000) / 60) / 60;
//                                 IF DurationInHours > 24 THEN
//                                     //ERROR('Cannot cancel invoice after 24 hours');
//                                     //MESSAGE('Ok');
//                                     IF DurationInHours < 24 THEN BEGIN
//                                         IF PostedInv.IRN <> 'CANCELLED' THEN
//                                             ERROR('Please cancel IRN in posted invoice');
//                                     END;
//                             END;
//                         END;
//                         //RSPL Temp Comment 12012021 --
//                         //RSPLSUM 13Jan21<<
//                     end;
//                 }
//                 field(AppliedDocDate; rec.AppliedDocDate)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Applies to Doc. Date';
//                 }
//                 field("Applies-to ID"; rec."Applies-to ID")
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
//                     Editable = false;
//                 }
//                 field("Ship-to Address"; rec."Ship-to Address")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Ship-to Address 2"; rec."Ship-to Address 2")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Ship-to Post Code"; rec."Ship-to Post Code")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Ship-to City"; rec."Ship-to City")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Ship-to Contact"; rec."Ship-to Contact")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(FOC; rec.FOC)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Location Code"; rec."Location Code")
//                 {
//                     Importance = Promoted;
//                 }
//                 field("Shipment Date"; rec."Shipment Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = EditBunkerFields;
//                     Importance = Promoted;

//                     trigger OnValidate()
//                     begin
//                         //RSPLSUM 10Jun2020>>
//                         IF "Shortcut Dimension 1 Code" = 'DIV-14' THEN BEGIN
//                             DueDateGPIPOL;
//                         END;
//                         //RSPLSUM 10Jun2020>>
//                     end;
//                 }
//                 field("Shipping No. Series"; rec."Shipping No. Series")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Posting No. Series"; rec."Posting No. Series")
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
//                         SalesCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
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
//             group("Tax Information")
//             {
//                 Caption = 'Tax Information';
//                 field("Form Code"; rec."Form Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Form No."; rec."Form No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Calc. Inv. Discount (%)"; rec."Calc. Inv. Discount (%)")
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
//                     Caption = 'ST Pure Agent';
//                 }
//                 field("Service Tax Rounding Precision"; rec."Service Tax Rounding Precision")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Service Tax Rounding Type"; rec."Service Tax Rounding Type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Sale Return Type"; rec."Sale Return Type")
//                 {
//                     ApplicationArea = all;
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
//                 ApplicationArea = all;
//                 SubPageLink = "Table ID" = CONST(36),
//                               "Document Type" = FIELD("Document Type"),
//                              "Document No." = FIELD("No.");
//                 Visible = OpenApprovalEntriesExistForCurrUser;
//             }
//             part(part2; 9080)
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "No." = FIELD("Sell-to Customer No.");
//                 Visible = true;
//             }
//             part(part3; 9081)
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "No." = FIELD("Sell-to Customer No.");
//                 Visible = false;
//             }
//             part(part4; 9082)
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "No." = FIELD("Bill-to Customer No.");
//                 Visible = false;
//             }
//             part(part5; 9084)
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "No." = FIELD("Sell-to Customer No.");
//                 Visible = true;
//             }
//             part(part6; 9087)
//             {
//                 ApplicationArea = all;
//                 Provider = SalesLines;
//                 SubPageLink = "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("Document No."),
//                               "Line No." = FIELD("Line No.");
//                 Visible = false;
//             }
//             part(part7; 9092)
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "Table ID" = CONST(36),
//                               "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("No."),
//                               Status = CONST(Open);
//                 Visible = false;
//             }
//             part(part8; 9108)
//             {
//                 ApplicationArea = all;
//                 Provider = SalesLines;
//                 SubPageLink = "No." = FIELD("No.");
//                 Visible = false;
//             }
//             part(WorkflowStatus; 1528)
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 Enabled = false;
//                 ShowFilter = false;
//                 Visible = ShowWorkflowStatus;
//             }
//             systempart(sys1; Links)
//             {
//                 ApplicationArea = all;
//                 Visible = false;
//             }
//             systempart(sys2; Notes)
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
//             group("&Return Order")
//             {
//                 Caption = '&Return Order';
//                 Image = Return;
//                 action(Statistics)
//                 {
//                     Caption = 'Statistics';
//                     Image = Statistics;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F7';

//                     trigger OnAction()
//                     begin
//                         OpenSalesOrderStatistics;
//                         SalesCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
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
//                     RunObject = Page 21;
//                     RunPageLink = "No." = FIELD("Sell-to Customer No.");
//                     ShortCutKey = 'Shift+F7';
//                 }
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
//                 action(Approvals)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Approvals';
//                     Image = Approvals;
//                     Promoted = false;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = false;

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
//                     ApplicationArea = all;
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     Promoted = false;
//                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
//                     //PromotedIsBig = false;
//                     RunObject = Page 67;
//                     RunPageLink = Document Type=CONST(Return Order),
//                                   No.=FIELD(No.),
//                                   Document Line No.=CONST(0);
//                 }
//             }
//             group(Documents)
//             {
//                 Caption = 'Documents';
//                 Image = Documents;
//                 action("Return Receipts")
//                 {
//                     ApplicationArea=all;
//                     Caption = 'Return Receipts';
//                     Image = ReturnReceipt;
//                     RunObject = Page 6662;
//                                     RunPageLink = Return Order No.=FIELD(No.);
//                     RunPageView = SORTING(Return Order No.);
//                 }
//                 action("Cred&it Memos")
//                 {
//                     ApplicationArea=all;
//                     Caption = 'Cred&it Memos';
//                     Image = CreditMemo;
//                     RunObject = Page 144;
//                                     RunPageLink = Return Order No.=FIELD(No.);
//                     RunPageView = SORTING(Return Order No.);
//                 }
//                 separator()
//                 {
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 action("In&vt. Put-away/Pick Lines")
//                 {
//                     applicationarea=ALL;
//                     Caption = 'In&vt. Put-away/Pick Lines';
//                     Image = PickLines;
//                     RunObject = Page 5774;
//                                     RunPageLink = "Source Document"=CONST("Sales Return Order"),
//                                   "Source No."=FIELD("No.");
//                     RunPageView = SORTING("Source Document","Source No.","Location Code");
//                 }
//                 separator()
//                 {
//                 }
//                 action("St&ructure")
//                 {
//                     applicationarea=ALL;
//                     Caption = 'St&ructure';
//                     Image = Hierarchy;
//                     RunObject = Page 16305;
//                                     RunPageLink = Type=CONST(Sale),
//                                   "Document Type"=FIELD("Document Type"),
//                                   Document No.=FIELD(No.),
//                                   Structure Code=FIELD(Structure),
//                                   Document Line No.=FILTER(0);
//                 }
//                 action("Attached Gate Entry")
//                 {
//                     applicationarea=ALL;
//                     Caption = 'Attached Gate Entry';
//                     Image = InwardEntry;
//                     RunObject = Page 16481;
//                                     RunPageLink = Source Type=CONST(Sales Return Order),
//                                   Source No.=FIELD(No.);
//                 }
//                 action("Detailed &Tax")
//                 {
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
//                     Caption = 'Structure';
//                     Image = Hierarchy;

//                     trigger OnAction()
//                     begin
//                         CurrPage.SalesLines.PAGE.ShowStrOrderDetailsPITForm;
//                     end;
//                 }
//                 action("Structure Header Details")
//                 {
//                     RunObject = Page 50054;
//                                     RunPageLink = Type=CONST(Sale),
//                                   "Document Type"=FIELD("Document Type"),
//                                   "Document No."=FIELD("No."),
//                                   "Structure Code"=FIELD(Structure),
//                                   "Document Line No."=FILTER(0),
//                                   Header/Line=CONST(Header);
//                 }
//                 action("Whse. Receipt Lines")
//                 {
//                     Caption = 'Whse. Receipt Lines';
//                     Image = ReceiptLines;
//                     RunObject = Page 7342;
//                                     RunPageLink = "Source Type"=CONST(37),
//                                   "Source Subtype"=FIELD("Document Type"),
//                                   "Source No."=FIELD("No.");
//                     RunPageView = SORTING("Source Type","Source Subtype","Source No.","Source Line No.");
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
//                         ApprovalsMgmt: Codeunit 1535;
//                     begin
//                         ApprovalsMgmt.GetApprovalComment(Rec);
//                     end;
//                 }
//             }
//             action("&Print")
//             {
//                 Caption = '&Print';
//                 Ellipsis = true;
//                 Image = Print;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     DocPrint.PrintSalesHeader(Rec);
//                 end;
//             }
//             group(Release)
//             {
//                 Caption = 'Release';
//                 Image = ReleaseDoc;
//                 action(Release)
//                 {
//                     Caption = 'Re&lease';
//                     Image = ReleaseDoc;
//                     ShortCutKey = 'Ctrl+F9';

//                     trigger OnAction()
//                     var
//                         ReleaseSalesDoc: Codeunit 414;
//                     begin
//                         //EBT STIVAN---(30012013)---Error Message POP UP, IF Structure is Blank------START
//                         IF Structure = '' THEN
//                         BEGIN
//                          ERROR('Structure is Balnk');
//                         END;
//                         //EBT STIVAN---(30012013)---Error Message POP UP, IF Structure is Blank------END


//                         //EBT STIVAN ---(24/08/2012)--- Release Rights as per Sales Approval Setup ----------------------START
//                         recSalesApproval.RESET;
//                         recSalesApproval.SETRANGE(recSalesApproval."Approvar ID",USERID);
//                         IF recSalesApproval.FINDFIRST THEN
//                         BEGIN
//                         ReleaseSalesDoc.PerformManualRelease(Rec);
//                         END ELSE
//                         ERROR('You are not authorised to Release the Cancelled Invoice');
//                         //EBT STIVAN ---(24/08/2012)--- Release Rights as per Sales Approval Setup ------------------------END
//                     end;
//                 }
//                 action("Re&open")
//                 {
//                     Caption = 'Re&open';
//                     Image = ReOpen;

//                     trigger OnAction()
//                     var
//                         ReleaseSalesDoc: Codeunit 414;
//                     begin
//                         ReleaseSalesDoc.PerformManualReopen(Rec);
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
//                     AccessByPermission = TableData 19=R;
//                     Caption = 'Calculate &Invoice Discount';
//                     Image = CalculateInvoiceDiscount;

//                     trigger OnAction()
//                     begin
//                         ApproveCalcInvDisc;
//                         SalesCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action("Apply Entries")
//                 {
//                     Caption = 'Apply Entries';
//                     Ellipsis = true;
//                     Image = ApplyEntries;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     ShortCutKey = 'Shift+F11';

//                     trigger OnAction()
//                     begin
//                         CODEUNIT.RUN(CODEUNIT::"Sales Header Apply",Rec);
//                     end;
//                 }
//                 action("Create Return-Related &Documents")
//                 {
//                     Caption = 'Create Return-Related &Documents';
//                     Ellipsis = true;
//                     Image = ApplyEntries;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     begin
//                         CLEAR(CreateRetRelDocs);
//                         CreateRetRelDocs.SetSalesHeader(Rec);
//                         CreateRetRelDocs.RUNMODAL;
//                         CreateRetRelDocs.ShowDocuments;
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
//                 action(GetPostedDocumentLinesToReverse)
//                 {
//                     Caption = 'Get Posted Doc&ument Lines to Reverse';
//                     Ellipsis = true;
//                     Image = ReverseLines;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;

//                     trigger OnAction()
//                     begin
//                         //EBT STIVAN ---(26062012)--- Error Message Pop if Applies to Doc. No. is Blank ---START
//                           IF "Applies-to Doc. No." = '' THEN
//                             ERROR('Please select Applies to Doc. No.');
//                         //EBT STIVAN ---(26062012)--- Error Message Pop if Applies to Doc. No. is Blank -----END

//                         //EBT STIVAN ---(26062012)--- Error Message Pop if Posting No. Series is Blank ---START
//                         IF "Posting No. Series" = '' THEN
//                         ERROR('Please Select Posting No. Series');
//                         //EBT STIVAN ---(26062012)--- Error Message Pop if Posting No. Series is Blank -----END

//                         GetPstdDocLinesToRevere;
//                     end;
//                 }
//                 action("Get Gate Entry Lines")
//                 {
//                     Caption = 'Get Gate Entry Lines';
//                     Image = GetLines;

//                     trigger OnAction()
//                     begin
//                         GetGateEntryLines;
//                     end;
//                 }
//                 action("Archive Document")
//                 {
//                     Caption = 'Archive Document';
//                     Image = Archive;

//                     trigger OnAction()
//                     begin
//                         ArchiveManagement.ArchiveSalesDocument(Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Send IC Return Order Cnfmn.")
//                 {
//                     AccessByPermission = TableData 410=R;
//                     Caption = 'Send IC Return Order Cnfmn.';
//                     Image = IntercompanyOrder;

//                     trigger OnAction()
//                     var
//                         ICInOutboxMgt: Codeunit "427";
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
//                           ICInOutboxMgt.SendSalesDoc(Rec,FALSE);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action("Calc&ulate Structure Values")
//                 {
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
//                 action("Calculate &TCS")
//                 {
//                     Caption = 'Calculate &TCS';
//                     Image = CalculateCollectedTax;

//                     trigger OnAction()
//                     begin
//                         SalesLine.CalculateStructures(Rec);
//                         SalesLine.AdjustStructureAmounts(Rec);
//                         SalesLine.UpdateSalesLines(Rec);
//                         SalesLine.CalculateTCS(Rec);
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//             }
//             group(Warehouse)
//             {
//                 Caption = 'Warehouse';
//                 Image = Warehouse;
//                 separator()
//                 {
//                 }
//                 action("Create &Whse. Receipt")
//                 {
//                     AccessByPermission = TableData 7316=R;
//                     Caption = 'Create &Whse. Receipt';
//                     Image = NewReceipt;

//                     trigger OnAction()
//                     var
//                         GetSourceDocInbound: Codeunit "5751";
//                     begin
//                         GetSourceDocInbound.CreateFromSalesReturnOrder(Rec);
//                     end;
//                 }
//                 action("Create Inventor&y Put-away/Pick")
//                 {
//                     AccessByPermission = TableData 7340=R;
//                     Caption = 'Create Inventor&y Put-away/Pick';
//                     Ellipsis = true;
//                     Image = CreateInventoryPickup;

//                     trigger OnAction()
//                     begin
//                         CreateInvtPutAwayPick;
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
//                     Caption = 'P&ost';
//                     Ellipsis = true;
//                     Image = PostOrder;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     PromotedIsBig = true;
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     var
//                         InvoiceDateTime: DateTime;
//                         DurationInvAndCancel: Duration;
//                         DurationInHours: Decimal;
//                     begin

//                         //EBT/CANINV/0001
//                         IF "Cancelled Invoice" THEN
//                           IF ("Applies-to Doc. Type" = 0) AND ("Applies-to Doc. No." = '') THEN
//                             ERROR('You must select Applies-to Document Type and Applies-to Document No.');
//                         //EBT/CANINV/0001

//                         //Commented by EBT STIVAN (20062012)--So Same code wriiten at Applies-to Doc. No. - OnInputChange trigger ---START
//                         /*
//                         IF "Applies-to Doc. No." <> '' THEN
//                         BEGIN
//                           PostedInv.RESET;
//                           PostedInv.SETRANGE(PostedInv."No.","Applies-to Doc. No.");
//                           PostedInv.SETRANGE(PostedInv."Posting Date",TODAY);
//                           IF NOT PostedInv.FINDFIRST THEN
//                              ERROR('The Invoice you are trying to cancel is not of Current Date');
//                         END;
//                         */
//                         //Commented by EBT STIVAN (20062012)--So Same code wriiten at Applies-to Doc. No. - OnInputChange trigger -----END

//                         // EBT MILAN ----(10092013)---Error Message POP if Excise Amount is ZERO-------------------------------------------START
//                         //>>Rahul
//                         /*
//                         IF "Currency Code" = '' THEN
//                         BEGIN
//                           IF "Form Code" <> 'CT-3' THEN
//                           BEGIN
//                             recSCL.RESET;
//                             recSCL.SETRANGE(recSCL."Document No.","No.");
//                             recSCL.SETRANGE(recSCL.Type,recSCL.Type::Item);
//                             IF recSCL.FINDSET THEN
//                             REPEAT
//                              IF (recSCL."Item Category Code"='CAT02') OR (recSCL."Item Category Code"='CAT03') OR (recSCL."Item Category Code"='CAT11')
//                              OR (recSCL."Item Category Code"='CAT12') OR (recSCL."Item Category Code"='CAT15') THEN
//                              IF (recSCL."Excise Amount" = 0) THEN
//                               BEGIN
//                                ERROR('Please Calculate Structure Value, Excise Amount is not calculated');
//                               END;
//                             UNTIL recSCL.NEXT = 0;
//                           END;
//                         END;
//                         *///Commented as per UNI SIR 12July2017
//                         // EBT MILAN ----(10092013)---Error Message POP if Excise Amount is ZERO---------------------------------------------END

//                         //RSPLSUM 13Jan21>>
//                         CLEAR(InvoiceDateTime);
//                         CLEAR(DurationInvAndCancel);
//                         CLEAR(DurationInHours);
//                         IF "Applies-to Doc. No." <> '' THEN
//                         BEGIN
//                           PostedInv.RESET;
//                           IF PostedInv.GET("Applies-to Doc. No.") THEN BEGIN
//                             PostedInv.CALCFIELDS(IRN);
//                             InvoiceDateTime := CREATEDATETIME(PostedInv."Posting Date",PostedInv."Invoice Print Time");
//                             DurationInvAndCancel := CURRENTDATETIME - InvoiceDateTime;
//                             DurationInHours := ((DurationInvAndCancel / 1000)/60)/60;
//                             IF DurationInHours > 24 THEN
//                               //ERROR('Cannot cancel invoice after 24 hours');
//                               MESSAGE('click ok');
//                             //IF DurationInHours < 24 THEN BEGIN
//                               //IF PostedInv.IRN <> 'CANCELLED' THEN
//                                 //ERROR('Please cancel IRN in posted invoice');
//                             //END;
//                           END;
//                         END;
//                         //RSPLSUM 13Jan21<<

//                         Post(CODEUNIT::"Sales-Post (Yes/No)");
//                         VALIDATE("Cancelled Invoice");

//                     end;
//                 }
//                 action("Preview Posting")
//                 {
//                     Caption = 'Preview Posting';
//                     Image = ViewPostedOrder;

//                     trigger OnAction()
//                     begin
//                         ShowPreview;
//                     end;
//                 }
//                 action("Test Report")
//                 {
//                     Caption = 'Test Report';
//                     Ellipsis = true;
//                     Image = TestReport;

//                     trigger OnAction()
//                     begin
//                         ReportPrint.PrintSalesHeader(Rec);
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

//                     trigger OnAction()
//                     begin
//                         Post(CODEUNIT::"Sales-Post + Print");
//                     end;
//                 }
//                 action("Post &Batch")
//                 {
//                     Caption = 'Post &Batch';
//                     Ellipsis = true;
//                     Image = PostBatch;

//                     trigger OnAction()
//                     begin
//                         REPORT.RUNMODAL(REPORT::"Batch Post Sales Return Orders",TRUE,TRUE,Rec);
//                         CurrPage.UPDATE(FALSE);
//                     end;
//                 }
//                 action("Remove From Job Queue")
//                 {
//                     Caption = 'Remove From Job Queue';
//                     Image = RemoveLine;
//                     Visible = JobQueueVisible;

//                     trigger OnAction()
//                     begin
//                         CancelBackgroundPosting;
//                     end;
//                 }
//             }
//             group("Request Approval")
//             {
//                 Caption = 'Request Approval';
//                 action(SendApprovalRequest)
//                 {
//                     Caption = 'Send A&pproval Request';
//                     Enabled = NOT OpenApprovalEntriesExist;
//                     Image = SendApprovalRequest;
//                     Promoted = true;
//                     PromotedCategory = Category9;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
//                           ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
//                     end;
//                 }
//                 action(CancelApprovalRequest)
//                 {
//                     Caption = 'Cancel Approval Re&quest';
//                     Enabled = OpenApprovalEntriesExist;
//                     Image = Cancel;
//                     Promoted = true;
//                     PromotedCategory = Category9;

//                     trigger OnAction()
//                     var
//                         ApprovalsMgmt: Codeunit "1535";
//                     begin
//                         ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     begin
//         ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
//     end;

//     trigger OnAfterGetRecord()
//     begin

//         /*
//         IF "Posting Date" <> TODAY THEN
//            "Posting Date" := TODAY;
//         IF "Shipment Date" <> TODAY THEN
//            "Shipment Date" := TODAY;
//         */
//         //EBT/CANINV/0001
//         SalesSetup.GET;
//         "Posting No. Series" := SalesSetup."Posted Cancelled Invoice Nos.";
//         "Shipping No. Series" := SalesSetup."Posted Cancelled.Shipment Nos.";
//         //EBT/CANINV/0001
//         //EBT STIVAN (13092012)--- To Capture the Applies To Document Nos Date -------------START
//         recSIH.RESET;
//         recSIH.SETRANGE(recSIH."No.","Applies-to Doc. No.");
//         IF recSIH.FINDFIRST THEN
//         BEGIN
//         AppliedDocDate := recSIH."Posting Date";
//         END ELSE
//         AppliedDocDate := 0D;
//         //EBT STIVAN (13092012)--- To Capture the Applies To Document Nos Date ---------------END
//         SetControlAppearance;

//         //RSPLSUM 10Jun2020>>
//         IF "Shortcut Dimension 1 Code" = 'DIV-14' THEN
//           EditBunkerFields := TRUE
//         ELSE
//           EditBunkerFields := FALSE;
//         //RSPLSUM 10Jun2020<<

//     end;

//     trigger OnDeleteRecord(): Boolean
//     begin
//         CurrPage.SAVERECORD;
//         EXIT(ConfirmDeletion);
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         CheckCreditMaxBeforeInsert;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         "Document Type" := "Document Type" :: "Return Order";
//         "Responsibility Center" := UserMgt.GetSalesFilter;

//         //EBT/CANINV/0001
//         "Cancelled Invoice" := TRUE;
//         //EBT/CANINV/0001
//     end;

//     trigger OnOpenPage()
//     begin
//         //Code move to List Page
//         /*
//         CSOMapping2.RESET;
//         CSOMapping2.SETRANGE(CSOMapping2."User Id",UPPERCASE(USERID));
//         IF CSOMapping2.FINDFIRST THEN
//           BEGIN
//           //FILTERGROUP(2);
//           CI.RESET;
//           CI.SETRANGE(CI."Document Type","Document Type");
//           CI.SETFILTER(CI."Short Close",'%1',FALSE);
//           IF CI.FINDSET THEN
//           REPEAT
//             CSOMapping.RESET;
//             CSOMapping.SETRANGE(CSOMapping."User Id",UPPERCASE(USERID));
//             CSOMapping.SETRANGE(CSOMapping.Type,CSOMapping.Type::"Responsibility Center");
//             CSOMapping.SETRANGE(CSOMapping.Value,CI."Responsibility Center");
//             IF CSOMapping.FINDFIRST THEN
//                CI.MARK := TRUE
//             ELSE
//             BEGIN
//               CSOMapping1.RESET;
//               CSOMapping1.SETRANGE("User Id",UPPERCASE(USERID));
//               CSOMapping1.SETRANGE(Type,CSOMapping.Type::Location);
//               CSOMapping1.SETRANGE(Value,CI."Location Code");
//               IF CSOMapping1.FINDFIRST THEN
//                  CI.MARK := TRUE
//              END;
//           UNTIL CI.NEXT = 0;
//           CI.MARKEDONLY(TRUE);
//           COPY(CI);
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
//         //SETRANGE("Cancelled Invoice",TRUE);

//         //EBT STIVAN---(22/07/2013)----To Delete the Open Sales Return Order Older then 7 Days -----START
//         /*
//         IF ("Document Type" = "Document Type" :: "Return Order") AND ("Created Date" <> 0D)THEN
//         BEGIN
//          "7Days" := CALCDATE('-7D',TODAY);

//          RECSH.RESET;
//          RECSH.SETRANGE(RECSH."Document Type",RECSH."Document Type"::"Return Order");
//          RECSH.SETRANGE(RECSH.Status,RECSH.Status::Open);
//          RECSH.SETFILTER(RECSH."Created Date",'%1..%2',0D,"7Days");
//          IF RECSH.FINDFIRST THEN
//          REPEAT

//           RECSL.RESET;
//           RECSL.SETRANGE(RECSL."Document No.",RECSH."No.");
//           IF RECSL.FINDSET THEN
//           BEGIN
//            RECSL.DELETEALL;
//           END;

//           ReservEntr.RESET;
//           ReservEntr.SETRANGE(ReservEntr."Source ID",RECSH."No.");
//           IF ReservEntr.FINDSET THEN
//           BEGIN
//            ReservEntr.DELETEALL;
//           END;

//          UNTIL RECSH.NEXT = 0;

//          RECSH.RESET;
//          RECSH.SETRANGE(RECSH."Document Type",RECSH."Document Type"::"Return Order");
//          RECSH.SETRANGE(RECSH.Status,RECSH.Status::Open);
//          RECSH.SETFILTER(RECSH."Created Date",'%1..%2',0D,"7Days");
//          IF RECSH.FINDSET THEN
//          BEGIN
//           RECSH.DELETEALL;
//          END;
//         END;
//         */
//         //EBT STIVAN---(22/07/2013)----To Delete the Open Sales Return Order Older then 7 Days -------END
//         //>>Robosoft\Migratuon\Rahul***Code added to modify posting date
//         IF "Shortcut Dimension 1 Code" <> 'DIV-14' THEN BEGIN//RSPLSUM 10Jun2020
//           IF "No." <>'' THEN BEGIN
//             IF "Posting Date" <> TODAY THEN BEGIN
//                //VALIDATE("Posting Date",TODAY);
//                "Posting Date" :=  TODAY;
//                SalesLine1.RESET;
//                SalesLine1.SETCURRENTKEY("Document Type","Document No.","Line No.");
//                SalesLine1.SETRANGE("Document Type","Document Type");
//                SalesLine1.SETRANGE("Document No.","No.");
//                IF SalesLine1.FINDSET THEN REPEAT
//                  SalesLine1."Posting Date" := TODAY;
//                  SalesLine1.MODIFY;
//                UNTIL SalesLine1.NEXT =0;
//                 MODIFY;
//             END;

//             IF "Shipment Date" <> TODAY THEN BEGIN
//               // VALIDATE("Shipment Date",TODAY);
//               "Shipment Date" :=  TODAY;
//                SalesLine1.RESET;
//                SalesLine1.SETCURRENTKEY("Document Type","Document No.","Line No.");
//                SalesLine1.SETRANGE("Document Type","Document Type");
//                SalesLine1.SETRANGE("Document No.","No.");
//                IF SalesLine1.FINDSET THEN REPEAT
//                  SalesLine1."Shipment Date" := TODAY;
//                  SalesLine1.MODIFY;
//                UNTIL SalesLine1.NEXT =0;
//                MODIFY;
//             END;
//           END;
//         END;//RSPLSUM 10Jun2020
//         //EBT0001


//         SetDocNoVisible;

//         //RSPLSUM 10Jun2020>>
//         IF "Shortcut Dimension 1 Code" = 'DIV-14' THEN
//           EditBunkerFields := TRUE
//         ELSE
//           EditBunkerFields := FALSE;
//         //RSPLSUM 10Jun2020<<

//     end;

//     var
//         SalesSetup: Record "311";
//         SalesLine: Record "37";
//     //ChangeExchangeRate: Page "Change Exchange Rate";
//     //CopySalesDoc: Report "292";
//     // MoveNegSalesLines: Report "6699";
//     //CreateRetRelDocs: Report "6697";
//     ReportPrint: Codeunit "228";
//     DocPrint: Codeunit "229";
//     UserMgt: Codeunit "5700";
//     ArchiveManagement: Codeunit "5063";
//     SalesCalcDiscByType: Codeunit "56";
//     //[InDataSet]

//     JobQueueVisible: Boolean;
//     DocNoVisible: Boolean;
//     OpenApprovalEntriesExistForCurrUser: Boolean;
//     OpenApprovalEntriesExist: Boolean;
//     ShowWorkflowStatus: Boolean;
//     CSOMapping: Record "50006";
//     CSOMapping1: Record "50006";
//     CSOMapping2: Record "50006";
//     CI: Record "36";
//     "7Days": Date;
//     recSH: Record "36";
//     recSL: Record "37";
//     ReservEntr: Record "337";
//     User: Record "91";
//     recSIH: Record "112";
//     recSCL: Record "37";
//     AppliedDocDate: Date;
//     SROMonthName: Text[30];
//     InvMonthName: Text[30];
//     confirmed: Boolean;
//     HideValidationDialog: Boolean;
//     recSalesApproval: Record "50008";
//     recSIL: Record "113";
//     PostedInv: Record "112";
//     SalesLine1: Record "37";
//     EditBunkerFields: Boolean;

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
//         CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
//     end;

//     local procedure ShortcutDimension2CodeOnAfterV()
//     begin
//         CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
//     end;

//     local procedure PricesIncludingVATOnAfterValid()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure SetDocNoVisible()
//     var
//         DocumentNoVisibility: Codeunit "1400";
//         DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
//     begin
//         DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::"Return Order", "No.");
//     end;

//     [Scope('Internal')]
//     procedure ShowPreview()
//     var
//         SalesPostYesNo: Codeunit "81";
//     begin
//         SalesPostYesNo.Preview(Rec);
//     end;

//     local procedure SetControlAppearance()
//     var
//         ApprovalsMgmt: Codeunit "1535";
//     begin
//         JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";

//         OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
//         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
//     end;

//     local procedure DueDateGPIPOL()
//     var
//         PayTerm02: Record "3";
//     begin
//         //RSPLSUM 25May2020>>
//         IF ("No." <> '') THEN
//             IF "Shipment Date" <> 0D THEN BEGIN
//                 "Date GP" := TODAY;
//                 IF ("Payment Terms Code" <> '') THEN BEGIN
//                     IF PayTerm02.GET("Payment Terms Code") THEN;
//                     "Due Date" := CALCDATE(PayTerm02."Due Date Calculation", "Shipment Date");
//                 END;
//                 MODIFY;
//             END;
//         //RSPLSUM 25May2020<<
//     end;
// }

