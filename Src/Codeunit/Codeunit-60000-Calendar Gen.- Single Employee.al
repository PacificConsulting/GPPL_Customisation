codeunit 60000 "Calendar Gen.- Single Employee"
{
    TableNo = 60019;

    trigger OnRun()
    var
        Counter: Integer;
        Answer: Boolean;
    begin
        EmpNo := rec."No.";
        Answer := CheckValidations;
        IF Answer THEN BEGIN
            InsertTempCal;
            MESSAGE(Text003);
        END;

        TempCalendar.RESET;
        IF TempCalendar.FIND('-') THEN
            TempCalendar.DELETEALL;
    end;

    var
        Date: Record 2000000007;
        HRSetup: Record 60016;
        Employee: Record 60019;
        PayYear: Record 60020;
        TempCalendar: Record 60027;
        Window: Dialog;
        Text000: Label 'Creating Calendar\Status          @1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        Text001: Label 'No Holidays are defined for this leave year, Do you want to continue';
        Text002: Label 'Creating attendance records for ...\\Employee        #1########\Status          @2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        Text008: Label 'Generating monthly attendance records...\\Employee        #1########\Status          @2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        StartDate: Date;
        EndDate: Date;
        Text009: Label 'Update shift timings......\\Employee        #1########\Status          @2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        Text010: Label 'Verifications......\\Employee        #1########\Status          @2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        Text011: Label 'Lock the HR Setup Table';
        Text006: Label 'Shift must be define for the employee %1 to the date %2';
        Text003: Label 'Attendance Generated.';
        Text004: Label 'Attendance already exist for this leave year.';
        EmpNo: Code[20];
        StartMonth: Integer;
        StartYear: Integer;

    // [Scope('Internal')]
    procedure CheckValidations(): Boolean
    var
        Holiday: Record 60021;
        EmployeeShift: Record 60023;
        CheckDate: Date;
        Count2: Integer;
        Flag: Boolean;
        Answer: Boolean;
    begin
        IF HRSetup.FIND('-') THEN BEGIN
            IF NOT HRSetup.Locked THEN
                ERROR(Text011);
        END;

        Employee.RESET;
        Employee.SETRANGE("No.", EmpNo);
        IF Employee.FIND('-') THEN
            REPEAT
                Employee.TESTFIELD("Pay Cadre");
            UNTIL Employee.NEXT = 0;

        PayYear.SETRANGE("Year Type", 'LEAVE YEAR');
        PayYear.SETRANGE(Closed, FALSE);
        IF PayYear.FIND('-') THEN BEGIN
            StartDate := PayYear."Year Start Date";
            EndDate := PayYear."Year End Date";
        END;

        Employee.RESET;
        Employee.SETRANGE("No.", EmpNo);
        IF Employee.FIND('-') THEN
            REPEAT
                Flag := FALSE;
                IF Employee."Employment Date" <= StartDate THEN BEGIN
                    CheckDate := StartDate;
                    //CheckDate := Employee."Employment Date"
                END ELSE
                    IF (StartDate < Employee."Employment Date") AND (Employee."Employment Date" < EndDate) THEN BEGIN
                        CheckDate := Employee."Employment Date";
                    END;

                EmployeeShift.SETRANGE("Employee Code", Employee."No.");
                IF EmployeeShift.FIND('-') THEN
                    REPEAT
                        IF EmployeeShift."Start Date" <= CheckDate THEN
                            Flag := TRUE;
                    UNTIL EmployeeShift.NEXT = 0;
                IF NOT Flag THEN
                    ERROR(Text006, Employee."No.", CheckDate);
            UNTIL Employee.NEXT = 0;


        IF Holiday.FIND('-') THEN
            REPEAT
                IF (StartDate <= Holiday.Date) AND (EndDate >= Holiday.Date) THEN
                    Count2 := Count2 + 1
                ELSE
                    Count2 := 0
            UNTIL Holiday.NEXT = 0;

        IF Count2 = 0 THEN BEGIN
            Answer := DIALOG.CONFIRM(Text001, TRUE);
            EXIT(Answer);
        END ELSE
            EXIT(TRUE);
    end;

    // [Scope('Internal')]
    procedure InsertTempCal()
    var
        Counter: Integer;
    begin
        PayYear.SETRANGE("Year Type", 'LEAVE YEAR');
        PayYear.SETRANGE(Closed, FALSE);
        IF PayYear.FIND('-') THEN BEGIN
            StartDate := PayYear."Year Start Date";
            EndDate := PayYear."Year End Date";
        END;

        Window.OPEN(Text000);
        Date.SETFILTER("Period Type", 'Date');
        Date.SETFILTER(Date."Period Start", '>=%1 & <= %2', StartDate, EndDate);
        IF Date.FIND('-') THEN BEGIN
            Counter := 0;
            REPEAT
                Counter := Counter + 1;
                TempCalendar.INIT;
                TempCalendar.Date := Date."Period Start";
                TempCalendar.Description := Date."Period Name";
                TempCalendar."Day No." := Date."Period No.";
                TempCalendar.INSERT;
                Window.UPDATE(1, ROUND(Counter / TempCalendar.COUNT * 10000, 1));
            UNTIL Date.NEXT = 0;
        END;
        NonWorking;
    end;

    //  [Scope('Internal')]
    procedure NonWorking()
    var
        Holiday: Record 60021;
        Weeklyoff: Record 60006;
    begin
        TempCalendar.RESET;
        IF TempCalendar.FIND('-') THEN
            REPEAT
                IF Holiday.FIND('-') THEN
                    REPEAT
                        IF TempCalendar.Date = Holiday.Date THEN BEGIN
                            TempCalendar."Non-Working" := TRUE;
                            TempCalendar.Holiday := 1;
                            TempCalendar.MODIFY;
                        END;
                    UNTIL Holiday.NEXT = 0;
            UNTIL TempCalendar.NEXT = 0;

        TempCalendar.RESET;
        IF TempCalendar.FIND('-') THEN
            REPEAT
                IF Weeklyoff.FIND('-') THEN
                    REPEAT
                        IF TempCalendar."Day No." = Weeklyoff."Day No." THEN BEGIN
                            TempCalendar."Non-Working" := TRUE;
                            TempCalendar.WeeklyOff := 1;
                            TempCalendar.MODIFY;
                        END;
                    UNTIL Weeklyoff.NEXT = 0;
            UNTIL TempCalendar.NEXT = 0;
        Window.CLOSE;

        DailyAttendanceRec;
    end;

    //  [Scope('Internal')]
    procedure DailyAttendanceRec()
    var
        DailyAttendance: Record 60028;
        TempCalendar: Record 60027;
        StartDate2: Date;
        CheckDate: Date;
        TestDate: Date;
        CheckDay: Integer;
        CheckMonth: Integer;
        CheckYear: Integer;
        Counter: Integer;
    begin
        Employee.RESET;
        Employee.SETRANGE("No.", EmpNo);
        IF Employee.FIND('-') THEN BEGIN
            Window.OPEN(Text002);
            Counter := 0;
            REPEAT
                IF Employee."Employment Date" <= StartDate THEN BEGIN
                    StartDate2 := StartDate;
                    TestDate := StartDate;
                END ELSE
                    IF (StartDate < Employee."Employment Date") AND (Employee."Employment Date" <= EndDate) THEN BEGIN
                        StartDate2 := Employee."Employment Date";

                        CheckDay := DATE2DMY(Employee."Period Start Date", 1);
                        CheckMonth := DATE2DMY(StartDate2, 2);
                        CheckYear := DATE2DMY(StartDate2, 3);
                        CheckDate := DMY2DATE(CheckDay, CheckMonth, CheckYear);
                        TestDate := CheckDate;

                        DailyAttendance.RESET;
                        DailyAttendance.SETRANGE("Employee No.", Employee."No.");
                        DailyAttendance.SETFILTER(Date, '=%1 | = %2', TestDate, EndDate);
                        IF NOT DailyAttendance.FIND('-') THEN BEGIN
                            WHILE (CheckDate > StartDate2) DO BEGIN
                                IF CheckMonth <> 1 THEN
                                    CheckMonth := CheckMonth - 1
                                ELSE BEGIN
                                    CheckMonth := 12;
                                    CheckYear := CheckYear - 1;
                                END;
                                CheckDate := DMY2DATE(CheckDay, CheckMonth, CheckYear);
                            END;

                            TempCalendar.SETFILTER(Date, '%1..%2', CheckDate, (StartDate2 - 1));
                            IF TempCalendar.FIND('-') THEN BEGIN
                                REPEAT
                                    DailyAttendance.INIT;
                                    DailyAttendance."Employee No." := Employee."No.";
                                    DailyAttendance."Employee Name" := Employee."First Name";
                                    DailyAttendance.PayCadre := Employee."Pay Cadre";
                                    DailyAttendance.Date := TempCalendar.Date;
                                    DailyAttendance."Day No." := TempCalendar."Day No.";
                                    DailyAttendance.Month := DATE2DMY(DailyAttendance.Date, 2);
                                    DailyAttendance."Not Joined" := 1;
                                    DailyAttendance.INSERT;
                                UNTIL TempCalendar.NEXT = 0;
                            END;
                        END;
                    END;

                DailyAttendance.RESET;
                DailyAttendance.SETRANGE("Employee No.", Employee."No.");
                DailyAttendance.SETFILTER(Date, '=%1 | = %2', StartDate2, EndDate);
                IF NOT DailyAttendance.FIND('-') THEN BEGIN
                    Counter := Counter + 1;
                    Window.UPDATE(1, Employee."No.");
                    InsertDailyAttendance(Employee, StartDate2);

                    //VE-003 >>
                    /*
                    InsertMonthlyAttendance(Employee,
                    DMY2DATE(DATE2DMY(Employee."Period Start Date",1),DATE2DMY(StartDate2,2),DATE2DMY(StartDate2,3)),
                    CALCDATE('-1D',CALCDATE('+1M',
                    DMY2DATE(DATE2DMY(Employee."Period Start Date",1),DATE2DMY(StartDate2,2),DATE2DMY(StartDate2,3)))));//
                    */
                    InsertMonthlyAttendance(Employee, Employee."Period Start Date", Employee."Period End Date");
                    //VE-003 <<
                    UpdateShiftTimings(Employee);
                    Window.UPDATE(2, ROUND(Counter / Employee.COUNT * 10000, 1));
                    Employee."Attendance Not Generated" := FALSE;
                    Employee.MODIFY;
                END ELSE
                    ERROR(Text004);
            UNTIL Employee.NEXT = 0;
            Window.CLOSE;
        END;

        Employee.RESET;
        Employee.SETRANGE("No.", EmpNo);
        IF Employee.FIND('-') THEN BEGIN
            Window.OPEN(Text010);
            Counter := 0;
            REPEAT
                Counter := Counter + 1;
                Window.UPDATE(1, Employee."No.");
                ModifyMonth(Employee."Period Start Date", Employee."Period End Date");
                //MOdifyAttendanceMonth.ModifyMonth(Employee."No.");
                Window.UPDATE(2, ROUND(Counter / Employee.COUNT * 10000, 1));
            UNTIL Employee.NEXT = 0;
            UpdateDailyAtt; //VE-003

            Window.CLOSE;


        END;

    end;

    //  [Scope('Internal')]
    procedure InsertDailyAttendance(Employee: Record 60019; StartDate: Date)
    var
        DailyAttendance: Record 60028;
        TempCalendar: Record 60027;
    begin
        HRSetup.RESET;
        IF HRSetup.FIND('-') THEN;


        TempCalendar.SETFILTER(Date, '>=%1 & <= %2', StartDate, EndDate);
        IF TempCalendar.FIND('-') THEN
            REPEAT
                DailyAttendance.INIT;
                DailyAttendance."Employee No." := Employee."No.";
                DailyAttendance.Date := TempCalendar.Date;
                DailyAttendance."Non-Working" := TempCalendar."Non-Working";
                DailyAttendance.WeeklyOff := TempCalendar.WeeklyOff;
                DailyAttendance.Holiday := TempCalendar.Holiday;
                DailyAttendance.Year := DATE2DMY(DailyAttendance.Date, 3);
                DailyAttendance.Month := DATE2DMY(DailyAttendance.Date, 2);
                DailyAttendance."Employee Name" := Employee."First Name";
                DailyAttendance.PayCadre := Employee."Pay Cadre";
                DailyAttendance."Attendance Type" := HRSetup."Default Attendance Type";
                IF DailyAttendance."Attendance Type" = DailyAttendance."Attendance Type"::Present THEN
                    DailyAttendance.Present := 1
                ELSE
                    IF DailyAttendance."Attendance Type" = DailyAttendance."Attendance Type"::Absent THEN
                        DailyAttendance.Absent := 1;

                DailyAttendance.INSERT;
            UNTIL TempCalendar.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure InsertMonthlyAttendance(Employee: Record 60019; PeriodStartDate: Date; PeriodEndDate: Date)
    var
        TempCalendar: Record 60027;
        MonthlyAttendance: Record 60029;
        DailyAttendance: Record 60028;
        StartMonth: Integer;
        EndMonth: Integer;
    begin
        StartMonth := DATE2DMY(PeriodStartDate, 2);
        REPEAT
            DailyAttendance.SETFILTER(Date, '%1..%2', PeriodStartDate, PeriodEndDate);
            DailyAttendance.SETRANGE("Employee No.", Employee."No.");
            IF DailyAttendance.FIND('-') THEN BEGIN
                MonthlyAttendance.INIT;
                MonthlyAttendance."Employee Code" := Employee."No.";
                MonthlyAttendance."Employee Name" := Employee."First Name";
                MonthlyAttendance.PayCadre := Employee."Pay Cadre";
                MonthlyAttendance."Post to GL" := Employee."Post to GL";   //EBT Paramita
                MonthlyAttendance."Period Start Date" := PeriodStartDate;
                MonthlyAttendance."Period End Date" := PeriodEndDate;
                MonthlyAttendance."Pay Slip Month" := DATE2DMY(MonthlyAttendance."Period End Date", 2);
                MonthlyAttendance.Year := DATE2DMY(MonthlyAttendance."Period End Date", 3);
                MonthlyAttendance.INSERT;
                //   InsertDimensions(MonthlyAttendance);
            END;
            PeriodStartDate := PeriodEndDate + 1;
            PeriodEndDate := (CALCDATE('1M', PeriodStartDate) - 1);
            EndMonth := DATE2DMY(PeriodStartDate, 2);
        UNTIL StartMonth = EndMonth;
    end;

    //  [Scope('Internal')]
    procedure UpdateShiftTimings(Employee: Record 60019)
    var
        DailyAttendance: Record 60028;
        EmployeeShift: Record 60023;
        StartDate: Date;
        EndDate: Date;
        StartTime: Time;
        EndTime: Time;
        CheckTime: Time;
        StartDateTime: DateTime;
        EndDateTime: DateTime;
    begin
        CheckTime := 130000T;
        EmployeeShift.SETRANGE("Employee Code", Employee."No.");
        IF EmployeeShift.FIND('-') THEN
            REPEAT
                StartTime := EmployeeShift."Shift Start Time";
                EndTime := EmployeeShift."Shift End Time";

                StartDate := EmployeeShift."Start Date";
                IF EmployeeShift.NEXT <> 0 THEN BEGIN
                    EndDate := EmployeeShift."Start Date" - 1;
                    EmployeeShift.NEXT(-1);
                END ELSE BEGIN
                    PayYear.SETRANGE("Year Type", 'LEAVE YEAR');
                    PayYear.SETRANGE(Closed, FALSE);
                    IF PayYear.FIND('-') THEN
                        EndDate := PayYear."Year End Date";
                END;
                DailyAttendance.SETRANGE("Employee No.", Employee."No.");
                DailyAttendance.SETFILTER(Date, '%1..%2', StartDate, EndDate);
                IF DailyAttendance.FIND('-') THEN BEGIN
                    REPEAT
                        DailyAttendance."Time In" := StartTime;
                        DailyAttendance."Time Out" := EndTime;
                        DailyAttendance."Break Duration" := EmployeeShift."Break Duration";
                        IF (StartTime > CheckTime) AND (EndTime < CheckTime) THEN BEGIN
                            StartDateTime := CREATEDATETIME(DailyAttendance.Date, DailyAttendance."Time In");
                            EndDateTime := CREATEDATETIME((DailyAttendance.Date + 1), DailyAttendance."Time Out");
                            DailyAttendance."Hours Worked" := ABS((StartDateTime - EndDateTime) / 3600000) - EmployeeShift."Break Duration";
                        END ELSE
                            DailyAttendance."Hours Worked" :=
                              ABS((DailyAttendance."Time In" - DailyAttendance."Time Out") / 3600000) -
                              EmployeeShift."Break Duration";
                        DailyAttendance."Actual Time In" := StartTime;
                        DailyAttendance."Actual Time Out" := EndTime;
                        IF (StartTime > CheckTime) AND (EndTime < CheckTime) THEN BEGIN
                            StartDateTime := CREATEDATETIME(DailyAttendance.Date, DailyAttendance."Actual Time In");
                            EndDateTime := CREATEDATETIME((DailyAttendance.Date + 1), DailyAttendance."Actual Time Out");
                            DailyAttendance."Actual Hrs" := ABS((StartDateTime - EndDateTime) / 3600000) - EmployeeShift."Break Duration";
                        END ELSE
                            DailyAttendance."Actual Hrs" :=
                              ABS((DailyAttendance."Actual Time In" - DailyAttendance."Actual Time Out") / 3600000) -
                              EmployeeShift."Break Duration";
                        DailyAttendance.MODIFY;
                    UNTIL DailyAttendance.NEXT = 0;
                END;
            UNTIL EmployeeShift.NEXT = 0;
    end;

    //  [Scope('Internal')]
    procedure ModifyMonth(PeriodStartDate: Date; PeriodEndDate: Date)
    var
        DailyAttendance: Record 60028;
        DailyAttendance2: Record 60028;
        StartDay: Integer;
        StartMonth: Integer;
        EndMonth: Integer;
        StartYear: Integer;
        Endyear: Integer;
        EndDate: Date;
        DailyAttendance3: Record 60028;
    begin

        PayYear.SETRANGE("Year Type", 'LEAVE YEAR');
        PayYear.SETRANGE(Closed, FALSE);
        IF PayYear.FIND('-') THEN BEGIN
            StartDate := PayYear."Year Start Date";
            EndDate := PayYear."Year End Date";
            Endyear := DATE2DMY(EndDate, 3);
        END;

        StartDay := DATE2DMY(PeriodStartDate, 1);
        StartMonth := DATE2DMY(StartDate, 2);
        StartYear := DATE2DMY(StartDate, 3);
        StartDate := DMY2DATE(StartDay, StartMonth, StartYear);
        PeriodStartDate := StartDate;
        PeriodEndDate := (CALCDATE('1M', PeriodStartDate) - 1);
        REPEAT
            DailyAttendance.SETFILTER(Date, '%1..%2', PeriodStartDate, PeriodEndDate);
            DailyAttendance.SETRANGE("Employee No.", Employee."No.");
            IF DailyAttendance.FIND('-') THEN
                REPEAT
                    DailyAttendance.Month := DATE2DMY(PeriodEndDate, 2);
                    DailyAttendance.Year := DATE2DMY(PeriodEndDate, 3);
                    DailyAttendance.MODIFY;
                UNTIL DailyAttendance.NEXT = 0;
            PeriodStartDate := PeriodEndDate + 1;
            PeriodEndDate := (CALCDATE('1M', PeriodStartDate) - 1);
            EndMonth := DATE2DMY(PeriodStartDate, 2);
        UNTIL StartMonth = EndMonth;

        DailyAttendance.RESET;
        DailyAttendance.SETRANGE("Employee No.", Employee."No.");
        DailyAttendance.SETRANGE(Year, Endyear + 1);
        IF DailyAttendance.FIND('-') THEN
            REPEAT
                DailyAttendance2.INIT;
                DailyAttendance2.TRANSFERFIELDS(DailyAttendance);
                DailyAttendance2.Year := Endyear;
                DailyAttendance2.Date := CALCDATE('-1Y', DailyAttendance.Date);
                IF NOT DailyAttendance3.GET(DailyAttendance2."Employee No.", DailyAttendance2.Date) THEN
                    DailyAttendance2.INSERT;
                DailyAttendance.DELETE;
            UNTIL DailyAttendance.NEXT = 0;


        /*//Future use
        DailyAttendance.RESET;
        DailyAttendance.SETRANGE("Employee No.",Employee."No.");
        IF DailyAttendance.FIND('+') THEN
          EndDate := DailyAttendance.Date;
        
        DailyAttendance.RESET;
        DailyAttendance.SETRANGE("Employee No.",Employee."No.");
        DailyAttendance.SETFILTER(Date,'%1..%2',PeriodStartDate,EndDate);
        IF DailyAttendance.FIND('-') THEN
          REPEAT
            DailyAttendance.Month := DATE2DMY(PeriodEndDate,2);
            DailyAttendance.Year := DATE2DMY(EndDate,3);
            DailyAttendance.MODIFY;
          UNTIL DailyAttendance.NEXT = 0;
        */

    end;

    // [Scope('Internal')]
    procedure InsertDimensions(MonAttendance: Record 60029)
    var
        DefaultDim: Record 352;
        MonAttendDim: Record 60055;
    begin
        DefaultDim.SETRANGE("No.", MonAttendance."Employee Code");
        IF DefaultDim.FIND('-') THEN
            REPEAT
                MonAttendDim.INIT;
                MonAttendDim."Employee Code" := DefaultDim."No.";
                MonAttendDim.Month := MonAttendance."Pay Slip Month";
                MonAttendDim.Year := MonAttendance.Year;
                MonAttendDim."Mon Line No." := MonAttendance."Line No.";
                MonAttendDim."Dimension Code" := DefaultDim."Dimension Code";
                MonAttendDim."Dimension Value Code" := DefaultDim."Dimension Value Code";
                MonAttendDim.INSERT;
            UNTIL DefaultDim.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure UpdateDailyAtt()
    var
        DailyAtt1: Record 60028;
        Empl: Record 60019;
    begin
        DailyAtt1.RESET;
        DailyAtt1.SETRANGE("Employee No.", EmpNo);
        IF Empl.GET(EmpNo) THEN;
        DailyAtt1.SETFILTER(Date, '<%1', Empl."Employment Date");
        IF DailyAtt1.FIND('-') THEN
            DailyAtt1.DELETEALL;
    end;
}

