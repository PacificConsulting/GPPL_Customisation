table 60023 "Employee Shift"
{
    DrillDownPageID = 60012;
    LookupPageID = 60012;

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            TableRelation = Employee_;

            trigger OnValidate()
            begin
                Employee.GET("Employee Code");
                "Employee Name" := Employee."First Name";
            end;
        }
        field(2; "Start Date"; Date)
        {

            trigger OnValidate()
            begin
                Employee.SETRANGE("No.", "Employee Code");
                IF Employee.FIND('-') THEN BEGIN
                    IF "Start Date" < Employee."Employment Date" THEN
                        ERROR(Text000);
                END;
            end;
        }
        field(3; "Shift Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Shift Master";

            trigger OnValidate()
            begin
                TESTFIELD("Start Date");
                IF ShiftMaster.GET("Shift Code") THEN BEGIN
                    "Shift Start Time" := ShiftMaster."Starting Time";
                    "Shift End Time" := ShiftMaster."Ending Time";
                    "Break Duration" := ShiftMaster."Break Duration";
                END;
            end;
        }
        field(4; "Employee Name"; Text[50])
        {
        }
        field(5; "Shift Start Time"; Time)
        {
        }
        field(6; "Shift End Time"; Time)
        {
        }
        field(7; "Break Duration"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Start Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'Shift start date should be greater than employement date.';
        Text001: Label 'Shift timings updated.';
        Text002: Label 'Please enter the start date.';
        Text003: Label 'Attendance Records are not generated.';
        Employee: Record 60019;
        ShiftMaster: Record 60022;

    // [Scope('Internal')]
    procedure UpdateShiftTimings()
    var
        DailyAttendance: Record 60028;
        EmployeeShift: Record 60023;
        Payyear: Record 60020;
        EndDate: Date;
        StartDate: Date;
        StartTime: Time;
        EndTime: Time;
        CheckTime: Time;
        StartDateTime: DateTime;
        EndDateTime: DateTime;
    begin
        CheckTime := 130000T;
        EmployeeShift.SETRANGE("Employee Code", "Employee Code");
        IF EmployeeShift.FIND('-') THEN
            REPEAT
                StartTime := EmployeeShift."Shift Start Time";
                EndTime := EmployeeShift."Shift End Time";
                StartDate := EmployeeShift."Start Date";
                IF EmployeeShift.NEXT <> 0 THEN BEGIN
                    EndDate := EmployeeShift."Start Date" - 1;
                    EmployeeShift.NEXT(-1);
                END ELSE BEGIN
                    Payyear.SETRANGE("Year Type", 'LEAVE YEAR');
                    Payyear.SETRANGE(Closed, FALSE);
                    IF Payyear.FIND('-') THEN
                        EndDate := Payyear."Year End Date";
                END;

                DailyAttendance.SETRANGE("Employee No.", "Employee Code");
                DailyAttendance.SETFILTER(Date, '%1..%2', StartDate, EndDate);
                IF DailyAttendance.FIND('-') THEN BEGIN
                    REPEAT
                        DailyAttendance."Time In" := StartTime;
                        DailyAttendance."Time Out" := EndTime;
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
}

