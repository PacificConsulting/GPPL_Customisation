table 60036 "Posted Other PayElements"
{
    // 21-Apr-06.


    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = Employee_;

            trigger OnValidate()
            var
                Employee: Record Employee;
            begin
                IF Employee.GET("Employee No.") THEN
                    "Employee Name" := Employee."First Name";
            end;
        }
        field(2; "Employee Name"; Text[50])
        {
        }
        field(3; Month; Integer)
        {
            // ValuesAllowed = 1;2;3;4;5;6;7;8;9;10;11;12;
        }
        field(4; Year; Integer)
        {
        }
        field(5; "Pay Element Code"; Code[30])
        {
            TableRelation = "Pay Deductions";

            trigger OnValidate()
            begin
                IF PayDeduct.GET("Pay Element Code") THEN BEGIN
                    Description := PayDeduct.Description;
                    "Add/Deduct" := PayDeduct."Add/Deduct";
                END;
            end;
        }
        field(6; Description; Text[50])
        {
        }
        field(7; Amount; Decimal)
        {
        }
        field(8; "Add/Deduct"; Option)
        {
            OptionMembers = " ",Addition,Deduction;
        }
        field(9; Priority; Integer)
        {
        }
        field(13; LineNo; Integer)
        {
        }
        field(14; Reversed; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", Month, Year, "Pay Element Code", LineNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF FINDLAST THEN
            LineNo += 1
        ELSE
            LineNo := 1;
    end;

    var
        Employee: Record 60019;
        PayDeduct: Record 60034;

    //  [Scope('Internal')]
    procedure UpdateProcSalary(OtherDeduct: Record 60035)
    var
        TempProcSalary: Record 60037;
    begin
        TempProcSalary.INIT;
        TempProcSalary."Document Type" := TempProcSalary."Document Type"::Payroll;
        TempProcSalary."Employee Code" := OtherDeduct."Employee No.";
        TempProcSalary."Pay Slip Month" := OtherDeduct.Month;
        TempProcSalary.Year := OtherDeduct.Year;
        TempProcSalary."Line No." := TempProcSalary."Line No." + 10000;
        TempProcSalary."Fixed/Percent" := TempProcSalary."Fixed/Percent"::Fixed;
        TempProcSalary."Add/Deduct Code" := OtherDeduct."Pay Element Code";
        TempProcSalary."Earned Amount" := OtherDeduct.Amount;
        TempProcSalary."Add/Deduct" := OtherDeduct."Add/Deduct";
        TempProcSalary."Employee Name" := OtherDeduct."Employee Name";
        TempProcSalary.Priority := OtherDeduct.Priority;
        TempProcSalary.INSERT;
    end;
}

