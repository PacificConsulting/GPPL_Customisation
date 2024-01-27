table 60014 "Expected Salary Computation"
{
    // 15-Dec-05

    DrillDownPageID = 60031;
    LookupPageID = 60031;

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
        }
        field(2; "Expected Salary"; Decimal)
        {
        }
        field(3; Account; Code[50])
        {
        }
        field(4; Month; Integer)
        {
            //            ValuesAllowed = 1;2;3;4;5;6;7;8;9;10;11;12;
        }
        field(5; Year; Integer)
        {
        }
        field(6; "Actual Earned Salary"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Monthly Attendance"."Net Salary" WHERE("Employee Code" = FIELD("Employee Code"),
                                                                       "Pay Slip Month" = FIELD(Month),
                                                                       Year = FIELD(Year)));

        }
    }

    keys
    {
        key(Key1; "Employee Code", Year, Month)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

