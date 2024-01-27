tableextension 50077 WarehouseReceiptLineExtCstm extends "Warehouse Receipt Line"
{
    fields
    {
        field(50000; "QC Applicable"; Boolean)
        {
            Description = 'EBT/QC Func/0001';
            Editable = true;
        }
        field(50001; "QC Approved"; Boolean)
        {
            Description = 'EBT/QC Func/0001';
            Editable = false;
        }
        field(50002; "Gross Weight"; Decimal)
        {
            Description = 'EBT/LR/0001';
        }
        field(50003; "Net Weight of Vehicle"; Decimal)
        {
            Description = 'EBT/LR/0001';

            trigger OnValidate()
            begin
                //EBT/LR/0001
                /*IF "Gross Weight" <> 0 THEN
                BEGIN
                  NetWeight := "Gross Weight" -"Qty. Outstanding (Base)";
                  IF NetWeight > "Qty. Outstanding (Base)" THEN
                     ERROR('You cannot put more than the Orderd Quantity. Here quantity is %1 more',(NetWeight - "Qty. Outstanding (Base)"))
                  ELSE
                     //VALIDATE("Qty. to Receive","Gross Weight"-NetWeight);
                     "Qty. to Receive" := "Gross Weight"-NetWeight;
                     VALIDATE("Qty. per Unit of Measure");
                END;
                
                VALIDATE("Qty. per Unit of Measure",1); */
                //EBT/LR/0001
                VALIDATE("Qty. to Receive", "Gross Weight" - "Net Weight of Vehicle");

            end;
        }
        field(50004; "Expiry Date"; Date)
        {
            Description = 'RSPLSUM 28688 18Feb21';
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