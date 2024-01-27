
// MY PC 09 01 2024
pageextension 50075 "TransferStatisticsExt" extends "Transfer Statistics"
{
    layout
    {

    }

    actions
    {
        // Add changes to page actions here
    }

    /// MY PC 09 01 2024
    trigger OnAfterGetRecord()

    var
        TransLine: Record "Transfer Line";
        LineQty: Decimal;
        TotalNetWeight: Decimal;
        TotalGrossWeight: Decimal;
        TotalVolume: Decimal;
        TotalParcels: Decimal;
        GSTBaseAmt13: Decimal;
        GSTAmt13: Decimal;
        Amount13: Decimal;
    begin
        CLEARALL;

        TransLine.SETRANGE("Document No.", rec."No.");
        TransLine.SETRANGE("Derived From Line No.", 0);
        IF TransLine.FIND('-') THEN
            REPEAT
                LineQty := LineQty + TransLine.Quantity;
                TotalNetWeight := TotalNetWeight + (TransLine.Quantity * TransLine."Net Weight");
                TotalGrossWeight := TotalGrossWeight + (TransLine.Quantity * TransLine."Gross Weight");
                TotalVolume := TotalVolume + (TransLine.Quantity * TransLine."Unit Volume");
                IF TransLine."Units per Parcel" > 0 THEN
                    TotalParcels := TotalParcels + ROUND(TransLine.Quantity / TransLine."Units per Parcel", 1, '');

                //RB-N 13Nov2017
                GSTBaseAmt13 += (TransLine."Quantity (Base)" * TransLine."Transfer Price of Base Unit");
                //  GSTAmt13 += ABS(TransLine."Total GST Amount");
                Amount13 += ABS(TransLine.Amount);

            //

            UNTIL TransLine.NEXT = 0;

    end;

    var
        myInt: Integer;
}
