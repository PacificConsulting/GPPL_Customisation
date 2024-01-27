pageextension 50047 "Item Tracking LinesCstmext" extends "Item Tracking Lines"
{
    layout
    {
        addafter("Location Code")
        {
            field("Quantity in Sales UOM"; Rec."Quantity in Sales UOM")
            {
                ApplicationArea = all;
                Style = Attention;
                StyleExpr = TRUE;
            }
        }
        addafter("Appl.-from Item Entry")
        {
            field("Qty Shipped Pervious"; Rec."Qty Shipped Pervious")
            {
                ApplicationArea = all;
                Editable = FALSE;
                Style = Attention;
                StyleExpr = TRUE;
            }
        }
    }



    actions
    {
        // Add changes to page actions here


    }

    trigger OnAfterGetRecord()
    var
        QtyShipped: Decimal;
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        //EBT0001
        QtyShipped := 0;
        IF rec."Source Type" = 37 THEN BEGIN
            SalesShipmentLine.RESET;
            SalesShipmentLine.SETRANGE(SalesShipmentLine."Order No.", rec."Source ID");
            SalesShipmentLine.SETRANGE(SalesShipmentLine."Lot No.", rec."Lot No.");
            IF SalesShipmentLine.FINDSET THEN
                REPEAT
                    QtyShipped += SalesShipmentLine.Quantity;
                UNTIL SalesShipmentLine.NEXT = 0;
            rec."Qty Shipped Pervious" := QtyShipped;
        END;
        //EBT0001
    end;

    var
        myInt: Integer;
}