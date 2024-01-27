table 56668 "Item SKU"
{

    fields
    {
        field(1; "code"; Code[20])
        {
        }
        field(2; done; Boolean)
        {
        }
        field(3; Inventory; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE(Open = FILTER(true),
                                                                  "Item No." = FIELD(code)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

