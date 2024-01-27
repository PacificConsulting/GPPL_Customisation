codeunit 60011 "Final Settlement Posting"
{
    // 22-May-06


    trigger OnRun()
    begin
    end;

    var
        Text000: Label 'Account  in General posting group should be defined for pay element %1 %2.';
        Text001: Label 'Pay Product Posting group/PayElement  is not defined for the pay element %1 in Lookup.';
        Text003: Label 'Processed Pay Element is not defined  in the Lookup.';
        Text004: Label 'Business  Posting Group not defined to Employee %1.';
        GenJnlLine: Record 81;
        Employee: Record 60019;
        HRSetup: Record 60016;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BusinessPosting: Code[20];
        ProductPosting: Code[20];
        PayBusiness: Code[20];
        PayElement: Code[20];
        Text005: Label 'Records are Posted';

    //  [Scope('Internal')]
    procedure ProcessPosting(FinalSettleHeader: Record 60050)
    var
        GenJnlLine: Record 81;
        Employee: Record 60019;
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
        FinalSettlementLine: Record 60051;
        DedFinalSettlementLine: Record 60051;
        AddFinalSettlementLine: Record 60051;
        "AccountNo.": Code[20];
        "CrAccountNo.": Code[20];
        CrAccountType: Option "G/L Account";
        AccountType: Option "G/L Account";
    begin
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        IF FinalSettlementLine.FIND('-') THEN BEGIN
            FinalSettlementLine.TESTFIELD("Document No.");
            FinalSettlementLine.TESTFIELD("Posting Date");
            FinalSettlementLine.TESTFIELD("Journal Batch Name");
        END;


        //LookupName is not defined for the Pay Revision Line Pay Element//Additions

        AddFinalSettlementLine.RESET;
        //FinalSettlementLine.SETCURRENTKEY("Add/Deduct","Pay Element");
        AddFinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        AddFinalSettlementLine.SETRANGE("Addition/Deduction", AddFinalSettlementLine."Addition/Deduction"::Addition);
        IF AddFinalSettlementLine.FIND('-') THEN BEGIN
            REPEAT
                AddLookup.RESET;
                IF AddLookup.FIND('-') THEN
                    REPEAT
                        AddLookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                        AddLookup.SETRANGE("Add/Deduct", AddLookup."Add/Deduct"::Addition);
                        AddLookup.SETRANGE(AddLookup."Lookup Name", AddFinalSettlementLine."Pay Element Code");
                        IF NOT AddLookup.FIND('-') THEN
                            ERROR(Text001, AddFinalSettlementLine."Pay Element Code");
                    UNTIL AddLookup.NEXT = 0;
            UNTIL AddFinalSettlementLine.NEXT = 0;
        END;

        //LookupName is not defined for the Pay Revision Line Pay Element//Deductions

        DedFinalSettlementLine.RESET;
        //DedFinalSettlementLine.SETCURRENTKEY("Add/Deduct","Pay Element");
        DedFinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        DedFinalSettlementLine.SETRANGE("Addition/Deduction", DedFinalSettlementLine."Addition/Deduction"::Deduction);
        IF DedFinalSettlementLine.FIND('-') THEN BEGIN
            REPEAT
                DedLookup.RESET;
                IF DedLookup.FIND('-') THEN
                    REPEAT
                        DedLookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                        DedLookup.SETRANGE("Add/Deduct", DedLookup."Add/Deduct"::Deduction);
                        DedLookup.SETRANGE("Lookup Name", DedFinalSettlementLine."Pay Element Code");
                        IF NOT DedLookup.FIND('-') THEN
                            ERROR(Text001, DedFinalSettlementLine."Pay Element Code");
                    UNTIL DedLookup.NEXT = 0;
            UNTIL DedFinalSettlementLine.NEXT = 0;
        END;

        //General Posting Group is not defined for the Pay Element//Additions

        Employee.RESET;
        Employee.SETRANGE("No.", FinalSettleHeader."Employee No.");
        IF Employee.FIND('-') THEN
            //AddPayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group");
            AddFinalSettlementLine.RESET;
        AddFinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        AddFinalSettlementLine.SETRANGE("Addition/Deduction", AddFinalSettlementLine."Addition/Deduction"::Addition);
        IF AddFinalSettlementLine.FIND('-') THEN BEGIN
            REPEAT
                IF AddPayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") THEN BEGIN
                    AddPayrollGeneralPosting.SETRANGE("Gen. Bus. Posting Group", AddPayrollBusinessPosting.Code);
                    IF AddPayrollGeneralPosting.FIND('-') THEN
                        PayBusiness := AddPayrollGeneralPosting."Gen. Bus. Posting Group";

                    Lookup2.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                    Lookup2.SETRANGE("Lookup Name", AddFinalSettlementLine."Pay Element Code");
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
            UNTIL AddFinalSettlementLine.NEXT = 0;
        END;

        //General Posting Group is not defined for the Pay Element//Deductions

        Employee.RESET;
        Employee.SETRANGE("No.", FinalSettleHeader."Employee No.");
        IF Employee.FIND('-') THEN
            DedFinalSettlementLine.RESET;
        DedFinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        DedFinalSettlementLine.SETRANGE("Addition/Deduction", DedFinalSettlementLine."Addition/Deduction"::Deduction);
        DedFinalSettlementLine.SETFILTER("Computation Type", '<>%1', 'LOAN');
        IF DedFinalSettlementLine.FIND('-') THEN BEGIN
            REPEAT
                IF (DedFinalSettlementLine."Pay Element Code" <> 'ESI') AND (DedFinalSettlementLine."Pay Element Code" <> 'PF') AND
                   (DedFinalSettlementLine."Pay Element Code" <> 'PT') AND (DedFinalSettlementLine."Pay Element Code" <> 'Loan') AND
                   (DedFinalSettlementLine."Pay Element Code" <> 'TDS')
                THEN BEGIN
                    IF DedPayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") THEN
                        DedPayrollGeneralPosting.SETRANGE("Gen. Bus. Posting Group", DedPayrollBusinessPosting.Code);
                    IF DedPayrollGeneralPosting.FIND('-') THEN
                        PayBusiness := DedPayrollGeneralPosting."Gen. Bus. Posting Group";

                    Lookup2.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                    Lookup2.SETRANGE("Lookup Name", DedFinalSettlementLine."Pay Element Code");
                    Lookup2.SETRANGE("Add/Deduct", Lookup2."Add/Deduct"::Deduction);
                    IF Lookup2.FIND('-') THEN BEGIN
                        Lookup2.TESTFIELD("Payroll Prod. Posting Group");
                        PayElement := Lookup2."Payroll Prod. Posting Group";
                    END ELSE
                        ERROR(Text003, Lookup2."Lookup Name");

                    DedPayrollGeneralPosting.SETRANGE("Gen. Prod. Posting Group", PayElement);
                    IF DedPayrollGeneralPosting.FIND('-') THEN BEGIN
                    END ELSE
                        ERROR(Text000, PayElement);
                END;
            UNTIL DedFinalSettlementLine.NEXT = 0;
        END;


        //Debit Account

        Employee.RESET;
        Employee.SETRANGE("No.", FinalSettleHeader."Employee No.");
        IF Employee.FIND('-') THEN BEGIN
            REPEAT
                IF PayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") THEN;
                BusinessPosting := PayrollBusinessPosting.Code;
                FinalSettlementLine.RESET;
                FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
                FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Addition);
                IF FinalSettlementLine.FIND('-') THEN BEGIN
                    REPEAT
                        Lookup.SETFILTER("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                        Lookup.SETRANGE("Lookup Name", FinalSettlementLine."Pay Element Code");
                        IF Lookup.FIND('-') THEN BEGIN
                            IF PayrollProductPosting.GET(Lookup."Payroll Prod. Posting Group") THEN;
                            ProductPosting := PayrollProductPosting.Code;
                            PayrollGeneralPosting.SETRANGE("Gen. Bus. Posting Group", BusinessPosting);
                            PayrollGeneralPosting.SETRANGE("Gen. Prod. Posting Group", ProductPosting);
                            IF PayrollGeneralPosting.FIND('-') THEN BEGIN
                                "AccountNo." := PayrollGeneralPosting."Salary G/L Account";
                                AccountType := AccountType::"G/L Account";
                            END;
                            InitGenJnlLine(FinalSettlementLine, "AccountNo.", AccountType, FinalSettlementLine.Amount);
                        END;
                    UNTIL FinalSettlementLine.NEXT = 0;
                END;
            UNTIL Employee.NEXT = 0;
        END;

        // Credit Account other than Statutory and Loans


        Employee.RESET;
        Employee.SETRANGE("No.", FinalSettleHeader."Employee No.");
        IF Employee.FIND('-') THEN BEGIN
            REPEAT
                IF CrPayBusinessPosting.GET(Employee."Payroll Bus. Posting Group") THEN;
                BusinessPosting := PayrollBusinessPosting.Code;
                FinalSettlementLine.RESET;
                FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
                FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
                FinalSettlementLine.SETFILTER("Computation Type", '<>%1', 'LOAN');
                IF FinalSettlementLine.FIND('-') THEN BEGIN
                    REPEAT
                        IF (FinalSettlementLine."Pay Element Code" <> 'ESI') AND (FinalSettlementLine."Pay Element Code" <> 'PF') AND
                           (FinalSettlementLine."Pay Element Code" <> 'PT') AND (FinalSettlementLine."Pay Element Code" <> 'Loan') AND
                           (FinalSettlementLine."Pay Element Code" <> 'TDS')
                        THEN BEGIN
                            CrLookup.SETFILTER("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                            CrLookup.SETRANGE("Lookup Name", FinalSettlementLine."Pay Element Code");
                            IF CrLookup.FIND('-') THEN BEGIN
                                IF CrPayrollProductPosting.GET(CrLookup."Payroll Prod. Posting Group") THEN;
                                ProductPosting := CrPayrollProductPosting.Code;
                                CrPayrollGeneralPosting.SETRANGE("Gen. Bus. Posting Group", BusinessPosting);
                                CrPayrollGeneralPosting.SETRANGE("Gen. Prod. Posting Group", ProductPosting);
                                IF CrPayrollGeneralPosting.FIND('-') THEN BEGIN
                                    "AccountNo." := CrPayrollGeneralPosting."Salary G/L Account";
                                    AccountType := AccountType::"G/L Account";
                                END;
                            END;
                            InitGenJnlLine(FinalSettlementLine, "AccountNo.", AccountType, -FinalSettlementLine.Amount);
                        END;
                    UNTIL FinalSettlementLine.NEXT = 0;
                END;
            UNTIL Employee.NEXT = 0;
        END;

        // Employer ESI Contribution

        IF HRSetup.FIND('-') THEN
            "AccountNo." := HRSetup."Employer ESI";
        AccountType := AccountType::"G/L Account";

        FinalSettlementLine.RESET;
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE("Pay Element Code", 'ESI');
        IF FinalSettlementLine.FIND('-') THEN
            InitGenJnlLine(FinalSettlementLine, "AccountNo.", AccountType, FinalSettlementLine."Co. Contribution");

        // Employer PF Contribution

        IF HRSetup.FIND('-') THEN
            "AccountNo." := HRSetup."Employer PF";
        AccountType := AccountType::"G/L Account";

        FinalSettlementLine.RESET;
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        //FinalSettlementLine.SETRANGE(Type,PayRevisionHeader.Type);
        //FinalSettlementLine.SETRANGE("No.",PayRevisionHeader."No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE("Pay Element Code", 'PF');
        IF FinalSettlementLine.FIND('-') THEN
            InitGenJnlLine(FinalSettlementLine, "AccountNo.", AccountType, FinalSettlementLine."Co. Contribution");

        // Employer EPS Contribution

        IF HRSetup.FIND('-') THEN
            "AccountNo." := HRSetup."Employer EPS";
        AccountType := AccountType::"G/L Account";

        FinalSettlementLine.RESET;
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE("Pay Element Code", 'PF');
        IF FinalSettlementLine.FIND('-') THEN
            InitGenJnlLine(FinalSettlementLine, "AccountNo.", AccountType, FinalSettlementLine."Co. Contribution2");

        DeductionPosting(FinalSettleHeader);

        Employee.SETRANGE("No.", FinalSettleHeader."Employee No.");
        IF Employee.FIND('-') THEN BEGIN
            Employee.VALIDATE(Blocked, TRUE); //UD 13th Dec to validate
            Employee.MODIFY;
            MESSAGE(Text005);
        END;

        //UD 19th DEC
        FinalSettlementLine.RESET;
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettleHeader."Employee No.");
        IF FinalSettlementLine.FIND('-') THEN
            REPEAT
                FinalSettlementLine.Posted := TRUE;
                FinalSettlementLine.MODIFY;
            UNTIL FinalSettlementLine.NEXT = 0;
        //UD 19th DEC
    end;

    // [Scope('Internal')]
    procedure DeductionPosting(FinalSettlementHeader: Record 60050)
    var
        FinalSettlementLine: Record 60051;
        EmpPostingGroup: Record 60056;
        "AccountNo.": Code[20];
        AccountType: Option "G/L Account";
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

        Employee.SETRANGE("No.", FinalSettlementHeader."Employee No.");
        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."ESI Payable Acc.";
        AccountType := AccountType::"G/L Account";
        FinalSettlementLine.RESET;
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementHeader."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE("Pay Element Code", 'ESI');
        IF FinalSettlementLine.FIND('-') THEN BEGIN
            REPEAT
                ESIAmt := FinalSettlementLine.Amount;
                InitGenJnlLine(
                  FinalSettlementLine, "AccountNo.", AccountType,
                  -(FinalSettlementLine.Amount + FinalSettlementLine."Co. Contribution"));
            UNTIL FinalSettlementLine.NEXT = 0;
        END;

        // PF Account

        Employee.RESET;
        Employee.SETRANGE("No.", FinalSettlementHeader."Employee No.");
        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."PF Payable Acc.";

        AccountType := AccountType::"G/L Account";
        FinalSettlementLine.RESET;
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementHeader."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE(FinalSettlementLine."Pay Element Code", 'PF');
        IF FinalSettlementLine.FIND('-') THEN BEGIN
            REPEAT
                PFAmt := FinalSettlementLine.Amount;
                InitGenJnlLine(
                  FinalSettlementLine, "AccountNo.", AccountType,
                  -(FinalSettlementLine.Amount + FinalSettlementLine."Co. Contribution"));
            UNTIL FinalSettlementLine.NEXT = 0;
        END;

        // EPS Account
        Employee.SETRANGE("No.", FinalSettlementHeader."Employee No.");
        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."EPS Payable Acc.";
        AccountType := AccountType::"G/L Account";

        FinalSettlementLine.RESET;
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementLine."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE("Pay Element Code", 'PF');
        IF FinalSettlementLine.FIND('-') THEN BEGIN
            InitGenJnlLine(
               FinalSettlementLine, "AccountNo.", AccountType, -(FinalSettlementLine."Co. Contribution2"));
        END;


        // Loan Account

        // PT Payable Account
        Employee.SETRANGE("No.", FinalSettlementHeader."Employee No.");
        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."PT Payable Account";
        AccountType := AccountType::"G/L Account";
        FinalSettlementLine.RESET;
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementLine."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE("Pay Element Code", 'PT');
        IF FinalSettlementLine.FIND('-') THEN BEGIN
            InitGenJnlLine(
              FinalSettlementLine, "AccountNo.", AccountType, -FinalSettlementLine.Amount);
        END;

        //TDS Payable Account
        Employee.SETRANGE("No.", FinalSettlementHeader."Employee No.");
        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."TDS Payable Acc.";
        AccountType := AccountType::"G/L Account";
        FinalSettlementLine.RESET;
        FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementLine."Employee No.");
        FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
        FinalSettlementLine.SETRANGE("Pay Element Code", 'TDS');
        IF FinalSettlementLine.FIND('-') THEN BEGIN
            InitGenJnlLine(
              FinalSettlementLine, "AccountNo.", AccountType, -FinalSettlementLine.Amount);
        END;



        // Salary Payable Account
        Additions := 0;
        Deductions := 0;
        Employee.SETRANGE("No.", FinalSettlementHeader."Employee No.");
        IF Employee.FIND('-') THEN BEGIN
            Employee.TESTFIELD(Employee."Emp Posting Group");
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
            IF EmpPostingGroup.FIND('-') THEN
                "AccountNo." := EmpPostingGroup."Arrear Salary Payable Acc.";
            AccountType := AccountType::"G/L Account";
            FinalSettlementLine.RESET;
            FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementHeader."Employee No.");
            FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Addition);
            IF FinalSettlementLine.FIND('-') THEN BEGIN
                REPEAT
                    Additions := Additions + FinalSettlementLine.Amount;
                UNTIL FinalSettlementLine.NEXT = 0;
                //TotalAddRoundAmt := Additions-Rounding(Additions);
            END;

            FinalSettlementLine.RESET;
            FinalSettlementLine.SETRANGE("Employee No.", FinalSettlementHeader."Employee No.");
            FinalSettlementLine.SETRANGE("Addition/Deduction", FinalSettlementLine."Addition/Deduction"::Deduction);
            IF FinalSettlementLine.FIND('-') THEN BEGIN
                REPEAT
                    Deductions := Deductions + FinalSettlementLine.Amount;
                //TotalDedRoundAmt := Deductions-Rounding(Deductions);
                UNTIL FinalSettlementLine.NEXT = 0;
            END;

            /* TotalAmt := TotalAddRoundAmt - TotalDedRoundAmt;
              RoundingAmt := Rounding(TotalAmt); */

            InitGenJnlLine(FinalSettlementLine, "AccountNo.", AccountType, -(Additions - Deductions));

            /*InitGenJnlLine(
              ProcessedSalary,MonthlyAttendance."Journal Template Name",MonthlyAttendance."Journal Batch Name",
              MonthlyAttendance."Document No.",MonthlyAttendance."Posting Date",
              "AccountNo.",AccountType,0.333);*/
        END;

    end;

    // [Scope('Internal')]
    procedure InitGenJnlLine(var FinalSettlementLine: Record 60051; "AccountNo.": Code[20]; AccountType: Option "G/L Account","Bank Account"; Amount: Decimal)
    var
        DimMgt: Codeunit DimensionManagement;
        DocumentNo: Code[20];
    begin
        IF Amount <> 0 THEN BEGIN
            GenJnlLine.INIT;
            GenJnlLine."Journal Template Name" := FinalSettlementLine."Journal Template Name";
            GenJnlLine."Journal Batch Name" := FinalSettlementLine."Journal Batch Name";
            GenJnlLine."Line No." := GenJnlLine."Line No." + 10000;
            GenJnlLine."Account Type" := AccountType;
            GenJnlLine."Account No." := "AccountNo.";
            GenJnlLine.VALIDATE("Account No.");
            GenJnlLine."Document No." := FinalSettlementLine."Document No.";
            //GenJnlLine."Document Type" := FinalSettlementLine."Document Type" :: p;
            GenJnlLine."Posting Date" := FinalSettlementLine."Posting Date";
            /*GenJnlLine.Description :=
               GenJnlLine.Description+' '+
               FORMAT(ProcessedSalary."Pay Slip Month")+' '+
               FORMAT(ProcessedSalary.Year);
            */
            //GenJnlLine.Description := ;
            GenJnlLine."Bal. Account Type" := AccountType;
            GenJnlLine.Amount := Amount;
            GenJnlLine.VALIDATE(Amount);
            GenJnlLine."Source Code" := 'GENJNL';
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::"Fixed Asset";
            GenJnlLine."Source No." := FinalSettlementLine."Employee No.";
            //GenJnlLine."Payslip Month" := ProcessedSalary."Pay Slip Month";
            //GenJnlLine."Payslip Year" := ProcessedSalary.Year;
            /* //RSPL-TC
            DocDim.RESET;
            DocDim.SETRANGE("Table ID",80081);
            DocDim.SETRANGE("Document Type",FinalSettlementLine."Document Type");
            DocDim.SETRANGE("Document No.",FinalSettlementLine."Employee No.");
            DocDim.SETRANGE("Line No.",FinalSettlementLine."Line No.");
            IF DocDim.FIND('-') THEN BEGIN
              DimMgt.CopyDocDimToJnlLineDim(DocDim,TempJnlLineDim);
            END;
            */ //RSPL-TC
            GenJnlLine."Dimension Set ID" := FinalSettlementLine."Dimension Set ID";  //RSPL-TC
            GenJnlPostLine.RunWithCheck(GenJnlLine);
        END;

    end;

    // [Scope('Internal')]
    procedure DeleteDim(var FinalSettlementLine: Record 60051)
    begin
        /*  //RSPL-TC
        DocDim.RESET;
        DocDim.SETRANGE("Table ID",50054);
        DocDim.SETRANGE("Document Type",FinalSettlementLine."Document Type");
        DocDim.SETRANGE("Document No.",FinalSettlementLine."Employee No.");
        //DocDim.SETRANGE("Line No.",FinalSettlementLine."Line No.");
        IF DocDim.FIND('-') THEN
          REPEAT
            DocDim.DELETE;
          UNTIL DocDim.NEXT = 0;
          */  //RSPL-TC
        FinalSettlementLine."Dimension Set ID" := 0;  //RSPL-TC

    end;
}

