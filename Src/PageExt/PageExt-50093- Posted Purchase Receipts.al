// MY PC 11 01 2024
pageextension 50093 "PostedPurchaseReceiptsExt" extends "Posted Purchase Receipts"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("Work Order"; rec."Work Order")
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