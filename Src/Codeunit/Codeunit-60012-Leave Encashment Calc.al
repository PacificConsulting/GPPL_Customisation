codeunit 60012 "Leave Encashment Calc"
{
    // 13/03/06


    trigger OnRun()
    begin
        LeavesToEncash(LeaveEntitle, EncashAmt);
    end;

    var
        LeaveEntitle: Record 60031;
        VAD: Record 60025;
        EncashAmt: Decimal;

    // [Scope('Internal')]
    procedure LeavesToEncash(LeaveEntitle: Record 60031; EncashAmt: Decimal)
    var
        LeaveEncash: Record 60033;
    begin
        LeaveEncash.INIT;
        LeaveEncash."Leave Code" := LeaveEntitle."Leave Code";
        LeaveEncash."Employee Code" := LeaveEntitle."Employee No.";
        LeaveEncash.Year := LeaveEntitle.Year;
        LeaveEncash.Month := LeaveEntitle.Month;
        LeaveEncash."Leaves Encashed" := LeaveEntitle."Leave to Encash";
        LeaveEncash."Leaves to Encash" := LeaveEntitle."Leave to Encash";
        LeaveEncash."Encash Amount" := EncashAmt;
        LeaveEncash.INSERT;
        UpdateLeaveBalance(LeaveEncash);
    end;

    //  [Scope('Internal')]
    procedure CalcofLeaveEncashment(MonAttendance: Record 60029; LeaveEncashed: Decimal): Decimal
    var
        DailyAttendance: Record 60028;
        PayElement: Record 60025;
        VAD: Record 60025;
        VAD2: Record 60025;
        Basic: Decimal;
        DA: Decimal;
        Total: Decimal;
        "Sum": Decimal;
        Sum2: Decimal;
        NetCash: Decimal;
        NoofDays: Decimal;
        StartDate: Date;
        EndDate: Date;
        CheckDate: Date;
    begin
        PayElement.SETRANGE(Processed, FALSE);
        PayElement.SETRANGE("Employee Code", MonAttendance."Employee Code");
        IF PayElement.FIND('-') THEN BEGIN
            REPEAT
                MonAttendance.CALCFIELDS(MonAttendance.Days);
                Total := 0;
                Sum := 0;
                NetCash := 0;
                StartDate := MonAttendance."Period Start Date";
                EndDate := MonAttendance."Period End Date";
                NoofDays := EndDate - StartDate + 1;
                VAD2.RESET;
                VAD2.SETRANGE("Employee Code", PayElement."Employee Code");
                VAD2.SETRANGE("Pay Element Code", PayElement."Pay Element Code");
                IF VAD2.FIND('-') THEN BEGIN
                    CheckDate := VAD2."Effective Start Date";
                    REPEAT
                        VAD2.Processed := TRUE;
                        VAD2.MODIFY;
                        IF (VAD2."Effective Start Date" >= CheckDate) AND (VAD2."Effective Start Date" <= EndDate) THEN BEGIN
                            IF VAD2."Pay Element Code" = 'BASIC' THEN BEGIN
                                IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                    Total := VAD2."Amount / Percent";
                                    Basic := Total;
                                    NetCash := (Basic / MonAttendance.Days) * LeaveEncashed;
                                END ELSE
                                    IF (VAD2."Computation Type" = 'NON ATTENDANCE') THEN BEGIN
                                        Total := VAD2."Amount / Percent";
                                        Basic := Total;
                                        NetCash := (Basic / MonAttendance.Days) * LeaveEncashed;
                                    END;
                            END ELSE BEGIN
                                IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) THEN BEGIN
                                    IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                        NetCash := (Total / MonAttendance.Days) * LeaveEncashed;
                                    END ELSE BEGIN
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                        NetCash := (Total / MonAttendance.Days) * LeaveEncashed;
                                    END;
                                END ELSE
                                    IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) AND
                                       (VAD2."Computation Type" = 'AFTER BASIC')
                           THEN BEGIN
                                        Total := (VAD2."Amount / Percent" * Basic) / 100;
                                        NetCash := (Total / MonAttendance.Days) * LeaveEncashed;
                                    END ELSE
                                        IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) AND
                                           (VAD2."Computation Type" = 'AFTER BASIC AND DA')
                               THEN BEGIN
                                            Total := (VAD2."Amount / Percent" * (Basic + DA)) / 100;
                                            NetCash := (Total / MonAttendance.Days) * LeaveEncashed;
                                        END;
                                IF VAD2."Pay Element Code" = 'DA' THEN
                                    DA := Total;
                            END;
                        END;
                    UNTIL VAD2.NEXT = 0;
                    Sum := Sum + NetCash;
                END;
                Sum2 := Sum2 + Sum;
            UNTIL PayElement.NEXT = 0;
            EXIT(Sum2);
        END;
    end;

    //[Scope('Internal')]
    procedure UpdateLeaveBalance(LeaveEncash: Record 60033)
    begin
        LeaveEntitle.SETRANGE("Employee No.", LeaveEncash."Employee Code");
        LeaveEntitle.SETRANGE("Leave Code", LeaveEncash."Leave Code");
        LeaveEntitle.SETRANGE(Year, LeaveEncash.Year);
        LeaveEntitle.SETRANGE(Month, LeaveEncash.Month);
        IF LeaveEntitle.FIND('-') THEN BEGIN
            LeaveEntitle."Total Leaves" := LeaveEntitle."Total Leaves" - LeaveEncash."Leaves Encashed";
            LeaveEntitle."Leave to Encash" := 0;
            LeaveEntitle.MODIFY;
        END;
    end;
}

