page 60069 "Leave Approval"
{
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = 60032;
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
                        IF PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK THEN BEGIN
                            CurrEmpno := Employee."No.";
                            Name := Employee."First Name";
                        END;
                        SelectEmployee;
                    end;
                }
                field(Name; Name)
                {
                    Caption = 'Employee Name';
                }
            }
            repeater(Leave)
            {
                Caption = 'Leave';
                field(Apply; rec.Apply)
                {
                    ApplicationArea = all;
                }
                field("Leave Code"; rec."Leave Code")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin


                        IF CurrEmpno = '' THEN
                            ERROR(Text000);
                    end;
                }
                field("Employee No."; rec."Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Leave Duration"; rec."Leave Duration")
                {
                    ApplicationArea = all;
                }
                field("From Date"; rec."From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; rec."To Date")
                {
                    ApplicationArea = all;
                }
                field("No.of Days"; rec."No.of Days")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Send For Appr.Userid"; rec."Send For Appr.Userid")
                {
                    ApplicationArea = all;
                }
                field("Reason for Leave"; rec."Reason for Leave")
                {
                    ApplicationArea = all;
                }
                field("Send for Approval DateTime"; rec."Send for Approval DateTime")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
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
                action(Approved)
                {
                    ApplicationArea = all;
                    Caption = 'Approved';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //VE-026>>
                        IF NOT CONFIRM(Text0000, FALSE, rec."Employee No.") THEN
                            EXIT
                        ELSE BEGIN
                            rec.RESET;
                            rec.SETRANGE(Apply, TRUE);
                            rec.SETRANGE(rec.Status, rec.Status::"Send For Approval");
                            IF rec.FIND('-') THEN BEGIN
                                REPEAT
                                    "Posted Leaves"(Rec);
                                UNTIL rec.NEXT = 0;
                                //EBT Paramita
                                DetailedAppliedLeave.RESET;
                                DetailedAppliedLeave.SETRANGE("Employee Code", rec."Employee No.");
                                DetailedAppliedLeave.SETRANGE(DetailedAppliedLeave."Leave Code", rec."Leave Code");
                                DetailedAppliedLeave.SETRANGE(DetailedAppliedLeave.Applied, TRUE);
                                DetailedAppliedLeave.SETRANGE(DetailedAppliedLeave.Date, rec."From Date", rec."To Date");
                                IF DetailedAppliedLeave.FINDSET THEN
                                    REPEAT
                                        DetailedAppliedLeave.Approved := TRUE;
                                        DetailedAppliedLeave.MODIFY;
                                    UNTIL DetailedAppliedLeave.NEXT = 0;
                                //EBT Paramita
                                MESSAGE('Leave Approved');
                            END
                            ELSE
                                ERROR('Please Check the Leave Application');
                        END;
                        //VE-026<<
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Ellipsis = true;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        //VE-026>>
                        rec.SETRANGE(Apply, TRUE);
                        rec.SETRANGE(rec.Status, rec.Status::"Send For Approval");
                        IF rec.FIND('-') THEN BEGIN
                            REPEAT
                                rec.TESTFIELD(rec."From Date");
                                rec.TESTFIELD(rec."To Date");
                                rec.TESTFIELD(rec."Reason for Leave");
                                Reject := CONFIRM(Text0001);
                                IF Reject THEN
                                    LeaveApplication.SETRANGE(LeaveApplication."Employee No.", rec."Employee No.");
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
                                            LeaveApplication.Status := LeaveApplication.Status::Reject;
                                            LeaveApplication.MODIFY;
                                        END;
                                    UNTIL LeaveApplication.NEXT = 0;
                            UNTIL rec.NEXT = 0;
                            //EBT Paramita
                            DetailedAppliedLeave.RESET;
                            DetailedAppliedLeave.SETRANGE("Employee Code", rec."Employee No.");
                            DetailedAppliedLeave.SETRANGE(DetailedAppliedLeave."Leave Code", rec."Leave Code");
                            DetailedAppliedLeave.SETRANGE(DetailedAppliedLeave.Applied, TRUE);
                            DetailedAppliedLeave.SETRANGE(DetailedAppliedLeave.Date, rec."From Date", rec."To Date");
                            IF DetailedAppliedLeave.FINDSET THEN
                                REPEAT
                                    DetailedAppliedLeave.Reject := TRUE;
                                    DetailedAppliedLeave.MODIFY;
                                UNTIL DetailedAppliedLeave.NEXT = 0;
                            //EBT Paramita
                            MESSAGE('Leave Rejected');
                        END
                        ELSE BEGIN
                            rec.RESET;
                            MESSAGE('Zero Records Rejected. \ Apply Should be True.');
                        END;
                        //VE-026<<
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF CurrEmpno = '' THEN
            ERROR(Text000);
    end;

    trigger OnOpenPage()
    begin

        rec.RESET;
        rec.SETRANGE(rec.Status, rec.Status::"Send For Approval");
        IF rec.FIND('-') THEN
            IF Hrsetup.FIND('-') THEN BEGIN
                CurrYear := Hrsetup."Salary Processing Year";
                CurrMonth := Hrsetup."Salary Processing month";
            END;

        /*
        
        CurrEmpno:='';
        Name:='';
        IF Hrsetup.FIND('-') THEN BEGIN
          CurrYear:=Hrsetup."Salary Processing Year";
          CurrMonth:=Hrsetup."Salary Processing month";
        END;
        SelectEmployee;
         */

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
        DetailedAppliedLeave: Record 60001;
        DailyA: Page 60016;

    //  [Scope('Internal')]
    procedure SelectEmployee()
    begin
        rec.SETRANGE(rec."Sanctioning Incharge", CurrEmpno); //EBT paramita
        CurrPage.UPDATE(FALSE);
    end;

    // [Scope('Internal')]
    procedure SelectYear()
    begin
        rec.SETRANGE(Year, CurrYear);
        CurrPage.UPDATE(FALSE);
    end;

    //  [Scope('Internal')]
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
        lev: Decimal;
    begin
        //VE-026>>
        DailyAttend.RESET;
        DailyAttend.SETRANGE("Employee No.", LeaveApplication."Employee No.");
        DailyAttend.SETFILTER(Date, '%1..%2', LeaveApplication."From Date", LeaveApplication."To Date");
        IF DailyAttend.FIND('-') THEN
            REPEAT
                IF DailyAttend."Non-Working" = FALSE THEN BEGIN
                    DailyAttend."Attendance Type" := Dailyattendance."Attendance Type"::"Full Day";
                    DailyAttend."Leave Code" := LeaveApplication."Leave Code";
                    IF LeaveApplication."Leave Code" = 'SL' THEN BEGIN
                        DailyattCount := 0;
                        Dailyatt1.RESET;
                        Dailyatt1.SETRANGE("Employee No.", LeaveApplication."Employee No.");
                        Dailyatt1.SETRANGE("Leave Code", 'SL');
                        Dailyatt1.SETFILTER(Leave, '<>%1', 0);
                        Dailyatt1.SETRANGE("Loss Of Pay", FALSE);
                        DailyattCount := Dailyatt1.COUNT;
                        IF (DailyattCount >= 8) THEN
                            DailyAttend."Loss Of Pay" := TRUE;
                    END;
                    IF LeaveApplication."Leave Code" = 'EL' THEN BEGIN
                        DailyattCount := 0;
                        Dailyatt1.RESET;
                        Dailyatt1.SETRANGE("Employee No.", LeaveApplication."Employee No.");
                        Dailyatt1.SETRANGE("Leave Code", 'EL');
                        Dailyatt1.SETFILTER(Leave, '<>%1', 0);
                        Dailyatt1.SETRANGE("Loss Of Pay", FALSE);
                        DailyattCount := Dailyatt1.COUNT;
                        lev := DailyA."Updating Earned leaves"(DailyAttend);
                        IF lev < DailyattCount THEN
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
                            DailyAttend."Leave Code" := LeaveApplication."Leave Code";
                            IF LeaveApplication."Leave Code" = 'SL' THEN BEGIN
                                DailyattCount := 0;
                                Dailyatt1.RESET;
                                Dailyatt1.SETRANGE("Employee No.", LeaveApplication."Employee No.");
                                Dailyatt1.SETRANGE("Leave Code", 'SL');
                                Dailyatt1.SETFILTER(Leave, '<>%1', 0);
                                Dailyatt1.SETRANGE("Loss Of Pay", FALSE);
                                DailyattCount := Dailyatt1.COUNT;
                                IF (DailyattCount >= 8) THEN
                                    DailyAttend."Loss Of Pay" := TRUE;
                            END;
                            IF LeaveApplication."Leave Code" = 'EL' THEN BEGIN
                                DailyattCount := 0;
                                Dailyatt1.RESET;
                                Dailyatt1.SETRANGE("Employee No.", LeaveApplication."Employee No.");
                                Dailyatt1.SETRANGE("Leave Code", 'EL');
                                Dailyatt1.SETFILTER(Leave, '<>%1', 0);
                                Dailyatt1.SETRANGE("Loss Of Pay", FALSE);
                                DailyattCount := Dailyatt1.COUNT;
                                lev := DailyA."Updating Earned leaves"(DailyAttend);
                                IF lev < DailyattCount THEN
                                    DailyAttend."Loss Of Pay" := TRUE;
                            END;


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

    // [Scope('Internal')]
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

    //   [Scope('Internal')]
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

