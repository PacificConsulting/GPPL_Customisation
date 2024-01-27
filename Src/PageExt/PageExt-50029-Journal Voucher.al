pageextension 50029 "Journal VoucherExtcstm" extends "Journal Voucher"
{
    layout
    {
        // Add changes to page layout here
        modify("Posting Date")
        {
            Editable = FieldEditable;
        }
        modify("Document Date")
        {
            Editable = FieldEditable;
        }
        modify("Document No.")
        {
            Editable = FieldEditable;
        }
        modify("Document Type")
        {
            Editable = FieldEditable;
        }
        modify("Location Code")
        {
            Editable = FieldEditable;
        }


        modify("Account Type")
        {
            Editable = FieldEditable;
        }
        modify("Account No.")
        {
            Editable = FieldEditable;
        }
        modify(Description)
        {
            Editable = FieldEditable;
        }
        modify("Debit Amount")
        {
            Editable = FieldEditable;
        }
        modify("Credit Amount")
        {
            Editable = FieldEditable;
        }
        modify("Currency Code")
        {
            Editable = FieldEditable;
        }
        modify("Gen. Posting Type")
        {
            Editable = FieldEditable;
        }
        modify("Gen. Bus. Posting Group")
        {
            Editable = FieldEditable;
        }
        modify("Gen. Prod. Posting Group")
        {
            Editable = FieldEditable;
        }
        modify(Amount)
        {
            Editable = FieldEditable;
        }
        modify("Bal. Account No.")
        {
            Editable = FieldEditable;
        }

        modify("Bal. Account Type")
        {
            Editable = FieldEditable;
        }

        modify("Bal. Gen. Posting Type")
        {
            Editable = FieldEditable;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Editable = FieldEditable;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Editable = FieldEditable;
        }
        modify("Ship-to/Order Address Code")
        {
            Editable = FieldEditable;

        }
        addafter("Document No.")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Editable = FieldEditable;
            }
            field("Approval Status"; Rec."Approval Status")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        modify("A&ccount")
        {
            Visible = AccVisible;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //>>30Oct2018
                GJL.RESET;
                GJL.SETRANGE("Journal Template Name", rec."Journal Template Name");
                GJL.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                IF rec.GETFILTER("Document No.") <> '' THEN
                    GJL.SETFILTER("Document No.", rec.GETFILTER("Document No."));
                IF GJL.FINDSET THEN
                    REPEAT
                        GJL.TESTFIELD("Approval Status", GJL."Approval Status"::Approved);
                    UNTIL GJL.NEXT = 0;

                ValidationCheck;
                //<<30Oct2018
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //>>30Oct2018
                GJL.RESET;
                GJL.SETRANGE("Journal Template Name", rec."Journal Template Name");
                GJL.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                IF rec.GETFILTER("Document No.") <> '' THEN
                    GJL.SETFILTER("Document No.", rec.GETFILTER("Document No."));
                IF GJL.FINDSET THEN
                    REPEAT
                        GJL.TESTFIELD("Approval Status", GJL."Approval Status"::Approved);
                    UNTIL GJL.NEXT = 0;

                ValidationCheck;
                //<<30Oct2018
            end;
        }
        addafter("A&ccount")
        {
            group(ApprovalProcess)
            {
                Caption = 'ApprovalProcess';
                action("Send For Authorization")
                {
                    Image = Approval;

                    trigger OnAction()
                    begin

                        //>>29Oct2018
                        rec.TESTFIELD("Approval Status", rec."Approval Status"::Open);

                        ValidationCheck;

                        IF NOT rec."Send For Approval" THEN BEGIN
                            TempVersionNo := 0;
                            SAE11.RESET;
                            SAE11.SETCURRENTKEY("Document No.", "Version No.");
                            SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Journal Voucher");
                            SAE11.SETRANGE("Document No.", rec."Document No.");
                            IF SAE11.FINDLAST THEN BEGIN
                                TempVersionNo := SAE11."Version No.";
                            END;

                            SalesApproval.RESET;
                            SalesApproval.SETCURRENTKEY("Document Type");
                            SalesApproval.SETRANGE("Document Type", SalesApproval."Document Type"::"Journal Voucher");
                            SalesApproval.SETRANGE("User ID", USERID);
                            SalesApproval.SETFILTER("Approvar ID", '<>%1', '');
                            IF SalesApproval.FINDSET THEN BEGIN
                                TempSeqNo := 0;
                                REPEAT
                                    TempSeqNo += 1;
                                    SalesApprovalEntry.INIT;
                                    SalesApprovalEntry."Document Type" := SalesApprovalEntry."Document Type"::"Journal Voucher";
                                    SalesApprovalEntry."Document No." := rec."Document No.";
                                    SalesApprovalEntry."User ID" := USERID;
                                    SalesApprovalEntry."User Name" := SalesApproval.Name;
                                    SalesApprovalEntry."Approvar ID" := SalesApproval."Approvar ID";
                                    SalesApprovalEntry."Approver Name" := SalesApproval."Approvar Name";
                                    SalesApprovalEntry."Mandatory ID" := SalesApproval.Mandatory;
                                    SalesApprovalEntry."Date Sent for Approval" := TODAY;
                                    SalesApprovalEntry."Time Sent for Approval" := TIME;
                                    SalesApprovalEntry."Version No." := TempVersionNo + 1;
                                    SalesApprovalEntry."Sequence No." := TempSeqNo;
                                    SalesApprovalEntry.INSERT;
                                UNTIL SalesApproval.NEXT = 0;
                                MESSAGE('Document No. %1 has been sent for Approval', rec."Document No.");
                            END ELSE
                                ERROR('JV Approval setup does not exists for User %1', USERID);
                        END ELSE
                            ERROR('Document No. %1 has already been sent for approval');

                        //"Send For Approval" := TRUE;
                        //"Approval Status" := "Approval Status"::"Pending for L1 Approval";
                        //MODIFY;
                        //<<29Oct2018

                        //>>JV Modification
                        GJL01.RESET;
                        GJL01.SETRANGE("Journal Template Name", rec."Journal Template Name");
                        GJL01.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                        GJL01.SETRANGE("Document No.", rec."Document No.");
                        IF GJL01.FINDSET THEN
                            REPEAT
                                GJL01."Approval Status" := GJL01."Approval Status"::"Pending for L1 Approval";
                                GJL01."Send For Approval" := TRUE;
                                GJL01.MODIFY;
                            UNTIL GJL01.NEXT = 0;
                        CurrPage.UPDATE(TRUE);

                        //<<JV Modification

                        //>>Email Notification
                        GLSetup.GET;
                        IF GLSetup."Email Notification On JV" THEN
                            EmailNotification(6, rec."Document No.", 1, USERID, '', '');
                        //<<Email Notification
                    end;
                }
                action(ReOpen)
                {
                    Image = ReOpen;

                    trigger OnAction()
                    begin

                        //>>29Oct2018
                        //IF ("Approval Status" = "Approval Status"::Open) OR  ("Approval Status" = "Approval Status"::Approved) THEN
                        //ERROR('Only Pending Document Approval are allowed for Cancel Approval Request');

                        SalesApprovalEntry.RESET;
                        SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Journal Voucher");
                        SalesApprovalEntry.SETRANGE("Document No.", rec."Document No.");
                        SalesApprovalEntry.SETRANGE("User ID", USERID);
                        //SalesApprovalEntry.SETRANGE(Approved,FALSE);
                        IF NOT SalesApprovalEntry.FINDLAST THEN
                            ERROR('Approval Entry Not Found %1 Document', rec."Document No.");


                        //"Approval Status" := "Approval Status"::Open;
                        //"Send For Approval" := FALSE;
                        //MODIFY;
                        //<<29Oct2018

                        //>>JV Modification
                        GJL01.RESET;
                        GJL01.SETRANGE("Journal Template Name", rec."Journal Template Name");
                        GJL01.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                        GJL01.SETRANGE("Document No.", rec."Document No.");
                        IF GJL01.FINDSET THEN
                            REPEAT
                                GJL01."Approval Status" := GJL01."Approval Status"::Open;
                                GJL01."Send For Approval" := FALSE;
                                GJL01.MODIFY;
                            UNTIL GJL01.NEXT = 0;
                        CurrPage.UPDATE(TRUE);
                        //<<JV Modification

                        SalesApprovalEntry.RESET;
                        SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Journal Voucher");
                        SalesApprovalEntry.SETRANGE("Document No.", rec."Document No.");
                        SalesApprovalEntry.SETRANGE(Approved, FALSE);
                        SalesApprovalEntry.SETRANGE(Rejected, FALSE);
                        IF SalesApprovalEntry.FINDFIRST THEN BEGIN
                            SalesApprovalEntry.DELETEALL(TRUE);
                        END;
                    end;
                }
                action("Approve ")
                {
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin

                        //>>29Oct2018
                        rec.TESTFIELD("Approval Status", rec."Approval Status"::"Pending for L1 Approval");

                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SalesApproval."Document Type"::"Journal Voucher");
                        SalesApproval.SETRANGE("Approvar ID", USERID);
                        IF NOT SalesApproval.FINDFIRST THEN
                            ERROR('You donot have rights to Approve, Please Contact System Administrator');

                        SalesApprovalEntry.RESET;
                        SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Journal Voucher");
                        SalesApprovalEntry.SETRANGE("Document No.", rec."Document No.");
                        SalesApprovalEntry.SETRANGE("Approvar ID", USERID);
                        SalesApprovalEntry.SETRANGE(Approved, FALSE);
                        IF NOT SalesApprovalEntry.FINDLAST THEN
                            ERROR('Approval Entry Not Found %1 Document', rec."Document No.");

                        IF NOT CONFIRM(Text29001, FALSE) THEN
                            EXIT;

                        SalesApprovalEntry.RESET;
                        SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                        SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Journal Voucher");
                        SalesApprovalEntry.SETRANGE("Document No.", rec."Document No.");
                        SalesApprovalEntry.SETRANGE("Approvar ID", USERID);
                        IF SalesApprovalEntry.FINDLAST THEN BEGIN
                            SalesApproval.RESET;
                            SalesApproval.SETRANGE("Document Type", SalesApprovalEntry."Document Type");
                            SalesApproval.SETRANGE("User ID", SalesApprovalEntry."User ID");
                            SalesApproval.SETRANGE("Approvar ID", USERID);
                            IF SalesApproval.FINDFIRST THEN BEGIN
                                SalesApprovalEntry.Approved := TRUE;
                                SalesApprovalEntry."Approval Date" := TODAY;
                                SalesApprovalEntry."Approval Time" := TIME;
                                SalesApprovalEntry.MODIFY;

                                //>>Email
                                GLSetup.GET;
                                IF GLSetup."Email Notification On JV" THEN
                                    EmailNotification(6, rec."Document No.", 2, USERID, '', 'YES');
                                //<<Email

                                //"Approval Status" := "Approval Status"::Approved;
                                //"Level1 Approval" := TRUE;
                                //MODIFY;
                                MESSAGE('Approved');

                                SAE11.RESET;
                                SAE11.SETCURRENTKEY("Document Type", "Document No.", "Version No.");
                                SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Blanket PO");
                                SAE11.SETRANGE("Document No.", SalesApprovalEntry."Document No.");
                                SAE11.SETRANGE("Version No.", SalesApprovalEntry."Version No.");
                                SAE11.SETRANGE(Approved, FALSE);
                                IF SAE11.FINDFIRST THEN BEGIN
                                    SAE11.DELETEALL(TRUE);
                                END;
                            END;
                        END;
                        //<<29Oct2018

                        //>>JV Modification
                        GJL01.RESET;
                        GJL01.SETRANGE("Journal Template Name", rec."Journal Template Name");
                        GJL01.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                        GJL01.SETRANGE("Document No.", rec."Document No.");
                        IF GJL01.FINDSET THEN
                            REPEAT
                                GJL01."Approval Status" := GJL01."Approval Status"::Approved;
                                GJL01."Level1 Approval" := TRUE;
                                GJL01.MODIFY;
                            UNTIL GJL01.NEXT = 0;
                        CurrPage.UPDATE(TRUE);
                        //<<JV Modification
                    end;
                }
                action(Rejection)
                {
                    Caption = 'Reject';
                    Image = Reject;

                    trigger OnAction()
                    begin

                        //>>30Oct2018
                        rec.TESTFIELD("Approval Status", rec."Approval Status"::"Pending for L1 Approval");

                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SalesApproval."Document Type"::"Journal Voucher");
                        SalesApproval.SETRANGE("Approvar ID", USERID);
                        IF NOT SalesApproval.FINDFIRST THEN
                            ERROR('You donot have rights to Reject, Please Contact System Administrator');

                        SalesApprovalEntry.RESET;
                        SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Journal Voucher");
                        SalesApprovalEntry.SETRANGE("Document No.", rec."Document No.");
                        SalesApprovalEntry.SETRANGE("Approvar ID", USERID);
                        SalesApprovalEntry.SETRANGE(Approved, FALSE);
                        IF NOT SalesApprovalEntry.FINDLAST THEN
                            ERROR('Approval Entry Not Found %1 Document', rec."Document No.");


                        //>>Reject Process
                        SalesApprovalEntry.RESET;
                        SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                        SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Journal Voucher");
                        SalesApprovalEntry.SETRANGE("Document No.", rec."Document No.");
                        SalesApprovalEntry.SETRANGE("Approvar ID", USERID);
                        IF SalesApprovalEntry.FINDLAST THEN BEGIN

                            SalesApprovalEntry.Rejected := TRUE;
                            SalesApprovalEntry."Rejected Date" := TODAY;
                            SalesApprovalEntry."Rejected Time" := TIME;
                            SalesApprovalEntry.MODIFY;

                            //"Send For Approval" := FALSE;
                            //MODIFY(TRUE);
                            MESSAGE('Rejected');

                            SAE11.RESET;
                            SAE11.SETCURRENTKEY("Document Type", "Document No.");
                            SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Journal Voucher");
                            SAE11.SETRANGE("Document No.", SalesApprovalEntry."Document No.");
                            SAE11.SETRANGE("Version No.", SalesApprovalEntry."Version No.");
                            SAE11.SETRANGE(Approved, FALSE);
                            SAE11.SETRANGE(Rejected, FALSE);
                            IF SAE11.FINDFIRST THEN BEGIN
                                SAE11.DELETEALL(TRUE);
                            END;
                        END;
                        //>>Reject Process

                        //>>Email
                        GLSetup.GET;
                        IF GLSetup."Email Notification On JV" THEN
                            EmailNotification(6, rec."Document No.", 3, USERID, '', '');
                        //<<Email

                        //>>JV Modification
                        GJL01.RESET;
                        GJL01.SETRANGE("Journal Template Name", rec."Journal Template Name");
                        GJL01.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                        GJL01.SETRANGE("Document No.", rec."Document No.");
                        IF GJL01.FINDSET THEN
                            REPEAT
                                GJL01."Approval Status" := GJL01."Approval Status"::Open;
                                GJL01."Send For Approval" := FALSE;
                                GJL01.MODIFY;
                            UNTIL GJL01.NEXT = 0;
                        CurrPage.UPDATE(TRUE);
                        //<<JV Modification
                    end;
                }
                action("Level2 Approval")
                {
                    Enabled = false;
                    Image = Approvals;
                    Visible = false;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin

                        //>>29Oct2018
                        rec.TESTFIELD("Approval Status", rec."Approval Status"::"Pending for L2 Approval");

                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SalesApproval."Document Type"::"Journal Voucher");
                        SalesApproval.SETRANGE("Level2 Approvar ID", USERID);
                        IF NOT SalesApproval.FINDFIRST THEN
                            ERROR('You donot have rights to Approve, Please Contact System Administrator');

                        SAE11.RESET;
                        SAE11.SETCURRENTKEY("Document Type", "Document No.");
                        SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Journal Voucher");
                        SAE11.SETRANGE("Document No.", rec."Document No.");
                        SAE11.SETRANGE(Approved, TRUE);
                        IF SAE11.FINDLAST THEN BEGIN
                            SalesApproval.RESET;
                            SalesApproval.SETRANGE("Document Type", SAE11."Document Type");
                            SalesApproval.SETRANGE("User ID", SAE11."User ID");
                            SalesApproval.SETRANGE("Approvar ID", SAE11."Approvar ID");
                            SalesApproval.SETRANGE("Level2 Approvar ID", USERID);
                            IF NOT SalesApproval.FINDFIRST THEN
                                ERROR('JV Approval Setup does not exists for Level2 Approval');
                        END;

                        IF NOT rec."Level2 Approval" THEN BEGIN
                            IF NOT CONFIRM(Text29002, FALSE) THEN
                                EXIT;

                            SalesApprovalEntry.RESET;
                            SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                            SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Journal Voucher");
                            SalesApprovalEntry.SETRANGE("Document No.", rec."Document No.");
                            SalesApprovalEntry.SETRANGE(Approved, TRUE);
                            IF SalesApprovalEntry.FINDLAST THEN BEGIN
                                UserName06 := '';
                                User06.RESET;
                                User06.SETRANGE("User Name", USERID);
                                IF User06.FINDFIRST THEN
                                    UserName06 := User06."Full Name"
                                ELSE
                                    UserName06 := USERID;

                                SalesApprovalEntry."Level2 Approvar ID" := USERID;
                                SalesApprovalEntry."Level2 Approvar Name" := UserName06;
                                SalesApprovalEntry."Level2 Approvar Date" := TODAY;
                                SalesApprovalEntry."Level2 Approvar Time" := TIME;
                                SalesApprovalEntry.MODIFY;

                                rec."Approval Status" := rec."Approval Status"::Approved;
                                rec."Level2 Approval" := TRUE;
                                rec.MODIFY;
                                MESSAGE('Approved');

                            END;
                        END;
                        //<<29Oct2018

                        //>>Email
                        GLSetup.GET;
                        IF GLSetup."Email Notification On JV" THEN
                            EmailNotification(6, rec."Document No.", 4, USERID, '', '');
                        //<<Email
                    end;
                }
                action("Approval Entries")
                {
                    Image = Ledger;

                    trigger OnAction()
                    begin

                        AppPage.Setfilters(6, rec."Document No.");
                        AppPage.RUN;
                    end;
                }
            }

        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        AccessControl: Record "Access Control";
    begin
        //RSPL-TC +
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETFILTER("Role ID", '%1|%2', 'SUPER', 'LEDGER ENTRIES VIEW');
        IF AccessControl.FINDFIRST THEN
            AccVisible := TRUE
        ELSE
            AccVisible := FALSE;
        //RSPL-TC -
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //>>30Oct2018
        FieldEditable := FALSE;
        IF rec."Approval Status" = rec."Approval Status"::Open THEN
            FieldEditable := TRUE;

        IF rec."Approval Status" = rec."Approval Status"::"Pending for L1 Approval" THEN BEGIN
            SalesApprovalEntry.RESET;
            SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Journal Voucher");
            SalesApprovalEntry.SETRANGE("Document No.", rec."Document No.");
            SalesApprovalEntry.SETRANGE("Approvar ID", USERID);
            IF SalesApprovalEntry.FINDFIRST THEN BEGIN
                FieldEditable := TRUE;
            END;
        END;

        IF rec."Approval Status" = rec."Approval Status"::Approved THEN
            FieldEditable := FALSE;
        //<<30Oct2018
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        //>>30Oct2018
        FieldEditable := FALSE;
        IF rec."Approval Status" = rec."Approval Status"::Open THEN
            FieldEditable := TRUE;
        //<<30Oct2018
    end;

    trigger OnDeleteRecord(): Boolean
    var
        myInt: Integer;
    begin
        rec.TESTFIELD("Approval Status", rec."Approval Status"::Open);//30Oct2018
    end;

    var
        myInt: Integer;
        AccVisible: Boolean;
        FieldEditable: Boolean;
        SalesApprovalEntry: Record "Sales Approval Entry";
        ChangeExchangeRate: Page 511;
        GLReconcile: Page 345;
        GenJnlManagement: Codeunit 230;
        ReportPrint: Codeunit 228;
        CurrentJnlBatchName: Code[10];
        AccName: Text[75];
        BalAccName: Text[60];
        Balance: Decimal;
        TotalBalance: Decimal;
        ShowBalance: Boolean;
        ShowTotalBalance: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        Text000: Label 'General Journal lines have been successfully inserted from Standard General Journal %1.';
        Text001: Label 'Standard General Journal %1 has been successfully created.';
        TotalDebitAmount: Decimal;
        TotalCreditAmount: Decimal;
        OpenedFromBatch: Boolean;
        //[InDataSet]
        BalanceVisible: Boolean;
        //[InDataSet]
        TotalBalanceVisible: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesOnJnlBatchExist: Boolean;
        OpenApprovalEntriesOnJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrCurrJnlLineExist: Boolean;
        OpenApprovalEntriesOnBatchOrAnyJnlLineExist: Boolean;
        ShowWorkflowStatusOnBatch: Boolean;
        ShowWorkflowStatusOnLine: Boolean;
        //AccVisible: Boolean;
        AccessControl: Record 2000000053;
        "-------02Jul2018": Integer;
        User02: Record 91;
        "-------29Oct2018---ApprovalProcess": Integer;
        TempVersionNo: Integer;
        SAE11: Record 50009;
        SalesApproval: Record 50008;
        // SalesApprovalEntry: Record "50009";
        User06: Record 2000000120;
        UserName06: Text;
        GJL06: Record 81;
        AppPage: Page 50010;
        GLSetup: Record 98;
        TempSeqNo: Integer;
        Text29001: Label 'First Level Approval , Do you want to Approve.';
        Text29002: Label 'Final Approval, Do you want to Approve.';
        GJL01: Record 81;
        // FieldEditable: Boolean;
        GJL: Record 81;
    //SMTPMailSetup: Record "409";

    local procedure ValidationCheck()
    begin
        GJL06.RESET;
        GJL06.SETRANGE("Journal Template Name", rec."Journal Template Name");
        GJL06.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
        GJL06.SETRANGE("Document No.", rec."Document No.");
        IF GJL06.FINDSET THEN
            REPEAT
                GJL06.TESTFIELD("Shortcut Dimension 1 Code");
                GJL06.TESTFIELD("Shortcut Dimension 2 Code");
                GJL06.TESTFIELD(Amount);
            UNTIL GJL06.NEXT = 0;

        GJL06.RESET;
        GJL06.SETRANGE("Journal Template Name", rec."Journal Template Name");
        GJL06.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
        GJL06.SETRANGE("Document No.", rec."Document No.");
        IF GJL06.FINDFIRST THEN BEGIN
            GJL06.CALCSUMS("Balance (LCY)");
            IF GJL06."Balance (LCY)" <> 0 THEN
                ERROR('Amount is not Balance');
        END;
    end;

    local procedure EmailNotification(DocType: Option "Sales Order","Blanket PO","Sales Invoice","Sales CrMemo","Purch Invoice","Purch CrMemo","Journal Voucher"; DocNo: Code[20]; SeqNo: Integer; SenderID: Code[50]; ReceiveID: Code[50]; FirstID: Code[50])
    var
        //SMTPMail: Codeunit "400";
        SAE18: Record 50009;
        SA18: Record 50008;
        SubjectText: Text;
        User18: Record 91;
        SenderName: Text;
        SenderEmail: Text;
        ReceiveEmail: Text;
        Text18: Text;
        Cust18: Record 23;
        TotalCrAmt: Decimal;
        TotalDrAmt: Decimal;
        EmailMsg: Codeunit "Email Message";//SMTPMail: Codeunit 400;
        RecipientType: Enum "Email Recipient Type";
        Instr: InStream;
        EmailObj: Codeunit Email;
    begin
        //SMTPMailSetup.GET;//RSPLSUM03Apr21

        SubjectText := '';
        SenderName := '';
        SenderEmail := '';
        Text18 := '';
        //CLEAR(SMTPMail);

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
            ReceiveEmail := SenderEmail;
        END;

        IF SeqNo = 2 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Approved Mail';
            Text18 := 'has been Approved.';
            ReceiveEmail := SenderEmail;
        END;

        IF SeqNo = 3 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Rejection Mail';
            Text18 := 'has been Rejected.';

            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", rec."Document No.");
            SAE18.SETRANGE(Rejected, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                User18.RESET;
                User18.SETRANGE("User ID", SAE18."User ID");
                IF User18.FINDFIRST THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    ReceiveEmail := User18."E-Mail";
                END;
            END;

        END;

        IF SeqNo = 4 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Approval Mail';
            Text18 := 'Requires L2 Approval.';
            ReceiveEmail := SenderEmail;
        END;


        //>>Email Body
        //RSPLSUM03Apr21--SMTPMail.CreateMessage(SenderName,SenderEmail,ReceiveEmail,SubjectText,'',TRUE);
        // SMTPMail.CreateMessage(SenderName, SMTPMailSetup."User ID", ReceiveEmail, SubjectText, '', TRUE);//RSPLSUM03Apr21
        EmailMsg.Create(ReceiveEmail, SubjectText, '', true);
        IF SeqNo = 1 THEN BEGIN
            SA18.RESET;
            SA18.SETCURRENTKEY("Document Type");
            SA18.SETRANGE("Document Type", DocType);
            SA18.SETRANGE("User ID", SenderID);
            IF SA18.FINDSET THEN
                REPEAT
                    //>>Level1 Approvar
                    User18.RESET;
                    User18.SETRANGE("User ID", SA18."Approvar ID");
                    IF User18.FINDFIRST THEN BEGIN
                        User18.TESTFIELD("E-Mail");
                        //SMTPMail.AddRecipients(User18."E-Mail");
                        EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                    END;
                //>>Level1 Approvar

                /*
                //>>Level2 Approvar
                IF SA18."Level2 Approvar ID" <> '' THEN BEGIN
                User18.RESET;
                User18.SETRANGE("User ID",SA18."Level2 Approvar ID");
                IF User18.FINDFIRST THEN
                BEGIN
                  User18.TESTFIELD("E-Mail");
                  SMTPMail.AddRecipients(User18."E-Mail");
                END;
                END;
                //>>Level2 Approvar
                */
                UNTIL SA18.NEXT = 0;
        END;

        IF SeqNo = 2 THEN BEGIN
            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", rec."Document No.");
            SAE18.SETRANGE("Approvar ID", SenderID);
            SAE18.SETRANGE(Approved, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                User18.RESET;
                User18.SETRANGE("User ID", SAE18."User ID");
                IF User18.FINDFIRST THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    //SMTPMail.AddRecipients(User18."E-Mail");
                    EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
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
                                //SMTPMail.AddRecipients(User18."E-Mail");
                                EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                            END;
                        //>>Level1 Approvar
                        /*
                        //>>Level2 Approvar
                        IF SA18."Level2 Approvar ID" <> '' THEN
                        BEGIN
                          User18.RESET;
                          User18.SETRANGE("User ID",SA18."Level2 Approvar ID");
                          IF User18.FINDFIRST THEN
                          BEGIN
                            User18.TESTFIELD("E-Mail");
                            SMTPMail.AddRecipients(User18."E-Mail");
                          END;
                        END;
                        //>>Level2 Approvar
                        */
                        UNTIL SA18.NEXT = 0;

                END;
            END;
        END;

        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<B> Microsoft Dynamics NAV Document Approval System </B>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br> <B> Journal Voucher No.  - </B>' + '<B>' + rec."Document No." + '</B>' + ' ' + Text18);
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Table  Border="1">');//Table Start
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Company Name </th>');
        EmailMsg.AppendToBody('<td>' + COMPANYNAME + '</td>');
        EmailMsg.AppendToBody('</tr>');
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>JV No.</th>');
        EmailMsg.AppendToBody('<td>' + rec."Document No." + '</td>');
        EmailMsg.AppendToBody('</tr>');
        //>>TotalAmount
        TotalCrAmt := 0;
        TotalDrAmt := 0;
        GJL06.RESET;
        GJL06.SETRANGE("Journal Template Name", rec."Journal Template Name");
        GJL06.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
        GJL06.SETRANGE("Document No.", rec."Document No.");
        IF GJL06.FINDSET THEN
            REPEAT
                IF GJL06."Debit Amount" > 0 THEN
                    TotalDrAmt += GJL06."Debit Amount";
                IF GJL06."Credit Amount" > 0 THEN
                    TotalCrAmt += GJL06."Credit Amount";

                IF GJL06."Bal. Account No." <> '' THEN BEGIN
                    IF GJL06."Debit Amount" > 0 THEN
                        TotalCrAmt += GJL06."Debit Amount";
                    IF GJL06."Credit Amount" > 0 THEN
                        TotalDrAmt += GJL06."Credit Amount";
                END;
            UNTIL GJL06.NEXT = 0;
        //<<TotalAmount
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Total Debit Amount</th>');
        EmailMsg.AppendToBody('<td>' + FORMAT(TotalDrAmt, 0, '<Integer Thousand><Decimals,3>') + '</td>');
        EmailMsg.AppendToBody('</tr>');
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Total Credit Amount</th>');
        EmailMsg.AppendToBody('<td>' + FORMAT(TotalCrAmt, 0, '<Integer Thousand><Decimals,3>') + '</td>');
        EmailMsg.AppendToBody('</tr>');
        EmailMsg.AppendToBody('</table>');//Table End
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        //SMTPMail.Send; //Fahim Comment on 06-05-22
        //<<Email Body

    end;
}