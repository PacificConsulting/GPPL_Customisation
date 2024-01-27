table 50003 "Transport Subsidy"
{

    fields
    {
        field(1; "Minimum Distance"; Decimal)
        {
        }
        field(2; "Maximum Distance"; Decimal)
        {
        }
        field(3; "Minimum Quantity"; Decimal)
        {
        }
        field(4; "Maximum Quantity"; Decimal)
        {
        }
        field(5; "Transport Subsidy"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Minimum Distance")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

