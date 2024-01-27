page 60098 "Loan Dashboard"
{
    Editable = false;
    PageType = Card;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group("LOAN DASHBOARD")
            {
                Caption = 'LOAN DASHBOARD';
                grid("-Active Loan Details-")
                {
                    Caption = '-Active Loan Details-';
                    group(group1)
                    {
                        label("Active Loans")
                        {
                            ApplicationArea = all;
                            Caption = 'Active Loans';
                            ShowCaption = false;
                        }
                        label("Loan Amount Outstanding")
                        {
                            ApplicationArea = all;
                            Caption = 'Loan Amount Outstanding';
                            ShowCaption = false;
                        }
                        label("Loans Availed(CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Loans Availed(CM)';
                            ShowCaption = false;
                        }
                        label("Loans Closed(CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Loans Closed(CM)';
                            ShowCaption = false;
                        }
                    }
                    group(group2)
                    {
                        field(Activecount; Activecount)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                LoanRec.RESET;
                                LoanRec.SETFILTER(LoanRec."Loan Balance", '>%1', 0);
                                IF LoanRec.FIND('-') THEN
                                    PAGE.RUNMODAL(60033, LoanRec);
                            end;
                        }
                        field(OutstndLoanAmt; OutstndLoanAmt)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                LoanRec.RESET;
                                LoanRec.SETFILTER(LoanRec."Loan Balance", '>%1', 0);
                                IF LoanRec.FIND('-') THEN
                                    PAGE.RUNMODAL(60033, LoanRec);
                            end;
                        }
                        field(NmbrLoanAvaild; NmbrLoanAvaild)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                StartDate := CALCDATE('-CM', TODAY);
                                EndDate := CALCDATE('+CM', TODAY);
                                CurrentMonth := DATE2DMY(TODAY, 2);


                                LoanRec.RESET;
                                LoanRec.SETRANGE(LoanRec."Loan Start Date", StartDate, EndDate);
                                IF LoanRec.FINDSET THEN
                                    PAGE.RUNMODAL(60033, LoanRec);
                            end;
                        }
                        field(NoLoanClosed; NoLoanClosed)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                //for loan closed count
                                LoanRec.RESET;
                                LoanRec.SETRANGE(LoanRec."Loan End Date", StartDate, EndDate);
                                IF LoanRec.FINDSET THEN
                                    PAGE.RUNMODAL(60033, LoanRec);
                            end;
                        }
                    }
                }
                grid("-Loan Details-")
                {
                    Caption = '-Loan Details-';
                    group(group3)
                    {
                        label("EMIs Recovered")
                        {
                            ApplicationArea = all;
                            Caption = 'EMIs Recovered';
                            ShowCaption = false;
                        }
                        label("EMI Amount Recovered")
                        {
                            ApplicationArea = all;
                            Caption = 'EMI Amount Recovered';
                            ShowCaption = false;
                        }
                        label("No Deduction Requests (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'No Deduction Requests (CM)';
                            ShowCaption = false;
                        }
                        label("No Deduction Amount(CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'No Deduction Amount(CM)';
                            ShowCaption = false;
                        }
                        label("Installment Outstanding-Number")
                        {
                            ApplicationArea = all;
                            Caption = 'Installment Outstanding-Number';
                            ShowCaption = false;
                        }
                        label("Installment Outstanding-Value")
                        {
                            ApplicationArea = all;
                            Caption = 'Installment Outstanding-Value';
                            ShowCaption = false;
                        }
                    }
                    group(group4)
                    {
                        field(NmbEMIrecvrd; NmbEMIrecvrd)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                LoanRec.RESET;
                                LoanRec.SETFILTER(LoanRec."Loan Balance", '>%1', 0);
                                LoanRec.SETRANGE(LoanRec."No Deduction Request", FALSE);
                                LoanRec.SETRANGE(LoanRec.Month, CurrentMonth);
                                IF LoanRec.FIND('-') THEN
                                    PAGE.RUNMODAL(60033, LoanRec);
                            end;
                        }
                        field(EMIrecvrdAmt; EMIrecvrdAmt)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                LoanRec.RESET;
                                LoanRec.SETFILTER(LoanRec."Loan Balance", '>%1', 0);
                                LoanRec.SETRANGE(LoanRec."No Deduction Request", FALSE);
                                LoanRec.SETRANGE(LoanRec.Month, CurrentMonth);
                                IF LoanRec.FIND('-') THEN
                                    PAGE.RUNMODAL(60033, LoanRec);
                            end;
                        }
                        field(NoDeductnReq; NoDeductnReq)
                        {
                            ApplicationArea = ALL;
                            trigger OnDrillDown()
                            begin

                                LoanRec.RESET;
                                LoanRec.SETRANGE(LoanRec."No Deduction Request", TRUE);
                                IF LoanRec.FINDFIRST THEN
                                    PAGE.RUNMODAL(60033, LoanRec);
                            end;
                        }
                        field(NoDeductnReqAmt; NoDeductnReqAmt)
                        {
                            ApplicationArea = ALL;
                            trigger OnDrillDown()
                            begin

                                LoanRec.RESET;
                                LoanRec.SETRANGE(LoanRec."No Deduction Request", TRUE);
                                IF LoanRec.FINDFIRST THEN
                                    PAGE.RUNMODAL(60033, LoanRec);
                            end;
                        }
                        field(InstallmentNmb; InstallmentNmb)
                        {
                            ApplicationArea = ALL;
                            trigger OnDrillDown()
                            begin

                                LoanDetails.RESET;
                                LoanDetails.SETFILTER(LoanDetails."EMI Deducted", '%1', 0);
                                LoanDetails.SETFILTER(LoanDetails."EMI Amount", '<>%1', 0);
                                IF LoanDetails.FINDFIRST THEN;

                                PAGE.RUNMODAL(60034, LoanDetails);
                            end;
                        }
                        field(InstalmntValue; InstalmntValue)
                        {
                            ApplicationArea = ALL;
                            trigger OnDrillDown()
                            begin


                                LoanRec.RESET;
                                LoanRec.SETFILTER(LoanRec."Loan Balance", '>%1', 0);
                                IF LoanRec.FIND('-') THEN;

                                PAGE.RUNMODAL(60033, LoanRec);
                            end;
                        }
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        //active loans count and amount.
        OutstndLoanAmt := 0;
        InstalmntValue := 0;
        Activecount := 0;
        NmbrLoanAvaild := 0;
        StartDate := 0D;
        EndDate := 0D;
        NoLoanClosed := 0;
        NmbEMIrecvrd := 0;
        EMIrecvrdAmt := 0;
        NoDeductnReq := 0;
        NoDeductnReqAmt := 0;
        CurrentMonth := 0;
        InstalmntAmt := 0;
        InstallmentNmb := 0;
        EMIdedct := 0;
        EMIamt := 0;
        CLEAR(LoanListRec);


        LoanRec.RESET;
        LoanRec.SETFILTER(LoanRec."Loan Balance", '>%1', 0);
        //LoanListRec.SETTABLEVIEW(LoanRec);
        IF LoanRec.FIND('-') THEN BEGIN
            Activecount := LoanRec.COUNT;
            REPEAT
                OutstndLoanAmt += LoanRec."Loan Balance";
            UNTIL LoanRec.NEXT = 0;
            InstalmntValue := OutstndLoanAmt;
        END;

        //for loan availed count
        StartDate := CALCDATE('-CM', TODAY);
        EndDate := CALCDATE('+CM', TODAY);
        CurrentMonth := DATE2DMY(TODAY, 2);
        LoanRec.RESET;
        LoanRec.SETRANGE(LoanRec."Loan Start Date", StartDate, EndDate);
        IF LoanRec.FINDSET THEN
            NmbrLoanAvaild := LoanRec.COUNT;

        //for loan closed count
        LoanRec.RESET;
        LoanRec.SETRANGE(LoanRec."Loan End Date", StartDate, EndDate);
        IF LoanRec.FINDSET THEN
            NoLoanClosed := LoanRec.COUNT;


        //for EMI request and no deduction false
        LoanRec.RESET;
        LoanRec.SETFILTER(LoanRec."Loan Balance", '>%1', 0);
        LoanRec.SETRANGE(LoanRec."No Deduction Request", FALSE);
        LoanRec.SETRANGE(LoanRec.Month, CurrentMonth);
        IF LoanRec.FIND('-') THEN BEGIN
            NmbEMIrecvrd := LoanRec.COUNT;
            REPEAT
                EMIrecvrdAmt += LoanRec."Installment Amount";
            UNTIL LoanRec.NEXT = 0;
        END;

        //for no deduction true count and amount
        LoanRec.RESET;
        LoanRec.SETRANGE(LoanRec."No Deduction Request", TRUE);
        IF LoanRec.FINDFIRST THEN BEGIN
            NoDeductnReq := LoanRec.COUNT;
            REPEAT
                NoDeductnReqAmt += LoanRec."Installment Amount";
            UNTIL LoanRec.NEXT = 0;
        END;

        //for installment outstanding value and amount
        InstalmntAmt := 0;
        CLEAR(LoanListRec);
        LoanRec.RESET;
        LoanRec.SETFILTER(LoanRec."Effective Amount", '>%1', 0);
        IF LoanRec.FINDFIRST THEN
            REPEAT
                InstalmntAmt += (LoanRec."Loan Balance" / LoanRec."Effective Amount");
            UNTIL LoanRec.NEXT = 0;

        LoanRec.RESET;
        LoanRec.SETRANGE(LoanRec.Closed, FALSE);
        IF LoanRec.FINDSET THEN
            REPEAT
                EMIdedct := 0;
                EMIamt := 0;
                InstallmentNo := 0;
                LoanDetails.RESET;
                LoanDetails.SETRANGE("Loan Id", LoanRec.Id);
                IF LoanDetails.FINDFIRST THEN
                    LoanDetails.SETFILTER("EMI Deducted", '<>%1', 0);
                IF LoanDetails.FINDFIRST THEN
                    EMIdedct := LoanDetails.COUNT;
                LoanDetails.RESET;
                LoanDetails.SETRANGE("Loan Id", LoanRec.Id);
                IF LoanDetails.FINDFIRST THEN
                    LoanDetails.SETFILTER("EMI Amount", '<>%1', 0);
                IF LoanDetails.FINDFIRST THEN
                    EMIamt := LoanDetails.COUNT;
                InstallmentNo := EMIamt - EMIdedct;
                InstallmentNmb += InstallmentNo;
            UNTIL LoanRec.NEXT = 0;
    end;

    var
        Text19040493: Label 'Employee Dashboard - Designationwise';
        Text19067950: Label 'DESIGNATION';
        Text19010561: Label 'Resignations';
        Text19076330: Label 'New Joinees';
        Text19001219: Label 'Terminated Employees';
        Text19011194: Label 'Overall Employee Statistics';
        Text19003536: Label 'No. Of Employees';
        Text19067053: Label 'Probation';
        Text19057152: Label 'No. of Inactive Employees';
        Text19065850: Label 'No. of Resigned Employees';
        Text19003771: Label 'No. of Terminated Employees';
        LoanListRec: Page 60033;
        LoanRec: Record 60039;
        Activecount: Integer;
        OutstndLoanAmt: Decimal;
        NmbrLoanAvaild: Integer;
        StartDate: Date;
        EndDate: Date;
        NoLoanClosed: Integer;
        NmbEMIrecvrd: Integer;
        EMIrecvrdAmt: Decimal;
        NoDeductnReq: Integer;
        NoDeductnReqAmt: Decimal;
        OutstndLoanRec: Page 60033;
        CurrentMonth: Integer;
        InstalmntValue: Decimal;
        InstalmntAmt: Decimal;
        LoanDetails: Record 60040;
        EMIdedct: Integer;
        EMIamt: Integer;
        InstallmentNmb: Integer;
        InstallmentNo: Integer;
}

