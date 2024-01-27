page 70025 "Payroll Cost - Departmentwise"
{
    Editable = false;
    PageType = Card;
    SourceTable = 60019;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group("Payroll Cost - Departmentwise")
            {
                Caption = 'Payroll Cost - Departmentwise';
                grid(General)
                {
                    group(Department)
                    {
                        Caption = 'Department';
                        label("1")
                        {
                            CaptionClass = '3,' + DepartmentArr[1, 1];
                            Caption = '1';
                            ShowCaption = false;
                        }
                        label("2")
                        {
                            CaptionClass = '3,' + DepartmentArr[2, 1];
                            Caption = '2';
                            ShowCaption = false;
                        }
                        label("3")
                        {
                            CaptionClass = '3,' + DepartmentArr[3, 1];
                            Caption = '3';
                            ShowCaption = false;
                        }
                        label("4")
                        {
                            CaptionClass = '3,' + DepartmentArr[4, 1];
                            Caption = '4';
                            ShowCaption = false;
                        }
                        label("5")
                        {
                            CaptionClass = '3,' + DepartmentArr[5, 1];
                            Caption = '5';
                            ShowCaption = false;
                        }
                        label("6")
                        {
                            CaptionClass = '3,' + DepartmentArr[6, 1];
                            Caption = '6';
                            ShowCaption = false;
                        }
                        label("7")
                        {
                            CaptionClass = '3,' + DepartmentArr[7, 1];
                            Caption = '7';
                            ShowCaption = false;
                        }
                        label("8")
                        {
                            CaptionClass = '3,' + DepartmentArr[8, 1];
                            Caption = '8';
                            ShowCaption = false;
                        }
                        label("9")
                        {
                            CaptionClass = '3,' + DepartmentArr[9, 1];
                            Caption = '9';
                            ShowCaption = false;
                        }
                        label("10")
                        {
                            CaptionClass = '3,' + DepartmentArr[10, 1];
                            Caption = '10';
                            ShowCaption = false;
                        }
                    }
                    group("Payroll Cost (CM)")
                    {
                        Caption = 'Payroll Cost (CM)';
                        field(DepartmentArr12; DepartmentArr[1, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[1, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(DepartmentArr22; DepartmentArr[2, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[2, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(DepartmentArr32; DepartmentArr[3, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[3, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(DepartmentArr42; DepartmentArr[4, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[4, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(DepartmentArr52; DepartmentArr[5, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[5, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(DepartmentArr62; DepartmentArr[6, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[6, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(DepartmentArr72; DepartmentArr[7, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[7, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(DepartmentArr82; DepartmentArr[8, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[8, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(DepartmentArr92; DepartmentArr[9, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[9, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(DepartmentArr102; DepartmentArr[10, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[10, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                    }
                    group("Payroll Cost (YTD)")
                    {
                        Caption = 'Payroll Cost (YTD)';
                        field(DepartmentArr13; DepartmentArr[1, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[1, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(DepartmentArr23; DepartmentArr[2, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[2, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(DepartmentArr33; DepartmentArr[3, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[3, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(DepartmentArr43; DepartmentArr[4, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[4, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(DepartmentArr53; DepartmentArr[5, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[5, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(DepartmentArr63; DepartmentArr[6, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[6, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(DepartmentArr73; DepartmentArr[7, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[7, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(DepartmentArr83; DepartmentArr[8, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[8, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(DepartmentArr93; DepartmentArr[9, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[9, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(DepartmentArr103; DepartmentArr[10, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[10, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                    }
                    group("Employees in Payroll")
                    {
                        Caption = 'Employees in Payroll';
                        field(DepartmentArr14; DepartmentArr[1, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[1, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(DepartmentArr24; DepartmentArr[2, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[2, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(DepartmentArr34; DepartmentArr[3, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[3, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(DepartmentArr44; DepartmentArr[4, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[4, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(DepartmentArr54; DepartmentArr[5, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[5, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(DepartmentArr64; DepartmentArr[6, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[6, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(DepartmentArr74; DepartmentArr[7, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[7, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(DepartmentArr84; DepartmentArr[8, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[8, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(DepartmentArr94; DepartmentArr[9, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[9, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(DepartmentArr104; DepartmentArr[10, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[10, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        //BasicSalaryShow;
        Month := DATE2DMY(TODAY, 2);
        Year := DATE2DMY(TODAY, 3);
        StartDate := DMY2DATE(1, Month, Year);
        EndDate := CALCDATE('CM', StartDate);


        Lookup.RESET;
        i := 0;
        Lookup.SETRANGE(Lookup."LookupType Name", 'DEPARTMENTS');
        IF Lookup.FINDSET THEN
            REPEAT

                // to calculate basic salaries:
                BasicSalaries := 0;
                Employee.RESET;
                Employee.SETRANGE(Resigned, FALSE);
                Employee.SETRANGE(Status, Employee.Status::Active);
                Employee.SETRANGE("Department Code", Lookup."Lookup Name");
                IF Employee.FINDSET THEN
                    REPEAT
                        PayElement.RESET;
                        PayElement.SETRANGE("Employee Code", Employee."No.");
                        IF PayElement.FINDLAST THEN
                            EffectiveDate := PayElement."Effective Start Date";
                        PayElement.RESET;
                        PayElement.SETRANGE("Employee Code", Employee."No.");
                        PayElement.SETRANGE(PayElement."Effective Start Date", EffectiveDate);
                        IF PayElement.FINDSET THEN
                            REPEAT
                                BasicSalaries += PayElement."Actual Amount";
                            UNTIL PayElement.NEXT = 0;
                    UNTIL Employee.NEXT = 0;

                //to calculate payrollYCT:
                AdditionAmount := 0;
                DeductAmount := 0;
                PayrollCostYTD := 0;
                PayRollYear.RESET;
                PayRollYear.SETRANGE(PayRollYear.Closed, FALSE);
                PayRollYear.SETFILTER(PayRollYear."Year Start Date", '<=%1', TODAY);
                IF PayRollYear.FINDFIRST THEN
                    YearStartDate := PayRollYear."Year Start Date";

                Employee.RESET;
                Employee.SETRANGE("Department Code", Lookup."Lookup Name");
                IF Employee.FINDSET THEN
                    REPEAT
                        ProcessedSalary.RESET;
                        ProcessedSalary.SETRANGE("Employee Code", Employee."No.");
                        ProcessedSalary.SETRANGE(ProcessedSalary.Posted, TRUE);
                        ProcessedSalary.SETRANGE(ProcessedSalary."Posting Date", YearStartDate, TODAY);
                        ProcessedSalary.SETRANGE(ProcessedSalary."Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
                        IF ProcessedSalary.FINDSET THEN
                            REPEAT
                                AdditionAmount += ProcessedSalary."Earned Amount";
                            UNTIL ProcessedSalary.NEXT = 0;

                        ProcessedSalary.RESET;
                        ProcessedSalary.SETRANGE("Employee Code", Employee."No.");
                        ProcessedSalary.SETRANGE(ProcessedSalary.Posted, TRUE);
                        ProcessedSalary.SETRANGE(ProcessedSalary."Posting Date", YearStartDate, TODAY);
                        ProcessedSalary.SETRANGE(ProcessedSalary."Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
                        IF ProcessedSalary.FINDSET THEN
                            REPEAT
                                DeductAmount += ProcessedSalary."Earned Amount";
                            UNTIL ProcessedSalary.NEXT = 0;

                        PayrollCostYTD := AdditionAmount - DeductAmount;

                    //MESSAGE('%1',AdditionAmount);
                    //MESSAGE('%1',DeductAmount);
                    //MESSAGE('%1',PayrollCostYTD);
                    UNTIL Employee.NEXT = 0;


                //to calculate employees in payroll:
                EmployeeinPayroll := 0;
                Employee.RESET;
                Employee.SETRANGE("Department Code", Lookup."Lookup Name");
                Employee.SETRANGE(Employee.Status, Employee.Status::Active);
                Employee.SETRANGE(Employee.Blocked, FALSE);
                Employee.SETRANGE(Employee."Stop Payment", FALSE);
                IF Employee.FINDSET THEN
                    REPEAT
                        EmployeeinPayroll += 1;
                    UNTIL Employee.NEXT = 0;

                i += 1;
                DepartmentArr[i, 1] := FORMAT(0);
                DepartmentArr[i, 2] := FORMAT(0);
                DepartmentArr[i, 3] := FORMAT(0);
                DepartmentArr[i, 4] := FORMAT(0);

                DepartmentArr[i, 1] := Lookup.Description;
                DepartmentArr[i, 2] := FORMAT(BasicSalaries);
                DepartmentArr[i, 3] := FORMAT(PayrollCostYTD);
                DepartmentArr[i, 4] := FORMAT(EmployeeinPayroll);
            UNTIL Lookup.NEXT = 0;
    end;

    var
        Text19040493: Label 'Employee Dashboard - Designationwise';
        Text19067950: Label 'DESIGNATION';
        Text19010561: Label 'Resignations';
        Text19076330: Label 'New Joinees';
        Text19001219: Label 'Terminated Employees';
        Text19011194: Label 'Overall Employee Statistics';
        Text19003536: Label 'No. Of Employees';
        Text19067053: Label 'Probation';
        Text19057152: Label 'No. of Inactive Employees';
        Text19065850: Label 'No. of Resigned Employees';
        Text19003771: Label 'No. of Terminated Employees';
        BasicSalaries: Decimal;
        AdditionAmount: Decimal;
        DeductAmount: Decimal;
        PayrollCostYTD: Decimal;
        EmployeeinPayroll: Integer;
        Employee: Record 60019;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        Year: Integer;
        EmployeeListForm: Page 60005;
        PayElement: Record 60025;
        EffectiveDate: Date;
        PayElementForm: Page 60097;
        PayRollYear: Record 60020;
        ProcessedSalary: Record 60038;
        YearStartDate: Date;
        ProcessedSalaryForm: Page 60031;
        Lookup: Record "60018";
        DepartmentArr: array[50, 4] of Text[100];
        i: Integer;
        Text1: Text[100];
        Lookup1: Record 60018;
        Lookup2: Record 60018;
        PayElement1: Record 60025;

    //   [Scope('Internal')]
    procedure BasicSalaryShow()
    begin
        PayElement.RESET;
        PayElement.SETRANGE(PayElement.Show, TRUE);
        IF PayElement.FINDSET THEN
            REPEAT
                PayElement.Show := FALSE;
                PayElement.MODIFY;
            UNTIL PayElement.NEXT = 0;
        Employee.RESET;
        Employee.SETRANGE(Resigned, FALSE);
        Employee.SETRANGE(Status, Employee.Status::Active);
        IF Employee.FINDSET THEN
            REPEAT
                PayElement.RESET;
                PayElement.SETRANGE("Employee Code", Employee."No.");
                IF PayElement.FINDLAST THEN
                    EffectiveDate := PayElement."Effective Start Date";

                PayElement.RESET;
                PayElement.SETRANGE("Employee Code", Employee."No.");
                PayElement.SETRANGE(PayElement."Effective Start Date", EffectiveDate);
                IF PayElement.FINDSET THEN
                    REPEAT
                        PayElement.Show := TRUE;
                        PayElement.MODIFY;
                    UNTIL PayElement.NEXT = 0;
            UNTIL Employee.NEXT = 0;
    end;

    //  [Scope('Internal')]
    procedure ShowPayrollCostCalculation(department: Text[100])
    begin
        CLEAR(ProcessedSalaryForm);
        ProcessedSalary.CLEARMARKS;
        Lookup1.RESET;
        Lookup1.SETRANGE(Lookup1."LookupType Name", 'DEPARTMENTS');
        Lookup1.SETRANGE(Lookup1.Description, department);
        IF Lookup1.FINDFIRST THEN BEGIN
            PayRollYear.RESET;
            PayRollYear.SETRANGE(PayRollYear.Closed, FALSE);
            PayRollYear.SETFILTER(PayRollYear."Year Start Date", '<=%1', TODAY);
            IF PayRollYear.FINDFIRST THEN
                YearStartDate := PayRollYear."Year Start Date";

            Employee.RESET;
            Employee.SETRANGE("Department Code", Lookup1."Lookup Name");
            IF Employee.FINDSET THEN BEGIN
                ProcessedSalary.RESET;
                ProcessedSalary.SETRANGE(ProcessedSalary.Posted, TRUE);
                ProcessedSalary.SETRANGE(ProcessedSalary."Posting Date", YearStartDate, TODAY);
                REPEAT
                    ProcessedSalary.MARKEDONLY(FALSE);
                    IF ProcessedSalary.FINDSET THEN
                        REPEAT
                            IF (ProcessedSalary."Employee Code") = (Employee."No.") THEN
                                ProcessedSalary.MARK(TRUE);
                        UNTIL ProcessedSalary.NEXT = 0;
                UNTIL Employee.NEXT = 0;
            END;
            ProcessedSalary.MARKEDONLY(TRUE);
            ProcessedSalaryForm.SETTABLEVIEW(ProcessedSalary);
            ProcessedSalaryForm.RUNMODAL;
        END;
    end;

    //  [Scope('Internal')]
    procedure ShowEmployeeInPayrollCalc(department: Text[100])
    begin
        CLEAR(EmployeeListForm);
        Lookup.RESET;
        Lookup.SETRANGE(Lookup."LookupType Name", 'DEPARTMENTS');
        Lookup.SETRANGE(Lookup.Description, department);
        IF Lookup.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE("Department Code", Lookup."Lookup Name");
            Employee.SETRANGE(Employee.Status, Employee.Status::Active);
            Employee.SETRANGE(Employee.Blocked, FALSE);
            Employee.SETRANGE(Employee."Stop Payment", FALSE);
            EmployeeListForm.SETTABLEVIEW(Employee);
            EmployeeListForm.RUNMODAL;
        END;
    end;

    // [Scope('Internal')]
    procedure ShowBasicSalaries(department: Text[100])
    begin
        CLEAR(PayElementForm);

        PayElement1.RESET;

        Lookup2.RESET;
        Lookup2.SETRANGE("LookupType Name", 'DEPARTMENTS');
        Lookup2.SETRANGE(Description, department);
        IF Lookup2.FINDFIRST THEN BEGIN              //it
            Employee.RESET;
            Employee.SETRANGE(Resigned, FALSE);
            Employee.SETRANGE(Status, Employee.Status::Active);
            Employee.SETRANGE("Department Code", Lookup2."Lookup Name");
            IF Employee.FINDSET THEN BEGIN
                REPEAT
                    PayElement1.MARKEDONLY(FALSE);
                    IF PayElement1.FINDSET THEN
                        REPEAT
                            IF (PayElement1."Employee Code" = Employee."No.") THEN
                                PayElement1.MARK(TRUE);
                        UNTIL PayElement1.NEXT = 0;
                UNTIL Employee.NEXT = 0;
            END;
            PayElement1.MARKEDONLY(TRUE);
            PayElementForm.SETTABLEVIEW(PayElement1);
            PayElementForm.RUNMODAL;
        END;
    end;
}

