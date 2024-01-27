pageextension 50045 DimentionValuesExtcstm extends "Dimension Values"
{
    layout
    {
        addafter("Consolidation Code")
        {
            field("Short Close Days"; Rec."Short Close Days")
            {
                ApplicationArea = all;
            }
            field("Mintifi Email"; Rec."Mintifi Email")
            {
                ApplicationArea = all;
            }
            field("Email PDF of SO"; Rec."Email PDF of SO")
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