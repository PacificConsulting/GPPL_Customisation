// MY PC 11 01 2024
pageextension 50086 "ShipToAddressListExt" extends "Ship-to Address List"
{
    layout
    {
        addafter("Location Code")
        {
            field("State Code"; rec."State Code")
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
