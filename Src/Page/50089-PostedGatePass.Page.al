page 50089 "Posted GatePass"
{
    // Date        Version      Remarks
    // .....................................................................................
    // 14Nov2018   RB-N         New Page Development from P#140

    Caption = 'Posted GatePass';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = 124;
    SourceTableView = SORTING("No.")
                      WHERE("Gate Pass" = CONST(true));
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
                    Editable = false;
                    Importance = Promoted;
                }
                field("Buy-from Contact No."; rec."Buy-from Contact No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Address"; rec."Buy-from Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Address 2"; rec."Buy-from Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Post Code"; rec."Buy-from Post Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from City"; rec."Buy-from City")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Buy-from Contact"; rec."Buy-from Contact")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field(Structure; rec.Structure)
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                //     Importance = Promoted;
                // }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pre-Assigned No."; rec."Pre-Assigned No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vendor Cr. Memo No."; rec."Vendor Cr. Memo No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Order Address Code"; rec."Order Address Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Purchaser Code"; rec."Purchaser Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No. Printed"; rec."No. Printed")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            part(PurchCrMemoLines; 141)
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Pay-to Contact No."; rec."Pay-to Contact No.")
                {
                    ApplicationArea = all;
                    Editable = false;
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
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pay-to City"; rec."Pay-to City")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pay-to Contact"; rec."Pay-to Contact")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field("LC No."; rec."LC No.")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Applies-to Doc. Type"; rec."Applies-to Doc. Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Applies-to Doc. No."; rec."Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
                // field("C Form"; rec."C Form")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                // field("Form Code"; rec."Form Code")
                // {
                //     ApplicationArea = all;
                // }
                // field("Form No."; rec."Form No.")
                // {
                //     ApplicationArea = all;
                // }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    Editable = false;
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
                    Editable = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Visible = false;
                field("Currency Code"; CurrCode)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    /*
                                        trigger OnAssistEdit()
                                        var
                                            ChangeExchangeRate: Page "Change Exchange Rate";
                                        begin
                                            ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date");
                                            ChangeExchangeRate.EDITABLE(FALSE);
                                            IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                                                "Currency Factor" := ChangeExchangeRate.GetParameter;
                                                MODIFY;
                                            END;
                                        end;
                                        */
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                // field("Service Type (Rev. Chrg.)"; rec."Service Type (Rev. Chrg.)")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                // field("Consignment Note No."; rec."Consignment Note No.")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                // field("Declaration Form (GTA)"; rec."Declaration Form (GTA)")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field(Remarks; rec.Remarks)
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
                field("Associated Enterprises"; rec."Associated Enterprises")
                {
                    ApplicationArea = all;
                }
                field("Bill of Entry No."; rec."Bill of Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Bill of Entry Date"; rec."Bill of Entry Date")
                {
                    ApplicationArea = all;
                }
                field("Bill of Entry Value"; rec."Bill of Entry Value")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; 193)
            {
                ApplicationArea = all;
                ShowFilter = false;
            }
            systempart(sys1; Links)
            {
                ApplicationArea = all;
                Visible = false;
            }
            systempart(sys2; Notes)
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
            group("&Cr. Memo")
            {
                Caption = '&Cr. Memo';
                Image = CreditMemo;
                Visible = false;
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 401;
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 66;
                    RunPageLink = "Document Type" = CONST("Posted Credit Memo"),
                                 "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ShowPostedApprovalEntries(Rec.RECORDID);
                    end;
                }
                action("St&ructure")
                {
                    Caption = 'St&ructure';
                    Image = Hierarchy;
                    //RunObject = Page 16308;
                    //RunPageLink = Type = CONST(Purchase), "No." = FIELD("No."), "Structure Code" = FIELD(Structure);
                }
                action("Third Party Invoices")
                {
                    Caption = 'Third Party Invoices';
                    Image = Invoice;
                    //RunObject = Page 16307;
                    //RunPageLink = Type = CONST(Purchase), "Invoice No." = FIELD("No.");
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Enabled = false;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(PurchCrMemoHeader);
                    PurchCrMemoHeader.PrintRecords(TRUE);
                end;
            }
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.Navigate;
                end;
            }
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;
                action(IncomingDocCard)
                {
                    Caption = 'View Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = ViewOrder;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';

                    trigger OnAction()
                    var
                        IncomingDocument: Record 130;
                    begin
                        IncomingDocument.ShowCard(Rec."No.", Rec."Posting Date");
                    end;
                }
                action(SelectIncomingDoc)
                {
                    AccessByPermission = TableData 130 = R;
                    Caption = 'Select Incoming Document';
                    Enabled = NOT HasIncomingDocument;
                    Image = SelectLineToApply;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        //IncomingDocument.SelectIncomingDocumentForPostedDocument("No.", "Posting Date");
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Enabled = NOT HasIncomingDocument;
                    Image = Attach;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record 133;
                    begin
                        IncomingDocumentAttachment.NewAttachmentFromPostedDocument(Rec."No.", Rec."Posting Date");
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Posted GatePass")
            {
                Image = Print;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUNMODAL(50219, TRUE, FALSE, Rec)
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        IncomingDocument: Record 130;
    begin
        HasIncomingDocument := IncomingDocument.PostedDocExists(Rec."No.", Rec."Posting Date");
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnAfterGetRecord()
    begin

        //>> RB-N 16Sep2017
        CurrCode := '';
        IF Rec."Currency Code" <> '' THEN
            CurrCode := Rec."Currency Code"
        ELSE
            CurrCode := '';
        //<< RB-N 16Sep2017
    end;

    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnRespCenter;
    end;

    var
        PurchCrMemoHeader: Record 124;
        //ChangeExchangeRate: Page "Change Exchange Rate";
        HasIncomingDocument: Boolean;
        GLEntry: Record 17;
        "----------16Sep2017": Integer;
        CurrCode: Code[20];
}

