pageextension 50018 PurchInvSuformExtCstm extends "Purch. Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        /// MY PC 12 01 2024
        addafter("Appl.-to Item Entry")
        {
            field("Import Invoice No."; rec."Import Invoice No.")
            {
                ApplicationArea = all;
                Editable = DocExpEdit;
                trigger OnValidate()
                begin
                    //
                    IF rec."Import Invoice No." <> '' THEN BEGIN
                        PL06.RESET;
                        PL06.SETRANGE("Document Type", rec."Document Type");
                        PL06.SETRANGE("Document No.", rec."Document No.");
                        PL06.SETRANGE(Type, PL06.Type::"G/L Account");
                        PL06.SETRANGE("Sub Expense Code", rec."Sub Expense Code");
                        PL06.SETFILTER("Line No.", '%1', rec."Line No.");
                        IF PL06.FINDSET THEN
                            REPEAT
                                IF PL06."Import Invoice No." = rec."Import Invoice No." THEN
                                    ERROR('Import Invoice No. has already exists for %1 Line No.', PL06."Line No.");
                            UNTIL PL06.NEXT = 0;

                        PIL06.RESET;
                        PIL06.SETCURRENTKEY("Import Invoice No.");
                        PIL06.SETRANGE("Import Invoice No.", rec."Import Invoice No.");
                        PIL06.SETRANGE("Sub Expense Code", rec."Sub Expense Code");
                        IF PIL06.FINDFIRST THEN BEGIN
                            IF PIL06."Import Invoice No." = rec."Import Invoice No." THEN
                                ERROR('Sub Expense %1 already posted against Document No %2', rec."Sub Expense Name", PIL06."Document No.");
                        END;
                    END;
                    //
                end;
            }
        }
    }
    actions
    {
        addafter("Item &Tracking Lines")
        {
            action("Transport Entries")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    GL02: Record "G/L Account";
                begin
                    Rec.TESTFIELD(Type, Rec.Type::"G/L Account");
                    Rec.TESTFIELD("No.");
                    GL02.RESET;
                    GL02.SETRANGE("No.", Rec."No.");
                    GL02.SETRANGE("Transport Entries", TRUE);
                    IF NOT GL02.FINDFIRST THEN
                        ERROR('%1 G/L Account No. cannot be utilized for Transport Entries', Rec."No.");
                    //

                    rec.ApplicationofEntries;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        FieldEditable13: Boolean;
        DocExpEdit: Boolean;
        GLAcc06: Record "G/L Account";
        ItmCh: Record "Item Charge";
    begin
        //>>13July2017 GSTFields Editable
        IF REC.Type = Rec.Type::" " THEN
            FieldEditable13 := FALSE;

        IF Rec.Type = Rec.Type::Item THEN
            FieldEditable13 := FALSE;

        IF Rec.Type <> Rec.Type::Item THEN
            FieldEditable13 := TRUE;
        //<<13July2017 GSTFields Editable

        //>>RB-N 06Jul2018
        DocExpEdit := FALSE;
        IF (Rec.Type = Rec.Type::"G/L Account") AND (Rec."No." <> '') THEN BEGIN
            GLAcc06.RESET;
            GLAcc06.SETRANGE("No.", Rec."No.");
            GLAcc06.SETRANGE("Sub Expense", TRUE);
            IF GLAcc06.FINDFIRST THEN
                DocExpEdit := TRUE
            ELSE
                DocExpEdit := FALSE;
        END;

        //>>30Aug2018
        IF (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> '') THEN BEGIN
            ItmCh.RESET;
            ItmCh.SETRANGE("No.", Rec."No.");
            ItmCh.SETRANGE("Sub Expense", TRUE);
            IF ItmCh.FINDFIRST THEN
                DocExpEdit := TRUE
            ELSE
                DocExpEdit := FALSE;
        END;
        //<<30Aug2018

        IF Rec."Line No." = 0 THEN
            DocExpEdit := FALSE;
        //<<RB-N 06Jul2018

    end;

    var
        myInt: Integer;
        DocExpEdit: Boolean;
        PL06: Record "Purchase Line";
        PIL06: Record "Purch. Inv. Line";
}