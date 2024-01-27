// MY PC 11 01 2024
pageextension 50092 "PostedPurchaseRecptSubformExt" extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        addafter("Order Date")
        {
            field("Density Factor"; rec."Density Factor")
            {
                ApplicationArea = all;
            }
            field("Expire Date"; rec."Expire Date")
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