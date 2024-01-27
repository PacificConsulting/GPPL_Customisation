// MY PC 08 01 2024
pageextension 50070 "PurchaseCrMemoExt" extends "Purchase Credit Memo"
{
    layout
    {
        addafter("Buy-from Contact")
        {
            field("Full Name"; rec."Full Name")
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