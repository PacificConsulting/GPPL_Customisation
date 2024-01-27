// MY PC 11 01 2024
pageextension 50091 "PostedPurchaseReceiptExt" extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("Closed GRN"; rec."Closed GRN")
            {
                ApplicationArea = all;
            }
            field("Blanket Order No."; rec."Blanket Order No.")
            {
                ApplicationArea = all;
            }
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