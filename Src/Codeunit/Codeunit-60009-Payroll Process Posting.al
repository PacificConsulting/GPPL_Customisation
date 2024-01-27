codeunit 60018 "Payroll Process Posting"
{

    trigger OnRun()
    begin
    end;

    var
        GenJnlLine: Record 81;
        HRSetup: Record 60016;
        Employee: Record 60019;
        MonAttendance: Record 60029;
        Loan: Record 60039;
        LoanPostingGroup: Record 60015;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text000: Label 'Account  in General posting group should be defined for pay element %1 %2.';
        Text001: Label 'Pay Product Posting group/PayElement  is not defined for the pay element %1 in Lookup.';
        BusinessPosting: Code[20];
        ProductPosting: Code[20];
        Text003: Label 'Processed Pay Element is not defined  in the Lookup.';
        PayBusiness: Code[20];
        PayElement: Code[20];
        Text004: Label 'Business  Posting Group not defined to Employee %1.';
        Month: Text[30];
        GenJnlLne1: Record 81;
        empcode: Code[30];
        "GenJnl-Post": Codeunit "Gen. Jnl.-Post";

    // [Scope('Internal')]
    procedure ProcessPosting(MonthlyAttendance: Record 60029)
    var
        GenJnlLine: Record 81;
        Lookup: Record 60018;
        Lookup2: Record 60018;
        AddLookup: Record 60018;
        DedLookup: Record 60018;
        CrLookup: Record 60018;
        EmpPostingGroup: Record 60056;
        CrEmpPostingGroup: Record 60056;
        PayrollBusinessPosting: Record 250;
        CrPayBusinessPosting: Record 250;
        PayrollProductPosting: Record 251;
        CrPayrollProductPosting: Record 251;
        PayrollGeneralPosting: Record 252;
        AddPayrollGeneralPosting: Record 252;
        AddPayrollBusinessPosting: Record 250;
        DedPayrollGeneralPosting: Record 252;
        DedPayrollBusinessPosting: Record 250;
        CrPayrollGeneralPosting: Record 252;
        ProcessedSalary: Record 60038;
        AddProcSalary: Record 60038;
        DedProcSalary: Record 60038;
        AddProcessedSalary: Record 60038;
        DedProcessedSalary: Record 60038;
        CrProcSalary: Record 60038;
        "AccountNo.": Code[20];
        "CrAccountNo.": Code[20];
        CrAccountType: Option "G/L Account";
        AccountType: Option "G/L Account";
        EmpTDSSetup: Record 60008;
    begin
        MonthlyAttendance.TESTFIELD("Document No.");
        MonthlyAttendance.TESTFIELD("Posting Date");
        MonthlyAttendance.TESTFIELD("Journal Batch Name");

        //LookupName is not defined for the Processed Pay Element//Additions
        AddProcSalary.SETCURRENTKEY("Add/Deduct", AddProcSalary."Add/Deduct Code");
        AddProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        AddProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        AddProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        AddProcSalary.SETRANGE("Add/Deduct", AddProcSalary."Add/Deduct"::Addition);
        IF AddProcSalary.FIND('-') THEN BEGIN
            REPEAT
                AddLookup.RESET;
                IF AddLookup.FIND('-') THEN
                    REPEAT
                        AddLookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                        AddLookup.SETRANGE("Add/Deduct", AddLookup."Add/Deduct"::Addition);
                        AddLookup.SETRANGE(AddLookup."Lookup Name", AddProcSalary."Add/Deduct Code");
                        IF AddLookup.FIND('-') THEN BEGIN
                        END ELSE
                            ERROR(Text001, AddProcSalary."Add/Deduct Code");
                    UNTIL AddLookup.NEXT = 0;
            UNTIL AddProcSalary.NEXT = 0;
        END;

        //LookupName is not defined for the Processed Pay Element//Deductions
        DedProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        DedProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
        DedProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        DedProcSalary.SETRANGE("Add/Deduct", DedProcSalary."Add/Deduct"::Deduction);
        DedProcSalary.SETFILTER("Computation Type", '<>%1', 'LOAN');
        IF DedProcSalary.FIND('-') THEN BEGIN
            REPEAT
                IF (DedProcSalary."Add/Deduct Code" <> 'ESI') AND (DedProcSalary."Add/Deduct Code" <> 'PF') AND
                   (DedProcSalary."Add/Deduct Code" <> 'PT') AND (DedProcSalary."Add/Deduct Code" <> 'Loan') AND
                   (DedProcSalary."Add/Deduct Code" <> 'TDS')
                THEN BEGIN
                    IF DedLookup.FIND('-') THEN
                        REPEAT
                            DedLookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                            DedLookup.SETRANGE("Add/Deduct", DedLookup."Add/Deduct"::Deduction);
                            DedLookup.SETRANGE("Lookup Name", DedProcSalary."Add/Deduct Code");
                            IF NOT DedLookup.FIND('-') THEN
                                ERROR(Text001, DedProcSalary."Add/Deduct Code");
                        UNTIL DedLookup.NEXT = 0;
                END;
            UNTIL DedProcSalary.NEXT = 0;
        END;

        //General Posting Group is not defined for the Pay Element//Additions
        Employee.RESET;
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        Employee.SETRANGE("Post to GL", TRUE);  //VE-003
        IF Employee.FIND('-') THEN
            //AddPayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group");
            AddProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        AddProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        AddProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        AddProcessedSalary.SETRANGE("Add/Deduct", AddProcessedSalary."Add/Deduct"::Addition);
        IF AddProcessedSalary.FIND('-') THEN BEGIN
            REPEAT
                IF AddPayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") THEN BEGIN
                    AddPayrollGeneralPosting.SETRANGE("Gen. Bus. Posting Group", AddPayrollBusinessPosting.Code);
                    IF AddPayrollGeneralPosting.FIND('-') THEN
                        PayBusiness := AddPayrollGeneralPosting."Gen. Bus. Posting Group";

                    Lookup2.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                    Lookup2.SETRANGE("Lookup Name", AddProcessedSalary."Add/Deduct Code");
                    Lookup2.SETRANGE("Add/Deduct", Lookup2."Add/Deduct"::Addition);
                    IF Lookup2.FIND('-') THEN BEGIN
                        Lookup2.TESTFIELD("Payroll Prod. Posting Group");
                        PayElement := Lookup2."Payroll Prod. Posting Group"
                    END ELSE
                        ERROR(Text003, Lookup2."Lookup Name");
                    AddPayrollGeneralPosting.SETRANGE("Gen. Prod. Posting Group", PayElement);
                    IF AddPayrollGeneralPosting.FIND('-') THEN BEGIN
                    END ELSE
                        ERROR(Text000, PayElement);
                END ELSE
                    ERROR(Text004, Employee."No.");
            UNTIL AddProcessedSalary.NEXT = 0;
        END;


        //General Posting Group is not defined for the Pay Element//Deductions
        Employee.RESET;
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        Employee.SETRANGE("Post to GL", TRUE);  //VE-003

        IF Employee.FIND('-') THEN
            DedProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        DedProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        DedProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        DedProcessedSalary.SETRANGE("Add/Deduct", DedProcessedSalary."Add/Deduct"::Deduction);
        DedProcessedSalary.SETFILTER("Computation Type", '<>%1', 'LOAN');
        IF DedProcessedSalary.FIND('-') THEN BEGIN
            REPEAT
                IF (DedProcessedSalary."Add/Deduct Code" <> 'ESI') AND (DedProcessedSalary."Add/Deduct Code" <> 'PF') AND
                 (DedProcessedSalary."Add/Deduct Code" <> 'PT') AND (DedProcessedSalary."Add/Deduct Code" <> 'Loan') AND
                 (DedProcessedSalary."Add/Deduct Code" <> 'TDS')
                THEN BEGIN

                    IF DedPayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") THEN
                        DedPayrollGeneralPosting.SETRANGE("Gen. Bus. Posting Group", DedPayrollBusinessPosting.Code);
                    IF DedPayrollGeneralPosting.FIND('-') THEN
                        PayBusiness := DedPayrollGeneralPosting."Gen. Bus. Posting Group";

                    Lookup2.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                    Lookup2.SETRANGE("Lookup Name", DedProcessedSalary."Add/Deduct Code");
                    Lookup2.SETRANGE("Add/Deduct", Lookup2."Add/Deduct"::Deduction);
                    IF Lookup2.FIND('-') THEN BEGIN
                        Lookup2.TESTFIELD("Payroll Prod. Posting Group");
                        PayElement := Lookup2."Payroll Prod. Posting Group"
                    END ELSE
                        ERROR(Text003, Lookup2."Lookup Name");

                    DedPayrollGeneralPosting.SETRANGE("Gen. Prod. Posting Group", PayElement);
                    IF DedPayrollGeneralPosting.FIND('-') THEN BEGIN
                    END ELSE
                        ERROR(Text000, PayElement);
                END;
            UNTIL DedProcessedSalary.NEXT = 0;
        END;

        //VE-003 >>

        //Update TDS Amount Setup

        EmpTDSSetup.RESET;
        EmpTDSSetup.SETRANGE(EmpTDSSetup."Employee Code", MonthlyAttendance."Employee Code");
        EmpTDSSetup.SETRANGE(Year, MonthlyAttendance.Year);
        EmpTDSSetup.SETRANGE(Month, MonthlyAttendance."Pay Slip Month");
        IF EmpTDSSetup.FIND('-') THEN BEGIN
            EmpTDSSetup.Posted := TRUE;
            EmpTDSSetup.MODIFY;
        END;

        //VE-003 <<


        //Debit Account
        Employee.RESET;
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        Employee.SETRANGE("Post to GL", TRUE);  //VE-003

        IF Employee.FIND('-') THEN BEGIN
            REPEAT
                IF PayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") THEN;
                BusinessPosting := PayrollBusinessPosting.Code;
                ProcessedSalary.RESET;
                ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
                ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
                ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
                ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
                IF ProcessedSalary.FIND('-') THEN BEGIN
                    REPEAT
                        Lookup.SETFILTER("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                        Lookup.SETRANGE("Lookup Name", ProcessedSalary."Add/Deduct Code");
                        IF Lookup.FIND('-') THEN BEGIN
                            IF PayrollProductPosting.GET(Lookup."Payroll Prod. Posting Group") THEN;
                            ProductPosting := PayrollProductPosting.Code;
                            PayrollGeneralPosting.SETRANGE("Gen. Bus. Posting Group", BusinessPosting);
                            PayrollGeneralPosting.SETRANGE("Gen. Prod. Posting Group", ProductPosting);
                            IF PayrollGeneralPosting.FIND('-') THEN BEGIN
                                "AccountNo." := PayrollGeneralPosting."Salary G/L Account";
                                AccountType := AccountType::"G/L Account";
                            END;
                            ProcessedSalary."Account No." := "AccountNo.";
                            ProcessedSalary.MODIFY;
                            InitGenJnlLine(
                              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                              "AccountNo.", AccountType, ProcessedSalary."Earned Amount");
                        END;
                    UNTIL ProcessedSalary.NEXT = 0;
                END;
            UNTIL Employee.NEXT = 0;
        END;

        // Credit Account other than Statutory and Loans
        Employee.RESET;
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        Employee.SETRANGE("Post to GL", TRUE);  //VE-003

        IF Employee.FIND('-') THEN BEGIN
            REPEAT
                IF CrPayBusinessPosting.GET(Employee."Payroll Bus. Posting Group") THEN;
                BusinessPosting := PayrollBusinessPosting.Code;
                CrProcSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
                CrProcSalary.SETRANGE(Year, MonthlyAttendance.Year);
                CrProcSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
                CrProcSalary.SETRANGE("Add/Deduct", CrProcSalary."Add/Deduct"::Deduction);
                CrProcSalary.SETFILTER("Computation Type", '<>%1', 'LOAN');
                IF CrProcSalary.FIND('-') THEN BEGIN
                    REPEAT
                        IF (CrProcSalary."Add/Deduct Code" <> 'ESI') AND (CrProcSalary."Add/Deduct Code" <> 'PF') AND
                           (CrProcSalary."Add/Deduct Code" <> 'PT') AND (CrProcSalary."Add/Deduct Code" <> 'Loan') AND
                           (CrProcSalary."Add/Deduct Code" <> 'TDS')
                        THEN BEGIN
                            CrLookup.SETFILTER("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                            CrLookup.SETRANGE("Lookup Name", CrProcSalary."Add/Deduct Code");
                            IF CrLookup.FIND('-') THEN BEGIN
                                IF CrPayrollProductPosting.GET(CrLookup."Payroll Prod. Posting Group") THEN;
                                ProductPosting := CrPayrollProductPosting.Code;
                                CrPayrollGeneralPosting.SETRANGE("Gen. Bus. Posting Group", BusinessPosting);
                                CrPayrollGeneralPosting.SETRANGE("Gen. Prod. Posting Group", ProductPosting);
                                IF CrPayrollGeneralPosting.FIND('-') THEN BEGIN
                                    "AccountNo." := CrPayrollGeneralPosting."Salary G/L Account";
                                    AccountType := AccountType::"G/L Account";
                                END;
                                CrProcSalary."Account No." := "AccountNo.";
                                CrProcSalary.MODIFY;
                                InitGenJnlLine(
                                  CrProcSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                                  MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                                  "AccountNo.", AccountType, -CrProcSalary."Earned Amount");
                            END;
                        END;
                    UNTIL CrProcSalary.NEXT = 0;
                END;
            UNTIL Employee.NEXT = 0;
        END;

        // Employer ESI Contribution
        IF HRSetup.FIND('-') THEN
            "AccountNo." := HRSetup."Employer ESI";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'ESI');
        IF ProcessedSalary.FIND('-') THEN
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, ProcessedSalary."Co. Contributions");

        // Employer PF Contribution
        IF HRSetup.FIND('-') THEN
            "AccountNo." := HRSetup."Employer PF";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'PF');
        IF ProcessedSalary.FIND('-') THEN
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, ProcessedSalary."Co. Contributions");

        // Employer EPS Contribution
        IF HRSetup.FIND('-') THEN
            "AccountNo." := HRSetup."Employer EPS";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'PF');
        IF ProcessedSalary.FIND('-') THEN
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, ProcessedSalary."Co. Contribution2");

        //PF AdminCharges
        IF HRSetup.FIND('-') THEN
            "AccountNo." := HRSetup."PF Admin. Charges";
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'PF');
        IF ProcessedSalary.FIND('-') THEN
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, ProcessedSalary."PF Admin Charges");

        //EDLI Charges
        IF HRSetup.FIND('-') THEN
            "AccountNo." := HRSetup."EDLI Charges";
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'PF');
        IF ProcessedSalary.FIND('-') THEN
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, ProcessedSalary."EDLI Charges");


        //RIFA Charges
        IF HRSetup.FIND('-') THEN
            "AccountNo." := HRSetup."RIFA Charges";
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'PF');
        IF ProcessedSalary.FIND('-') THEN
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, ProcessedSalary."RIFA Charges");


        Deductions(MonthlyAttendance);
    end;

    //  [Scope('Internal')]
    procedure Deductions(MonthlyAttendance: Record 60029)
    var
        ProcessedSalary: Record 60038;
        "AccountNo.": Code[20];
        AccountType: Option "G/L Account";
        EmpPostingGroup: Record 60056;
        ESIAmt: Decimal;
        PFAmt: Decimal;
        LoanAmt: Decimal;
        PTAmt: Decimal;
        Additions: Decimal;
        Deductions: Decimal;
        OtherDeductions: Decimal;
        TotalAmt: Decimal;
        RoundingAmt: Decimal;
        TotalAddRoundAmt: Decimal;
        TotalDedRoundAmt: Decimal;
    begin

        // ESI Account
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        Employee.SETRANGE("Post to GL", TRUE);  //VE-003

        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."ESI Payable Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'ESI');
        IF ProcessedSalary.FIND('-') THEN BEGIN
            ProcessedSalary."Account No." := "AccountNo.";
            ProcessedSalary.MODIFY;
            ESIAmt := ProcessedSalary."Earned Amount";
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, -(ProcessedSalary."Earned Amount" + ProcessedSalary."Co. Contributions"));
        END;

        // PF Account
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        Employee.SETRANGE("Post to GL", TRUE);  //VE-003

        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."PF Payable Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'PF');
        IF ProcessedSalary.FIND('-') THEN BEGIN
            ProcessedSalary."Account No." := "AccountNo.";
            ProcessedSalary.MODIFY;
            PFAmt := ProcessedSalary."Earned Amount";
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, -(ProcessedSalary."Earned Amount" + ProcessedSalary."Co. Contributions"));
        END;

        // EPS Account
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        Employee.SETRANGE("Post to GL", TRUE);  //VE-003

        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."EPS Payable Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'PF');
        IF ProcessedSalary.FIND('-') THEN BEGIN
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, -ProcessedSalary."Co. Contribution2");
        END;

        //Loan Account
        Loan.SETRANGE(Loan."Employee Code", MonthlyAttendance."Employee Code");
        IF Loan.FIND('-') THEN
            REPEAT
                LoanPostingGroup.SETRANGE(Code, Loan."Loan Posting Group");
                IF LoanPostingGroup.FIND('-') THEN
                    "AccountNo." := LoanPostingGroup."Loan Refundable Acc.";
                AccountType := AccountType::"G/L Account";
                ProcessedSalary.RESET;
                ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
                ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
                ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
                ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
                ProcessedSalary.SETRANGE("Computation Type", 'Loan');
                ProcessedSalary.SETRANGE("Add/Deduct Code", Loan."Loan Type");
                ProcessedSalary.SETRANGE("Loan Id", Loan.Id); //AR
                IF ProcessedSalary.FIND('-') THEN BEGIN
                    ProcessedSalary."Account No." := "AccountNo.";
                    ProcessedSalary.MODIFY;
                    InitGenJnlLine(
                      ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
                      MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
                      "AccountNo.", AccountType, -ProcessedSalary."Earned Amount");
                END;
            UNTIL Loan.NEXT = 0;

        // PT Payable Account
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        Employee.SETRANGE("Post to GL", TRUE);  //VE-003

        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."PT Payable Account";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'PT');
        IF ProcessedSalary.FIND('-') THEN BEGIN
            ProcessedSalary."Account No." := "AccountNo.";
            ProcessedSalary.MODIFY;
            PTAmt := ProcessedSalary."Earned Amount";
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, -ProcessedSalary."Earned Amount");
        END;

        //TDS Payable Account
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        Employee.SETRANGE("Post to GL", TRUE);  //VE-003

        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."TDS Payable Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'TDS');
        IF ProcessedSalary.FIND('-') THEN BEGIN
            ProcessedSalary."Account No." := "AccountNo.";
            ProcessedSalary.MODIFY;
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, -ProcessedSalary."Earned Amount");
        END;

        //Bonus Payable Account
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        Employee.SETRANGE("Post to GL", TRUE);  //VE-003

        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."Bonus Payable Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'BONUS');
        IF ProcessedSalary.FIND('-') THEN BEGIN
            ProcessedSalary."Account No." := "AccountNo.";
            ProcessedSalary.MODIFY;
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, -ProcessedSalary."Earned Amount");
        END;

        // Salary Payable Account
        Additions := 0;
        Deductions := 0;
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        Employee.SETRANGE("Post to GL", TRUE);  //VE-003

        IF Employee.FIND('-') THEN BEGIN
            Employee.TESTFIELD(Employee."Emp Posting Group");
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
            IF EmpPostingGroup.FIND('-') THEN
                "AccountNo." := EmpPostingGroup."Salary Payable Acc.";
            AccountType := AccountType::"G/L Account";
            ProcessedSalary.RESET;
            ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
            ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
            ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
            ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
            IF ProcessedSalary.FIND('-') THEN BEGIN
                REPEAT
                    Additions := Additions + ProcessedSalary."Earned Amount";
                UNTIL ProcessedSalary.NEXT = 0;
                //TotalAddRoundAmt := Additions-Rounding(Additions);
            END;
            ProcessedSalary.RESET;
            ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
            ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
            ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
            ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
            IF ProcessedSalary.FIND('-') THEN BEGIN
                REPEAT
                    Deductions := Deductions + ProcessedSalary."Earned Amount";
                UNTIL ProcessedSalary.NEXT = 0;
                //TotalDedRoundAmt := Deductions-Rounding(Deductions);
            END;
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, -(Additions - Deductions));

        END;

        //PF AdminCharges
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        Employee.SETRANGE("Post to GL", TRUE);  //VE-003

        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."PF Admin Charge Payable Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'PF');
        IF ProcessedSalary.FIND('-') THEN BEGIN
            ProcessedSalary."Account No." := "AccountNo.";
            ProcessedSalary.MODIFY;
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, -ProcessedSalary."PF Admin Charges");
        END;


        //EDLI Charges
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        Employee.SETRANGE("Post to GL", TRUE);  //VE-003

        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."EDLI Charges Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'PF');
        IF ProcessedSalary.FIND('-') THEN BEGIN
            ProcessedSalary."Account No." := "AccountNo.";
            ProcessedSalary.MODIFY;
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, -ProcessedSalary."EDLI Charges");
        END;

        //RIFA Charges
        Employee.SETRANGE("No.", MonthlyAttendance."Employee Code");
        Employee.SETRANGE("Post to GL", TRUE);  //VE-003

        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."RIFA Charges Acc.";
        AccountType := AccountType::"G/L Account";
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", MonthlyAttendance."Employee Code");
        ProcessedSalary.SETRANGE(Year, MonthlyAttendance.Year);
        ProcessedSalary.SETRANGE("Pay Slip Month", MonthlyAttendance."Pay Slip Month");
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Deduction);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'PF');
        IF ProcessedSalary.FIND('-') THEN BEGIN
            ProcessedSalary."Account No." := "AccountNo.";
            ProcessedSalary.MODIFY;
            InitGenJnlLine(
              ProcessedSalary, MonthlyAttendance."Journal Template Name", MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.", MonthlyAttendance."Posting Date",
              "AccountNo.", AccountType, -ProcessedSalary."RIFA Charges");
        END;
    end;

    //  [Scope('Internal')]
    procedure InitGenJnlLine(var ProcessedSalary: Record 60038; JournalTemplate: Code[20]; JournalBatch: Code[20]; "DocumentNo.": Code[20]; PostDate: Date; "AccountNo.": Code[20]; AccountType: Option "G/L Account","Bank Account"; Amount: Decimal)
    var
        ProcSalary: Record 60038;
        DimMgt: Codeunit "Dimension Value-Indent";
        DocumentNo: Code[20];
        MonAttendDim: Record 60055;
        LineNo: Integer;
        Amount2: Decimal;
        ProcessSal: Record 60038;
        GenJnl: Record 81;
        GenJnlLine2: Record 81;
        LineNo2: Integer;
        Emp: Record 60019;
        TempDimSetEntry: Record 480 temporary;
        cduDimMgt: Codeunit DimensionManagement;
        RecDimSetEntry: Record 480;
    begin
        Amount2 := ROUND(Amount, 0.01, '<');

        GenJnlLine2.RESET;
        GenJnlLine2.SETRANGE("Journal Template Name", JournalTemplate);
        GenJnlLine2.SETRANGE("Journal Batch Name", JournalBatch);
        IF GenJnlLine2.FIND('+') THEN
            LineNo2 := GenJnlLine2."Line No." + 10000
        ELSE
            LineNo2 := 0;
        IF Amount2 <> 0 THEN BEGIN
            GenJnlLine.RESET;
            GenJnlLine."Journal Template Name" := JournalTemplate;
            GenJnlLine."Journal Batch Name" := JournalBatch;
            GenJnlLine."Line No." := LineNo2;
            GenJnlLine."Account Type" := AccountType;
            GenJnlLine."Account No." := "AccountNo.";
            GenJnlLine.VALIDATE("Account No.");
            GenJnlLine."Document No." := "DocumentNo.";
            GenJnlLine."Posting Date" := PostDate;
            GenJnlLine.Description := GenJnlLine.Description + ' ' +
                                      ReturnMonth(ProcessedSalary."Pay Slip Month") + ' ' +
                                      FORMAT(ProcessedSalary.Year);
            GenJnlLine."Bal. Account Type" := AccountType;
            GenJnlLine.Amount := Amount;
            GenJnlLine.VALIDATE(Amount);
            GenJnlLine."Source Code" := 'GENJNL';
            //IF Emp.GET(ProcessedSalary."Employee Code") THEN
            //  GenJnlLine."Shortcut Dimension 1 Code" := Emp."Global Dimension 1 Code";
            GenJnlLine.INSERT;
            //RSPL-TC +
            TempDimSetEntry.RESET;
            TempDimSetEntry.DELETEALL;

            RecDimSetEntry.RESET;
            RecDimSetEntry.SETRANGE("Dimension Set ID", GenJnlLine."Dimension Set ID");
            IF RecDimSetEntry.FINDSET THEN
                REPEAT
                    TempDimSetEntry.INIT;
                    TempDimSetEntry.VALIDATE("Dimension Code", RecDimSetEntry."Dimension Code");
                    TempDimSetEntry.VALIDATE("Dimension Value Code", RecDimSetEntry."Dimension Value Code");
                    TempDimSetEntry.INSERT;
                UNTIL RecDimSetEntry.NEXT = 0;
            //RSPL-TC -
            MonAttendance.SETRANGE("Employee Code", ProcessedSalary."Employee Code");
            MonAttendance.SETRANGE("Pay Slip Month", ProcessedSalary."Pay Slip Month");
            MonAttendance.SETRANGE(Year, ProcessedSalary.Year);
            MonAttendance.SETRANGE("Post to GL", TRUE); //VE-003
            IF MonAttendance.FIND('-') THEN BEGIN
                //JnlDim.DELETEALL;
                MonAttendDim.RESET;
                MonAttendDim.SETRANGE("Employee Code", MonAttendance."Employee Code");
                MonAttendDim.SETRANGE(Month, MonAttendance."Pay Slip Month");
                MonAttendDim.SETRANGE(Year, MonAttendance.Year);
                MonAttendDim.SETRANGE("Mon Line No.", MonAttendance."Line No.");
                //LineNo := Lineno2;
                IF MonAttendDim.FIND('-') THEN BEGIN
                    REPEAT
                        /*

                              JnlDim1.RESET;
                              JnlDim1.SETRANGE("Journal Template Name",GenJnlLine."Journal Template Name");
                              JnlDim1.SETRANGE("Journal Batch Name",GenJnlLine."Journal Batch Name");
                              JnlDim1.SETRANGE("Dimension Code",MonAttendDim."Dimension Code");
                              JnlDim1.SETRANGE("Dimension Value Code",MonAttendDim."Dimension Value Code");
                              IF JnlDim1.FIND('-') THEN
                              REPEAT
                                 JnlDim1.DELETE;
                              UNTIL JnlDim1.NEXT=0;

                              JnlDim1.RESET;
                              JnlDim1.SETRANGE("Journal Template Name",GenJnlLine."Journal Template Name");
                              JnlDim1.SETRANGE("Journal Batch Name",GenJnlLine."Journal Batch Name");
                              JnlDim1.SETRANGE("Dimension Code",MonAttendDim."Dimension Code");
                              IF JnlDim1.FIND('+') THEN
                                LineNo := JnlDim1."Journal Line No." + 10000;

                              */
                        /*  //RSPL-TC
            IF NOT JnlDim.GET(81,GenJnlLine."Journal Template Name",GenJnlLine."Journal Batch Name",LineNo2,0,MonAttendDim."Dimension Code")
               THEN BEGIN
                    JnlDim.INIT;
                    JnlDim."Table ID" := 81;
                    JnlDim."Journal Template Name" := GenJnlLine."Journal Template Name";
                    JnlDim."Journal Batch Name" := GenJnlLine."Journal Batch Name";
                    JnlDim."Journal Line No." := LineNo2;
                    JnlDim.VALIDATE("Dimension Code" , MonAttendDim."Dimension Code");
                    JnlDim.VALIDATE("Dimension Value Code" , MonAttendDim."Dimension Value Code");
                    JnlDim.INSERT;
                END; */
                        //RSPL-TC +
                        TempDimSetEntry.RESET;
                        TempDimSetEntry.SETRANGE("Dimension Code", MonAttendDim."Dimension Code");
                        TempDimSetEntry.SETRANGE("Dimension Value Code", MonAttendDim."Dimension Value Code");
                        IF NOT TempDimSetEntry.FINDSET THEN BEGIN
                            TempDimSetEntry.INIT;
                            TempDimSetEntry.VALIDATE("Dimension Code", MonAttendDim."Dimension Code");
                            TempDimSetEntry.VALIDATE("Dimension Value Code", MonAttendDim."Dimension Value Code");
                            TempDimSetEntry.INSERT;
                        END;
                    //RSPL-TC -
                    UNTIL MonAttendDim.NEXT = 0
                END;
            END;
            //RSPL-TC +
            GenJnlLine."Dimension Set ID" := cduDimMgt.GetDimensionSetID(TempDimSetEntry);
            GenJnlLine.MODIFY;
            //RSPL-TC -
            //GenJnlPostLine.RunWithCheck(GenJnlLine,JnlDim);
        END;

    end;

    //  [Scope('Internal')]
    procedure Rounding(Amount: Decimal) "Final Amount": Decimal
    var
        HRSetup: Record 60016;
        "Rounding Precision": Decimal;
        "Rounding Direction": Text[30];
    begin
        //IF NOT HRSetup.GET THEN ERROR(Error0001);
        IF HRSetup.FIND('+') THEN BEGIN
            "Rounding Precision" := HRSetup."Rounding Precision";
            CASE HRSetup."Rounding Type" OF
                0:
                    "Rounding Direction" := '=';
                1:
                    "Rounding Direction" := '>';
                2:
                    "Rounding Direction" := '<';
            END;
            "Final Amount" := ROUND(Amount, "Rounding Precision", "Rounding Direction");
        END;
    end;

    //  [Scope('Internal')]
    procedure ReturnMonth(Month: Integer): Code[20]
    begin

        IF Month = 1 THEN
            EXIT('Jan')
        ELSE
            IF Month = 2 THEN
                EXIT('Febuary')
            ELSE
                IF Month = 3 THEN
                    EXIT('March')
                ELSE
                    IF Month = 4 THEN
                        EXIT('April')
                    ELSE
                        IF Month = 5 THEN
                            EXIT('May')
                        ELSE
                            IF Month = 6 THEN
                                EXIT('June')
                            ELSE
                                IF Month = 7 THEN
                                    EXIT('July')
                                ELSE
                                    IF Month = 8 THEN
                                        EXIT('August')
                                    ELSE
                                        IF Month = 9 THEN
                                            EXIT('Septmeber')
                                        ELSE
                                            IF Month = 10 THEN
                                                EXIT('October')
                                            ELSE
                                                IF Month = 11 THEN
                                                    EXIT('November')
                                                ELSE
                                                    IF Month = 12 THEN
                                                        EXIT('December');
    end;
}

