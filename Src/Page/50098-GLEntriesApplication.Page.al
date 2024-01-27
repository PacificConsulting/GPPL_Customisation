page 50098 "GL Entries Application"
{
    Caption = 'GL Entries Application';
    DataCaptionExpression = GetCaption;
    Editable = false;
    PageType = List;
    SourceTable = 50057;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("System-Created Entry"; rec."System-Created Entry")
                {
                }
                field("Posting Date"; rec."Posting Date")
                {
                }
                field("Document Type"; rec."Document Type")
                {
                }
                field("Document No."; rec."Document No.")
                {
                }
                field("External Document No."; rec."External Document No.")
                {
                }
                field("Exp/Purchase Invoice Doc. No."; rec."Exp/Purchase Invoice Doc. No.")
                {
                }
                field("G/L Account No."; rec."G/L Account No.")
                {
                }
                field("Source Type"; rec."Source Type")
                {
                }
                field("Transaction No."; rec."Transaction No.")
                {
                }
                field("Source No."; rec."Source No.")
                {
                }
                field("G/L Account Name"; rec."G/L Account Name")
                {
                    DrillDown = false;
                    Visible = true;
                }
                field("Location Code"; rec."Location Code")
                {
                }
                field(Description; rec.Description)
                {
                }
                field("Dimension Set ID"; rec."Dimension Set ID")
                {
                }
                field("Debit Amount"; rec."Debit Amount")
                {
                }
                field("Credit Amount"; rec."Credit Amount")
                {
                }
                field(Amount; rec.Amount)
                {
                    DecimalPlaces = 5 : 5;
                }
                field("Bal. Account Type"; rec."Bal. Account Type")
                {
                }
                field("Bal. Account No."; rec."Bal. Account No.")
                {
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field("User ID"; rec."User ID")
                {
                    Visible = false;
                }
                field("Source Code"; rec."Source Code")
                {
                    Visible = false;
                }
                field("Reason Code"; rec."Reason Code")
                {
                    Visible = false;
                }
                field(Reversed; rec.Reversed)
                {
                    Visible = false;
                }
                field("Reversed by Entry No."; rec."Reversed by Entry No.")
                {
                    Visible = false;
                }
                field("Reversed Entry No."; rec."Reversed Entry No.")
                {
                    Visible = false;
                }
                field("FA Entry Type"; rec."FA Entry Type")
                {
                    Visible = false;
                }
                field("FA Entry No."; rec."FA Entry No.")
                {
                    Visible = false;
                }
                field("Entry No."; rec."Entry No.")
                {
                }
                field("Job No."; rec."Job No.")
                {
                    Visible = false;
                }
                field("IC Partner Code"; rec."IC Partner Code")
                {
                    Visible = false;
                }
                field("Gen. Posting Type"; rec."Gen. Posting Type")
                {
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                }
                field(Quantity; rec.Quantity)
                {
                    Visible = false;
                }
                field("Additional-Currency Amount"; rec."Additional-Currency Amount")
                {
                    Visible = false;
                }
                field("VAT Amount"; rec."VAT Amount")
                {
                    Visible = false;
                }
                field("Remaining Amount"; rec."Remaining Amount")
                {
                }
                field("Applied Amount"; rec."Applied Amount")
                {
                }
                field(Open; rec.Open)
                {
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; 193)
            {
                ShowFilter = false;
            }
            systempart(sys1; Links)
            {
                Visible = false;
            }
            systempart(s; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                Image = Entry;
                action("Applied E&ntries")
                {
                    Caption = 'Applied E&ntries';
                    Image = Approve;
                    RunObject = Page 50095;
                    RunPageOnRec = true;
                    Scope = Repeater;
                }
                action("Detailed &Ledger Entries")
                {
                    Caption = 'Detailed &Ledger Entries';
                    Image = View;
                    RunObject = Page 50099;
                    RunPageLink = "G/L Application Entry No." = FIELD("Entry No."),
                                  "G/L Account No." = FIELD("G/L Account No.");
                    RunPageView = SORTING("G/L Application Entry No.", "Posting Date");
                    Scope = Repeater;
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Apply Entries")
                {
                    Caption = 'Apply Entries';
                    Image = ApplyEntries;
                    Scope = Repeater;
                    ShortCutKey = 'Shift+F11';

                    trigger OnAction()
                    var
                        CustLedgEntry: Record 21;
                        CustEntryApplyPostEntries: Codeunit 226;
                    begin
                        ApplyingGLEntAppEntry.COPY(Rec);

                        IF NOT ApplyingGLEntAppEntry.Open THEN
                            ERROR(CannotApplyClosedEntriesErr);

                        GLEntryApplID := USERID;
                        IF GLEntryApplID = '' THEN
                            GLEntryApplID := '***';

                        ApplyingGLEntAppEntry."Applying Entry" := TRUE;
                        ApplyingGLEntAppEntry."Applies-to ID" := GLEntryApplID;
                        ApplyingGLEntAppEntry."Amount to Apply" := ApplyingGLEntAppEntry."Remaining Amount";
                        COMMIT;

                        //GLEntryAppl.SETCURRENTKEY("G/L Account No.",Open);
                        //GLEntryAppl.SETRANGE("G/L Account No.",ApplyingGLEntAppEntry."G/L Account No.");
                        //GLEntryAppl.SETRANGE(Open,TRUE);
                        GLEntryAppl.SETRANGE("Entry No.", ApplyingGLEntAppEntry."Entry No.");
                        IF GLEntryAppl.FINDSET THEN BEGIN
                            ApplyGLAppEntry.SetGLEntryApplication(ApplyingGLEntAppEntry);
                            ApplyGLAppEntry.SETRECORD(GLEntryAppl);
                            ApplyGLAppEntry.SETTABLEVIEW(GLEntryAppl);
                            ApplyGLAppEntry.RUNMODAL;
                            CLEAR(ApplyGLAppEntry);
                            ApplyingGLEntAppEntry."Applying Entry" := FALSE;
                            ApplyingGLEntAppEntry."Applies-to ID" := '';
                            ApplyingGLEntAppEntry."Amount to Apply" := 0;
                        END;

                        Rec := ApplyingGLEntAppEntry;
                        CurrPage.UPDATE;
                    end;
                }
                action(UnapplyEntries)
                {
                    Caption = 'Unapply Entries';
                    Ellipsis = true;
                    Image = UnApply;
                    Scope = Repeater;

                    trigger OnAction()
                    var
                        CustEntryApplyPostedEntries: Codeunit 226;
                    begin
                        UnApplyGLApplEntry(rec."Entry No.");
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        IncomingDocument: Record 130;
    begin
        HasIncomingDocument := IncomingDocument.PostedDocExists(rec."Document No.", rec."Posting Date");
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    var
        GLAcc: Record 15;
        HasIncomingDocument: Boolean;
        ApplyingGLEntAppEntry: Record 50057 temporary;
        CannotApplyClosedEntriesErr: Label 'One or more of the entries that you selected is closed. You cannot apply closed entries.';
        GLEntryApplID: Code[50];
        ApplyGLAppEntry: Page 50097;
        GLEntryAppl: Record 50057;
        NoApplicationEntryErr: Label 'G/L Application Entry No. %1 does not have an application entry.';

    local procedure GetCaption(): Text[250]
    begin
        IF GLAcc."No." <> rec."G/L Account No." THEN
            IF NOT GLAcc.GET(rec."G/L Account No.") THEN
                IF rec.GETFILTER(rec."G/L Account No.") <> '' THEN
                    IF GLAcc.GET(rec.GETRANGEMIN("G/L Account No.")) THEN;
        EXIT(STRSUBSTNO('%1 %2', GLAcc."No.", GLAcc.Name))
    end;

    // [Scope('Internal')]
    procedure UnApplyGLApplEntry(GLApplEntryNo: Integer)
    var
        DtldGLApplEntry: Record 50058;
        ApplicationEntryNo: Integer;
    begin
        ApplicationEntryNo := FindLastApplEntry(GLApplEntryNo);
        IF ApplicationEntryNo = 0 THEN
            ERROR(NoApplicationEntryErr, GLApplEntryNo);
        DtldGLApplEntry.GET(ApplicationEntryNo);
        UnApplyGL(DtldGLApplEntry);
    end;

    local procedure FindLastApplEntry(GLApplEntryNo: Integer): Integer
    var
        DtldGLApplEntry: Record 50058;
        ApplicationEntryNo: Integer;
    begin
        WITH DtldGLApplEntry DO BEGIN
            SETCURRENTKEY("G/L Application Entry No.", "Entry Type");
            SETRANGE("G/L Application Entry No.", GLApplEntryNo);
            SETRANGE("Entry Type", "Entry Type"::Application);
            SETRANGE(Unapplied, FALSE);
            ApplicationEntryNo := 0;
            IF FIND('-') THEN
                REPEAT
                    IF "Entry No." > ApplicationEntryNo THEN
                        ApplicationEntryNo := "Entry No.";
                UNTIL NEXT = 0;
        END;
        EXIT(ApplicationEntryNo);
    end;

    local procedure UnApplyGL(DtldGLApplEntry: Record 50058)
    var
        UnapplyGLApplEntries: Page 50096;
    begin
        WITH DtldGLApplEntry DO BEGIN
            TESTFIELD("Entry Type", "Entry Type"::Application);
            TESTFIELD(Unapplied, FALSE);
            UnapplyGLApplEntries.SetDtldGLApplEntry("Entry No.");
            UnapplyGLApplEntries.LOOKUPMODE(TRUE);
            UnapplyGLApplEntries.RUNMODAL;
        END;
    end;
}

