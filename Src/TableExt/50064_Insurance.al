tableextension 50064 InsuranceExtCstm extends Insurance
{
    fields
    {
        field(50001; Payroll; Boolean)
        {
        }
        field(50002; "Insurance Utilized"; Decimal)
        {
            //CalcFormula = Sum(Table60078.Field4 WHERE (Field3=FIELD(No.)));
            Editable = false;
            //FieldClass = FlowField;azhar Pending
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