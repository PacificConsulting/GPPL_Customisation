page 50149 "Mintifi Log"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50049;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = true;
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Entry Date"; rec."Entry Date")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Source Type"; rec."Source Type")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Source Name"; rec."Source Name")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Source No."; rec."Source No.")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    StyleExpr = TxtColorMessage;
                }
                field("Status Message"; rec."Status Message")
                {
                    ApplicationArea = all;
                    StyleExpr = TxtColorMessage;
                }
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Created By"; rec."Created By")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Upload Mintifi")
            {
                Image = AddAction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                trigger OnAction()
                var
                    MintifiLogRec: Record 50049;
                //MintifiAPIMgmt: Codeunit 50014;
                begin

                    MintifiLogRec.RESET;
                    MintifiLogRec.SETRANGE(Status, MintifiLogRec.Status::Error);
                    IF MintifiLogRec.FINDSET THEN
                        REPEAT

                            IF MintifiLogRec."Entry Type" = MintifiLogRec."Entry Type"::"Order Process" THEN BEGIN
                                // >> Invoice >>
                                IF MintifiLogRec."Document Type" = MintifiLogRec."Document Type"::Invoice THEN;
                                // MintifiAPIMgmt.GenerateSalesInvoiceMintifi(MintifiLogRec."Document No.");
                                // << Invoice <<

                                // >> Credit Memo >>
                                IF MintifiLogRec."Document Type" = MintifiLogRec."Document Type"::"Credit Memo" THEN;
                                //MintifiAPIMgmt.GenerateSalesCreditMemoMintifi(MintifiLogRec."Document No.");
                                // << Credit Memo <<
                            END;

                            IF MintifiLogRec."Entry Type" = MintifiLogRec."Entry Type"::Payment THEN BEGIN
                                // >> Payment >>
                                IF MintifiLogRec."Document Type" = MintifiLogRec."Document Type"::Payment THEN;
                                //MintifiAPIMgmt.GeneratePaymentDocMintifi(MintifiLogRec."Document No.");
                                // << Payment <<
                            END;
                            IF MintifiLogRec."Entry Type" = MintifiLogRec."Entry Type"::Journal THEN BEGIN
                                IF MintifiLogRec."Document Type" <> MintifiLogRec."Document Type"::Payment THEN;
                                //MintifiAPIMgmt.GenerateJournalDocMintifi(MintifiLogRec."Document No.", MintifiLogRec."Document Type");
                            END;

                        UNTIL MintifiLogRec.NEXT = 0;

                    MESSAGE(Text50000);
                end;
            }
            action("Open Record")
            {
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = all;
                trigger OnAction()
                var
                    CustLedgerEntry: Record 21;
                    CustomerLedgerEntriesPg: Page 25;
                begin

                    CustLedgerEntry.RESET;
                    CustLedgerEntry.SETRANGE("Customer No.", Rec."Source No.");
                    CustLedgerEntry.SETRANGE("Document Type", Rec."Document Type");
                    CustLedgerEntry.SETRANGE("Document No.", Rec."Document No.");
                    IF CustLedgerEntry.FINDFIRST THEN BEGIN
                        CustomerLedgerEntriesPg.SETTABLEVIEW(CustLedgerEntry);
                        CustomerLedgerEntriesPg.RUN;
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        IF rec.Status = rec.Status::Error THEN
            TxtColorMessage := 'Unfavorable'
        ELSE
            TxtColorMessage := 'Favorable';
    end;

    trigger OnOpenPage()
    begin

        IF rec.Status = rec.Status::Error THEN
            TxtColorMessage := 'Unfavorable'
        ELSE
            TxtColorMessage := 'Favorable';
    end;

    var
        TxtColorMessage: Text[100];
        Text50000: Label 'API Endpoint Processed Successfully.';
}

