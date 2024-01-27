tableextension 50055 TrackingSpecificationExtcstm extends 336
{
    fields
    {
        field(50000; "Quantity in Sales UOM"; Decimal)
        {
            Description = 'EBT0001';

            trigger OnValidate()
            begin
                IF "Quantity in Sales UOM" <> 0 THEN
                    VALIDATE("Quantity (Base)", "Qty. per Unit of Measure" * "Quantity in Sales UOM");  //EBT0001
            end;
        }
        field(50001; "Qty Shipped Pervious"; Decimal)
        {
            Description = 'EBT0001';
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
}