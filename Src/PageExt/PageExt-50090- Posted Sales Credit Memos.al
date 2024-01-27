// MY PC 11 01 2024
pageextension 50090 "PostedSalesCreditMemosExtCstm" extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Last Year Sales Return"; rec."Last Year Sales Return")
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