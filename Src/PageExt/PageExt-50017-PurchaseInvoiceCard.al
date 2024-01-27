pageextension 50017 PurchInvCardExtCstm extends "Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("Buy-from Contact")  /// MY PC 08 01 2024
        {
            field("Full Name"; rec."Full Name")
            {
                ApplicationArea = all;
            }
            field("Blanket Order No."; rec."Blanket Order No.")
            {
                ApplicationArea = all;
            }
            field("LR Details Required"; rec."LR Details Required")  // MY PC 09 01 2024
            {
                ApplicationArea = all;
            }
            field("LR Invoice No."; rec."LR Invoice No.")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        modify("Re&lease")
        {
            trigger OnBeforeAction()
            var
                PL06: Record "Purchase Line";
                GL06: Record "G/L Account";
            begin
                PL06.RESET;
                PL06.SETRANGE("Document Type", Rec."Document Type");
                PL06.SETRANGE("Document No.", Rec."No.");
                PL06.SETRANGE(Type, PL06.Type::"G/L Account");
                IF PL06.FINDSET THEN
                    REPEAT
                        GL06.RESET;
                        GL06.SETRANGE("No.", PL06."No.");
                        GL06.SETRANGE("Sub Expense", TRUE);
                        IF GL06.FINDFIRST THEN BEGIN
                            PL06.TESTFIELD("Sub Expense Code");
                            IF PL06."No." <> '75001150' THEN
                                PL06.TESTFIELD("Import Invoice No.");
                        END;
                    UNTIL PL06.NEXT = 0;
            end;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                PL06: Record "Purchase Line";
                GL06: Record "G/L Account";
            begin
                PL06.RESET;
                PL06.SETRANGE("Document Type", Rec."Document Type");
                PL06.SETRANGE("Document No.", Rec."No.");
                PL06.SETRANGE(Type, PL06.Type::"G/L Account");
                IF PL06.FINDSET THEN
                    REPEAT
                        GL06.RESET;
                        GL06.SETRANGE("No.", PL06."No.");
                        GL06.SETRANGE("Sub Expense", TRUE);
                        IF GL06.FINDFIRST THEN BEGIN
                            PL06.TESTFIELD("Sub Expense Code");
                            IF PL06."No." <> '75001150' THEN
                                PL06.TESTFIELD("Import Invoice No.");
                        END;
                    UNTIL PL06.NEXT = 0;
            end;
        }

        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            var
                PL06: Record "Purchase Line";
                GL06: Record "G/L Account";
            begin
                PL06.RESET;
                PL06.SETRANGE("Document Type", Rec."Document Type");
                PL06.SETRANGE("Document No.", Rec."No.");
                PL06.SETRANGE(Type, PL06.Type::"G/L Account");
                IF PL06.FINDSET THEN
                    REPEAT
                        GL06.RESET;
                        GL06.SETRANGE("No.", PL06."No.");
                        GL06.SETRANGE("Sub Expense", TRUE);
                        IF GL06.FINDFIRST THEN BEGIN
                            PL06.TESTFIELD("Sub Expense Code");
                            IF PL06."No." <> '75001150' THEN
                                PL06.TESTFIELD("Import Invoice No.");
                        END;
                    UNTIL PL06.NEXT = 0;
            end;
        }

    }

    var
        myInt: Integer;
}