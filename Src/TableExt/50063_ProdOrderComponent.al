tableextension 50063 ProdOrderComponentExtCstm extends "Prod. Order Component"
{
    fields
    {
        field(50000; "Input Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = '01Sep2018';

            trigger OnValidate()
            begin

                IF Status = Status::Finished THEN
                    ERROR(Text000);


                TQty := 0;
                PrOrdLine.RESET;
                PrOrdLine.SETRANGE(Status, Status);
                PrOrdLine.SETRANGE("Prod. Order No.", "Prod. Order No.");
                PrOrdLine.SETRANGE("Line No.", "Prod. Order Line No.");
                IF PrOrdLine.FINDFIRST THEN BEGIN
                    TQty := PrOrdLine.Quantity;
                END;

                IF "Input Quantity" <> 0 THEN BEGIN
                    IF NOT "Original Qty Update" THEN BEGIN
                        VALIDATE("Original Qty Per", "Quantity per");
                        VALIDATE("Original Qty Update", TRUE);
                    END;
                    VALIDATE("Quantity per", "Input Quantity" / TQty);
                END ELSE BEGIN
                    IF "Original Qty Update" THEN
                        VALIDATE("Quantity per", "Original Qty Per");
                END;
            end;
        }
        field(50001; "Original Qty Per"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = '01Sep2018';
            Editable = false;
        }
        field(50002; "Original Qty Update"; Boolean)
        {
            Description = '01Sep2018';
            Editable = false;
        }
        field(50004; "Online Rejection Qty"; Decimal)
        {
            Description = '04Sep2018';
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
        Text000: Label 'A finished production order component cannot be inserted, modified, or deleted.';
        PrOrdLine: Record 5406;
        TQty: Decimal;
}