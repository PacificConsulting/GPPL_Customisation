page 60016 "Daily Attendance"
{
    // Date: 07-Jan-06

    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
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
                field(CurrentEmpNo; CurrentEmpNo)
                {
                    ApplicationArea = all;
                    Caption = 'Employee No.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK THEN BEGIN
                            CurrentEmpNo := Employee."No.";
                            Name := Employee."First Name";
                            Cadre := Employee."Pay Cadre";
                        END;
                        SelectEmployee;
                    end;

                    trigger OnValidate()
                    begin
                        IF Employee.GET(CurrentEmpNo) THEN BEGIN
                            IF Employee.Resigned THEN
                                //ERROR('Employee was Resigned...');
                                Name := Employee."First Name";
                            Cadre := Employee."Pay Cadre";
                        END ELSE BEGIN
                            Name := '';
                            Cadre := '';
                        END;

                        IF CurrentEmpNo = '' THEN BEGIN
                            Name := '';
                            Cadre := '';
                        END;
                        CurrentEmpNoOnAfterValidate;
                    end;
                }
                field(Name; rec."Employee Name")
                {
                    ApplicationArea = all;
                    Caption = 'Employee Name';
                    Editable = false;
                }
                field(Cadre; Rec.PayCadre)
                {
                    ApplicationArea = all;
                    Caption = 'Pay Cadre';
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
                    //ValuesAllowed = 1;2;3;4;5;6;7;8;9;10;11;12;

                    trigger OnValidate()
                    begin
                        CurrentMonthOnAfterValidate;
                    end;
                }
            }
            repeater(control1)
            {
                Editable = true;
                field(Date; rec.Date)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Time In"; rec."Time In")
                {
                    ApplicationArea = all;
                }
                field("Time Out"; rec."Time Out")
                {
                    ApplicationArea = all;
                }
                field("Hours Worked"; rec."Hours Worked")
                {
                    ApplicationArea = all;
                }
                field("Hrs Worked"; rec."Hrs Worked")
                {
                    ApplicationArea = all;
                }
                field("Late Hours"; rec."Late Hours")
                {
                    ApplicationArea = all;
                }
                field("Leave Code"; rec."Leave Code")
                {
                    ApplicationArea = all;
                    Editable = true;

                    trigger OnValidate()
                    begin

                        IF rec."Leave Code" = 'EL' THEN BEGIN
                            lev := "Updating Earned leaves"(Rec);
                            rec.CALCFIELDS(TotalELUsed);
                            IF lev <= rec.TotalELUsed THEN BEGIN
                                rec."Loss Of Pay" := TRUE;
                                rec.VALIDATE("Attendance Type", rec."Attendance Type"::"Full Day");
                                rec.MODIFY;
                            END;
                        END;
                    end;
                }
                field("Attendance Type"; rec."Attendance Type")
                {
                    ApplicationArea = all;
                }
                field("Loss Of Pay"; rec."Loss Of Pay")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        LossOfPayOnPush;
                    end;
                }
                field("OT Hrs"; rec."OT Hrs")
                {
                    ApplicationArea = all;
                }
                field("OT Approved Hrs"; rec."OT Approved Hrs")
                {
                    ApplicationArea = all;
                }
                field("Actual Hrs"; rec."Actual Hrs")
                {
                    ApplicationArea = all;
                }
                field("Medical Certificate Submitted"; rec."Medical Certificate Submitted")
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
            action(Previous)
            {
                ApplicationArea = all;
                Caption = 'Previous';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Previous';

                trigger OnAction()
                var
                    Navigate: Record 60028;
                begin
                    IF CurrentMonth = 1 THEN
                        rec.Year := CurrentYear - 1
                    ELSE
                        rec.Year := CurrentYear;

                    IF CurrentMonth = 1 THEN
                        rec.Month := 12
                    ELSE
                        rec.Month := CurrentMonth - 1;

                    Navigate.SETRANGE(Year, rec.Year);
                    Navigate.SETRANGE(Month, rec.Month);
                    IF Navigate.FIND('-') THEN BEGIN
                        IF CurrentEmpNo = '' THEN
                            ERROR(Text001);
                        CurrentYear := rec.Year;
                        CurrentMonth := rec.Month;
                        SelectYear;
                        SelectMonth;
                    END ELSE
                        ERROR(Text000);
                end;
            }
            action(Next)
            {
                Caption = 'Next';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Next';
                ApplicationArea = all;
                trigger OnAction()
                var
                    Navigate: Record 60028;
                begin
                    IF CurrentMonth = 12 THEN
                        rec.Year := CurrentYear + 1
                    ELSE
                        rec.Year := CurrentYear;

                    IF CurrentMonth = 12 THEN
                        rec.Month := 1
                    ELSE
                        rec.Month := CurrentMonth + 1;

                    Navigate.SETRANGE(Year, rec.Year);
                    Navigate.SETRANGE(Month, rec.Month);
                    IF Navigate.FIND('-') THEN BEGIN
                        IF CurrentEmpNo = '' THEN
                            ERROR(Text001);
                        CurrentYear := rec.Year;
                        CurrentMonth := rec.Month;
                        SelectYear;
                        SelectMonth;
                    END ELSE
                        ERROR(Text000);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DateOnFormat;
    end;

    trigger OnOpenPage()
    begin
        CurrentEmpNo := '';
        Name := '';
        IF HRSetup.FIND('-') THEN BEGIN
            CurrentMonth := HRSetup."Salary Processing month";
            CurrentYear := HRSetup."Salary Processing Year";
        END;
        SelectEmployee;
        SelectYear;
        SelectMonth;
    end;

    var
        HRSetup: Record 60016;
        Employee: Record 60019;
        CurrentEmpNo: Code[20];
        Text000: Label 'There are no records with in these filters';
        Text001: Label 'Please, Select Employee ';
        Cadre: Code[30];
        Name: Text[50];
        CurrentMonth: Integer;
        CurrentYear: Integer;
        DailyAttend1: Record 60028;
        ELLeaves: Text[30];
        lev: Decimal;
        emp1: Record 60019;

    //  [Scope('Internal')]
    procedure SelectYear()
    begin
        rec.SETRANGE("Not Joined", 0);
        rec.SETRANGE(Year, CurrentYear);
        CurrPage.UPDATE(FALSE);
    end;

    //  [Scope('Internal')]
    procedure SelectMonth()
    begin
        rec.SETRANGE("Not Joined", 0);
        rec.SETRANGE(Month, CurrentMonth);
        CurrPage.UPDATE(FALSE);
    end;

    //  [Scope('Internal')]
    procedure SelectEmployee()
    begin
        rec.SETRANGE("Not Joined", 0);
        rec.SETRANGE("Employee No.", CurrentEmpNo);
        CurrPage.UPDATE(FALSE);
    end;

    // [Scope('Internal')]
    procedure "Updating Earned leaves"(var DailyAttend: Record 60028) Elleave: Decimal
    var
        LeaveEntitle1: Record 60031;
        DailyAtt: Record 60028;
        Emp: Record 60019;
        Date1: Date;
        Mon1: Integer;
        year1: Integer;
    begin
        //VE-026
        emp1.INIT;
        emp1.SETRANGE("No.", DailyAttend."Employee No.");
        IF emp1.FIND('-') THEN
            Date1 := CALCDATE('1Y', emp1."Employment Date");
        year1 := DATE2DMY(Date1, 3);
        Mon1 := DATE2DMY(Date1, 2);
        IF year1 <= DailyAttend.Year THEN BEGIN
            IF year1 = DailyAttend.Year THEN BEGIN
                IF (Mon1 <= DailyAttend.Month) AND (DailyAttend.Month <> 1) THEN BEGIN
                    DailyAttend1.RESET;
                    DailyAttend1.SETRANGE("Employee No.", DailyAttend."Employee No.");
                    DailyAttend1.SETRANGE(Year, DailyAttend.Year - 1);
                    IF DailyAttend1.FIND('+') THEN
                        DailyAttend1.CALCFIELDS("Total Present Days");
                    IF DailyAttend1."Total Present Days" > 240 THEN BEGIN
                        Elleave := 15;
                    END ELSE BEGIN
                        IF DailyAttend1."Total Present Days" / 20 <> 0 THEN BEGIN
                            ELLeaves := FORMAT(DailyAttend1."Total Present Days" / 20);
                            EVALUATE(Elleave, COPYSTR(ELLeaves, 1, (STRPOS(ELLeaves, '.')) - 1));
                        END;
                    END;
                END;
            END ELSE BEGIN
                //IF DailyAttend.Month=1 THEN
                //BEGIN
                DailyAttend1.RESET;
                DailyAttend1.SETRANGE("Employee No.", DailyAttend."Employee No.");
                DailyAttend1.SETRANGE(Year, DailyAttend.Year - 1);
                IF DailyAttend1.FIND('+') THEN
                    DailyAttend1.CALCFIELDS("Total Present Days");
                IF DailyAttend1."Total Present Days" > 240 THEN BEGIN
                    Elleave := UpdateLeaveforEL(DailyAttend);
                END
                ELSE BEGIN
                    ELLeaves := FORMAT(DailyAttend1."Total Present Days" / 20);
                    EVALUATE(Elleave, COPYSTR(ELLeaves, 1, (STRPOS(ELLeaves, '.')) - 1));
                    Elleave += UpdateLeaveforEL(DailyAttend);
                END;
                // END;
            END;
        END;
        //VE-026
    end;

    //  [Scope('Internal')]
    procedure UpdateLeaveforEL(var DailyAttend: Record 60028) ELLeaves1: Decimal
    var
        LeaveEntitle1: Record 60031;
        DailyAtt: Record 60028;
    begin
        //VE-026>>
        LeaveEntitle1.INIT;
        LeaveEntitle1.SETRANGE("Employee No.", DailyAttend."Employee No.");
        LeaveEntitle1.SETRANGE(Year, DailyAttend.Year - 1);
        LeaveEntitle1.SETRANGE(Month, 12);
        LeaveEntitle1.SETRANGE("Leave Code", 'EL');
        IF LeaveEntitle1.FIND('-') THEN
            ELLeaves1 := LeaveEntitle1."Leave Bal. at the Month End";
        //VE-026<<
    end;

    local procedure CurrentYearOnAfterValidate()
    begin
        SelectYear
    end;

    local procedure CurrentMonthOnAfterValidate()
    begin
        SelectMonth;
    end;

    local procedure CurrentEmpNoOnAfterValidate()
    begin
        SelectEmployee;
    end;

    local procedure LossOfPayOnPush()
    begin
        CurrPage.SAVERECORD;
    end;

    local procedure DateOnFormat()
    begin
        IF rec."Non-Working" THEN;
    end;
}

