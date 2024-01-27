pageextension 50052 "No. Series ListExtcstm" extends "No. Series"
{
    layout
    {
        addafter("Date Order")
        {
            field("Work Order"; Rec."Work Order")
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