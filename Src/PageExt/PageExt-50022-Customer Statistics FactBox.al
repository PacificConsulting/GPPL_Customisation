pageextension 50022 "Customer Stat FactBoxExtCstm" extends "Customer Statistics FactBox"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        CreditLimit: Decimal;
        CreditChecking2: Codeunit 50013;
        GlSetup: Record "General Ledger Setup";
        CI: Record "Company Information";
        CurrentDate: Date;

        Text000: Label 'Overdue Amounts (LCY) as of %1';
        TotalAmountLCY: Decimal;
        //CurrentDate: Date;
        "Balance Credit Limit": Decimal;
        ////CreditLimit: Decimal;
        CreditLimitLCY: Decimal;
        CreditLimitFCY: Decimal;
        CurrencyCode: Code[10];
        BalanceAsonTodayLCY: Decimal;
        BalanceAsOnTodayFCY: Decimal;
        PDCOnHandLCY: Decimal;
        PDCOnHandFCY: Decimal;
        DtCustLdgr: Record 379;
        BalanceCreditLimitLCY: Decimal;
        BalanceCreditLimitFCY: Decimal;
        CurrExchRate: Record 330;
        FacilityValueLCY: Decimal;
        FacilityValueFCY: Decimal;
        CurrCode: Code[10];
        OSCreditFCY: Decimal;
        ShipNotInv: Decimal;
        FactRun: Boolean;
        OutStdandingFCY: Decimal;
        ShipNotInvCredFCY: Decimal;
        "O/sCreditOrders(LCY)": Decimal;
        "ShpNotInvoicedCredit(LCY)": Decimal;
        "OutstandingOrders(LCY)": Decimal;
        "ShippedNotInvoiced(LCY)": Decimal;
        OverDueInvLCY: Decimal;
        OverDueInvFCY: Decimal;
        OutOverDueInvLCY: Decimal;
        OutOverDueInvFCY: Decimal;
        "Gain/LossLCY": Decimal;
        "Gain/LossFCY": Decimal;

        RecCurrExchRate: Record 330;


    begin
        //Azhar
        /*
                IF Rec."Customer Posting Group" = 'FO' THEN BEGIN //21Feb2019
                    IF Rec."Credit Limit Approval Status" = Rec."Credit Limit Approval Status"::Approved THEN BEGIN
                        Clear(CreditLimit);
                        IF Rec."Insurance Limit Exp Date" >= WORKDATE THEN
                            CreditLimit := CreditLimit + (Rec."Insurance Limit" * Rec."Insurance Percentage" / 100);
                        IF Rec."Management Limit Exp Date" >= WORKDATE THEN
                            CreditLimit := CreditLimit + (Rec."Management Limit" * Rec."Management Percentage" / 100);
                        IF Rec."Temporary Limit Exp Date" >= WORKDATE THEN
                            CreditLimit := CreditLimit + (Rec."Temporary Limit" * Rec."Temporary Percentage" / 100);
                    end;
                end ELSE BEGIN
                    CreditLimit := Rec."Credit Limit (LCY)";
                END;

                IF (Rec."Currency Code" = '') THEN //19Oct2018
                    Rec.BalanceCreditLimit := CreditChecking2.CreditLimitCustValueCheck(Rec."No.", WORKDATE, GlSetup."LCY Code", 0)
                ELSE
                    rec."Balance Credit Limit in USD" := CreditChecking2.CreditLimitCustValueCheck(Rec."No.", WORKDATE, Rec."Currency Code", 0);
        */
        //Azhar
        //RSPLSUM 11May2020>>
        //CreditChecking; //1 Not Required XML Files
        CI.GET;
        IF CI."Customer Credit Validation" THEN BEGIN

            IF CurrentDate <> WORKDATE THEN BEGIN
                CurrentDate := WORKDATE;
            END;


            BalanceCreditLimitFCY := 0;
            CreditLimitFCY := 0;
            CreditLimitLCY := 0;
            CurrCode := '';
            FacilityValueFCY := 0;
            FacilityValueLCY := 0;
            ShipNotInv := 0;
            OSCreditFCY := 0;
            OutStdandingFCY := 0;
            ShipNotInvCredFCY := 0;
            OverDueInvLCY := 0;
            OverDueInvFCY := 0;
            OutOverDueInvLCY := 0;
            OutOverDueInvFCY := 0;
            BalanceAsonTodayLCY := 0;
            BalanceAsOnTodayFCY := 0;
            "Gain/LossLCY" := 0;
            "Gain/LossFCY" := 0;
            CreditLimit := 0;
            //"Facility Value(LCY)" :=0;//5 Facility Details Not Required


            InvOverDueValue;  //2
            OutInvOverDueValue; //3
                                //FacilityLCYValueFn;   //4 Facility Details Not Required
            rec.CALCFIELDS(
              Balance, "Balance (LCY)", "Balance Due", "Balance Due (LCY)",
              "Outstanding Orders (LCY)", "Shipped Not Invoiced (LCY)", "Balance (FCY)");

            TotalAmountLCY := rec."Balance (LCY)" + rec."Outstanding Orders (LCY)" + rec."Shipped Not Invoiced (LCY)" + rec."Outstanding Invoices (LCY)";

            BalanceAsOnTodayFn;
            PDCOnHandFn;
            /*
            CLEAR(RepUpdateBalLCY);
            RepUpdateBalLCY.NumParm("No.",DATABASE::Customer,TRUE);
            RepUpdateBalLCY.USEREQUESTFORM(FALSE);
            IF FactRun THEN BEGIN
              RepUpdateBalLCY.RUNMODAL;
              FactRun:=FALSE;
            END;
            *///8
            rec.CALCFIELDS(
              "Sales (LCY)", "Profit (LCY)", "Inv. Discounts (LCY)", "Inv. Amounts (LCY)", "Pmt. Discounts (LCY)",
              "Pmt. Disc. Tolerance (LCY)", "Pmt. Tolerance (LCY)",
              "Fin. Charge Memo Amounts (LCY)", "Cr. Memo Amounts (LCY)", "Payments (LCY)",
              "Reminder Amounts (LCY)", "Refunds (LCY)", "Other Amounts (LCY)",
              "O/s Credit Orders (LCY)", "Shipped Not Invoiced (LCY)", "Shp Not Invoiced Credit (LCY)");

            GlSetup.GET();

            //IF ("Currency Code" = '') OR ("Currency Code" = GlSetup."LCY Code")  THEN
            IF (rec."Currency Code" = '') THEN //19Oct2018
                rec.BalanceCreditLimit := CreditChecking2.CreditLimitCustValueCheck(rec."No.", WORKDATE, GlSetup."LCY Code", 0)
            ELSE
                rec."Balance Credit Limit in USD" := CreditChecking2.CreditLimitCustValueCheck(rec."No.", WORKDATE, rec."Currency Code", 0);

            CurrencyCode := rec."Currency Code";

            IF rec."Customer Posting Group" = 'FO' THEN BEGIN //21Feb2019
                IF rec."Credit Limit Approval Status" = rec."Credit Limit Approval Status"::Approved THEN BEGIN
                    CreditLimit := 0;
                    IF rec."Insurance Limit Exp Date" >= WORKDATE THEN
                        CreditLimit := CreditLimit + (rec."Insurance Limit" * rec."Insurance Percentage" / 100);
                    IF rec."Management Limit Exp Date" >= WORKDATE THEN
                        CreditLimit := CreditLimit + (rec."Management Limit" * rec."Management Percentage" / 100);
                    IF rec."Temporary Limit Exp Date" >= WORKDATE THEN
                        CreditLimit := CreditLimit + (rec."Temporary Limit" * rec."Temporary Percentage" / 100);
                END;
            END ELSE BEGIN
                CreditLimit := rec."Credit Limit (LCY)";
            END;

            //RSPLSUM 25Jun2020--BalanceAsonTodayLCY := CreditChecking2.CustOutStanding("No.",GlSetup."LCY Code", COMPANYNAME);
            BalanceAsonTodayLCY := CreditChecking2.CustOutStanding(rec."No.", '', COMPANYNAME);//RSPLSUM 25Jun2020
            BalanceAsOnTodayFCY := 0;

            //RSPLSUM 25Jun2020--"O/sCreditOrders(LCY)" := CreditChecking2.CustSalesLineValue("No.",GlSetup."LCY Code", COMPANYNAME);
            "O/sCreditOrders(LCY)" := CreditChecking2.CustSalesLineValue(rec."No.", '', COMPANYNAME);//RSPLSUM 25Jun2020
                                                                                                     //RSPLSUM 25Jun2020--"ShpNotInvoicedCredit(LCY)" := CreditChecking2.ShippedNotInvoiced("No.",GlSetup."LCY Code", COMPANYNAME);
            "ShpNotInvoicedCredit(LCY)" := CreditChecking2.ShippedNotInvoiced(rec."No.", '', COMPANYNAME);//RSPLSUM 25Jun2020
            "OutstandingOrders(LCY)" := rec."Outstanding Orders (LCY)";
            "ShippedNotInvoiced(LCY)" := rec."Shipped Not Invoiced (LCY)";
            IF rec."Customer Posting Group" = 'FO' THEN //21Feb2019
                                                        //RSPLSUM 09Jun2020--BalanceCreditLimitLCY := CreditChecking2.CreditLimitCustValueCheck("No.",WORKDATE,GlSetup."LCY Code",0)
                BalanceCreditLimitLCY := CreditChecking2.CreditLimitCustValueCheck(rec."No.", WORKDATE, GlSetup."LCY Code", 0)//RSPLSUM 25Jun2020
                                                                                                                              //RSPLSUM 25Jun2020--BalanceCreditLimitLCY := CreditChecking2.CreditLimitCustValueCheck("No.",WORKDATE,'USD',0)//RSPLSUM 09Jun2020
            ELSE
                BalanceCreditLimitLCY := CreditLimit - BalanceAsonTodayLCY - "O/sCreditOrders(LCY)" - "ShpNotInvoicedCredit(LCY)";
            //IF ("Currency Code" = '') OR ("Currency Code" = GlSetup."LCY Code")  THEN BEGIN
            //RSPLSUM 01Jun2020--IF ("Currency Code" = '') THEN BEGIN //19Oct2018
            IF (rec."Currency Code" = '') OR (rec."Currency Code" = GlSetup."LCY Code") THEN BEGIN//RSPLSUM 01Jun2020
                BalanceCreditLimitFCY := BalanceCreditLimitLCY;//RSPLSUM 28May2020
                                                               //RSPLSUM 28May2020--BalanceCreditLimitFCY:=  CreditChecking2.CreditLimitCustValueCheck("No.",WORKDATE,'USD',0);
                CreditLimitFCY := CreditLimit;
                CreditLimitLCY := CreditLimit;
                FacilityValueFCY := FacilityValueLCY;
                //CurrCode := GlSetup."LCY Code";
                //RSPLSUM 01Jun2020--CurrCode := 'USD';//19Oct2018
                CurrCode := GlSetup."LCY Code";//RSPLSUM 01Jun2020
                OSCreditFCY := "O/sCreditOrders(LCY)";
                ShipNotInv := rec."Shipped Not Invoiced (LCY)";
                OutStdandingFCY := rec."Outstanding Orders (LCY)";
                ShipNotInvCredFCY := "ShpNotInvoicedCredit(LCY)";
                OverDueInvFCY := OverDueInvLCY;
                OutOverDueInvFCY := OutOverDueInvLCY;
                PDCOnHandFCY := PDCOnHandLCY;//RSPLSUM 28May2020
                BalanceAsOnTodayFCY := CreditChecking2.CustOutStanding(rec."No.", GlSetup."LCY Code", COMPANYNAME);//RSPLSUM 01Jun2020
                                                                                                                   //RSPLSUM 01Jun2020--BalanceAsOnTodayFCY := CreditChecking2.CustOutStanding("No.",'USD', COMPANYNAME);

            END ELSE BEGIN
                //RSPLSUM 28May2020--BalanceCreditLimitFCY:=  CreditChecking2.CreditLimitCustValueCheck("No.",WORKDATE,"Currency Code",0);
                //RSPLSUM 28May2FacilityValueLCY020--CreditLimitFCY := CreditLimit;
                //RSPLSUM 28May2020--FacilityValueLCY := FacilityValueLCY;
                /*//RSPLSUM 28May2020>>
                IF GlSetup."LCY Code" <> 'INR' THEN//RSPLSUM 15May2020
                  CreditLimitLCY  := CreditLimitFCY * CurrExchRate.ExchangeAmtFCYToFCY(WORKDATE,"Currency Code",GlSetup."LCY Code",1)
                ELSE//RSPLSUM 15May2020
                  CreditLimitLCY := CreditLimitFCY;//RSPLSUM 15May2020
                *///RSPLSUM 28May2020<<

                /*
                CurrExchRate.RESET;
                CurrExchRate.SETRANGE("Currency Code",GlSetup."LCY Code");
                CurrExchRate.SETFILTER("Starting Date",'<=%1',WORKDATE);
                IF CurrExchRate.FINDLAST THEN;
                 */
                /*//RSPLSUM 28May2020>>
               //IF GlSetup."LCY Code" <> 'INR' THEN BEGIN//RSPLSUM 15May2020
                 BalanceAsOnTodayFCY := BalanceAsonTodayLCY * CurrExchRate.ExchangeAmtFCYToFCY(WORKDATE,GlSetup."LCY Code","Currency Code",1);
                 ShipNotInvCredFCY := "ShpNotInvoicedCredit(LCY)"
                                       * CurrExchRate.ExchangeAmtFCYToFCY(WORKDATE,GlSetup."LCY Code","Currency Code",1);
                 OutStdandingFCY := "Outstanding Orders (LCY)"  * CurrExchRate.ExchangeAmtFCYToFCY(WORKDATE,GlSetup."LCY Code","Currency Code",1);
                 ShipNotInv := "Shipped Not Invoiced (LCY)" * CurrExchRate.ExchangeAmtFCYToFCY(WORKDATE,GlSetup."LCY Code","Currency Code",1);
                 OSCreditFCY := "O/sCreditOrders(LCY)" * CurrExchRate.ExchangeAmtFCYToFCY(WORKDATE,GlSetup."LCY Code","Currency Code",1);
                 FacilityValueFCY := FacilityValueLCY * CurrExchRate.ExchangeAmtFCYToFCY(WORKDATE,GlSetup."LCY Code","Currency Code",1);
                   //FacilityValueFCY := FacilityValueLCY *CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE,
                   //                   "Currency Code",CreditLimitFCY,1/CurrExchRate."Relational Exch. Rate Amount");
                 OverDueInvFCY := OverDueInvLCY * CurrExchRate.ExchangeAmtFCYToFCY(WORKDATE,GlSetup."LCY Code","Currency Code",1);
               {END ELSE BEGIN//RSPLSUM 15May2020>>
                 BalanceAsOnTodayFCY := BalanceAsonTodayLCY;
                 ShipNotInvCredFCY := "ShpNotInvoicedCredit(LCY)";
                 OutStdandingFCY := "Outstanding Orders (LCY)";
                 ShipNotInv := "Shipped Not Invoiced (LCY)";
                 OSCreditFCY := "O/sCreditOrders(LCY)";
                 FacilityValueFCY := FacilityValueLCY;
                 OverDueInvFCY := OverDueInvLCY;
               END;//RSPLSUM 15May2020<<}
               *///RSPLSUM 28May2020<<
                 //RSPLSUM 28May2020>>
                 //CreditLimitLCY := CreditLimit;
                FacilityValueLCY := FacilityValueLCY;
                CreditLimitFCY := CreditLimit;//RSPLSUM 09Jun2020
                BalanceAsOnTodayFCY := BalanceAsonTodayLCY;//RSPLSUM 26Jun2020
                OSCreditFCY := "O/sCreditOrders(LCY)";//RSPLSUM 25Jun2020
                ShipNotInvCredFCY := "ShpNotInvoicedCredit(LCY)";//RSPLSUM 25Jun2020
                BalanceCreditLimitFCY := BalanceCreditLimitLCY;//RSPLSUM 09Jun2020
                RecCurrExchRate.RESET;
                RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                RecCurrExchRate.SETRANGE("Currency Code", rec."Currency Code");
                RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                IF RecCurrExchRate.FINDLAST THEN BEGIN
                    //CreditLimitFCY := CreditLimitLCY * (RecCurrExchRate."Exchange Rate Amount"/RecCurrExchRate."Relational Exch. Rate Amount");
                    CreditLimitLCY := CreditLimitFCY / (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");//RSPLSUM 09Jun2020
                                                                                                                                                 //RSPLSUM 25Jun2020--BalanceCreditLimitFCY := BalanceCreditLimitLCY * (RecCurrExchRate."Exchange Rate Amount"/RecCurrExchRate."Relational Exch. Rate Amount");
                    BalanceCreditLimitLCY := BalanceCreditLimitFCY / (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");//RSPLSUM 25Jun2020
                    OutOverDueInvFCY := OutOverDueInvLCY * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                    PDCOnHandFCY := PDCOnHandLCY * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                    //RSPLSUM 26Jun2020--BalanceAsOnTodayFCY  := BalanceAsonTodayLCY * (RecCurrExchRate."Exchange Rate Amount"/RecCurrExchRate."Relational Exch. Rate Amount");
                    BalanceAsonTodayLCY := BalanceAsOnTodayFCY / (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");//RSPLSUM 26Jun2020
                                                                                                                                                           //RSPLSUM 25Jun2020--ShipNotInvCredFCY  := "ShpNotInvoicedCredit(LCY)" * (RecCurrExchRate."Exchange Rate Amount"/RecCurrExchRate."Relational Exch. Rate Amount");
                    "ShpNotInvoicedCredit(LCY)" := ShipNotInvCredFCY / (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");//RSPLSUM 25Jun2020
                    OutStdandingFCY := rec."Outstanding Orders (LCY)" * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                    ShipNotInv := rec."Shipped Not Invoiced (LCY)" * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                    //RSPLSUM 25Jun2020--OSCreditFCY  := "O/sCreditOrders(LCY)" * (RecCurrExchRate."Exchange Rate Amount"/RecCurrExchRate."Relational Exch. Rate Amount");
                    "O/sCreditOrders(LCY)" := OSCreditFCY / (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                    FacilityValueFCY := FacilityValueLCY * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                    OverDueInvFCY := OverDueInvLCY * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                END;
                //RSPLSUM 28May2020<<

                CurrCode := rec."Currency Code";
                /*//RSPLSUM 28May2020>>
               IF GlSetup."LCY Code" <> 'INR' THEN//RSPLSUM 15May2020
                 OutOverDueInvFCY := OutOverDueInvLCY *  CurrExchRate.ExchangeAmtFCYToFCY(WORKDATE,GlSetup."LCY Code","Currency Code",1)
               ELSE//RSPLSUM 15May2020
                 OutOverDueInvFCY := OutOverDueInvLCY;//RSPLSUM 15May2020
                 *///RSPLSUM 28May2020<<
            END;

            IF rec."Customer Posting Group" = 'FO' THEN //21Feb2019
                IF CreditLimitLCY <> 0 THEN BEGIN
                    "Gain/LossLCY" := CreditLimitLCY - BalanceAsonTodayLCY - "O/sCreditOrders(LCY)" - "ShpNotInvoicedCredit(LCY)" - BalanceCreditLimitLCY;
                    "Gain/LossFCY" := CreditLimitFCY - BalanceAsOnTodayFCY - OSCreditFCY - ShipNotInvCredFCY - BalanceCreditLimitFCY;
                END;
        END ELSE BEGIN
            CreditLimitLCY := 0;

            BalanceAsonTodayLCY := 0;

            CreditLimitLCY := rec."Credit Limit (LCY)";
            rec.CALCFIELDS("Balance (LCY)");
            BalanceAsonTodayLCY := rec."Balance (LCY)";
        END;
        //RSPLSUM 11May2020<<

    end;

    PROCEDURE InvOverDueValue();
    VAR
        CustlederEntry: Record 21;
        Cusotmer: Record 18;
        OverDueInvLCY: Decimal;
    BEGIN
        //Check ledger for over due days
        OverDueInvLCY := 0;
        CustlederEntry.RESET;
        CustlederEntry.SETCURRENTKEY("Customer No.", "Document Type", Open, "Due Date", "Currency Code");
        CustlederEntry.SETFILTER("Customer No.", Rec."No.");
        CustlederEntry.SETFILTER("Document Type", '%1', CustlederEntry."Document Type"::Invoice);
        CustlederEntry.SETFILTER(Open, '%1', TRUE);
        CustlederEntry.SETFILTER("Due Date", '<=%11', WORKDATE);
        CustlederEntry.SETFILTER("Credit Checking Not Required", '%1', FALSE);
        CustlederEntry.SETFILTER("Posting Date", '<=%11', WORKDATE);
        IF CustlederEntry.FINDFIRST THEN
            REPEAT
                CustlederEntry.CALCFIELDS(CustlederEntry."Remaining Amt. (LCY)");
                OverDueInvLCY := OverDueInvLCY + CustlederEntry."Remaining Amt. (LCY)";
            UNTIL CustlederEntry.NEXT = 0;
    END;

    PROCEDURE OutInvOverDueValue();
    VAR
        CustlederEntry: Record 21;
        Cusotmer: Record 18;
        OutOverDueInvLCY: Decimal;
    BEGIN
        //Check ledger for over due days
        OutOverDueInvLCY := 0;
        CustlederEntry.RESET;
        CustlederEntry.SETCURRENTKEY("Customer No.", "Document Type", Open, "Due Date", "Currency Code");
        CustlederEntry.SETFILTER("Customer No.", Rec."No.");
        CustlederEntry.SETFILTER("Document Type", '%1', CustlederEntry."Document Type"::Invoice);
        CustlederEntry.SETFILTER(Open, '%1', TRUE);
        CustlederEntry.SETFILTER("Due Date", '<=%11', WORKDATE);
        CustlederEntry.SETFILTER("Credit Checking Not Required", '%1', FALSE);
        CustlederEntry.SETFILTER("Posting Date", '<=%11', WORKDATE);
        IF CustlederEntry.FINDFIRST THEN
            REPEAT
                CustlederEntry.CALCFIELDS(CustlederEntry."Remaining Amt. (LCY)");
                OutOverDueInvLCY := OutOverDueInvLCY + CustlederEntry."Remaining Amt. (LCY)";
            UNTIL CustlederEntry.NEXT = 0;
    END;

    procedure BalanceAsOnTodayFn()
    begin
        /*
        BalanceAsonTodayLCY := 0;
        BalanceAsOnTodayFCY := 0;
        DtCustLdgr.RESET;
        DtCustLdgr.SETCURRENTKEY("Customer No.","Posting Date","Entry Type","Initial Entry Global Dim. 1","Initial Entry Global Dim. 2",
                      "Currency Code");
        DtCustLdgr.SETFILTER("Customer No.","No.");
        DtCustLdgr.SETFILTER("Posting Date",'<=%1',WORKDATE);
        DtCustLdgr.SETFILTER("Initial Entry Global Dim. 1","Global Dimension 1 Filter");
        DtCustLdgr.SETFILTER("Initial Entry Global Dim. 2","Global Dimension 2 Filter");
        DtCustLdgr.CALCSUMS(DtCustLdgr.Amount,DtCustLdgr."Amount (LCY)",DtCustLdgr."Amount (FCY)");
        //BalanceAsonTodayLCY := DtCustLdgr."Amount (LCY)";
        BalanceAsOnTodayFCY := DtCustLdgr."Amount (FCY)";
        BalanceAsonTodayLCY :=
        
         */

    end;


    procedure PDCOnHandFn()
    var
        PDCOnHandLCY: Decimal;
        PDCOnHandFCY: Decimal;
        DtCustLdgr: Record "Detailed Cust. Ledg. Entry";
    begin
        PDCOnHandLCY := 0;
        PDCOnHandFCY := 0;

        DtCustLdgr.RESET;
        DtCustLdgr.SETCURRENTKEY("Customer No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2",
                      "Currency Code");
        DtCustLdgr.SETFILTER("Customer No.", rec."No.");
        DtCustLdgr.SETFILTER("Posting Date", '>%1', WORKDATE);
        DtCustLdgr.SETFILTER("Initial Entry Global Dim. 1", rec."Global Dimension 1 Filter");
        DtCustLdgr.SETFILTER("Initial Entry Global Dim. 2", rec."Global Dimension 2 Filter");
        DtCustLdgr.CALCSUMS(DtCustLdgr.Amount, DtCustLdgr."Amount (LCY)");//RSPLSUM 01Jun2020--,DtCustLdgr."Amount (FCY)");
        PDCOnHandLCY := -1 * DtCustLdgr."Amount (LCY)";
        //RSPLSUM 28May2020--PDCOnHandFCY :=-1* DtCustLdgr.Amount;

        /*
        IF ("Currency Code" = 'AED') OR ("Currency Code" = '') THEN BEGIN
          PDCOnHandLCY := DtCustLdgr."Amount (LCY)";
          PDCOnHandFCY := DtCustLdgr."Amount (LCY)";
        END ELSE BEGIN
          PDCOnHandLCY := DtCustLdgr."Amount (LCY)";
          PDCOnHandFCY := DtCustLdgr."Amount (FCY)";
        END;
        */

    end;


    var
        myInt: Integer;
}