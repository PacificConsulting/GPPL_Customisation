page 60102 "Accounts Receivables"
{
    PageType = Card;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group("Accounts Receivables")
            {
                Caption = 'Accounts Receivables';
                field(SalesRecvbl; SalesRecvbl)
                {
                    ApplicationArea = all;
                    Caption = 'Sales Receivables';
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //FORM.RUN(25);
                        CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                    end;
                }
                field(SalesOutstndg; SalesOutstndg)
                {
                    ApplicationArea = all;
                    Caption = 'Day Sales Outstanding';
                    Editable = false;
                }
                field(DebtorDays; DebtorDays)
                {
                    ApplicationArea = all;
                    Caption = 'Best Debtor Days';
                    Editable = false;
                }
                field(DaysDelinquent; DaysDelinquent)
                {
                    ApplicationArea = all;
                    Caption = 'Days Delinquent';
                    Editable = false;
                }
                field(SalesRecvblNotDue; SalesRecvblNotDue)
                {
                    ApplicationArea = all;
                    Caption = 'Invoices as on date not due';
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CustLedgerEntry.RESET;
                        CustLedgerEntry.SETFILTER("Due Date", '>%1', TODAY);
                        IF CustLedgerEntry.FINDSET THEN;

                        PAGE.RUN(25, CustLedgerEntry);
                    end;
                }
                field(RcvblTurnover; RcvblTurnover)
                {
                    ApplicationArea = all;
                    Caption = 'Receivables Turnover';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        StartDate := CALCDATE('-CM', TODAY);
        Date2 := 0;
        NoOfDaysInPeriod := 0;


        Date2 := DATE2DMY(TODAY, 1);
        IF Date2 <> 1 THEN
            NoOfDaysInPeriod := Date2;
        MESSAGE(FORMAT(NoOfDaysInPeriod));

        SalesRecvbl := 0;
        CustRec.RESET;
        IF CustRec.FINDSET THEN
            REPEAT
                CustRec.CALCFIELDS(CustRec."Balance (LCY)");
                SalesRecvbl += CustRec."Balance (LCY)";
            UNTIL CustRec.NEXT = 0;

        SalesAmount := 0;
        ValueEnty.RESET;
        ValueEnty.SETRANGE("Posting Date", StartDate, TODAY);
        IF ValueEnty.FINDSET THEN
            REPEAT
                SalesAmount += ValueEnty."Sales Amount (Actual)";
            UNTIL ValueEnty.NEXT = 0;

        SalesOutstndg := 0;
        RcvblTurnover := 0;
        DebtorDays := 0;
        IF SalesAmount <> 0 THEN BEGIN
            SalesOutstndg := (SalesRecvbl / SalesAmount) * NoOfDaysInPeriod;
            RcvblTurnover := (SalesRecvbl / SalesAmount);
            DebtorDays := (SalesRecvbl * NoOfDaysInPeriod / SalesAmount);
        END;

        DaysDelinquent := 0;
        DaysDelinquent := SalesOutstndg - DebtorDays;

        SalesRecvblNotDue := 0;
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETFILTER("Due Date", '>%1', TODAY);
        IF CustLedgerEntry.FINDSET THEN
            REPEAT
                CustLedgerEntry.CALCFIELDS(CustLedgerEntry.Amount);
                SalesRecvblNotDue += CustLedgerEntry.Amount;
            UNTIL CustLedgerEntry.NEXT = 0;
    end;

    var
        SalesRecvbl: Decimal;
        StartDate: Date;
        CustRec: Record Customer;
        SalesOutstndg: Decimal;
        ValueEnty: Record "Value Entry";
        SalesAmount: Decimal;
        NoOfDaysInPeriod: Integer;
        Date1: Integer;
        Date2: Integer;
        DebtorDays: Decimal;
        DaysDelinquent: Decimal;
        SalesRecvblNotDue: Decimal;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        RcvblTurnover: Decimal;
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";

}

