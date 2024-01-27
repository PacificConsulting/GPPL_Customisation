codeunit 60006 "Loan Calculations"
{
    // Date: 21-Mar-06


    trigger OnRun()
    begin
    end;

    // [Scope('Internal')]
    procedure LoanInstallments(Loan: Record 60039)
    var
        Text000: Label 'Loan installment details are inserted.';
    begin
        IF Loan."Interest Method" = Loan."Interest Method"::"Interest Free" THEN
            InterestFree(Loan)
        ELSE
            IF Loan."Interest Method" = Loan."Interest Method"::"Flat Rate" THEN
                FlatRate(Loan)
            ELSE
                IF Loan."Interest Method" = Loan."Interest Method"::"Dimnishing Rate" THEN
                    Dimnishing(Loan);
    end;

    // [Scope('Internal')]
    procedure InterestFree(Loan: Record 60039)
    var
        LoanDetails: Record 60040;
        PaymentDate: Date;
        I: Integer;
    begin
        PaymentDate := Loan."Loan Start Date";
        IF Loan."Interest Method" = Loan."Interest Method"::"Interest Free" THEN BEGIN
            FOR I := 1 TO Loan."No of Installments" DO BEGIN
                LoanDetails.INIT;
                LoanDetails."Line No" := LoanDetails."Line No" + 1;
                LoanDetails."Employee No." := Loan."Employee Code";
                LoanDetails."Loan Id" := Loan.Id;
                LoanDetails."Loan Code" := Loan."Loan Type";
                LoanDetails."Pay Date" := PaymentDate;
                LoanDetails."EMI Amount" := (Loan."Loan Amount" / Loan."No of Installments");
                LoanDetails.Principal := (Loan."Loan Amount" / Loan."No of Installments");
                LoanDetails.Month := DATE2DMY(LoanDetails."Pay Date", 2);
                LoanDetails.Year := DATE2DMY(LoanDetails."Pay Date", 3);
                LoanDetails."Loan Amount" := Loan."Loan Amount";
                LoanDetails.INSERT;
                PaymentDate := CALCDATE('1M', PaymentDate);
            END;

            Loan."Effective Amount" := LoanDetails."EMI Amount";
            Loan.MODIFY
        END;
    end;

    // [Scope('Internal')]
    procedure FlatRate(Loan: Record 60039)
    var
        LoanDetails: Record 60040;
        PaymentDate: Date;
        Principal: Decimal;
        InterestAmt: Decimal;
        MonthlyInterest: Decimal;
        IntRateperMonth: Decimal;
        EMIAmt: Decimal;
        I: Integer;
    begin
        IntRateperMonth := Loan."Interest Rate" / 12;
        MonthlyInterest := ROUND((Loan."Loan Amount" * IntRateperMonth) / 100, 0.01);
        InterestAmt := ROUND((MonthlyInterest * Loan."No of Installments"), 0.01);
        PaymentDate := Loan."Loan Start Date";
        EMIAmt := ROUND(((Loan."Loan Amount" + InterestAmt) / Loan."No of Installments"), 0.01);

        FOR I := 1 TO Loan."No of Installments" DO BEGIN
            LoanDetails.INIT;
            LoanDetails."Line No" := LoanDetails."Line No" + 1;
            LoanDetails."Employee No." := Loan."Employee Code";
            LoanDetails."Loan Id" := Loan.Id;
            LoanDetails."Loan Code" := Loan."Loan Type";
            LoanDetails."Pay Date" := PaymentDate;
            LoanDetails."EMI Amount" := EMIAmt;
            LoanDetails.Interest := MonthlyInterest;
            LoanDetails.Principal := EMIAmt - MonthlyInterest;
            LoanDetails.Month := DATE2DMY(LoanDetails."Pay Date", 2);
            LoanDetails.Year := DATE2DMY(LoanDetails."Pay Date", 3);
            LoanDetails."Loan Amount" := Loan."Loan Amount";
            LoanDetails.INSERT;
            PaymentDate := CALCDATE('1M', PaymentDate);
        END;

        Loan."Total Loan Payable" := Loan."Loan Amount" + InterestAmt;
        Loan."Total Interest Amount" := InterestAmt;
        Loan."Effective Amount" := LoanDetails."EMI Amount";
        Loan.MODIFY;
    end;

    //  [Scope('Internal')]
    procedure Dimnishing(Loan: Record 60039)
    var
        LoanDetails: Record 60040;
        EMIAmt: Decimal;
        InterestPerMonth: Decimal;
        EMIValue2: Decimal;
        EMIValue3: Decimal;
        Balance: Decimal;
        J: Integer;
        I: Integer;
        PaymentDate: Date;
        TempDate: Date;
    begin
        Loan.TESTFIELD(Loan."No of Installments");
        PaymentDate := Loan."Loan Start Date";
        InterestPerMonth := (1200 + Loan."Interest Rate") / 1200;
        EMIValue2 := Loan."Loan Amount" * POWER(InterestPerMonth, Loan."No of Installments");
        EMIValue3 := 0;
        FOR J := 0 TO (Loan."No of Installments" - 1) DO
            EMIValue3 := EMIValue3 + POWER(InterestPerMonth, J);
        EMIAmt := ROUND((EMIValue2 / EMIValue3), 0.01, '=');
        Balance := Loan."Loan Amount";

        FOR I := 1 TO Loan."No of Installments" DO BEGIN
            TempDate := PaymentDate;
            LoanDetails.INIT;
            LoanDetails."Line No" := LoanDetails."Line No" + 1;
            LoanDetails."Employee No." := Loan."Employee Code";
            LoanDetails."Loan Id" := Loan.Id;
            LoanDetails."Loan Code" := Loan."Loan Type";
            LoanDetails."Pay Date" := PaymentDate;
            LoanDetails."EMI Amount" := EMIAmt;
            LoanDetails.Interest := (Balance * Loan."Interest Rate") / (1200);
            LoanDetails.Principal := EMIAmt - LoanDetails.Interest;
            LoanDetails.Month := DATE2DMY(LoanDetails."Pay Date", 2);
            LoanDetails.Year := DATE2DMY(LoanDetails."Pay Date", 3);
            LoanDetails."Loan Amount" := Loan."Loan Amount";
            LoanDetails."Balance (Base)" := Balance;
            Balance := Balance - LoanDetails.Principal;
            LoanDetails.INSERT;
            PaymentDate := CALCDATE('1M', PaymentDate);
        END;

        Loan."Effective Amount" := LoanDetails."EMI Amount";
        Loan.MODIFY;
    end;

    // [Scope('Internal')]
    procedure LoanInstallmentsAll()
    var
        Text000: Label 'Loan Id..........#1###########\Employee code....#2###############\';
        Loan: Record 60039;
        Window: Dialog;
    begin
        Window.OPEN(Text000);
        Loan.RESET;
        IF Loan.FIND('-') THEN BEGIN
            REPEAT
                Window.UPDATE(1, Loan.Id);
                Window.UPDATE(2, Loan."Employee Code");
                LoanInstallments(Loan);
            UNTIL Loan.NEXT = 0;
        END;
        Window.CLOSE;
    end;

    //  [Scope('Internal')]
    procedure ExistingLoanInstallments(Loan: Record 60039)
    var
        LoanDetails: Record 60040;
        PaymentDate: Date;
        Text000: Label 'Loan installment details are inserted.';
        Flag: Boolean;
        I: Integer;
        j: Integer;
        TempLoanAmt: Decimal;
    begin
        PaymentDate := Loan."Loan Start Date";
        IF Loan."Interest Method" = Loan."Interest Method"::"Interest Free" THEN BEGIN
            FOR I := 1 TO Loan."No of Installments" DO BEGIN
                LoanDetails.INIT;
                LoanDetails."Line No" := LoanDetails."Line No" + 1;
                LoanDetails."Employee No." := Loan."Employee Code";
                LoanDetails."Loan Id" := Loan.Id;
                LoanDetails."Loan Code" := Loan."Loan Type";
                LoanDetails."Pay Date" := PaymentDate;
                LoanDetails."EMI Amount" := Loan."Installment Amount";
                LoanDetails.Month := DATE2DMY(LoanDetails."Pay Date", 2);
                LoanDetails.Year := DATE2DMY(LoanDetails."Pay Date", 3);
                LoanDetails."Loan Amount" := Loan."Loan Amount";
                LoanDetails.INSERT;
                PaymentDate := CALCDATE('1M', PaymentDate);
            END;
            Loan."Effective Amount" := LoanDetails."EMI Amount";
            Loan.MODIFY;
        END;
    end;

    // [Scope('Internal')]
    procedure ExistingLoanInstallmentsAll()
    var
        Text000: Label 'Loan Id..........#1###########\Employee code....#2###############\';
        Loan: Record 60039;
        Window: Dialog;
    begin
        Window.OPEN(Text000);
        Loan.RESET;
        IF Loan.FIND('-') THEN BEGIN
            REPEAT
                Window.UPDATE(1, Loan.Id);
                Window.UPDATE(2, Loan."Employee Code");
                ExistingLoanInstallments(Loan);
            UNTIL Loan.NEXT = 0;
        END;
        Window.CLOSE;
    end;
}

