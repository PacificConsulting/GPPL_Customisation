page 50096 "Unapply GL Application Entries"
{
    Caption = 'Unapply GL Application Entries';
    DataCaptionExpression = Caption;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = 50058;
    SourceTableTemporary = true;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(DocuNo; DocNo)
                {
                    ApplicationArea = all;
                    Caption = 'Document No.';
                }
                field(PostDate; PostingDate)
                {
                    ApplicationArea = all;
                    Caption = 'Posting Date';
                }
            }
            repeater(control01)
            {
                Editable = false;
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("G/L Account No."; rec."G/L Account No.")
                {
                    ApplicationArea = all;
                }
                field("Initial Document Type"; rec."Initial Document Type")
                {
                    ApplicationArea = all;
                }
                field("Initial Entry Global Dim. 1"; rec."Initial Entry Global Dim. 1")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Initial Entry Global Dim. 2"; rec."Initial Entry Global Dim. 2")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Amount (LCY)"; rec."Amount (LCY)")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Source Code"; rec."Source Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("G/L Application Entry No."; rec."G/L Application Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Entry No."; rec."Entry No.")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Unapply)
            {
                ApplicationArea = all;
                Caption = '&Unapply';
                Image = UnApply;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    DtldGLApplEntry: Record 50058;
                    GLApplEnt: Record 50057;
                begin
                    IF rec.ISEMPTY THEN
                        ERROR(Text010);
                    IF NOT CONFIRM(Text011, FALSE) THEN
                        EXIT;

                    CLEAR(DtldGLApplEntry);
                    CLEAR(GLApplEnt);
                    IF Rec."Transaction No." <> 0 THEN BEGIN
                        DtldGLApplEntry.SETCURRENTKEY("Transaction No.", "G/L Account No.", "Entry Type");
                        DtldGLApplEntry.SETRANGE("Transaction No.", Rec."Transaction No.");
                    END;

                    DtldGLApplEntry.SETRANGE("G/L Account No.", Rec."G/L Account No.");
                    DtldGLApplEntry.SETFILTER(DtldGLApplEntry."Entry Type", '<>%1', DtldGLApplEntry."Entry Type"::"Initial Entry");
                    DtldGLApplEntry.SETRANGE(Unapplied, FALSE);
                    IF DtldGLApplEntry.FINDSET THEN
                        REPEAT
                            InsertDetailGLApplicationEntry(DtldGLApplEntry);
                            IF GLApplEnt.GET(DtldGLApplEntry."G/L Application Entry No.") THEN
                                GLApplEnt.CALCFIELDS("Remaining Amount", Amount);
                            GLApplEnt."Applied Amount" := GLApplEnt.Amount - GLApplEnt."Remaining Amount";
                            IF GLApplEnt."Remaining Amount" <> 0 THEN
                                GLApplEnt.Open := TRUE
                            ELSE
                                GLApplEnt.Open := FALSE;
                            GLApplEnt.MODIFY;
                        UNTIL DtldGLApplEntry.NEXT = 0;

                    PostingDate := 0D;
                    DocNo := '';
                    rec.DELETEALL;
                    MESSAGE(Text009);

                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        InsertEntries;
    end;

    var
        DtldGLApplEntry2: Record 50058;
        GLAcc: Record 15;
        DocNo: Code[20];
        PostingDate: Date;
        GLApplEntryNo: Integer;
        Text009: Label 'The entries were successfully unapplied.';
        Text010: Label 'There is nothing to unapply.';
        Text011: Label 'To unapply these entries, correcting entries will be posted.\Do you want to unapply the entries?';

    //  [Scope('Internal')]
    procedure SetDtldGLApplEntry(EntryNo: Integer)
    begin
        DtldGLApplEntry2.GET(EntryNo);
        GLApplEntryNo := DtldGLApplEntry2."G/L Application Entry No.";
        PostingDate := DtldGLApplEntry2."Posting Date";
        DocNo := DtldGLApplEntry2."Document No.";
        GLAcc.GET(DtldGLApplEntry2."G/L Account No.");
    end;

    local procedure InsertEntries()
    var
        DtldGLApplEntry: Record 50058;
    begin
        //IF DtldGLApplEntry2."Transaction No." = 0 THEN BEGIN
        //DtldGLApplEntry.SETCURRENTKEY("Application No.","G/L Account No.","Entry Type");
        //DtldGLApplEntry.SETRANGE("Application No.",DtldGLApplEntry2."Application No.");
        //END ELSE BEGIN
        //DtldGLApplEntry.SETCURRENTKEY("Transaction No.","G/L Account No.","Entry Type");
        //DtldGLApplEntry.SETRANGE("Transaction No.",DtldGLApplEntry2."Transaction No.");
        //END;
        IF DtldGLApplEntry2."Transaction No." <> 0 THEN BEGIN
            DtldGLApplEntry.SETCURRENTKEY("Transaction No.", "G/L Account No.", "Entry Type");
            DtldGLApplEntry.SETRANGE("Transaction No.", DtldGLApplEntry2."Transaction No.");
        END;

        DtldGLApplEntry.SETRANGE("G/L Account No.", DtldGLApplEntry2."G/L Account No.");
        rec.DELETEALL;
        IF DtldGLApplEntry.FINDSET THEN
            REPEAT
                IF (DtldGLApplEntry."Entry Type" <> DtldGLApplEntry."Entry Type"::"Initial Entry") AND
                   NOT DtldGLApplEntry.Unapplied
                THEN BEGIN
                    Rec := DtldGLApplEntry;
                    rec.INSERT;
                END;
            UNTIL DtldGLApplEntry.NEXT = 0;
    end;

    local procedure GetDocumentNo(): Code[20]
    var
        GLApplEntry: Record 50057;
    begin
        IF GLApplEntry.GET(rec."G/L Application Entry No.") THEN;
        EXIT(GLApplEntry."Document No.");
    end;

    local procedure Caption(): Text[100]
    var
        GLApplEntry: Record 50057;
    begin
        EXIT(STRSUBSTNO(
            '%1 %2 %3 %4',
            GLAcc."No.",
            GLAcc.Name,
            GLApplEntry.FIELDCAPTION("Entry No."),
            GLApplEntryNo));
    end;

    local procedure InsertDetailGLApplicationEntry(NewDetailedGLEntryAppl: Record 50058)
    var
        DetailGLApplEntry: Record 50058;
    begin
        DetailGLApplEntry.INIT;
        DetailGLApplEntry."G/L Application Entry No." := NewDetailedGLEntryAppl."G/L Application Entry No.";
        DetailGLApplEntry."Entry Type" := DetailGLApplEntry."Entry Type"::Application;
        DetailGLApplEntry."Posting Date" := NewDetailedGLEntryAppl."Posting Date";
        DetailGLApplEntry."Document Type" := NewDetailedGLEntryAppl."Document Type";
        DetailGLApplEntry."Document No." := NewDetailedGLEntryAppl."Document No.";
        //IF (ABS(AppliedGLEntAppEntry."Remaining Amount") >= ABS(AppliedGLEntAppEntry."Amount to Apply")) AND
        //    (ABS(AppliedGLEntAppEntry."Remaining Amount") <= ABS(GLEntryAppl."Remaining Amount")) THEN BEGIN
        //  DetailGLApplEntry.Amount := AppliedGLEntAppEntry."Amount to Apply";
        //DetailGLApplEntry."Amount (LCY)" := AppliedGLEntAppEntry."Amount to Apply";
        IF NewDetailedGLEntryAppl."Debit Amount" <> 0 THEN BEGIN
            DetailGLApplEntry.Amount := -NewDetailedGLEntryAppl.Amount;
            DetailGLApplEntry."Amount (LCY)" := -NewDetailedGLEntryAppl."Amount (LCY)";
            DetailGLApplEntry."Credit Amount" := ABS(NewDetailedGLEntryAppl.Amount);
            DetailGLApplEntry."Credit Amount (LCY)" := ABS(NewDetailedGLEntryAppl."Amount (LCY)");
        END;
        IF NewDetailedGLEntryAppl."Credit Amount" <> 0 THEN BEGIN
            DetailGLApplEntry.Amount := -NewDetailedGLEntryAppl.Amount;
            DetailGLApplEntry."Amount (LCY)" := -NewDetailedGLEntryAppl."Amount (LCY)";
            DetailGLApplEntry."Debit Amount" := ABS(NewDetailedGLEntryAppl.Amount);
            DetailGLApplEntry."Debit Amount (LCY)" := ABS(NewDetailedGLEntryAppl."Amount (LCY)");
        END;
        //END;
        /*
        IF (ABS(AppliedGLEntAppEntry."Remaining Amount") >= ABS(AppliedGLEntAppEntry."Amount to Apply")) AND
              (ABS(AppliedGLEntAppEntry."Remaining Amount") > ABS(GLEntryAppl."Remaining Amount")) THEN BEGIN
            DetailGLApplEntry.Amount := GLEntryAppl."Remaining Amount";
            DetailGLApplEntry."Amount (LCY)" := GLEntryAppl."Remaining Amount";
            IF GLEntryAppl."Debit Amount" <> 0 THEN BEGIN
            DetailGLApplEntry."Debit Amount" := GLEntryAppl."Remaining Amount";
            DetailGLApplEntry."Debit Amount (LCY)" := GLEntryAppl."Remaining Amount";
            END;
            IF GLEntryAppl."Credit Amount" <> 0 THEN BEGIN
              DetailGLApplEntry."Credit Amount" := GLEntryAppl."Remaining Amount";
              DetailGLApplEntry."Credit Amount (LCY)" := GLEntryAppl."Remaining Amount";
            END;
        END;
        */
        DetailGLApplEntry."G/L Account No." := NewDetailedGLEntryAppl."G/L Account No.";
        DetailGLApplEntry."User ID" := NewDetailedGLEntryAppl."User ID";
        DetailGLApplEntry."Source Code" := NewDetailedGLEntryAppl."Source Code";
        DetailGLApplEntry."Transaction No." := NewDetailedGLEntryAppl."Transaction No.";
        DetailGLApplEntry."Initial Entry Global Dim. 1" := NewDetailedGLEntryAppl."Initial Entry Global Dim. 1";
        DetailGLApplEntry."Initial Entry Global Dim. 2" := NewDetailedGLEntryAppl."Initial Entry Global Dim. 2";
        DetailGLApplEntry."Gen. Bus. Posting Group" := NewDetailedGLEntryAppl."Gen. Bus. Posting Group";
        DetailGLApplEntry."Gen. Prod. Posting Group" := NewDetailedGLEntryAppl."Gen. Prod. Posting Group";
        DetailGLApplEntry."VAT Bus. Posting Group" := NewDetailedGLEntryAppl."VAT Bus. Posting Group";
        DetailGLApplEntry."VAT Prod. Posting Group" := NewDetailedGLEntryAppl."VAT Prod. Posting Group";
        DetailGLApplEntry."Initial Document Type" := NewDetailedGLEntryAppl."Document Type";
        DetailGLApplEntry."Applied G/L Appl Entry No." := NewDetailedGLEntryAppl."Applied G/L Appl Entry No.";
        DetailGLApplEntry.Unapplied := TRUE;
        DetailGLApplEntry."Unapplied by Entry No." := NewDetailedGLEntryAppl."Entry No.";
        DetailGLApplEntry.INSERT;

        NewDetailedGLEntryAppl.Unapplied := TRUE;
        NewDetailedGLEntryAppl."Unapplied by Entry No." := DetailGLApplEntry."Entry No.";
        NewDetailedGLEntryAppl.MODIFY;

    end;

    // [Scope('Internal')]
    procedure GetGLApplEntryNo(NewGLApplEntryNo: Integer)
    begin
        GLApplEntryNo := NewGLApplEntryNo;
    end;
}

