pageextension 50042 FinProOrdExtCstm extends "Finished Production Order"
{
    layout
    {
        addafter(Description)
        {
            field("Man Hours"; Rec."Man Hours")
            {
                ApplicationArea = all;
            }
            field("Machine Hours"; Rec."Machine Hours")

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