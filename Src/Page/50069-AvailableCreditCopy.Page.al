page 70028 "Available Credit Copy"
{
    // 
    // 22May2017--Replace SetrangeCode for Customer From OnAfterGetRecord-->OnOpenPage

    Caption = 'Available Credit';
    Editable = false;
    PageType = Card;
    SourceTable = 18;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Balance (LCY)"; rec."Balance (LCY)")
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    var
                        DtldCustLedgEntry: Record 379;
                        CustLedgEntry: Record 21;
                    begin
                        DtldCustLedgEntry.SETRANGE("Customer No.", Rec."No.");
                        Rec.COPYFILTER("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                        Rec.COPYFILTER("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                        Rec.COPYFILTER("Currency Filter", DtldCustLedgEntry."Currency Code");
                        CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                    end;
                }
                field(vOutStandSo; vOutStandSo)
                {
                    ApplicationArea = all;
                    Caption = 'Approved Orders (LCY)';
                }
                field(vCurrentOrderAmt; vCurrentOrderAmt)
                {
                    ApplicationArea = all;
                    Caption = 'Total Shipment Value (LCY)';
                }
                field("Outstanding Orders (LCY)"; rec."Outstanding Orders (LCY)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shipped Not Invoiced (LCY)"; rec."Shipped Not Invoiced (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Shipped Not Invd. (LCY)';
                }
                field("Outstanding Invoices (LCY)"; rec."Outstanding Invoices (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Outstanding Invoices (LCY)';
                }
                field("Outstanding Serv. Orders (LCY)"; rec."Outstanding Serv. Orders (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Serv Shipped Not Invoiced(LCY)"; rec."Serv Shipped Not Invoiced(LCY)")
                {
                    ApplicationArea = all;
                }
                field("Outstanding Serv.Invoices(LCY)"; rec."Outstanding Serv.Invoices(LCY)")
                {
                    ApplicationArea = all;
                }
                field(GetTotalAmountLCYUI; Rec.GetTotalAmountLCYUI)
                {
                    ApplicationArea = all;
                    AutoFormatType = 1;
                    Caption = 'Total (LCY)';
                    Visible = false;
                }
                field(TotalAmountLCY; TotalAmountLCY)
                {
                    ApplicationArea = all;
                    Caption = 'Total (LCY)';
                }
                field("Credit Limit (LCY)"; rec."Credit Limit (LCY)")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTxt;
                }
                field(CalcAvailableCreditUI; rec.CalcAvailableCreditUI)
                {
                    ApplicationArea = all;
                    Caption = 'Available Credit (LCY)';
                    Visible = false;
                }
                field(AvailCreditLCY; AvailCreditLCY)
                {
                    ApplicationArea = all;
                    Caption = 'Available Credit (LCY)';
                }
                field("Balance Due (LCY)"; rec.CalcOverdueBalance)
                {
                    ApplicationArea = all;
                    CaptionClass = FORMAT(STRSUBSTNO(Text000, FORMAT(WORKDATE)));

                    trigger OnDrillDown()
                    var
                        DtldCustLedgEntry: Record 379;
                        CustLedgEntry: Record 21;
                    begin
                        DtldCustLedgEntry.SETFILTER("Customer No.", rec."No.");
                        Rec.COPYFILTER("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                        Rec.COPYFILTER("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                        Rec.COPYFILTER("Currency Filter", DtldCustLedgEntry."Currency Code");
                        CustLedgEntry.DrillDownOnOverdueEntries(DtldCustLedgEntry);
                    end;
                }
                field(GetInvoicedPrepmtAmountLCY; Rec.GetInvoicedPrepmtAmountLCY)
                {
                    ApplicationArea = all;
                    Caption = 'Invoiced Prepayment Amount (LCY)';
                }
            }
        }
        area(factboxes)
        {
            systempart(sys1; Links)
            {
                Visible = false;
            }
            systempart(sys2; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        vOutStandSo := 0;
        /*
        SETRANGE("No.",vOrderCustNo);
        *///Commented 22May2017


        recSH.RESET;
        recSH.SETCURRENTKEY("Document Type", "Bill-to Customer No.", "Short Close", Status);
        recSH.SETRANGE("Document Type", recSH."Document Type"::Order);
        recSH.SETRANGE("Bill-to Customer No.", Rec."No.");
        recSH.SETRANGE("Short Close", FALSE);
        recSH.SETRANGE(Status, recSH.Status::Released);
        IF recSH.FINDFIRST THEN
            REPEAT
                recSH.CALCFIELDS("Amount to Customer");
                IF recSH."Currency Factor" <> 0 THEN
                    vOutStandSo := vOutStandSo + (recSH."Amount to Customer" / recSH."Currency Factor")
                ELSE
                    vOutStandSo := vOutStandSo + recSH."Amount to Customer";
            UNTIL recSH.NEXT = 0;

        vCurrentOrderAmt := CurrentOrderAmt(vCurrentOrderNo);

        Rec.SETRANGE("Date Filter", 0D, WORKDATE);
        Rec.CALCFIELDS("Balance (LCY)", "Balance Due (LCY)", "Outstanding Orders (LCY)", "Shipped Not Invoiced (LCY)");

        TotalAmountLCY := Rec."Balance (LCY)" + vOutStandSo + vCurrentOrderAmt;

        //vOutStandSo+ "Shipped Not Invoiced (LCY)" +
        // "Outstanding Serv. Orders (LCY)" + "Serv Shipped Not Invoiced(LCY)";
        StyleTxt := Rec.SetStyle;

        AvailCreditLCY := 0;
        IF Rec."Credit Limit (LCY)" <> 0 THEN
            AvailCreditLCY := Rec."Credit Limit (LCY)" - TotalAmountLCY;

    end;

    trigger OnClosePage()
    begin
        CLEAR(vOutStandSo);
    end;

    trigger OnInit()
    begin
        vOutStandSo := 0;
    end;

    trigger OnOpenPage()
    begin

        //>>22May2017 RB-N
        rec.SETRANGE("No.", vOrderCustNo);
        //>>22May2017
    end;

    var
        Text000: Label 'Overdue Amounts (LCY) as of %1';
        StyleTxt: Text;
        vCurrentOrderNo: Code[50];
        vOrderCustNo: Code[70];
        vCurrentOrderAmt: Decimal;
        vOutStandSo: Decimal;
        recSH: Record 36;
        TotalAmountLCY: Decimal;
        AvailCreditLCY: Decimal;

    //  [Scope('Internal')]
    procedure GetOrderNo(SalesOrderNo: Code[50]): Code[50]
    begin
        vCurrentOrderNo := SalesOrderNo;
    end;

    // [Scope('Internal')]
    procedure GetCustomerNo(CustomerNo: Code[60]): Code[60]
    begin
        CLEAR(vOrderCustNo);
        vOrderCustNo := CustomerNo;
    end;

    //  [Scope('Internal')]
    procedure CurrentOrderAmt(OrderNo: Code[50]): Decimal
    var
        recSLine: Record 37;
        RecSH: Record 36;
        RecSL: Record 37;
        TCSAmount: Decimal;
    begin
        recSLine.RESET;
        recSLine.SETCURRENTKEY("Document Type", "Document No.");
        recSLine.SETRANGE("Document Type", recSLine."Document Type"::Order);
        recSLine.SETRANGE("Document No.", OrderNo);
        recSLine.SETFILTER(Quantity, '>0');
        IF recSLine.FINDFIRST THEN BEGIN
            //RSPLSUM 12Oct2020>>
            CLEAR(TCSAmount);
            RecSL.RESET;
            RecSL.SETCURRENTKEY("Document Type", "Document No.");
            RecSL.SETRANGE("Document Type", RecSL."Document Type"::Order);
            RecSL.SETRANGE("Document No.", OrderNo);
            RecSL.SETFILTER(Quantity, '>0');
            IF (RecSL."Shortcut Dimension 1 Code" = 'DIV-04') OR (RecSL."Shortcut Dimension 1 Code" = 'DIV-08') THEN
                RecSL.SETFILTER("Qty. to Ship", '>0');
            IF ((recSLine."Shortcut Dimension 1 Code" = 'DIV-04') OR (recSLine."Shortcut Dimension 1 Code" = 'DIV-08')) AND (recSLine."Location Code" = 'PLANT01') THEN
                RecSL.SETRANGE("Qty. to Ship");
            IF RecSL.FINDSET THEN
                REPEAT
                    TCSAmount += RecSL."TDS/TCS Amount";
                UNTIL RecSL.NEXT = 0;
            //RSPLSUM 12Oct2020<<

            //>>07Jul2019
            IF (recSLine."Shortcut Dimension 1 Code" = 'DIV-04') OR (recSLine."Shortcut Dimension 1 Code" = 'DIV-08') THEN
                recSLine.SETFILTER("Qty. to Ship", '>0');
            //<<07Jul2019

            //>>31Oct2019
            IF (recSLine."Shortcut Dimension 1 Code" = 'DIV-04') OR (recSLine."Shortcut Dimension 1 Code" = 'DIV-08') THEN
                IF (recSLine."Location Code" = 'PLANT01') THEN BEGIN
                    recSLine.SETRANGE("Qty. to Ship");
                    //recSLine.SETFILTER("Outstanding Quantity",'>0');
                    recSLine.CALCSUMS("Amount To Customer");
                    EXIT(recSLine."Amount To Customer" + TCSAmount);//RSPLSUM 12Oct2020
                END;
            //<<31Oct2019

            recSLine.CALCSUMS("Amount To Customer");
            EXIT(recSLine."Amount To Customer" + TCSAmount);//RSPLSUM 12Oct2020
        END;
    end;
}

