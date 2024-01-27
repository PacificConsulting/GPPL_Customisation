page 50072 "Expense Invoices"
{
    Caption = 'Purchase Invoices';
    CardPageID = "Purchase Invoice";
    Editable = false;
    PageType = List;
    SourceTable = 38;
    SourceTableView = WHERE("Document Type" = CONST(Invoice));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(group1)
            {
                field("No."; rec."No.")
                {
                    applicationarea = all;
                }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                    applicationarea = all;
                }
                field("Order Address Code"; rec."Order Address Code")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {
                    applicationarea = all;
                }
                field("Vendor Authorization No."; rec."Vendor Authorization No.")
                {
                    applicationarea = all;
                }
                field("Buy-from Post Code"; rec."Buy-from Post Code")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; rec."Buy-from Country/Region Code")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Buy-from Contact"; rec."Buy-from Contact")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Pay-to Name"; rec."Pay-to Name")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Pay-to Post Code"; rec."Pay-to Post Code")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; rec."Pay-to Country/Region Code")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Pay-to Contact"; rec."Pay-to Contact")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Ship-to Code"; rec."Ship-to Code")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Ship-to Post Code"; rec."Ship-to Post Code")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; rec."Ship-to Country/Region Code")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Ship-to Contact"; rec."Ship-to Contact")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    applicationarea = all;
                    Visible = true;
                }
                field("Purchaser Code"; rec."Purchaser Code")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Assigned User ID"; rec."Assigned User ID")
                {
                    applicationarea = all;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Document Date"; rec."Document Date")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field(Status; rec.Status)
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Payment Terms Code"; rec."Payment Terms Code")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Due Date"; rec."Due Date")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Payment Discount %"; rec."Payment Discount %")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Payment Method Code"; rec."Payment Method Code")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Requested Receipt Date"; rec."Requested Receipt Date")
                {
                    applicationarea = all;
                    Visible = false;
                }
                field("Job Queue Status"; rec."Job Queue Status")
                {
                    applicationarea = all;
                    Visible = JobQueueActive;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    applicationarea = all;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Purchase Statistics", Rec);
                    end;
                }
                action("Co&mments")
                {
                    applicationarea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 66;
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(Dimensions)
                {
                    applicationarea = all;
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action(Approvals)
                {
                    applicationarea = all;
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
            }
        }
        area(processing)
        {
            group(ReleaseG)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    applicationarea = all;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    applicationarea = all;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = "Action";
                action(SendApprovalRequest)
                {
                    applicationarea = all;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalsMgmt.CheckPurchaseApprovalsWorkflowEnabled(Rec) THEN
                        // ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    applicationarea = all;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    applicationarea = all;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action(Preview)
                {
                    applicationarea = all;
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
                    applicationarea = all;
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
                    applicationarea = all;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action(PostBatch)
                {
                    applicationarea = all;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Invoices", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    applicationarea = all;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueActive;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        //CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage()
    var
        PurchasesPayablesSetup: Record 312;
    begin
        Rec.SetSecurityFilterOnRespCenter;

        JobQueueActive := PurchasesPayablesSetup.JobQueueActive;
    end;

    var
        ReportPrint: Codeunit 228;
        // [InDataSet]
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
    end;
}

