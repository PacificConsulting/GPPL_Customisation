pageextension 50058 "Bank Account CardExtcstm" extends "Bank Account Card"
{
    layout
    {
        addafter(Contact)
        {
            field("Full Name"; Rec."Full Name")
            {
                ApplicationArea = all;
            }
            field("Cheque No. Series"; Rec."Cheque No. Series")
            {
                ApplicationArea = all;
            }
            field("Swift Code Number"; Rec."Swift Code Number")
            {
                ApplicationArea = all;
            }
            field("Corresponding Bank"; Rec."Corresponding Bank")
            {
                ApplicationArea = all;
            }
            field("Account Type"; Rec."Account Type")
            {
                ApplicationArea = all;
            }
            field("Corresponding Bank Account No."; Rec."Corresponding Bank Account No.")
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