pageextension 50033 ItemChargeExtCstm extends "Item Charges"
{
    layout
    {
        addafter("Search Description")
        {
            field("Sub Expense"; Rec."Sub Expense")
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