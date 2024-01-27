table 60035 "Other PayElements"
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
                    Type := PayDeduct.Type;
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
        field(10; Quantity; Decimal)
        {
        }
        field(11; Type; Option)
        {
            OptionCaption = ' ,Canteen,Holiday Compensation,OT,LED,Others';
            OptionMembers = " ",Canteen,"Holiday Compensation",OT,LED,Others;
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

    var
        HRSetup: Record 60016;
        Employee: Record 60019;
        PayDeduct: Record 60034;
        Monattendance: Record 60029;
        NoofDays: Decimal;
        Mon: Integer;
        Year: Integer;
        EndDate: Date;


    procedure UpdateProcSalary(OtherDeduct: Record 60035)
    var
        MonAttendance: Record 60029;
        TempProcSalary: Record 60037;
        PostedOtherDeductions: Record 60036;
        Attendance: Decimal;
        Days: Decimal;
    begin
        MonAttendance.SETRANGE("Employee Code", OtherDeduct."Employee No.");
        MonAttendance.SETRANGE("Pay Slip Month", OtherDeduct.Month);
        //MonAttendance.SETRANGE(Year,OtherDeduct.Year);
        IF MonAttendance.FIND('-') THEN BEGIN
            Attendance := MonAttendance.Attendance;
            Days := MonAttendance.Days;
        END;

        //VE-003 >>

        TempProcSalary.INIT;
        TempProcSalary.RESET;
        TempProcSalary.SETRANGE("Employee Code", OtherDeduct."Employee No.");
        TempProcSalary.SETRANGE("Pay Slip Month", OtherDeduct.Month);
        TempProcSalary.SETRANGE(Year, OtherDeduct.Year);
        TempProcSalary.SETRANGE("Add/Deduct Code", OtherDeduct."Pay Element Code");
        IF TempProcSalary.FIND('-') THEN
            TempProcSalary.DELETE;

        //VE-003<<


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
        TempProcSalary.Attendance := Attendance;
        TempProcSalary.Days := Days;
        TempProcSalary.INSERT;

        //VE-003 >>

        PostedOtherDeductions.INIT;
        PostedOtherDeductions.RESET;
        PostedOtherDeductions.SETRANGE("Employee No.", OtherDeduct."Employee No.");
        PostedOtherDeductions.SETRANGE(Month, OtherDeduct.Month);
        PostedOtherDeductions.SETRANGE(Year, OtherDeduct.Year);
        PostedOtherDeductions.SETRANGE("Pay Element Code", OtherDeduct."Pay Element Code");
        IF PostedOtherDeductions.FIND('-') THEN
            PostedOtherDeductions.DELETE;

        //VE-003 <<

        PostedOtherDeductions.INIT;
        PostedOtherDeductions.TRANSFERFIELDS(OtherDeduct);
        PostedOtherDeductions.INSERT;
    end;


    procedure CanteenAmount(OtherPayElement: Record 60035)
    var
        Employee: Record 60019;
        Lookup: Record 60018;
        Rate: Decimal;
    begin
        Employee.SETRANGE("No.", OtherPayElement."Employee No.");
        IF Employee.FIND('-') THEN BEGIN
            Lookup.SETRANGE("LookupType Name", 'PAY CADRE');
            //Lookup.SETRANGE("Lookup Name",Employee."Pay Cadre");
            IF Lookup.FIND('-') THEN
                Rate := Lookup."Per Meal Rate";
        END;
        OtherPayElement.Amount := Rate * OtherPayElement.Quantity;
        OtherPayElement.MODIFY;
    end;


    procedure HolidayCompensation(OtherPayElements: Record 60035)
    var
        lookup: Record 60018;
        PayElements: Record 60025;
        CheckDate: Date;
        TotalAmount: Decimal;
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        Days: Decimal;
    begin
        CheckDate := DMY2DATE(1, OtherPayElements.Month, OtherPayElements.Year);
        lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
        lookup.SETRANGE("Holiday Compensation", TRUE);
        IF lookup.FIND('-') THEN
            REPEAT
                PayElements.SETRANGE("Employee Code", OtherPayElements."Employee No.");
                PayElements.SETRANGE("Pay Element Code", lookup."Lookup Name");
                PayElements.SETFILTER("Effective Start Date", '<%1', CheckDate);
                IF PayElements.FIND('+') THEN BEGIN
                    IF PayElements."Pay Element Code" = 'BASIC' THEN BEGIN
                        Total := PayElements."Amount / Percent";
                        Basic := Total;
                    END ELSE BEGIN
                        IF (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Fixed) THEN BEGIN
                            Total := PayElements."Amount / Percent";
                        END ELSE
                            IF (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Percent) AND
                               (PayElements."Computation Type" = 'AFTER BASIC')
                   THEN
                                Total := (PayElements."Amount / Percent" * Basic) / 100
                            ELSE
                                IF (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Percent) AND
                                   (PayElements."Computation Type" = 'AFTER BASIC AND DA')
                           THEN
                                    Total := (PayElements."Amount / Percent" * (Basic + DA)) / 100;
                    END;
                    IF PayElements."Pay Element Code" = 'DA' THEN
                        DA := Total;

                    IF PayElements."Add/Deduct" = PayElements."Add/Deduct"::Addition THEN
                        TotalAmount := TotalAmount + Total
                    ELSE
                        TotalAmount := TotalAmount - Total;
                END;
            UNTIL lookup.NEXT = 0;


        Days := MonthDays(OtherPayElements.Month);
        OtherPayElements.Amount := (TotalAmount * OtherPayElements.Quantity) / Days;
        OtherPayElements.MODIFY;
    end;


    procedure MonthDays(MonthNum: Integer): Integer
    begin
        IF (MonthNum = 1) OR (MonthNum = 3) OR (MonthNum = 5) OR (MonthNum = 7) OR (MonthNum = 8) OR (MonthNum = 10) OR (MonthNum = 12)
        THEN
            EXIT(31)
        ELSE
            IF MonthNum = 2 THEN
                EXIT(28)
            ELSE
                EXIT(30);
    end;


    procedure OTcalc(OtherPayElements: Record 60035)
    var
        lookup: Record 60018;
        PayElements: Record 60025;
        EmpShift: Record 60023;
        CheckDate: Date;
        TotalAmount: Decimal;
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        Days: Decimal;
        HoursPerDay: Decimal;
        Otrate: Decimal;
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        CheckTime: Time;
    begin
        //23-May-06

        CheckDate := DMY2DATE(1, OtherPayElements.Month, OtherPayElements.Year);
        EmpShift.SETRANGE("Employee Code", OtherPayElements."Employee No.");
        EmpShift.SETFILTER("Start Date", '<=%1', CheckDate);
        IF EmpShift.FIND('+') THEN
            CheckTime := 130000T;
        IF EmpShift."Shift End Time" <> 0T THEN
            IF (EmpShift."Shift Start Time" > CheckTime) AND (EmpShift."Shift End Time" < CheckTime) THEN BEGIN
                StartDateTime := CREATEDATETIME(EmpShift."Start Date", EmpShift."Shift Start Time");
                EndDateTime := CREATEDATETIME((EmpShift."Start Date" + 1), EmpShift."Shift End Time");
                HoursPerDay := ABS(((StartDateTime - EndDateTime) / 3600000)) - EmpShift."Break Duration";
            END ELSE
                HoursPerDay := ABS(((EmpShift."Shift Start Time" - EmpShift."Shift End Time") / 3600000)) - EmpShift."Break Duration";


        MESSAGE('Hrs per Day %1', HoursPerDay);

        Employee.RESET;
        Employee.SETRANGE("No.", OtherPayElements."Employee No.");
        //Employee.SETRANGE("OT Applicable",TRUE);
        //IF Employee.FIND('-') THEN
        // Otrate := Employee."OT Calculation Rate";

        MESSAGE('Ot rate %1', Otrate);

        lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
        lookup.SETRANGE("Applicable for OT", TRUE);
        IF lookup.FIND('-') THEN
            REPEAT
                PayElements.SETRANGE("Employee Code", OtherPayElements."Employee No.");
                PayElements.SETRANGE("Pay Element Code", lookup."Lookup Name");
                //PayElements.SETRANGE("Applicable for OT",TRUE);
                PayElements.SETFILTER("Effective Start Date", '<%1', CheckDate);
                IF PayElements.FIND('+') THEN BEGIN
                    IF PayElements."Pay Element Code" = 'BASIC' THEN BEGIN
                        Total := PayElements."Amount / Percent";
                        Basic := Total;
                    END ELSE BEGIN
                        IF (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Fixed) THEN BEGIN
                            Total := PayElements."Amount / Percent";
                        END ELSE
                            IF (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Percent) AND
                               (PayElements."Computation Type" = 'AFTER BASIC')
                   THEN
                                Total := (PayElements."Amount / Percent" * Basic) / 100
                            ELSE
                                IF (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Percent) AND
                                   (PayElements."Computation Type" = 'AFTER BASIC AND DA')
                           THEN
                                    Total := (PayElements."Amount / Percent" * (Basic + DA)) / 100;
                    END;
                    IF PayElements."Pay Element Code" = 'DA' THEN
                        DA := Total;

                    IF PayElements."Add/Deduct" = PayElements."Add/Deduct"::Addition THEN
                        TotalAmount := TotalAmount + Total
                    ELSE
                        TotalAmount := TotalAmount - Total;
                END;
            UNTIL lookup.NEXT = 0;
        MESSAGE('%1', TotalAmount);
        Days := MonthDays(OtherPayElements.Month);
        OtherPayElements.Amount := (TotalAmount * OtherPayElements.Quantity * Otrate) / (Days * HoursPerDay);
        MESSAGE('OTAmount %1', OtherPayElements.Amount);
        OtherPayElements.MODIFY;
    end;
}

