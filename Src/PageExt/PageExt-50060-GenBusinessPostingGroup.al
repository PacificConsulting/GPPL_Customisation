pageextension 50060 "GenBusPostGroupCardExtcstm" extends "Gen. Business Posting Groups"
{
    layout
    {
        addafter("Def. VAT Bus. Posting Group")
        {
            field("TDS Mandatory"; Rec."TDS Mandatory")
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