page 60100 "Sales Dashboard"
{
    Editable = false;
    PageType = Card;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group("SALES DASHBOARD")
            {
                Caption = 'SALES DASHBOARD';
                grid("Sales Orders Status")
                {
                    Caption = 'Sales Orders Status';
                    group(group1)
                    {
                        label("Open Sales Orders - Number")
                        {
                            ApplicationArea = all;
                            Caption = 'Open Sales Orders - Number';
                            ShowCaption = false;
                        }
                        label("Open Sales Order - Value")
                        {
                            ApplicationArea = all;
                            Caption = 'Open Sales Order - Value';
                            ShowCaption = false;
                        }
                        label("Sales Order Ready to Ship - Number")
                        {
                            ApplicationArea = all;
                            Caption = 'Sales Order Ready to Ship - Number';
                            ShowCaption = false;
                        }
                        label("Sales Order Ready to Ship - Value")
                        {
                            ApplicationArea = all;
                            Caption = 'Sales Order Ready to Ship - Value';
                            ShowCaption = false;
                        }
                        label("Orders Delivered Not Invoiced - Number")
                        {
                            ApplicationArea = all;
                            Caption = 'Orders Delivered Not Invoiced - Number';
                            ShowCaption = false;
                        }
                        label("Orders Delivered Not Invoiced - Value")
                        {
                            ApplicationArea = all;
                            Caption = 'Orders Delivered Not Invoiced - Value';
                            ShowCaption = false;
                        }
                        label("Delayed Orders - Number")
                        {
                            ApplicationArea = all;
                            Caption = 'Delayed Orders - Number';
                            ShowCaption = false;
                        }
                        label("Delayed Orders - Value")
                        {
                            ApplicationArea = all;
                            Caption = 'Delayed Orders - Value';
                            ShowCaption = false;
                        }
                        label("Partially Shipped Orders - Number")
                        {
                            ApplicationArea = all;
                            Caption = 'Partially Shipped Orders - Number';
                            ShowCaption = false;
                        }
                        label("Partially Shipped Orders - Value")
                        {
                            ApplicationArea = all;
                            Caption = 'Partially Shipped Orders - Value';
                            ShowCaption = false;
                        }
                    }
                    group(group6)
                    {
                        field(OpenNumbr; OpenNumbr)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                SalesHeader1.CLEARMARKS;
                                SalesLine1.RESET;
                                SalesLine1.SETFILTER(SalesLine1."Qty. to Ship", '>%1', 0);
                                IF SalesLine1.FINDSET THEN
                                    REPEAT
                                        SalesHeader1.GET(SalesLine1."Document Type", SalesLine1."Document No.");
                                        IF SalesHeader1.Status = SalesHeader1.Status::Open THEN
                                            SalesHeader1.MARK(TRUE);
                                    UNTIL SalesLine1.NEXT = 0;
                                SalesHeader1.MARKEDONLY(TRUE);

                                PAGE.RUN(45, SalesHeader1);
                            end;
                        }
                        field(OpenValue; OpenValue)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                SalesHeader1.CLEARMARKS;
                                SalesLine1.RESET;
                                SalesLine1.SETFILTER(SalesLine1."Qty. to Ship", '>%1', 0);
                                IF SalesLine1.FINDSET THEN
                                    REPEAT
                                        SalesHeader1.GET(SalesLine1."Document Type", SalesLine1."Document No.");
                                        IF SalesHeader1.Status = SalesHeader1.Status::Open THEN
                                            SalesHeader1.MARK(TRUE);
                                    UNTIL SalesLine1.NEXT = 0;
                                SalesHeader1.MARKEDONLY(TRUE);

                                PAGE.RUN(45, SalesHeader1);
                            end;
                        }
                        field(ReadytoShipNmbr; ReadytoShipNmbr)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                SalesHeader2.CLEARMARKS;
                                SalesLine2.RESET;
                                SalesLine2.SETFILTER(SalesLine2."Qty. to Ship", '>%1', 0);
                                IF SalesLine2.FINDSET THEN
                                    REPEAT
                                        SalesHeader2.GET(SalesLine2."Document Type", SalesLine2."Document No.");
                                        IF SalesHeader2.Status = SalesHeader2.Status::Released THEN BEGIN
                                            SalesHeader2.MARK(TRUE);
                                        END;
                                    UNTIL SalesLine2.NEXT = 0;
                                SalesHeader2.MARKEDONLY(TRUE);

                                PAGE.RUN(45, SalesHeader2);
                            end;
                        }
                        field(ReadytoShipVal; ReadytoShipVal)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                SalesHeader2.CLEARMARKS;
                                SalesLine2.RESET;
                                SalesLine2.SETFILTER(SalesLine2."Qty. to Ship", '>%1', 0);
                                IF SalesLine2.FINDSET THEN
                                    REPEAT
                                        SalesHeader2.GET(SalesLine2."Document Type", SalesLine2."Document No.");
                                        IF SalesHeader2.Status = SalesHeader2.Status::Released THEN BEGIN
                                            SalesHeader2.MARK(TRUE);
                                        END;
                                    UNTIL SalesLine2.NEXT = 0;
                                SalesHeader2.MARKEDONLY(TRUE);

                                PAGE.RUN(45, SalesHeader2);
                            end;
                        }
                        field(DelNOTinvNmbr; DelNOTinvNmbr)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                SalesHeader3.CLEARMARKS;
                                SalesLine3.RESET;
                                SalesLine3.SETFILTER(SalesLine3."Quantity Shipped", '>%1', 0);
                                IF SalesLine3.FINDSET THEN
                                    REPEAT
                                        SalesHeader3.GET(SalesLine3."Document Type", SalesLine3."Document No.");
                                        IF SalesHeader3.Status = SalesHeader3.Status::Released THEN BEGIN
                                            IF SalesLine3."Qty. to Invoice" > SalesLine3."Qty. to Ship" THEN BEGIN
                                                SalesHeader3.MARK(TRUE);
                                            END;
                                        END;
                                    UNTIL SalesLine3.NEXT = 0;
                                SalesHeader3.MARKEDONLY(TRUE);

                                PAGE.RUN(45, SalesHeader3);
                            end;
                        }
                        field(DelNOTinvVal; DelNOTinvVal)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                SalesHeader3.CLEARMARKS;
                                SalesLine3.RESET;
                                SalesLine3.SETFILTER(SalesLine3."Quantity Shipped", '>%1', 0);
                                IF SalesLine3.FINDSET THEN
                                    REPEAT
                                        SalesHeader3.GET(SalesLine3."Document Type", SalesLine3."Document No.");
                                        IF SalesHeader3.Status = SalesHeader3.Status::Released THEN BEGIN
                                            IF SalesLine3."Qty. to Invoice" > SalesLine3."Qty. to Ship" THEN BEGIN
                                                SalesHeader3.MARK(TRUE);
                                            END;
                                        END;
                                    UNTIL SalesLine3.NEXT = 0;
                                SalesHeader3.MARKEDONLY(TRUE);

                                PAGE.RUN(45, SalesHeader3);
                            end;
                        }
                        field(DelayedOrdNmbr; DelayedOrdNmbr)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                SalesHeader4.CLEARMARKS;
                                SalesLine4.RESET;
                                SalesLine4.SETFILTER(SalesLine4."Qty. to Ship", '>%1', 0);
                                IF SalesLine4.FINDSET THEN
                                    REPEAT
                                        SalesHeader4.GET(SalesLine4."Document Type", SalesLine4."Document No.");
                                        SalesHeader4.SETFILTER(SalesHeader4."Shipment Date", '<%1', TODAY);
                                        IF SalesHeader4.FINDSET THEN BEGIN
                                            IF SalesHeader4.Status = SalesHeader4.Status::Released THEN BEGIN
                                                SalesHeader4.MARK(TRUE);
                                            END;
                                        END;
                                    UNTIL SalesLine4.NEXT = 0;
                                SalesHeader4.MARKEDONLY(TRUE);

                                PAGE.RUN(45, SalesHeader4);
                            end;
                        }
                        field(DelayedOrdVal; DelayedOrdVal)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                SalesHeader4.CLEARMARKS;
                                SalesLine4.RESET;
                                SalesLine4.SETFILTER(SalesLine4."Qty. to Ship", '>%1', 0);
                                IF SalesLine4.FINDSET THEN
                                    REPEAT
                                        SalesHeader4.GET(SalesLine4."Document Type", SalesLine4."Document No.");
                                        SalesHeader4.SETFILTER(SalesHeader4."Shipment Date", '<%1', TODAY);
                                        IF SalesHeader4.FINDSET THEN BEGIN
                                            IF SalesHeader4.Status = SalesHeader4.Status::Released THEN BEGIN
                                                SalesHeader4.MARK(TRUE);
                                            END;
                                        END;
                                    UNTIL SalesLine4.NEXT = 0;
                                SalesHeader4.MARKEDONLY(TRUE);

                                PAGE.RUN(45, SalesHeader4);
                            end;
                        }
                        field(PartShpNmbr; PartShpNmbr)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                SalesHeader5.CLEARMARKS;
                                SalesLine5.RESET;
                                SalesLine5.SETFILTER(SalesLine5."Quantity Shipped", '>%1', 0);
                                IF SalesLine5.FINDSET THEN
                                    REPEAT
                                        IF SalesLine5."Qty. to Ship" < SalesLine5.Quantity THEN BEGIN
                                            SalesHeader5.GET(SalesLine5."Document Type", SalesLine5."Document No.");
                                            IF SalesHeader5.Status = SalesHeader5.Status::Released THEN BEGIN
                                                SalesHeader5.MARK(TRUE);
                                            END;
                                        END;
                                    UNTIL SalesLine5.NEXT = 0;
                                SalesHeader5.MARKEDONLY(TRUE);

                                PAGE.RUN(45, SalesHeader5);
                            end;
                        }
                        field(PartShpValue; PartShpValue)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                SalesHeader5.CLEARMARKS;
                                SalesLine5.RESET;
                                SalesLine5.SETFILTER(SalesLine5."Quantity Shipped", '>%1', 0);
                                IF SalesLine5.FINDSET THEN
                                    REPEAT
                                        IF SalesLine5."Qty. to Ship" < SalesLine5.Quantity THEN BEGIN
                                            SalesHeader5.GET(SalesLine5."Document Type", SalesLine5."Document No.");
                                            IF SalesHeader5.Status = SalesHeader5.Status::Released THEN BEGIN
                                                SalesHeader5.MARK(TRUE);
                                            END;
                                        END;
                                    UNTIL SalesLine5.NEXT = 0;
                                SalesHeader5.MARKEDONLY(TRUE);

                                PAGE.RUN(45, SalesHeader5);
                            end;
                        }
                    }
                }
                grid("Current Month Orders Details")
                {
                    Caption = 'Current Month Orders Details';
                    group(group5)
                    {
                        label("Sales Orders - Number (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Sales Orders - Number (CM)';
                            ShowCaption = false;
                        }
                        label("Sales Orders -  Value (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Sales Orders -  Value (CM)';
                            ShowCaption = false;
                        }
                        label("Sales Shipments - Number (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Sales Shipments - Number (CM)';
                            ShowCaption = false;
                        }
                        label("Sales Shipments - Value (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Sales Shipments - Value (CM)';
                            ShowCaption = false;
                        }
                        label("Sales Invoices - Number (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Sales Invoices - Number (CM)';
                            ShowCaption = false;
                        }
                        label("Sales Invoices - Value (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Sales Invoices - Value (CM)';
                            ShowCaption = false;
                        }
                        label("Sales Return Order - Number (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Sales Return Order - Number (CM)';
                            ShowCaption = false;
                        }
                        label("Sales Return Order - Value (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Sales Return Order - Value (CM)';
                            ShowCaption = false;
                        }
                    }
                    group(group4)
                    {
                        field(SONmbr; SONmbr)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                SalesHeader.RESET;
                                SalesHeader.SETRANGE(SalesHeader."Document Type", SalesHeader."Document Type"::Order);
                                SalesHeader.SETRANGE(SalesHeader."Order Date", StartDate, TODAY);
                                IF SalesHeader.FINDSET THEN
                                    REPEAT
                                        SalesLine.RESET;
                                        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                                        IF SalesLine.FINDSET THEN;
                                    UNTIL SalesHeader.NEXT = 0;

                                PAGE.RUN(45, SalesHeader);
                            end;
                        }
                        field(SOValue; SOValue)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                SalesHeader.RESET;
                                SalesHeader.SETRANGE(SalesHeader."Document Type", SalesHeader."Document Type"::Order);
                                SalesHeader.SETRANGE(SalesHeader."Order Date", StartDate, TODAY);
                                IF SalesHeader.FINDSET THEN
                                    REPEAT
                                        SalesLine.RESET;
                                        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                                        IF SalesLine.FINDSET THEN;
                                    UNTIL SalesHeader.NEXT = 0;

                                PAGE.RUN(45, SalesHeader);
                            end;
                        }
                        field(ShpNmbr; ShpNmbr)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                PstdSalesShpHdr.RESET;
                                PstdSalesShpHdr.SETRANGE("Order Date", StartDate, TODAY);
                                IF PstdSalesShpHdr.FINDSET THEN
                                    REPEAT
                                        PstedSalesShpLine.RESET;
                                        PstedSalesShpLine.SETRANGE("Document No.", PstdSalesShpHdr."No.");
                                        IF PstedSalesShpLine.FINDSET THEN;
                                    UNTIL PstdSalesShpHdr.NEXT = 0;

                                PAGE.RUN(142, PstdSalesShpHdr);
                            end;
                        }
                        field(ShpValue; ShpValue)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                PstdSalesShpHdr.RESET;
                                PstdSalesShpHdr.SETRANGE("Order Date", StartDate, TODAY);
                                IF PstdSalesShpHdr.FINDSET THEN
                                    REPEAT
                                        PstedSalesShpLine.RESET;
                                        PstedSalesShpLine.SETRANGE("Document No.", PstdSalesShpHdr."No.");
                                        IF PstedSalesShpLine.FINDSET THEN;
                                    UNTIL PstdSalesShpHdr.NEXT = 0;

                                PAGE.RUN(142, PstdSalesShpHdr);
                            end;
                        }
                        field(PstdSONmbr; PstdSONmbr)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                SalesInvHeader.RESET;
                                SalesInvHeader.SETRANGE("Order Date", StartDate, TODAY);
                                IF SalesInvHeader.FINDSET THEN
                                    REPEAT
                                        SalesInvLine.RESET;
                                        SalesInvLine.SETRANGE("Document No.", SalesInvHeader."No.");
                                        IF SalesInvLine.FINDSET THEN;
                                    UNTIL SalesInvHeader.NEXT = 0;

                                PAGE.RUN(143, SalesInvHeader);
                            end;
                        }
                        field(PstdSOValue; PstdSOValue)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                SalesInvHeader.RESET;
                                SalesInvHeader.SETRANGE("Order Date", StartDate, TODAY);
                                IF SalesInvHeader.FINDSET THEN
                                    REPEAT
                                        SalesInvLine.RESET;
                                        SalesInvLine.SETRANGE("Document No.", SalesInvHeader."No.");
                                        IF SalesInvLine.FINDSET THEN;
                                    UNTIL SalesInvHeader.NEXT = 0;

                                PAGE.RUN(143, SalesInvHeader);
                            end;
                        }
                        field(RetrnOrdrNmbr; RetrnOrdrNmbr)
                        {
                            ApplicationArea = all;

                            trigger OnDrillDown()
                            begin

                                RetrnOrdrHeader.RESET;
                                RetrnOrdrHeader.SETRANGE("Order Date", StartDate, TODAY);
                                IF RetrnOrdrHeader.FINDSET THEN
                                    REPEAT
                                        RetrnOrdrLine.RESET;
                                        RetrnOrdrLine.SETRANGE("Document No.", RetrnOrdrHeader."No.");
                                        IF RetrnOrdrLine.FINDSET THEN;
                                    UNTIL RetrnOrdrHeader.NEXT = 0;

                                PAGE.RUN(6662, RetrnOrdrHeader);
                            end;
                        }
                        field(RetrnOrdrValue; RetrnOrdrValue)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                RetrnOrdrHeader.RESET;
                                RetrnOrdrHeader.SETRANGE("Order Date", StartDate, TODAY);
                                IF RetrnOrdrHeader.FINDSET THEN
                                    REPEAT
                                        RetrnOrdrLine.RESET;
                                        RetrnOrdrLine.SETRANGE("Document No.", RetrnOrdrHeader."No.");
                                        IF RetrnOrdrLine.FINDSET THEN;
                                    UNTIL RetrnOrdrHeader.NEXT = 0;

                                PAGE.RUN(6662, RetrnOrdrHeader);
                            end;
                        }
                    }
                }
                grid(Totals)
                {
                    Caption = 'Totals';
                    group(group3)
                    {
                        label("Total Sales (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Total Sales (CM)';
                            ShowCaption = false;
                        }
                        label("Total COGS (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Total COGS (CM)';
                            ShowCaption = false;
                        }
                        label("Total Gross Profit (CM)")
                        {
                            ApplicationArea = all;
                            Caption = 'Total Gross Profit (CM)';
                            ShowCaption = false;
                        }
                        label("Total Gross Profit %")
                        {
                            ApplicationArea = all;
                            Caption = 'Total Gross Profit %';
                            ShowCaption = false;
                        }
                    }
                    group(group2)
                    {
                        field(TotSales; TotSales)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                ValEntry.RESET;
                                ValEntry.SETRANGE(ValEntry."Item Ledger Entry Type", ValEntry."Item Ledger Entry Type"::Sale);
                                ValEntry.SETRANGE(ValEntry."Posting Date", StartDate, TODAY);
                                IF ValEntry.FINDSET THEN;

                                PAGE.RUN(5802, ValEntry);
                            end;
                        }
                        field(Control1000000031; ABS(TotCOGS))
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin
                                ValEntry.RESET;
                                ValEntry.SETRANGE(ValEntry."Item Ledger Entry Type", ValEntry."Item Ledger Entry Type"::Sale);
                                ValEntry.SETRANGE(ValEntry."Posting Date", StartDate, TODAY);
                                IF ValEntry.FINDSET THEN;

                                PAGE.RUN(5802, ValEntry);
                            end;
                        }
                        field(TotGrossProf; TotGrossProf)
                        {
                            ApplicationArea = all;
                        }
                        field("TotGrossProf%"; "TotGrossProf%")
                        {
                            ApplicationArea = all;
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
        //MESSAGE('%1',StartDate);


        OpenNumbr := 0;
        OpenValue := 0;
        SalesHeader.CLEARMARKS;
        SalesLine.RESET;
        SalesLine.SETFILTER(SalesLine."Qty. to Ship", '>%1', 0);
        IF SalesLine.FINDSET THEN
            REPEAT
                SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
                IF SalesHeader.Status = SalesHeader.Status::Open THEN BEGIN
                    OpenValue += SalesLine."Qty. to Ship" * SalesLine."Unit Price";
                    SalesHeader.MARK(TRUE);
                END;
            UNTIL SalesLine.NEXT = 0;
        SalesHeader.MARKEDONLY(TRUE);
        OpenNumbr := SalesHeader.COUNT;


        ReadytoShipNmbr := 0;
        ReadytoShipVal := 0;
        SalesHeader.CLEARMARKS;
        SalesLine.RESET;
        SalesLine.SETFILTER(SalesLine."Qty. to Ship", '>%1', 0);
        IF SalesLine.FINDSET THEN
            REPEAT
                SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
                IF SalesHeader.Status = SalesHeader.Status::Released THEN BEGIN
                    ReadytoShipVal += SalesLine."Qty. to Ship" * SalesLine."Unit Price";
                    SalesHeader.MARK(TRUE);
                END;
            UNTIL SalesLine.NEXT = 0;
        SalesHeader.MARKEDONLY(TRUE);
        ReadytoShipNmbr := SalesHeader.COUNT;



        DelNOTinvNmbr := 0;
        DelNOTinvVal := 0;
        SalesHeader.CLEARMARKS;
        SalesLine.RESET;
        SalesLine.SETFILTER(SalesLine."Quantity Shipped", '>%1', 0);
        IF SalesLine.FINDSET THEN
            REPEAT
                SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
                IF SalesHeader.Status = SalesHeader.Status::Released THEN BEGIN
                    IF SalesLine."Qty. to Invoice" > SalesLine."Qty. to Ship" THEN BEGIN
                        DelNOTinvVal += SalesLine."Qty. Shipped Not Invoiced";
                        SalesHeader.MARK(TRUE);
                    END;
                END;
            UNTIL SalesLine.NEXT = 0;
        SalesHeader.MARKEDONLY(TRUE);
        DelNOTinvNmbr := SalesHeader.COUNT;


        DelayedOrdNmbr := 0;
        DelayedOrdVal := 0;
        SalesHeader.CLEARMARKS;
        SalesLine.RESET;
        SalesLine.SETFILTER(SalesLine."Qty. to Ship", '>%1', 0);
        IF SalesLine.FINDSET THEN
            REPEAT
                SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
                SalesHeader.SETFILTER(SalesHeader."Shipment Date", '<%1', TODAY);
                IF SalesHeader.FINDSET THEN BEGIN
                    IF SalesHeader.Status = SalesHeader.Status::Released THEN BEGIN
                        DelayedOrdVal += (SalesLine."Qty. to Invoice" * SalesLine."Unit Price");
                        SalesHeader.MARK(TRUE);
                    END;
                END;
            UNTIL SalesLine.NEXT = 0;
        SalesHeader.MARKEDONLY(TRUE);
        DelayedOrdNmbr := SalesHeader.COUNT;


        PartShpNmbr := 0;
        PartShpValue := 0;
        SalesHeader.CLEARMARKS;
        SalesLine.RESET;
        SalesLine.SETFILTER(SalesLine."Quantity Shipped", '>%1', 0);
        IF SalesLine.FINDSET THEN
            REPEAT
                IF SalesLine."Qty. to Ship" < SalesLine.Quantity THEN BEGIN
                    SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
                    IF SalesHeader.Status = SalesHeader.Status::Released THEN BEGIN
                        PartShpValue += (SalesLine."Qty. to Invoice" * SalesLine."Unit Price");
                        SalesHeader.MARK(TRUE);
                    END;
                END;
            UNTIL SalesLine.NEXT = 0;
        SalesHeader.MARKEDONLY(TRUE);
        PartShpNmbr := SalesHeader.COUNT;


        SONmbr := 0;
        SOValue := 0;
        SalesHeader.RESET;
        SalesHeader.SETRANGE(SalesHeader."Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETRANGE(SalesHeader."Order Date", StartDate, TODAY);
        IF SalesHeader.FINDSET THEN BEGIN
            SONmbr := SalesHeader.COUNT;
            REPEAT
                SalesLine.RESET;
                SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                IF SalesLine.FINDSET THEN
                    REPEAT
                    //SOValue += SalesLine."Amount To Customer";
                    UNTIL SalesLine.NEXT = 0;
            UNTIL SalesHeader.NEXT = 0;
        END;


        ShpNmbr := 0;
        ShpValue := 0;
        PstdSalesShpHdr.RESET;
        PstdSalesShpHdr.SETRANGE("Order Date", StartDate, TODAY);
        IF PstdSalesShpHdr.FINDSET THEN BEGIN
            ShpNmbr := PstdSalesShpHdr.COUNT;
            REPEAT
                PstedSalesShpLine.RESET;
                PstedSalesShpLine.SETRANGE("Document No.", PstdSalesShpHdr."No.");
                IF PstedSalesShpLine.FINDSET THEN
                    REPEAT
                        ShpValue += (PstedSalesShpLine."Unit Price" * PstedSalesShpLine.Quantity);
                    UNTIL PstedSalesShpLine.NEXT = 0;
            UNTIL PstdSalesShpHdr.NEXT = 0;
        END;


        PstdSONmbr := 0;
        PstdSOValue := 0;
        SalesInvHeader.RESET;
        SalesInvHeader.SETRANGE("Order Date", StartDate, TODAY);
        IF SalesInvHeader.FINDSET THEN BEGIN
            PstdSONmbr := SalesInvHeader.COUNT;
            REPEAT
                SalesInvLine.RESET;
                SalesInvLine.SETRANGE("Document No.", SalesInvHeader."No.");
                IF SalesInvLine.FINDSET THEN
                    REPEAT
                    //PstdSOValue += SalesInvLine."Amount To Customer";
                    UNTIL SalesInvLine.NEXT = 0;
            UNTIL SalesInvHeader.NEXT = 0;
        END;

        RetrnOrdrValue := 0;
        RetrnOrdrNmbr := 0;
        RetrnOrdrHeader.RESET;
        RetrnOrdrHeader.SETRANGE("Order Date", StartDate, TODAY);
        IF RetrnOrdrHeader.FINDSET THEN
            REPEAT
                RetrnOrdrNmbr += 1;
                RetrnOrdrLine.RESET;
                RetrnOrdrLine.SETRANGE("Document No.", RetrnOrdrHeader."No.");
                IF RetrnOrdrLine.FINDSET THEN
                    REPEAT
                        RetrnOrdrValue += (RetrnOrdrLine.Quantity * RetrnOrdrLine."Unit Price");
                    UNTIL RetrnOrdrLine.NEXT = 0;
            UNTIL RetrnOrdrHeader.NEXT = 0;



        TotSales := 0;
        TotCOGS := 0;
        TotCOGAct := 0;
        TotCOGexp := 0;
        TotGrossProf := 0;
        "TotGrossProf%" := 0;
        ValEntry.RESET;
        ValEntry.SETRANGE(ValEntry."Item Ledger Entry Type", ValEntry."Item Ledger Entry Type"::Sale);
        ValEntry.SETRANGE(ValEntry."Posting Date", StartDate, TODAY);
        IF ValEntry.FINDSET THEN BEGIN
            REPEAT
                TotSales += ValEntry."Sales Amount (Actual)";
                TotCOGAct += ValEntry."Cost Amount (Actual)";
                TotCOGexp += ValEntry."Cost Amount (Expected)";
            UNTIL ValEntry.NEXT = 0;
            TotCOGS := TotCOGAct + TotCOGexp;
        END;

        TotGrossProf := TotSales + TotCOGS;

        IF TotSales <> 0 THEN
            "TotGrossProf%" := (TotGrossProf / TotSales) * 100;
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
        SalesHeader: Record 36;
        SalesHeader1: Record 36;
        SalesLine: Record 37;
        SalesLine1: Record 37;
        SalesHeader2: Record 36;
        SalesLine2: Record 37;
        SalesHeader3: Record 36;
        SalesLine3: Record 37;
        SalesHeader4: Record 36;
        SalesLine4: Record 37;
        SalesHeader5: Record 36;
        SalesLine5: Record 37;
        SalesInvHeader: Record 112;
        SalesInvLine: Record 113;
        CustRec: Record 18;
        CustLedg: Record 21;
        ValEntry: Record 5802;
        PstdSalesShpHdr: Record 110;
        PstedSalesShpLine: Record 111;
        RetrnOrdrHeader: Record 6660;
        RetrnOrdrLine: Record 6661;
        RetrnOrdrNmbr: Integer;
        RetrnOrdrValue: Decimal;
        ShpdNOTInv: Integer;
        OpenNumbr: Integer;
        OpenValue: Decimal;
        ReadytoShipNmbr: Integer;
        ReadytoShipVal: Decimal;
        DelNOTinvNmbr: Integer;
        DelNOTinvVal: Decimal;
        DelayedOrdNmbr: Integer;
        DelayedOrdVal: Decimal;
        PartShpNmbr: Integer;
        PartShpValue: Decimal;
        StartDate: Date;
        SONmbr: Integer;
        SOValue: Decimal;
        ShpNmbr: Integer;
        ShpValue: Decimal;
        PstdSONmbr: Integer;
        PstdSOValue: Decimal;
        TotSales: Decimal;
        TotCOGS: Decimal;
        TotCOGAct: Decimal;
        TotCOGexp: Decimal;
        TotGrossProf: Decimal;
        "TotGrossProf%": Decimal;
}

