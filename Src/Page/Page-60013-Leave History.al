page 60013 "Leave History"
{
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = 60028;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrEmpno; CurrEmpno)
                {
                    Caption = 'Employee No.';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF PAGE.RUNMODAL(60005, Employee) = ACTION::LookupOK THEN BEGIN
                            CurrEmpno := Employee."No.";
                            Name := Employee."First Name";
                        END;
                        SelectEmployee;
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                    Caption = 'Employee Name';
                }
            }
            repeater(History)
            {
                Caption = 'History';
                field(Apply; rec.Apply)
                {
                    ApplicationArea = all;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Attendance Type"; Rec."Attendance Type")
                {
                    ValuesAllowed = " ", Present, "Half Day", "Full Day";
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = all;
                }
                field(Date; rec.Date)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Cancel Leave")
                {
                    Caption = 'Cancel Leave';
                    Ellipsis = true;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        Cancel: Boolean;
                    begin
                        //VE-026>>
                        Cancel := CONFIRM(Text002);
                        IF Cancel THEN
                            rec.SETRANGE(Apply, TRUE);
                        IF rec.FIND('-') THEN
                            REPEAT
                                Rec."Attendance Type" := Rec."Attendance Type"::Present;
                                Rec."Leave Code" := '';
                                rec.MODIFY;
                            UNTIL rec.NEXT = 0;
                        rec.RESET;
                        SelectEmployee;
                        //VE-026<<
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*
        RESET;
        SETRANGE(Status,Status::"Send For Approval");
        IF FIND('-') THEN
        IF Hrsetup.FIND('-') THEN BEGIN
          CurrYear:=Hrsetup."Salary Processing Year";
          CurrMonth:=Hrsetup."Salary Processing month";
        END;
         */

        rec.RESET;
        SelectEmployee;

    end;

    var
        Hrsetup: Record 60016;
        Employee: Record 60019;
        CurrEmpno: Code[20];
        Name: Text[50];
        CurrentMonth: Integer;
        CurrentYear: Integer;
        Text000: Label 'Employee No. should  be selected';
        CurrYear: Integer;
        CurrMonth: Integer;
        LeaveApplication: Record 60032;
        Dailyattendance: Record 60028;
        Text0001: Label 'Are You sure to Reject Leave For Employee No %1';
        Text002: Label 'Are You Sure To Cancel Leave For EmployeeNo %1';
        Text0000: Label 'Are You Sure To Sanction Leave For EmployeeNo %1';
        Dailyatt1: Record 60028;
        DailyattCount: Integer;
        Reject: Boolean;
        LeaveApp1: Record 60032;

    // [Scope('Internal')]
    procedure SelectEmployee()
    begin
        rec.SETRANGE(Rec."Employee No.", CurrEmpno);
        rec.SETFILTER(Rec."Attendance Type", '%1 | %2', Rec."Attendance Type"::"Full Day", Rec."Attendance Type"::"Half Day");
        CurrPage.UPDATE(FALSE);
    end;

    // [Scope('Internal')]
    procedure SelectYear()
    begin
        /*SETRANGE(Year,CurrYear);
        CurrForm.UPDATE(FALSE);
         */

    end;

    // [Scope('Internal')]
    procedure SelectMonth()
    begin
        /*SETRANGE(Month,CurrMonth);
        CurrForm.UPDATE(FALSE);
         */

    end;

    // [Scope('Internal')]
    procedure UpdateDailyAttend()
    var
        DailyAttend: Record 60028;
        CurrLeave: Decimal;
    begin
        //VE-026>>
        DailyAttend.SETRANGE("Employee No.", LeaveApplication."Employee No.");
        DailyAttend.SETFILTER(Date, '%1..%2', LeaveApplication."From Date", LeaveApplication."To Date");
        IF DailyAttend.FIND('-') THEN
            REPEAT
                IF DailyAttend."Non-Working" = FALSE THEN BEGIN
                    DailyAttend."Attendance Type" := Dailyattendance."Attendance Type"::"Full Day";
                    DailyAttend."Leave Code" := LeaveApplication."Leave Code";
                    IF DailyAttend."Leave Code" = 'SL' THEN
                        DailyattCount := 0;
                    BEGIN
                        Dailyatt1.RESET;
                        Dailyatt1.SETRANGE("Employee No.", LeaveApplication."Employee No.");
                        Dailyatt1.SETRANGE("Leave Code", 'SL');
                        Dailyatt1.SETFILTER(Leave, '<>%1', 0);
                        Dailyatt1.SETRANGE("Loss Of Pay", FALSE);
                        DailyattCount := Dailyatt1.COUNT;
                        IF (DailyattCount >= 8) THEN
                            DailyAttend."Loss Of Pay" := TRUE;
                    END;

                    DailyAttend.Leave := 1;
                    DailyAttend.Present := 0;
                    CurrLeave := 1;
                    DailyAttend."Hrs Worked" := 0;
                    DailyAttend.MODIFY;


                    IF LeaveApplication."Leave Duration" = LeaveApplication."Leave Duration"::"Half Day" THEN BEGIN
                        IF DailyAttend."Non-Working" = FALSE THEN BEGIN
                            DailyAttend."Attendance Type" := Dailyattendance."Attendance Type"::"Half Day";
                            DailyAttend.Leave := 0.5;
                            DailyAttend.Present := 0.5;
                            DailyAttend."Hrs Worked" := 4;
                            CurrLeave := 0.5;
                            DailyAttend.MODIFY;
                        END;
                    END;
                END;

            UNTIL DailyAttend.NEXT = 0;
        UpdateMonthlyAttend;
        //VE-026>>
    end;

    //[Scope('Internal')]
    procedure UpdateMonthlyAttend()
    var
        MonthlyAttend: Record 60029;
        empl: Record 60019;
    begin
        //VE-026>>
        MonthlyAttend.RESET;
        MonthlyAttend.SETRANGE(MonthlyAttend."Employee Code", LeaveApplication."Employee No.");
        MonthlyAttend.SETRANGE(MonthlyAttend.Year, LeaveApplication.Year);
        MonthlyAttend.SETRANGE(MonthlyAttend."Pay Slip Month", LeaveApplication.Month);
        IF MonthlyAttend.FIND('-') THEN BEGIN
            MonthlyAttend.CALCFIELDS(Attendance);
            MonthlyAttend.CALCFIELDS(Leaves);
            MonthlyAttend.Leaves := MonthlyAttend.Leaves + LeaveApplication."No.of Days";
            MonthlyAttend.Attendance := MonthlyAttend.Attendance - LeaveApplication."No.of Days";
            MonthlyAttend.MODIFY;
        END;
        //VE-026>>
    end;

    // [Scope('Internal')]
    procedure "Posted Leaves"(LeaveApp: Record 60032)
    begin
        //VE-026>>
        LeaveApplication.SETRANGE(LeaveApplication."Employee No.", LeaveApp."Employee No.");
        LeaveApplication.SETRANGE(Apply, TRUE);
        LeaveApplication.SETRANGE(Status, LeaveApplication.Status::"Send For Approval");
        IF LeaveApplication.FIND('-') THEN
            REPEAT
                LeaveApplication.TESTFIELD(LeaveApplication."From Date");
                LeaveApplication.TESTFIELD(LeaveApplication."To Date");
                LeaveApplication.TESTFIELD(LeaveApplication."Reason for Leave");
                BEGIN
                    LeaveApplication.Processed := TRUE;
                    LeaveApplication."Update Leave" := TRUE;
                    LeaveApplication.Sanctioned := TRUE;
                    LeaveApplication.Status := LeaveApplication.Status::Approved;
                    LeaveApplication."Date of Sanction" := WORKDATE;
                    LeaveApplication."Sanctioning Incharge" := USERID;
                    LeaveApplication.MODIFY;
                    UpdateDailyAttend;
                END;
            UNTIL LeaveApplication.NEXT = 0;
        //VE-026>>
    end;
}

