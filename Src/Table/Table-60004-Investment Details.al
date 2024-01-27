table 60004 "Investment Details"
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = Employee_;
        }
        field(2; "Investment Plan"; Code[50])
        {
            TableRelation = Investment."Investment Plan";
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; "Year Start Date"; Date)
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
        field(5; "Year End Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Investment Plan", "Year Start Date")
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

