table 60032 "Leave Application"
{
    // 09-Jan-06

    DrillDownPageID = 60025;
    LookupPageID = 60025;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = Employee_;
        }
        field(2; "Leave Code"; Code[20])
        {
            TableRelation = "Leave Master";

            trigger OnLookup()
            begin
                CheckStatus;
                Employee.SETRANGE("No.", "Employee No.");
                Employee.SETFILTER(Probation, 'Yes');
                IF Employee.FIND('-') THEN BEGIN
                    LeaveMaster.SETFILTER("Leave Code", '<>%1', 'EL');
                    IF LeaveMaster.FIND('-') THEN
                        IF PAGE.RUNMODAL(60021, LeaveMaster) = ACTION::LookupOK THEN
                            "Leave Code" := LeaveMaster."Leave Code";
                END ELSE BEGIN
                    LeaveMaster2.SETFILTER("Leave Code", 'CL|EL|SL');
                    IF PAGE.RUNMODAL(60021, LeaveMaster2) = ACTION::LookupOK THEN
                        "Leave Code" := LeaveMaster2."Leave Code";
                    IF "Leave Code" = 'SL' THEN BEGIN
                        Employee1.SETRANGE("No.", "Employee No.");
                        //         IF NOT Employee1."ESI Applicable" THEN
                        //         ERROR('U R not eligible for sick leave');
                        //         "Leave Code" :='';
                    END;


                END;
            end;

            trigger OnValidate()
            begin



                CheckStatus;
            end;
        }
        field(3; "Leave Duration"; Option)
        {
            OptionMembers = " ","Half Day","Full Day";

            trigger OnValidate()
            begin
                CheckStatus;
            end;
        }
        field(4; "From Date"; Date)
        {

            trigger OnValidate()
            begin
                CheckStatus;
                //EBT Paramita
                Holiday.RESET;
                Holiday.SETRANGE(Holiday.Date, "From Date");
                IF Holiday.FINDFIRST THEN
                    ERROR('This is already declared Holiday in the Company');
                OffDay.RESET;
                OffDay.SETRANGE(OffDay."Weekly Off", OffDay."Weekly Off"::"Full Day");
                IF OffDay.FINDSET THEN
                    REPEAT
                        Date.RESET;
                        Date.SETRANGE(Date."Period Type", Date."Period Type"::Date);
                        Date.SETRANGE(Date."Period Start", "From Date");
                        Date.SETRANGE(Date."Period Name", FORMAT(OffDay.Day));
                        IF Date.FINDFIRST THEN
                            ERROR('This day is Weekely Holiday declared in the company');
                    UNTIL OffDay.NEXT = 0;
                IF "Leave Duration" = "Leave Duration"::"Half Day" THEN BEGIN
                    OffDay.RESET;
                    OffDay.SETRANGE(OffDay."Weekly Off", OffDay."Weekly Off"::"Half Day");
                    IF OffDay.FINDSET THEN
                        REPEAT
                            Date.RESET;
                            Date.SETRANGE(Date."Period Type", Date."Period Type"::Date);
                            Date.SETRANGE(Date."Period Start", "From Date");
                            Date.SETRANGE(Date."Period Name", FORMAT(OffDay.Day));
                            IF Date.FINDFIRST THEN
                                ERROR('This day is Weekely Half day declared in the company');
                        UNTIL OffDay.NEXT = 0;
                END;
                Employee.GET("Employee No.");
                IF Employee."Employment Date" > "From Date" THEN
                    ERROR('This date is before than Employeement Date');
                //EBT Paramita

                IF "Leave Duration" = "Leave Duration"::"Half Day" THEN BEGIN
                    "To Date" := "From Date";
                    "No.of Days" := 0.5;
                END ELSE BEGIN
                    IF "To Date" <> 0D THEN
                        "No.of Days" := ("To Date" - "From Date") + 1;
                END;
                Month := DATE2DMY("From Date", 2);
                Year := DATE2DMY("From Date", 3);

                LeaveEntitle;
                Employee.SETRANGE("No.", "Employee No.");
                IF Employee.FIND('-') THEN BEGIN
                    IF Employee.Probation THEN BEGIN
                        //    IF "From Date" < AvailableDate THEN
                        //      ERROR(Text004,"Leave Code",AvailableDate);
                    END;
                END;

                IF "Leave Code" = 'EL' THEN
                    emp1.INIT;
                emp1.SETRANGE("No.", "Employee No.");
                IF emp1.FIND('-') THEN
                    date1 := CALCDATE('1Y', emp1."Employment Date");
                IF "From Date" < date1 THEN BEGIN
                    //    "Leave Code":='';
                    //    "From Date":=0D;
                    //     MODIFY;
                    //     ERROR('EL is not applicable');
                END;
            end;
        }
        field(5; "To Date"; Date)
        {

            trigger OnValidate()
            begin
                CheckStatus;
                //EBT Paramita
                Holiday.RESET;
                Holiday.SETRANGE(Holiday.Date, "To Date");
                IF Holiday.FINDFIRST THEN
                    ERROR('This is already declared Holiday in the Company');
                OffDay.RESET;
                OffDay.SETRANGE(OffDay."Weekly Off", OffDay."Weekly Off"::"Full Day");
                IF OffDay.FINDSET THEN
                    REPEAT
                        Date.RESET;
                        Date.SETRANGE(Date."Period Type", Date."Period Type"::Date);
                        Date.SETRANGE(Date."Period Start", "To Date");
                        Date.SETRANGE(Date."Period Name", FORMAT(OffDay.Day));
                        IF Date.FINDFIRST THEN
                            ERROR('This day is Weekely Holiday declared in the company');
                    UNTIL OffDay.NEXT = 0;
                IF "Leave Duration" = "Leave Duration"::"Half Day" THEN BEGIN
                    OffDay.RESET;
                    OffDay.SETRANGE(OffDay."Weekly Off", OffDay."Weekly Off"::"Half Day");
                    IF OffDay.FINDSET THEN
                        REPEAT
                            Date.RESET;
                            Date.SETRANGE(Date."Period Type", Date."Period Type"::Date);
                            Date.SETRANGE(Date."Period Start", "To Date");
                            Date.SETRANGE(Date."Period Name", FORMAT(OffDay.Day));
                            IF Date.FINDFIRST THEN
                                ERROR('This day is Weekely Half day declared in the company');
                        UNTIL OffDay.NEXT = 0;
                END;
                Employee.GET("Employee No.");
                IF Employee."Employment Date" > "To Date" THEN
                    ERROR('This date is before than Employeement Date');
                //EBT Paramita

                IF "Leave Duration" = "Leave Duration"::"Half Day" THEN
                    IF "From Date" <> "To Date" THEN BEGIN
                        ERROR(Text000);
                        "To Date" := "From Date";
                    END;

                IF "To Date" < "From Date" THEN
                    ERROR(Text003);

                IF "Leave Duration" = "Leave Duration"::"Half Day" THEN
                    "No.of Days" := 0.5
                ELSE
                    "No.of Days" := ("To Date" - "From Date") + 1;
            end;
        }
        field(6; "Reason for Leave"; Text[50])
        {

            trigger OnValidate()
            begin
                CheckStatus;
            end;
        }
        field(7; Status; Option)
        {
            OptionMembers = " ","Send For Approval",Approved,Reject,"Cancelled ";
        }
        field(8; Sanctioned; Boolean)
        {

            trigger OnValidate()
            begin
                CheckStatus;
                IF Sanctioned THEN
                    Status := Status::"Send For Approval"
                ELSE
                    Status := Status::" ";

                IF Status = Status::Approved THEN
                    Sanctioned := FALSE;
            end;
        }
        field(9; "Sanctioning Incharge"; Text[30])
        {
            TableRelation = Employee_;

            trigger OnValidate()
            begin
                CheckStatus;
                IF "Sanctioning Incharge" = "Employee No." THEN
                    ERROR(Text002);
            end;
        }
        field(10; "Date of Sanction"; Date)
        {

            trigger OnValidate()
            begin
                CheckStatus;
            end;
        }
        field(11; "Date of Cancellation"; Date)
        {

            trigger OnValidate()
            begin
                CheckStatus;
            end;
        }
        field(12; "Employee Name"; Text[50])
        {
        }
        field(13; Year; Integer)
        {
        }
        field(14; Month; Integer)
        {
        }
        field(15; "Leaves avail.curr.Month"; Decimal)
        {
        }
        field(16; "No.of Days"; Decimal)
        {
        }
        field(17; Processed; Boolean)
        {
        }
        field(19; "Update Leave"; Boolean)
        {
        }
        field(20; "Send for Approval DateTime"; DateTime)
        {
            Editable = false;
        }
        field(21; "Send For Appr.Userid"; Code[15])
        {
            Editable = false;
        }
        field(22; "Leave Created From Daily Atten"; Boolean)
        {
        }
        field(23; Apply; Boolean)
        {
        }
        field(24; LosOfPayCount; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Leave Code", "From Date")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.", "Leave Code", Year, Month)
        {
            SumIndexFields = "No.of Days";
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'Leave End Date should be equal to Leave Start Date for Half day Leaves';
        Text001: Label 'Sanction should be false';
        Text002: Label 'Sanction incharge should not be the same person';
        Text003: Label 'To Date should be greater than the From Date';
        Text004: Label '%1 Type Leaves are not available before %2';
        Employee: Record 60019;
        LeaveMaster: Record 60030;
        LeaveMaster2: Record 60030;
        AvailableDate: Date;
        StartDate: Date;
        EndDate: Date;
        Text005: Label 'Processing is done, You cannot cancel these leaves.';
        Text006: Label 'This Leave is cancelled, You can not do any modifications.';
        Employee1: Record 60019;
        emp1: Record 60019;
        date1: Date;
        Holiday: Record 60021;
        OffDay: Record 60006;
        Date: Record 2000000007;

    //  [Scope('Internal')]
    procedure UpdateAbsent()
    var
        LeaveApplication: Record 60032;
        Dailyattendance: Record 60028;
        Dailyattendance2: Record 60028;
        Dailyattendance3: Record 60028;
    begin
        //VE-026>>
        Dailyattendance3.SETFILTER(Leave, '<>0');
        IF Dailyattendance3.FIND('-') THEN
            REPEAT
                Dailyattendance3.Absent := 0;
                Dailyattendance3.Leave := 0;
                Dailyattendance3.Present := 1;
                Dailyattendance3."Leave Code" := '';
                Dailyattendance3."Attendance Type" := Dailyattendance3."Attendance Type"::Present;
                Dailyattendance3.MODIFY;
            UNTIL Dailyattendance3.NEXT = 0;

        LeaveApplication.SETRANGE(Sanctioned, TRUE);
        LeaveApplication.SETRANGE(Processed, FALSE);
        IF LeaveApplication.FIND('-') THEN BEGIN
            REPEAT
                LeaveApplication.TESTFIELD("From Date");
                LeaveApplication.TESTFIELD("To Date");
                Dailyattendance.SETRANGE("Employee No.", LeaveApplication."Employee No.");
                Dailyattendance.SETFILTER(Date, '%1..%2', LeaveApplication."From Date", LeaveApplication."To Date");
                IF Dailyattendance.FIND('-') THEN BEGIN
                    REPEAT
                        Dailyattendance."Attendance Type" := Dailyattendance."Attendance Type"::"Full Day";
                        Dailyattendance."Leave Code" := LeaveApplication."Leave Code";
                        Dailyattendance.Leave := 1;
                        Dailyattendance.Absent := 0;
                        Dailyattendance.Present := 1;

                        IF LeaveApplication."Leave Duration" = LeaveApplication."Leave Duration"::"Half Day" THEN BEGIN
                            Dailyattendance.Leave := 0.5;
                            Dailyattendance.Absent := 0;
                            Dailyattendance.Present := 0.5;
                        END;
                        Dailyattendance.MODIFY;
                    UNTIL Dailyattendance.NEXT = 0;
                END;
            UNTIL LeaveApplication.NEXT = 0;
        END;

        Dailyattendance2.SETRANGE("Non-Working", TRUE);
        IF Dailyattendance2.FIND('-') THEN
            REPEAT
                Dailyattendance2.Leave := 0;
                Dailyattendance2.Absent := 0;
                Dailyattendance2.Present := 1;
                Dailyattendance2."Leave Code" := '';
                Dailyattendance2."Attendance Type" := 0;
                Dailyattendance2.MODIFY;
            UNTIL Dailyattendance2.NEXT = 0;
        //VE-026<<
    end;

    //  [Scope('Internal')]
    procedure LeaveEntitle()
    var
        LeaveMaster: Record 60030;
        Payyear: Record 60020;
    begin


        Payyear.SETRANGE("Year Type", 'LEAVE YEAR');
        Payyear.SETRANGE(Closed, FALSE);
        IF Payyear.FIND('-') THEN BEGIN
            StartDate := Payyear."Year Start Date";
            EndDate := Payyear."Year End Date";
        END;

        LeaveMaster.SETRANGE("Leave Code", "Leave Code");
        IF LeaveMaster.FIND('-') THEN
            REPEAT
                IF LeaveMaster."Crediting Type" = LeaveMaster."Crediting Type"::"After the Period" THEN
                    AvailableDate := CALCDATE(LeaveMaster."Crediting Interval", StartDate)
                ELSE
                    IF LeaveMaster."Crediting Type" = LeaveMaster."Crediting Type"::"Before the Period" THEN
                        AvailableDate := StartDate;
            UNTIL LeaveMaster.NEXT = 0;
    end;

    //   [Scope('Internal')]
    procedure LeaveConvertion()
    var
        Dailyattendance: Record 60028;
        LeaveEntitlement: Record 60031;
        CountLeaves: Decimal;
    begin
        IF LeaveEntitlement.FIND('-') THEN
            REPEAT
                CountLeaves := 0;
                Dailyattendance.SETRANGE("Employee No.", LeaveEntitlement."Employee No.");
                Dailyattendance.SETRANGE("Leave Code", LeaveEntitlement."Leave Code");
                Dailyattendance.SETRANGE(Year, LeaveEntitlement.Year);
                Dailyattendance.SETRANGE(Month, LeaveEntitlement.Month);
                IF Dailyattendance.FIND('-') THEN
                    REPEAT
                        CountLeaves := Dailyattendance.Leave + CountLeaves;
                        IF CountLeaves > LeaveEntitlement."Total Leaves" THEN BEGIN
                            IF (CountLeaves - LeaveEntitlement."Total Leaves") = 0.5 THEN BEGIN
                                Dailyattendance."Attendance Type" := Dailyattendance."Attendance Type"::"Half Day";
                                Dailyattendance."Leave Code" := '';
                                Dailyattendance.Leave := 0;
                                Dailyattendance.Absent := 0.5;
                                Dailyattendance.Present := 0.5;
                                Dailyattendance.MODIFY;
                            END ELSE BEGIN
                                Dailyattendance."Attendance Type" := Dailyattendance."Attendance Type"::Absent;
                                Dailyattendance."Leave Code" := '';
                                Dailyattendance.Leave := 0;
                                Dailyattendance.Absent := 1;
                                Dailyattendance.Present := 0;
                                Dailyattendance.MODIFY;
                            END;
                        END;
                    UNTIL Dailyattendance.NEXT = 0;
            UNTIL LeaveEntitlement.NEXT = 0;
    end;

    //  [Scope('Internal')]
    procedure CancelLeaves(LeaveApp: Record 60032)
    begin
        IF LeaveApp.Processed THEN
            ERROR(Text005)
        ELSE BEGIN
            LeaveApp."Date of Cancellation" := WORKDATE;
            LeaveApp.Status := LeaveApp.Status::Approved;
            //LeaveApp.Sanctioned := FALSE;
            LeaveApp.MODIFY;
            UpdateAbsent;
            LeaveConvertion;
        END;
    end;

    // [Scope('Internal')]
    procedure CheckStatus()
    begin
        IF Status = Status::Approved THEN
            ERROR(Text006);
    end;
}

