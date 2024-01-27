page 60027 "Leave Encashement"
{
    // Date: 13-Jan-06

    DeleteAllowed = false;
    PageType = Worksheet;
    SourceTable = 60031;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrentLeaveCode; CurrentLeaveCode)
                {
                    Caption = 'Leave Code';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LeaveMaster.SETRANGE(Encashable, TRUE);
                        IF PAGE.RUNMODAL(0, LeaveMaster) = ACTION::LookupOK THEN BEGIN
                            CurrentLeaveCode := LeaveMaster."Leave Code";
                            "Leave Name" := LeaveMaster.Description;
                        END;
                        SelectLeaveCode;
                    end;

                    trigger OnValidate()
                    begin
                        CurrentLeaveCodeOnAfterValidat;
                    end;
                }
                field("Leave Name"; "Leave Name")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Name';
                    Editable = false;
                }
                field(CurrentYear; CurrentYear)
                {
                    ApplicationArea = all;
                    Caption = 'Year';

                    trigger OnValidate()
                    begin
                        CurrentYearOnAfterValidate;
                    end;
                }
                field(CurrentMonth; CurrentMonth)
                {
                    ApplicationArea = all;
                    Caption = 'Month';

                    trigger OnValidate()
                    begin
                        CurrentMonthOnAfterValidate;
                    end;
                }
            }
            repeater(control1)
            {
                Editable = true;
                field("Employee No."; rec."Employee No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Employee Name"; rec."Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Total Leaves"; rec."Total Leaves")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Leave Encashed"; rec."Leave Encashed")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Leave to Encash"; rec."Leave to Encash")
                {
                    ApplicationArea = all;
                }
                field("Encashed Amount"; rec."Encashed Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Leave")
            {
                Caption = '&Leave';
                action("&Encash")
                {
                    ApplicationArea = ALL;
                    Caption = '&Encash';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Encash;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //VE-026 >>
        /*RecRef.GETTABLE(Rec);
        FILTERGROUP(2);
        SETVIEW(SecurityF.GetSecurityFilters(RecRef));
        FILTERGROUP(0);  */
        //VE-026 <<
        CurrentLeaveCode := '';
        "Leave Name" := '';
        IF HRSetup.FIND('-') THEN BEGIN
            CurrentMonth := HRSetup."Salary Processing month";
            CurrentYear := HRSetup."Salary Processing Year";
        END;
        SelectLeaveCode;
        SelectYear;
        SelectMonth;

    end;

    var
        LeaveMaster: Record 60030;
        HRSetup: Record 60016;
        Text001: Label 'There is nothing to encash';
        Text002: Label 'This type of leaves are not encashable';
        Text003: Label 'The no of days cannot exceed the maximum limit';
        MonthlyAttendance: Record 60029;
        LeaveEntitle: Record 60031;
        PayElements: Record 60025;
        LeaveEncashCalc: Codeunit 60012;
        Text004: Label 'Leaves encash should not exceed the Leave Balance ';
        Text005: Label 'Process the attendance first before to encash the leaves for the month %1 of Year  %2';
        CurrentLeaveCode: Code[20];
        "Leave Name": Text[50];
        EncashAmt: Decimal;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        Text006: Label 'salary is already processed for this month.';
        Text007: Label 'Leaves cannot be encashed.';
        RecRef: RecordRef;

    //  [Scope('Internal')]
    procedure SelectYear()
    begin
        rec.SETRANGE(rec.Probation, FALSE);
        rec.SETRANGE(Year, CurrentYear);
        CurrPage.UPDATE(FALSE);
    end;

    //  [Scope('Internal')]
    procedure SelectMonth()
    begin
        rec.SETRANGE(rec.Month, CurrentMonth);
        CurrPage.UPDATE(FALSE);
    end;

    //  [Scope('Internal')]
    procedure SelectLeaveCode()
    begin
        rec.SETRANGE(rec."Leave Code", CurrentLeaveCode);
        CurrPage.UPDATE(FALSE);
    end;

    //   [Scope('Internal')]
    procedure Encash()
    begin
        IF (rec."Leave to Encash" = 0) THEN
            ERROR(Text001);
        LeaveMaster.RESET;
        LeaveMaster.SETRANGE("Leave Code", rec."Leave Code");
        IF LeaveMaster.FIND('-') THEN BEGIN
            IF NOT LeaveMaster.Encashable THEN
                ERROR(Text002);

            IF rec."Total Leaves" < LeaveMaster."Encashment in excess of." THEN
                ERROR(Text007);

            IF rec."Leave to Encash" + rec."Leave Encashed" > LeaveMaster."Max. Encashable" THEN
                ERROR(Text003);
        END;

        LeaveEntitle.SETRANGE("Leave Code", rec."Leave Code");
        LeaveEntitle.SETRANGE("Employee No.", rec."Employee No.");
        LeaveEntitle.SETRANGE(Year, rec.Year);
        IF LeaveEntitle.FIND('-') THEN
            IF LeaveEntitle."Total Leaves" < rec."Leave to Encash" + rec."Leave Encashed" THEN
                ERROR(Text004);

        IF rec.FIND('-') THEN
            REPEAT
                EncashAmt := 0;
                LeaveEntitle.SETRANGE("Leave Code", rec."Leave Code");
                LeaveEntitle.SETRANGE("Employee No.", rec."Employee No.");
                LeaveEntitle.SETRANGE(Year, rec.Year);
                LeaveEntitle.SETRANGE(Month, rec.Month);
                IF LeaveEntitle.FIND('-') THEN
                    REPEAT
                        MonthlyAttendance.SETRANGE("Employee Code", LeaveEntitle."Employee No.");
                        MonthlyAttendance.SETRANGE(Year, LeaveEntitle.Year);
                        MonthlyAttendance.SETRANGE("Pay Slip Month", LeaveEntitle.Month);
                        //MonthlyAttendance.SETRANGE(Processed,FALSE);
                        IF MonthlyAttendance.FIND('-') THEN
                            REPEAT
                                IF rec."Leave to Encash" <> 0 THEN BEGIN
                                    MonthlyAttendance.TESTFIELD(Processed, TRUE);
                                    EncashAmt := LeaveEncashCalc.CalcofLeaveEncashment(MonthlyAttendance, rec."Leave to Encash");
                                    LeaveEncashCalc.LeavesToEncash(LeaveEntitle, EncashAmt);
                                END;
                            UNTIL MonthlyAttendance.NEXT = 0;
                    UNTIL LeaveEntitle.NEXT = 0;
            UNTIL rec.NEXT = 0;

        IF PayElements.FIND('-') THEN
            REPEAT
                PayElements.Processed := FALSE;
                PayElements.MODIFY;
            UNTIL PayElements.NEXT = 0;
    end;

    local procedure CurrentYearOnAfterValidate()
    begin
        SelectYear
    end;

    local procedure CurrentMonthOnAfterValidate()
    begin
        SelectMonth;
    end;

    local procedure CurrentLeaveCodeOnAfterValidat()
    begin
        SelectLeaveCode;
    end;
}

