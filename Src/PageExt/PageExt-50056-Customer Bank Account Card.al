pageextension 50056 "CustBankAccCardExtCstm" extends "Customer Bank Account Card"
{
    layout
    {
        addafter("Bank Account No.")
        {
            field("SWIFT Code Number"; Rec."SWIFT Code Number")
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