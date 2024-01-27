table 60040 "Loan Details"
{
    DrillDownPageID = 60034;
    LookupPageID = 60034;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = Employee_;
        }
        field(2; "Loan Code"; Code[20])
        {
        }
        field(3; "Pay Date"; Date)
        {
        }
        field(4; "Loan Amount"; Decimal)
        {
        }
        field(5; "Repayment Date"; Date)
        {
        }
        field(6; "EMI Deducted"; Decimal)
        {
        }
        field(7; "EMI Amount"; Decimal)
        {
        }
        field(8; Interest; Decimal)
        {
        }
        field(9; Principal; Decimal)
        {
        }
        field(10; "Lump Sum Payment"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Loan Repayments".Amount WHERE("Loan Id" = FIELD("Loan Id"),
                                                             "Employee No." = FIELD("Employee No."),
                                                              Month = FIELD(Month),
                                                              Year = FIELD(Year),
                                                              Paid = CONST(true)));

        }
        field(11; Balance; Decimal)
        {
        }
        field(12; "Paid Month"; Integer)
        {
        }
        field(13; "Paid Year"; Integer)
        {
        }
        field(14; "Line No"; Integer)
        {
        }
        field(15; "Loan Closed"; Boolean)
        {
        }
        field(16; Month; Integer)
        {
        }
        field(17; Year; Integer)
        {
        }
        field(18; "Loan Id"; Code[20])
        {
        }
        field(19; "Knocked Off ag lumsum"; Boolean)
        {
        }
        field(20; "knocked Off Amount"; Decimal)
        {
        }
        field(21; "Balance (Base)"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Loan Id", "Line No")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.", "Loan Code", Month, Year)
        {
            SumIndexFields = "EMI Amount";
        }
        key(Key3; "Loan Id")
        {
        }
    }

    fieldgroups
    {
    }
}

