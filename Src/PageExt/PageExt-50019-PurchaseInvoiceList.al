pageextension 50019 PurchInvListExtCstm extends "Purchase Invoices"
{
    layout
    {
        // Add changes to page layout here
        /// MY PC 09 01 2024
        addafter(Status)
        {
            field("Invoice Received By Finance"; rec."Invoice Received By Finance")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        modify("Release")
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

        modify(PostBatch)
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