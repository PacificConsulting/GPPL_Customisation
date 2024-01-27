pageextension 50039 "ResponsiCenteCardExtCsmrt" extends "Responsibility Center Card"
{
    layout
    {
        addafter("Location Code")
        {
            field("City for Sales"; Rec."City for Sales")
            {
                ApplicationArea = all;
            }
            field(State; Rec.State)
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