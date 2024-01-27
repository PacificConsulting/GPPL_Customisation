page 50082 "Posted GST Ledger Entry Detail"
{
    // Date        Version      Remarks
    // .....................................................................................
    // 16Sep2017   RB-N         New Page for Detailed GST Ledger Entry

    Caption = 'Posted GST Ledger Entry Detail';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "Detailed GST Ledger Entry";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                FreezeColumn = "Document No.";
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Document Line No."; rec."Document Line No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Item Description"; ItmDesc)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("HSN/SAC Code"; rec."HSN/SAC Code")
                {
                    ApplicationArea = all;
                }
                field("GST Component Code"; rec."GST Component Code")
                {
                    ApplicationArea = all;
                }
                field("GST Group Code"; rec."GST Group Code")
                {
                    ApplicationArea = all;
                }
                field("GST Group Type"; rec."GST Group Type")
                {
                    ApplicationArea = all;
                }
                field("GST Base Amount"; rec."GST Base Amount")
                {
                    ApplicationArea = all;
                }
                field("GST %"; rec."GST %")
                {
                    ApplicationArea = all;
                }
                field("GST Amount"; rec."GST Amount")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin



        //>>RB-N  16Sep2017 ItemDescription
        CLEAR(ItmDesc);
        IF rec.Type = rec.Type::Item THEN BEGIN
            Itm16.RESET;
            IF Itm16.GET(rec."No.") THEN
                ItmDesc := Itm16.Description;

        END;

        IF rec.Type = rec.Type::"G/L Account" THEN BEGIN
            GL16.RESET;
            IF GL16.GET(rec."No.") THEN
                ItmDesc := GL16.Name;

        END;
        //>>RB-N  16Sep2017 ItemDescription
    end;

    var
        Itm16: Record 27;
        GL16: Record 15;
        ItmDesc: Text[50];
}

