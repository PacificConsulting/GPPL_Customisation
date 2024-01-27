table 60041 "Loan Repayments"
{
    DrillDownPageID = 60068;
    LookupPageID = 60068;

    fields
    {
        field(1; "Loan Id"; Code[20])
        {
            TableRelation = Loan.Id;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee_."No.";
        }
        field(3; Month; Integer)
        {
        }
        field(4; Year; Integer)
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Payment Date"; Date)
        {
        }
        field(7; Paid; Boolean)
        {
        }
        field(8; "Line No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Loan Id", "Employee No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Loan Id", "Employee No.", Month, Year, Paid)
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record 60019;
        Loan: Record 60039;
}

