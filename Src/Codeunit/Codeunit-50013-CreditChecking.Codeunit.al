codeunit 50013 "Credit Checking"
{
    // 
    // 
    // Date          Version         Remarks
    // ----------------------------------------------------------------------
    // 21Jun2018     RB-N           Codeunit#90902 Migration from GPUAE--NAV2009

    Permissions = TableData 21 = rimd,
                  TableData 36 = rimd,
                  TableData 37 = rimd;

    trigger OnRun()
    begin
    end;

    var
        Company: Record 2000000006;
        Overduedayformula: DateFormula;
        recCompany: Record 79;
        Text0001: Label 'Currency Code Not Specified for the Customer %1';
        RecCurrExchRate: Record 330;
        RecCustNew: Record 18;

    //[Scope('Internal')]
    procedure CreditLimitCustValueCheck(cCustNo: Code[20]; cOrderDate: Date; cCurrency: Code[10]; dOrderValue: Decimal) creditlimitAmount: Decimal
    var
        Customer: Record 18;
        "Sales Line": Record 37;
        CustLedgerEntry: Record 21;
        GlSetup: Record 98;
        GlSetupothercompany: Record 98;
        CustomerGroup: Record 18;
        rCustomer: Record 18;
        bNoChildLimit: Boolean;
        bGroupChild: Boolean;
        bGroupParent: Boolean;
        DecAmountSameCurrency: Decimal;
        dCustomerLimit: Decimal;
        SameCustledgertotal: Decimal;
        OtherCustledgertotal: Decimal;
        dChildBalanceLimit: Decimal;
        DecAmountotherCurrency: Decimal;
        cParentCustNo: Code[20];
    begin
        EVALUATE(Overduedayformula, '0D');
        GlSetup.GET;
        //IF GlSetup."Exchange Master Company"='' THEN
        // ERROR('Exchange Rate Master Company information in G/L Setup not specified');
        //GlSetupothercompany.CHANGECOMPANY(GlSetup."Exchange Master Company");
        GlSetupothercompany.GET();
        IF FORMAT(GlSetupothercompany."OCL Over Due days") = '' THEN
            ERROR('OCL over due days not specified in G/L Setup')
        ELSE
            Overduedayformula := GlSetupothercompany."OCL Over Due days";

        bGroupParent := FALSE;
        bGroupChild := FALSE;
        IF Customer.GET(cCustNo) THEN;
        //Customer.MODIFY;

        //Check - This company is a parent company or not
        CustomerGroup.RESET;
        CustomerGroup.SETFILTER("Parent Company", Customer."No.");
        bGroupParent := CustomerGroup.COUNT() > 0;

        //Check This is a child Company
        IF Customer."Parent Company" <> '' THEN BEGIN
            bGroupChild := TRUE;
            cParentCustNo := Customer."Parent Company";          //Parent Company code

        END;
        //Child Company Balance Credit limi Check
        bNoChildLimit := FALSE;
        dChildBalanceLimit := 0;

        IF ((bGroupChild) AND (Customer."Credit Limit Approval Status" = Customer."Credit Limit Approval Status"::Approved)) THEN BEGIN
            Company.RESET;
            recCompany.GET;
            //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
            //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
            Company.SETRANGE(Company.Name, recCompany.Name);
            IF Company.FINDFIRST THEN
                REPEAT
                    dChildBalanceLimit := dChildBalanceLimit + CreditLimitCustValueCheckbycom(cCustNo, cCurrency, Company.Name);
                UNTIL Company.NEXT = 0;

            //Check for Limit currently available
            dCustomerLimit := 0;
            IF Customer."Insurance Limit Exp Date" >= cOrderDate THEN
                dCustomerLimit := dCustomerLimit + Customer."Insurance Limit" * Customer."Insurance Percentage" / 100;
            IF Customer."Management Limit Exp Date" >= cOrderDate THEN
                dCustomerLimit := dCustomerLimit + Customer."Management Limit" * Customer."Management Percentage" / 100;
            IF Customer."Temporary Limit Exp Date" >= cOrderDate THEN
                dCustomerLimit := dCustomerLimit + Customer."Temporary Limit" * Customer."Temporary Percentage" / 100;
            IF RlnExchageRate(cCurrency, Customer."Currency Code", WORKDATE) <> 0 THEN //RSPL
                dCustomerLimit := dCustomerLimit * 1 / RlnExchageRate(cCurrency, Customer."Currency Code", WORKDATE) //RSPL
            ELSE
                dCustomerLimit := 0;
            IF dCustomerLimit > (dChildBalanceLimit) + (dOrderValue) THEN BEGIN
                creditlimitAmount := dCustomerLimit - dChildBalanceLimit;
                EXIT(creditlimitAmount);
            END
            ELSE
                bNoChildLimit := TRUE
        END;

        // Child and OCL OR   Credit Limit Less Than the amount
        IF ((bGroupChild AND (Customer."Credit Limit Approval")) OR (bNoChildLimit)) THEN BEGIN
            //Check in parent
            dChildBalanceLimit := 0;
            IF rCustomer.GET(Customer."Parent Company") THEN BEGIN
                Company.RESET;
                //IF Company.Name='GP Global Energy Private Limited' THEN  //05Jul2018
                //Company.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
                Company.SETRANGE(Company.Name, recCompany.Name);
                IF Company.FINDFIRST THEN
                    REPEAT
                        dChildBalanceLimit := dChildBalanceLimit + CreditLimitCustValueCheckbycom(rCustomer."No.", cCurrency, Company.Name);
                    UNTIL Company.NEXT = 0;
            END;
            //Check In child
            rCustomer.RESET;
            rCustomer.SETFILTER("Parent Company", Customer."Parent Company");
            IF rCustomer.FINDFIRST THEN
                REPEAT
                    Company.RESET;
                    recCompany.GET;
                    //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
                    //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
                    Company.SETRANGE(Company.Name, recCompany.Name);
                    IF Company.FINDFIRST THEN
                        REPEAT
                            dChildBalanceLimit := dChildBalanceLimit + CreditLimitCustValueCheckbycom(rCustomer."No.", cCurrency, Company.Name);
                        UNTIL Company.NEXT = 0;
                UNTIL rCustomer.NEXT = 0;

            dCustomerLimit := 0;
            IF rCustomer.GET(Customer."Parent Company") THEN
                IF rCustomer."Credit Limit Approval Status" = rCustomer."Credit Limit Approval Status"::Approved THEN BEGIN
                    IF rCustomer."Insurance Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Insurance Limit" * rCustomer."Insurance Percentage" / 100;
                    IF rCustomer."Management Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Management Limit" * rCustomer."Management Percentage" / 100;
                    IF rCustomer."Temporary Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Temporary Limit" * rCustomer."Temporary Percentage" / 100;
                    IF RlnExchageRate(cCurrency, rCustomer."Currency Code", WORKDATE) <> 0 THEN
                        dCustomerLimit := dCustomerLimit * 1 / RlnExchageRate(cCurrency, rCustomer."Currency Code", WORKDATE)
                    ELSE
                        dCustomerLimit := 0;
                END;

            IF (dCustomerLimit) > (dChildBalanceLimit) THEN BEGIN
                creditlimitAmount := dCustomerLimit - dChildBalanceLimit;
                EXIT(creditlimitAmount);
            END;
        END;

        //Group Parent
        IF bGroupParent THEN BEGIN
            //Check in parent
            dChildBalanceLimit := 0;
            IF rCustomer.GET(Customer."No.") THEN BEGIN
                Company.RESET;
                recCompany.GET;
                //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
                //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
                Company.SETRANGE(Company.Name, recCompany.Name);
                IF Company.FINDFIRST THEN
                    REPEAT
                        dChildBalanceLimit := dChildBalanceLimit + CreditLimitCustValueCheckbycom(rCustomer."No.", cCurrency, Company.Name);
                    UNTIL Company.NEXT = 0;
            END;

            //Check In child
            rCustomer.RESET;
            rCustomer.SETFILTER("Parent Company", Customer."No.");
            IF rCustomer.FINDFIRST THEN
                REPEAT
                    Company.RESET;
                    recCompany.GET;
                    //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
                    //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
                    Company.SETRANGE(Company.Name, recCompany.Name);
                    IF Company.FINDFIRST THEN
                        REPEAT
                            dChildBalanceLimit := dChildBalanceLimit + CreditLimitCustValueCheckbycom(rCustomer."No.", cCurrency, Company.Name);
                        UNTIL Company.NEXT = 0;
                UNTIL rCustomer.NEXT = 0;

            dCustomerLimit := 0;
            IF rCustomer.GET(Customer."No.") THEN
                IF rCustomer."Credit Limit Approval Status" = rCustomer."Credit Limit Approval Status"::Approved THEN BEGIN
                    IF rCustomer."Insurance Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Insurance Limit" * rCustomer."Insurance Percentage" / 100;
                    IF rCustomer."Management Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Management Limit" * rCustomer."Management Percentage" / 100;
                    IF rCustomer."Temporary Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Temporary Limit" * rCustomer."Temporary Percentage" / 100;
                    IF RlnExchageRate(cCurrency, rCustomer."Currency Code", WORKDATE) <> 0 THEN
                        dCustomerLimit := dCustomerLimit * 1 / RlnExchageRate(cCurrency, rCustomer."Currency Code", WORKDATE)
                    ELSE
                        dCustomerLimit := 0;
                END;

            IF (dCustomerLimit) > (dChildBalanceLimit) THEN BEGIN
                creditlimitAmount := dCustomerLimit - dChildBalanceLimit;
                EXIT(creditlimitAmount);
            END ELSE BEGIN
                creditlimitAmount := dCustomerLimit - dChildBalanceLimit;
                EXIT(creditlimitAmount);
            END;
        END;


        //No Parent No Child
        IF ((NOT bGroupChild)) AND ((NOT bGroupParent)) THEN BEGIN
            dChildBalanceLimit := 0;
            IF rCustomer.GET(Customer."No.") THEN BEGIN
                Company.RESET;
                recCompany.GET;
                //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
                //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
                Company.SETRANGE(Company.Name, recCompany.Name);
                IF Company.FINDFIRST THEN
                    REPEAT
                        //RSPLSUM 25Jun2020--dChildBalanceLimit := dChildBalanceLimit + CreditLimitCustValueCheckbycom(rCustomer."No.",cCurrency,Company.Name) ;
                        dChildBalanceLimit := dChildBalanceLimit + CreditLimitCustValueCheckbycom(rCustomer."No.", '', Company.Name);//RSPLSUM 25Jun2020
                    UNTIL Company.NEXT = 0;
            END;
            dCustomerLimit := 0;
            IF rCustomer.GET(Customer."No.") THEN
                IF rCustomer."Credit Limit Approval Status" = rCustomer."Credit Limit Approval Status"::Approved THEN BEGIN
                    IF rCustomer."Insurance Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Insurance Limit" * rCustomer."Insurance Percentage" / 100;
                    IF rCustomer."Management Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Management Limit" * rCustomer."Management Percentage" / 100;
                    IF rCustomer."Temporary Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Temporary Limit" * rCustomer."Temporary Percentage" / 100;
                    IF RlnExchageRate(cCurrency, rCustomer."Currency Code", WORKDATE) <> 0 THEN
                        dCustomerLimit := dCustomerLimit * 1 / RlnExchageRate(cCurrency, rCustomer."Currency Code", WORKDATE)
                    ELSE
                        dCustomerLimit := 0;
                END;
            /*
            //RSPLSUM 25Jun2020>>
            IF dCustomerLimit <> 0 THEN BEGIN
              RecCurrExchRate.RESET;
              RecCurrExchRate.SETCURRENTKEY("Currency Code","Starting Date");
              RecCurrExchRate.SETRANGE("Currency Code",rCustomer."Currency Code");
              RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date",'<=%1',WORKDATE);
              IF RecCurrExchRate.FINDLAST THEN BEGIN
                //dCustomerLimit := dCustomerLimit/(RecCurrExchRate."Exchange Rate Amount"/RecCurrExchRate."Relational Exch. Rate Amount");
                dChildBalanceLimit := dChildBalanceLimit/(RecCurrExchRate."Exchange Rate Amount"/RecCurrExchRate."Relational Exch. Rate Amount");
              END;
            END;
            //RSPLSUM 25Jun2020<<
            */
            IF (dCustomerLimit) > (dChildBalanceLimit) THEN BEGIN
                creditlimitAmount := dCustomerLimit - dChildBalanceLimit;
                EXIT(creditlimitAmount);
            END ELSE BEGIN
                creditlimitAmount := dCustomerLimit - dChildBalanceLimit;
                EXIT(creditlimitAmount);
            END;
        END;
        EXIT(creditlimitAmount);

    end;

    // [Scope('Internal')]
    procedure RlnExchageRate(Currency1: Code[10]; Currency2: Code[10]; datDate: Date) RlnExcahangerate: Decimal
    var
        CurrExchRate: Record 330;
        GlSetup: Record 98;
    begin
        //Relational Exchange rate check
        GlSetup.GET;
        IF Currency2 = '' THEN
            Currency2 := GlSetup."LCY Code";
        IF Currency1 = '' THEN
            Currency1 := GlSetup."LCY Code";

        IF UPPERCASE(Currency2) = UPPERCASE(Currency1) THEN
            EXIT(1);

        RlnExcahangerate := 0;
        //IF GlSetup."Exchange Master Company" = '' THEN
        // ERROR('Exchange rate Master Company information in G/L Setup not specified');
        IF FORMAT(GlSetup."OCL Over Due days") = '' THEN
            ERROR('OCL over due days not specified in G/L Setup');

        CurrExchRate.RESET;
        //CurrExchRate.CHANGECOMPANY(GlSetup."Exchange Master Company");
        IF CurrExchRate.FINDLAST THEN BEGIN//RSPLSUM 11May2020
            IF (Currency1 = 'INR') OR (Currency2 = 'INR') THEN//RSPLSUM 11May2020
                EXIT(1)//RSPLSUM 11May2020
            ELSE//RSPLSUM 11May2020
                EXIT(CurrExchRate.ExchangeAmtFCYToFCY(datDate, Currency1, Currency2, 1))//RSPL
        END//RSPLSUM 11May2020
        ELSE BEGIN
            ERROR('Exchange Rate Not found for' + Currency1 + ' and ' + Currency2);
        END;
    end;

    //  [Scope('Internal')]
    procedure CreditLimitCustValueCheckbycom(CustNo: Code[20]; Currency: Code[10]; Companyname: Text[50]) CompanyTotalValue: Decimal
    var
        Customer: Record 18;
        DecAmountSameCurrency: Decimal;
        SalesLine: Record 37;
        CusomteLimit: Decimal;
        DecAmountotherCurrency: Decimal;
        CustLedgerEntry: Record 21;
        SameCustledgertotal: Decimal;
        OtherCustledgertotal: Decimal;
        RecCust: Record 18;
    begin
        CompanyTotalValue := 0;
        DecAmountSameCurrency := 0;
        DecAmountotherCurrency := 0;
        CusomteLimit := 0;
        SameCustledgertotal := 0;
        OtherCustledgertotal := 0;

        //RSPLSUM 13Jul2020>>
        RecCust.RESET;
        IF RecCust.GET(CustNo) THEN
            IF RecCust."Currency Code" <> 'USD' THEN BEGIN//RSPLSUM 13Jul2020<<
                                                          //Same Currency Released Non OCL total From Sales Line
                SalesLine.RESET;
                //SalesLine.CHANGECOMPANY(Companyname);
                SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
                SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
                SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
                SalesLine.SETFILTER(Status, '%1', SalesLine.Status::Released);
                IF Currency = '' THEN
                    SalesLine.SETFILTER("Currency Code", '%1', '')
                ELSE
                    SalesLine.SETFILTER("Currency Code", '%1', Currency);
                SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
                SalesLine.SETRANGE("Short Close", FALSE);//31Oct2019
                IF SalesLine.FINDSET THEN BEGIN
                    SalesLine.CALCSUMS(SalesLine."Shipped Not Invoiced", SalesLine."Outstanding Amount");
                    DecAmountSameCurrency := DecAmountSameCurrency + SalesLine."Shipped Not Invoiced" + SalesLine."Outstanding Amount";
                    ;
                END;

                //Other Currency Released Non OCL total From Sales Line
                SalesLine.RESET;
                //SalesLine.CHANGECOMPANY(Companyname);
                SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
                SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
                SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
                SalesLine.SETFILTER(Status, '%1', SalesLine.Status::Released);
                IF Currency = '' THEN
                    SalesLine.SETFILTER("Currency Code", '<>%1', '')
                ELSE
                    SalesLine.SETFILTER("Currency Code", '<>%1', Currency);
                SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
                SalesLine.SETRANGE("Short Close", FALSE);//31Oct2019
                IF SalesLine.FINDFIRST THEN BEGIN
                    REPEAT
                        DecAmountotherCurrency := 0;
                        DecAmountotherCurrency := SalesLine."Shipped Not Invoiced" + SalesLine."Outstanding Amount";
                        IF RlnExchageRate(Currency, SalesLine."Currency Code", WORKDATE) <> 0 THEN
                            DecAmountotherCurrency := DecAmountotherCurrency * 1 / RlnExchageRate(Currency, SalesLine."Currency Code", WORKDATE)
                        ELSE
                            DecAmountotherCurrency := 0;
                        DecAmountSameCurrency := DecAmountSameCurrency + DecAmountotherCurrency;
                    UNTIL SalesLine.NEXT = 0;
                END;

                //Same Currency <> Released Non OCL total From Sales Line
                SalesLine.RESET;
                //SalesLine.CHANGECOMPANY(Companyname);
                SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
                SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
                SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
                SalesLine.SETFILTER(Status, '<>%1', SalesLine.Status::Released);
                IF Currency = '' THEN
                    SalesLine.SETFILTER("Currency Code", '%1', '')
                ELSE
                    SalesLine.SETFILTER("Currency Code", '%1', Currency);
                SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
                SalesLine.SETRANGE("Short Close", FALSE);//31Oct2019
                IF SalesLine.FINDSET THEN BEGIN
                    SalesLine.CALCSUMS(SalesLine."Shipped Not Invoiced", SalesLine."Outstanding Amount");
                    DecAmountSameCurrency := DecAmountSameCurrency + SalesLine."Shipped Not Invoiced";
                END;

                //Other Currency <> Released Non OCL total From Sales Line
                SalesLine.RESET;
                //SalesLine.CHANGECOMPANY(Companyname);
                SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
                SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
                SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
                SalesLine.SETFILTER(Status, '<>%1', SalesLine.Status::Released);
                IF Currency = '' THEN
                    SalesLine.SETFILTER("Currency Code", '<>%1', '')
                ELSE
                    SalesLine.SETFILTER("Currency Code", '<>%1', Currency);
                SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
                SalesLine.SETRANGE("Short Close", FALSE);//31Oct2019
                IF SalesLine.FINDFIRST THEN BEGIN
                    REPEAT
                        DecAmountotherCurrency := 0;
                        DecAmountotherCurrency := SalesLine."Shipped Not Invoiced";
                        IF RlnExchageRate(Currency, SalesLine."Currency Code", WORKDATE) <> 0 THEN
                            DecAmountotherCurrency := DecAmountotherCurrency * 1 / RlnExchageRate(Currency, SalesLine."Currency Code", WORKDATE)
                        ELSE
                            DecAmountotherCurrency := 0;
                        DecAmountSameCurrency := DecAmountSameCurrency + DecAmountotherCurrency;
                    UNTIL SalesLine.NEXT = 0;
                END;

                //Same Currency open ledger remaining Amount total
                CustLedgerEntry.RESET;
                //CustLedgerEntry.CHANGECOMPANY(Companyname);
                CustLedgerEntry.SETCURRENTKEY("Customer No.", Open, "Currency Code");
                CustLedgerEntry.SETFILTER("Customer No.", CustNo);
                CustLedgerEntry.SETFILTER(Open, '%1', TRUE);
                IF Currency = '' THEN
                    CustLedgerEntry.SETFILTER("Currency Code", '%1', '')
                ELSE
                    CustLedgerEntry.SETFILTER("Currency Code", '%1', Currency);
                CustLedgerEntry.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                CustLedgerEntry.SETFILTER("Posting Date", '<=%1', WORKDATE);
                IF CustLedgerEntry.FINDFIRST THEN
                    REPEAT
                        CustLedgerEntry.CALCFIELDS("Remaining Amount");
                        SameCustledgertotal := SameCustledgertotal + CustLedgerEntry."Remaining Amount";
                    UNTIL CustLedgerEntry.NEXT = 0;

                //other Currency open ledger remaining Amount total
                CustLedgerEntry.RESET;
                //CustLedgerEntry.CHANGECOMPANY(Companyname);
                CustLedgerEntry.SETCURRENTKEY("Customer No.", Open, "Currency Code");
                CustLedgerEntry.SETFILTER("Customer No.", CustNo);
                CustLedgerEntry.SETFILTER(Open, '%1', TRUE);
                IF Currency = '' THEN
                    CustLedgerEntry.SETFILTER("Currency Code", '<>%1', '')
                ELSE
                    CustLedgerEntry.SETFILTER("Currency Code", '<>%1', Currency);
                CustLedgerEntry.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                CustLedgerEntry.SETFILTER("Posting Date", '<=%1', WORKDATE);
                IF CustLedgerEntry.FINDFIRST THEN
                    REPEAT
                        OtherCustledgertotal := 0;
                        CustLedgerEntry.CALCFIELDS("Remaining Amount");
                        IF RlnExchageRate(Currency, CustLedgerEntry."Currency Code", WORKDATE) <> 0 THEN
                            OtherCustledgertotal := CustLedgerEntry."Remaining Amount" * 1 / RlnExchageRate(Currency, CustLedgerEntry."Currency Code", WORKDATE)
                        ELSE
                            OtherCustledgertotal := 0;
                        SameCustledgertotal := SameCustledgertotal + OtherCustledgertotal;
                    UNTIL CustLedgerEntry.NEXT = 0;

            END ELSE BEGIN//RSPLSUM 13Jul2020>>
                          //Same Currency Released Non OCL total From Sales Line
                SalesLine.RESET;
                //SalesLine.CHANGECOMPANY(Companyname);
                SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
                SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
                SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
                SalesLine.SETFILTER(Status, '%1', SalesLine.Status::Released);
                SalesLine.SETFILTER("Currency Code", '%1', '');
                SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
                SalesLine.SETRANGE("Short Close", FALSE);//31Oct2019
                IF SalesLine.FINDSET THEN BEGIN
                    SalesLine.CALCSUMS(SalesLine."Shipped Not Invoiced", SalesLine."Outstanding Amount");
                    DecAmountSameCurrency := DecAmountSameCurrency + SalesLine."Shipped Not Invoiced" + SalesLine."Outstanding Amount";
                    IF DecAmountSameCurrency <> 0 THEN BEGIN
                        RecCurrExchRate.RESET;
                        RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                        RecCurrExchRate.SETRANGE("Currency Code", RecCust."Currency Code");
                        RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                        IF RecCurrExchRate.FINDLAST THEN BEGIN
                            DecAmountSameCurrency := DecAmountSameCurrency * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                        END;
                    END;
                END;

                //Other Currency Released Non OCL total From Sales Line
                SalesLine.RESET;
                //SalesLine.CHANGECOMPANY(Companyname);
                SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
                SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
                SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
                SalesLine.SETFILTER(Status, '%1', SalesLine.Status::Released);
                SalesLine.SETFILTER("Currency Code", '<>%1', '');
                SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
                SalesLine.SETRANGE("Short Close", FALSE);//31Oct2019
                IF SalesLine.FINDFIRST THEN BEGIN
                    REPEAT
                        DecAmountotherCurrency := 0;
                        DecAmountotherCurrency := SalesLine."Shipped Not Invoiced" + SalesLine."Outstanding Amount";

                        IF DecAmountotherCurrency <> 0 THEN BEGIN
                            RecCurrExchRate.RESET;
                            RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                            RecCurrExchRate.SETRANGE("Currency Code", SalesLine."Currency Code");
                            RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                            IF RecCurrExchRate.FINDLAST THEN BEGIN
                                DecAmountotherCurrency := DecAmountotherCurrency / (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                            END;
                        END;

                        IF DecAmountotherCurrency <> 0 THEN BEGIN
                            RecCurrExchRate.RESET;
                            RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                            RecCurrExchRate.SETRANGE("Currency Code", RecCust."Currency Code");
                            RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                            IF RecCurrExchRate.FINDLAST THEN BEGIN
                                DecAmountotherCurrency := DecAmountotherCurrency * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                            END;
                        END;

                        DecAmountSameCurrency := DecAmountSameCurrency + DecAmountotherCurrency;
                    UNTIL SalesLine.NEXT = 0;
                END;

                //Same Currency <> Released Non OCL total From Sales Line
                SalesLine.RESET;
                //SalesLine.CHANGECOMPANY(Companyname);
                SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
                SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
                SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
                SalesLine.SETFILTER(Status, '<>%1', SalesLine.Status::Released);
                SalesLine.SETFILTER("Currency Code", '%1', '');
                SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
                SalesLine.SETRANGE("Short Close", FALSE);//31Oct2019
                IF SalesLine.FINDSET THEN BEGIN
                    SalesLine.CALCSUMS(SalesLine."Shipped Not Invoiced", SalesLine."Outstanding Amount");
                    DecAmountSameCurrency := DecAmountSameCurrency + SalesLine."Shipped Not Invoiced";
                    IF DecAmountSameCurrency <> 0 THEN BEGIN
                        RecCurrExchRate.RESET;
                        RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                        RecCurrExchRate.SETRANGE("Currency Code", RecCust."Currency Code");
                        RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                        IF RecCurrExchRate.FINDLAST THEN BEGIN
                            DecAmountSameCurrency := DecAmountSameCurrency * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                        END;
                    END;
                END;

                //Other Currency <> Released Non OCL total From Sales Line
                SalesLine.RESET;
                //SalesLine.CHANGECOMPANY(Companyname);
                SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
                SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
                SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
                SalesLine.SETFILTER(Status, '<>%1', SalesLine.Status::Released);
                SalesLine.SETFILTER("Currency Code", '<>%1', '');
                SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
                SalesLine.SETRANGE("Short Close", FALSE);//31Oct2019
                IF SalesLine.FINDFIRST THEN BEGIN
                    REPEAT
                        DecAmountotherCurrency := 0;
                        DecAmountotherCurrency := SalesLine."Shipped Not Invoiced";

                        IF DecAmountotherCurrency <> 0 THEN BEGIN
                            RecCurrExchRate.RESET;
                            RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                            RecCurrExchRate.SETRANGE("Currency Code", SalesLine."Currency Code");
                            RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                            IF RecCurrExchRate.FINDLAST THEN BEGIN
                                DecAmountotherCurrency := DecAmountotherCurrency / (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                            END;
                        END;

                        IF DecAmountotherCurrency <> 0 THEN BEGIN
                            RecCurrExchRate.RESET;
                            RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                            RecCurrExchRate.SETRANGE("Currency Code", RecCust."Currency Code");
                            RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                            IF RecCurrExchRate.FINDLAST THEN BEGIN
                                DecAmountotherCurrency := DecAmountotherCurrency * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                            END;
                        END;

                        DecAmountSameCurrency := DecAmountSameCurrency + DecAmountotherCurrency;
                    UNTIL SalesLine.NEXT = 0;
                END;

                //Same Currency open ledger remaining Amount total
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETCURRENTKEY("Customer No.", Open, "Currency Code");
                CustLedgerEntry.SETFILTER("Customer No.", CustNo);
                CustLedgerEntry.SETFILTER(Open, '%1', TRUE);
                CustLedgerEntry.SETFILTER("Currency Code", '%1', '');
                CustLedgerEntry.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                CustLedgerEntry.SETFILTER("Posting Date", '<=%1', WORKDATE);
                IF CustLedgerEntry.FINDFIRST THEN
                    REPEAT
                        CustLedgerEntry.CALCFIELDS("Remaining Amount");
                        SameCustledgertotal := SameCustledgertotal + CustLedgerEntry."Remaining Amount";
                    UNTIL CustLedgerEntry.NEXT = 0;
                IF SameCustledgertotal <> 0 THEN BEGIN
                    RecCurrExchRate.RESET;
                    RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                    RecCurrExchRate.SETRANGE("Currency Code", RecCust."Currency Code");
                    RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                    IF RecCurrExchRate.FINDLAST THEN BEGIN
                        SameCustledgertotal := SameCustledgertotal * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                    END;
                END;

                //other Currency open ledger remaining Amount total
                CustLedgerEntry.RESET;
                //CustLedgerEntry.CHANGECOMPANY(Companyname);
                CustLedgerEntry.SETCURRENTKEY("Customer No.", Open, "Currency Code");
                CustLedgerEntry.SETFILTER("Customer No.", CustNo);
                CustLedgerEntry.SETFILTER(Open, '%1', TRUE);
                CustLedgerEntry.SETFILTER("Currency Code", '<>%1', '');
                CustLedgerEntry.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                CustLedgerEntry.SETFILTER("Posting Date", '<=%1', WORKDATE);
                IF CustLedgerEntry.FINDFIRST THEN
                    REPEAT
                        OtherCustledgertotal := 0;
                        CustLedgerEntry.CALCFIELDS("Remaining Amount");
                        OtherCustledgertotal := CustLedgerEntry."Remaining Amount";

                        IF OtherCustledgertotal <> 0 THEN BEGIN
                            RecCurrExchRate.RESET;
                            RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                            RecCurrExchRate.SETRANGE("Currency Code", CustLedgerEntry."Currency Code");
                            RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                            IF RecCurrExchRate.FINDLAST THEN BEGIN
                                OtherCustledgertotal := OtherCustledgertotal / (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                            END;
                        END;

                        IF OtherCustledgertotal <> 0 THEN BEGIN
                            RecCurrExchRate.RESET;
                            RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                            RecCurrExchRate.SETRANGE("Currency Code", RecCust."Currency Code");
                            RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                            IF RecCurrExchRate.FINDLAST THEN BEGIN
                                OtherCustledgertotal := OtherCustledgertotal * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                            END;
                        END;

                        SameCustledgertotal := SameCustledgertotal + OtherCustledgertotal;
                    UNTIL CustLedgerEntry.NEXT = 0;

            END;//RSPLSUM 13Jul2020<<

        EXIT(DecAmountSameCurrency + SameCustledgertotal);
    end;

    //[Scope('Internal')]
    procedure CreditLimitOCLCheckCheckbycom(CustNo: Code[20]; Currency: Code[10]; Companyname: Text[50]) OCL: Boolean
    var
        CustlederEntry: Record 21;
        Cusotmer: Record 18;
    begin
        //Check ledger for over due days
        OCL := FALSE;
        CustlederEntry.RESET;
        //CustlederEntry.CHANGECOMPANY(Companyname);
        CustlederEntry.SETCURRENTKEY("Customer No.", "Document Type", Open, "Due Date", "Currency Code");
        CustlederEntry.SETFILTER("Customer No.", CustNo);
        CustlederEntry.SETFILTER("Document Type", '%1', CustlederEntry."Document Type"::Invoice);
        CustlederEntry.SETFILTER(Open, '%1', TRUE);
        CustlederEntry.SETFILTER("Due Date", '<%1', CALCDATE((FORMAT('-' + FORMAT(Overduedayformula))), WORKDATE));
        CustlederEntry.SETFILTER("Credit Checking Not Required", '%1', FALSE);
        CustlederEntry.SETFILTER("Posting Date", '<=%1', WORKDATE);
        IF CustlederEntry.FINDFIRST THEN
            REPEAT
                CustlederEntry.CALCFIELDS("Remaining Amount");
                IF (CustlederEntry."Remaining Amount") > 0 THEN BEGIN
                    EXIT(OCL);
                END
            UNTIL CustlederEntry.NEXT = 0;
        EXIT(TRUE);
    end;

    //[Scope('Internal')]
    procedure CreditLimitCustoclCheck(cCustNo: Code[20]; cOrderDate: Date; cCurrency: Code[10]; dOrderValue: Decimal): Boolean
    var
        Customer: Record 18;
        "Sales Line": Record 37;
        CustLedgerEntry: Record 21;
        GlSetup: Record 98;
        GlSetupothercompany: Record 98;
        CustomerGroup: Record 18;
        rCustomer: Record 18;
        bNoChildLimit: Boolean;
        bGroupChild: Boolean;
        bGroupParent: Boolean;
        DecAmountSameCurrency: Decimal;
        dCustomerLimit: Decimal;
        SameCustledgertotal: Decimal;
        OtherCustledgertotal: Decimal;
        dChildBalanceLimit: Decimal;
        DecAmountotherCurrency: Decimal;
        cParentCustNo: Code[20];
        CreditlimitAmount: Decimal;
    begin
        //OCL yes or no return
        EVALUATE(Overduedayformula, '0D');
        GlSetup.GET;
        //IF GlSetup."Exchange Master Company"='' THEN
        // ERROR('Exchange Rate Master Company information in G/L Setup not specified');
        //GlSetupothercompany.CHANGECOMPANY(GlSetup."Exchange Master Company");
        GlSetupothercompany.GET();
        IF FORMAT(GlSetupothercompany."OCL Over Due days") = '' THEN
            ERROR('OCL over due days not specified in G/L Setup')
        ELSE
            Overduedayformula := GlSetupothercompany."OCL Over Due days";

        bGroupParent := FALSE;
        bGroupChild := FALSE;
        IF Customer.GET(cCustNo) THEN;

        //Check - This company is a parent company or not
        CustomerGroup.RESET;
        CustomerGroup.SETFILTER("Parent Company", Customer."No.");
        bGroupParent := CustomerGroup.COUNT() > 0;

        //Check This is a child Company
        IF Customer."Parent Company" <> '' THEN BEGIN
            bGroupChild := TRUE;
            cParentCustNo := Customer."Parent Company";          //Parent Company code
        END;

        //Child Company Balance Credit limi Check
        bNoChildLimit := FALSE;
        dChildBalanceLimit := 0;
        IF bGroupChild AND NOT Customer."Credit Limit Approval" THEN BEGIN
            Company.RESET;
            recCompany.GET;
            //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
            //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
            Company.SETRANGE(Company.Name, recCompany.Name);
            IF Company.FINDFIRST THEN
                REPEAT
                    IF NOT CreditLimitOCLCheckCheckbycom(cCustNo, cCurrency, Company.Name) THEN
                        EXIT(TRUE);
                UNTIL Company.NEXT = 0;

            Company.RESET;
            recCompany.GET;
            //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
            //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
            Company.SETRANGE(Company.Name, recCompany.Name);
            IF Company.FINDFIRST THEN
                REPEAT
                    dChildBalanceLimit := dChildBalanceLimit + CreditLimitCustValueCheckbycom(cCustNo, cCurrency, Company.Name);
                UNTIL Company.NEXT = 0;

            //Check for Limit currently available
            dCustomerLimit := 0;
            IF Customer."Insurance Limit Exp Date" >= cOrderDate THEN
                dCustomerLimit := dCustomerLimit + Customer."Insurance Limit" * Customer."Insurance Percentage" / 100;
            IF Customer."Management Limit Exp Date" >= cOrderDate THEN
                dCustomerLimit := dCustomerLimit + Customer."Management Limit" * Customer."Management Percentage" / 100;
            IF Customer."Temporary Limit Exp Date" >= cOrderDate THEN
                dCustomerLimit := dCustomerLimit + Customer."Temporary Limit" * Customer."Temporary Percentage" / 100;
            IF RlnExchageRate(cCurrency, Customer."Currency Code", WORKDATE) <> 0 THEN
                dCustomerLimit := dCustomerLimit * 1 / RlnExchageRate(cCurrency, Customer."Currency Code", WORKDATE)
            ELSE
                dCustomerLimit := 0;
            IF dCustomerLimit < dChildBalanceLimit + dOrderValue THEN BEGIN
                CreditlimitAmount := dCustomerLimit - dChildBalanceLimit;
                bNoChildLimit := TRUE
            END ELSE
                bNoChildLimit := FALSE;

            IF ((bGroupChild AND (NOT Customer."Credit Limit Approval")) OR (NOT bNoChildLimit)) THEN
                EXIT(TRUE)
        END;


        // Child and OCL OR   Credit Limit Less Than the amount
        IF ((bGroupChild AND (Customer."Credit Limit Approval")) OR (bNoChildLimit)) THEN BEGIN
            //Check in parent
            dChildBalanceLimit := 0;
            IF rCustomer.GET(Customer."Parent Company") THEN BEGIN
                Company.RESET;
                recCompany.GET;
                //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
                //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
                Company.SETRANGE(Company.Name, recCompany.Name);
                IF Company.FINDFIRST THEN
                    REPEAT
                        IF NOT CreditLimitOCLCheckCheckbycom(rCustomer."No.", cCurrency, Company.Name) THEN
                            EXIT(TRUE);
                    UNTIL Company.NEXT = 0;

                Company.RESET;
                recCompany.GET;
                //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
                // recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
                Company.SETRANGE(Company.Name, recCompany.Name);
                IF Company.FINDFIRST THEN
                    REPEAT
                        dChildBalanceLimit := dChildBalanceLimit + CreditLimitCustValueCheckbycom(rCustomer."No.", cCurrency, Company.Name);
                    UNTIL Company.NEXT = 0;
            END;

            //Check In child
            rCustomer.RESET;
            rCustomer.SETFILTER("Parent Company", Customer."Parent Company");
            IF rCustomer.FINDFIRST THEN
                REPEAT
                    Company.RESET;
                    recCompany.GET;
                    //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
                    //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
                    Company.SETRANGE(Company.Name, recCompany.Name);
                    IF Company.FINDFIRST THEN
                        REPEAT
                            IF NOT CreditLimitOCLCheckCheckbycom(rCustomer."No.", cCurrency, Company.Name) THEN
                                EXIT(TRUE);
                        UNTIL Company.NEXT = 0;

                    Company.RESET;
                    recCompany.GET;
                    //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
                    //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
                    Company.SETRANGE(Company.Name, recCompany.Name);
                    IF Company.FINDFIRST THEN
                        REPEAT
                            dChildBalanceLimit := dChildBalanceLimit + CreditLimitCustValueCheckbycom(rCustomer."No.", cCurrency, Company.Name);
                        UNTIL Company.NEXT = 0;
                UNTIL rCustomer.NEXT = 0;

            dCustomerLimit := 0;
            IF rCustomer.GET(Customer."Parent Company") THEN
                IF NOT rCustomer."Credit Limit Approval" THEN BEGIN
                    IF rCustomer."Insurance Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Insurance Limit" * rCustomer."Insurance Percentage" / 100;
                    IF rCustomer."Management Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Management Limit" * rCustomer."Management Percentage" / 100;
                    IF rCustomer."Temporary Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Temporary Limit" * rCustomer."Temporary Percentage" / 100;
                    IF RlnExchageRate(cCurrency, rCustomer."Currency Code", WORKDATE) <> 0 THEN
                        dCustomerLimit := dCustomerLimit * 1 / RlnExchageRate(cCurrency, rCustomer."Currency Code", WORKDATE)
                    ELSE
                        dCustomerLimit := 0;
                END ELSE
                    EXIT(TRUE);
            IF dCustomerLimit < dChildBalanceLimit THEN BEGIN
                CreditlimitAmount := dCustomerLimit - dChildBalanceLimit;
                EXIT(TRUE);
            END
        END;

        //Group Parent
        IF bGroupParent THEN BEGIN
            //Check in parent
            dChildBalanceLimit := 0;
            IF rCustomer.GET(Customer."No.") THEN BEGIN
                Company.RESET;
                recCompany.GET;
                //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
                //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
                Company.SETRANGE(Company.Name, recCompany.Name);
                IF Company.FINDFIRST THEN
                    REPEAT
                        IF NOT CreditLimitOCLCheckCheckbycom(rCustomer."No.", cCurrency, Company.Name) THEN
                            EXIT(TRUE);
                    UNTIL Company.NEXT = 0;

                Company.RESET;
                recCompany.GET;
                //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
                //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
                Company.SETRANGE(Company.Name, recCompany.Name);
                IF Company.FINDFIRST THEN
                    REPEAT
                        dChildBalanceLimit := dChildBalanceLimit + CreditLimitCustValueCheckbycom(rCustomer."No.", cCurrency, Company.Name);
                    UNTIL Company.NEXT = 0;
            END;

            //Check In child
            rCustomer.RESET;
            rCustomer.SETFILTER("Parent Company", Customer."No.");
            IF rCustomer.FINDFIRST THEN
                REPEAT
                    Company.RESET;
                    recCompany.GET;
                    //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
                    //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
                    Company.SETRANGE(Company.Name, recCompany.Name);
                    IF Company.FINDFIRST THEN
                        REPEAT
                            IF NOT CreditLimitOCLCheckCheckbycom(rCustomer."No.", cCurrency, Company.Name) THEN
                                EXIT(TRUE);
                        UNTIL Company.NEXT = 0;

                    Company.RESET;
                    recCompany.GET;
                    //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
                    //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
                    Company.SETRANGE(Company.Name, recCompany.Name);
                    IF Company.FINDFIRST THEN
                        REPEAT
                            dChildBalanceLimit := dChildBalanceLimit + CreditLimitCustValueCheckbycom(rCustomer."No.", cCurrency, Company.Name);
                        UNTIL Company.NEXT = 0;
                UNTIL rCustomer.NEXT = 0;

            dCustomerLimit := 0;
            IF rCustomer.GET(Customer."No.") THEN
                IF NOT rCustomer."Credit Limit Approval" THEN BEGIN
                    IF rCustomer."Insurance Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Insurance Limit" * rCustomer."Insurance Percentage" / 100;
                    IF rCustomer."Management Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Management Limit" * rCustomer."Management Percentage" / 100;
                    IF rCustomer."Temporary Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Temporary Limit" * rCustomer."Temporary Percentage" / 100;
                    IF RlnExchageRate(cCurrency, rCustomer."Currency Code", WORKDATE) <> 0 THEN
                        dCustomerLimit := dCustomerLimit * 1 / RlnExchageRate(cCurrency, rCustomer."Currency Code", WORKDATE)
                    ELSE
                        dCustomerLimit := 0;
                END ELSE
                    EXIT(TRUE);

            IF dCustomerLimit < dChildBalanceLimit THEN BEGIN
                CreditlimitAmount := dCustomerLimit - dChildBalanceLimit;
                EXIT(TRUE);
            END;
        END;

        //No Parent No Child
        IF ((NOT bGroupChild)) AND ((NOT bGroupParent)) THEN BEGIN
            dChildBalanceLimit := 0;
            IF rCustomer.GET(Customer."No.") THEN BEGIN
                Company.RESET;
                recCompany.GET;
                //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
                //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
                Company.SETRANGE(Company.Name, recCompany.Name);
                IF Company.FINDFIRST THEN
                    REPEAT
                        IF NOT CreditLimitOCLCheckCheckbycom(rCustomer."No.", cCurrency, Company.Name) THEN
                            EXIT(TRUE);
                    UNTIL Company.NEXT = 0;

                Company.RESET;
                recCompany.GET;
                //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
                //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
                Company.SETRANGE(Company.Name, recCompany.Name);
                IF Company.FINDFIRST THEN
                    REPEAT
                        dChildBalanceLimit := dChildBalanceLimit + CreditLimitCustValueCheckbycom(rCustomer."No.", cCurrency, Company.Name);
                    UNTIL Company.NEXT = 0;
            END;
            dCustomerLimit := 0;
            IF rCustomer.GET(Customer."No.") THEN
                IF NOT rCustomer."Credit Limit Approval" THEN BEGIN
                    IF rCustomer."Insurance Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Insurance Limit" * rCustomer."Insurance Percentage" / 100;
                    IF rCustomer."Management Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Management Limit" * rCustomer."Management Percentage" / 100;
                    IF rCustomer."Temporary Limit Exp Date" >= cOrderDate THEN
                        dCustomerLimit := dCustomerLimit + rCustomer."Temporary Limit" * rCustomer."Temporary Percentage" / 100;
                    IF RlnExchageRate(cCurrency, rCustomer."Currency Code", WORKDATE) <> 0 THEN
                        dCustomerLimit := dCustomerLimit * 1 / RlnExchageRate(cCurrency, rCustomer."Currency Code", WORKDATE)
                    ELSE
                        dCustomerLimit := 0;
                END ELSE
                    EXIT(TRUE);

            IF dCustomerLimit < dChildBalanceLimit THEN BEGIN
                CreditlimitAmount := dCustomerLimit - dChildBalanceLimit;
                EXIT(TRUE);
            END;
        END;

        EXIT(TRUE);//credit approval process changed
    end;

    //[Scope('Internal')]
    procedure CreditExposure(CustNo: Code[20]; Currency: Code[10]) Exposure: Decimal
    begin
        Company.RESET;
        recCompany.GET;
        //IF recCompany.Name='GP Global Energy Private Limited' THEN  //05Jul2018
        //recCompany.Name:='GP Global Energy Pvt. Ltd.';//05Jul2018
        Company.SETRANGE(Company.Name, recCompany.Name);
        Exposure := 0;
        IF Company.FINDFIRST THEN
            REPEAT
                Exposure := Exposure + CreditLimitCustValueCheckbycom(CustNo, Currency, Company.Name);
            UNTIL Company.NEXT = 0;

        EXIT(Exposure);
    end;

    //[Scope('Internal')]
    procedure CustSalesLineValue(CustNo: Code[20]; Currency: Code[10]; Companyname: Text[50]) CompanyTotalValue: Decimal
    var
        Customer: Record 18;
        DecAmountSameCurrency: Decimal;
        SalesLine: Record 37;
        CusomteLimit: Decimal;
        DecAmountotherCurrency: Decimal;
        CustLedgerEntry: Record 21;
        SameCustledgertotal: Decimal;
        OtherCustledgertotal: Decimal;
        RecCust: Record 18;
    begin
        CompanyTotalValue := 0;
        DecAmountSameCurrency := 0;
        DecAmountotherCurrency := 0;
        CusomteLimit := 0;
        SameCustledgertotal := 0;
        OtherCustledgertotal := 0;

        //RSPLSUM 13Jul2020>>
        RecCust.RESET;
        IF RecCust.GET(CustNo) THEN
            IF RecCust."Currency Code" <> 'USD' THEN BEGIN//RSPLSUM 13Jul2020<<

                //Same Currency Released Non OCL total From Sales Line
                SalesLine.RESET;
                //SalesLine.CHANGECOMPANY(Companyname);
                SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
                SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
                SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
                SalesLine.SETFILTER(Status, '%1', SalesLine.Status::Released);
                IF Currency = '' THEN
                    SalesLine.SETFILTER("Currency Code", '%1', '')
                ELSE
                    SalesLine.SETFILTER("Currency Code", '%1', Currency);
                SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
                SalesLine.SETRANGE("Short Close", FALSE);//02May2019
                IF SalesLine.FINDSET THEN BEGIN
                    SalesLine.CALCSUMS(SalesLine."Shipped Not Invoiced", SalesLine."Outstanding Amount");
                    DecAmountSameCurrency := DecAmountSameCurrency + SalesLine."Outstanding Amount";
                END;

                //Other Currency Released Non OCL total From Sales Line

                SalesLine.RESET;
                //SalesLine.CHANGECOMPANY(Companyname);
                SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
                SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
                SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
                SalesLine.SETFILTER(Status, '%1', SalesLine.Status::Released);
                IF Currency = '' THEN
                    SalesLine.SETFILTER("Currency Code", '<>%1', '')
                ELSE
                    SalesLine.SETFILTER("Currency Code", '<>%1', Currency);
                SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
                SalesLine.SETRANGE("Short Close", FALSE);//02May2019
                IF SalesLine.FINDFIRST THEN BEGIN
                    REPEAT
                        DecAmountotherCurrency := 0;
                        DecAmountotherCurrency := SalesLine."Outstanding Amount";
                        IF RlnExchageRate(Currency, SalesLine."Currency Code", WORKDATE) <> 0 THEN
                            DecAmountotherCurrency := DecAmountotherCurrency * 1 / RlnExchageRate(Currency, SalesLine."Currency Code", WORKDATE)
                        ELSE
                            DecAmountotherCurrency := 0;
                        DecAmountSameCurrency := DecAmountSameCurrency + DecAmountotherCurrency;
                    UNTIL SalesLine.NEXT = 0;
                END;
            END ELSE BEGIN//RSPLSUM 13Jul2020>>
                          //Same Currency Released Non OCL total From Sales Line
                SalesLine.RESET;
                //SalesLine.CHANGECOMPANY(Companyname);
                SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
                SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
                SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
                SalesLine.SETFILTER(Status, '%1', SalesLine.Status::Released);
                SalesLine.SETFILTER("Currency Code", '%1', '');
                SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
                SalesLine.SETRANGE("Short Close", FALSE);//02May2019
                IF SalesLine.FINDSET THEN BEGIN
                    SalesLine.CALCSUMS(SalesLine."Shipped Not Invoiced", SalesLine."Outstanding Amount");
                    DecAmountSameCurrency := DecAmountSameCurrency + SalesLine."Outstanding Amount";
                    IF DecAmountSameCurrency <> 0 THEN BEGIN
                        RecCurrExchRate.RESET;
                        RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                        RecCurrExchRate.SETRANGE("Currency Code", RecCust."Currency Code");
                        RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                        IF RecCurrExchRate.FINDLAST THEN BEGIN
                            //dCustomerLimit := dCustomerLimit/(RecCurrExchRate."Exchange Rate Amount"/RecCurrExchRate."Relational Exch. Rate Amount");
                            DecAmountSameCurrency := DecAmountSameCurrency * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                        END;
                    END;
                END;

                //Other Currency Released Non OCL total From Sales Line

                SalesLine.RESET;
                //SalesLine.CHANGECOMPANY(Companyname);
                SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
                SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
                SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
                SalesLine.SETFILTER(Status, '%1', SalesLine.Status::Released);
                SalesLine.SETFILTER("Currency Code", '<>%1', '');
                SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
                SalesLine.SETRANGE("Short Close", FALSE);//02May2019
                IF SalesLine.FINDFIRST THEN BEGIN
                    REPEAT
                        DecAmountotherCurrency := 0;
                        DecAmountotherCurrency := SalesLine."Outstanding Amount";

                        IF DecAmountotherCurrency <> 0 THEN BEGIN
                            RecCurrExchRate.RESET;
                            RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                            RecCurrExchRate.SETRANGE("Currency Code", SalesLine."Currency Code");
                            RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                            IF RecCurrExchRate.FINDLAST THEN BEGIN
                                DecAmountotherCurrency := DecAmountotherCurrency / (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                            END;
                        END;

                        IF DecAmountotherCurrency <> 0 THEN BEGIN
                            RecCurrExchRate.RESET;
                            RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                            RecCurrExchRate.SETRANGE("Currency Code", RecCust."Currency Code");
                            RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                            IF RecCurrExchRate.FINDLAST THEN BEGIN
                                //dCustomerLimit := dCustomerLimit/(RecCurrExchRate."Exchange Rate Amount"/RecCurrExchRate."Relational Exch. Rate Amount");
                                DecAmountotherCurrency := DecAmountotherCurrency * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                            END;
                        END;

                        DecAmountSameCurrency := DecAmountSameCurrency + DecAmountotherCurrency;
                    UNTIL SalesLine.NEXT = 0;
                END;
            END;//RSPLSUM 13Jul2020<<

        EXIT(DecAmountSameCurrency + SameCustledgertotal);
    end;

    // [Scope('Internal')]
    procedure ShippedNotInvoiced(CustNo: Code[20]; Currency: Code[10]; Companyname: Text[50]) CompanyTotalValue: Decimal
    var
        Customer: Record 18;
        DecAmountSameCurrency: Decimal;
        SalesLine: Record 37;
        CusomteLimit: Decimal;
        DecAmountotherCurrency: Decimal;
        CustLedgerEntry: Record 21;
        SameCustledgertotal: Decimal;
        OtherCustledgertotal: Decimal;
    begin
        CompanyTotalValue := 0;
        DecAmountSameCurrency := 0;
        DecAmountotherCurrency := 0;
        CusomteLimit := 0;
        SameCustledgertotal := 0;
        OtherCustledgertotal := 0;


        //Same Currency Released Non OCL total From Sales Line
        SalesLine.RESET;
        //SalesLine.CHANGECOMPANY(Companyname);
        SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
        SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
        SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
        SalesLine.SETFILTER(Status, '%1', SalesLine.Status::Released);
        IF Currency = '' THEN
            SalesLine.SETFILTER("Currency Code", '%1', '')
        ELSE
            SalesLine.SETFILTER("Currency Code", '%1', Currency);
        SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
        SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
        SalesLine.SETRANGE("Short Close", FALSE);//31Oct2019
        IF SalesLine.FINDSET THEN BEGIN
            SalesLine.CALCSUMS(SalesLine."Shipped Not Invoiced", SalesLine."Outstanding Amount");
            DecAmountSameCurrency := DecAmountSameCurrency + SalesLine."Shipped Not Invoiced";
            ;
        END;

        //Other Currency Released Non OCL total From Sales Line
        SalesLine.RESET;
        //SalesLine.CHANGECOMPANY(Companyname);
        SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
        SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
        SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
        SalesLine.SETFILTER(Status, '%1', SalesLine.Status::Released);
        IF Currency = '' THEN
            SalesLine.SETFILTER("Currency Code", '<>%1', '')
        ELSE
            SalesLine.SETFILTER("Currency Code", '<>%1', Currency);
        SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
        SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
        SalesLine.SETRANGE("Short Close", FALSE);//31Oct2019
        IF SalesLine.FINDFIRST THEN BEGIN
            REPEAT
                DecAmountotherCurrency := 0;
                DecAmountotherCurrency := SalesLine."Shipped Not Invoiced";
                IF RlnExchageRate(Currency, SalesLine."Currency Code", WORKDATE) <> 0 THEN
                    DecAmountotherCurrency := DecAmountotherCurrency * 1 / RlnExchageRate(Currency, SalesLine."Currency Code", WORKDATE)
                ELSE
                    DecAmountotherCurrency := 0;
                DecAmountSameCurrency := DecAmountSameCurrency + DecAmountotherCurrency;
            UNTIL SalesLine.NEXT = 0;
        END;

        //Same Currency <> Released Non OCL total From Sales Line
        SalesLine.RESET;
        //SalesLine.CHANGECOMPANY(Companyname);
        SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
        SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
        SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
        SalesLine.SETFILTER(Status, '<>%1', SalesLine.Status::Released);
        IF Currency = '' THEN
            SalesLine.SETFILTER("Currency Code", '%1', '')
        ELSE
            SalesLine.SETFILTER("Currency Code", '%1', Currency);
        SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
        SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
        SalesLine.SETRANGE("Short Close", FALSE);//31Oct2019
        IF SalesLine.FINDSET THEN BEGIN
            SalesLine.CALCSUMS(SalesLine."Shipped Not Invoiced", SalesLine."Outstanding Amount");
            DecAmountSameCurrency := DecAmountSameCurrency + SalesLine."Shipped Not Invoiced";
        END;

        //Other Currency <> Released Non OCL total From Sales Line

        SalesLine.RESET;
        //SalesLine.CHANGECOMPANY(Companyname);
        SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", Status, "Currency Code", "Credit Checking Not Required", Type);
        SalesLine.SETFILTER("Document Type", '%1', SalesLine."Document Type"::Order);
        SalesLine.SETFILTER("Bill-to Customer No.", CustNo);
        SalesLine.SETFILTER(Status, '<>%1', SalesLine.Status::Released);
        IF Currency = '' THEN
            SalesLine.SETFILTER("Currency Code", '<>%1', '')
        ELSE
            SalesLine.SETFILTER("Currency Code", '<>%1', Currency);
        SalesLine.SETFILTER("Credit Checking Not Required", '%1', FALSE);
        SalesLine.SETFILTER(Type, '%1', SalesLine.Type::Item);
        SalesLine.SETRANGE("Short Close", FALSE);//31Oct2019
        IF SalesLine.FINDFIRST THEN BEGIN
            REPEAT
                DecAmountotherCurrency := 0;
                DecAmountotherCurrency := SalesLine."Shipped Not Invoiced";
                IF RlnExchageRate(Currency, SalesLine."Currency Code", WORKDATE) <> 0 THEN
                    DecAmountotherCurrency := DecAmountotherCurrency * 1 / RlnExchageRate(Currency, SalesLine."Currency Code", WORKDATE)
                ELSE
                    DecAmountotherCurrency := 0;
                DecAmountSameCurrency := DecAmountSameCurrency + DecAmountotherCurrency;
            UNTIL SalesLine.NEXT = 0;
        END;

        EXIT(DecAmountSameCurrency + SameCustledgertotal);
    end;

    //[Scope('Internal')]
    procedure CustOutStanding(CustNo: Code[20]; Currency: Code[10]; Companyname: Text[50]) CompanyTotalValue: Decimal
    var
        Customer: Record 18;
        DecAmountSameCurrency: Decimal;
        SalesLine: Record 37;
        CusomteLimit: Decimal;
        DecAmountotherCurrency: Decimal;
        CustLedgerEntry: Record 21;
        SameCustledgertotal: Decimal;
        OtherCustledgertotal: Decimal;
        RecCust: Record 18;
    begin
        CompanyTotalValue := 0;
        DecAmountSameCurrency := 0;
        DecAmountotherCurrency := 0;
        CusomteLimit := 0;
        SameCustledgertotal := 0;
        OtherCustledgertotal := 0;

        //RSPLSUM 13Jul2020>>
        RecCust.RESET;
        IF RecCust.GET(CustNo) THEN
            IF RecCust."Currency Code" <> 'USD' THEN BEGIN//RSPLSUM 13Jul2020<<

                //Same Currency open ledger remaining Amount total

                CustLedgerEntry.RESET;
                //CustLedgerEntry.CHANGECOMPANY(Companyname);
                CustLedgerEntry.SETCURRENTKEY("Customer No.", Open, "Currency Code");
                CustLedgerEntry.SETFILTER("Customer No.", CustNo);
                CustLedgerEntry.SETFILTER(Open, '%1', TRUE);
                IF Currency = '' THEN
                    CustLedgerEntry.SETFILTER("Currency Code", '%1', '')
                ELSE
                    CustLedgerEntry.SETFILTER("Currency Code", '%1', Currency);
                CustLedgerEntry.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                CustLedgerEntry.SETFILTER("Posting Date", '<=%1', WORKDATE);
                IF CustLedgerEntry.FINDFIRST THEN
                    REPEAT
                        CustLedgerEntry.CALCFIELDS("Remaining Amount");
                        SameCustledgertotal := SameCustledgertotal + CustLedgerEntry."Remaining Amount";
                    UNTIL CustLedgerEntry.NEXT = 0;

                //other Currency open ledger remaining Amount total
                CustLedgerEntry.RESET;
                //CustLedgerEntry.CHANGECOMPANY(Companyname);
                CustLedgerEntry.SETCURRENTKEY("Customer No.", Open, "Currency Code");
                CustLedgerEntry.SETFILTER("Customer No.", CustNo);
                CustLedgerEntry.SETFILTER(Open, '%1', TRUE);
                IF Currency = '' THEN
                    CustLedgerEntry.SETFILTER("Currency Code", '<>%1', '')
                ELSE
                    CustLedgerEntry.SETFILTER("Currency Code", '<>%1', Currency);
                CustLedgerEntry.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                CustLedgerEntry.SETFILTER("Posting Date", '<=%1', WORKDATE);
                IF CustLedgerEntry.FINDFIRST THEN
                    REPEAT
                        OtherCustledgertotal := 0;
                        CustLedgerEntry.CALCFIELDS("Remaining Amount");
                        IF RlnExchageRate(Currency, CustLedgerEntry."Currency Code", WORKDATE) <> 0 THEN
                            OtherCustledgertotal := CustLedgerEntry."Remaining Amount" * 1 /
                                                    RlnExchageRate(Currency, CustLedgerEntry."Currency Code", CustLedgerEntry."Posting Date")
                        ELSE
                            OtherCustledgertotal := 0;
                        SameCustledgertotal := SameCustledgertotal + OtherCustledgertotal;
                    UNTIL CustLedgerEntry.NEXT = 0;
            END ELSE BEGIN//RSPLSUM 13Jul2020>>
                          //Same Currency open ledger remaining Amount total

                CustLedgerEntry.RESET;
                CustLedgerEntry.SETCURRENTKEY("Customer No.", Open, "Currency Code");
                CustLedgerEntry.SETFILTER("Customer No.", CustNo);
                CustLedgerEntry.SETFILTER(Open, '%1', TRUE);
                CustLedgerEntry.SETFILTER("Currency Code", '%1', '');
                CustLedgerEntry.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                CustLedgerEntry.SETFILTER("Posting Date", '<=%1', WORKDATE);
                IF CustLedgerEntry.FINDFIRST THEN
                    REPEAT
                        CustLedgerEntry.CALCFIELDS("Remaining Amount");
                        SameCustledgertotal := SameCustledgertotal + CustLedgerEntry."Remaining Amount";
                    UNTIL CustLedgerEntry.NEXT = 0;
                IF SameCustledgertotal <> 0 THEN BEGIN
                    RecCurrExchRate.RESET;
                    RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                    RecCurrExchRate.SETRANGE("Currency Code", RecCust."Currency Code");
                    RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                    IF RecCurrExchRate.FINDLAST THEN BEGIN
                        SameCustledgertotal := SameCustledgertotal * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                    END;
                END;

                //other Currency open ledger remaining Amount total
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETCURRENTKEY("Customer No.", Open, "Currency Code");
                CustLedgerEntry.SETFILTER("Customer No.", CustNo);
                CustLedgerEntry.SETFILTER(Open, '%1', TRUE);
                CustLedgerEntry.SETFILTER("Currency Code", '<>%1', '');
                CustLedgerEntry.SETFILTER("Credit Checking Not Required", '%1', FALSE);
                CustLedgerEntry.SETFILTER("Posting Date", '<=%1', WORKDATE);
                IF CustLedgerEntry.FINDFIRST THEN
                    REPEAT
                        OtherCustledgertotal := 0;
                        CustLedgerEntry.CALCFIELDS("Remaining Amount");
                        OtherCustledgertotal := CustLedgerEntry."Remaining Amount";

                        IF OtherCustledgertotal <> 0 THEN BEGIN
                            RecCurrExchRate.RESET;
                            RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                            RecCurrExchRate.SETRANGE("Currency Code", CustLedgerEntry."Currency Code");
                            RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                            IF RecCurrExchRate.FINDLAST THEN BEGIN
                                OtherCustledgertotal := OtherCustledgertotal / (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                            END;
                        END;

                        IF OtherCustledgertotal <> 0 THEN BEGIN
                            RecCurrExchRate.RESET;
                            RecCurrExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                            RecCurrExchRate.SETRANGE("Currency Code", RecCust."Currency Code");
                            RecCurrExchRate.SETFILTER(RecCurrExchRate."Starting Date", '<=%1', WORKDATE);
                            IF RecCurrExchRate.FINDLAST THEN BEGIN
                                OtherCustledgertotal := OtherCustledgertotal * (RecCurrExchRate."Exchange Rate Amount" / RecCurrExchRate."Relational Exch. Rate Amount");
                            END;
                        END;

                        SameCustledgertotal := SameCustledgertotal + OtherCustledgertotal;
                    UNTIL CustLedgerEntry.NEXT = 0;
            END;//RSPLSUM 13Jul2020<<

        EXIT(DecAmountSameCurrency + SameCustledgertotal);
    end;
}

