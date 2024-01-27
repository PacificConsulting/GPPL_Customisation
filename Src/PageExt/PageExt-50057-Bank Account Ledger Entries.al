pageextension 50057 "BankAccoLedgEntriesExtcust" extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter("Amount (LCY)")
        {
            field("Check Print Name"; Rec."Check Print Name")
            {
                ApplicationArea = all;
            }
            field("Currency Factor"; Rec."Currency Factor")
            {
                ApplicationArea = all;
            }
            field("Amount (FCY)"; Rec."Amount (FCY)")
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