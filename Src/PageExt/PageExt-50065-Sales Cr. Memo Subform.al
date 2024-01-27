
// MY PC 05 01 2024
pageextension 50065 "Sales Cr. Memo SubformExtCstm" extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter(Type)
        {
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}