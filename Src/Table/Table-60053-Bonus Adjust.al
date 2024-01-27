table 60053 "Bonus Adjust"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
        }
        field(2; "Employee Name"; Text[50])
        {
        }
        field(3; Month; Integer)
        {
        }
        field(4; Year; Integer)
        {
        }
        field(5; "Pay Element Code"; Code[30])
        {
        }
        field(6; "Bonus/Exgratia Amt"; Decimal)
        {
        }
        field(7; "Additional Bonus"; Decimal)
        {
        }
        field(8; Adjustments; Decimal)
        {
        }
        field(9; Salary; Decimal)
        {
        }
        field(10; "Net Payable"; Decimal)
        {
        }
        field(11; "Line No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", Month, Year, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

