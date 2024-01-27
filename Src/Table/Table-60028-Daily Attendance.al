table 60028 "Daily Attendance"
{
    DrillDownPageID = 60017;
    LookupPageID = 60017;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Time In"; Time)
        {

            trigger OnValidate()
            begin
                CheckTime := 130000T;
                IF "Time Out" <> 0T THEN
                    IF ("Time In" > CheckTime) AND ("Time Out" < CheckTime) THEN BEGIN
                        StartDateTime := CREATEDATETIME(Date, "Time In");
                        EndDateTime := CREATEDATETIME((Date + 1), "Time Out");
                        "Hours Worked" := ABS(((StartDateTime - EndDateTime) / 3600000)) - "Break Duration";
                    END ELSE
                        "Hours Worked" := ABS((("Time In" - "Time Out") / 3600000)) - "Break Duration";

                IF "Hours Worked" > "Actual Hrs" THEN BEGIN
                    "OT Hrs" := "Hours Worked" - "Actual Hrs";
                    "OT Approved Hrs" := "OT Hrs";
                END ELSE BEGIN
                    "OT Hrs" := 0;
                    "OT Approved Hrs" := "OT Hrs";
                END;

                HRSetup.GET;
                IF HRSetup."Late Entry Ded. Allowed" THEN BEGIN
                    IF NOT ("Non-Working") THEN BEGIN
                        IF "Time In" > HRSetup."Start Time with Grace Period" THEN
                            IF NOT "Non-Working" THEN BEGIN
                                LateEntryFromTimeIn := TRUE;
                                MODIFY;
                                VALIDATE("Late Hours", ("Time In" - HRSetup."Start Time with Grace Period"))
                            END ELSE
                                ERROR('This is Not Working Day')
                        ELSE BEGIN
                            LateEntryFromTimeIn := TRUE;
                            MODIFY;
                            VALIDATE("Late Hours", 0);
                        END;
                        Modified := TRUE;
                        MODIFY;
                    END ELSE
                        ERROR('%1 is Non-working Day', Date);
                END;
            end;
        }
        field(4; "Time Out"; Time)
        {

            trigger OnValidate()
            begin
                CheckTime := 130000T;
                IF "Time Out" <> 0T THEN
                    IF ("Time In" > CheckTime) AND ("Time Out" < CheckTime) THEN BEGIN
                        StartDateTime := CREATEDATETIME(Date, "Time In");
                        EndDateTime := CREATEDATETIME((Date + 1), "Time Out");
                        "Hours Worked" := ABS(((StartDateTime - EndDateTime) / 3600000)) - "Break Duration";
                    END ELSE
                        "Hours Worked" := ABS((("Time In" - "Time Out") / 3600000)) - "Break Duration";

                IF "Hours Worked" > "Actual Hrs" THEN BEGIN
                    "OT Hrs" := "Hours Worked" - "Actual Hrs";
                    "OT Approved Hrs" := "OT Hrs";
                END ELSE BEGIN
                    "OT Hrs" := 0;
                    "OT Approved Hrs" := "OT Hrs";
                END;
            end;
        }
        field(5; "Hours Worked"; Decimal)
        {
        }
        field(6; "Shift No."; Code[10])
        {
        }
        field(7; "Non-Working"; Boolean)
        {

            trigger OnValidate()
            begin
                IF "Non-Working" = TRUE THEN
                    "Attendance Type" := 0
            end;
        }
        field(8; "Non-Working Type"; Option)
        {
            OptionMembers = " ",Holiday,OffDay;
        }
        field(9; "Attendance Type"; Option)
        {
            OptionMembers = " ",Present,Absent,"Half Day","Full Day";
            ValuesAllowed = " ", Present, "Half Day", "Full Day";

            trigger OnValidate()
            begin
                /*
                Emp2.INIT;
                Emp2.SETRANGE("No.","Employee No.");
                Emp2.SETRANGE(Resigned,TRUE);
                IF NOT Emp2.FIND('-') THEN
                BEGIN
                IF "Non-Working"=TRUE THEN BEGIN
                  IF "Attendance Type" <> 0 THEN
                    ERROR(Text000);
                END;
                END ELSE
                res1:=TRUE;
                */
                CASE "Attendance Type" OF
                    "Attendance Type"::Present:
                        BEGIN
                            "Leave Code" := '';
                            Present := 1;
                            Absent := 0;
                            Leave := 0;
                            "Loss Of Pay" := FALSE;
                        END;
                    "Attendance Type"::Absent:
                        BEGIN
                            Present := 0;
                            Leave := 1;
                            Absent := 1;
                        END;
                    "Attendance Type"::"Half Day":
                        BEGIN
                            TESTFIELD("Leave Code");
                            Leave := 0.5;
                            Present := 0.5;
                            Absent := 0;
                        END;
                    "Attendance Type"::"Full Day":
                        BEGIN
                            IF NOT res1 THEN
                                TESTFIELD("Leave Code");

                            Present := 0;
                            Leave := 1;
                            Absent := 0;
                        END;

                END;

            end;
        }
        field(10; "Day No."; Integer)
        {
        }
        field(11; WeeklyOff; Decimal)
        {
        }
        field(12; Holiday; Decimal)
        {
        }
        field(13; Year; Integer)
        {
        }
        field(14; Month; Integer)
        {
            //ValuesAllowed = 1,2,3,4;5;6;7;8;9;10;11;12;
        }
        field(15; "Employee Name"; Text[50])
        {
        }
        field(16; "Leave Code"; Code[20])
        {
            TableRelation = "Leave Master"."Leave Code";

            trigger OnValidate()
            begin
                Emp2.RESET;
                Emp2.SETRANGE("No.", "Employee No.");
                Emp2.SETRANGE(Resigned, TRUE);
                IF Emp2.FIND('-') THEN BEGIN
                    Res := TRUE;
                END;

                IF Res THEN BEGIN
                    IF "Loss Of Pay" THEN BEGIN
                        VALIDATE("Attendance Type", "Attendance Type"::"Full Day");
                        "Loss Of Pay" := TRUE;
                    END;
                END ELSE BEGIN
                    IF "Non-Working" THEN
                        ERROR(Text003);
                END;

                IF "Leave Code" = '' THEN BEGIN
                    "Loss Of Pay" := FALSE;
                    MODIFY;
                END;

                IF "Leave Code" = 'EL' THEN BEGIN
                    emp1.INIT;
                    emp1.SETRANGE("No.", "Employee No.");
                    IF emp1.FIND('-') THEN
                        Date1 := CALCDATE('1Y', emp1."Employment Date");
                    IF Date < Date1 THEN BEGIN
                        ERROR('EL is not applicable');
                    END;
                END;

                IF "Leave Code" = 'SL' THEN BEGIN
                    Employee1.INIT;
                    Employee1.SETRANGE("No.", "Employee No.");
                    IF Employee1.FIND('-') THEN BEGIN
                        IF Employee1."ESI Applicable" THEN
                            ERROR('SL is not applicable');
                    END;
                END;

                IF "Leave Code" = 'SL' THEN
                    CALCFIELDS(TotalSickLeavesUsed);
                IF TotalSickLeavesUsed > 8 THEN BEGIN
                    "Loss Of Pay" := TRUE;
                    VALIDATE("Attendance Type", "Attendance Type"::"Full Day");
                    MODIFY;
                END;

                MODIFY;
                DA.INIT;
                i := 1;
                DA.SETRANGE(Year, Year);
                DA.SETRANGE("Employee No.", "Employee No.");
                DA.SETRANGE("Leave Code", 'EL');
                IF DA.FIND('-') THEN BEGIN
                    REPEAT
                        IF i = 1 THEN
                            ELUsed := NooftimesELUsed(DA.Date)
                        ELSE
                            IF DA.Date > ELUsed THEN
                                ELUsed := NooftimesELUsed(DA.Date);
                        i := 2;
                    UNTIL DA.NEXT = 0;
                    IF "Leave Code" = 'EL' THEN
                        "No of times EL used" := Test
                    ELSE
                        "No of times EL used" := 0;

                    IF "No of times EL used" > 4 THEN BEGIN
                        ERROR('Not eligible to EL leaves');
                    END;
                END;
            end;
        }
        field(17; Present; Decimal)
        {
        }
        field(18; Absent; Decimal)
        {
        }
        field(19; Leave; Decimal)
        {
        }
        field(20; "Actual Time In"; Time)
        {
        }
        field(21; "Actual Time Out"; Time)
        {
        }
        field(22; "OT Hrs"; Decimal)
        {
        }
        field(23; "OT Approved Hrs"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "OT Approved Hrs" > "OT Hrs" THEN
                    ERROR(Text002);
            end;
        }
        field(24; "Actual Hrs"; Decimal)
        {
        }
        field(25; "Break Duration"; Decimal)
        {
        }
        field(26; PayCadre; Code[30])
        {
        }
        field(27; "Hrs Worked"; Decimal)
        {
            // CalcFormula = Sum("Employee Timings"."No.of Hours" WHERE (Employee No.=FIELD(Employee No.),
            //                                                           Date=FIELD(Date)));
            // FieldClass = FlowField;
        }
        field(28; "Not Joined"; Decimal)
        {
        }
        field(29; Activity; Integer)
        {
            // CalcFormula = Count(new WHERE(Code = FIELD(Employee No.),
            //                                Field3=FIELD(Date)));
            // FieldClass = FlowField;
        }
        field(30; "Late Hours"; Duration)
        {

            trigger OnValidate()
            var
                Ch: Boolean;
            begin
                IF LateEntryFromTimeIn THEN BEGIN
                    CurrLateHrs := xRec."Late Hours";
                    MonthlyAttd.RESET;
                    MonthlyAttd.SETRANGE(MonthlyAttd."Employee Code", "Employee No.");
                    MonthlyAttd.SETRANGE(MonthlyAttd."Pay Slip Month", Month);
                    MonthlyAttd.SETRANGE(MonthlyAttd.Year, Year);
                    IF MonthlyAttd.FIND('-') THEN BEGIN
                        MonthlyAttd.VALIDATE("Late Hours", ((MonthlyAttd."Late Hours" + "Late Hours") - CurrLateHrs));
                        MonthlyAttd.MODIFY;
                        CurrLateHrs := 0;
                    END;
                    LateEntryFromTimeIn := FALSE;
                END ELSE BEGIN
                    IF NOT ("Non-Working") THEN BEGIN
                        HRSetup.GET;
                        LateEntryFromTimeIn := FALSE;
                        "Time In" := HRSetup."Start Time with Grace Period" + "Late Hours";
                        CurrLateHrs := xRec."Late Hours";
                        MODIFY;
                        MonthlyAttd.RESET;
                        MonthlyAttd.SETRANGE(MonthlyAttd."Employee Code", "Employee No.");
                        MonthlyAttd.SETRANGE(MonthlyAttd."Pay Slip Month", Month);
                        MonthlyAttd.SETRANGE(MonthlyAttd.Year, Year);
                        IF MonthlyAttd.FIND('-') THEN BEGIN
                            MonthlyAttd.VALIDATE("Late Hours", (MonthlyAttd."Late Hours" + "Late Hours") - CurrLateHrs);
                            MonthlyAttd.MODIFY;
                        END;
                    END ELSE
                        ERROR('%1 is Non-working Day', Date);
                END;
            end;
        }
        field(35; Modified; Boolean)
        {
        }
        field(40; LossOfPayCount; Boolean)
        {

            trigger OnValidate()
            begin
                // ve-026 -->
                TESTFIELD("Non-Working", FALSE);
            end;
        }
        field(41; LateEntryFromTimeIn; Boolean)
        {
        }
        field(42; "Medical Certificate Submitted"; Boolean)
        {
        }
        field(43; "Loss Of Pay"; Boolean)
        {

            trigger OnValidate()
            begin

                //VE-026 >>

                Emp2.RESET;
                Emp2.SETRANGE("No.", "Employee No.");
                Emp2.SETRANGE(Resigned, TRUE);
                IF Emp2.FIND('-') THEN BEGIN
                    Res := TRUE;
                END;

                IF Res THEN BEGIN
                    IF "Loss Of Pay" THEN BEGIN
                        VALIDATE("Attendance Type", "Attendance Type"::"Full Day");
                        "Loss Of Pay" := TRUE;
                    END;
                END ELSE

                    IF "Loss Of Pay" THEN BEGIN
                        IF "Attendance Type" = "Attendance Type"::Present THEN
                            ERROR(Text001);
                        VALIDATE("Attendance Type");
                        MODIFY;
                    END;


                //VE-026   <<
            end;
        }
        field(76; TotalSickLeavesUsed; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum("Daily Attendance".Leave WHERE ("Employee No."=FIELD("Employee No."),
            //                                                   Leave Code=CONST(SL),
            //                                                   Loss Of Pay=FILTER(No),
            //                                                   Year=FIELD(Year)));

        }
        field(77; "Total Present Days"; Decimal)
        {
            // FieldClass = FlowField;

            // CalcFormula = Sum("Daily Attendance".Present WHERE ("Employee No."=FIELD("Employee No."),
            //                                                     Attendance Type=FILTER(<>Full Day),
            //                                                     Present=FILTER(<>0),
            //                                                     Non-Working=FILTER(No),
            //                                                     Year=FIELD(Year)));
        }
        field(78; Apply; Boolean)
        {
        }
        field(79; "No of times EL used"; Integer)
        {
        }
        field(80; TotalELUsed; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum("Daily Attendance".Leave WHERE("Employee No." = FIELD("Employee No."),
            //                                                   Leave Code=CONST(EL),
            //                                                   Loss Of Pay=FILTER(No),
            //                                                   Year=FIELD(Year)));

        }
    }

    keys
    {
        key(Key1; "Employee No.", Date)
        {
            Clustered = true;
            SumIndexFields = WeeklyOff, Holiday;
        }
        key(Key2; Year, Month, WeeklyOff, Holiday, Present, Absent, Leave, "Leave Code")
        {
            SumIndexFields = WeeklyOff, Holiday, Present, Absent, Leave;
        }
        key(Key3; "Employee No.", Year, Month, "OT Approved Hrs")
        {
            SumIndexFields = "OT Approved Hrs";
        }
        key(Key4; "Employee No.", Year, Month, LossOfPayCount)
        {
            SumIndexFields = Leave;
        }
        key(Key5; "Leave Code", "Loss Of Pay", Month, Year, "Employee No.", Leave)
        {
            SumIndexFields = Leave;
        }
        key(Key6; "Non-Working", "Attendance Type", "Employee No.", Present, Year)
        {
            SumIndexFields = Present;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR('Deletion Not Allowed..');
    end;

    var
        Text000: Label 'Invalid Attendance type';
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        Text002: Label 'OT Approved Hrs should be less than or equal to the OT Hrs';
        CheckTime: Time;
        emp: Record 60019;
        HRSetup: Record 60016;
        LeaveEntit: Record 60031;
        CurrLateHrs: Duration;
        MonthlyAttd: Record 60029;
        Text0000: Label 'Are you sure to change Attendance Type for  %1';
        LeaveApp: Record 60032;
        LeaveApplication: Record 60032;
        leaveappli: Page 60069;

        Employee1: Record 60019;
        ELUsed: Date;
        ELDate: Date;
        ElComplete: Integer;
        DA: Record 60028;
        i: Integer;
        Test: Integer;
        emp1: Record 60019;
        Date1: Date;
        Text001: Label 'Attendence Type Should not be Present ';
        Text003: Label 'The given day was Non-Working Day...';
        Emp2: Record 60019;
        Res: Boolean;
        res1: Boolean;

    procedure "Posted LeavesFromDailyAttend"(LeaveApp: Record 60032)
    begin
        LeaveApplication := LeaveApp;
        LeaveApplication.TESTFIELD(LeaveApplication."From Date");
        LeaveApplication.TESTFIELD(LeaveApplication."To Date");
        LeaveApplication.TESTFIELD(LeaveApplication."Reason for Leave");
        BEGIN
            LeaveApplication.Processed := TRUE;
            LeaveApplication."Update Leave" := TRUE;
            LeaveApplication.Sanctioned := TRUE;
            LeaveApplication.Status := LeaveApplication.Status::"Send For Approval";
            LeaveApplication."Sanctioning Incharge" := USERID;
            LeaveApplication.MODIFY;
            leaveappli.UpdateMonthlyAttend;
        END;
    end;

    //  [Scope('Internal')]
    procedure NooftimesELUsed(var Date1: Date) ELDate: Date
    var
        da1: Record 60028;
    begin
        da1.SETRANGE("Employee No.", "Employee No.");
        da1.SETRANGE(Year, Year);
        da1.SETFILTER(da1.Date, '>=%1', Date1);
        IF da1.FIND('-') THEN
            REPEAT
                IF (da1."Attendance Type" = da1."Attendance Type"::Present) AND (NOT da1."Non-Working") THEN BEGIN
                    Test += 1;
                    EXIT(da1.Date);
                    da1.NEXT := 0;
                END;
            UNTIL da1.NEXT = 0;
    end;
}

