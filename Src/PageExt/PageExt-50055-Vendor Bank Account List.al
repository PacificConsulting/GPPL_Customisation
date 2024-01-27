pageextension 50055 "VendBankAccountListExtCstm" extends "Vendor Bank Account List"
{
    layout
    {
        addafter("Bank Account No.")
        {
            field("SWIFT Code Number"; Rec."SWIFT Code Number")
            {
                ApplicationArea = all;
            }
            field(Blocked; Rec.Blocked)
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