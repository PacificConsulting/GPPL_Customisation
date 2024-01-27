table 60009 "Posted Salary Details"
{
    DrillDownPageID = 60084;
    LookupPageID = 60084;

    fields
    {
        field(1; "Posting Date"; Date)
        {
        }
        field(2; "Document No"; Code[20])
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; Month; Integer)
        {
        }
        field(5; Year; Integer)
        {
        }
        field(6; "Employee Code"; Code[20])
        {
            TableRelation = Employee_;
        }
        field(7; "Total Additions"; Decimal)
        {
        }
        field(8; "Total Deductions"; Decimal)
        {
        }
        field(9; "Net Salary"; Decimal)
        {
        }
        field(10; "Salary Paid"; Decimal)
        {
        }
        field(11; Reversed; Boolean)
        {
        }
        field(12; "Line No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", Month, Year, "Posting Date", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Salary Paid";
        }
    }

    fieldgroups
    {
    }
}

