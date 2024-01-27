codeunit 60005 "Attendance Process"
{
    // Date: 17-Jan-06 by Bhavani For  HR & Payroll HR4.0.01
    // Remark 1 : This Codeunit is used Process the Attendace based on the Leaves


    trigger OnRun()
    begin
    end;

    // [Scope('Internal')]
    procedure UpdateLeaves(DailyAttendance: Record 60028)
    var
        LeaveEntitle: Record 60031;
    begin
        LeaveEntitle.SETRANGE(Year, DailyAttendance.Year);
        LeaveEntitle.SETRANGE(Month, DailyAttendance.Month);
        IF LeaveEntitle.FIND('-') THEN
            REPEAT
                LeaveEntitle.CALCFIELDS("Leaves taken during Month");
                LeaveEntitle."Leave Bal. at the Month End" := LeaveEntitle."Total Leaves" - LeaveEntitle."Leaves taken during Month";
                LeaveEntitle.MODIFY;
            UNTIL LeaveEntitle.NEXT = 0;
    end;
}

