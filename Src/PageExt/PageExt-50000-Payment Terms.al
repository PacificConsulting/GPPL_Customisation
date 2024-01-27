pageextension 50000 PaymentTermsExt extends "Payment Terms"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field(Bunker; Rec.Bunker)
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