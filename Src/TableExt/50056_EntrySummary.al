tableextension 50056 EntrySummaryExtCtm extends 338
{
    fields
    {
        field(50000; "Quantity in Sales UOM"; Decimal)
        {
            Description = 'EBT0001';
        }
        field(50001; "MRP Price"; Decimal)
        {
            Description = 'EBT0001';
        }
        field(50002; "List Price"; Decimal)
        {
            Description = 'EBT0001';
        }
        field(50003; "Manufacturing Date"; Date)
        {
            Description = 'RB-N 18Nov2017';
            Editable = false;
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