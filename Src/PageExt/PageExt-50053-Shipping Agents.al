pageextension 50053 "Shipping AgentsExtcstm" extends "Shipping Agents"
{
    layout
    {
        addafter("Account No.")
        {
            // field("GST Registration No."; Rec."GST Registration No.")
            // {
            //     ApplicationArea = all;
            // }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}