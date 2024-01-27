page 60035 "Loan Repayment"
{
    PageType = Card;
    SourceTable = 60041;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Loan Id"; rec."Loan Id")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Employee No."; rec."Employee No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Payment Date"; rec."Payment Date")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        AmountEditable := TRUE;
                        rec.Month := DATE2DMY(rec."Payment Date", 2);
                        rec.Year := DATE2DMY(rec."Payment Date", 3);
                        Loan.SETRANGE(Id, rec."Loan Id");
                        Loan.SETRANGE("Employee Code", rec."Employee No.");
                        IF Loan.FIND('-') THEN
                            rec.Amount := Loan."Loan Balance";
                    end;
                }
                field(Amount; rec.Amount)
                {

                    Editable = AmountEditable;
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        Loan.RESET;
                        Loan.SETRANGE(Id, rec."Loan Id");
                        Loan.SETRANGE("Employee Code", rec."Employee No.");
                        IF Loan.FIND('-') THEN
                            IF rec.Amount > Loan."Loan Balance" THEN
                                ERROR(Text002, Loan."Loan Balance");
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OK)
            {
                ApplicationArea = ALL;
                Caption = 'OK';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Loan.RESET;
                    Loan.SETRANGE(Id, rec."Loan Id");
                    IF Loan.FIND('-') THEN
                        IF Loan.Closed THEN
                            ERROR(Text000);

                    rec.TESTFIELD(rec."Payment Date");
                    rec.TESTFIELD(rec.Amount);
                    LoanDetails.RESET;
                    LoanDetails.SETRANGE("Employee No.", rec."Employee No.");
                    LoanDetails.SETRANGE("Loan Id", rec."Loan Id");
                    LoanDetails.SETRANGE(Month, rec.Month);
                    LoanDetails.SETRANGE(Year, rec.Year);
                    LoanDetails.SETFILTER(Balance, '<>%1', 0);
                    IF LoanDetails.FIND('-') THEN BEGIN
                        LoanDetails."Lump Sum Payment" := rec.Amount;
                        LoanDetails."Paid Month" := rec.Month;
                        LoanDetails."Paid Year" := rec.Year;
                        LoanDetails.Balance := LoanDetails.Balance - rec.Amount;
                        IF LoanDetails.Balance = 0 THEN
                            LoanDetails."Loan Closed" := TRUE;
                        LoanDetails.MODIFY;
                        Loan.SETRANGE("Employee Code", rec."Employee No.");
                        Loan.SETRANGE(Id, rec."Loan Id");
                        IF Loan.FIND('-') THEN
                            Loan."Loan Balance" := Loan."Loan Balance" - rec.Amount;
                        IF Loan."Loan Balance" = 0 THEN BEGIN
                            Loan."Effective Amount" := 0;
                            Loan.Closed := TRUE;
                        END;
                        Loan.MODIFY;
                        rec.Paid := TRUE;
                        rec.MODIFY;

                        IF Loan."Interest Method" = Loan."Interest Method"::"Interest Free" THEN
                            LoanRescheduleForIF(LoanDetails, Loan, rec.Amount)
                        ELSE
                            IF Loan."Interest Method" = Loan."Interest Method"::"Flat Rate" THEN
                                LoanRescheduleForFR(LoanDetails, Loan, rec.Amount)
                            ELSE
                                IF Loan."Interest Method" = Loan."Interest Method"::"Dimnishing Rate" THEN
                                    LoanRescheduleForDim(LoanDetails, Loan, rec.Amount);
                        MESSAGE(Text001);
                    END ELSE BEGIN
                        LoanDetails.RESET;
                        LoanDetails.SETRANGE("Employee No.", rec."Employee No.");
                        LoanDetails.SETRANGE("Loan Id", rec."Loan Id");
                        LoanDetails.SETRANGE(Month, rec.Month);
                        LoanDetails.SETRANGE(Year, rec.Year);
                        IF LoanDetails.FIND('-') THEN BEGIN
                            LoanDetails."Lump Sum Payment" := rec.Amount;
                            LoanDetails."Paid Month" := rec.Month;
                            LoanDetails."Paid Year" := rec.Year;
                            Loan.RESET;
                            Loan.SETRANGE("Employee Code", rec."Employee No.");
                            Loan.SETRANGE(Id, rec."Loan Id");
                            IF Loan.FIND('-') THEN BEGIN
                                LoanDetails.Balance := Loan."Loan Balance" - rec.Amount;
                                IF LoanDetails.Balance = 0 THEN
                                    LoanDetails."Loan Closed" := TRUE;
                                LoanDetails.MODIFY;
                                Loan."Loan Balance" := Loan."Loan Balance" - rec.Amount;
                                IF Loan."Loan Balance" = 0 THEN BEGIN
                                    Loan."Effective Amount" := 0;
                                    Loan.Closed := TRUE;
                                END;
                                Loan.MODIFY;
                                rec.Paid := TRUE;
                                rec.MODIFY;
                                IF Loan."Interest Method" = Loan."Interest Method"::"Interest Free" THEN
                                    LoanRescheduleForIF(LoanDetails, Loan, rec.Amount)
                                ELSE
                                    IF Loan."Interest Method" = Loan."Interest Method"::"Flat Rate" THEN
                                        LoanRescheduleForFR(LoanDetails, Loan, rec.Amount)
                                    ELSE
                                        IF Loan."Interest Method" = Loan."Interest Method"::"Dimnishing Rate" THEN
                                            LoanRescheduleForDim(LoanDetails, Loan, rec.Amount);

                                MESSAGE(Text001);
                            END;
                        END;
                    END;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        AmountEditable := TRUE;
    end;

    trigger OnOpenPage()
    begin
        //VE-026 >>
        /*RecRef.GETTABLE(Rec);
        FILTERGROUP(2);
        SETVIEW(SecurityF.GetSecurityFilters(RecRef));
        FILTERGROUP(0);  */
        //VE-026 <<
        AmountEditable := FALSE;

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF (rec."Payment Date" <> 0D) AND (NOT rec.Paid) THEN
            rec.DELETE;
    end;

    var
        Loan: Record 60039;
        LoanDetails: Record 60040;
        LoanPayment: Record 60041;
        Text000: Label 'Loan already closed.';
        Text001: Label 'Loan repayment done.';
        Text002: Label 'Amount should not be greater than %1.';
        RecRef: RecordRef;
        // [InDataSet]
        AmountEditable: Boolean;

    // [Scope('Internal')]
    procedure LoanRescheduleForIF(LoanDetails: Record 60040; Loan: Record 60039; Amount: Decimal)
    var
        TempKnockoffAmount: Decimal;
    begin
        TempKnockoffAmount := Amount;
        LoanDetails.RESET;
        LoanDetails.SETRANGE("Loan Id", Loan.Id);
        LoanDetails.SETRANGE("Employee No.", Loan."Employee Code");
        LoanDetails.SETRANGE("Knocked Off ag lumsum", FALSE);
        IF LoanDetails.FIND('+') THEN
            REPEAT
                IF LoanDetails."EMI Amount" <= TempKnockoffAmount THEN BEGIN
                    LoanDetails."knocked Off Amount" := LoanDetails."EMI Amount";
                    LoanDetails."Knocked Off ag lumsum" := TRUE;
                    LoanDetails."EMI Amount" := 0;
                    LoanDetails.MODIFY;
                    TempKnockoffAmount := TempKnockoffAmount - LoanDetails."knocked Off Amount";
                END ELSE
                    IF LoanDetails."EMI Amount" > TempKnockoffAmount THEN BEGIN
                        LoanDetails."knocked Off Amount" := TempKnockoffAmount;
                        LoanDetails."EMI Amount" := (LoanDetails."EMI Amount" - TempKnockoffAmount);
                        LoanDetails.MODIFY;
                        TempKnockoffAmount := TempKnockoffAmount - LoanDetails."knocked Off Amount";
                    END;
                LoanDetails.NEXT(-1);
            UNTIL TempKnockoffAmount = 0;
    end;

    // [Scope('Internal')]
    procedure LoanRescheduleForFR(LoanDetails: Record 60040; Loan: Record 60039; Amount: Decimal)
    begin
        LoanDetails.RESET;
        LoanDetails.SETRANGE("Employee No.", rec."Employee No.");
        LoanDetails.SETRANGE("Loan Id", rec."Loan Id");
        LoanDetails.SETRANGE(Month, rec.Month);
        LoanDetails.SETRANGE(Year, rec.Year);
        LoanDetails.SETFILTER("Lump Sum Payment", '<>%1', 0);
        IF LoanDetails.FIND('-') THEN BEGIN
            LoanDetails.NEXT;
            REPEAT
                LoanDetails.DELETE;
            UNTIL LoanDetails.NEXT = 0;
        END;
    end;

    // [Scope('Internal')]
    procedure LoanRescheduleForDim(LoanDetails: Record 60040; Loan: Record 60039; Amount: Decimal)
    var
        LoanDetails2: Record 60040;
        PaymentDate: Date;
        TempDate: Date;
        EMIAmt: Decimal;
        Balance: Decimal;
    begin
        PaymentDate := DMY2DATE(1, rec.Month, rec.Year);
        PaymentDate := CALCDATE('1M', PaymentDate);

        LoanDetails.RESET;
        LoanDetails.SETRANGE("Employee No.", rec."Employee No.");
        LoanDetails.SETRANGE("Loan Id", rec."Loan Id");
        LoanDetails.SETRANGE(Month, rec.Month);
        LoanDetails.SETRANGE(Year, rec.Year);
        LoanDetails.SETFILTER("Lump Sum Payment", '<>%1', 0);
        IF LoanDetails.FIND('-') THEN BEGIN
            EMIAmt := LoanDetails."EMI Amount";
            Balance := LoanDetails.Balance;
            LoanDetails2.SETRANGE("Loan Id", LoanDetails."Loan Id");
            LoanDetails2.SETRANGE("Employee No.", LoanDetails."Employee No.");
            LoanDetails2.SETFILTER("Line No", '>%1', LoanDetails."Line No");
            IF LoanDetails2.FIND('-') THEN
                REPEAT
                    TempDate := PaymentDate;
                    LoanDetails2.Month := DATE2DMY(LoanDetails2."Pay Date", 2);
                    LoanDetails2.Year := DATE2DMY(LoanDetails2."Pay Date", 3);
                    LoanDetails2.Interest := (Balance * Loan."Interest Rate") / (1200);
                    LoanDetails2.Principal := LoanDetails2."EMI Amount" - LoanDetails2.Interest;
                    IF (Balance + LoanDetails2.Interest) > 0 THEN BEGIN
                        LoanDetails2."EMI Amount" := EMIAmt;
                    END ELSE BEGIN
                        LoanDetails2."EMI Amount" := Balance + LoanDetails2.Interest;
                        //MESSAGE('Emi amt %1',LoanDetails2."EMI Amount");
                        Balance := Balance - LoanDetails2.Principal;
                    END;
                    /*END ELSE BEGIN
                      LoanDetails2."Knocked Off ag lumsum" := TRUE;
                      LoanDetails2."knocked Off Amount" := LoanDetails2."EMI Amount";
                      LoanDetails2."EMI Amount" := 0;
                      LoanDetails2.Principal := 0;*/
                    //    END;   }
                    LoanDetails2.MODIFY;
                    PaymentDate := CALCDATE('1M', PaymentDate);
                UNTIL LoanDetails2.NEXT = 0;
        END;

    end;
}

