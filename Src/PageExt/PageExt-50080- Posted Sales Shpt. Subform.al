// MY PC 10 01 2024
pageextension 50080 "PostedSalesShipmentSubFormExt" extends "Posted Sales Shpt. Subform"
{
    layout
    {
        addafter("Quantity Invoiced")
        {
            field("Inventory Posting Group"; rec."Inventory Posting Group")
            {
                ApplicationArea = all;
            }

            field("Lot No."; rec."Lot No.")
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