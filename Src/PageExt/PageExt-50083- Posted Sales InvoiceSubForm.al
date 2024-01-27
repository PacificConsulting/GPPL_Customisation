// MY PC 11 01 2024
pageextension 50083 "PostedSalesInvoiceSubFormExt" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Inventory Posting Group"; rec."Inventory Posting Group")
            {
                ApplicationArea = all;
            }
            field("Lot No."; rec."Lot No.")
            {
                ApplicationArea = all;

            }
            field("Appiles to Inv.No."; rec."Appiles to Inv.No.")
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