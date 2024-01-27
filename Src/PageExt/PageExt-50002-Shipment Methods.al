pageextension 50002 ShipmentMethodsExt extends "Shipment Methods"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("GST Reporting Transport Mode"; Rec."GST Reporting Transport Mode")
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