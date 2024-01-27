pageextension 50054 "VendBankAccount CardExtCstm" extends "Vendor Bank Account Card"
{
    layout
    {
        addafter(City)
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