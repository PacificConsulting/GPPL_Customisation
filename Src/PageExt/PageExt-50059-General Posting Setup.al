pageextension 50059 "General Posting SetupExtcstm" extends "General Posting Setup"
{
    layout
    {
        addafter("Gen. Prod. Posting Group")
        {
            field("Salary G/L Account"; Rec."Salary G/L Account")
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