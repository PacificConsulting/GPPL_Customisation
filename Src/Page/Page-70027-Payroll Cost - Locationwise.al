page 70027 "Payroll Cost - Locationwise"
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
            group("Payroll Cost - Locationwise")
            {
                Caption = 'Payroll Cost - Locationwise';
                grid(Control1000000001)
                {
                    group(Location)
                    {
                        Caption = 'Location';
                        label("1")
                        {
                            CaptionClass = '3,' + LocationArr[1, 1];
                            Caption = '1';
                            ShowCaption = false;

                        }
                        label("2")
                        {
                            CaptionClass = '3,' + LocationArr[2, 1];
                            Caption = '2';
                            ShowCaption = false;
                        }
                        label("3")
                        {
                            CaptionClass = '3,' + LocationArr[3, 1];
                            Caption = '3';
                            ShowCaption = false;
                        }
                        label("4")
                        {
                            CaptionClass = '3,' + LocationArr[4, 1];
                            Caption = '4';
                            ShowCaption = false;
                        }
                        label("5")
                        {
                            CaptionClass = '3,' + LocationArr[5, 1];
                            Caption = '5';
                            ShowCaption = false;
                        }
                        label("6")
                        {
                            CaptionClass = '3,' + LocationArr[6, 1];
                            Caption = '6';
                            ShowCaption = false;
                        }
                        label("7")
                        {
                            CaptionClass = '3,' + LocationArr[7, 1];
                            Caption = '7';
                            ShowCaption = false;
                        }
                        label("8")
                        {
                            CaptionClass = '3,' + LocationArr[8, 1];
                            Caption = '8';
                            ShowCaption = false;
                        }
                        label("9")
                        {
                            CaptionClass = '3,' + LocationArr[9, 1];
                            Caption = '9';
                            ShowCaption = false;
                        }
                        label("10")
                        {
                            CaptionClass = '3,' + LocationArr[10, 1];
                            Caption = '10';
                            ShowCaption = false;
                        }
                    }

                    group("Payroll Cost (CM)")
                    {
                        Caption = 'Payroll Cost (CM)';
                        field(Control1000000012; LocationArr[1, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[1, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }


                        field(Control1000000013; LocationArr[2, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[2, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(Control1000000014; LocationArr[3, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[3, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(Control1000000015; LocationArr[4, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[4, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(Control1000000016; LocationArr[5, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[5, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(Control1000000017; LocationArr[6, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[6, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(Control1000000018; LocationArr[7, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[7, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(Control1000000019; LocationArr[8, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[8, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(Control1000000032; LocationArr[9, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[9, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                        field(Control1000000031; LocationArr[10, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[10, 1];
                                ShowBasicSalaries(Text1);
                            end;
                        }
                    }

                    group("Payroll Cost (YTD)")
                    {
                        Caption = 'Payroll Cost (YTD)';
                        field(Control1000000042; LocationArr[1, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[1, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(Control1000000041; LocationArr[2, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[2, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(Control1000000040; LocationArr[3, 3])
                        {

                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[3, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(Control1000000039; LocationArr[4, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[4, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(Control1000000038; LocationArr[5, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[5, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(Control1000000037; LocationArr[6, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[6, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(Control1000000036; LocationArr[7, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[7, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(Control1000000035; LocationArr[8, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[8, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(Control1000000034; LocationArr[9, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[9, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                        field(Control1000000033; LocationArr[10, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[10, 1];
                                ShowPayrollCostCalculation(Text1);
                            end;
                        }
                    }

                    group("Employees in Payroll")
                    {
                        Caption = 'Employees in Payroll';
                        field(Control1000000053; LocationArr[1, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[1, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(Control1000000052; LocationArr[2, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[2, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(Control1000000051; LocationArr[3, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[3, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(Control1000000050; LocationArr[4, 4])
                        {

                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[4, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(Control1000000049; LocationArr[5, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[5, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(Control1000000048; LocationArr[6, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[6, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(Control1000000047; LocationArr[7, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[7, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(Control1000000046; LocationArr[8, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[8, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(Control1000000045; LocationArr[9, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[9, 1];
                                ShowEmployeeInPayrollCalc(Text1);
                            end;
                        }
                        field(Control1000000044; LocationArr[10, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[10, 1];
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
        Lookup.SETRANGE(Lookup."LookupType Name", 'EMP LOCATION');
        IF Lookup.FINDSET THEN
            REPEAT

                // to calculate basic salaries:
                BasicSalaries := 0;
                Employee.RESET;
                Employee.SETRANGE(Resigned, FALSE);
                Employee.SETRANGE(Status, Employee.Status::Active);
                Employee.SETRANGE(Employee."Emp Location", Lookup."Lookup Name");
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
                Employee.SETRANGE(Employee."Emp Location", Lookup."Lookup Name");
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
                Employee.SETRANGE(Employee."Emp Location", Lookup."Lookup Name");
                Employee.SETRANGE(Employee.Status, Employee.Status::Active);
                Employee.SETRANGE(Employee.Blocked, FALSE);
                Employee.SETRANGE(Employee."Stop Payment", FALSE);
                IF Employee.FINDSET THEN
                    REPEAT
                        EmployeeinPayroll += 1;
                    UNTIL Employee.NEXT = 0;

                i += 1;
                LocationArr[i, 1] := FORMAT(0);
                LocationArr[i, 2] := FORMAT(0);
                LocationArr[i, 3] := FORMAT(0);
                LocationArr[i, 4] := FORMAT(0);

                LocationArr[i, 1] := Lookup.Description;
                LocationArr[i, 2] := FORMAT(BasicSalaries);
                LocationArr[i, 3] := FORMAT(PayrollCostYTD);
                LocationArr[i, 4] := FORMAT(EmployeeinPayroll);
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
        Lookup: Record 60018;
        i: Integer;
        Text1: Text[100];
        Lookup1: Record 60018;
        Lookup2: Record 60018;
        PayElement1: Record 60025;
        LocationArr: array[50, 4] of Text[100];

    //  [Scope('Internal')]
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
    procedure ShowPayrollCostCalculation(location: Text[100])
    begin
        CLEAR(ProcessedSalaryForm);
        ProcessedSalary.CLEARMARKS;
        Lookup1.RESET;
        Lookup1.SETRANGE(Lookup1."LookupType Name", 'EMP LOCATION');
        Lookup1.SETRANGE(Lookup1.Description, location);
        IF Lookup1.FINDFIRST THEN BEGIN

            PayRollYear.RESET;
            PayRollYear.SETRANGE(PayRollYear.Closed, FALSE);
            PayRollYear.SETFILTER(PayRollYear."Year Start Date", '<=%1', TODAY);
            IF PayRollYear.FINDFIRST THEN
                YearStartDate := PayRollYear."Year Start Date";

            Employee.RESET;
            Employee.SETRANGE(Employee."Emp Location", Lookup1."Lookup Name");
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
    procedure ShowEmployeeInPayrollCalc(location: Text[100])
    begin
        CLEAR(EmployeeListForm);
        Lookup.RESET;
        Lookup.SETRANGE(Lookup."LookupType Name", 'EMP LOCATION');
        Lookup.SETRANGE(Lookup.Description, location);
        IF Lookup.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE(Employee."Emp Location", Lookup."Lookup Name");
            Employee.SETRANGE(Employee.Status, Employee.Status::Active);
            Employee.SETRANGE(Employee.Blocked, FALSE);
            Employee.SETRANGE(Employee."Stop Payment", FALSE);
            EmployeeListForm.SETTABLEVIEW(Employee);
            EmployeeListForm.RUNMODAL;
        END;
    end;

    // [Scope('Internal')]
    procedure ShowBasicSalaries(location: Text[100])
    begin
        CLEAR(PayElementForm);

        PayElement1.RESET;

        Lookup2.RESET;
        Lookup2.SETRANGE("LookupType Name", 'EMP LOCATION');
        Lookup2.SETRANGE(Description, location);
        IF Lookup2.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE(Resigned, FALSE);
            Employee.SETRANGE(Status, Employee.Status::Active);
            Employee.SETRANGE(Employee."Emp Location", Lookup2."Lookup Name");
            IF Employee.FINDSET THEN BEGIN
                REPEAT
                    //MESSAGE('emp %1',Employee."No.");
                    PayElement1.MARKEDONLY(FALSE);
                    IF PayElement1.FINDSET THEN
                        REPEAT
                            //MESSAGE('payelement %1',PayElement1."Employee Code");
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

