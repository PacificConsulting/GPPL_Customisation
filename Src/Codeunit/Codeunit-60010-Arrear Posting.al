codeunit 60010 "Arrear Posting"
{
    // 17-May-06


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
        DefDim: Record 352;
        LineNo: Integer;
        TempDimSetEntry: Record 480 temporary;
        cduDimMgt: Codeunit DimensionManagement;
        RecDimSetEntry: Record 480;

    // [Scope('Internal')]
    procedure ProcessPosting(PayRevisionHeader: Record 60048)
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
        AddPayRevisionLine: Record 60049;
        DedPayRevisionLine: Record 60049;
        PayRevisionLine: Record 60049;
        "AccountNo.": Code[20];
        "CrAccountNo.": Code[20];
        CrAccountType: Option "G/L Account";
        AccountType: Option "G/L Account";
    begin
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        IF PayRevisionLine.FIND('-') THEN
            REPEAT
                PayRevisionLine.TESTFIELD("Document No.");
                PayRevisionLine.TESTFIELD("Posting Date");
                PayRevisionLine.TESTFIELD("Journal Batch Name");
            UNTIL PayRevisionLine.NEXT = 0;

        //LookupName is not defined for the Pay Revision Line Pay Element//Additions

        AddPayRevisionLine.RESET;
        AddPayRevisionLine.SETCURRENTKEY("Add/Deduct", "Pay Element");
        AddPayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        AddPayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        AddPayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        AddPayRevisionLine.SETRANGE("Add/Deduct", AddPayRevisionLine."Add/Deduct"::Addition);
        IF AddPayRevisionLine.FIND('-') THEN BEGIN
            REPEAT
                AddLookup.RESET;
                IF AddLookup.FIND('-') THEN
                    REPEAT
                        AddLookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                        AddLookup.SETRANGE("Add/Deduct", AddLookup."Add/Deduct"::Addition);
                        AddLookup.SETRANGE(AddLookup."Lookup Name", AddPayRevisionLine."Pay Element");
                        IF NOT AddLookup.FIND('-') THEN
                            ERROR(Text001, PayRevisionLine."Pay Element");
                    UNTIL AddLookup.NEXT = 0;
            UNTIL AddPayRevisionLine.NEXT = 0;
        END;

        //LookupName is not defined for the Pay Revision Line Pay Element//Deductions

        DedPayRevisionLine.RESET;
        DedPayRevisionLine.SETCURRENTKEY("Add/Deduct", "Pay Element");
        DedPayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        DedPayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        DedPayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        DedPayRevisionLine.SETRANGE("Add/Deduct", DedPayRevisionLine."Add/Deduct"::Deduction);
        IF DedPayRevisionLine.FIND('-') THEN BEGIN
            REPEAT
                DedLookup.RESET;
                IF DedLookup.FIND('-') THEN
                    REPEAT
                        DedLookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                        DedLookup.SETRANGE("Add/Deduct", DedLookup."Add/Deduct"::Deduction);
                        DedLookup.SETRANGE("Lookup Name", DedPayRevisionLine."Pay Element");
                        IF NOT DedLookup.FIND('-') THEN
                            ERROR(Text001, PayRevisionLine."Pay Element");
                    UNTIL DedLookup.NEXT = 0;
            UNTIL DedPayRevisionLine.NEXT = 0;
        END;

        //General Posting Group is not defined for the Pay Element//Additions

        Employee.RESET;
        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        IF Employee.FIND('-') THEN
            //AddPayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group");
            AddPayRevisionLine.RESET;
        AddPayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        AddPayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        AddPayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        AddPayRevisionLine.SETRANGE("Add/Deduct", AddPayRevisionLine."Add/Deduct"::Addition);
        IF AddPayRevisionLine.FIND('-') THEN BEGIN
            REPEAT
                IF AddPayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") THEN BEGIN
                    AddPayrollGeneralPosting.SETRANGE("Gen. Bus. Posting Group", AddPayrollBusinessPosting.Code);
                    IF AddPayrollGeneralPosting.FIND('-') THEN
                        PayBusiness := AddPayrollGeneralPosting."Gen. Bus. Posting Group";

                    Lookup2.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                    Lookup2.SETRANGE("Lookup Name", AddPayRevisionLine."Pay Element");
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
            UNTIL AddPayRevisionLine.NEXT = 0;
        END;

        //General Posting Group is not defined for the Pay Element//Deductions

        Employee.RESET;
        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        IF Employee.FIND('-') THEN
            DedPayRevisionLine.RESET;
        DedPayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        DedPayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        DedPayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        DedPayRevisionLine.SETRANGE("Add/Deduct", DedPayRevisionLine."Add/Deduct"::Deduction);
        IF DedPayRevisionLine.FIND('-') THEN BEGIN
            REPEAT
                IF (DedPayRevisionLine."Pay Element" <> 'ESI') AND (DedPayRevisionLine."Pay Element" <> 'PF') AND
                   (DedPayRevisionLine."Pay Element" <> 'PT') AND (DedPayRevisionLine."Pay Element" <> 'Loan') AND
                   (DedPayRevisionLine."Pay Element" <> 'TDS')
                THEN BEGIN
                    IF DedPayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") THEN
                        DedPayrollGeneralPosting.SETRANGE("Gen. Bus. Posting Group", DedPayrollBusinessPosting.Code);
                    IF DedPayrollGeneralPosting.FIND('-') THEN
                        PayBusiness := DedPayrollGeneralPosting."Gen. Bus. Posting Group";

                    Lookup2.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                    Lookup2.SETRANGE("Lookup Name", DedPayRevisionLine."Pay Element");
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
            UNTIL DedPayRevisionLine.NEXT = 0;
        END;


        //Debit Account

        Employee.RESET;
        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        IF Employee.FIND('-') THEN BEGIN
            REPEAT
                IF PayrollBusinessPosting.GET(Employee."Payroll Bus. Posting Group") THEN;
                BusinessPosting := PayrollBusinessPosting.Code;
                PayRevisionLine.RESET;
                PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
                PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
                PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
                PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Addition);
                IF PayRevisionLine.FIND('-') THEN BEGIN
                    REPEAT
                        Lookup.SETFILTER("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                        Lookup.SETRANGE("Lookup Name", PayRevisionLine."Pay Element");
                        IF Lookup.FIND('-') THEN BEGIN
                            IF PayrollProductPosting.GET(Lookup."Payroll Prod. Posting Group") THEN;
                            ProductPosting := PayrollProductPosting.Code;
                            PayrollGeneralPosting.SETRANGE("Gen. Bus. Posting Group", BusinessPosting);
                            PayrollGeneralPosting.SETRANGE("Gen. Prod. Posting Group", ProductPosting);
                            IF PayrollGeneralPosting.FIND('-') THEN BEGIN
                                "AccountNo." := PayrollGeneralPosting."Salary G/L Account";
                                AccountType := AccountType::"G/L Account";
                            END;
                            InitGenJnlLine(PayRevisionLine, "AccountNo.", AccountType, PayRevisionLine."Arrear Amount");
                        END;
                    UNTIL PayRevisionLine.NEXT = 0;
                END;
            UNTIL Employee.NEXT = 0;
        END;

        // Credit Account other than Statutory and Loans


        Employee.RESET;
        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        IF Employee.FIND('-') THEN BEGIN
            REPEAT
                IF CrPayBusinessPosting.GET(Employee."Payroll Bus. Posting Group") THEN;
                BusinessPosting := PayrollBusinessPosting.Code;
                PayRevisionLine.RESET;
                PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
                PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
                PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
                PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
                IF PayRevisionLine.FIND('-') THEN BEGIN
                    REPEAT
                        IF (PayRevisionLine."Pay Element" <> 'ESI') AND (PayRevisionLine."Pay Element" <> 'PF') AND
                           (PayRevisionLine."Pay Element" <> 'PT') AND (PayRevisionLine."Pay Element" <> 'Loan') AND
                           (PayRevisionLine."Pay Element" <> 'TDS')
                        THEN BEGIN
                            CrLookup.SETFILTER("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                            CrLookup.SETRANGE("Lookup Name", PayRevisionLine."Pay Element");
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
                            InitGenJnlLine(PayRevisionLine, "AccountNo.", AccountType, -PayRevisionLine."Arrear Amount");
                        END;
                    UNTIL PayRevisionLine.NEXT = 0;
                END;
            UNTIL Employee.NEXT = 0;
        END;

        // Employer ESI Contribution

        IF HRSetup.FIND('-') THEN
            "AccountNo." := HRSetup."Employer ESI";
        AccountType := AccountType::"G/L Account";

        PayRevisionLine.RESET;
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
        PayRevisionLine.SETRANGE("Pay Element", 'ESI');
        IF PayRevisionLine.FIND('-') THEN
            InitGenJnlLine(PayRevisionLine, "AccountNo.", AccountType, PayRevisionLine."Arrear Co. Contribution");

        // Employer PF Contribution

        IF HRSetup.FIND('-') THEN
            "AccountNo." := HRSetup."Employer PF";
        AccountType := AccountType::"G/L Account";

        PayRevisionLine.RESET;
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
        PayRevisionLine.SETRANGE("Pay Element", 'PF');
        IF PayRevisionLine.FIND('-') THEN
            InitGenJnlLine(PayRevisionLine, "AccountNo.", AccountType, PayRevisionLine."Arrear Co. Contribution");

        // Employer EPS Contribution

        IF HRSetup.FIND('-') THEN
            "AccountNo." := HRSetup."Employer EPS";
        AccountType := AccountType::"G/L Account";

        PayRevisionLine.RESET;
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
        PayRevisionLine.SETRANGE("Pay Element", 'PF');
        IF PayRevisionLine.FIND('-') THEN
            InitGenJnlLine(PayRevisionLine, "AccountNo.", AccountType, PayRevisionLine."Arrear Co. Contribution2");

        DeductionPosting(PayRevisionHeader);
    end;

    // [Scope('Internal')]
    procedure DeductionPosting(PayRevisionHeader: Record 60048)
    var
        PayRevisionLine: Record 60049;
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

        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."ESI Payable Acc.";
        AccountType := AccountType::"G/L Account";
        PayRevisionLine.RESET;
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
        PayRevisionLine.SETRANGE("Pay Element", 'ESI');
        IF PayRevisionLine.FIND('-') THEN BEGIN
            REPEAT
                ESIAmt := PayRevisionLine."Arrear Amount";
                InitGenJnlLine(
                  PayRevisionLine, "AccountNo.", AccountType,
                  -(PayRevisionLine."Arrear Amount" + PayRevisionLine."Arrear Co. Contribution"));
            UNTIL PayRevisionLine.NEXT = 0;
        END;

        // PF Account

        Employee.RESET;
        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."PF Payable Acc.";

        AccountType := AccountType::"G/L Account";
        PayRevisionLine.RESET;
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
        PayRevisionLine.SETRANGE("Pay Element", 'PF');
        IF PayRevisionLine.FIND('-') THEN BEGIN
            REPEAT
                PFAmt := PayRevisionLine."Arrear Amount";
                InitGenJnlLine(
                  PayRevisionLine, "AccountNo.", AccountType,
                  -(PayRevisionLine."Arrear Amount" + PayRevisionLine."Arrear Co. Contribution"));
            UNTIL PayRevisionLine.NEXT = 0;
        END;

        // EPS Account
        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        IF Employee.FIND('-') THEN
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
        IF EmpPostingGroup.FIND('-') THEN
            "AccountNo." := EmpPostingGroup."EPS Payable Acc.";
        AccountType := AccountType::"G/L Account";

        PayRevisionLine.RESET;
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
        PayRevisionLine.SETRANGE("Pay Element", 'PF');
        IF PayRevisionLine.FIND('-') THEN BEGIN
            InitGenJnlLine(
                PayRevisionLine, "AccountNo.", AccountType, -(PayRevisionLine."Arrear Co. Contribution2"));
        END;


        // Salary Payable Account
        Additions := 0;
        Deductions := 0;
        Employee.SETRANGE("No.", PayRevisionHeader."No.");
        IF Employee.FIND('-') THEN BEGIN
            Employee.TESTFIELD(Employee."Emp Posting Group");
            EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
            IF EmpPostingGroup.FIND('-') THEN
                "AccountNo." := EmpPostingGroup."Arrear Salary Payable Acc.";
            AccountType := AccountType::"G/L Account";
            PayRevisionLine.RESET;
            PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
            PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
            PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
            PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Addition);
            IF PayRevisionLine.FIND('-') THEN BEGIN
                REPEAT
                    Additions := Additions + PayRevisionLine."Arrear Amount";
                UNTIL PayRevisionLine.NEXT = 0;
                //TotalAddRoundAmt := Additions-Rounding(Additions);
            END;

            PayRevisionLine.RESET;
            PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
            PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
            PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
            PayRevisionLine.SETRANGE("Add/Deduct", PayRevisionLine."Add/Deduct"::Deduction);
            IF PayRevisionLine.FIND('-') THEN BEGIN
                REPEAT
                    Deductions := Deductions + PayRevisionLine."Arrear Amount";
                UNTIL PayRevisionLine.NEXT = 0;
                //TotalDedRoundAmt := Deductions-Rounding(Deductions);
            END;

            InitGenJnlLine(PayRevisionLine, "AccountNo.", AccountType, -(Additions - Deductions));

        END;
    end;

    // [Scope('Internal')]
    procedure InitGenJnlLine(var PayRevisionLine: Record 60049; "AccountNo.": Code[20]; AccountType: Option "G/L Account","Bank Account"; Amount: Decimal)
    var
        DimMgt: Codeunit DimensionManagement;
        DocumentNo: Code[20];
    begin
        IF Amount <> 0 THEN BEGIN
            GenJnlLine.INIT;
            GenJnlLine."Journal Template Name" := PayRevisionLine."Journal Template Name";
            GenJnlLine."Journal Batch Name" := PayRevisionLine."Journal Batch Name";
            GenJnlLine."Line No." := GenJnlLine."Line No." + 10000;
            GenJnlLine."Account Type" := AccountType;
            GenJnlLine."Account No." := "AccountNo.";
            GenJnlLine.VALIDATE("Account No.");
            GenJnlLine."Document No." := PayRevisionLine."Document No.";
            //GenJnlLine."Document Type" := GenJnlLine."Document Type" :: p;
            GenJnlLine."Posting Date" := PayRevisionLine."Posting Date";
            /*GenJnlLine.Description :=
               GenJnlLine.Description+' '+
               FORMAT(ProcessedSalary."Pay Slip Month")+' '+
               FORMAT(ProcessedSalary.Year);
            */
            //GenJnlLine.Description := 'ARREARS';
            GenJnlLine."Bal. Account Type" := AccountType;
            GenJnlLine.Amount := Amount;
            GenJnlLine.VALIDATE(Amount);
            GenJnlLine."Source Code" := 'GENJNL';
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::"Fixed Asset";
            GenJnlLine."Source No." := PayRevisionLine."No.";
            //GenJnlLine."Payslip Month" := ProcessedSalary."Pay Slip Month";
            //GenJnlLine."Payslip Year" := ProcessedSalary.Year;

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
            //JnlDim.DELETEALL;
            DefDim.INIT;
            DefDim.RESET;
            DefDim.SETRANGE("Table ID", 50003);
            DefDim.SETRANGE("No.", PayRevisionLine."No.");
            LineNo := 10000;
            IF DefDim.FIND('-') THEN
                REPEAT
                    /*  //RSPL-TC
                      JnlDim.INIT;
                      JnlDim."Table ID" := 81;
                      JnlDim."Journal Template Name" := GenJnlLine."Journal Template Name";
                      JnlDim."Journal Batch Name" := GenJnlLine."Journal Batch Name";
                      JnlDim."Journal Line No." := LineNo;
                      JnlDim."Dimension Code" := DefDim."Dimension Code";
                      JnlDim."Dimension Value Code" := DefDim."Dimension Value Code";
                      JnlDim.INSERT;
                      */
                    LineNo := LineNo + 10000;
                    //RSPL-TC +
                    TempDimSetEntry.INIT;
                    TempDimSetEntry.VALIDATE("Dimension Code", DefDim."Dimension Code");
                    TempDimSetEntry.VALIDATE("Dimension Value Code", DefDim."Dimension Value Code");
                    TempDimSetEntry.INSERT;
                //RSPL-TC -
                UNTIL DefDim.NEXT = 0;


            //RSPL-TC +
            GenJnlLine."Dimension Set ID" := cduDimMgt.GetDimensionSetID(TempDimSetEntry);
            //RSPL-TC -
            //VE-003 >>
            /*
            TempJnlLineDim.DELETEALL;
            DocDim.RESET;
            DocDim.SETRANGE("Table ID",80051);
            DocDim.SETRANGE("Document Type",PayRevisionLine."Document Type");
            DocDim.SETRANGE("Document No.",PayRevisionLine."No.");
            DocDim.SETRANGE("Line No.",PayRevisionLine."Line No.");
            IF DocDim.FIND('-') THEN BEGIN
              DimMgt.CopyDocDimToJnlLineDim(DocDim,TempJnlLineDim);
            END;
            */
            //VE-003 <<

            GenJnlPostLine.RunWithCheck(GenJnlLine);
        END;

    end;
}

