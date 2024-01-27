codeunit 60007 "TDS Calculations"
{

    trigger OnRun()
    begin
        UpdateTDSRecords;
        Window.CLOSE;
    end;

    var
        Text002: Label 'Employee       #1#################\';
        Window: Dialog;

    // [Scope('Internal')]
    procedure InsertRecords(TDSDeduction: Record 60046; Total: Decimal; Month: Integer; Year: Integer)
    var
        ExpSalComp: Record 60014;
        ExpSalComputation: Record 60014;
    begin
        ExpSalComp.INIT;
        ExpSalComp."Employee Code" := TDSDeduction."Employee No.";
        ExpSalComp.Month := Month;
        ExpSalComp.Year := Year;
        ExpSalComp."Expected Salary" := Total;

        ExpSalComputation.SETRANGE("Employee Code", ExpSalComp."Employee Code");
        ExpSalComputation.SETRANGE(Month, ExpSalComp.Month);
        ExpSalComputation.SETRANGE(Year, ExpSalComp.Year);
        IF NOT ExpSalComputation.FIND('-') THEN
            ExpSalComp.INSERT;
    end;

    // [Scope('Internal')]
    procedure InsertTDS(Employee: Record 60019; StartingDate: Date; EndingDate: Date; Days: Decimal)
    var
        TDSDeduction: Record 60046;
        TDSDeduction2: Record 60046;
    begin
        IF NOT Employee.Blocked THEN BEGIN
            TDSDeduction.INIT;
            TDSDeduction."Employee No." := Employee."No.";
            TDSDeduction."Year Starting Date" := StartingDate;
            TDSDeduction."Year Ending Date" := EndingDate;
            TDSDeduction."Remaining Months" := Days DIV 30;

            TDSDeduction2.SETRANGE("Employee No.", TDSDeduction."Employee No.");
            IF NOT TDSDeduction2.FIND('-') THEN
                TDSDeduction.INSERT;
        END;
    end;

    // [Scope('Internal')]
    procedure TDSScheduleCalc(TDSDeduction: Record 60046)
    var
        TDSSchedule: Record 60047;
        TDSSchedule2: Record 60047;
        Months: Integer;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        i: Integer;
    begin
        Months := (TDSDeduction."Year Ending Date" - TDSDeduction."Year Starting Date") DIV 30;
        CurrentMonth := DATE2DMY(TDSDeduction."Year Starting Date", 2);
        CurrentYear := DATE2DMY(TDSDeduction."Year Starting Date", 3);

        FOR i := 1 TO Months DO BEGIN
            TDSSchedule.INIT;
            TDSSchedule."Employee No." := TDSDeduction."Employee No.";
            TDSSchedule."Year Starting Date" := TDSDeduction."Year Starting Date";
            TDSSchedule."Year Ending Date" := TDSDeduction."Year Ending Date";
            TDSSchedule.Month := CurrentMonth;
            TDSSchedule."TDS Amount" := TDSDeduction."Tax Per Month";
            TDSSchedule.Year := CurrentYear;
            TDSSchedule.INSERT;
            CurrentMonth := CurrentMonth + 1;
            IF CurrentMonth > 12 THEN BEGIN
                CurrentMonth := 1;
                CurrentYear := CurrentYear + 1;
            END;
        END;
    end;

    //  [Scope('Internal')]
    procedure UpdateTDSRecords()
    var
        Employee: Record 60019;
        TDSDeduction: Record 60046;
        PayYear: Record 60020;
        Days: Decimal;
        StartingDate: Date;
        EndingDate: Date;
    begin
        Window.OPEN(Text002);

        PayYear.FIND('-');
        PayYear.SETRANGE("Year Type", 'FINANCIAL YEAR');
        PayYear.SETRANGE(Closed, FALSE);
        IF PayYear.FIND('-') THEN BEGIN
            StartingDate := PayYear."Year Start Date";
            EndingDate := PayYear."Year End Date";
            Days := EndingDate - StartingDate;
        END;


        Employee.SETFILTER(Blocked, 'No');
        IF Employee.FIND('-') THEN
            REPEAT
                InsertTDS(Employee, StartingDate, EndingDate, Days);
            UNTIL Employee.NEXT = 0;

        IF TDSDeduction.FIND('-') THEN
            REPEAT
                Window.UPDATE(1, TDSDeduction."Employee No.");
                VADProcess(TDSDeduction);
            UNTIL TDSDeduction.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure VADProcess(TDSDeduction: Record 60046)
    var
        ProcessedSalary: Record 60038;
        PayElement: Record 60025;
        Total: Decimal;
        Amount: Decimal;
        StartMonth: Integer;
        StartYear: Integer;
        CheckMonth: Integer;
        CheckYear: Integer;
        StartDate: Date;
        EndDate: Date;
    begin
        StartDate := TDSDeduction."Year Starting Date";
        EndDate := TDSDeduction."Year Ending Date";
        StartMonth := DATE2DMY(StartDate, 2);
        StartYear := DATE2DMY(StartDate, 3);
        CheckMonth := DATE2DMY(EndDate, 2);
        CheckYear := DATE2DMY(EndDate, 3);
        IF CheckMonth = 12 THEN BEGIN
            Amount := 0;
            REPEAT
                Total := 0;
                ProcessedSalary.SETRANGE("Employee Code", TDSDeduction."Employee No.");
                ProcessedSalary.SETFILTER(Year, '=%1', StartYear);
                ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', StartMonth);
                ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
                IF ProcessedSalary.FIND('-') THEN BEGIN
                    REPEAT
                        Total := Total + ProcessedSalary."Earned Amount";
                    UNTIL ProcessedSalary.NEXT = 0;
                END ELSE BEGIN
                    EndDate := CALCDATE('1M', StartDate) - 1;
                    Total := GrossSalaryCalc(TDSDeduction, StartDate, EndDate);
                END;

                Amount := Amount + Total;

                InsertRecords(TDSDeduction, Total, StartMonth, StartYear);

                IF PayElement.FIND('-') THEN
                    REPEAT
                        PayElement.Processed := FALSE;
                        PayElement.MODIFY;
                    UNTIL PayElement.NEXT = 0;

                StartDate := CALCDATE('1M', StartDate);
                StartMonth := StartMonth + 1;
                IF StartMonth > 12 THEN BEGIN
                    StartYear := StartYear + 1;
                    StartMonth := 1;
                END;

                TDSDeduction."Gross Salary" := Amount;
                TDSDeduction.MODIFY;

            UNTIL (StartMonth = 1) AND (StartYear = CheckYear + 1);
        END ELSE BEGIN
            Amount := 0;
            REPEAT
                Total := 0;

                ProcessedSalary.SETRANGE("Employee Code", TDSDeduction."Employee No.");
                ProcessedSalary.SETFILTER(Year, '=%1', StartYear);
                ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', StartMonth);
                ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
                IF ProcessedSalary.FIND('-') THEN BEGIN
                    REPEAT
                        Total := Total + ProcessedSalary."Earned Amount";
                    UNTIL ProcessedSalary.NEXT = 0;
                END ELSE BEGIN
                    EndDate := CALCDATE('1M', StartDate) - 1;
                    Total := GrossSalaryCalc(TDSDeduction, StartDate, EndDate);
                END;

                Amount := Amount + Total;
                InsertRecords(TDSDeduction, Total, StartMonth, StartYear);

                IF PayElement.FIND('-') THEN
                    REPEAT
                        PayElement.Processed := FALSE;
                        PayElement.MODIFY;
                    UNTIL PayElement.NEXT = 0;

                StartDate := CALCDATE('1M', StartDate);
                StartMonth := StartMonth + 1;
                IF StartMonth > 12 THEN BEGIN
                    StartYear := StartYear + 1;
                    StartMonth := 1;
                END;

                TDSDeduction."Gross Salary" := Amount;
                TDSDeduction.MODIFY;

            UNTIL (StartMonth > CheckMonth) AND (StartYear = CheckYear);
        END;
    end;

    // [Scope('Internal')]
    procedure GrossSalaryCalc(TDSDeduction: Record 60046; StartDatesrc: Date; Enddatesrc: Date): Decimal
    var
        PayElement: Record 60025;
        VAD: Record 60025;
        VAD2: Record 60025;
        Basic: Decimal;
        DA: Decimal;
        Total: Decimal;
        "Sum": Decimal;
        Sum2: Decimal;
        Amount: Decimal;
        NoofDays: Decimal;
        Days: Decimal;
        Month: Integer;
        Year: Integer;
        StartDate: Date;
        EndDate: Date;
        StartDate2: Date;
        CheckDate: Date;
    begin
        Month := DATE2DMY(TDSDeduction."Year Starting Date", 2);
        Year := DATE2DMY(TDSDeduction."Year Starting Date", 3);
        Days := Enddatesrc - StartDatesrc + 1;
        PayElement.SETRANGE(Processed, FALSE);
        PayElement.SETRANGE("Employee Code", TDSDeduction."Employee No.");
        PayElement.SETRANGE("Add/Deduct", PayElement."Add/Deduct"::Addition);
        IF PayElement.FIND('-') THEN BEGIN
            REPEAT
                Total := 0;
                Sum := 0;
                StartDate := StartDatesrc;
                EndDate := Enddatesrc;
                VAD.RESET;
                VAD.SETRANGE("Employee Code", PayElement."Employee Code");
                VAD.SETRANGE("Pay Element Code", PayElement."Pay Element Code");
                IF VAD.FIND('-') THEN
                    REPEAT
                        NoofDays := 0;
                        IF (VAD."Effective Start Date" > StartDate) AND (VAD."Effective Start Date" <= EndDate) THEN BEGIN
                            NoofDays := VAD."Effective Start Date" - StartDate;
                            StartDate2 := StartDate;
                            StartDate := VAD."Effective Start Date";
                            VAD2.RESET;
                            VAD2.SETRANGE("Employee Code", VAD."Employee Code");
                            VAD2.SETRANGE("Pay Element Code", VAD."Pay Element Code");
                            IF VAD2.FIND('-') THEN BEGIN
                                CheckDate := VAD2."Effective Start Date";
                                REPEAT
                                    VAD2.Processed := TRUE;
                                    VAD2.MODIFY;
                                    IF (VAD2."Effective Start Date" >= CheckDate) AND (VAD2."Effective Start Date" <= StartDate2) THEN BEGIN
                                        IF VAD2."Pay Element Code" = 'BASIC' THEN BEGIN
                                            IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                                Total := (NoofDays / Days) * VAD2."Amount / Percent";
                                                Basic := Total;
                                            END ELSE
                                                IF (VAD2."Computation Type" = 'NON ATTENDANCE') THEN BEGIN
                                                    Total := (NoofDays / Days) * VAD2."Amount / Percent";
                                                    Basic := Total;
                                                END;
                                        END ELSE BEGIN
                                            IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) THEN BEGIN
                                                IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN
                                                    Total := (NoofDays / Days) * VAD2."Amount / Percent"
                                                ELSE
                                                    Total := (NoofDays / Days) * VAD2."Amount / Percent";
                                            END ELSE
                                                IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) AND
                                                   (VAD2."Computation Type" = 'AFTER BASIC')
                                       THEN
                                                    Total := (VAD2."Amount / Percent" * Basic) / 100
                                                ELSE
                                                    IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) AND
                                                       (VAD2."Computation Type" = 'AFTER BASIC AND DA')
                                               THEN
                                                        Total := (VAD2."Amount / Percent" * (Basic + DA)) / 100;
                                        END;
                                        IF VAD2."Pay Element Code" = 'DA' THEN
                                            DA := Total;
                                    END;
                                UNTIL VAD2.NEXT = 0;
                            END;
                            Sum := Sum + Total;
                        END;
                    UNTIL VAD.NEXT = 0;

                VAD2.RESET;
                VAD2.SETRANGE("Employee Code", VAD."Employee Code");
                VAD2.SETRANGE("Pay Element Code", VAD."Pay Element Code");
                IF VAD2.FIND('-') THEN BEGIN
                    CheckDate := VAD2."Effective Start Date";
                    NoofDays := EndDate - StartDate + 1;
                    REPEAT
                        VAD2.Processed := TRUE;
                        VAD2.MODIFY;
                        IF (VAD2."Effective Start Date" >= CheckDate) AND (VAD2."Effective Start Date" <= StartDate) THEN BEGIN
                            IF VAD2."Pay Element Code" = 'BASIC' THEN BEGIN
                                IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                    Total := (NoofDays / Days) * VAD2."Amount / Percent";
                                    Basic := Total;
                                END ELSE
                                    IF (VAD2."Computation Type" = 'NON ATTENDANCE') THEN BEGIN
                                        Total := (NoofDays / Days) * VAD2."Amount / Percent";
                                        Basic := Total;
                                    END;
                            END ELSE BEGIN
                                IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) THEN BEGIN
                                    IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN
                                        Total := (NoofDays / Days) * VAD2."Amount / Percent"
                                    ELSE
                                        Total := (NoofDays / Days) * VAD2."Amount / Percent";
                                END ELSE
                                    IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) AND
                                       (VAD2."Computation Type" = 'AFTER BASIC')
                           THEN
                                        Total := (VAD2."Amount / Percent" * Basic) / 100
                                    ELSE
                                        IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) AND
                                           (VAD2."Computation Type" = 'AFTER BASIC AND DA')
                                   THEN
                                            Total := (VAD2."Amount / Percent" * (Basic + DA)) / 100;
                            END;
                            IF VAD2."Pay Element Code" = 'DA' THEN
                                DA := Total;
                        END;
                    UNTIL VAD2.NEXT = 0;
                END;
                Sum2 := Sum + Total;
                Amount := Amount + Sum2;
            UNTIL PayElement.NEXT = 0;
            EXIT(Amount);
        END;
    end;

    // [Scope('Internal')]
    procedure TDSReSchedule()
    var
        TDSDeduction: Record 60046;
    begin
        Window.OPEN(Text002);
        IF TDSDeduction.FIND('-') THEN
            REPEAT
                Window.UPDATE(1, TDSDeduction."Employee No.");
                VADProcess(TDSDeduction);
                TDSReScheduleCalc(TDSDeduction);
            UNTIL TDSDeduction.NEXT = 0;
        Window.CLOSE;
    end;

    //  [Scope('Internal')]
    procedure TDSReScheduleCalc(TDSDeduction: Record 60046)
    var
        TDSSchedule: Record 60047;
        TDSSchedule2: Record 60047;
        Months: Integer;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        i: Integer;
        DeductedAmount: Decimal;
        TotalAmount: Decimal;
        TaxAmount: Decimal;
    begin
        Months := TDSDeduction."Remaining Months";

        TDSSchedule.CALCFIELDS("TDS Amount Deducted");
        TDSSchedule.SETRANGE("Employee No.", TDSDeduction."Employee No.");
        TDSSchedule.SETRANGE("Year Starting Date", TDSDeduction."Year Starting Date");
        TDSSchedule.SETRANGE("Year Ending Date", TDSDeduction."Year Ending Date");
        TDSSchedule.SETFILTER("TDS Amount Deducted", '<>0');
        IF TDSSchedule.FIND('-') THEN
            REPEAT
                TDSSchedule.CALCFIELDS("TDS Amount Deducted");
                DeductedAmount := DeductedAmount + TDSSchedule."TDS Amount Deducted";
            UNTIL TDSSchedule.NEXT = 0;

        TotalAmount := TDSDeduction."Tax Liability after savings" - DeductedAmount;
        TaxAmount := TotalAmount / Months;

        TDSSchedule.RESET;
        TDSSchedule.CALCFIELDS("TDS Amount Deducted");
        TDSSchedule.SETRANGE("Employee No.", TDSDeduction."Employee No.");
        TDSSchedule.SETRANGE("Year Starting Date", TDSDeduction."Year Starting Date");
        TDSSchedule.SETRANGE("Year Ending Date", TDSDeduction."Year Ending Date");
        TDSSchedule.SETFILTER("TDS Amount Deducted", '=0');
        IF TDSSchedule.FIND('-') THEN
            REPEAT
                TDSSchedule."TDS Amount" := TaxAmount;
                TDSSchedule.MODIFY;
            UNTIL TDSSchedule.NEXT = 0;
    end;
}

