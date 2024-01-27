page 50086 "Outward GatePass Requisition"
{
    // 
    // Date        Version      Remarks
    // .....................................................................................
    // 14Nov2018   RB-N         New Page Development from P#6640

    Caption = 'Outward GatePass Requisition';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval';
    RefreshOnActivate = true;
    SourceTable = 38;
    SourceTableView = WHERE("Document Type" = CONST("Return Order"),
                            "Gate Pass" = CONST(true));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {

                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {

                    ApplicationArea = all;
                    Editable = true;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin

                        BuyfromVendorNoOnAfterValidate;

                        Rec."Posting No. Series" := 'OGPP';//17Mar2019
                    end;
                }
                field("Buy-from Contact No."; rec."Buy-from Contact No.")
                {

                    ApplicationArea = all;
                    Editable = false;
                    QuickEntry = false;
                }
                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {

                    ApplicationArea = all;
                    Editable = false;
                    QuickEntry = false;
                }
                field("Buy-from Address"; rec."Buy-from Address")
                {

                    ApplicationArea = all;
                    Editable = false;
                    QuickEntry = false;
                }
                field("Buy-from Address 2"; rec."Buy-from Address 2")
                {

                    ApplicationArea = all;
                    Editable = false;
                    QuickEntry = false;
                }
                field("Buy-from Post Code"; rec."Buy-from Post Code")
                {

                    ApplicationArea = all;
                    Editable = false;
                    QuickEntry = false;
                }
                field("Buy-from City"; rec."Buy-from City")
                {

                    ApplicationArea = all;
                    Editable = false;
                    QuickEntry = false;
                }
                field("Buy-from Contact"; rec."Buy-from Contact")
                {

                    ApplicationArea = all;
                    QuickEntry = false;
                }
                field("No. of Archived Versions"; rec."No. of Archived Versions")
                {

                    ApplicationArea = all;
                    QuickEntry = false;
                }
                // field(Structure; rec.Structure)
                // {
                //     ApplicationArea = all;
                // }
                field("Full Name"; rec."Full Name")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    QuickEntry = false;
                }
                field("Order Date"; rec."Order Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    QuickEntry = false;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    QuickEntry = false;
                }
                field("Vendor Authorization No."; rec."Vendor Authorization No.")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Visible = false;
                }
                field("Vendor Cr. Memo No."; rec."Vendor Cr. Memo No.")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Visible = false;
                }
                field("Order Address Code"; rec."Order Address Code")
                {
                    ApplicationArea = all;
                    QuickEntry = false;
                }
                field("Purchaser Code"; rec."Purchaser Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    QuickEntry = false;

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate;
                    end;
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = all;
                    QuickEntry = false;
                }
                field("Assigned User ID"; rec."Assigned User ID")
                {
                    ApplicationArea = all;
                    QuickEntry = false;
                }
                field("Job Queue Status"; rec."Job Queue Status")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                    QuickEntry = false;
                }
                field("Approval Status"; rec."Approval Status")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    QuickEntry = false;
                    Visible = false;
                }
                field("Gate Pass Status"; rec."Gate Pass Status")
                {
                    ApplicationArea = all;
                }
                field("Mode of Transport"; rec."Mode of Transport")
                {
                    ApplicationArea = all;
                }
                field("Requestor's Dept"; rec."Requestor's Dept")
                {
                    ApplicationArea = all;
                }
                field("Return Material Date"; rec."Return Material Date")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        IF Rec."Return Material Date" <> 0D THEN
                            IF Rec."Return Material Date" < Rec."Posting Date" THEN
                                ERROR('Return Material Date is greater than Posting Date');
                    end;
                }
                field("Purpose of GatePass"; rec."Purpose of GatePass")
                {
                    ApplicationArea = all;
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = all;
                }
                field("Posting No. Series"; rec."Posting No. Series")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Return Shipment No. Series"; rec."Return Shipment No. Series")
                {
                    ApplicationArea = all;
                }
            }
            part(PurchLines; 50087)
            {
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
                {
                    ApplicationArea = all;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                field("Pay-to Contact No."; rec."Pay-to Contact No.")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Name"; rec."Pay-to Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pay-to Address"; rec."Pay-to Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pay-to Address 2"; rec."Pay-to Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pay-to Post Code"; rec."Pay-to Post Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Pay-to City"; rec."Pay-to City")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Pay-to Contact"; rec."Pay-to Contact")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Posting No."; rec."Posting No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Last Posting No."; rec."Last Posting No.")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Applies-to Doc. Type"; rec."Applies-to Doc. Type")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Applies-to Doc. No."; rec."Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Applies-to ID"; rec."Applies-to ID")
                {
                    ApplicationArea = all;
                }
                field("Prices Including VAT"; rec."Prices Including VAT")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Return Shipment No."; rec."Return Shipment No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Last Return Shipment No."; rec."Last Return Shipment No.")
                {
                    ApplicationArea = all;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Address"; rec."Ship-to Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to Address 2"; rec."Ship-to Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to Post Code"; rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to City"; rec."Ship-to City")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Ship-to Contact"; rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Expected Receipt Date"; rec."Expected Receipt Date")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Receiving No. Series"; rec."Receiving No. Series")
                {
                    ApplicationArea = all;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Visible = false;
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF rec."Posting Date" <> 0D THEN
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        ELSE
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Transaction Type"; rec."Transaction Type")
                {
                    ApplicationArea = all;
                }
                field("Transaction Specification"; rec."Transaction Specification")
                {
                    ApplicationArea = all;
                }
                field("Transport Method"; rec."Transport Method")
                {
                    ApplicationArea = all;
                }
                field("Entry Point"; rec."Entry Point")
                {
                    ApplicationArea = all;
                }
                field(Area1; rec.Area)
                {
                    ApplicationArea = all;
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                // field("Service Type (Rev. Chrg.)"; rec."Service Type (Rev. Chrg.)")
                // {
                //     ApplicationArea = all;
                // }
                // field("Consignment Note No."; rec."Consignment Note No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Declaration Form (GTA)"; rec."Declaration Form (GTA)")
                // {
                //     ApplicationArea = all;
                // }
                // field("Input Service Distribution"; rec."Input Service Distribution")
                // {
                //     ApplicationArea = all;
                // }
                field(Trading; rec.Trading)
                {
                    ApplicationArea = all;
                }
                // field(PoT; rec.PoT)
                // {
                //     ApplicationArea = all;
                // }
                // field("C Form"; rec."C Form")
                // {
                //     ApplicationArea = all;
                // }
                // field("Form Code"; rec."Form Code")
                // {
                //     ApplicationArea = all;
                // }
                // field("Form No."; rec."Form No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax Rounding Precision"; rec."Service Tax Rounding Precision")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax Rounding Type"; rec."Service Tax Rounding Type")
                // {
                //     ApplicationArea = all;
                // }
                field("Nature of Supply"; rec."Nature of Supply")
                {
                    ApplicationArea = all;
                }
                field("GST Vendor Type"; rec."GST Vendor Type")
                {
                    ApplicationArea = all;
                }
                field("Invoice Type"; rec."Invoice Type")
                {
                    ApplicationArea = all;
                }
                field("GST Input Service Distribution"; rec."GST Input Service Distribution")
                {
                    ApplicationArea = all;
                }
                field("Bill of Entry No."; rec."Bill of Entry No.")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Bill of Entry Date"; rec."Bill of Entry Date")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
                field("Bill of Entry Value"; rec."Bill of Entry Value")
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
            }
        }
        area(factboxes)
        {
            part(part1; 9103)
            {
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
                ApplicationArea = all;
            }
            part(part2; 9092)
            {
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No."),
                              Status = CONST(Open);
                Visible = false;
                ApplicationArea = all;
            }
            part(part3; 9093)
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
                ApplicationArea = all;
            }
            part(part4; 9094)
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
                ApplicationArea = all;
            }
            part(part5; 9095)
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
                ApplicationArea = all;
            }
            part(part6; 9096)
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
                ApplicationArea = all;
            }
            part(part7; 9100)
            {
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
                Visible = false;
                ApplicationArea = all;
            }
            part(WorkflowStatus; 1528)
            {
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
                ApplicationArea = all;
            }
            systempart(part8; Links)
            {
                Visible = false;
                ApplicationArea = all;
            }
            systempart(part10; Notes)
            {
                Visible = true;
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Return Order")
            {
                Caption = '&Return Order';
                Image = Return;
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        Rec.OpenPurchaseOrderStatistics;
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Vendor)
                {
                    ApplicationArea = all;
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page 26;
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                action(Dimensions)
                {
                    ApplicationArea = all;
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = all;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page 658;
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 66;
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("Return Shipments")
                {
                    ApplicationArea = all;
                    Caption = 'Return Shipments';
                    Image = Shipment;
                    RunObject = Page 6652;
                    RunPageLink = "Return Order No." = FIELD("No.");
                    RunPageView = SORTING("Return Order No.");
                }
                action("Cred&it Memos")
                {
                    ApplicationArea = all;
                    Caption = 'Cred&it Memos';
                    Image = CreditMemo;
                    RunObject = Page 147;
                    RunPageLink = "Return Order No." = FIELD("No.");
                    RunPageView = SORTING("Return Order No.");
                }
                separator(sep1)
                {
                }
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Whse. Shipment Lines")
                {
                    ApplicationArea = all;
                    Caption = 'Whse. Shipment Lines';
                    Image = ShipmentLines;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(39),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    Visible = false;
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    // ApplicationArea = all;
                    // Caption = 'In&vt. Put-away/Pick Lines';
                    // Image = PickLines;
                    // RunObject = Page 5774;
                    // RunPageLink = Source Document=CONST("Purchase Return Order"),
                    //               "Source No."=FIELD("No.");
                    // RunPageView = SORTING("Source Document","Source No.","Location Code");
                    // Visible = false;
                }
                // separator()
                // {
                // }
                action("St&ructure")
                {
                    //  ApplicationArea = all;    
                    //     Caption = 'St&ructure';
                    //     Image = Hierarchy;
                    //     RunObject = Page 16305;
                    //                     RunPageLink = Type=CONST('Purchase'),
                    //                   "Document Type"=FIELD("Document Type"),
                    //                   "Document No."=FIELD("No."),
                    //                   "Structure Code"=FIELD(Structure);
                    //     Visible = false;
                }
                action("Detailed &Tax")
                {
                    // ApplicationArea=all;
                    // Caption = 'Detailed &Tax';
                    // Image = TaxDetail;
                    // RunObject = Page 16341;
                    //                 RunPageLink = "Document Type"=FIELD("Document Type"),
                    //               "Document No."=FIELD("No."),
                    //               "Transaction Type"=CONST(Purchase);
                    // Visible = false;
                }
                action("Detailed GST")
                {
                    // ApplicationArea=all;
                    // Caption = 'Detailed GST';
                    // Image = ServiceTax;
                    // RunObject = Page 16412;
                    //                 RunPageLink = "Transaction Type"=FILTER(Purchase),
                    //               "Document Type"=FIELD("Document Type"),
                    //               "Document No."=FIELD("No.");
                    // Visible = false;
                }
            }
        }
        area(processing)
        {
            group(ApprovalProcess)
            {
                Caption = 'ApprovalProcess';
                action("Send For Authorization")
                {
                    ApplicationArea = all;
                    Image = Approval;

                    trigger OnAction()
                    begin

                        rec.TESTFIELD(Status, rec.Status::Open);
                        rec.TESTFIELD("Approval Status", rec."Approval Status"::Open);
                        ValidationCheck;

                        IF NOT rec."Send For Approval" THEN BEGIN
                            TempVersionNo := 0;
                            SAE11.RESET;
                            SAE11.SETCURRENTKEY("Document No.", "Version No.");
                            SAE11.SETRANGE("Document Type", SAE11."Document Type"::GatePass);
                            SAE11.SETRANGE("Document No.", rec."No.");
                            IF SAE11.FINDLAST THEN
                                TempVersionNo := SAE11."Version No." + 1
                            ELSE
                                TempVersionNo := 1;

                            SalesApproval.RESET;
                            SalesApproval.SETCURRENTKEY("Document Type");
                            SalesApproval.SETRANGE("Document Type", SalesApproval."Document Type"::GatePass);
                            SalesApproval.SETRANGE("User ID", USERID);
                            SalesApproval.SETFILTER("Approvar ID", '<>%1', '');
                            IF SalesApproval.FINDSET THEN BEGIN
                                TempSeqNo := 0;
                                REPEAT
                                    TempSeqNo += 1;
                                    SalesApprovalEntry.INIT;
                                    SalesApprovalEntry."Document Type" := SalesApprovalEntry."Document Type"::GatePass;
                                    SalesApprovalEntry."Document No." := rec."No.";
                                    SalesApprovalEntry."User ID" := USERID;
                                    SalesApprovalEntry."User Name" := SalesApproval.Name;
                                    SalesApprovalEntry."Approvar ID" := SalesApproval."Approvar ID";
                                    SalesApprovalEntry."Approver Name" := SalesApproval."Approvar Name";
                                    SalesApprovalEntry."Mandatory ID" := SalesApproval.Mandatory;
                                    SalesApprovalEntry."Date Sent for Approval" := TODAY;
                                    SalesApprovalEntry."Time Sent for Approval" := TIME;
                                    SalesApprovalEntry."Version No." := TempVersionNo;
                                    SalesApprovalEntry."Sequence No." := TempSeqNo;
                                    SalesApprovalEntry.INSERT;
                                UNTIL SalesApproval.NEXT = 0;
                                MESSAGE('Document No. %1 has been sent for Approval', rec."No.");
                            END ELSE
                                ERROR('GatePass  Approval setup does not exists for User %1', USERID);
                        END ELSE
                            ERROR('Document No. %1 has already been sent for approval');

                        rec."Send For Approval" := TRUE;
                        rec."Approval Status" := rec."Approval Status"::"Pending for L1 Approval";
                        rec.Status := rec.Status::"Pending Approval";
                        rec.MODIFY;

                        //>>Email Notification
                        PurPay.GET;
                        IF PurPay."Email Alert on GatePass" THEN
                            EmailNotification(1, rec."No.", 1, USERID, '', '');
                        //<<Email Notification
                    end;
                }
                action("Level1 Approval")
                {
                    ApplicationArea = all;
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin

                        rec.TESTFIELD("Approval Status", rec."Approval Status"::"Pending for L1 Approval");

                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SalesApproval."Document Type"::GatePass);
                        SalesApproval.SETRANGE("Approvar ID", USERID);
                        IF NOT SalesApproval.FINDFIRST THEN
                            ERROR('You donot have rights to Approve, Please Contact System Administrator');

                        SalesApprovalEntry.RESET;
                        SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::GatePass);
                        SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                        SalesApprovalEntry.SETRANGE("Approvar ID", USERID);
                        SalesApprovalEntry.SETRANGE(Approved, FALSE);
                        IF NOT SalesApprovalEntry.FINDLAST THEN
                            ERROR('Approval Entry Not Found %1 Document', rec."No.");

                        SalesApprovalEntry.RESET;
                        SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                        SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::GatePass);
                        SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                        SalesApprovalEntry.SETRANGE("Approvar ID", USERID);
                        IF SalesApprovalEntry.FINDLAST THEN BEGIN
                            IF NOT CONFIRM(Text001, FALSE) THEN
                                EXIT;

                            SalesApprovalEntry.Approved := TRUE;
                            SalesApprovalEntry."Approval Date" := TODAY;
                            SalesApprovalEntry."Approval Time" := TIME;
                            SalesApprovalEntry.MODIFY;

                            //>>Email Notification
                            PurPay.GET;
                            IF PurPay."Email Alert on GatePass" THEN
                                EmailNotification(1, rec."No.", 2, USERID, '', 'YES');
                            //<<Email Notification

                            ReleasePurchDoc.PerformManualRelease(Rec);
                            rec."Approval Status" := rec."Approval Status"::Approved;
                            rec."Level1 Approval" := TRUE;
                            MODIFY;
                            MESSAGE('Approved');
                            cduArchveMgmt.StorePurchDocument(Rec, FALSE);

                            SAE11.RESET;
                            SAE11.SETCURRENTKEY("Document Type", "Document No.", "Version No.");
                            SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Blanket PO");
                            SAE11.SETRANGE("Document No.", SalesApprovalEntry."Document No.");
                            SAE11.SETRANGE("Version No.", SalesApprovalEntry."Version No.");
                            SAE11.SETRANGE(Approved, FALSE);
                            SAE11.SETRANGE(Rejected, FALSE);
                            IF SAE11.FINDFIRST THEN BEGIN
                                SAE11.DELETEALL(TRUE);
                            END;
                        END;
                    end;
                }
                action("Approval Entries")
                {
                    applicationarea = all;
                    Image = Ledger;

                    trigger OnAction()
                    begin

                        AppPage.Setfilters(7, rec."No.");
                        AppPage.RUN;
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    applicationarea = all;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    applicationarea = all;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    applicationarea = all;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(rec.RECORDID);
                    end;
                }
                action(Comment)
                {
                    applicationarea = all;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    DocPrint.PrintPurchHeader(Rec);
                end;
            }
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("Re&lease")
                {
                    applicationarea = all;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        ERROR('You cannot release Document directly');
                        //ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    applicationarea = all;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        //>>14Nov2018
                        rec."Send For Approval" := FALSE;
                        rec."Approval Status" := rec."Approval Status"::Open;
                        rec."Level1 Approval" := FALSE;
                        rec."Level2 Approval" := FALSE;
                        rec.MODIFY;
                        //<<14Nov2018
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }

            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(GetPostedDocumentLinesToReverse)
                {
                    // applicationarea=all;
                    // Caption = 'Get Posted Doc&ument Lines to Reverse';
                    // Ellipsis = true;
                    // Image = ReverseLines;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    // PromotedIsBig = true;
                    // Visible = false;

                    // trigger OnAction()
                    // begin
                    //     IF "GST Vendor Type" <>  "GST Vendor Type"::" " THEN
                    //       TESTFIELD("Location Code");
                    //     GetPstdDocLinesToRevere;
                    // end;
                }
                action("Apply Entries")
                {
                    applicationarea = all;
                    Caption = 'Apply Entries';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+F11';
                    Visible = false;

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Purchase Header Apply", Rec);
                    end;
                }

                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData 24 = R;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    Visible = false;
                    applicationarea = all;
                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }

                action(CopyDocument)
                {
                    applicationarea = all;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                        IF rec.GET(rec."Document Type", rec."No.") THEN;
                    end;
                }
                action("Move Negative Lines")
                {
                    applicationarea = all;
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL;
                        MoveNegPurchLines.ShowDocument;
                    end;
                }
                action("Archive Document")
                {
                    applicationarea = all;
                    Caption = 'Archive Document';
                    Image = Archive;
                    Visible = false;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Send IC Return Order")
                {
                    // applicationarea=all;
                    // AccessByPermission = TableData 410=R;
                    // Caption = 'Send IC Return Order';
                    // Image = IntercompanyOrder;
                    // Visible = false;

                    // trigger OnAction()
                    // var
                    //     ICInOutMgt: Codeunit "StringConversionManagement";
                    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    // begin
                    //     IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                    //       ICInOutMgt.SendPurchDoc(Rec,FALSE);
                    // end;
                }

                action("Calc&ulate Structure Values")
                {
                    Caption = 'Calc&ulate Structure Values';
                    Image = CalculateHierarchy;

                    trigger OnAction()
                    begin
                        //PurchLine.CalculateStructures(Rec);
                        //PurchLine.AdjustStructureAmounts(Rec);
                        //PurchLine.UpdatePurchLines(Rec);
                    end;
                }

            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = Approval;
                Visible = false;
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    Visible = false;

                    // trigger OnAction()
                    // var
                    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    // begin
                    //     IF ApprovalsMgmt.CheckPurchaseApprovalsWorkflowEnabled(Rec) THEN
                    //         ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    // end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }

            }
            group(Warehouse2)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create &Whse. Shipment")
                {
                    // AccessByPermission = TableData 7320 = R;
                    // Caption = 'Create &Whse. Shipment';
                    // Image = NewShipment;
                    // Visible = false;

                    // trigger OnAction()
                    // var
                    //     GetSourceDocOutbound: Codeunit "5752";
                    // begin
                    //     GetSourceDocOutbound.CreateFromPurchaseReturnOrder(Rec);
                    // end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData 7342 = R;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Visible = false;

                    trigger OnAction()
                    begin
                        rec.CreateInvtPutAwayPick;
                    end;
                }

            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post1)
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        ValidationCheck;//14Nov2018
                        Post(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action(Preview)
                {
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;

                    trigger OnAction()
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(TestReport)
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(PostAndPrint)
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        ValidationCheck;//14Nov2018
                        Post(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action(PostBatch)
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purch. Ret. Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        rec.CancelBackgroundPosting;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(rec.RECORDID);
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;

        IF rec."Posting Date" <> TODAY THEN
            rec."Posting Date" := TODAY;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(rec.ConfirmDeletion);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        rec."No." := NoSeries.GetNextNo('OGP', WORKDATE, TRUE);//17Mar2019
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        rec."Gate Pass" := TRUE;//14Nov2018
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
            rec.FILTERGROUP(2);
            rec.SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
            rec.FILTERGROUP(0);
        END;

        SetDocNoVisible;

        //>>14Nov2018
        IF rec."No." <> '' THEN
            IF rec."Posting Date" <> TODAY THEN BEGIN
                rec."Posting Date" := TODAY;
                rec.MODIFY;
                PL14.RESET;
                PL14.SETRANGE("Document Type", rec."Document Type");
                PL14.SETRANGE("Document No.", rec."No.");
                IF PL14.FINDFIRST THEN
                    PL14.MODIFYALL("Posting Date", TODAY);
            END;
        //<<14Nov2018
    end;

    var
        PurchSetup: Record 312;
        ChangeExchangeRate: Page 511;
        CopyPurchDoc: Report 492;
        MoveNegPurchLines: Report 6698;
        DocPrint: Codeunit 229;
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit 5063;
        PurchCalcDiscByType: Codeunit 66;
        PurchLine: Record 39;
        //[InDataSet]

        JobQueueVisible: Boolean;
        DocNoVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;
        recSalesApproval: Record 50008;
        "---------------14Nov2018": Integer;
        PL14: Record 39;
        TempVersionNo: Integer;
        SAE11: Record 50009;
        SalesApproval: Record 50008;
        TempSeqNo: Integer;
        SalesApprovalEntry: Record 50009;
        PurPay: Record 312;
        Text001: Label 'First Level Approval , Do you want to Approve.';
        Text002: Label 'Final Approval, Do you want to Approve.';
        cduArchveMgmt: Codeunit 5063;
        AppPage: Page 50010;
        NoSeries: Codeunit 396;
    //SMTPMailSetup: Record 409;

    local procedure Post(PostingCodeunitID: Integer)
    begin
        Rec.SendToPosting(PostingCodeunitID);
        IF rec."Job Queue Status" = rec."Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        IF rec.GETFILTER("Buy-from Vendor No.") = xRec."Buy-from Vendor No." THEN
            IF rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." THEN
                rec.SETRANGE("Buy-from Vendor No.");
        CurrPage.UPDATE;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit "DocumentNoVisibility";
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::"Return Order", rec."No.");
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        JobQueueVisible := rec."Job Queue Status" = rec."Job Queue Status"::"Scheduled for Posting";
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(rec.RECORDID);
    end;

    local procedure ValidationCheck()
    begin
        //>>14Nov2018
        PL14.RESET;
        PL14.SETRANGE("Document Type", rec."Document Type");
        PL14.SETRANGE("Document No.", rec."No.");
        IF NOT PL14.FINDFIRST THEN
            ERROR('No Lines Found');

        PL14.RESET;
        PL14.SETRANGE("Document Type", rec."Document Type");
        PL14.SETRANGE("Document No.", rec."No.");
        IF PL14.FINDSET THEN BEGIN
            PL14.TESTFIELD(Quantity);
            PL14.TESTFIELD("Line Amount", 0);
            PL14.TESTFIELD("Return Qty. to Ship");
        END;

        rec.TESTFIELD("Buy-from Vendor No.");
        rec.TESTFIELD("Gate Pass Status");
        rec.TESTFIELD("Mode of Transport");
        rec.TESTFIELD("Requestor's Dept");
        rec.TESTFIELD("Purpose of GatePass");
        IF rec."Gate Pass Status" = rec."Gate Pass Status"::Returnable THEN
            rec.TESTFIELD("Return Material Date");
        //<<14Nov2018
    end;

    //[Scope('Internal')]
    procedure EmailNotification(DocType: Option "Sales Order","Blanket PO","Sales Invoice","Sales CrMemo","Purch Invoice","Purch CrMemo","Journal Voucher",GatePass; DocNo: Code[20]; SeqNo: Integer; SenderID: Code[50]; ReceiveID: Code[50]; FirstID: Code[50])
    var
        //SMTPMail: Codeunit 400;
        SAE18: Record 50009;
        SA18: Record 50008;
        SubjectText: Text;
        User18: Record 91;
        SenderName: Text;
        SenderEmail: Text;
        Text18: Text;
        Cust18: Record 23;
        OtAmt: Decimal;
        CrAmt: Decimal;
    begin
        /*
        SMTPMailSetup.GET;//RSPLSUM02Apr21

        SubjectText := '';
        SenderName := '';
        SenderEmail := '';
        Text18 := '';
        CLEAR(SMTPMail);

        //>>SenderID
        User18.RESET;
        IF User18.GET(SenderID) THEN BEGIN
            User18.TESTFIELD("E-Mail");
            SenderEmail := User18."E-Mail";
            IF User18.Name <> '' THEN
                SenderName := User18.Name
            ELSE
                SenderName := SenderID;
        END;
        //<<SenderID

        IF SeqNo = 1 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Approval Mail';
            Text18 := 'Requires Approval.';
        END;

        IF SeqNo = 2 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Approved Mail';
            Text18 := 'has been Approved.';
        END;

        IF SeqNo = 3 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Credit Limit Approval Mail';
            Text18 := 'Requires Level2 Approval.';
        END;

        IF SeqNo = 4 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Over Due Approval Mail';
            Text18 := 'Over Due Approval.';
        END;

        //>>CreditLimit
        CLEAR(OtAmt);
        Cust18.RESET;
        IF Cust18.GET("Buy-from Vendor No.") THEN BEGIN
            Cust18.CALCFIELDS("Balance (LCY)");
            OtAmt := Cust18."Balance (LCY)";
        END;
        //<<CreditLimit

        //>>Email Body
        //RSPLSUM02Apr21--SMTPMail.CreateMessage(SenderName,SenderEmail,SenderEmail,SubjectText,'',TRUE);
        SMTPMail.CreateMessage(SenderName, SMTPMailSetup."User ID", SenderEmail, SubjectText, '', TRUE);//RSPLSUM02Apr21

        IF SeqNo = 1 THEN BEGIN
            SA18.RESET;
            SA18.SETCURRENTKEY("Document Type");
            SA18.SETRANGE("Document Type", DocType);
            SA18.SETRANGE("User ID", SenderID);
            SA18.SETFILTER("Approvar ID", '<>%1', '');
            IF SA18.FINDSET THEN
                REPEAT
                    User18.RESET;
                    User18.SETRANGE("User ID", SA18."Approvar ID");
                    IF User18.FINDFIRST THEN BEGIN
                        User18.TESTFIELD("E-Mail");
                        SMTPMail.AddRecipients(User18."E-Mail");
                    END;
                UNTIL SA18.NEXT = 0;
        END;

        IF SeqNo = 2 THEN BEGIN
            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", "No.");
            SAE18.SETRANGE("Approvar ID", SenderID);
            SAE18.SETRANGE(Approved, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                User18.RESET;
                User18.SETRANGE("User ID", SAE18."User ID");
                IF User18.FINDFIRST THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    SMTPMail.AddRecipients(User18."E-Mail");

                    SA18.RESET;
                    SA18.SETCURRENTKEY("Document Type");
                    SA18.SETRANGE("Document Type", DocType);
                    SA18.SETRANGE("User ID", SAE18."User ID");
                    SA18.SETFILTER("Approvar ID", '<>%1', SenderID);
                    IF SA18.FINDSET THEN
                        REPEAT
                            //>>Level1 Approvar
                            User18.RESET;
                            User18.SETRANGE("User ID", SA18."Approvar ID");
                            IF User18.FINDFIRST THEN BEGIN
                                User18.TESTFIELD("E-Mail");
                                SMTPMail.AddRecipients(User18."E-Mail");
                            END;
                        //>>Level1 Approvar
                        UNTIL SA18.NEXT = 0;
                END;
            END;
        END;

        SMTPMail.AppendBody('<Br>');
        SMTPMail.AppendBody('<Br>');
        SMTPMail.AppendBody('<B> Microsoft Dynamics NAV Document Approval System </B>');
        SMTPMail.AppendBody('<Br>');
        SMTPMail.AppendBody('<Br> <B> GatePass Requisition No.  - </B>' + '<B>' + "No." + '</B>' + ' ' + Text18);
        SMTPMail.AppendBody('<Br>');
        SMTPMail.AppendBody('<Br>');
        SMTPMail.AppendBody('<Table  Border="1">');//Table Start
        SMTPMail.AppendBody('<tr>');
        SMTPMail.AppendBody('<th>Company Name </th>');
        SMTPMail.AppendBody('<td>' + COMPANYNAME + '</td>');
        SMTPMail.AppendBody('</tr>');
        SMTPMail.AppendBody('<tr>');
        SMTPMail.AppendBody('<th>Amount (LCY) </th>');
        CALCFIELDS("Amount to Vendor");
        SMTPMail.AppendBody('<td>' + FORMAT("Amount to Vendor", 0, '<Integer Thousand><Decimals,3>') + '</td>');
        SMTPMail.AppendBody('</tr>');
        SMTPMail.AppendBody('<tr>');
        SMTPMail.AppendBody('<th>Vendor</th>');
        SMTPMail.AppendBody('<td>' + "Buy-from Vendor No." + '  ' + "Buy-from Vendor Name" + '</td>');
        SMTPMail.AppendBody('</tr>');
        SMTPMail.AppendBody('<tr>');
        SMTPMail.AppendBody('<th>Due Date </th>');
        SMTPMail.AppendBody('<td>' + FORMAT("Due Date") + '</td>');
        SMTPMail.AppendBody('</tr>');
        SMTPMail.AppendBody('</table>');//Table End
        SMTPMail.AppendBody('<Br>');
        SMTPMail.AppendBody('<Br>');
        SMTPMail.Send;
        //<<Email Body
        */
    end;
}

