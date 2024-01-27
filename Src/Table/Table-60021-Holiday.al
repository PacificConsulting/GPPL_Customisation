table 60021 Holiday
{
    // Date: 06-Jan-06


    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Date; Date)
        {

            trigger OnValidate()
            var
                Month: Integer;
                year: Integer;
            begin
                Payrollyear.SETFILTER("Year Type", 'LEAVE YEAR');
                Payrollyear.SETFILTER(Closed, 'NO');
                IF Payrollyear.FIND('-') THEN BEGIN
                    Enddate := DATE2DMY(Payrollyear."Year End Date", 3);
                    Month := DATE2DMY(Date, 2);
                    year := DATE2DMY(Date, 3);
                    IF HrSetup.FIND('-') THEN BEGIN
                        IF year < HrSetup."Salary Processing Year" THEN
                            ERROR(Text000)
                        ELSE
                            IF year = HrSetup."Salary Processing Year" THEN BEGIN
                                IF Month < HrSetup."Salary Processing month" THEN
                                    ERROR(Text000)
                            END;
                    END;
                END ELSE
                    ERROR(Text003);
            end;
        }
        field(3; Description; Text[50])
        {
        }
        field(4; Updated; Boolean)
        {
        }
        field(5; "Operation Type"; Code[50])
        {
            Caption = 'Office Type';
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('OFFICE TYPE'));
        }
    }

    keys
    {
        key(Key1; Date, "Operation Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Updated = TRUE THEN
            ERROR(Text002);
    end;

    var
        Text000: Label 'Holiday date should not be earlier than salary processing month and year';
        HrSetup: Record 60016;
        Payrollyear: Record 60020;
        Text002: Label 'Can''t delete updated records';
        Text003: Label 'Leave year is  closed or Leave year is not created';
        Text004: Label 'Attendance updated successfully';
        Text005: Label 'Please create attendance';
        Enddate: Integer;

    // [Scope('Internal')]
    procedure UpdateAttendance()
    var
        DailyAttendance: Record 60028;
        Holiday: Record 60021;
    begin
        IF Holiday.FIND('-') THEN
            REPEAT
                DailyAttendance.RESET;
                DailyAttendance.SETRANGE(Date, Holiday.Date);
                IF DailyAttendance.COUNT <> 0 THEN BEGIN
                    IF DailyAttendance.FIND('-') THEN
                        REPEAT
                            DailyAttendance."Non-Working" := TRUE;
                            DailyAttendance.Holiday := 1;
                            DailyAttendance."Attendance Type" := 0;
                            DailyAttendance.Present := 0;
                            DailyAttendance.Leave := 0;
                            DailyAttendance.MODIFY;
                        UNTIL DailyAttendance.NEXT = 0;
                    Holiday.Updated := TRUE;
                    Holiday.MODIFY;
                END ELSE
                    ERROR(Text005);
            UNTIL Holiday.NEXT = 0;
        MESSAGE(Text004);
    end;
}

