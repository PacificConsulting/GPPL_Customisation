page 60101 "Top 5 Salespersons"
{
    Editable = false;
    PageType = Card;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group("TOP 5 SALES DASHBOARD")
            {
                Caption = 'TOP 5 SALES DASHBOARD';
                grid("Top 5 SalesPersons of the Month")
                {
                    Caption = 'Top 5 SalesPersons of the Month';
                    group(group1)
                    {
                        label(label1)
                        {
                            ApplicationArea = all;
                            CaptionClass = TopSPName[1];
                            ShowCaption = false;
                        }
                        label(label2)
                        {
                            ApplicationArea = all;
                            CaptionClass = TopSPName[2];
                            ShowCaption = false;
                        }
                        label(label3)
                        {
                            ApplicationArea = all;
                            CaptionClass = TopSPName[3];
                            ShowCaption = false;
                        }
                        label(label4)
                        {
                            ApplicationArea = all;
                            CaptionClass = TopSPName[4];
                            ShowCaption = false;
                        }
                        label(label5)
                        {
                            ApplicationArea = all;
                            CaptionClass = TopSPName[5];
                            ShowCaption = false;

                        }
                    }
                    group(group2)
                    {
                        field(Control1000000004; SalesAmount[1])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(CustLedgerForm);
                                CustLedgerEntry.RESET;
                                CustLedgerEntry.SETRANGE("Salesperson Code", TopSP[1]);
                                CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                CustLedgerForm.SETTABLEVIEW(CustLedgerEntry);
                                CustLedgerForm.RUN;
                            end;
                        }
                        field(Control1000000005; SalesAmount[2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(CustLedgerForm);
                                CustLedgerEntry.RESET;
                                CustLedgerEntry.SETRANGE("Salesperson Code", TopSP[2]);
                                CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                CustLedgerForm.SETTABLEVIEW(CustLedgerEntry);
                                CustLedgerForm.RUN;
                            end;
                        }
                        field(Control1000000006; SalesAmount[3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(CustLedgerForm);
                                CustLedgerEntry.RESET;
                                CustLedgerEntry.SETRANGE("Salesperson Code", TopSP[3]);
                                CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                CustLedgerForm.SETTABLEVIEW(CustLedgerEntry);
                                CustLedgerForm.RUN;
                            end;
                        }
                        field(Control1000000007; SalesAmount[4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(CustLedgerForm);
                                CustLedgerEntry.RESET;
                                CustLedgerEntry.SETRANGE("Salesperson Code", TopSP[4]);
                                CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                CustLedgerForm.SETTABLEVIEW(CustLedgerEntry);
                                CustLedgerForm.RUN;
                            end;
                        }
                        field(Control1000000008; SalesAmount[5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(CustLedgerForm);
                                CustLedgerEntry.RESET;
                                CustLedgerEntry.SETRANGE("Salesperson Code", TopSP[5]);
                                CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                CustLedgerForm.SETTABLEVIEW(CustLedgerEntry);
                                CustLedgerForm.RUN;
                            end;
                        }
                    }
                }
                grid("Top 5 Customers of the Month")
                {
                    Caption = 'Top 5 Customers of the Month';
                    group(group3)
                    {
                        label(label11)
                        {
                            CaptionClass = TopCustName[1];
                            ShowCaption = false;
                        }
                        label(label12)
                        {
                            CaptionClass = TopCustName[2];
                            ShowCaption = false;
                        }
                        label(label13)
                        {
                            CaptionClass = TopCustName[3];
                            ShowCaption = false;
                        }
                        label(label14)
                        {
                            CaptionClass = TopCustName[4];
                            ShowCaption = false;
                        }
                        label(label15)
                        {
                            CaptionClass = TopCustName[5];
                            ShowCaption = false;
                        }
                    }
                    group(group4)
                    {
                        field(Control1000000009; SalesqtyAmount[1])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(CustLedgerForm);
                                CustLedgerEntry.RESET;
                                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                                CustLedgerEntry.SETRANGE("Customer No.", TopQtyCust[1]);
                                CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                CustLedgerForm.SETTABLEVIEW(CustLedgerEntry);
                                CustLedgerForm.RUN;
                            end;
                        }
                        field(Control10000000010; SalesqtyAmount[2])
                        {
                            ApplicationArea = all;

                            trigger OnDrillDown()
                            begin

                                CLEAR(CustLedgerForm);
                                CustLedgerEntry.RESET;
                                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                                CustLedgerEntry.SETRANGE("Customer No.", TopQtyCust[2]);
                                CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                CustLedgerForm.SETTABLEVIEW(CustLedgerEntry);
                                CustLedgerForm.RUN;
                            end;
                        }
                        field(Control10000000011; SalesqtyAmount[3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(CustLedgerForm);
                                CustLedgerEntry.RESET;
                                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                                CustLedgerEntry.SETRANGE("Customer No.", TopQtyCust[3]);
                                CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                CustLedgerForm.SETTABLEVIEW(CustLedgerEntry);
                                CustLedgerForm.RUN;
                            end;
                        }
                        field(Control10000000012; SalesqtyAmount[4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(CustLedgerForm);
                                CustLedgerEntry.RESET;
                                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                                CustLedgerEntry.SETRANGE("Customer No.", TopQtyCust[4]);
                                CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                CustLedgerForm.SETTABLEVIEW(CustLedgerEntry);
                                CustLedgerForm.RUN;
                            end;
                        }
                        field(Control10000000013; SalesqtyAmount[5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(CustLedgerForm);
                                CustLedgerEntry.RESET;
                                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                                CustLedgerEntry.SETRANGE("Customer No.", TopQtyCust[5]);
                                CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                CustLedgerForm.SETTABLEVIEW(CustLedgerEntry);
                                CustLedgerForm.RUN;
                            end;
                        }
                    }
                }
                grid("Top 5 Item Sales of the Month")
                {
                    Caption = 'Top 5 Item Sales of the Month';
                    group(group5)
                    {
                        label(label6)
                        {
                            ApplicationArea = all;
                            CaptionClass = TopItemName[1];
                            ShowCaption = false;
                        }
                        label(label7)
                        {
                            ApplicationArea = all;
                            CaptionClass = TopItemName[2];
                            ShowCaption = false;
                        }
                        label(label8)
                        {
                            ApplicationArea = all;
                            CaptionClass = TopItemName[3];
                            ShowCaption = false;
                        }
                        label(label9)
                        {
                            ApplicationArea = all;
                            CaptionClass = TopItemName[4];
                            ShowCaption = false;
                        }
                        label(label10)
                        {
                            ApplicationArea = all;
                            CaptionClass = TopItemName[5];
                            ShowCaption = false;
                        }
                    }
                    group(group6)
                    {
                        field(QtySold1; QtySold[1])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[1]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(QtySold2; QtySold[2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[2]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(QtySold3; QtySold[3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[3]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(QtySold4; QtySold[4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[4]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(QtySold5; QtySold[5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[5]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                    }
                    group(group7)
                    {
                        field(TotalItemValueSold1; TotalItemValueSold[1])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[1]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(TotalItemValueSold2; TotalItemValueSold[2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[2]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(TotalItemValueSold3; TotalItemValueSold[3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[3]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(TotalItemValueSold4; TotalItemValueSold[4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[4]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
                            end;
                        }
                        field(TotalItemValueSold5; TotalItemValueSold[5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                CLEAR(ItemLedgerEntryForm);
                                ItemLedgerEntry.RESET;
                                ItemLedgerEntry.SETRANGE("Item No.", TopItem[5]);
                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                                ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                                ItemLedgerEntryForm.SETTABLEVIEW(ItemLedgerEntry);
                                ItemLedgerEntryForm.RUN;
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

        StartDate := CALCDATE('-CM', TODAY);

        TopSalespersonCalc;
        TopSalesCustomerCalc;
        TopItemCalc;
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
        SalesPersonAmtGreater: Decimal;
        SPRec: Record 13;
        TotalSalesAmtSPwise: Decimal;
        CustLedg: Record 21;
        TopSP: array[5] of Code[10];
        SalesAmount: array[5] of Decimal;
        StartDate: Date;
        i: Integer;
        CustomerSalesQtyGreater: Integer;
        Customer: Record 18;
        TotalSalesQtyCustwise: Integer;
        CustLedgerEntry: Record 21;
        TopQtyCust: array[5] of Code[10];
        SalesqtyAmount: array[5] of Decimal;
        TopSPName: array[5] of Text[50];
        TopCustName: array[5] of Text[50];
        Item: Record "27";
        ItemLedgerEntry: Record 32;
        TotalItemQtySold: Decimal;
        TotalItemQtySalesGreater: Decimal;
        TopItem: array[5] of Code[10];
        TotalItemValueSold: array[5] of Decimal;
        QtySold: array[5] of Decimal;
        TopItemName: array[5] of Text[100];
        CustLedgerForm: Page 25;
        ItemLedgerEntryForm: Page 38;

    //  [Scope('Internal')]
    procedure TopSalespersonCalc()
    begin
        SalesPersonAmtGreater := 0;
        SPRec.RESET;
        IF SPRec.FINDSET THEN
            REPEAT
                TotalSalesAmtSPwise := 0;
                CustLedg.RESET;
                CustLedg.SETRANGE("Salesperson Code", SPRec.Code);
                CustLedg.SETRANGE("Posting Date", StartDate, TODAY);
                IF CustLedg.FINDSET THEN
                    REPEAT
                        TotalSalesAmtSPwise += CustLedg."Sales (LCY)";
                    UNTIL CustLedg.NEXT = 0;
                IF ABS(TotalSalesAmtSPwise) > SalesPersonAmtGreater THEN BEGIN
                    SalesPersonAmtGreater := ABS(TotalSalesAmtSPwise);
                    TopSP[1] := SPRec.Code;
                    TopSPName[1] := SPRec.Name;
                END
                ELSE
                    SalesPersonAmtGreater := SalesPersonAmtGreater;
            UNTIL SPRec.NEXT = 0;

        SalesPersonAmtGreater := 0;
        SPRec.RESET;
        SPRec.SETFILTER(SPRec.Code, '<>%1', TopSP[1]);
        IF SPRec.FINDSET THEN
            REPEAT
                TotalSalesAmtSPwise := 0;
                CustLedg.RESET;
                CustLedg.SETRANGE("Salesperson Code", SPRec.Code);
                CustLedg.SETRANGE("Posting Date", StartDate, TODAY);
                IF CustLedg.FINDSET THEN
                    REPEAT
                        TotalSalesAmtSPwise += CustLedg."Sales (LCY)";
                    UNTIL CustLedg.NEXT = 0;
                IF ABS(TotalSalesAmtSPwise) > SalesPersonAmtGreater THEN BEGIN
                    SalesPersonAmtGreater := ABS(TotalSalesAmtSPwise);
                    TopSP[2] := SPRec.Code;
                    TopSPName[2] := SPRec.Name;
                END
                ELSE
                    SalesPersonAmtGreater := SalesPersonAmtGreater;
            UNTIL SPRec.NEXT = 0;

        SalesPersonAmtGreater := 0;
        SPRec.RESET;
        SPRec.SETFILTER(SPRec.Code, '<>%1&<>%2', TopSP[1], TopSP[2]);
        IF SPRec.FINDSET THEN
            REPEAT
                TotalSalesAmtSPwise := 0;
                CustLedg.RESET;
                CustLedg.SETRANGE("Salesperson Code", SPRec.Code);
                CustLedg.SETRANGE("Posting Date", StartDate, TODAY);
                IF CustLedg.FINDSET THEN
                    REPEAT
                        TotalSalesAmtSPwise += CustLedg."Sales (LCY)";
                    UNTIL CustLedg.NEXT = 0;
                IF ABS(TotalSalesAmtSPwise) > SalesPersonAmtGreater THEN BEGIN
                    SalesPersonAmtGreater := ABS(TotalSalesAmtSPwise);
                    TopSP[3] := SPRec.Code;
                    TopSPName[3] := SPRec.Name;
                END
                ELSE
                    SalesPersonAmtGreater := SalesPersonAmtGreater;
            UNTIL SPRec.NEXT = 0;

        SalesPersonAmtGreater := 0;
        SPRec.RESET;
        SPRec.SETFILTER(SPRec.Code, '<>%1&<>%2&<>%3', TopSP[1], TopSP[2], TopSP[3]);
        IF SPRec.FINDSET THEN
            REPEAT
                TotalSalesAmtSPwise := 0;
                CustLedg.RESET;
                CustLedg.SETRANGE("Salesperson Code", SPRec.Code);
                CustLedg.SETRANGE("Posting Date", StartDate, TODAY);
                IF CustLedg.FINDSET THEN
                    REPEAT
                        TotalSalesAmtSPwise += CustLedg."Sales (LCY)";
                    UNTIL CustLedg.NEXT = 0;
                IF ABS(TotalSalesAmtSPwise) > SalesPersonAmtGreater THEN BEGIN
                    SalesPersonAmtGreater := ABS(TotalSalesAmtSPwise);
                    TopSP[4] := SPRec.Code;
                    TopSPName[4] := SPRec.Name;
                END
                ELSE
                    SalesPersonAmtGreater := SalesPersonAmtGreater;
            UNTIL SPRec.NEXT = 0;

        SalesPersonAmtGreater := 0;
        SPRec.RESET;
        SPRec.SETFILTER(SPRec.Code, '<>%1&<>%2&<>%3&<>%4', TopSP[1], TopSP[2], TopSP[3], TopSP[4]);
        IF SPRec.FINDSET THEN
            REPEAT
                TotalSalesAmtSPwise := 0;
                CustLedg.RESET;
                CustLedg.SETRANGE("Salesperson Code", SPRec.Code);
                CustLedg.SETRANGE("Posting Date", StartDate, TODAY);
                IF CustLedg.FINDSET THEN
                    REPEAT
                        TotalSalesAmtSPwise += CustLedg."Sales (LCY)";
                    UNTIL CustLedg.NEXT = 0;
                IF ABS(TotalSalesAmtSPwise) > SalesPersonAmtGreater THEN BEGIN
                    SalesPersonAmtGreater := ABS(TotalSalesAmtSPwise);
                    TopSP[5] := SPRec.Code;
                    TopSPName[5] := SPRec.Name;
                END
                ELSE
                    SalesPersonAmtGreater := SalesPersonAmtGreater;
            UNTIL SPRec.NEXT = 0;

        CLEAR(SalesAmount);
        i := 0;
        REPEAT
            i += 1;
            CustLedg.RESET;
            CustLedg.SETRANGE("Salesperson Code", TopSP[i]);
            CustLedg.SETRANGE("Posting Date", StartDate, TODAY);
            IF CustLedg.FINDSET THEN
                REPEAT
                    SalesAmount[i] += CustLedg."Sales (LCY)";
                UNTIL CustLedg.NEXT = 0;
        UNTIL i = 5;
    end;

    //  [Scope('Internal')]
    procedure TopSalesCustomerCalc()
    begin
        CustomerSalesQtyGreater := 0;
        Customer.RESET;
        IF Customer.FINDSET THEN
            REPEAT
                TotalSalesQtyCustwise := 0;
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                IF CustLedgerEntry.FINDSET THEN
                    TotalSalesQtyCustwise += CustLedgerEntry.COUNT;
                IF ABS(TotalSalesQtyCustwise) > CustomerSalesQtyGreater THEN BEGIN
                    CustomerSalesQtyGreater := ABS(TotalSalesQtyCustwise);
                    TopQtyCust[1] := Customer."No.";
                    TopCustName[1] := Customer.Name;
                END
                ELSE
                    CustomerSalesQtyGreater := CustomerSalesQtyGreater;
            UNTIL Customer.NEXT = 0;

        CustomerSalesQtyGreater := 0;
        Customer.RESET;
        Customer.SETFILTER(Customer."No.", '<>%1', TopQtyCust[1]);
        IF Customer.FINDSET THEN
            REPEAT
                TotalSalesQtyCustwise := 0;
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                IF CustLedgerEntry.FINDSET THEN
                    TotalSalesQtyCustwise += CustLedgerEntry.COUNT;
                IF ABS(TotalSalesQtyCustwise) > CustomerSalesQtyGreater THEN BEGIN
                    CustomerSalesQtyGreater := ABS(TotalSalesQtyCustwise);
                    TopQtyCust[2] := Customer."No.";
                    TopCustName[2] := Customer.Name;
                END
                ELSE
                    CustomerSalesQtyGreater := CustomerSalesQtyGreater;
            UNTIL Customer.NEXT = 0;

        CustomerSalesQtyGreater := 0;
        Customer.RESET;
        Customer.SETFILTER(Customer."No.", '<>%1&<>%2', TopQtyCust[1], TopQtyCust[2]);
        IF Customer.FINDSET THEN
            REPEAT
                TotalSalesQtyCustwise := 0;
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                IF CustLedgerEntry.FINDSET THEN
                    TotalSalesQtyCustwise += CustLedgerEntry.COUNT;
                IF ABS(TotalSalesQtyCustwise) > CustomerSalesQtyGreater THEN BEGIN
                    CustomerSalesQtyGreater := ABS(TotalSalesQtyCustwise);
                    TopQtyCust[3] := Customer."No.";
                    TopCustName[3] := Customer.Name;
                END
                ELSE
                    CustomerSalesQtyGreater := CustomerSalesQtyGreater;
            UNTIL Customer.NEXT = 0;

        CustomerSalesQtyGreater := 0;
        Customer.RESET;
        Customer.SETFILTER(Customer."No.", '<>%1&<>%2&<>%3', TopQtyCust[1], TopQtyCust[2], TopQtyCust[3]);
        IF Customer.FINDSET THEN
            REPEAT
                TotalSalesQtyCustwise := 0;
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                IF CustLedgerEntry.FINDSET THEN
                    TotalSalesQtyCustwise += CustLedgerEntry.COUNT;
                IF ABS(TotalSalesQtyCustwise) > CustomerSalesQtyGreater THEN BEGIN
                    CustomerSalesQtyGreater := ABS(TotalSalesQtyCustwise);
                    TopQtyCust[4] := Customer."No.";
                    TopCustName[4] := Customer.Name;
                END
                ELSE
                    CustomerSalesQtyGreater := CustomerSalesQtyGreater;
            UNTIL Customer.NEXT = 0;

        CustomerSalesQtyGreater := 0;
        Customer.RESET;
        Customer.SETFILTER(Customer."No.", '<>%1&<>%2&<>%3&<>%4', TopQtyCust[1], TopQtyCust[2], TopQtyCust[3], TopQtyCust[4]);
        IF Customer.FINDSET THEN
            REPEAT
                TotalSalesQtyCustwise := 0;
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                IF CustLedgerEntry.FINDSET THEN
                    TotalSalesQtyCustwise += CustLedgerEntry.COUNT;
                IF ABS(TotalSalesQtyCustwise) > CustomerSalesQtyGreater THEN BEGIN
                    CustomerSalesQtyGreater := ABS(TotalSalesQtyCustwise);
                    TopQtyCust[5] := Customer."No.";
                    TopCustName[5] := Customer.Name;
                END
                ELSE
                    CustomerSalesQtyGreater := CustomerSalesQtyGreater;
            UNTIL Customer.NEXT = 0;

        CLEAR(SalesqtyAmount);
        i := 0;
        REPEAT
            i += 1;
            CustLedgerEntry.RESET;
            CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
            CustLedgerEntry.SETRANGE("Customer No.", TopQtyCust[i]);
            CustLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
            IF CustLedgerEntry.FINDSET THEN
                REPEAT
                    SalesqtyAmount[i] += CustLedgerEntry."Sales (LCY)";
                UNTIL CustLedgerEntry.NEXT = 0;
        UNTIL i = 5;
    end;

    // [Scope('Internal')]
    procedure TopItemCalc()
    begin
        TotalItemQtySalesGreater := 0;
        Item.RESET;
        IF Item.FINDSET THEN
            REPEAT
                TotalItemQtySold := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalItemQtySold += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                IF ABS(TotalItemQtySold) > TotalItemQtySalesGreater THEN BEGIN
                    TotalItemQtySalesGreater := ABS(TotalItemQtySold);
                    TopItem[1] := Item."No.";
                    TopItemName[1] := Item.Description;
                END
                ELSE
                    TotalItemQtySalesGreater := TotalItemQtySalesGreater;
            UNTIL Item.NEXT = 0;

        TotalItemQtySalesGreater := 0;
        Item.RESET;
        Item.SETFILTER(Item."No.", '<>%1', TopItem[1]);
        IF Item.FINDSET THEN
            REPEAT
                TotalItemQtySold := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalItemQtySold += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                IF ABS(TotalItemQtySold) > TotalItemQtySalesGreater THEN BEGIN
                    TotalItemQtySalesGreater := ABS(TotalItemQtySold);
                    TopItem[2] := Item."No.";
                    TopItemName[2] := Item.Description;
                END
                ELSE
                    TotalItemQtySalesGreater := TotalItemQtySalesGreater;
            UNTIL Item.NEXT = 0;

        TotalItemQtySalesGreater := 0;
        Item.RESET;
        Item.SETFILTER(Item."No.", '<>%1&<>%2', TopItem[1], TopItem[2]);
        IF Item.FINDSET THEN
            REPEAT
                TotalItemQtySold := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalItemQtySold += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                IF ABS(TotalItemQtySold) > TotalItemQtySalesGreater THEN BEGIN
                    TotalItemQtySalesGreater := ABS(TotalItemQtySold);
                    TopItem[3] := Item."No.";
                    TopItemName[3] := Item.Description;
                END
                ELSE
                    TotalItemQtySalesGreater := TotalItemQtySalesGreater;
            UNTIL Item.NEXT = 0;

        TotalItemQtySalesGreater := 0;
        Item.RESET;
        Item.SETFILTER(Item."No.", '<>%1&<>%2&<>%3', TopItem[1], TopItem[2], TopItem[3]);
        IF Item.FINDSET THEN
            REPEAT
                TotalItemQtySold := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalItemQtySold += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                IF ABS(TotalItemQtySold) > TotalItemQtySalesGreater THEN BEGIN
                    TotalItemQtySalesGreater := ABS(TotalItemQtySold);
                    TopItem[4] := Item."No.";
                    TopItemName[4] := Item.Description;
                END
                ELSE
                    TotalItemQtySalesGreater := TotalItemQtySalesGreater;
            UNTIL Item.NEXT = 0;

        TotalItemQtySalesGreater := 0;
        Item.RESET;
        Item.SETFILTER(Item."No.", '<>%1&<>%2&<>%3&<>%4', TopItem[1], TopItem[2], TopItem[3], TopItem[4]);
        IF Item.FINDSET THEN
            REPEAT
                TotalItemQtySold := 0;
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalItemQtySold += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                IF ABS(TotalItemQtySold) > TotalItemQtySalesGreater THEN BEGIN
                    TotalItemQtySalesGreater := ABS(TotalItemQtySold);
                    TopItem[5] := Item."No.";
                    TopItemName[5] := Item.Description;
                END
                ELSE
                    TotalItemQtySalesGreater := TotalItemQtySalesGreater;
            UNTIL Item.NEXT = 0;

        CLEAR(TotalItemValueSold);
        CLEAR(QtySold);
        i := 0;
        REPEAT
            i += 1;
            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETRANGE("Item No.", TopItem[i]);
            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
            ItemLedgerEntry.SETRANGE("Posting Date", StartDate, TODAY);
            IF ItemLedgerEntry.FINDSET THEN
                REPEAT
                    QtySold[i] += ItemLedgerEntry.Quantity;
                    ItemLedgerEntry.CALCFIELDS("Sales Amount (Expected)", "Sales Amount (Actual)");
                    TotalItemValueSold[i] += ItemLedgerEntry."Sales Amount (Expected)" + ItemLedgerEntry."Sales Amount (Actual)";
                UNTIL ItemLedgerEntry.NEXT = 0;
        UNTIL i = 5;
    end;
}

