pageextension 50062 "Reason CodesExtcstm" extends "Reason Codes"
{
    layout
    {
        addafter(Description)
        {
            field(EWB; Rec.EWB)
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