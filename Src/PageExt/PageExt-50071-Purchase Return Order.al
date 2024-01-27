// MY PC 08 01 2024
pageextension 50071 "PurchaseReturnOrderExt" extends "Purchase Return Order"
{
    layout
    {
        addafter("No. of Archived Versions")
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