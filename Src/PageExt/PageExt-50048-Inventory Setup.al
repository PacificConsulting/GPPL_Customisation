pageextension 50048 "Inventory SetupExtCstm" extends "Inventory Setup"
{
    layout
    {
        addafter("Transfer Order Nos.")
        {
            field("Transfer Indent No Series"; Rec."Transfer Indent No Series")
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