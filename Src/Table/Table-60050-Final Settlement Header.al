table 60050 "Final Settlement Header"
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = Employee_;

            trigger OnValidate()
            begin
                IF Employee.GET("Employee No.") THEN
                    "Employee Name" := Employee."First Name";
            end;
        }
        field(2; "Employee Name"; Text[50])
        {
        }
        field(3; "Pay Cadre"; Code[30])
        {
        }
        field(4; "Date of Leaving"; Date)
        {

            trigger OnValidate()
            begin
                Employee.GET("Employee No.");
                IF Employee."Employment Date" <> 0D THEN BEGIN
                    IF "Date of Leaving" < Employee."Employment Date" THEN
                        ERROR('Leaving Date cannot be before Employeement Date');
                END;
                PostedSalary.RESET;
                PostedSalary.SETRANGE("Employee Code", "Employee No.");
                PostedSalary.SETFILTER("Posting Date", '>=%1', "Date of Leaving");
                IF PostedSalary.FINDFIRST THEN
                    ERROR('Salary for this time has been posted');
            end;
        }
        field(5; Month; Integer)
        {
            MaxValue = 12;
            MinValue = 1;

            trigger OnValidate()
            begin
                IF Year <> 0 THEN BEGIN
                    PostedSalary.RESET;
                    PostedSalary.SETRANGE("Employee Code", "Employee No.");
                    PostedSalary.SETRANGE(Month, Month);
                    PostedSalary.SETRANGE(Year, Year);
                    IF PostedSalary.FINDFIRST THEN
                        ERROR('Salary for this time has been posted');
                END;
            end;
        }
        field(6; Year; Integer)
        {

            trigger OnValidate()
            begin
                IF Month <> 0 THEN BEGIN
                    PostedSalary.RESET;
                    PostedSalary.SETRANGE("Employee Code", "Employee No.");
                    PostedSalary.SETRANGE(Month, Month);
                    PostedSalary.SETRANGE(Year, Year);
                    IF PostedSalary.FINDFIRST THEN
                        ERROR('Salary for this time has been posted');
                END;
            end;
        }
        field(7; "Attended Days"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "Employee No." = '' THEN
                    ERROR('');
                StartingDateOfMonth := DMY2DATE(1, Month, Year);
                EndDingDateOfMonth := CALCDATE('CM', StartingDateOfMonth);
                NoOfDays := 1 + (EndDingDateOfMonth - StartingDateOfMonth);

                IF "Attended Days" > NoOfDays THEN
                    ERROR('Attended days cannot be greater than No of Dyas in the month');
            end;
        }
        field(11; "Journal Template Name"; Code[20])
        {
        }
        field(12; "Journal Batch Name"; Code[20])
        {
        }
        field(13; "Posting Date"; Date)
        {
        }
        field(14; "Document No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        IF FinalSettleLine.FIND('-') THEN
            FinalSettleLine.DELETEALL;
    end;

    var
        Employee: Record 60019;
        FinalSettleLine: Record 60051;
        PostedSalary: Record 60009;
        StartingDateOfMonth: Date;
        EndDingDateOfMonth: Date;
        NoOfDays: Integer;

    //[Scope('Internal')]
    procedure GetPayElements()
    var
        Lookup: Record 60018;
        FinalLine: Record 60051;
    begin
        FinalLine.SETRANGE("Employee No.", "Employee No.");
        FinalLine.SETRANGE(Month, Month);
        FinalLine.SETRANGE(Year, Year);
        IF FinalLine.FIND('-') THEN
            DELETEALL;

        Lookup.SETRANGE("LookupType Name", 'FINALSETTLEMENT');
        IF Lookup.FIND('-') THEN
            REPEAT
                FinalLine.INIT;
                FinalLine."Employee No." := "Employee No.";
                FinalLine.Month := Month;
                FinalLine.Year := Year;
                FinalLine."Document Type" := FinalLine."Document Type"::Payroll;
                FinalLine."Document No." := "Document No.";
                FinalLine."Journal Template Name" := "Journal Template Name";
                FinalLine."Journal Batch Name" := "Journal Batch Name";
                FinalLine."Posting Date" := "Posting Date";
                FinalLine."Line No." := FinalLine."Line No." + 10000;
                FinalLine."Pay Element Code" := Lookup."Lookup Name";
                FinalLine.Description := Lookup.Description;
                FinalLine."Addition/Deduction" := Lookup."Add/Deduct";
                FinalLine.INSERT;
                InsertDimensions(FinalLine);
            UNTIL Lookup.NEXT = 0;
    end;

    //  [Scope('Internal')]
    procedure CalculateSalary()
    var
        PayElements: Record 60025;
        FinalSettleLine: Record 60051;
        CheckMonth: Integer;
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        Days: Decimal;
        TotalAdditions: Decimal;
        TotalDeductions: Decimal;
        TotalSalary: Decimal;
    begin
        CheckMonth := DATE2DMY("Date of Leaving", 2);

        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        IF FinalSettleLine.FIND('-') THEN BEGIN
            Total := 0;
            REPEAT
                PayElements.SETRANGE("Employee Code", "Employee No.");
                PayElements.SETRANGE("Pay Element Code", FinalSettleLine."Pay Element Code");
                PayElements.SETFILTER("Effective Start Date", '<=%1', "Date of Leaving");
                IF PayElements.FIND('+') THEN BEGIN
                    IF PayElements."Pay Element Code" = 'BASIC' THEN BEGIN
                        Total := PayElements."Amount / Percent";
                        Basic := Total;
                    END ELSE BEGIN
                        IF (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Fixed) THEN BEGIN
                            Total := PayElements."Amount / Percent";
                        END ELSE
                            IF (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Percent) AND
                               (PayElements."Computation Type" = 'AFTER BASIC')
                   THEN
                                Total := (PayElements."Amount / Percent" * Basic) / 100
                            ELSE
                                IF (PayElements."Fixed/Percent" = PayElements."Fixed/Percent"::Percent) AND
                                   (PayElements."Computation Type" = 'AFTER BASIC AND DA')
                           THEN
                                    Total := (PayElements."Amount / Percent" * (Basic + DA)) / 100;
                    END;
                    IF PayElements."Pay Element Code" = 'DA' THEN
                        DA := Total;

                    Days := MonthDays(CheckMonth);
                    FinalSettleLine.Amount := (Total * "Attended Days") / Days;
                    FinalSettleLine.MODIFY;
                END;
            UNTIL FinalSettleLine.NEXT = 0;
            LoanAmount;
            GratuityAmount;
            OTAmount;
            //ESIAmount;
            //PFAmount;
            //PTAmount;
            //TDSAmount;
        END;
    end;

    //[Scope('Internal')]
    procedure MonthDays(MonthNum: Integer): Integer
    begin
        IF (MonthNum = 1) OR (MonthNum = 3) OR (MonthNum = 5) OR (MonthNum = 7) OR (MonthNum = 8) OR (MonthNum = 10) OR (MonthNum = 12)
        THEN
            EXIT(31)
        ELSE
            IF MonthNum = 2 THEN
                EXIT(28)
            ELSE
                EXIT(30);
    end;

    //  [Scope('Internal')]
    procedure LoanAmount()
    var
        Loan: Record 60039;
        FinalSettleLine: Record 60051;
        LoanAmount: Decimal;
    begin
        Loan.SETRANGE("Employee Code", "Employee No.");
        Loan.SETRANGE(Closed, FALSE);
        Loan.SETFILTER("Loan Balance", '<>0');
        IF Loan.FIND('-') THEN
            REPEAT
                LoanAmount := LoanAmount + Loan."Loan Balance";
            UNTIL Loan.NEXT = 0;

        FinalSettleLine.RESET;
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        FinalSettleLine.SETRANGE("Pay Element Code", 'LOAN');
        IF FinalSettleLine.FIND('-') THEN BEGIN
            FinalSettleLine.Amount := LoanAmount;
            FinalSettleLine."Computation Type" := 'LOAN';
            FinalSettleLine.MODIFY;
        END;
    end;

    // [Scope('Internal')]
    procedure GratuityAmount()
    var
        HRSetup: Record 60016;
        Lookup: Record 60018;
        FinalSettleLine: Record 60051;
        Payelements: Record 60025;
        GrossAmount: Decimal;
        GratuityAmount: Decimal;
        Days: Decimal;
        NoofDays: Decimal;
        ServiceYears: Decimal;
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        CheckMonth: Integer;
    begin
        CheckMonth := DATE2DMY("Date of Leaving", 2);

        Lookup.SETRANGE("LookupType Name", 'FINALSETTLEMENT');
        Lookup.SETRANGE(Gratuity, TRUE);
        IF Lookup.FIND('-') THEN
            REPEAT
                Total := 0;
                Payelements.RESET;
                Payelements.SETRANGE("Employee Code", "Employee No.");
                Payelements.SETRANGE("Pay Element Code", Lookup."Lookup Name");
                Payelements.SETFILTER("Effective Start Date", '<=%1', "Date of Leaving");
                IF Payelements.FIND('-') THEN BEGIN
                    IF (Payelements."Fixed/Percent" = Payelements."Fixed/Percent"::Fixed) THEN BEGIN
                        Total := Payelements."Amount / Percent";
                        IF Payelements."Pay Element Code" = 'BASIC' THEN
                            Basic := Total
                        ELSE
                            IF Payelements."Pay Element Code" = 'DA' THEN
                                DA := Total;
                    END ELSE
                        IF (Payelements."Fixed/Percent" = Payelements."Fixed/Percent"::Percent) AND
                                        (Payelements."Computation Type" = 'AFTER BASIC')
               THEN
                            Total := (Payelements."Amount / Percent" * Basic) / 100
                        ELSE
                            IF (Payelements."Fixed/Percent" = Payelements."Fixed/Percent"::Percent) AND
                                            (Payelements."Computation Type" = 'AFTER BASIC AND DA')
                       THEN
                                Total := (Payelements."Amount / Percent" * (Basic + DA)) / 100;
                    IF Payelements."Pay Element Code" = 'DA' THEN
                        DA := Total;

                END;
                IF Payelements."Add/Deduct" = Payelements."Add/Deduct"::Addition THEN
                    GrossAmount := GrossAmount + Total
                ELSE
                    IF Payelements."Add/Deduct" = Payelements."Add/Deduct"::Deduction THEN
                        GrossAmount := GrossAmount - Total;
            UNTIL Lookup.NEXT = 0;

        Employee.RESET;
        Employee.SETRANGE("No.", "Employee No.");
        IF Employee.FIND('-') THEN BEGIN
            NoofDays := "Date of Leaving" - Employee."Employment Date";
            ServiceYears := ROUND((NoofDays / 365), 0.01, '>');
        END;

        /*  // HM
        IF HRSetup.FIND('-') THEN BEGIN
          Days := MonthDays(CheckMonth);
          IF ServiceYears >= HRSetup."Min. No.of Years" THEN
            GratuityAmount := (GrossAmount * HRSetup."No.of Days Salary" * ServiceYears) / HRSetup."No.of Days in Month";
        */  // HM

        IF HRSetup.FIND('-') THEN
            IF ServiceYears >= 5 THEN
                GratuityAmount := ((GrossAmount / 365) * ServiceYears * HRSetup."No. of days less than 6 years")
            ELSE
                GratuityAmount := ((GrossAmount / 365) * ServiceYears * HRSetup."No. of days Grea. than 6 years");

        FinalSettleLine.RESET;
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        FinalSettleLine.SETRANGE("Pay Element Code", 'GRATUITY');
        IF FinalSettleLine.FIND('-') THEN BEGIN
            FinalSettleLine.Amount := GratuityAmount;
            FinalSettleLine.MODIFY;
        END;
        //END

    end;

    // [Scope('Internal')]
    procedure TDSAmount()
    var
        TDSSchedule: Record 60047;
        FinalSettleLine: Record 60051;
        TDSAmount: Decimal;
    begin
        TDSSchedule.SETRANGE("Employee No.", "Employee No.");
        TDSSchedule.SETRANGE(Month, Month);
        TDSSchedule.SETRANGE(Year, Year);
        TDSSchedule.SETRANGE(Processes, FALSE);
        IF TDSSchedule.FIND('-') THEN
            TDSAmount := TDSSchedule."TDS Amount";

        FinalSettleLine.RESET;
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        FinalSettleLine.SETRANGE("Pay Element Code", 'TDS');
        IF FinalSettleLine.FIND('-') THEN BEGIN
            FinalSettleLine.Amount := TDSAmount;
            FinalSettleLine.MODIFY;
        END;
    end;

    //  [Scope('Internal')]
    procedure ESIAmount()
    var
        Lookup: Record 60018;
        ESI: Record 60043;
        PayYear: Record 60020;
        ProcSalary: Record 60038;
        FinalSettleLine: Record 60051;
        GrossESIAmt: Decimal;
        GrossSalary: Decimal;
        EmployeeContribution: Decimal;
        EmployerContribution: Decimal;
        CheckDate: Date;
        ESIStartDate: Date;
        ESIEndDate: Date;
        Flag: Boolean;
    begin

        Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
        Lookup.SETRANGE(Lookup.ESI, Lookup.ESI::"Regular Element");
        IF Lookup.FIND('-') THEN
            REPEAT
                FinalSettleLine.RESET;
                FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
                FinalSettleLine.SETRANGE(Month, Month);
                FinalSettleLine.SETRANGE(Year, Year);
                FinalSettleLine.SETRANGE("Pay Element Code", Lookup."Lookup Name");
                IF FinalSettleLine.FIND('-') THEN BEGIN
                    IF FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Addition THEN
                        GrossESIAmt := GrossESIAmt + FinalSettleLine.Amount
                    ELSE
                        IF FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Deduction THEN
                            GrossESIAmt := GrossESIAmt - FinalSettleLine.Amount;
                END;
            UNTIL Lookup.NEXT = 0;



        Lookup.RESET;
        Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
        Lookup.SETFILTER(ESI, '<>%1', Lookup.ESI::" ");
        IF Lookup.FIND('-') THEN
            REPEAT
                FinalSettleLine.RESET;
                FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
                FinalSettleLine.SETRANGE(Month, Month);
                FinalSettleLine.SETRANGE(Year, Year);
                FinalSettleLine.SETRANGE("Pay Element Code", Lookup."Lookup Name");
                IF FinalSettleLine.FIND('-') THEN BEGIN
                    IF FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Addition THEN
                        GrossSalary := GrossSalary + FinalSettleLine.Amount
                    ELSE
                        IF FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Deduction THEN
                            GrossSalary := GrossSalary - FinalSettleLine.Amount;
                END;
            UNTIL Lookup.NEXT = 0;



        IF ESI.FIND('-') THEN BEGIN
            REPEAT
                IF GrossESIAmt < ESI."ESI Salary Amount" THEN BEGIN
                    Flag := TRUE;
                    IF ESI."Effective Date" <= "Date of Leaving" THEN
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
        END;

        IF NOT Flag THEN BEGIN
            PayYear.SETRANGE("Year Type", 'ESI YEAR');
            PayYear.SETRANGE(Closed, FALSE);
            IF PayYear.FIND('-') THEN
                REPEAT
                    IF ("Date of Leaving" >= PayYear."Year Start Date") AND
                       ("Date of Leaving" <= PayYear."Year End Date")
                    THEN BEGIN
                        ESIStartDate := PayYear."Year Start Date";
                        ESIEndDate := PayYear."Year End Date";
                    END;
                UNTIL PayYear.NEXT = 0;

            ProcSalary.RESET;
            ProcSalary.SETRANGE("Employee Code", "Employee No.");
            ProcSalary.SETRANGE(Year, Year);
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
        END;

        FinalSettleLine.RESET;
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        FinalSettleLine.SETRANGE("Pay Element Code", 'ESI');
        IF FinalSettleLine.FIND('-') THEN BEGIN
            FinalSettleLine.Amount := EmployeeContribution;
            FinalSettleLine.Salary := GrossSalary;
            FinalSettleLine."Co. Contribution" := EmployerContribution;
            FinalSettleLine.MODIFY;
        END;
    end;

    //  [Scope('Internal')]
    procedure PTAmount()
    var
        Lookup: Record 60018;
        PT: Record 60045;
        FinalSettleLine: Record 60051;
        GrossAmount: Decimal;
        PTAmount: Decimal;
    begin
        Lookup.RESET;
        Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
        Lookup.SETRANGE(PT, TRUE);
        IF Lookup.FIND('-') THEN
            REPEAT
                FinalSettleLine.RESET;
                FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
                FinalSettleLine.SETRANGE(Month, Month);
                FinalSettleLine.SETRANGE(Year, Year);
                FinalSettleLine.SETRANGE("Pay Element Code", Lookup."Lookup Name");
                IF FinalSettleLine.FIND('-') THEN BEGIN
                    IF FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Addition THEN
                        GrossAmount := GrossAmount + FinalSettleLine.Amount
                    ELSE
                        IF FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Deduction THEN
                            GrossAmount := GrossAmount - FinalSettleLine.Amount;
                END;
            UNTIL Lookup.NEXT = 0;

        IF PT.FIND('-') THEN BEGIN
            REPEAT
                PT.TESTFIELD("Income From");
                PT.TESTFIELD("Income To");
                IF (PT."Income From" <= GrossAmount) AND (PT."Income To" >= GrossAmount) THEN BEGIN
                    IF PT."Effective Date" <= "Date of Leaving" THEN
                        PTAmount := PT."Tax Amount";
                END;
            UNTIL PT.NEXT = 0;
        END;

        FinalSettleLine.RESET;
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        FinalSettleLine.SETRANGE("Pay Element Code", 'PT');
        IF FinalSettleLine.FIND('-') THEN BEGIN
            FinalSettleLine.Amount := PTAmount;
            FinalSettleLine.MODIFY;
        END;
    end;

    // [Scope('Internal')]
    procedure PFAmount()
    var
        Lookup: Record 60018;
        PF: Record 60042;
        FinalSettleLine: Record 60051;
        GrossAmount: Decimal;
        EmployerContribution: Decimal;
        EmployeeContribution: Decimal;
        EPSAmount: Decimal;
    begin
        GrossAmount := 0;
        Lookup.RESET;
        Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
        Lookup.SETRANGE(PF, TRUE);
        IF Lookup.FIND('-') THEN
            REPEAT
                FinalSettleLine.RESET;
                FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
                FinalSettleLine.SETRANGE(Month, Month);
                FinalSettleLine.SETRANGE(Year, Year);
                FinalSettleLine.SETRANGE("Pay Element Code", Lookup."Lookup Name");
                IF FinalSettleLine.FIND('-') THEN BEGIN
                    IF FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Addition THEN
                        GrossAmount := GrossAmount + FinalSettleLine.Amount
                    ELSE
                        IF FinalSettleLine."Addition/Deduction" = FinalSettleLine."Addition/Deduction"::Deduction THEN
                            GrossAmount := GrossAmount - FinalSettleLine.Amount;
                END;
            UNTIL Lookup.NEXT = 0;



        IF PF.FIND('-') THEN BEGIN
            REPEAT
                IF GrossAmount < PF."PF Amount" THEN BEGIN
                    IF PF."Effective Date" <= "Date of Leaving" THEN
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
                    IF PF."Effective Date" <= "Date of Leaving" THEN
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
            UNTIL PF.NEXT = 0;
        END;

        FinalSettleLine.RESET;
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        FinalSettleLine.SETRANGE("Pay Element Code", 'PF');
        IF FinalSettleLine.FIND('-') THEN BEGIN
            FinalSettleLine.Amount := EmployeeContribution;
            FinalSettleLine.Salary := GrossAmount;
            FinalSettleLine."Co. Contribution" := EmployerContribution;
            FinalSettleLine."Co. Contribution2" := EPSAmount;
            FinalSettleLine.MODIFY;
        END;
    end;

    // [Scope('Internal')]
    procedure OTAmount()
    var
        DailyAttendance: Record 60028;
        Lookup: Record 60018;
        FinalSettleLine: Record 60051;
        CheckMonth: Integer;
        CheckYear: Integer;
        OTHrs: Decimal;
        NoofHrs: Decimal;
        GrossAmount: Decimal;
        OTDay: Decimal;
        OTHrsAmount: Decimal;
        OTTotal: Decimal;
    begin
        CheckMonth := DATE2DMY("Date of Leaving", 2);
        CheckYear := DATE2DMY("Date of Leaving", 3);

        DailyAttendance.SETRANGE("Employee No.", "Employee No.");
        DailyAttendance.SETRANGE(Month, CheckMonth);
        DailyAttendance.SETRANGE(Year, CheckYear);
        DailyAttendance.SETFILTER(Date, '<=%1', "Date of Leaving");
        IF DailyAttendance.FIND('-') THEN BEGIN
            NoofHrs := DailyAttendance."Actual Hrs";
            REPEAT
                OTHrs := OTHrs + DailyAttendance."OT Approved Hrs";
            UNTIL DailyAttendance.NEXT = 0;
        END;


        Lookup.RESET;
        Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
        Lookup.SETRANGE("Applicable for OT", TRUE);
        IF Lookup.FIND('-') THEN
            REPEAT
                FinalSettleLine.RESET;
                FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
                FinalSettleLine.SETRANGE(Month, Month);
                FinalSettleLine.SETRANGE(Year, Year);
                FinalSettleLine.SETRANGE("Pay Element Code", Lookup."Lookup Name");
                IF FinalSettleLine.FIND('-') THEN BEGIN
                    OTDay := FinalSettleLine.Amount / "Attended Days";
                    OTHrsAmount := (OTDay * OTHrs) / NoofHrs;
                END;
                OTTotal := OTTotal + OTHrsAmount;
            UNTIL Lookup.NEXT = 0;

        FinalSettleLine.RESET;
        FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
        FinalSettleLine.SETRANGE(Month, Month);
        FinalSettleLine.SETRANGE(Year, Year);
        FinalSettleLine.SETRANGE("Pay Element Code", 'OT');
        IF FinalSettleLine.FIND('-') THEN BEGIN
            FinalSettleLine.Amount := OTTotal;
            FinalSettleLine.MODIFY;
        END;
    end;

    // [Scope('Internal')]
    procedure LeaveAmount()
    var
        Lookup: Record 60018;
    begin
        Lookup.RESET;
        Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
        Lookup.SETRANGE("Leave Encashment", TRUE);
        IF Lookup.FIND('-') THEN
            REPEAT
                FinalSettleLine.RESET;
                FinalSettleLine.SETRANGE("Employee No.", "Employee No.");
                FinalSettleLine.SETRANGE(Month, Month);
                FinalSettleLine.SETRANGE(Year, Year);
                FinalSettleLine.SETRANGE("Pay Element Code", Lookup."Lookup Name");
                IF FinalSettleLine.FIND('-') THEN BEGIN
                END;
            UNTIL Lookup.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure "----Dimensions------"()
    begin
    end;

    // [Scope('Internal')]
    procedure InsertDimensions(FinalSettleLine: Record 60051)
    begin
        FinalSettleLine.VALIDATE("Employee No.");
    end;
}

