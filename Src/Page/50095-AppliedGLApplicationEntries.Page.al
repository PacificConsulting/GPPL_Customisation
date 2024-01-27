page 50095 "Applied GL Application Entries"
{
    Caption = 'Applied GL Application Entries';
    DataCaptionExpression = Heading;
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
                field("Posting Date"; rec."Posting Date")
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
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Amount to Apply"; rec."Amount to Apply")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Amount; rec.Amount)
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
                field("Reason Code"; rec."Reason Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(sys1; Links)
            {
                Visible = false;
            }
            systempart(sys2; Notes)
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
                action("Detailed &Ledger Entries")
                {
                    Caption = 'Detailed &Ledger Entries';
                    Image = View;
                    RunObject = Page 50099;
                    RunPageLink = "G/L Application Entry No." = FIELD("Entry No."),
                                  "G/L Account No." = FIELD("G/L Account No.");
                    RunPageView = SORTING("G/L Application Entry No.", "Posting Date");
                    ShortCutKey = 'Ctrl+F7';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        rec.RESET;

        IF rec."Entry No." <> 0 THEN BEGIN
            CreateGLApplEntry := Rec;
            IF CreateGLApplEntry."Document Type" = 0 THEN
                Heading := Text000
            ELSE
                Heading := FORMAT(CreateGLApplEntry."Document Type");
            Heading := Heading + ' ' + CreateGLApplEntry."Document No.";

            FindApplnEntriesDtldtLedgEntry;
            rec.SETCURRENTKEY("Entry No.");
            rec.SETRANGE("Entry No.");

            IF CreateGLApplEntry."Closed by Entry No." <> 0 THEN BEGIN
                rec."Entry No." := CreateGLApplEntry."Closed by Entry No.";
                rec.MARK(TRUE);
            END;

            rec.SETCURRENTKEY("Closed by Entry No.");
            rec.SETRANGE("Closed by Entry No.", CreateGLApplEntry."Entry No.");
            IF rec.FIND('-') THEN
                REPEAT
                    rec.MARK(TRUE);
                UNTIL rec.NEXT = 0;

            rec.SETCURRENTKEY("Entry No.");
            rec.SETRANGE("Closed by Entry No.");
        END;

        rec.MARKEDONLY(TRUE);
    end;

    var
        Text000: Label 'Document';
        CreateGLApplEntry: Record 50057;
        Navigate: Page 344;
        Heading: Text[50];

    local procedure FindApplnEntriesDtldtLedgEntry()
    var
        DtldGLApplEntry1: Record 50058;
        DtldGLApplEntry2: Record 50058;
    begin
        DtldGLApplEntry1.SETCURRENTKEY("G/L Application Entry No.");
        DtldGLApplEntry1.SETRANGE("G/L Application Entry No.", CreateGLApplEntry."Entry No.");
        DtldGLApplEntry1.SETRANGE(Unapplied, FALSE);
        IF DtldGLApplEntry1.FIND('-') THEN
            REPEAT
                IF DtldGLApplEntry1."G/L Application Entry No." =
                   DtldGLApplEntry1."Applied G/L Appl Entry No."
                THEN BEGIN
                    DtldGLApplEntry2.INIT;
                    DtldGLApplEntry2.SETCURRENTKEY("Applied G/L Appl Entry No.", "Entry Type");
                    DtldGLApplEntry2.SETRANGE(
                      "Applied G/L Appl Entry No.", DtldGLApplEntry1."Applied G/L Appl Entry No.");
                    DtldGLApplEntry2.SETRANGE("Entry Type", DtldGLApplEntry2."Entry Type"::Application);
                    DtldGLApplEntry2.SETRANGE(Unapplied, FALSE);
                    IF DtldGLApplEntry2.FIND('-') THEN
                        REPEAT
                            IF DtldGLApplEntry2."G/L Application Entry No." <>
                               DtldGLApplEntry2."Applied G/L Appl Entry No."
                            THEN BEGIN
                                rec.SETCURRENTKEY("Entry No.");
                                rec.SETRANGE("Entry No.", DtldGLApplEntry2."G/L Application Entry No.");
                                IF rec.FIND('-') THEN
                                    rec.MARK(TRUE);
                            END;
                        UNTIL DtldGLApplEntry2.NEXT = 0;
                END ELSE BEGIN
                    rec.SETCURRENTKEY("Entry No.");
                    rec.SETRANGE("Entry No.", DtldGLApplEntry1."Applied G/L Appl Entry No.");
                    IF rec.FIND('-') THEN
                        rec.MARK(TRUE);
                END;
            UNTIL DtldGLApplEntry1.NEXT = 0;
    end;

    //[Scope('Internal')]
    procedure SetTempGLApplEntry(NewTempGLApplEntryNo: Integer)
    begin
        IF NewTempGLApplEntryNo <> 0 THEN BEGIN
            rec.SETRANGE("Entry No.", NewTempGLApplEntryNo);
            rec.FIND('-');
        END;
    end;
}

