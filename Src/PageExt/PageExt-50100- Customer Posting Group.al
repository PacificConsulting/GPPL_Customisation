// MY PC 18 01 2024
pageextension 50100 CustomerPostingGroupEXT extends "Customer Posting Groups"
{
    layout
    {
        addafter("Add. Fee per Line Account")
        {
            field("PIT Difference Acc."; rec."PIT Difference Acc.")
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
