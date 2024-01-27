pageextension 50003 "SalespePurchasersListCstm" extends "Salespersons/Purchasers"
{
    //Editable = false;
    //ModifyAllowed = false;
    //SourceTableView = WHERE(Blocked = CONST(false));

    layout
    {
        // Add changes to page layout here
        addafter("Phone No.")
        {
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = all;
            }
            field(L1; Rec.L1)
            {
                ApplicationArea = all;
            }
            field("Region Head Code"; Rec."Region Head Code")
            {
                ApplicationArea = all;
            }
            field(HOD; Rec.HOD)
            {
                ApplicationArea = all;
            }
            field("Zone Code"; Rec."Zone Code")
            {
                ApplicationArea = all;
            }
            field("Region Code"; Rec."Region Code")
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