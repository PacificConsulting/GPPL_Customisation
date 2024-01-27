// MY PC 10 01 2024
pageextension 50081 "SalesShipmentLinesExt" extends "Sales Shipment Lines"
{
    layout
    {
        addafter("Quantity Invoiced")
        {
            field("Lot No."; rec."Lot No.")
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