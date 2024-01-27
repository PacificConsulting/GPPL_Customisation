codeunit 60008 "Salary Process"
{
    // Date: 15-Dec-05

    SingleInstance = false;

    trigger OnRun()
    begin
    end;

    var
        Employee: Record 60019;
        TempProcessedSalary: Record 60037;
        Lookup: Record 60018;
        LeaveEncash: Record 60033;
        Text001: Label 'Processing is Completed';
        Text002: Label 'Check the Leaves , they are Greater than the No.of days of the Month';
        Text003: Label 'Please define payelements for the Employee %1';
        AddDeduct: Option " ",Addition,Deduction,Benifits;
        TotalEncashAmt: Decimal;
        RevisiedPayElements: Record 60025;
        TempPayElements: Record 60025 temporary;
        HRSetup: Record 60016;
        RoundType: Text[30];
        EmpTDSAmt: Record 60008;
        MonthlyAtt: Record 60029;
        MA2: Record 60007;
        emp1: Record 60019;
        Flag: Boolean;

    //   [Scope('Internal')]
    procedure ProcessSalary(var MonAttendance: Record 60029)
    var
        DailyAttendance: Record 60028;
        PayElements: Record 60025;
        VAD: Record 60025;
        VAD2: Record 60025;
        Employee: Record 60019;
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        NoofDays: Decimal;
        NoofDays2: Decimal;
        "Sum": Decimal;
        Sum2: Decimal;
        Lop: Decimal;
        NotJoined: Decimal;
        StartDate: Date;
        EndDate: Date;
        StartDate2: Date;
        CheckDate: Date;
        RevisiedDate: Date;
        TotalDays: Decimal;
        PostedOthPayElements: Record 60036;
    begin
        TempPayElements.DELETEALL;
        RevisiedPayElements.RESET;
        RevisiedPayElements.SETCURRENTKEY("Effective Start Date");
        RevisiedPayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
        RevisiedPayElements.SETFILTER("Effective Start Date", '<=%1', MonAttendance."Period End Date");
        IF RevisiedPayElements.FIND('+') THEN BEGIN
            RevisiedDate := RevisiedPayElements."Effective Start Date";
        END;

        RevisiedPayElements.RESET;
        RevisiedPayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
        IF RevisiedPayElements.FIND('-') THEN
            REPEAT
                TempPayElements.INIT;
                TempPayElements.TRANSFERFIELDS(RevisiedPayElements);
                TempPayElements.INSERT;
            UNTIL RevisiedPayElements.NEXT = 0;

        RevisiedPayElements.RESET;
        RevisiedPayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
        RevisiedPayElements.SETFILTER("Effective Start Date", '<> %1', RevisiedDate);
        IF RevisiedPayElements.FIND('-') THEN
            REPEAT
                PayElements.SETRANGE("Employee Code", RevisiedPayElements."Employee Code");
                PayElements.SETRANGE("Effective Start Date", RevisiedDate);
                PayElements.SETRANGE("Pay Element Code", RevisiedPayElements."Pay Element Code");
                IF PayElements.FIND('-') THEN BEGIN
                END ELSE BEGIN
                    PayElements.INIT;
                    PayElements.TRANSFERFIELDS(RevisiedPayElements);
                    PayElements."Effective Start Date" := RevisiedDate;
                    PayElements."Amount / Percent" := 0;
                    PayElements.Processed := FALSE;
                    PayElements.INSERT;
                END;
            UNTIL RevisiedPayElements.NEXT = 0;

        PayElements.RESET;
        PayElements.SETCURRENTKEY("Employee Code", "Pay Element Code");
        PayElements.SETRANGE(Processed, FALSE);
        PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
        IF PayElements.FIND('-') THEN BEGIN
            REPEAT
                MonAttendance.CALCFIELDS(MonAttendance.Days);
                Total := 0;
                Sum := 0;
                StartDate := MonAttendance."Period Start Date";
                EndDate := MonAttendance."Period End Date";
                VAD.RESET;
                VAD.SETRANGE("Employee Code", PayElements."Employee Code");
                VAD.SETRANGE("Pay Element Code", PayElements."Pay Element Code");
                IF VAD.FIND('-') THEN
                    REPEAT
                        NoofDays2 := 0;
                        NoofDays := 0;
                        Lop := 0;
                        NotJoined := 0;
                        IF (VAD."Effective Start Date" > StartDate) AND (VAD."Effective Start Date" <= EndDate) THEN BEGIN
                            NoofDays2 := VAD."Effective Start Date" - StartDate;
                            //ve-026
                            /*
                              DailyAttendance.RESET;
                              DailyAttendance.SETFILTER(Date,'%1..%2',StartDate,VAD."Effective Start Date");
                              DailyAttendance.SETRANGE("Employee No.",VAD."Employee Code");
                              DailyAttendance.SETFILTER(Absent,'<>0');
                              IF DailyAttendance.FIND('-') THEN
                                REPEAT
                                  Lop := Lop + DailyAttendance.Absent;
                                UNTIL DailyAttendance.NEXT = 0;

                              DailyAttendance.RESET;
                              DailyAttendance.SETFILTER(Date,'%1..%2',StartDate,VAD."Effective Start Date");
                              DailyAttendance.SETRANGE("Employee No.",VAD."Employee Code");
                              DailyAttendance.SETFILTER("Not Joined",'<>0');
                              IF DailyAttendance.FIND('-') THEN
                                REPEAT
                                  NotJoined := NotJoined + DailyAttendance."Not Joined";
                                UNTIL DailyAttendance.NEXT = 0;
                              NoofDays := NoofDays2 - (Lop + NotJoined);  */
                            NoofDays := MonAttendance."No.Of Payroll Days";
                            TotalDays := NoofDays + MonAttendance."Loss Of Pay";
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
                                                IF TotalDays <> MonAttendance.Days THEN BEGIN
                                                    IF TotalDays <> 0 THEN   //PARAMITA
                                                        Total := ((NoofDays) / TotalDays) * VAD2."Amount / Percent";
                                                END
                                                ELSE
                                                    Total := ((NoofDays) / MonAttendance.Days) * VAD2."Amount / Percent";
                                                Basic := Total;
                                            END ELSE
                                                IF (VAD2."Computation Type" = 'NON ATTENDANCE') THEN BEGIN
                                                    Total := (NoofDays2 / MonAttendance.Days) * VAD2."Amount / Percent";
                                                    Basic := Total;
                                                END;
                                        END ELSE BEGIN
                                            IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) THEN BEGIN
                                                IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                                    IF TotalDays <> MonAttendance.Days THEN BEGIN
                                                        IF TotalDays <> 0 THEN   //PARAMITA
                                                            Total := ((NoofDays) / TotalDays) * VAD2."Amount / Percent";
                                                    END
                                                    ELSE
                                                        Total := ((NoofDays) / MonAttendance.Days) * VAD2."Amount / Percent"
                                                END ELSE BEGIN
                                                    IF TotalDays <> MonAttendance.Days THEN BEGIN
                                                        IF TotalDays <> 0 THEN   //PARAMITA
                                                            Total := ((NoofDays) / TotalDays) * VAD2."Amount / Percent";
                                                    END
                                                    ELSE
                                                        Total := (NoofDays2 / MonAttendance.Days) * VAD2."Amount / Percent";
                                                END;
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
                    Lop := 0;
                    NotJoined := 0;
                    CheckDate := VAD2."Effective Start Date";
                    NoofDays2 := EndDate - StartDate + 1;
                    //VE-026
                    /*
                        DailyAttendance.RESET;
                        DailyAttendance.SETFILTER(Date,'%1..%2',StartDate,EndDate);
                        DailyAttendance.SETRANGE("Employee No.",VAD2."Employee Code");
                        DailyAttendance.SETFILTER(Absent,'<>0');
                        IF DailyAttendance.FIND('-') THEN
                          REPEAT
                            Lop := Lop + DailyAttendance.Absent;
                          UNTIL DailyAttendance.NEXT = 0;

                          DailyAttendance.RESET;
                          DailyAttendance.SETFILTER(Date,'%1..%2',StartDate,EndDate);
                          DailyAttendance.SETRANGE("Employee No.",VAD2."Employee Code");
                          DailyAttendance.SETFILTER("Not Joined",'<>0');
                          IF DailyAttendance.FIND('-') THEN
                            REPEAT
                              NotJoined := NotJoined + DailyAttendance."Not Joined";
                            UNTIL DailyAttendance.NEXT = 0;
                          NoofDays := NoofDays2 - (Lop + NotJoined);*/
                    NoofDays := MonAttendance."No.Of Payroll Days";
                    TotalDays := NoofDays + MonAttendance."Loss Of Pay";
                    REPEAT
                        VAD2.Processed := TRUE;
                        VAD2.MODIFY;
                        IF (VAD2."Effective Start Date" >= CheckDate) AND (VAD2."Effective Start Date" <= StartDate) THEN BEGIN
                            IF VAD2."Pay Element Code" = 'BASIC' THEN BEGIN
                                IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                    IF TotalDays <> MonAttendance.Days THEN BEGIN
                                        IF TotalDays <> 0 THEN   //PARAMITA
                                            Total := ((NoofDays) / TotalDays) * VAD2."Amount / Percent";
                                    END
                                    ELSE
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                    Basic := Total;
                                END ELSE
                                    IF (VAD2."Computation Type" = 'NON ATTENDANCE') THEN BEGIN
                                        Total := (NoofDays2 / MonAttendance.Days) * VAD2."Amount / Percent";
                                        Basic := Total;
                                    END;
                            END ELSE BEGIN
                                IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) THEN BEGIN
                                    IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                        IF TotalDays <> MonAttendance.Days THEN BEGIN
                                            IF TotalDays <> 0 THEN   //PARAMITA
                                                Total := ((NoofDays) / TotalDays) * VAD2."Amount / Percent";
                                        END
                                        ELSE
                                            Total := ((NoofDays) / MonAttendance.Days) * VAD2."Amount / Percent"
                                    END ELSE BEGIN
                                        IF TotalDays <> MonAttendance.Days THEN BEGIN
                                            IF TotalDays <> 0 THEN   //PARAMITA
                                                Total := ((NoofDays) / TotalDays) * VAD2."Amount / Percent";
                                        END
                                        ELSE
                                            Total := (NoofDays2 / MonAttendance.Days) * VAD2."Amount / Percent";
                                    END;
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
                InsertTempProcRecords(MonAttendance, PayElements, Sum2);

            UNTIL PayElements.NEXT = 0;

            PayElements.RESET;
            PayElements.SETRANGE(PayElements."Employee Code", MonAttendance."Employee Code");
            IF PayElements.FIND('-') THEN
                REPEAT
                    PayElements.Processed := FALSE;
                    PayElements.MODIFY;
                UNTIL PayElements.NEXT = 0;


            //VE-003 >>
            //Get Other Pay Elements if Already Posted

            PostedOthPayElements.INIT;
            PostedOthPayElements.RESET;
            PostedOthPayElements.SETRANGE("Employee No.", MonAttendance."Employee Code");
            PostedOthPayElements.SETRANGE(Year, MonAttendance.Year);
            PostedOthPayElements.SETRANGE(Month, MonAttendance."Pay Slip Month");
            PostedOthPayElements.SETFILTER(PostedOthPayElements.Amount, '>%1', 0);
            IF PostedOthPayElements.FIND('-') THEN
                REPEAT
                    TempProcessedSalary.SETRANGE("Document Type", TempProcessedSalary."Document Type"::Payroll);
                    TempProcessedSalary.SETRANGE("Employee Code", MonAttendance."Employee Code");
                    TempProcessedSalary.SETRANGE("Pay Slip Month", MonAttendance."Pay Slip Month");
                    TempProcessedSalary.SETRANGE(Year, MonAttendance.Year);
                    TempProcessedSalary.SETRANGE("Add/Deduct Code", PostedOthPayElements."Pay Element Code");
                    IF NOT TempProcessedSalary.FIND('-') THEN
                        InsertTempProcRecordsVAD(MonAttendance, PostedOthPayElements."Pay Element Code",
                                     PostedOthPayElements."Add/Deduct", PostedOthPayElements.Amount);

                UNTIL PostedOthPayElements.NEXT = 0;

            //VE-003 <<


            // OT Calculation
            Employee.SETRANGE("No.", VAD."Employee Code");
            IF Employee.FIND('-') THEN BEGIN
                IF (Employee."OT Applicable" = TRUE) AND (Employee."OT Calculation Rate" <> 0) THEN
                    OTCalculations(MonAttendance, Employee."OT Calculation Rate");
            END;


            // PT Calculation

            PayElements.RESET;
            PayElements.SETRANGE(PayElements."Employee Code", MonAttendance."Employee Code");
            IF PayElements.FIND('-') THEN
                REPEAT
                    PayElements.Processed := FALSE;
                    PayElements.MODIFY;
                UNTIL PayElements.NEXT = 0;

            Employee.RESET;
            Employee.SETRANGE("No.", VAD."Employee Code");
            IF Employee.FIND('-') THEN BEGIN
                IF (Employee."PT Applicable" = TRUE) THEN
                    CalcPTGrossSalary(MonAttendance);  //PT Calculation
            END;


            //B2B ESI Calculation
            PayElements.RESET;
            PayElements.SETRANGE(PayElements."Employee Code", MonAttendance."Employee Code");
            IF PayElements.FIND('-') THEN
                REPEAT
                    PayElements.Processed := FALSE;
                    PayElements.MODIFY;
                UNTIL PayElements.NEXT = 0;

            Employee.RESET;
            Employee.SETRANGE("No.", VAD."Employee Code");
            IF Employee.FIND('-') THEN BEGIN
                IF (Employee."ESI Applicable" = TRUE) THEN
                    CalcESITaxAmt(MonAttendance);     // ESI Calculation
            END;
            //B2B ESI Calculation


            //B2B PF Calculation

            PayElements.RESET;
            PayElements.SETRANGE(PayElements."Employee Code", MonAttendance."Employee Code");
            IF PayElements.FIND('-') THEN
                REPEAT
                    PayElements.Processed := FALSE;
                    PayElements.MODIFY;
                UNTIL PayElements.NEXT = 0;

            Employee.RESET;
            Employee.SETRANGE("No.", VAD."Employee Code");
            IF Employee.FIND('-') THEN BEGIN
                IF (Employee."PF Applicable" = TRUE) THEN
                    CalcPFTaxAmt(MonAttendance);      // PF Calculation
            END;
            //B2B PF Calculation


            LoanDeductions(MonAttendance);    // Loan Deductions
                                              //InsertTDSRecords(MonAttendance);      // TDS //VE-003
            InsertTDSRecords2(MonAttendance); //VE-003     // TDS

            CalcBonusAmt(MonAttendance);

            // Leave Encashment
            TotalEncashAmt := 0;
            LeaveEncash.SETRANGE("Employee Code", MonAttendance."Employee Code");
            LeaveEncash.SETRANGE(Year, MonAttendance.Year);
            LeaveEncash.SETRANGE(Month, MonAttendance."Pay Slip Month");
            IF LeaveEncash.FIND('-') THEN BEGIN
                REPEAT
                    TotalEncashAmt := TotalEncashAmt + LeaveEncash."Encash Amount";
                UNTIL LeaveEncash.NEXT = 0;
                AddDeduct := AddDeduct::Addition;
                InsertTempProcRecordsVAD(MonAttendance, 'LEAVE ENCASHMENT', AddDeduct, TotalEncashAmt);
            END;


            PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
            IF PayElements.FIND('-') THEN
                REPEAT
                    PayElements.DELETE;
                UNTIL PayElements.NEXT = 0;

            TempPayElements.RESET;
            TempPayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
            IF TempPayElements.FIND('-') THEN
                REPEAT
                    PayElements := TempPayElements;
                    PayElements.INSERT;
                UNTIL TempPayElements.NEXT = 0;

        END ELSE
            ERROR(Text003, MonAttendance."Employee Code");

    end;

    // [Scope('Internal')]
    procedure InsertTempProcRecords(MonAttendance: Record 60029; PayElement: Record 60025; Total: Decimal)
    var
        TempProcSalary: Record 60037;
        TempProcSalary2: Record 60037;
        Lookup: Record 60018;
    begin
        IF Total <> 0 THEN BEGIN
            TempProcSalary.INIT;
            TempProcSalary."Employee Code" := PayElement."Employee Code";
            TempProcSalary."Add/Deduct Code" := PayElement."Pay Element Code";
            TempProcSalary."Pay Slip Month" := MonAttendance."Pay Slip Month";
            TempProcSalary.Year := MonAttendance.Year;
            TempProcSalary."Document Type" := TempProcSalary."Document Type"::Payroll;

            TempProcessedSalary.SETRANGE("Document Type", TempProcessedSalary."Document Type"::Payroll);
            TempProcessedSalary.SETRANGE("Employee Code", TempProcSalary."Employee Code");
            TempProcessedSalary.SETRANGE("Pay Slip Month", TempProcSalary."Pay Slip Month");
            TempProcessedSalary.SETRANGE(Year, TempProcSalary.Year);
            IF TempProcessedSalary.FIND('+') THEN
                TempProcSalary."Line No." := TempProcessedSalary."Line No." + 10000
            ELSE
                TempProcSalary."Line No." := 10000;

            HRSetup.FIND('-');
            IF HRSetup."Rounding Type" = HRSetup."Rounding Type"::Up THEN
                RoundType := '>'
            ELSE
                IF HRSetup."Rounding Type" = HRSetup."Rounding Type"::Down THEN
                    RoundType := '<'
                ELSE
                    RoundType := '=';

            TempProcSalary."Fixed/Percent" := PayElement."Fixed/Percent";
            TempProcSalary."Computation Type" := PayElement."Computation Type";
            TempProcSalary."Loan Priority No" := PayElement."Loan Priority No";
            TempProcSalary."Earned Amount" := ROUND(Total, HRSetup."Rounding Precision", RoundType);
            TempProcSalary."Add/Deduct" := PayElement."Add/Deduct";
            TempProcSalary.Attendance := MonAttendance.Attendance;
            TempProcSalary.Days := MonAttendance.Days;

            Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
            Lookup.SETRANGE("Lookup Name", TempProcSalary."Add/Deduct Code");
            IF Lookup.FIND('-') THEN
                TempProcSalary.Priority := Lookup.Priority;

            TempProcSalary.INSERT;


            //VE-003 >>
            /*
            IF TempProcSalary."Add/Deduct Code" = 'TDS' THEN;
              TDSDeductionAmt(TempProcSalary);
            */
            //VE-003 <<

        END;

    end;

    //[Scope('Internal')]
    procedure TDSRemainingMonths(PayElement: Record 60025)
    var
        TDSDeduction: Record 60046;
        PayYear: Record 60020;
        StartDate: Date;
        EndDate: Date;
        TotalMonths: Integer;
        days: Decimal;
    begin
        PayYear.FIND('-');
        PayYear.SETRANGE("Year Type", 'FINANCIAL YEAR');
        PayYear.SETRANGE(Closed, FALSE);
        IF PayYear.FIND('-') THEN BEGIN
            StartDate := PayYear."Year Start Date";
            EndDate := PayYear."Year End Date";
        END;

        TDSDeduction.SETRANGE("Employee No.", PayElement."Employee Code");
        TDSDeduction.SETRANGE("Year Starting Date", StartDate);
        TDSDeduction.SETRANGE("Year Ending Date", EndDate);
        IF TDSDeduction.FIND('-') THEN BEGIN
            IF TDSDeduction."Remaining Months" <> 0 THEN
                TDSDeduction."Remaining Months" := TDSDeduction."Remaining Months" - 1;
            TDSDeduction.MODIFY;
        END;
    end;

    //   [Scope('Internal')]
    procedure TDSDeductionAmt(ProcessedSalary: Record 60037)
    var
        TDSDeduction: Record 60046;
        Payyear: Record 60020;
        StartDate: Date;
        EndDate: Date;
    begin
        Payyear.FIND('-');
        Payyear.SETRANGE("Year Type", 'FINANCIAL YEAR');
        Payyear.SETRANGE(Closed, FALSE);
        IF Payyear.FIND('-') THEN BEGIN
            StartDate := Payyear."Year Start Date";
            EndDate := Payyear."Year End Date";
        END;

        TDSDeduction.SETRANGE("Employee No.", TempProcessedSalary."Employee Code");
        TDSDeduction.SETRANGE("Year Starting Date", StartDate);
        TDSDeduction.SETRANGE("Year Ending Date", EndDate);
        IF TDSDeduction.FIND('-') THEN BEGIN
            TDSDeduction."Tax Already Deducted" := TDSDeduction."Tax Already Deducted" + TempProcessedSalary."Earned Amount";
            TDSDeduction.MODIFY;
        END;
    end;

    // [Scope('Internal')]
    procedure InsertTDSRecords(MonAttendance: Record 60029)
    var
        TDSSchedule: Record 60047;
        ProcSalary: Record 60038;
    begin
        TDSSchedule.SETRANGE("Employee No.", MonAttendance."Employee Code");
        TDSSchedule.SETRANGE(Month, MonAttendance."Pay Slip Month");
        TDSSchedule.SETRANGE(Year, MonAttendance.Year);
        IF TDSSchedule.FIND('-') THEN BEGIN
            AddDeduct := AddDeduct::Deduction;
            InsertTempProcRecordsVAD(MonAttendance, 'TDS', AddDeduct, TDSSchedule."TDS Amount");
            TDSSchedule.Processes := TRUE;
            TDSSchedule.MODIFY;
        END;
    end;

    // [Scope('Internal')]
    procedure OTCalculations(MonAttendance: Record 60029; OTRate: Decimal)
    var
        PayElements: Record 60025;
        VAD: Record 60025;
        VAD2: Record 60025;
        DailyAttendance: Record 60028;
        Basic: Decimal;
        DA: Decimal;
        DayAmount: Decimal;
        OTAmount: Decimal;
        FinalTotal: Decimal;
        OTTotal: Decimal;
        Total: Decimal;
    begin
        //MonAttendance.CALCFIELDS(MonAttendance."OT Hrs");
        MonAttendance.CALCFIELDS(MonAttendance.Days);

        DailyAttendance.SETRANGE("Employee No.", MonAttendance."Employee Code");
        DailyAttendance.SETFILTER(Date, '%1..%2', MonAttendance."Period Start Date", MonAttendance."Period End Date");
        DailyAttendance.SETFILTER(DailyAttendance."OT Approved Hrs", '<> 0');
        IF DailyAttendance.FIND('-') THEN BEGIN
            REPEAT
                IF VAD.FIND('-') THEN
                    REPEAT
                        VAD.Processed := FALSE;
                        VAD.MODIFY;
                    UNTIL VAD.NEXT = 0;
                VAD.RESET;

                PayElements.SETRANGE(PayElements.Processed, FALSE);
                PayElements.SETRANGE("Employee Code", DailyAttendance."Employee No.");
                PayElements.SETRANGE("Applicable for OT", TRUE);
                PayElements.SETFILTER(PayElements."Effective Start Date", '<= %1', DailyAttendance.Date);
                IF PayElements.FIND('-') THEN
                    REPEAT
                        Total := 0;
                        VAD2.SETFILTER(VAD2."Effective Start Date", '<= %1', DailyAttendance.Date);
                        VAD2.SETRANGE("Employee Code", PayElements."Employee Code");
                        VAD2.SETRANGE("Pay Element Code", PayElements."Pay Element Code");
                        VAD2.SETRANGE("Applicable for OT", TRUE);
                        IF VAD2.FIND('-') THEN
                            REPEAT
                                OTTotal := 0;
                                VAD2.Processed := TRUE;
                                VAD2.MODIFY;
                                IF VAD2."Pay Element Code" = 'BASIC' THEN BEGIN
                                    Total := VAD2."Amount / Percent";
                                    Basic := Total;
                                    DayAmount := (Total * 1) / MonAttendance.Days;
                                    OTAmount := (DayAmount * DailyAttendance."OT Approved Hrs") / DailyAttendance."Actual Hrs";
                                    OTAmount := OTAmount * OTRate;
                                END ELSE BEGIN
                                    IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) THEN BEGIN
                                        Total := VAD2."Amount / Percent";
                                        DayAmount := (Total * 1) / MonAttendance.Days;
                                        OTAmount := (DayAmount * DailyAttendance."OT Approved Hrs") / DailyAttendance."Actual Hrs";
                                        OTAmount := OTAmount * OTRate;
                                    END ELSE
                                        IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) AND
                                           (VAD2."Computation Type" = 'AFTER BASIC')
                               THEN BEGIN
                                            Total := (VAD2."Amount / Percent" * Basic) / 100;
                                            DayAmount := (Total * 1) / MonAttendance.Days;
                                            OTAmount := (DayAmount * DailyAttendance."OT Approved Hrs") / DailyAttendance."Actual Hrs";
                                            OTAmount := OTAmount * OTRate;
                                        END ELSE
                                            IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Percent) AND
                                               (VAD2."Computation Type" = 'AFTER BASIC AND DA')
                                   THEN BEGIN
                                                Total := (VAD2."Amount / Percent" * (Basic + DA)) / 100;
                                                DayAmount := (Total * 1) / MonAttendance.Days;
                                                OTAmount := (DayAmount * DailyAttendance."OT Approved Hrs") / DailyAttendance."Actual Hrs";
                                                OTAmount := OTAmount * OTRate;
                                            END;
                                END;
                                IF VAD2."Pay Element Code" = 'DA' THEN
                                    DA := Total;
                                IF VAD2."Add/Deduct" = VAD2."Add/Deduct"::Addition THEN
                                    OTTotal := OTTotal + OTAmount
                                ELSE
                                    IF VAD2."Add/Deduct" = VAD2."Add/Deduct"::Deduction THEN
                                        OTTotal := OTTotal - OTAmount;
                            UNTIL VAD2.NEXT = 0;
                        FinalTotal := FinalTotal + OTTotal;
                    UNTIL PayElements.NEXT = 0;
            UNTIL DailyAttendance.NEXT = 0;

            AddDeduct := AddDeduct::Addition;
            InsertTempProcRecordsVAD(MonAttendance, 'OT', AddDeduct, FinalTotal);
        END;
    end;

    //  [Scope('Internal')]
    procedure InsertTempProcRecordsVAD(MonAttendance: Record 60029; PayElementCode: Code[20]; "Add/DeductCode": Option " ",Addition,Deduction,Benifits; Amount: Decimal)
    var
        TempProcSalary: Record 60037;
        TempProcSalary2: Record 60037;
        Lookup: Record 60018;
    begin
        IF Amount <> 0 THEN BEGIN
            TempProcSalary.INIT;
            TempProcSalary."Employee Code" := MonAttendance."Employee Code";
            TempProcSalary."Add/Deduct Code" := PayElementCode;
            TempProcSalary."Pay Slip Month" := MonAttendance."Pay Slip Month";
            TempProcSalary.Year := MonAttendance.Year;
            TempProcSalary."Document Type" := TempProcSalary."Document Type"::Payroll;

            TempProcessedSalary.SETRANGE("Document Type", TempProcessedSalary."Document Type"::Payroll);
            TempProcessedSalary.SETRANGE("Employee Code", TempProcSalary."Employee Code");
            TempProcessedSalary.SETRANGE("Pay Slip Month", TempProcSalary."Pay Slip Month");
            TempProcessedSalary.SETRANGE(Year, TempProcSalary.Year);
            IF TempProcessedSalary.FIND('+') THEN
                TempProcSalary."Line No." := TempProcessedSalary."Line No." + 10000
            ELSE
                TempProcSalary."Line No." := 10000;

            HRSetup.FIND('-');
            IF HRSetup."Rounding Type" = HRSetup."Rounding Type"::Up THEN
                RoundType := '>'
            ELSE
                IF HRSetup."Rounding Type" = HRSetup."Rounding Type"::Down THEN
                    RoundType := '<'
                ELSE
                    RoundType := '=';

            TempProcSalary."Earned Amount" := ROUND(Amount, HRSetup."Rounding Precision", RoundType);
            TempProcSalary."Add/Deduct" := "Add/DeductCode";
            TempProcSalary.Attendance := MonAttendance.Attendance;
            TempProcSalary.Days := MonAttendance.Days;

            Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
            Lookup.SETRANGE("Lookup Name", TempProcSalary."Add/Deduct Code");
            IF Lookup.FIND('-') THEN
                TempProcSalary.Priority := Lookup.Priority;

            TempProcSalary.INSERT;
        END;
    end;

    // [Scope('Internal')]
    procedure PTAmount(MonAttendance: Record 60029; GrossAmount: Decimal)
    var
        PT: Record 60045;
        TaxAmount: Decimal;
        BranchCode: Code[20];
    begin
        BranchCode := '';
        Employee.RESET;
        Employee.SETRANGE(Employee."No.", MonAttendance."Employee Code");
        IF Employee.FIND('-') THEN BEGIN
            BranchCode := Employee."Branch Code";
        END;

        PT.RESET;
        PT.SETRANGE(PT."Branch Code", BranchCode);
        IF PT.FIND('-') THEN BEGIN
            REPEAT
                PT.TESTFIELD("Income From");
                PT.TESTFIELD("Income To");
                IF (PT."Income From" <= GrossAmount) AND (PT."Income To" >= GrossAmount) THEN BEGIN
                    IF PT."Effective Date" <= MonAttendance."Period End Date" THEN
                        TaxAmount := PT."Tax Amount";
                END;
            UNTIL PT.NEXT = 0;
            AddDeduct := AddDeduct::Deduction;
            InsertTempProcRecordsVAD(MonAttendance, 'PT', AddDeduct, TaxAmount);
        END;
    end;

    //  [Scope('Internal')]
    procedure ESIAmount(MonAttendance: Record 60029; PayElement: Record 60025; GrossAmount: Decimal)
    var
        ESI: Record 60043;
        Lookup: Record 60018;
        PayYear: Record 60020;
        TempProcSalary: Record 60037;
        ProcSalary: Record 60038;
        EmployerContribution: Decimal;
        EmployeeContribution: Decimal;
        ESIAmount: Decimal;
        GrossSalary: Decimal;
        ESIStartDate: Date;
        ESIEndDate: Date;
        CheckDate: Date;
        Flag: Boolean;
    begin
        TempProcSalary.RESET;
        TempProcSalary.SETRANGE("Employee Code", MonAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Addition);
        IF TempProcSalary.FIND('-') THEN
            REPEAT
                Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                Lookup.SETRANGE("Lookup Name", TempProcSalary."Add/Deduct Code");
                Lookup.SETFILTER(ESI, '<>%1', Lookup.ESI::" ");
                IF Lookup.FIND('-') THEN
                    GrossSalary := GrossSalary + TempProcSalary."Earned Amount";
            UNTIL TempProcSalary.NEXT = 0;

        IF ESI.FIND('-') THEN BEGIN
            REPEAT
                IF GrossAmount < ESI."ESI Salary Amount" THEN BEGIN
                    Flag := TRUE;
                    IF ESI."Effective Date" <= MonAttendance."Period End Date" THEN
                        IF ESI."Rounding Method" = ESI."Rounding Method"::Nearest THEN BEGIN
                            EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '=');
                            EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '=');
                        END ELSE
                            IF ESI."Rounding Method" = ESI."Rounding Method"::Up THEN BEGIN
                                EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '>');
                                EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '>');
                            END ELSE BEGIN
                                EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '<');
                                EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '<');
                            END;
                END ELSE
                    ;
            UNTIL ESI.NEXT = 0;
            AddDeduct := AddDeduct::Deduction;
            InsertESIPFRecords(MonAttendance, EmployeeContribution, EmployerContribution, 0, GrossSalary, 0, 0, 0, 'ESI', AddDeduct);
        END;
        IF NOT Flag THEN BEGIN
            PayYear.SETRANGE("Year Type", 'ESI YEAR');
            PayYear.SETRANGE(Closed, FALSE);
            IF PayYear.FIND('-') THEN
                REPEAT
                    IF (MonAttendance."Period End Date" >= PayYear."Year Start Date") AND
                       (MonAttendance."Period End Date" <= PayYear."Year End Date")
                    THEN BEGIN
                        ESIStartDate := PayYear."Year Start Date";
                        ESIEndDate := PayYear."Year End Date";
                    END;
                UNTIL PayYear.NEXT = 0;

            ProcSalary.RESET;
            ProcSalary.SETRANGE("Employee Code", MonAttendance."Employee Code");
            ProcSalary.SETRANGE(Year, MonAttendance.Year);
            ProcSalary.SETRANGE("Add/Deduct Code", 'ESI');
            IF ProcSalary.FIND('+') THEN BEGIN
                CheckDate := DMY2DATE(1, ProcSalary."Pay Slip Month", ProcSalary.Year);
                IF (CheckDate >= ESIStartDate) AND (CheckDate <= ESIEndDate) THEN BEGIN
                    IF ESI."Rounding Method" = ESI."Rounding Method"::Nearest THEN BEGIN
                        EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '=');
                        EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '=');
                    END ELSE
                        IF ESI."Rounding Method" = ESI."Rounding Method"::Up THEN BEGIN
                            EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '>');
                            EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '>');
                        END ELSE BEGIN
                            EmployerContribution := ROUND((GrossSalary * ESI."Employer %") / 100, ESI."Rounding Amount", '<');
                            EmployeeContribution := ROUND((GrossSalary * ESI."Employee %") / 100, ESI."Rounding Amount", '<');
                        END;
                END;
            END;
            AddDeduct := AddDeduct::Deduction;
            InsertESIPFRecords(MonAttendance, EmployeeContribution, EmployerContribution, 0, GrossSalary, 0, 0, 0, 'ESI', AddDeduct);
        END;
    end;

    // [Scope('Internal')]
    procedure InsertESIPFRecords(MonAttendance: Record 60029; EmployeeContribution: Decimal; EmployerContribution: Decimal; EPFAmt: Decimal; GrossAmount: Decimal; PFAdminCharges: Decimal; EDLICharges: Decimal; RIFACharges: Decimal; PayElementCode: Code[20]; "Add/DeductCode": Option " ",Addition,Deduction,Benifits)
    var
        TempProcSalary: Record 60037;
        TempProcSalary2: Record 60037;
        Lookup: Record 60018;
    begin
        IF EmployeeContribution <> 0 THEN BEGIN
            TempProcSalary.INIT;
            TempProcSalary."Employee Code" := MonAttendance."Employee Code";
            TempProcSalary."Add/Deduct Code" := PayElementCode;
            TempProcSalary."Pay Slip Month" := MonAttendance."Pay Slip Month";
            TempProcSalary.Year := MonAttendance.Year;
            TempProcSalary."Document Type" := TempProcSalary."Document Type"::Payroll;

            TempProcessedSalary.SETRANGE("Document Type", TempProcessedSalary."Document Type"::Payroll);
            TempProcessedSalary.SETRANGE("Employee Code", TempProcSalary."Employee Code");
            TempProcessedSalary.SETRANGE("Pay Slip Month", TempProcSalary."Pay Slip Month");
            TempProcessedSalary.SETRANGE(Year, TempProcSalary.Year);
            IF TempProcessedSalary.FIND('+') THEN
                TempProcSalary."Line No." := TempProcessedSalary."Line No." + 10000
            ELSE
                TempProcSalary."Line No." := 10000;

            TempProcSalary."Earned Amount" := EmployeeContribution;
            TempProcSalary."Co. Contributions" := EmployerContribution;
            TempProcSalary."Co. Contribution2" := EPFAmt;
            TempProcSalary."PF Admin Charges" := PFAdminCharges;
            TempProcSalary."EDLI Charges" := EDLICharges;
            TempProcSalary."RIFA Charges" := RIFACharges;
            TempProcSalary."Add/Deduct" := "Add/DeductCode";
            TempProcSalary.Attendance := MonAttendance.Attendance;
            TempProcSalary.Days := MonAttendance.Days;
            TempProcSalary.Salary := GrossAmount;

            Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
            Lookup.SETRANGE("Lookup Name", TempProcSalary."Add/Deduct Code");
            IF Lookup.FIND('-') THEN
                TempProcSalary.Priority := Lookup.Priority;

            TempProcSalary.INSERT;
        END;
    end;

    //  [Scope('Internal')]
    procedure PFAmount(MonAttendance: Record 60029; PayElement: Record 60025; GrossAmount: Decimal; EDLIGross: Decimal)
    var
        PF: Record 60042;
        PFAmount: Decimal;
        EmployerContribution: Decimal;
        EmployeeContribution: Decimal;
        EPSAmount: Decimal;
        PFAdminCharges: Decimal;
        EDLICharges: Decimal;
        RIFACharges: Decimal;
    begin
        //Gross Salary is less than the PF Salary Limit
        Flag := FALSE;
        IF PF.FIND('-') THEN BEGIN
            //UD 28-11-2007 for calculating on PF Amount when Gross Amount greater than PF Amount >>
            //ve
            emp1.RESET;
            emp1.SETRANGE("No.", MonAttendance."Employee Code");
            emp1.SETRANGE(PF, TRUE);
            IF emp1.FIND('-') THEN BEGIN
                PF."PF Amount" := GrossAmount;
                Flag := TRUE;
            END ELSE BEGIN

                IF GrossAmount > PF."PF Amount" THEN
                    GrossAmount := PF."PF Amount";
                //UD 28-11-2007 <<
            END;
            REPEAT
                IF GrossAmount < PF."PF Amount" THEN BEGIN
                    IF PF."Effective Date" <= MonAttendance."Period End Date" THEN
                        IF PF."Rounding Method" = PF."Rounding Method"::Nearest THEN BEGIN
                            EmployerContribution := ROUND((GrossAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '=');
                            EmployeeContribution := ROUND((GrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '=');
                            EPSAmount := ROUND((GrossAmount * PF."EPS %") / 100, PF."Rounding Amount", '=');
                        END ELSE
                            IF PF."Rounding Method" = PF."Rounding Method"::Up THEN BEGIN
                                EmployerContribution := ROUND((GrossAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '>');
                                EmployeeContribution := ROUND((GrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '>');
                                EPSAmount := ROUND((GrossAmount * PF."EPS %") / 100, PF."Rounding Amount", '>');
                            END ELSE BEGIN
                                EmployerContribution := ROUND((GrossAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '<');
                                EmployeeContribution := ROUND((GrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '<');
                                EPSAmount := ROUND((GrossAmount * PF."EPS %") / 100, PF."Rounding Amount", '<');
                            END;
                END ELSE BEGIN
                    //Gross Salary is greater than the PF Salary Limit
                    IF PF."Effective Date" <= MonAttendance."Period End Date" THEN
                        IF PF."Rounding Method" = PF."Rounding Method"::Nearest THEN BEGIN
                            EPSAmount := ROUND((PF."PF Amount" * PF."EPS %") / 100, PF."Rounding Amount", '=');
                            EmployerContribution := ROUND((GrossAmount * (PF."EPS %" + PF."Employer Contribution")) / 100, PF."Rounding Amount", '=')
                                                      - EPSAmount;
                            EmployeeContribution := ROUND((GrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '=');
                        END ELSE
                            IF PF."Rounding Method" = PF."Rounding Method"::Up THEN BEGIN
                                EPSAmount := ROUND((PF."PF Amount" * PF."EPS %") / 100, PF."Rounding Amount", '>');
                                EmployerContribution := ROUND((GrossAmount * (PF."EPS %" + PF."Employer Contribution")) / 100, PF."Rounding Amount", '>')
                                                          - EPSAmount;
                                EmployeeContribution := ROUND((GrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '>');
                            END ELSE BEGIN
                                EPSAmount := ROUND((PF."PF Amount" * PF."EPS %") / 100, PF."Rounding Amount", '<');
                                EmployerContribution := ROUND((GrossAmount * (PF."EPS %" + PF."Employer Contribution")) / 100, PF."Rounding Amount", '<')
                                                          - EPSAmount;
                                EmployeeContribution := ROUND((GrossAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '<');
                            END;
                END;

                //PF Admin Charges//
                PFAdminCharges := (GrossAmount * PF."Admin Charges %") / 100;
                //PF Admin Charges//

                //EDLI Charges//
                EDLICharges := (GrossAmount * PF."EDLI %") / 100;
                //EDLI Charges//

                //RIFA Charges//
                RIFACharges := (GrossAmount * PF."RIFA %") / 100;
            //RIFA Charges//


            UNTIL PF.NEXT = 0;

            AddDeduct := AddDeduct::Deduction;
            InsertESIPFRecords(MonAttendance, EmployeeContribution, EmployerContribution, EPSAmount, GrossAmount,
                                 PFAdminCharges, EDLICharges, RIFACharges, 'PF', AddDeduct);
        END;
    end;

    // [Scope('Internal')]
    procedure CalcPTGrossSalary(MonAttendance: Record 60029)
    var
        DailyAttendance: Record 60028;
        PayElements: Record 60025;
        VAD: Record 60025;
        VAD2: Record 60025;
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        "Sum": Decimal;
        NoofDays: Decimal;
        Sum2: Decimal;
        NoofDays2: Decimal;
        Lop: Decimal;
        NotJoined: Decimal;
        GrossSalary: Decimal;
        StartDate: Date;
        EndDate: Date;
        StartDate2: Date;
        CheckDate: Date;
    begin
        PayElements.RESET;
        PayElements.SETCURRENTKEY("Employee Code", "Pay Element Code");
        PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
        PayElements.SETRANGE(Processed, FALSE);
        PayElements.SETRANGE(PT, TRUE);
        IF PayElements.FIND('-') THEN BEGIN
            REPEAT
                MonAttendance.CALCFIELDS(MonAttendance.Days);
                Total := 0;
                Sum := 0;
                StartDate := MonAttendance."Period Start Date";
                EndDate := MonAttendance."Period End Date";
                VAD.RESET;
                VAD.SETRANGE("Employee Code", PayElements."Employee Code");
                VAD.SETRANGE("Pay Element Code", PayElements."Pay Element Code");
                VAD.SETRANGE(PT, TRUE);
                IF VAD.FIND('-') THEN
                    REPEAT
                        NoofDays2 := 0;
                        NoofDays := 0;
                        Lop := 0;
                        NotJoined := 0;
                        IF (VAD."Effective Start Date" >= StartDate) AND (VAD."Effective Start Date" <= EndDate) THEN BEGIN
                            NoofDays2 := VAD."Effective Start Date" - StartDate;
                            DailyAttendance.RESET;
                            DailyAttendance.SETFILTER(Date, '%1..%2', StartDate, VAD."Effective Start Date");
                            DailyAttendance.SETRANGE("Employee No.", VAD."Employee Code");
                            DailyAttendance.SETFILTER(Absent, '<>0');
                            IF DailyAttendance.FIND('-') THEN
                                REPEAT
                                    Lop := Lop + DailyAttendance.Absent;
                                UNTIL DailyAttendance.NEXT = 0;

                            DailyAttendance.RESET;
                            DailyAttendance.SETFILTER(Date, '%1..%2', StartDate, VAD."Effective Start Date");
                            DailyAttendance.SETRANGE("Employee No.", VAD."Employee Code");
                            DailyAttendance.SETFILTER("Not Joined", '<>0');
                            IF DailyAttendance.FIND('-') THEN
                                REPEAT
                                    NotJoined := NotJoined + DailyAttendance."Not Joined";
                                UNTIL DailyAttendance.NEXT = 0;
                            NoofDays := NoofDays2 - (Lop + NotJoined);
                            StartDate2 := StartDate;
                            StartDate := VAD."Effective Start Date";
                            VAD2.RESET;
                            VAD2.SETRANGE("Employee Code", VAD."Employee Code");
                            VAD2.SETRANGE("Pay Element Code", VAD."Pay Element Code");
                            VAD2.SETRANGE(PT, TRUE);
                            IF VAD2.FIND('-') THEN BEGIN
                                CheckDate := VAD2."Effective Start Date";
                                REPEAT
                                    VAD2.Processed := TRUE;
                                    VAD2.MODIFY;
                                    IF (VAD2."Effective Start Date" >= CheckDate) AND (VAD2."Effective Start Date" <= StartDate2) THEN BEGIN
                                        IF VAD2."Pay Element Code" = 'BASIC' THEN BEGIN
                                            IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                                Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                                Basic := Total;
                                            END ELSE
                                                IF (VAD2."Computation Type" = 'NON ATTENDANCE') THEN BEGIN
                                                    Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                                    Basic := Total;
                                                END;
                                        END ELSE BEGIN
                                            IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) THEN BEGIN
                                                IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN
                                                    Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent"
                                                ELSE
                                                    Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
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
                VAD2.SETRANGE(PT, TRUE);
                IF VAD2.FIND('-') THEN BEGIN
                    Lop := 0;
                    NotJoined := 0;
                    CheckDate := VAD2."Effective Start Date";
                    NoofDays2 := EndDate - StartDate + 1;
                    DailyAttendance.RESET;
                    DailyAttendance.SETFILTER(Date, '%1..%2', StartDate, EndDate);
                    DailyAttendance.SETRANGE("Employee No.", VAD."Employee Code");
                    DailyAttendance.SETFILTER(Absent, '<>0');
                    IF DailyAttendance.FIND('-') THEN
                        REPEAT
                            Lop := Lop + DailyAttendance.Absent;
                        UNTIL DailyAttendance.NEXT = 0;

                    DailyAttendance.RESET;
                    DailyAttendance.SETFILTER(Date, '%1..%2', StartDate, EndDate);
                    DailyAttendance.SETRANGE("Employee No.", VAD."Employee Code");
                    DailyAttendance.SETFILTER("Not Joined", '<>0');
                    IF DailyAttendance.FIND('-') THEN
                        REPEAT
                            NotJoined := NotJoined + DailyAttendance."Not Joined";
                        UNTIL DailyAttendance.NEXT = 0;
                    NoofDays := NoofDays2 - (Lop + NotJoined);
                    REPEAT
                        VAD2.Processed := TRUE;
                        VAD2.MODIFY;
                        IF (VAD2."Effective Start Date" >= CheckDate) AND (VAD2."Effective Start Date" <= StartDate) THEN BEGIN
                            IF VAD2."Pay Element Code" = 'BASIC' THEN BEGIN
                                IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                    Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                    Basic := Total;
                                END ELSE
                                    IF (VAD2."Computation Type" = 'NON ATTENDANCE') THEN BEGIN
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                        Basic := Total;
                                    END;
                            END ELSE BEGIN
                                IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) THEN BEGIN
                                    IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent"
                                    ELSE
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
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
                        Sum := Total;
                    UNTIL VAD2.NEXT = 0;
                END;
                GrossSalary := GrossSalary + Sum;
            UNTIL PayElements.NEXT = 0;
            PayElements.RESET;
            PayElements.SETRANGE(PayElements."Employee Code", MonAttendance."Employee Code");
            IF PayElements.FIND('-') THEN
                REPEAT
                    PayElements.Processed := FALSE;
                    PayElements.MODIFY;
                UNTIL PayElements.NEXT = 0;
            PTAmount(MonAttendance, GrossSalary);
        END;
    end;

    //  [Scope('Internal')]
    procedure CalcESITaxAmt(MonAttendance: Record 60029)
    var
        DailyAttendance: Record 60028;
        PayElements: Record 60025;
        VAD: Record 60025;
        VAD2: Record 60025;
        Basic: Decimal;
        DA: Decimal;
        Total: Decimal;
        "Sum": Decimal;
        Sum2: Decimal;
        NoofDays: Decimal;
        NoofDays2: Decimal;
        Lop: Decimal;
        NotJoined: Decimal;
        GrossSalary: Decimal;
        StartDate: Date;
        EndDate: Date;
        StartDate2: Date;
        CheckDate: Date;
    begin
        PayElements.RESET;
        PayElements.SETCURRENTKEY("Employee Code", "Pay Element Code");
        PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
        PayElements.SETRANGE(Processed, FALSE);
        PayElements.SETRANGE(ESI, PayElements.ESI::"Regular Element");
        IF PayElements.FIND('-') THEN BEGIN
            REPEAT
                MonAttendance.CALCFIELDS(MonAttendance.Days);
                Total := 0;
                Sum := 0;
                StartDate := MonAttendance."Period Start Date";
                EndDate := MonAttendance."Period End Date";
                VAD.RESET;
                VAD.SETRANGE("Employee Code", PayElements."Employee Code");
                VAD.SETRANGE("Pay Element Code", PayElements."Pay Element Code");
                VAD.SETRANGE(ESI, PayElements.ESI::"Regular Element");
                IF VAD.FIND('-') THEN
                    REPEAT
                        NoofDays2 := 0;
                        NoofDays := 0;
                        Lop := 0;
                        NotJoined := 0;
                        IF (VAD."Effective Start Date" > StartDate) AND (VAD."Effective Start Date" <= EndDate) THEN BEGIN
                            NoofDays2 := VAD."Effective Start Date" - StartDate;
                            DailyAttendance.RESET;
                            DailyAttendance.SETFILTER(Date, '%1..%2', StartDate, VAD."Effective Start Date");
                            DailyAttendance.SETRANGE("Employee No.", VAD."Employee Code");
                            DailyAttendance.SETFILTER(Absent, '<>0');
                            IF DailyAttendance.FIND('-') THEN
                                REPEAT
                                    Lop := Lop + DailyAttendance.Absent;
                                UNTIL DailyAttendance.NEXT = 0;

                            DailyAttendance.RESET;
                            DailyAttendance.SETFILTER(Date, '%1..%2', StartDate, VAD."Effective Start Date");
                            DailyAttendance.SETRANGE("Employee No.", VAD."Employee Code");
                            DailyAttendance.SETFILTER("Not Joined", '<>0');
                            IF DailyAttendance.FIND('-') THEN
                                REPEAT
                                    NotJoined := NotJoined + DailyAttendance."Not Joined";
                                UNTIL DailyAttendance.NEXT = 0;

                            NoofDays := NoofDays2 - (Lop + NotJoined);
                            StartDate2 := StartDate;
                            StartDate := VAD."Effective Start Date";
                            VAD2.RESET;
                            VAD2.SETRANGE("Employee Code", VAD."Employee Code");
                            VAD2.SETRANGE("Pay Element Code", VAD."Pay Element Code");
                            VAD2.SETRANGE(ESI, PayElements.ESI::"Regular Element");
                            IF VAD2.FIND('-') THEN BEGIN
                                CheckDate := VAD2."Effective Start Date";
                                REPEAT
                                    VAD2.Processed := TRUE;
                                    VAD2.MODIFY;
                                    IF (VAD2."Effective Start Date" >= CheckDate) AND (VAD2."Effective Start Date" <= StartDate2) THEN BEGIN
                                        IF VAD2."Pay Element Code" = 'BASIC' THEN BEGIN
                                            IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                                Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                                Basic := Total;
                                            END ELSE
                                                IF (VAD2."Computation Type" = 'NON ATTENDANCE') THEN BEGIN
                                                    Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                                    Basic := Total;
                                                END;
                                        END ELSE BEGIN
                                            IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) THEN BEGIN
                                                IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN
                                                    Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent"
                                                ELSE
                                                    Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
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
                VAD2.SETRANGE(ESI, PayElements.ESI::"Regular Element");
                IF VAD2.FIND('-') THEN BEGIN
                    Lop := 0;
                    NotJoined := 0;
                    CheckDate := VAD2."Effective Start Date";
                    NoofDays2 := EndDate - StartDate + 1;
                    DailyAttendance.RESET;
                    DailyAttendance.SETFILTER(Date, '%1..%2', StartDate, EndDate);
                    DailyAttendance.SETRANGE("Employee No.", VAD."Employee Code");
                    DailyAttendance.SETFILTER(Absent, '<>0');
                    IF DailyAttendance.FIND('-') THEN
                        REPEAT
                            Lop := Lop + DailyAttendance.Absent;
                        UNTIL DailyAttendance.NEXT = 0;

                    DailyAttendance.RESET;
                    DailyAttendance.SETFILTER(Date, '%1..%2', StartDate, EndDate);
                    DailyAttendance.SETRANGE("Employee No.", VAD."Employee Code");
                    DailyAttendance.SETFILTER("Not Joined", '<>0');
                    IF DailyAttendance.FIND('-') THEN
                        REPEAT
                            NotJoined := NotJoined + DailyAttendance."Not Joined";
                        UNTIL DailyAttendance.NEXT = 0;

                    NoofDays := NoofDays2 - (Lop + NotJoined);
                    REPEAT
                        VAD2.Processed := TRUE;
                        VAD2.MODIFY;
                        IF (VAD2."Effective Start Date" >= CheckDate) AND (VAD2."Effective Start Date" <= StartDate) THEN BEGIN
                            IF VAD2."Pay Element Code" = 'BASIC' THEN BEGIN
                                IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                    Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                    Basic := Total;
                                END ELSE
                                    IF (VAD2."Computation Type" = 'NON ATTENDANCE') THEN BEGIN
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                        Basic := Total;
                                    END;
                            END ELSE BEGIN
                                IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) THEN BEGIN
                                    IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent"
                                    ELSE
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
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
                        Sum := Total;
                    UNTIL VAD2.NEXT = 0;
                END;
                GrossSalary := GrossSalary + Sum;

            UNTIL PayElements.NEXT = 0;
            PayElements.RESET;
            PayElements.SETRANGE(PayElements."Employee Code", MonAttendance."Employee Code");
            IF PayElements.FIND('-') THEN
                REPEAT
                    PayElements.Processed := FALSE;
                    PayElements.MODIFY;
                UNTIL PayElements.NEXT = 0;
            ESIAmount(MonAttendance, VAD2, GrossSalary);
        END;
    end;

    // [Scope('Internal')]
    procedure CalcPFTaxAmt(MonAttendance: Record 60029)
    var
        DailyAttendance: Record 60028;
        PayElements: Record 60025;
        VAD: Record 60025;
        VAD2: Record 60025;
        Basic: Decimal;
        DA: Decimal;
        Total: Decimal;
        "Sum": Decimal;
        Sum2: Decimal;
        NoofDays: Decimal;
        NoofDays2: Decimal;
        Lop: Decimal;
        NotJoined: Decimal;
        GrossSalary: Decimal;
        StartDate: Date;
        EndDate: Date;
        StartDate2: Date;
        CheckDate: Date;
        EDLIGross: Decimal;
        TotalDays: Decimal;
    begin
        PayElements.RESET;
        PayElements.SETCURRENTKEY("Employee Code", "Pay Element Code");
        PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
        PayElements.SETRANGE(Processed, FALSE);
        PayElements.SETRANGE(PF, TRUE);
        IF PayElements.FIND('-') THEN BEGIN
            REPEAT
                MonAttendance.CALCFIELDS(MonAttendance.Days);
                Total := 0;
                Sum := 0;
                StartDate := MonAttendance."Period Start Date";
                EndDate := MonAttendance."Period End Date";
                VAD.RESET;
                VAD.SETRANGE("Employee Code", PayElements."Employee Code");
                VAD.SETRANGE("Pay Element Code", PayElements."Pay Element Code");
                VAD.SETRANGE(PF, TRUE);
                IF VAD.FIND('-') THEN
                    REPEAT
                        NoofDays2 := 0;
                        NoofDays := 0;
                        Lop := 0;
                        NotJoined := 0;
                        IF (VAD."Effective Start Date" > StartDate) AND (VAD."Effective Start Date" <= EndDate) THEN BEGIN
                            NoofDays2 := VAD."Effective Start Date" - StartDate;

                            //VE-003 - VE-026 >>
                            /*
                            DailyAttendance.RESET;
                            DailyAttendance.SETFILTER(Date,'%1..%2',StartDate,VAD."Effective Start Date");
                            DailyAttendance.SETRANGE("Employee No.",VAD."Employee Code");
                            DailyAttendance.SETFILTER(Absent,'<>0');
                            IF DailyAttendance.FIND('-') THEN
                              REPEAT
                                Lop := Lop + DailyAttendance.Absent;
                              UNTIL DailyAttendance.NEXT = 0;

                            DailyAttendance.RESET;
                            DailyAttendance.SETFILTER(Date,'%1..%2',StartDate,VAD."Effective Start Date");
                            DailyAttendance.SETRANGE("Employee No.",VAD."Employee Code");
                            DailyAttendance.SETFILTER("Not Joined",'<>0');
                            IF DailyAttendance.FIND('-') THEN
                              REPEAT
                                NotJoined := NotJoined + DailyAttendance."Not Joined";
                              UNTIL DailyAttendance.NEXT = 0;

                            NoofDays := NoofDays2 - (Lop + NotJoined);
                            */

                            NoofDays := MonAttendance."No.Of Payroll Days";  //ve-026
                            TotalDays := NoofDays + MonAttendance."Loss Of Pay";//ve-026

                            StartDate2 := StartDate;
                            StartDate := VAD."Effective Start Date";
                            VAD2.RESET;
                            VAD2.SETRANGE("Employee Code", VAD."Employee Code");
                            VAD2.SETRANGE("Pay Element Code", VAD."Pay Element Code");
                            VAD2.SETRANGE(PF, TRUE);
                            IF VAD2.FIND('-') THEN BEGIN
                                CheckDate := VAD2."Effective Start Date";
                                REPEAT
                                    VAD2.Processed := TRUE;
                                    VAD2.MODIFY;
                                    IF (VAD2."Effective Start Date" >= CheckDate) AND (VAD2."Effective Start Date" <= StartDate2) THEN BEGIN
                                        IF VAD2."Pay Element Code" = 'BASIC' THEN BEGIN
                                            IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                                IF TotalDays <> MonAttendance.Days THEN //VE-026
                                                                                        //Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent"; //VE-003 & VE-026
                                                  BEGIN
                                                    IF TotalDays <> 0 THEN   //PARAMITA
                                                        Total := ((NoofDays) / TotalDays) * VAD2."Amount / Percent";
                                                END
                                                ELSE
                                                    Total := ((NoofDays) / MonAttendance.Days) * VAD2."Amount / Percent";

                                                Basic := Total;
                                            END ELSE
                                                IF (VAD2."Computation Type" = 'NON ATTENDANCE') THEN BEGIN
                                                    Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                                    Basic := Total;
                                                END;
                                        END ELSE BEGIN
                                            IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) THEN BEGIN
                                                IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN
                                                    IF TotalDays <> MonAttendance.Days THEN
                                                    //Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent" //VE-003 & VE-026
                                                    BEGIN
                                                        IF TotalDays <> 0 THEN   //PARAMITA
                                                            Total := ((NoofDays) / TotalDays) * VAD2."Amount / Percent";
                                                    END
                                                    ELSE
                                                        Total := ((NoofDays) / MonAttendance.Days) * VAD2."Amount / Percent"
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
                VAD2.SETRANGE(PF, TRUE);
                IF VAD2.FIND('-') THEN BEGIN
                    Lop := 0;
                    NotJoined := 0;
                    CheckDate := VAD2."Effective Start Date";
                    NoofDays2 := EndDate - StartDate + 1;

                    //VE-003 & VE-026 >>
                    /*
                    DailyAttendance.RESET;
                    DailyAttendance.SETFILTER(Date,'%1..%2',StartDate,EndDate);
                    DailyAttendance.SETRANGE("Employee No.",VAD."Employee Code");
                    DailyAttendance.SETFILTER(Absent,'<>0');
                    IF DailyAttendance.FIND('-') THEN
                      REPEAT
                        Lop := Lop + DailyAttendance.Absent;
                      UNTIL DailyAttendance.NEXT = 0;

                      DailyAttendance.RESET;
                      DailyAttendance.SETFILTER(Date,'%1..%2',StartDate,EndDate);
                      DailyAttendance.SETRANGE("Employee No.",VAD."Employee Code");
                      DailyAttendance.SETFILTER("Not Joined",'<>0');
                      IF DailyAttendance.FIND('-') THEN
                        REPEAT
                          NotJoined := NotJoined + DailyAttendance."Not Joined";
                        UNTIL DailyAttendance.NEXT = 0;

                      NoofDays := NoofDays2 - (Lop + NotJoined);
                     */
                    NoofDays := MonAttendance."No.Of Payroll Days";//ve-026
                    TotalDays := NoofDays + MonAttendance."Loss Of Pay";//ve-026

                    REPEAT
                        VAD2.Processed := TRUE;
                        VAD2.MODIFY;
                        IF (VAD2."Effective Start Date" >= CheckDate) AND (VAD2."Effective Start Date" <= StartDate) THEN BEGIN
                            IF VAD2."Pay Element Code" = 'BASIC' THEN BEGIN
                                IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                    IF TotalDays <> MonAttendance.Days THEN
                                    //Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent"; //VE-003 & VE-026
                                    BEGIN
                                        IF TotalDays <> 0 THEN   //PARAMITA
                                            Total := ((NoofDays) / TotalDays) * VAD2."Amount / Percent";
                                    END
                                    ELSE
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";

                                    Basic := Total;
                                END ELSE
                                    IF (VAD2."Computation Type" = 'NON ATTENDANCE') THEN BEGIN
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                        Basic := Total;
                                    END;
                            END ELSE BEGIN
                                IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) THEN BEGIN
                                    IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                        /*
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent"
                                      ELSE
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                        */
                                        IF TotalDays <> MonAttendance.Days THEN BEGIN
                                            IF TotalDays <> 0 THEN   //PARAMITA
                                                Total := ((NoofDays) / TotalDays) * VAD2."Amount / Percent";
                                        END
                                        ELSE
                                            Total := ((NoofDays) / MonAttendance.Days) * VAD2."Amount / Percent"
                                    END ELSE BEGIN
                                        IF TotalDays <> MonAttendance.Days THEN BEGIN
                                            IF TotalDays <> 0 THEN   //PARAMITA
                                                Total := ((NoofDays) / TotalDays) * VAD2."Amount / Percent";
                                        END
                                        ELSE
                                            Total := (NoofDays2 / MonAttendance.Days) * VAD2."Amount / Percent";
                                    END;

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
                        Sum := Total;
                    UNTIL VAD2.NEXT = 0;
                END;
                GrossSalary := GrossSalary + Sum;
            UNTIL PayElements.NEXT = 0;
            IF PayElements.FIND('-') THEN
                REPEAT
                    PayElements.Processed := FALSE;
                    PayElements.MODIFY;
                UNTIL PayElements.NEXT = 0;
            //PFAmount(MonAttendance,VAD2,GrossSalary);
            //END;


            //EDLI Charges//

            PayElements.RESET;
            PayElements.SETCURRENTKEY("Employee Code", "Pay Element Code");
            PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
            PayElements.SETRANGE(PF, TRUE);
            IF PayElements.FIND('-') THEN BEGIN
                REPEAT
                    MonAttendance.CALCFIELDS(MonAttendance.Days);
                    Total := 0;
                    Sum := 0;
                    StartDate := MonAttendance."Period Start Date";
                    EndDate := MonAttendance."Period End Date";
                    VAD.RESET;
                    VAD.SETRANGE("Employee Code", PayElements."Employee Code");
                    VAD.SETRANGE("Pay Element Code", PayElements."Pay Element Code");
                    VAD.SETRANGE(PF, TRUE);
                    IF VAD.FIND('-') THEN
                        REPEAT
                            NoofDays := 0;
                            IF (VAD."Effective Start Date" > StartDate) AND (VAD."Effective Start Date" <= EndDate) THEN BEGIN
                                //NoofDays2 := VAD."Effective Start Date" - StartDate;
                                NoofDays := MonAttendance.Days;
                                StartDate2 := StartDate;
                                StartDate := VAD."Effective Start Date";
                                VAD2.RESET;
                                VAD2.SETRANGE("Employee Code", VAD."Employee Code");
                                VAD2.SETRANGE("Pay Element Code", VAD."Pay Element Code");
                                VAD2.SETRANGE(ESI, PayElements.ESI::"Regular Element");
                                IF VAD2.FIND('-') THEN BEGIN
                                    CheckDate := VAD2."Effective Start Date";
                                    REPEAT
                                        VAD2.Processed := TRUE;
                                        VAD2.MODIFY;
                                        IF (VAD2."Effective Start Date" >= CheckDate) AND (VAD2."Effective Start Date" <= StartDate2) THEN BEGIN
                                            IF VAD2."Pay Element Code" = 'BASIC' THEN BEGIN
                                                IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                                    Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                                    Basic := Total;
                                                END ELSE
                                                    IF (VAD2."Computation Type" = 'NON ATTENDANCE') THEN BEGIN
                                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                                        Basic := Total;
                                                    END;
                                            END ELSE BEGIN
                                                IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) THEN BEGIN
                                                    IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN
                                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent"
                                                    ELSE
                                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
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
                    VAD2.SETRANGE(PF, TRUE);
                    IF VAD2.FIND('-') THEN BEGIN
                        CheckDate := VAD2."Effective Start Date";
                        //NoofDays2 := EndDate - StartDate + 1;
                        NoofDays := MonAttendance.Days;
                        REPEAT
                            VAD2.Processed := TRUE;
                            VAD2.MODIFY;
                            IF (VAD2."Effective Start Date" >= CheckDate) AND (VAD2."Effective Start Date" <= StartDate) THEN BEGIN
                                IF VAD2."Pay Element Code" = 'BASIC' THEN BEGIN
                                    IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                                        Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                        Basic := Total;
                                    END ELSE
                                        IF (VAD2."Computation Type" = 'NON ATTENDANCE') THEN BEGIN
                                            Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
                                            Basic := Total;
                                        END;
                                END ELSE BEGIN
                                    IF (VAD2."Fixed/Percent" = VAD2."Fixed/Percent"::Fixed) THEN BEGIN
                                        IF (VAD2."Computation Type" = 'ON ATTENDANCE') THEN
                                            Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent"
                                        ELSE
                                            Total := (NoofDays / MonAttendance.Days) * VAD2."Amount / Percent";
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
                            Sum := Total;
                        UNTIL VAD2.NEXT = 0;
                    END;
                    EDLIGross := EDLIGross + Sum;
                UNTIL PayElements.NEXT = 0;
                PayElements.RESET;
                PayElements.SETRANGE(PayElements."Employee Code", MonAttendance."Employee Code");
                IF PayElements.FIND('-') THEN
                    REPEAT
                        PayElements.Processed := FALSE;
                        PayElements.MODIFY;
                    UNTIL PayElements.NEXT = 0;
            END;

            PFAmount(MonAttendance, VAD2, GrossSalary, EDLIGross);
        END;

    end;

    // [Scope('Internal')]
    procedure CalcBonusAmt(MonAttendance: Record 60029)
    var
        TempProcSalary: Record 60037;
        PayElements: Record 60025;
        Bonus: Record 60052;
        BonussableAmt: Decimal;
        BonusOnAttendance: Decimal;
        BonusAmount: Decimal;
        TotalBonus: Decimal;
        TotalExgratia: Decimal;
        TotalExgratiaBonus: Decimal;
        ExgratiaAmount: Decimal;
        BonusCalculation: Boolean;
        ExgratiaCalculation: Boolean;
        BonusorExgratia: Code[20];
    begin
        Lookup.RESET;
        Lookup.SETRANGE("LookupType Name", 'PAY CADRE');
        Lookup.SETRANGE("Lookup Name", MonAttendance.PayCadre);
        IF Lookup.FIND('-') THEN BEGIN
            IF Lookup."Incentive Applicable" = Lookup."Incentive Applicable"::Bonus THEN
                BonusCalculation := TRUE
            ELSE
                IF Lookup."Incentive Applicable" = Lookup."Incentive Applicable"::"Ex-gratia" THEN
                    ExgratiaCalculation := TRUE
        END;

        IF BonusCalculation THEN BEGIN
            BonusAmount := 0;
            PayElements.RESET;
            PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
            IF PayElements.FIND('-') THEN
                REPEAT
                    IF (PayElements."Bonus/Exgratia" <> PayElements."Bonus/Exgratia"::" ") AND
                       (PayElements."Bonus/Exgratia" <> PayElements."Bonus/Exgratia"::"Ex-gratia")
                    THEN BEGIN
                        TempProcSalary.SETRANGE("Employee Code", PayElements."Employee Code");
                        TempProcSalary.SETRANGE("Pay Slip Month", MonAttendance."Pay Slip Month");
                        TempProcSalary.SETRANGE(Year, MonAttendance.Year);
                        TempProcSalary.SETRANGE("Add/Deduct Code", PayElements."Pay Element Code");
                        IF TempProcSalary.FIND('-') THEN BEGIN
                            IF TempProcSalary."Add/Deduct" = TempProcSalary."Add/Deduct"::Addition THEN
                                BonusAmount := BonusAmount + TempProcSalary."Earned Amount"
                            ELSE
                                IF TempProcSalary."Add/Deduct" = TempProcSalary."Add/Deduct"::Deduction THEN
                                    BonusAmount := BonusAmount - TempProcSalary."Earned Amount"
                        END;
                    END;
                UNTIL PayElements.NEXT = 0;

            Bonus.RESET;
            IF Bonus.FIND('-') THEN BEGIN
                REPEAT
                    IF Bonus."Effective Date" <= MonAttendance."Period End Date" THEN
                        BonussableAmt := Bonus."Min.Bonus sable Salary";
                UNTIL Bonus.NEXT = 0;
            END;

            MonAttendance.CALCFIELDS(Days);
            MonAttendance.CALCFIELDS(Attendance);
            BonusOnAttendance := (BonussableAmt * MonAttendance.Attendance) / MonAttendance.Days;

            IF BonusOnAttendance < BonusAmount THEN
                TotalBonus := BonusOnAttendance
            ELSE
                TotalBonus := BonusAmount;

            BonusorExgratia := 'BONUS';
            InsertBonusRecords(MonAttendance, TotalBonus, BonusorExgratia);
        END;

        IF ExgratiaCalculation THEN BEGIN
            ExgratiaAmount := 0;
            PayElements.RESET;
            PayElements.SETRANGE("Employee Code", MonAttendance."Employee Code");
            IF PayElements.FIND('-') THEN
                REPEAT
                    IF (PayElements."Bonus/Exgratia" <> PayElements."Bonus/Exgratia"::" ") AND
                       (PayElements."Bonus/Exgratia" <> PayElements."Bonus/Exgratia"::Bonus)
                    THEN BEGIN
                        TempProcSalary.SETRANGE("Employee Code", PayElements."Employee Code");
                        TempProcSalary.SETRANGE("Pay Slip Month", MonAttendance."Pay Slip Month");
                        TempProcSalary.SETRANGE(Year, MonAttendance.Year);
                        TempProcSalary.SETRANGE("Add/Deduct Code", PayElements."Pay Element Code");
                        IF TempProcSalary.FIND('-') THEN BEGIN
                            IF TempProcSalary."Add/Deduct" = TempProcSalary."Add/Deduct"::Addition THEN
                                ExgratiaAmount := ExgratiaAmount + TempProcSalary."Earned Amount"
                            ELSE
                                IF TempProcSalary."Add/Deduct" = TempProcSalary."Add/Deduct"::Deduction THEN
                                    ExgratiaAmount := ExgratiaAmount - TempProcSalary."Earned Amount"
                        END;
                    END;
                UNTIL PayElements.NEXT = 0;

            Bonus.RESET;
            IF Bonus.FIND('-') THEN BEGIN
                REPEAT
                    IF Bonus."Effective Date" <= MonAttendance."Period End Date" THEN
                        BonussableAmt := Bonus."Bonus Amount";
                    ;
                    TotalExgratiaBonus := Bonus."Min.Bonus sable Salary";
                UNTIL Bonus.NEXT = 0;
            END;

            IF ExgratiaAmount < BonussableAmt THEN BEGIN
                TotalExgratiaBonus := TotalExgratiaBonus;
                TotalExgratia := BonussableAmt - TotalExgratiaBonus;
                BonusorExgratia := 'BONUS';
                InsertBonusRecords(MonAttendance, TotalExgratiaBonus, BonusorExgratia);
                BonusorExgratia := 'Ex-Gratia';
                InsertBonusRecords(MonAttendance, TotalExgratia, BonusorExgratia);
            END ELSE BEGIN
                TotalExgratia := ExgratiaAmount;
                BonusorExgratia := 'Ex-Gratia';
                InsertBonusRecords(MonAttendance, TotalExgratia, BonusorExgratia);
            END;
        END;
    end;

    //  [Scope('Internal')]
    procedure InsertBonusRecords(MonAttendance: Record 60029; Total: Decimal; bonusorexgratia: Code[20])
    var
        TempProcSalary: Record 60037;
        TempProcSalary2: Record 60037;
        Lookup: Record 60018;
    begin
        TempProcSalary.INIT;
        TempProcSalary."Employee Code" := MonAttendance."Employee Code";
        TempProcSalary."Add/Deduct Code" := bonusorexgratia;
        TempProcSalary."Pay Slip Month" := MonAttendance."Pay Slip Month";
        TempProcSalary.Year := MonAttendance.Year;
        TempProcSalary."Document Type" := TempProcSalary."Document Type"::Payroll;

        TempProcessedSalary.SETRANGE("Document Type", TempProcessedSalary."Document Type"::Payroll);
        TempProcessedSalary.SETRANGE("Employee Code", TempProcSalary."Employee Code");
        TempProcessedSalary.SETRANGE("Pay Slip Month", TempProcSalary."Pay Slip Month");
        TempProcessedSalary.SETRANGE(Year, TempProcSalary.Year);
        IF TempProcessedSalary.FIND('+') THEN
            TempProcSalary."Line No." := TempProcessedSalary."Line No." + 10000
        ELSE
            TempProcSalary."Line No." := 10000;

        TempProcSalary."Fixed/Percent" := TempProcSalary."Fixed/Percent"::Fixed;
        TempProcSalary."Earned Amount" := 0;
        TempProcSalary."Bonus/Exgratia" := Total;
        TempProcSalary."Add/Deduct" := TempProcSalary."Add/Deduct"::Addition;
        TempProcSalary.Attendance := MonAttendance.Attendance;
        TempProcSalary.Days := MonAttendance.Days;

        Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
        Lookup.SETRANGE("Lookup Name", TempProcSalary."Add/Deduct Code");
        IF Lookup.FIND('-') THEN
            TempProcSalary.Priority := Lookup.Priority;

        TempProcSalary.INSERT;
    end;

    // [Scope('Internal')]
    procedure LoanDeductions(MonAttendance: Record 60029)
    var
        Loan: Record 60039;
        LoanStartMonth: Integer;
        LoanStartYear: Integer;
    begin
        Loan.SETRANGE("Employee Code", MonAttendance."Employee Code");
        Loan.SETRANGE("No Deduction Request", FALSE);
        Loan.SETFILTER("Loan Balance", '<>0');
        IF Loan.FIND('-') THEN
            REPEAT
                LoanStartMonth := DATE2DMY(Loan."Loan Start Date", 2);
                LoanStartYear := DATE2DMY(Loan."Loan Start Date", 3);
                //UD dec 8th
                //    IF (MonAttendance."Pay Slip Month" >= LoanStartMonth) AND (MonAttendance.Year >= LoanStartYear) THEN
                IF ((MonAttendance."Pay Slip Month" >= LoanStartMonth) AND (MonAttendance.Year = LoanStartYear)) OR
                    (MonAttendance.Year > LoanStartYear) THEN  //UD dec 8th
                    LoanRecords(MonAttendance, Loan);
            UNTIL Loan.NEXT = 0;
    end;

    //  [Scope('Internal')]
    procedure LoanRecords(MonAttendance: Record 60029; Loan: Record 60039)
    var
        TempProcsalary: Record 60037;
    begin
        IF Loan."Effective Amount" <> 0 THEN BEGIN
            TempProcsalary.INIT;
            TempProcsalary."Employee Code" := Loan."Employee Code";
            TempProcsalary."Add/Deduct Code" := Loan."Loan Type";
            TempProcsalary."Pay Slip Month" := MonAttendance."Pay Slip Month";
            TempProcsalary.Year := MonAttendance.Year;
            TempProcsalary."Document Type" := TempProcsalary."Document Type"::Payroll;

            TempProcessedSalary.SETRANGE("Document Type", TempProcessedSalary."Document Type"::Payroll);
            TempProcessedSalary.SETRANGE("Employee Code", TempProcsalary."Employee Code");
            TempProcessedSalary.SETRANGE("Pay Slip Month", TempProcsalary."Pay Slip Month");
            TempProcessedSalary.SETRANGE(Year, TempProcsalary.Year);
            IF TempProcessedSalary.FIND('+') THEN
                TempProcsalary."Line No." := TempProcessedSalary."Line No." + 10000
            ELSE
                TempProcsalary."Line No." := 10000;

            TempProcsalary."Computation Type" := 'LOAN';
            TempProcsalary."Loan Priority No" := Loan."Loan Priority No";
            TempProcsalary."Earned Amount" := Loan."Effective Amount";
            TempProcessedSalary."Loan Id" := Loan.Id;
            TempProcsalary."Partial Deduction" := Loan."Partial Deduction";
            TempProcsalary."Add/Deduct" := TempProcsalary."Add/Deduct"::Deduction;
            TempProcsalary.Attendance := MonAttendance.Attendance;
            TempProcsalary.Days := MonAttendance.Days;

            Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
            Lookup.SETRANGE("Lookup Name", 'LOAN');
            IF Lookup.FIND('-') THEN
                TempProcsalary.Priority := Lookup.Priority;

            TempProcsalary."Loan Id" := Loan.Id;
            TempProcsalary.INSERT;
        END;
    end;

    //  [Scope('Internal')]
    procedure DeductionPriority(var MonthlyAttendance: Record 60029)
    var
        Employee: Record 60019;
        TempProcSalaryAdd: Record 60037;
        TempProcSalary: Record 60037;
        ProcessedSalaryAdd: Record 60038;
        ProcessedSalaryAdd2: Record 60038;
        ProcessedSalary: Record 60038;
        ProcessedSalary2: Record 60038;
        ProcSalary: Record 60038;
        Lookup: Record 60018;
        TotalSalary: Decimal;
        MinimumSalary: Decimal;
        Additions: Decimal;
        Deductions: Decimal;
    begin
        TempProcSalaryAdd.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalaryAdd.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalaryAdd.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalaryAdd.SETRANGE("Add/Deduct", TempProcSalaryAdd."Add/Deduct"::Addition);
        IF TempProcSalaryAdd.FIND('-') THEN
            REPEAT
                TotalSalary := TotalSalary + TempProcSalaryAdd."Earned Amount";
                ProcessedSalaryAdd.INIT;
                ProcessedSalaryAdd.TRANSFERFIELDS(TempProcSalaryAdd);
                ProcessedSalaryAdd."Document Type" := ProcessedSalaryAdd."Document Type"::Payroll;
                ProcessedSalaryAdd."Pay Cadre" := MonthlyAttendance.PayCadre;
                ProcSalary.RESET;
                ProcSalary.SETRANGE("Document Type", ProcessedSalaryAdd."Document Type"::Payroll);
                ProcSalary.SETRANGE("Employee Code", ProcessedSalaryAdd."Employee Code");
                ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalaryAdd."Pay Slip Month");
                ProcSalary.SETRANGE(Year, ProcessedSalaryAdd.Year);
                IF ProcSalary.FIND('+') THEN
                    ProcessedSalaryAdd."Line No." := ProcSalary."Line No." + 10000
                ELSE
                    ProcessedSalaryAdd."Line No." := 10000;

                ProcessedSalaryAdd.INSERT;
                InsertDimensions(ProcessedSalaryAdd);
            UNTIL TempProcSalaryAdd.NEXT = 0;

        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        IF Employee.FIND('-') THEN BEGIN
            Lookup.SETRANGE("LookupType Name", 'PAY CADRE');
            Lookup.SETRANGE("Lookup Name", Employee."Pay Cadre");
            IF Lookup.FIND('-') THEN
                MinimumSalary := Lookup."Min Salary";
        END;

        TotalSalary := TotalSalary - MinimumSalary;

        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority);
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETFILTER(Priority, '<>0');
        TempProcSalary.SETRANGE(Deducted, FALSE);
        IF TempProcSalary.FIND('-') THEN BEGIN
            REPEAT
                IF TempProcSalary."Computation Type" = 'LOAN' THEN BEGIN
                    IF TempProcSalary."Partial Deduction" THEN
                        TotalSalary := LoanPriority(MonthlyAttendance, TempProcSalary, TotalSalary)
                    ELSE BEGIN
                        IF (TotalSalary > TempProcSalary."Earned Amount") THEN BEGIN
                            TotalSalary := LoanPriority(MonthlyAttendance, TempProcSalary, TotalSalary);
                        END;
                    END;
                END ELSE BEGIN
                    IF (TotalSalary >= TempProcSalary."Earned Amount") THEN BEGIN
                        ProcessedSalary.INIT;
                        ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                        ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                        ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                        ProcSalary.RESET;
                        ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                        ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                        ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                        ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                        IF ProcSalary.FIND('+') THEN
                            ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                        ELSE
                            ProcessedSalary."Line No." := 10000;

                        ProcessedSalary.INSERT;
                        InsertDimensions(ProcessedSalary);
                        TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                        TempProcSalary.Deducted := TRUE;
                        TempProcSalary.MODIFY;
                    END;
                END;
            UNTIL TempProcSalary.NEXT = 0;
        END;

        //ESI (IF priority not given)
        TempProcSalary.RESET;
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct Code", 'ESI');
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETRANGE(Deducted, FALSE);
        IF TempProcSalary.FIND('-') THEN BEGIN
            IF (TotalSalary >= TempProcSalary."Earned Amount") THEN BEGIN
                ProcessedSalary.INIT;
                ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                ProcSalary.RESET;
                ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                IF ProcSalary.FIND('+') THEN
                    ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                ELSE
                    ProcessedSalary."Line No." := 10000;

                ProcessedSalary.INSERT;

                InsertDimensions(ProcessedSalary);

                TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                TempProcSalary.Deducted := TRUE;
                TempProcSalary.MODIFY;
            END;
        END;

        //PF (IF priority not given)
        TempProcSalary.RESET;
        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority);
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETRANGE(Deducted, FALSE);
        TempProcSalary.SETRANGE("Add/Deduct Code", 'PF');
        IF TempProcSalary.FIND('-') THEN BEGIN
            IF (TotalSalary >= TempProcSalary."Earned Amount") THEN BEGIN
                ProcessedSalary.INIT;
                ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                ProcSalary.RESET;
                ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                IF ProcSalary.FIND('+') THEN
                    ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                ELSE
                    ProcessedSalary."Line No." := 10000;

                ProcessedSalary.INSERT;

                InsertDimensions(ProcessedSalary);

                TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                TempProcSalary.Deducted := TRUE;
                TempProcSalary.MODIFY;
            END;
        END;

        //PT (IF priority not given)
        TempProcSalary.RESET;
        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority);
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETRANGE(Deducted, FALSE);
        TempProcSalary.SETRANGE("Add/Deduct Code", 'PT');
        IF TempProcSalary.FIND('-') THEN BEGIN
            IF (TotalSalary >= TempProcSalary."Earned Amount") THEN BEGIN
                ProcessedSalary.INIT;
                ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                ProcSalary.RESET;
                ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                IF ProcSalary.FIND('+') THEN
                    ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                ELSE
                    ProcessedSalary."Line No." := 10000;

                ProcessedSalary.INSERT;

                InsertDimensions(ProcessedSalary);

                TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                TempProcSalary.Deducted := TRUE;
                TempProcSalary.MODIFY;
            END;
        END;

        //TDS (IF priority not given)
        TempProcSalary.RESET;
        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority);
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETRANGE(Deducted, FALSE);
        TempProcSalary.SETRANGE("Add/Deduct Code", 'TDs');
        IF TempProcSalary.FIND('-') THEN BEGIN
            IF (TotalSalary >= TempProcSalary."Earned Amount") THEN BEGIN
                ProcessedSalary.INIT;
                ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                ProcSalary.RESET;
                ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                IF ProcSalary.FIND('+') THEN
                    ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                ELSE
                    ProcessedSalary."Line No." := 10000;

                ProcessedSalary.INSERT;

                InsertDimensions(ProcessedSalary);

                TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                TempProcSalary.Deducted := TRUE;
                TempProcSalary.MODIFY;
            END;
        END;

        //Loans (IF priority not given)
        TempProcSalary.RESET;
        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority);
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETRANGE(Deducted, FALSE);
        TempProcSalary.SETRANGE(TempProcSalary."Computation Type", 'LOAN');
        IF TempProcSalary.FIND('-') THEN BEGIN
            IF TempProcSalary."Partial Deduction" THEN
                TotalSalary := LoanPriority(MonthlyAttendance, TempProcSalary, TotalSalary)
            ELSE BEGIN
                IF (TotalSalary > TempProcSalary."Earned Amount") THEN BEGIN
                    TotalSalary := LoanPriority(MonthlyAttendance, TempProcSalary, TotalSalary);
                END;
            END;
        END;

        //Others (IF priority not given)
        TempProcSalary.RESET;
        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority);
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETRANGE(Deducted, FALSE);
        IF TempProcSalary.FIND('-') THEN BEGIN
            REPEAT
                IF (TotalSalary >= TempProcSalary."Earned Amount") THEN BEGIN
                    ProcessedSalary.INIT;
                    ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                    ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                    ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                    ProcSalary.RESET;
                    ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                    ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                    ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                    ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                    IF ProcSalary.FIND('+') THEN
                        ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                    ELSE
                        ProcessedSalary."Line No." := 10000;

                    ProcessedSalary.INSERT;

                    InsertDimensions(ProcessedSalary);

                    TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                    TempProcSalary.Deducted := TRUE;
                    TempProcSalary.MODIFY;
                END;
            UNTIL TempProcSalary.NEXT = 0;
        END;

        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        IF ProcessedSalary.FIND('-') THEN BEGIN
            REPEAT
                IF ProcessedSalary."Add/Deduct" = ProcessedSalary."Add/Deduct"::Addition THEN
                    Additions := Additions + ProcessedSalary."Earned Amount"
                ELSE
                    IF ProcessedSalary."Add/Deduct" = ProcessedSalary."Add/Deduct"::Deduction THEN
                        Deductions := Deductions + ProcessedSalary."Earned Amount";
            UNTIL ProcessedSalary.NEXT = 0;
            MonthlyAttendance.Processed := TRUE;
            MonthlyAttendance."Processing Date" := TODAY;
            MonthlyAttendance."Net Salary" := Additions - Deductions;
            MonthlyAttendance."Remaining Amount" := Additions - Deductions;
            COMMIT;
            MA2.RESET;
            MA2.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
            MA2.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
            MA2.SETRANGE(Year, MonthlyAttendance.Year);
            IF MA2.FIND('-') THEN BEGIN

                MA2.TRANSFERFIELDS(MonthlyAttendance);
                MA2.Processed := TRUE;
                MA2."Processing Date" := TODAY;
                MA2."Net Salary" := Additions - Deductions;
                MA2."Remaining Amount" := Additions - Deductions;
                MA2.MODIFY;
            END;

            MonthlyAttendance.Processed := MA2.Processed;
            MonthlyAttendance."Processing Date" := MA2."Processing Date";
            MonthlyAttendance."Net Salary" := MA2."Net Salary";
            MonthlyAttendance."Remaining Amount" := MA2."Remaining Amount";

            MonthlyAttendance.TRANSFERFIELDS(MA2);

            // MonthlyAttendance.MODIFY;    // HM     //Blocked By Paramita because of error in Monthly Attendance
        END;

        TempProcSalary.RESET;
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        IF TempProcSalary.FIND('-') THEN
            TempProcSalary.DELETEALL;
    end;

    //   [Scope('Internal')]
    procedure LoanPriority(MonthlyAttendance: Record 60029; TempProcSalary: Record 60037; TotalSalary: Decimal): Decimal
    var
        ProcessedSalary: Record 60038;
        ProcessedSalary2: Record 60038;
        ProcSalary: Record 60038;
        Loan: Record 60039;
    begin
        TempProcSalary.RESET;
        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority, "Loan Priority No");
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETFILTER(TempProcSalary."Loan Priority No", '<>0');
        TempProcSalary.SETRANGE(Deducted, FALSE);
        TempProcSalary.SETRANGE(TempProcSalary."Computation Type", 'LOAN');
        IF TempProcSalary.FIND('-') THEN BEGIN
            REPEAT
                IF TotalSalary >= TempProcSalary."Earned Amount" THEN BEGIN
                    ProcessedSalary.INIT;
                    ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                    ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                    ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                    ProcSalary.RESET;
                    ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                    ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                    ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                    ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                    IF ProcSalary.FIND('+') THEN
                        ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                    ELSE
                        ProcessedSalary."Line No." := 10000;

                    ProcessedSalary.INSERT;

                    LoanDetailRecords(ProcessedSalary);
                    InsertDimensions(ProcessedSalary);
                    TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                    TempProcSalary.Deducted := TRUE;
                    TempProcSalary.MODIFY;
                END ELSE BEGIN
                    Loan.RESET;
                    Loan.SETRANGE(Loan.Id, TempProcSalary."Loan Id");
                    Loan.SETRANGE("Employee Code", TempProcSalary."Employee Code");
                    IF Loan.FIND('-') THEN BEGIN
                        IF Loan."Partial Deduction" = TRUE THEN BEGIN
                            ProcessedSalary.INIT;
                            ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                            ProcessedSalary."Earned Amount" := TotalSalary;
                            ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                            ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                            ProcSalary.RESET;
                            ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                            ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                            ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                            ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                            IF ProcSalary.FIND('+') THEN
                                ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                            ELSE
                                ProcessedSalary."Line No." := 10000;

                            ProcessedSalary.INSERT;

                            LoanDetailRecords(ProcessedSalary);
                            InsertDimensions(ProcessedSalary);
                            TotalSalary := TotalSalary - TotalSalary;
                            TempProcSalary.Deducted := TRUE;
                            TempProcSalary.MODIFY;
                        END;
                    END;
                END;
            UNTIL TempProcSalary.NEXT = 0;
        END;

        TempProcSalary.RESET;
        TempProcSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Priority, "Loan Priority No");
        TempProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        TempProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        TempProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        TempProcSalary.SETRANGE("Add/Deduct", TempProcSalary."Add/Deduct"::Deduction);
        TempProcSalary.SETRANGE(Deducted, FALSE);
        TempProcSalary.SETRANGE("Computation Type", 'LOAN');
        IF TempProcSalary.FIND('-') THEN BEGIN
            REPEAT
                IF TotalSalary >= TempProcSalary."Earned Amount" THEN BEGIN
                    ProcessedSalary.INIT;
                    ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                    ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                    ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                    ProcSalary.RESET;
                    ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                    ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                    ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                    ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                    IF ProcSalary.FIND('+') THEN
                        ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                    ELSE
                        ProcessedSalary."Line No." := 10000;

                    ProcessedSalary.INSERT;

                    LoanDetailRecords(ProcessedSalary);
                    InsertDimensions(ProcessedSalary);
                    TotalSalary := TotalSalary - TempProcSalary."Earned Amount";
                    TempProcSalary.Deducted := TRUE;
                    TempProcSalary.MODIFY;
                END ELSE BEGIN
                    Loan.RESET;
                    Loan.SETRANGE(Loan.Id, TempProcSalary."Loan Id");
                    Loan.SETRANGE("Employee Code", TempProcSalary."Employee Code");
                    IF Loan.FIND('-') THEN BEGIN
                        IF Loan."Partial Deduction" = TRUE THEN BEGIN
                            ProcessedSalary.INIT;
                            ProcessedSalary.TRANSFERFIELDS(TempProcSalary);
                            ProcessedSalary."Earned Amount" := TotalSalary;
                            ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                            ProcessedSalary."Pay Cadre" := MonthlyAttendance.PayCadre;
                            ProcSalary.RESET;
                            ProcSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                            ProcSalary.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
                            ProcSalary.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
                            ProcSalary.SETRANGE(Year, ProcessedSalary.Year);
                            IF ProcSalary.FIND('+') THEN
                                ProcessedSalary."Line No." := ProcSalary."Line No." + 10000
                            ELSE
                                ProcessedSalary."Line No." := 10000;

                            ProcessedSalary.INSERT;

                            LoanDetailRecords(ProcessedSalary);
                            InsertDimensions(ProcessedSalary);
                            TotalSalary := TotalSalary - TotalSalary;
                            TempProcSalary.Deducted := TRUE;
                            TempProcSalary.MODIFY;
                        END;
                    END;
                END;
            UNTIL TempProcSalary.NEXT = 0;
        END;

        EXIT(TotalSalary);
    end;

    // [Scope('Internal')]
    procedure LoanDetailRecords(ProcessedSalary: Record 60038)
    var
        Loan: Record 60039;
        LoanDetails: Record 60040;
        LoanDetails2: Record 60040;
        LoanLast: Record 60040;
        NextNo: Integer;
    begin
        //B2B
        LoanDetails.SETRANGE("Employee No.", ProcessedSalary."Employee Code");
        LoanDetails.SETRANGE(Month, ProcessedSalary."Pay Slip Month");
        LoanDetails.SETRANGE(Year, ProcessedSalary.Year);
        LoanDetails.SETRANGE("Loan Code", ProcessedSalary."Add/Deduct Code");
        IF LoanDetails.FIND('-') THEN BEGIN
            LoanDetails."EMI Deducted" := ProcessedSalary."Earned Amount";
            LoanDetails."Paid Month" := ProcessedSalary."Pay Slip Month";
            LoanDetails."Paid Year" := ProcessedSalary.Year;

            LoanDetails2.RESET;
            LoanDetails2.SETRANGE("Employee No.", LoanDetails."Employee No.");
            LoanDetails2.SETRANGE("Loan Id", LoanDetails."Loan Id");
            LoanDetails2.SETFILTER("EMI Deducted", '<>0');
            LoanDetails2.SETFILTER("Paid Month", '<>0');
            LoanDetails2.SETFILTER("Paid Year", '<>0');
            IF LoanDetails2.FIND('+') THEN
                LoanDetails.Balance := LoanDetails2.Balance - LoanDetails."EMI Deducted"
            ELSE
                LoanDetails.Balance := LoanDetails."Loan Amount" - LoanDetails."EMI Deducted";

            IF LoanDetails.Balance = 0 THEN
                LoanDetails."Loan Closed" := TRUE;
            LoanDetails.MODIFY;

            LoanDetails2.RESET;
            LoanDetails2.SETRANGE("Employee No.", LoanDetails."Employee No.");
            LoanDetails2.SETRANGE("Loan Id", LoanDetails."Loan Id");
            LoanDetails2.SETFILTER("EMI Deducted", '=0');
            LoanDetails2.SETFILTER("Paid Month", '=0');
            LoanDetails2.SETFILTER("Paid Year", '=0');
            IF LoanDetails2.FIND('-') THEN BEGIN
                Loan.RESET;
                Loan.SETRANGE(Id, LoanDetails."Loan Id");
                Loan.SETRANGE("Employee Code", LoanDetails."Employee No.");
                IF Loan.FIND('-') THEN BEGIN
                    Loan."Effective Amount" := LoanDetails."EMI Amount";
                    Loan."Loan Balance" := LoanDetails.Balance;
                    IF Loan."Loan Balance" = 0 THEN
                        Loan.Closed := TRUE;
                    Loan.MODIFY;
                END;
            END ELSE BEGIN
                BEGIN
                    Loan.RESET;
                    Loan.SETRANGE(Id, LoanDetails."Loan Id");
                    Loan.SETRANGE("Employee Code", LoanDetails."Employee No.");
                    IF Loan.FIND('-') THEN BEGIN
                        Loan."Effective Amount" := LoanDetails.Balance;
                        Loan."Loan Balance" := LoanDetails.Balance;
                        IF Loan."Loan Balance" = 0 THEN
                            Loan.Closed := TRUE;
                        Loan.MODIFY;
                    END;
                END;
            END

        END ELSE BEGIN
            LoanLast.RESET;
            LoanLast.SETRANGE("Loan Id", ProcessedSalary."Loan Id");
            LoanLast.SETRANGE("Employee No.", ProcessedSalary."Employee Code");
            IF LoanLast.FIND('+') THEN
                NextNo := LoanLast."Line No"
            ELSE
                NextNo := 0;

            Loan.RESET;
            Loan.SETRANGE(Id, ProcessedSalary."Loan Id");
            Loan.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
            IF Loan.FIND('-') THEN BEGIN
                LoanDetails.INIT;
                LoanDetails."Employee No." := Loan."Employee Code";
                LoanDetails."Loan Code" := Loan."Loan Type";
                LoanDetails."Line No" := NextNo + 1;
                LoanDetails."Loan Id" := Loan.Id;
                LoanDetails."Loan Amount" := Loan."Loan Amount";
                LoanDetails."EMI Deducted" := ProcessedSalary."Earned Amount";
                LoanDetails."Paid Month" := ProcessedSalary."Pay Slip Month";
                LoanDetails."Paid Year" := ProcessedSalary.Year;

                LoanDetails2.RESET;
                LoanDetails2.SETRANGE("Employee No.", LoanDetails."Employee No.");
                LoanDetails2.SETRANGE("Loan Id", LoanDetails."Loan Id");
                LoanDetails2.SETFILTER("EMI Deducted", '<>0');
                LoanDetails2.SETFILTER("Paid Month", '<>0');
                LoanDetails2.SETFILTER("Paid Year", '<>0');
                IF LoanDetails2.FIND('+') THEN
                    LoanDetails.Balance := LoanDetails2.Balance - LoanDetails."EMI Deducted";
                IF LoanDetails.Balance = 0 THEN
                    LoanDetails."Loan Closed" := TRUE;
                LoanDetails.INSERT;
                Loan.RESET;
                Loan.SETRANGE(Id, LoanDetails."Loan Id");
                Loan.SETRANGE("Employee Code", LoanDetails."Employee No.");
                IF Loan.FIND('-') THEN BEGIN
                    Loan."Effective Amount" := LoanDetails.Balance;
                    Loan."Loan Balance" := LoanDetails.Balance;
                    IF Loan."Loan Balance" = 0 THEN
                        Loan.Closed := TRUE;
                    Loan.MODIFY;
                END;
            END;
        END;
    end;

    //  [Scope('Internal')]
    procedure "----------Postings------------"()
    begin
    end;

    // [Scope('Internal')]
    procedure InsertDimensions(ProcSalary: Record 60038)
    begin
        ProcSalary.VALIDATE("Employee Code");
    end;

    //  [Scope('Internal')]
    procedure RoundtheAmount(var MonAttendance: Record 60029)
    var
        ProcessedSalary: Record 60038;
        GrossAmt: Decimal;
        HrSetupLocal: Record 60016;
        RoundType: Text[30];
        LineNoLocal: Integer;
        MonGross: Decimal;
    begin

        HrSetupLocal.GET;
        IF HrSetupLocal."Rounding Type" = HrSetupLocal."Rounding Type"::Up THEN
            RoundType := '>'
        ELSE
            IF HrSetupLocal."Rounding Type" = HrSetupLocal."Rounding Type"::Down THEN
                RoundType := '<'
            ELSE
                IF HrSetupLocal."Rounding Type" = HrSetupLocal."Rounding Type"::"To the nearest value" THEN
                    RoundType := '=';

        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonAttendance."Employee Code");
        ProcessedSalary.SETRANGE("Pay Slip Month", MonAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE(Year, MonAttendance.Year);
        IF ProcessedSalary.FINDFIRST THEN
            REPEAT
                IF ProcessedSalary."Add/Deduct" = ProcessedSalary."Add/Deduct"::Addition THEN
                    MonGross := MonGross + ProcessedSalary."Earned Amount"
                ELSE
                    MonGross := MonGross - ProcessedSalary."Earned Amount";
            UNTIL ProcessedSalary.NEXT = 0;

        GrossAmt := ROUND(MonGross, 1, RoundType) - MonGross;

        IF GrossAmt <> 0 THEN BEGIN
            CLEAR(LineNoLocal);
            ProcessedSalary.RESET;
            ProcessedSalary.SETRANGE("Employee Code", MonAttendance."Employee Code");
            ProcessedSalary.SETRANGE("Pay Slip Month", MonAttendance."Pay Slip Month");
            ProcessedSalary.SETRANGE(Year, MonAttendance.Year);
            IF ProcessedSalary.FINDLAST THEN
                LineNoLocal := ProcessedSalary."Line No.";

            ProcessedSalary.INIT;
            ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
            ProcessedSalary.VALIDATE("Employee Code", MonAttendance."Employee Code");
            ProcessedSalary."Pay Slip Month" := MonAttendance."Pay Slip Month";
            ProcessedSalary.Year := MonAttendance.Year;
            ProcessedSalary.VALIDATE("Pay Cadre", MonAttendance.PayCadre);
            ProcessedSalary."Line No." := LineNoLocal + 10000;
            IF GrossAmt > 0 THEN BEGIN
                ProcessedSalary.VALIDATE("Add/Deduct Code", 'ADD ROUND');
                ProcessedSalary."Add/Deduct" := ProcessedSalary."Add/Deduct"::Addition;
            END ELSE BEGIN
                ProcessedSalary.VALIDATE("Add/Deduct Code", 'DED ROUND');
                ProcessedSalary."Add/Deduct" := ProcessedSalary."Add/Deduct"::Deduction;
            END;
            MonAttendance.CALCFIELDS(Attendance, Days);
            ProcessedSalary.Attendance := MonAttendance.Attendance;
            ProcessedSalary.Days := MonAttendance.Days;
            ProcessedSalary."Earned Amount" := ABS(GrossAmt);
            ProcessedSalary.INSERT;
            //  MonAttendance."Net Salary" := ROUND(MonAttendance."Net Salary",HrSetupLocal."Rounding Precision",RoundType);
            MonAttendance."Net Salary" := ROUND(MonAttendance."Net Salary", 1, RoundType);
            MonAttendance.Processed := TRUE;
            //MonAttendance.MODIFY;
            MA2.INIT;
            MA2.RESET;
            MA2.SETRANGE("Employee Code", MonAttendance."Employee Code");
            MA2.SETRANGE("Pay Slip Month", MonAttendance."Pay Slip Month");
            MA2.SETRANGE(Year, MonAttendance.Year);
            IF MA2.FIND('-') THEN BEGIN

                MA2.TRANSFERFIELDS(MonAttendance);
                MA2.Processed := TRUE;
                MA2."Net Salary" := MonAttendance."Net Salary";
                MA2.MODIFY;
            END;
        END;
    end;

    //  [Scope('Internal')]
    procedure InsertTDSRecords2(MonAttendance: Record 60029)
    var
        TDSSchedule: Record 60047;
        ProcSalary: Record 60038;
    begin
        EmpTDSAmt.INIT;
        EmpTDSAmt.RESET;
        EmpTDSAmt.SETRANGE("Employee Code", MonAttendance."Employee Code");
        EmpTDSAmt.SETRANGE(Month, MonAttendance."Pay Slip Month");
        EmpTDSAmt.SETRANGE(Year, MonAttendance.Year);
        IF EmpTDSAmt.FIND('-') THEN BEGIN
            AddDeduct := AddDeduct::Deduction;
            InsertTempProcRecordsVAD(MonAttendance, 'TDS', AddDeduct, EmpTDSAmt."TDS Amount");
            EmpTDSAmt.Processed := TRUE;
            EmpTDSAmt.MODIFY;
        END;
    end;
}

