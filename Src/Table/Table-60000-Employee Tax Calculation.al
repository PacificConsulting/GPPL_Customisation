table 60000 "Employee Tax Calculation"
{

    fields
    {
        field(1; "Employee No."; Code[10])
        {
            TableRelation = Employee_;
        }
        field(2; "Year Start Date"; Date)
        {
            TableRelation = "Payroll Year"."Year Start Date" WHERE("Year Type" = CONST('LEAVE YEAR'),
                                                                    Closed = FILTER(false));

            trigger OnValidate()
            begin
                PayrollYear.RESET;
                PayrollYear.SETRANGE("Year Type", 'LEAVE YEAR');
                PayrollYear.SETRANGE(Closed, FALSE);
                PayrollYear.SETRANGE("Year Start Date", "Year Start Date");
                IF PayrollYear.FINDFIRST THEN
                    "Year End Date" := PayrollYear."Year End Date"
                ELSE
                    ERROR('This Leave year has not been defined');
            end;
        }
        field(3; "Year End Date"; Date)
        {
        }
        field(4; "Total Salary In the Year"; Decimal)
        {
        }
        field(5; "Tax Rebate"; Decimal)
        {
        }
        field(6; "Total Investment"; Decimal)
        {
        }
        field(7; "HRA Exempt"; Decimal)
        {
        }
        field(8; "Conveyance Exempt"; Decimal)
        {
        }
        field(9; "Medical Exempt"; Decimal)
        {
        }
        field(10; "Total HRA Paid"; Decimal)
        {
        }
        field(11; "Total Basic Paid"; Decimal)
        {
        }
        field(12; "Total Rent Paid"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PayrollYear: Record 60020;
}

