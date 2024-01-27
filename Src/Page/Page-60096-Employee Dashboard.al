page 60096 "Employee Dashboard"
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
            group("EMPLOYEE DASHBOARD")
            {
                Caption = 'EMPLOYEE DASHBOARD';
                grid("-Employee Details-")
                {
                    Caption = '-Employee Details-';
                    group(group1)
                    {
                        label("New Joinees (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'New Joinees (CM)';
                            ShowCaption = false;
                        }
                        label("Resignations (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Resignations (CM)';
                            ShowCaption = false;
                        }
                        label("Terminated Employees (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Terminated Employees (CM)';
                            ShowCaption = false;
                        }
                        label(Probation)
                        {
                            ApplicationArea = all;
                            Caption = 'Probation';
                            ShowCaption = false;
                        }
                        label("No. Of Employees")
                        {
                            ApplicationArea = all;
                            Caption = 'No. Of Employees';
                            ShowCaption = false;
                        }
                        label("No. of Inactive Employees")
                        {
                            ApplicationArea = all;
                            Caption = 'No. of Inactive Employees';
                            ShowCaption = false;
                        }
                        label("No. of Resigned Employees")
                        {
                            ApplicationArea = all;
                            Caption = 'No. of Resigned Employees';
                            ShowCaption = false;
                        }
                        label("No. of Terminated Employees")
                        {
                            ApplicationArea = all;
                            Caption = 'No. of Terminated Employees';
                            ShowCaption = false;
                        }
                    }
                    group(group2)
                    {
                        field(NewJoinees; NewJoinees)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin
                                CLEAR(EmployeeListForm);
                                Employee.RESET;
                                Employee.SETRANGE("Employment Date", StartDate, EndDate);
                                EmployeeListForm.SETTABLEVIEW(Employee);
                                EmployeeListForm.RUNMODAL;
                            end;
                        }
                        field(Resignations; Resignations)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin
                                CLEAR(EmployeeListForm);
                                Employee.RESET;
                                Employee.SETFILTER(Employee.Status, '<>%1', Employee.Status::Terminated);
                                Employee.SETRANGE(Resigned, TRUE);
                                Employee.SETRANGE("Resignation Date", StartDate, EndDate);
                                EmployeeListForm.SETTABLEVIEW(Employee);
                                EmployeeListForm.RUNMODAL;
                            end;
                        }
                        field(Terminations; Terminations)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(EmployeeListForm);
                                Employee.RESET;
                                Employee.SETRANGE(Status, Employee.Status::Terminated);
                                Employee.SETRANGE("Termination Date", StartDate, EndDate);
                                EmployeeListForm.SETTABLEVIEW(Employee);
                                EmployeeListForm.RUNMODAL;
                            end;
                        }
                        field(Probations; Probations)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(EmployeeListForm);
                                Employee.RESET;
                                Employee.SETRANGE(Employee.Probation, TRUE);
                                EmployeeListForm.SETTABLEVIEW(Employee);
                                EmployeeListForm.RUNMODAL;
                            end;
                        }
                        field(NoOfEmployees; NoOfEmployees)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(EmployeeListForm);
                                Employee.RESET;
                                Employee.SETRANGE(Employee.Status, Employee.Status::Active);
                                EmployeeListForm.SETTABLEVIEW(Employee);
                                EmployeeListForm.RUNMODAL;
                            end;
                        }
                        field(NoOfInactiveEmployees; NoOfInactiveEmployees)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(EmployeeListForm);
                                Employee.RESET;
                                Employee.SETRANGE(Employee.Status, Employee.Status::Inactive);
                                EmployeeListForm.SETTABLEVIEW(Employee);
                                EmployeeListForm.RUNMODAL;
                            end;
                        }
                        field(NoOfResignedEmployees; NoOfResignedEmployees)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(EmployeeListForm);
                                Employee.RESET;
                                Employee.SETFILTER(Employee.Status, '<>%1', Employee.Status::Terminated);
                                Employee.SETRANGE(Employee.Resigned, TRUE);
                                EmployeeListForm.SETTABLEVIEW(Employee);
                                EmployeeListForm.RUNMODAL;
                            end;
                        }
                        field(NoOfTerminatedEmployees; NoOfTerminatedEmployees)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(EmployeeListForm);
                                Employee.RESET;
                                Employee.SETRANGE(Employee.Status, Employee.Status::Terminated);
                                EmployeeListForm.SETTABLEVIEW(Employee);
                                EmployeeListForm.RUN;
                            end;
                        }
                    }
                }
                grid("-Payroll Details-")
                {
                    Caption = '-Payroll Details-';
                    group(group3)
                    {
                        label("Payroll Cost (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Payroll Cost (CM)';
                            ShowCaption = false;
                        }
                        label("Payroll Cost (YTD)")
                        {
                            ApplicationArea = all;
                            Caption = 'Payroll Cost (YTD)';
                            ShowCaption = false;
                        }
                        label("Employees in Payroll")
                        {
                            ApplicationArea = all;
                            Caption = 'Employees in Payroll';
                            ShowCaption = false;
                        }
                    }
                    group(group4)
                    {
                        field(BasicSalaries; BasicSalaries)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(PayElementForm);
                                PayElement.RESET;
                                PayElement.SETRANGE(Show, TRUE);
                                PayElementForm.SETTABLEVIEW(PayElement);
                                PayElementForm.RUNMODAL;
                            end;
                        }
                        field(PayrollCostYTD; PayrollCostYTD)
                        {

                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(ProcessedSalaryForm);
                                ProcessedSalary.RESET;
                                ProcessedSalary.SETRANGE(ProcessedSalary.Posted, TRUE);
                                ProcessedSalary.SETRANGE(ProcessedSalary."Posting Date", YearStartDate, TODAY);
                                ProcessedSalaryForm.SETTABLEVIEW(ProcessedSalary);
                                ProcessedSalaryForm.RUNMODAL;
                            end;
                        }
                        field(EmployeeinPayroll; EmployeeinPayroll)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(EmployeeListForm);
                                Employee.RESET;
                                Employee.SETRANGE(Employee.Status, Employee.Status::Active);
                                Employee.SETRANGE(Employee.Blocked, FALSE);
                                Employee.SETRANGE(Employee."Stop Payment", FALSE);
                                EmployeeListForm.SETTABLEVIEW(Employee);
                                EmployeeListForm.RUNMODAL;
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

    trigger OnAfterGetRecord()
    begin

        Month := DATE2DMY(TODAY, 2);
        Year := DATE2DMY(TODAY, 3);
        StartDate := DMY2DATE(1, Month, Year);
        EndDate := CALCDATE('CM', StartDate);

        NewJoineesCalculation;
        ResignationCalculation;
        TerminationCalculation;
        ProbationCalculation;
        NoOfEmployeeCalculation;
        InactiveEmpCalculation;
        ResignedEmpCalculation;
        TerminatedEmpCalculation;
        BasicSalaryCalculation;
        PayrollCostCalculation;
        EmployeeInPayrollCalc;
    end;

    trigger OnOpenPage()
    begin
        BasicSalaryShow;
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
        NewJoinees: Integer;
        Resignations: Integer;
        Terminations: Integer;
        Probations: Integer;
        NoOfEmployees: Integer;
        NoOfResignedEmployees: Integer;
        NoOfTerminatedEmployees: Integer;
        NoOfInactiveEmployees: Integer;
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
        PayRollYear: Record 60020;
        ProcessedSalary: Record 60038;
        YearStartDate: Date;
        ProcessedSalaryForm: Page 60031;
        PayElementForm: Page 60097;

    // [Scope('Internal')]
    procedure NewJoineesCalculation()
    begin
        //New Joinees
        NewJoinees := 0;
        Employee.RESET;
        Employee.SETRANGE("Employment Date", StartDate, EndDate);
        IF Employee.FINDSET THEN
            REPEAT
                NewJoinees += 1;
            UNTIL Employee.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure ResignationCalculation()
    begin
        //Resignations
        Resignations := 0;
        Employee.RESET;
        Employee.SETFILTER(Employee.Status, '<>%1', Employee.Status::Terminated);
        Employee.SETRANGE(Resigned, TRUE);
        Employee.SETRANGE("Resignation Date", StartDate, EndDate);
        IF Employee.FINDSET THEN
            REPEAT
                Resignations += 1;
            UNTIL Employee.NEXT = 0;
    end;

    //  [Scope('Internal')]
    procedure TerminationCalculation()
    begin
        //Terminations
        Terminations := 0;
        Employee.RESET;
        Employee.SETRANGE(Status, Employee.Status::Terminated);
        Employee.SETRANGE("Termination Date", StartDate, EndDate);
        IF Employee.FINDSET THEN
            REPEAT
                Terminations += 1;
            UNTIL Employee.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure ProbationCalculation()
    begin
        //Probation
        Probations := 0;
        Employee.RESET;
        Employee.SETRANGE(Employee.Probation, TRUE);
        IF Employee.FINDSET THEN
            REPEAT
                Probations += 1;
            UNTIL Employee.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure NoOfEmployeeCalculation()
    begin
        //NoOfEmployees
        NoOfEmployees := 0;
        Employee.RESET;
        Employee.SETRANGE(Employee.Status, Employee.Status::Active);
        IF Employee.FINDSET THEN
            REPEAT
                NoOfEmployees += 1;
            UNTIL Employee.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure ResignedEmpCalculation()
    begin
        //NoOfResignedEmployees
        NoOfResignedEmployees := 0;
        Employee.RESET;
        Employee.SETFILTER(Employee.Status, '<>%1', Employee.Status::Terminated);
        Employee.SETRANGE(Resigned, TRUE);
        IF Employee.FINDSET THEN
            REPEAT
                NoOfResignedEmployees += 1;
            UNTIL Employee.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure TerminatedEmpCalculation()
    begin
        //No.OfTerminatedEmployees
        NoOfTerminatedEmployees := 0;
        Employee.RESET;
        Employee.SETRANGE(Status, Employee.Status::Terminated);
        IF Employee.FINDSET THEN
            REPEAT
                NoOfTerminatedEmployees += 1;
            UNTIL Employee.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure BasicSalaryCalculation()
    begin
        BasicSalaries := 0;
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
                        BasicSalaries += PayElement."Actual Amount";
                    UNTIL PayElement.NEXT = 0;
            UNTIL Employee.NEXT = 0;
    end;

    //[Scope('Internal')]
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
    procedure PayrollCostCalculation()
    begin
        PayRollYear.RESET;
        PayRollYear.SETRANGE(PayRollYear.Closed, FALSE);
        PayRollYear.SETFILTER(PayRollYear."Year Start Date", '<=%1', TODAY);
        IF PayRollYear.FINDFIRST THEN
            YearStartDate := PayRollYear."Year Start Date";
        AdditionAmount := 0;
        DeductAmount := 0;
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE(ProcessedSalary.Posted, TRUE);
        ProcessedSalary.SETRANGE(ProcessedSalary."Posting Date", YearStartDate, TODAY);
        ProcessedSalary.SETRANGE(ProcessedSalary."Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
        IF ProcessedSalary.FINDSET THEN
            REPEAT
                AdditionAmount += ProcessedSalary."Earned Amount";
            UNTIL ProcessedSalary.NEXT = 0;
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE(ProcessedSalary.Posted, TRUE);
        ProcessedSalary.SETRANGE(ProcessedSalary."Posting Date", YearStartDate, TODAY);
        ProcessedSalary.SETRANGE(ProcessedSalary."Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        IF ProcessedSalary.FINDSET THEN
            REPEAT
                DeductAmount += ProcessedSalary."Earned Amount";
            UNTIL ProcessedSalary.NEXT = 0;
        PayrollCostYTD := AdditionAmount - DeductAmount;
    end;

    // [Scope('Internal')]
    procedure EmployeeInPayrollCalc()
    begin
        EmployeeinPayroll := 0;
        Employee.RESET;
        Employee.SETRANGE(Employee.Status, Employee.Status::Active);
        Employee.SETRANGE(Employee.Blocked, FALSE);
        Employee.SETRANGE(Employee."Stop Payment", FALSE);
        IF Employee.FINDSET THEN
            REPEAT
                EmployeeinPayroll += 1;
            UNTIL Employee.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure InactiveEmpCalculation()
    begin
        NoOfInactiveEmployees := 0;
        Employee.RESET;
        Employee.SETRANGE(Status, Employee.Status::Inactive);
        IF Employee.FINDSET THEN
            REPEAT
                NoOfInactiveEmployees += 1;
            UNTIL Employee.NEXT = 0;
    end;
}

