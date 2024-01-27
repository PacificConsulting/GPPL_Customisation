page 50050 "Purchase Dashboard"
{
    Caption = 'Purchase Dashboard';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout

    {
        area(content)
        {
            group("PURCHASE DASHBOARD")
            {
                Caption = 'PURCHASE DASHBOARD';
                grid(Status)
                {
                    Caption = 'Status';
                    group(group1)
                    {
                        label("Open Purchase Orders - Number")
                        {
                            Caption = 'Open Purchase Orders - Number';
                            ShowCaption = false;
                        }
                        label("Open Purchase Orders - Value")
                        {
                            Caption = 'Open Purchase Orders - Value';
                            ShowCaption = false;
                        }
                        label("Purchase order ready to Recv - No.")
                        {
                            Caption = 'Purchase order ready to Recv - No.';
                            ShowCaption = false;
                        }
                        label("Purchase order ready to Recv - Value")
                        {
                            Caption = 'Purchase order ready to Recv - Value';
                            ShowCaption = false;
                        }
                        label("Order Received not Invoiced")
                        {
                            Caption = 'Order Received not Invoiced';
                            ShowCaption = false;
                        }
                        label("Order Received not Invoiced Value")
                        {
                            Caption = 'Order Received not Invoiced Value';
                            ShowCaption = false;
                        }
                        label("Delayed Orders - Number")
                        {
                            Caption = 'Delayed Orders - Number';
                            ShowCaption = false;
                        }
                        label("Delayed Orders - Value")
                        {
                            Caption = 'Delayed Orders - Value';
                            ShowCaption = false;
                        }
                        label("Partially Received Orders")
                        {
                            Caption = 'Partially Received Orders';
                            ShowCaption = false;
                        }
                        label("Partially Received Orders - Value")
                        {
                            Caption = 'Partially Received Orders - Value';
                            ShowCaption = false;
                        }
                    }
                    group(group2)
                    {
                        field(OpenPurchaseOrderNumber; OpenPurchaseOrderNumber)
                        {

                            trigger OnDrillDown()
                            begin
                                PurchaseOrder1.CLEARMARKS;
                                PurchaseOrder1.RESET;
                                PurchaseLine1.RESET;
                                PurchaseLine1.SETFILTER("Qty. to Receive", '>%1', 0);
                                IF PurchaseLine1.FINDSET THEN
                                    REPEAT
                                        PurchaseOrder1.GET(PurchaseLine1."Document Type", PurchaseLine1."Document No.");
                                        IF PurchaseOrder1.Status = PurchaseOrder1.Status::Open THEN
                                            PurchaseOrder1.MARK(TRUE);
                                    UNTIL PurchaseLine1.NEXT = 0;
                                PurchaseOrder1.MARKEDONLY(TRUE);
                                PAGE.RUN(53, PurchaseOrder1);
                            end;
                        }
                        field(OpenPurchaseOrderValue; OpenPurchaseOrderValue)
                        {

                            trigger OnDrillDown()
                            begin

                                PurchaseOrder1.CLEARMARKS;
                                PurchaseOrder1.RESET;
                                PurchaseLine1.RESET;
                                PurchaseLine1.SETFILTER("Qty. to Receive", '>%1', 0);
                                IF PurchaseLine1.FINDSET THEN
                                    REPEAT
                                        PurchaseOrder1.GET(PurchaseLine1."Document Type", PurchaseLine1."Document No.");
                                        IF PurchaseOrder1.Status = PurchaseOrder1.Status::Open THEN
                                            PurchaseOrder1.MARK(TRUE);
                                    UNTIL PurchaseLine1.NEXT = 0;
                                PurchaseOrder1.MARKEDONLY(TRUE);
                                PAGE.RUN(53, PurchaseOrder1);
                            end;
                        }
                        field(POOrderreadyToRecv; POOrderreadyToRecv)
                        {

                            trigger OnDrillDown()
                            begin

                                PurchaseOrder3.CLEARMARKS;
                                PurchaseOrder3.RESET;
                                PurchaseLine3.RESET;
                                PurchaseLine3.SETFILTER("Qty. to Receive", '>%1', 0);
                                IF PurchaseLine3.FINDSET THEN
                                    REPEAT
                                        PurchaseOrder3.GET(PurchaseLine3."Document Type", PurchaseLine3."Document No.");
                                        IF PurchaseOrder3.Status = PurchaseOrder3.Status::Released THEN
                                            PurchaseOrder3.MARK(TRUE);
                                    UNTIL PurchaseLine3.NEXT = 0;
                                PurchaseOrder3.MARKEDONLY(TRUE);
                                PAGE.RUN(53, PurchaseOrder3);
                            end;
                        }
                        field(POOrderreadyToRecvValue; POOrderreadyToRecvValue)
                        {

                            trigger OnDrillDown()
                            begin

                                PurchaseOrder2.CLEARMARKS;
                                PurchaseOrder2.RESET;
                                PurchaseLine2.RESET;
                                PurchaseLine2.SETFILTER("Qty. to Receive", '>%1', 0);
                                IF PurchaseLine2.FINDSET THEN
                                    REPEAT
                                        PurchaseOrder2.GET(PurchaseLine2."Document Type", PurchaseLine2."Document No.");
                                        IF PurchaseOrder2.Status = PurchaseOrder2.Status::Released THEN
                                            PurchaseOrder2.MARK(TRUE);
                                    UNTIL PurchaseLine2.NEXT = 0;
                                PurchaseOrder2.MARKEDONLY(TRUE);
                                PAGE.RUN(53, PurchaseOrder2);
                            end;
                        }
                        field(QtyRecvNotInvoiced; QtyRecvNotInvoiced)
                        {

                            trigger OnDrillDown()
                            begin

                                PurchaseOrder2.CLEARMARKS;
                                PurchaseOrder2.RESET;
                                PurchaseLine2.RESET;
                                PurchaseLine2.SETFILTER("Qty. Rcd. Not Invoiced", '>%1', 0);
                                IF PurchaseLine2.FINDSET THEN
                                    REPEAT
                                        IF PurchaseOrder2.GET(PurchaseLine2."Document Type", PurchaseLine2."Document No.") THEN
                                            PurchaseOrder2.MARK(TRUE);
                                    UNTIL PurchaseLine2.NEXT = 0;
                                PurchaseOrder2.MARKEDONLY(TRUE);
                                PAGE.RUN(53, PurchaseOrder2);
                            end;
                        }
                        field(QtyRecvNotInvoicedValue; QtyRecvNotInvoicedValue)
                        {

                            trigger OnDrillDown()
                            begin

                                PurchaseOrder2.CLEARMARKS;
                                PurchaseOrder2.RESET;
                                PurchaseLine2.RESET;
                                PurchaseLine2.SETFILTER("Qty. Rcd. Not Invoiced", '>%1', 0);
                                IF PurchaseLine2.FINDSET THEN
                                    REPEAT
                                        IF PurchaseOrder2.GET(PurchaseLine2."Document Type", PurchaseLine2."Document No.") THEN
                                            PurchaseOrder2.MARK(TRUE);
                                    UNTIL PurchaseLine2.NEXT = 0;
                                PurchaseOrder2.MARKEDONLY(TRUE);
                                PAGE.RUN(53, PurchaseOrder2);
                            end;
                        }
                        field(DelayedOrdersNumber; DelayedOrdersNumber)
                        {

                            trigger OnDrillDown()
                            begin

                                PurchaseOrder4.CLEARMARKS;
                                PurchaseOrder4.RESET;
                                PurchaseLine4.RESET;
                                PurchaseLine4.SETFILTER("Expected Receipt Date", '<%1', TODAY);
                                PurchaseLine4.SETFILTER("Qty. to Receive", '>%1', 0);
                                IF PurchaseLine4.FINDSET THEN
                                    REPEAT
                                        IF PurchaseOrder4.GET(PurchaseLine4."Document Type", PurchaseLine4."Document No.") THEN
                                            PurchaseOrder4.MARK(TRUE);
                                    UNTIL PurchaseLine4.NEXT = 0;
                                PurchaseOrder4.MARKEDONLY(TRUE);
                                PAGE.RUN(53, PurchaseOrder4);
                            end;
                        }
                        field(DelayedOrdersValue; DelayedOrdersValue)
                        {

                            trigger OnDrillDown()
                            begin

                                PurchaseOrder4.CLEARMARKS;
                                PurchaseOrder4.RESET;
                                PurchaseLine4.RESET;
                                PurchaseLine4.SETFILTER("Expected Receipt Date", '<%1', TODAY);
                                PurchaseLine4.SETFILTER("Qty. to Receive", '>%1', 0);
                                IF PurchaseLine4.FINDSET THEN
                                    REPEAT
                                        IF PurchaseOrder4.GET(PurchaseLine4."Document Type", PurchaseLine4."Document No.") THEN
                                            PurchaseOrder4.MARK(TRUE);
                                    UNTIL PurchaseLine4.NEXT = 0;
                                PurchaseOrder4.MARKEDONLY(TRUE);
                                PAGE.RUN(53, PurchaseOrder4);
                            end;
                        }
                        field(PartiallyReceived; PartiallyReceived)
                        {

                            trigger OnDrillDown()
                            begin

                                PurchaseOrder2.CLEARMARKS;
                                PurchaseOrder2.RESET;
                                PurchaseLine2.RESET;
                                PurchaseLine2.SETFILTER("Qty. to Receive", '>%1', 0);
                                PurchaseLine2.SETFILTER("Quantity Received", '>%1', 0);
                                IF PurchaseLine2.FINDSET THEN
                                    REPEAT
                                        IF PurchaseOrder2.GET(PurchaseLine2."Document Type", PurchaseLine2."Document No.") THEN
                                            PurchaseOrder2.MARK(TRUE);
                                    UNTIL PurchaseLine2.NEXT = 0;
                                PurchaseOrder2.MARKEDONLY(TRUE);
                                PAGE.RUN(53, PurchaseOrder2);
                            end;
                        }
                        field(PartiallyReceivedValue; PartiallyReceivedValue)
                        {

                            trigger OnDrillDown()
                            begin

                                PurchaseOrder2.CLEARMARKS;
                                PurchaseOrder2.RESET;
                                PurchaseLine2.RESET;
                                PurchaseLine2.SETFILTER("Qty. to Receive", '>%1', 0);
                                PurchaseLine2.SETFILTER("Quantity Received", '>%1', 0);
                                IF PurchaseLine2.FINDSET THEN
                                    REPEAT
                                        IF PurchaseOrder2.GET(PurchaseLine2."Document Type", PurchaseLine2."Document No.") THEN
                                            PurchaseOrder2.MARK(TRUE);
                                    UNTIL PurchaseLine2.NEXT = 0;
                                PurchaseOrder2.MARKEDONLY(TRUE);
                                PAGE.RUN(53, PurchaseOrder2);
                            end;
                        }
                    }
                }
                grid(Orders)
                {
                    Caption = 'Orders';
                    group(group3)
                    {
                        label("Purchase Orders - Number (CM)")
                        {
                            Caption = 'Purchase Orders - Number (CM)';
                            ShowCaption = false;
                        }
                        label("Purchase Orders - Value (CM)")
                        {
                            Caption = 'Purchase Orders - Value (CM)';
                            ShowCaption = false;
                        }
                        label("Purchase Receipt - Number (CM)")
                        {
                            Caption = 'Purchase Receipt - Number (CM)';
                            ShowCaption = false;
                        }
                        label("Purchase Receipt - Value (CM)")
                        {
                            Caption = 'Purchase Receipt - Value (CM)';
                            ShowCaption = false;
                        }
                        label("Purchase Invoices - Number (CM)")
                        {
                            Caption = 'Purchase Invoices - Number (CM)';
                            ShowCaption = false;
                        }
                        label("Purchase Invoices - Value (CM)")
                        {
                            Caption = 'Purchase Invoices - Value (CM)';
                            ShowCaption = false;
                        }
                        label("Purchase Return Orders - Number (CM)")
                        {
                            Caption = 'Purchase Return Orders - Number (CM)';
                            ShowCaption = false;
                        }
                        label("Purchase Return Orders - Value (CM)")
                        {
                            Caption = 'Purchase Return Orders - Value (CM)';
                            ShowCaption = false;
                        }
                        label("Total Purchases (CM)")
                        {
                            Caption = 'Total Purchases (CM)';
                            ShowCaption = false;
                        }
                    }
                    group(group4)
                    {
                        field(PurchaseOrdersCM; PurchaseOrdersCM)
                        {

                            trigger OnDrillDown()
                            begin

                                PurchaseOrder2.CLEARMARKS;
                                PurchaseOrder2.RESET;
                                PurchaseOrder2.SETRANGE("Document Date", StartingDateofTheMonth, TODAY);
                                IF PurchaseOrder2.FINDSET THEN
                                    REPEAT
                                        PurchaseOrder2.MARK(TRUE);
                                    UNTIL PurchaseOrder2.NEXT = 0;
                                PurchaseOrder2.MARKEDONLY(TRUE);
                                PAGE.RUN(53, PurchaseOrder2);
                            end;
                        }
                        field(PurchaseOrdersValueCM; PurchaseOrdersValueCM)
                        {

                            trigger OnDrillDown()
                            begin

                                PurchaseOrder2.CLEARMARKS;
                                PurchaseOrder2.RESET;
                                PurchaseOrder2.SETRANGE("Document Date", StartingDateofTheMonth, TODAY);
                                IF PurchaseOrder2.FINDSET THEN
                                    REPEAT
                                        PurchaseOrder2.MARK(TRUE);
                                    UNTIL PurchaseOrder2.NEXT = 0;
                                PurchaseOrder2.MARKEDONLY(TRUE);
                                PAGE.RUN(53, PurchaseOrder2);
                            end;
                        }
                        field(PurchaseReceiptCM; PurchaseReceiptCM)
                        {

                            trigger OnDrillDown()
                            begin

                                PurchRecpHeader2.CLEARMARKS;
                                PurchRecpHeader2.RESET;
                                PurchRecpHeader2.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                IF PurchRecpHeader2.FINDSET THEN
                                    REPEAT
                                        PurchRecpHeader2.MARK(TRUE);
                                    UNTIL PurchRecpHeader2.NEXT = 0;
                                PurchRecpHeader2.MARKEDONLY(TRUE);
                                PAGE.RUN(145, PurchRecpHeader2);
                            end;
                        }
                        field(PurchaseReceiptValueCM; PurchaseReceiptValueCM)
                        {

                            trigger OnDrillDown()
                            begin

                                PurchRecpHeader2.CLEARMARKS;
                                PurchRecpHeader2.RESET;
                                PurchRecpHeader2.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                IF PurchRecpHeader2.FINDSET THEN
                                    REPEAT
                                        PurchRecpHeader2.MARK(TRUE);
                                    UNTIL PurchRecpHeader2.NEXT = 0;
                                PurchRecpHeader2.MARKEDONLY(TRUE);
                                PAGE.RUN(145, PurchRecpHeader2);
                            end;
                        }
                        field(PurchaseInvoiceCM; PurchaseInvoiceCM)
                        {

                            trigger OnDrillDown()
                            begin

                                PurchaseInvoiceHeader2.CLEARMARKS;
                                PurchaseInvoiceHeader2.RESET;
                                PurchaseInvoiceHeader2.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                IF PurchaseInvoiceHeader2.FINDSET THEN
                                    REPEAT
                                        PurchaseInvoiceHeader2.MARK(TRUE);
                                    UNTIL PurchaseInvoiceHeader2.NEXT = 0;
                                PurchaseInvoiceHeader2.MARKEDONLY(TRUE);
                                PAGE.RUN(146, PurchaseInvoiceHeader2);
                            end;
                        }
                        field(PurchaseInvoicevalueCM; PurchaseInvoicevalueCM)
                        {

                            trigger OnDrillDown()
                            begin

                                PurchaseInvoiceHeader2.CLEARMARKS;
                                PurchaseInvoiceHeader2.RESET;
                                PurchaseInvoiceHeader2.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                IF PurchaseInvoiceHeader2.FINDSET THEN
                                    REPEAT
                                        PurchaseInvoiceHeader2.MARK(TRUE);
                                    UNTIL PurchaseInvoiceHeader2.NEXT = 0;
                                PurchaseInvoiceHeader2.MARKEDONLY(TRUE);
                                PAGE.RUN(146, PurchaseInvoiceHeader2);
                            end;
                        }
                        field(PurchaseReturnOrderCM; PurchaseReturnOrderCM)
                        {

                            trigger OnDrillDown()
                            begin

                                ReturnShipmentHeader2.CLEARMARKS;
                                ReturnShipmentHeader2.RESET;
                                ReturnShipmentHeader2.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                IF ReturnShipmentHeader2.FINDSET THEN
                                    REPEAT
                                        ReturnShipmentHeader2.MARK(TRUE);
                                    UNTIL ReturnShipmentHeader2.NEXT = 0;
                                ReturnShipmentHeader2.MARKEDONLY(TRUE);
                                PAGE.RUN(6652, ReturnShipmentHeader2);
                            end;
                        }
                        field(PurchaseReturnOrderValueCM; PurchaseReturnOrderValueCM)
                        {

                            trigger OnDrillDown()
                            begin

                                ReturnShipmentHeader2.CLEARMARKS;
                                ReturnShipmentHeader2.RESET;
                                ReturnShipmentHeader2.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                IF ReturnShipmentHeader2.FINDSET THEN
                                    REPEAT
                                        ReturnShipmentHeader2.MARK(TRUE);
                                    UNTIL ReturnShipmentHeader2.NEXT = 0;
                                ReturnShipmentHeader2.MARKEDONLY(TRUE);
                                PAGE.RUN(6652, ReturnShipmentHeader2);
                            end;
                        }
                        field(TotalPurchasesCM; TotalPurchasesCM)
                        {

                            trigger OnDrillDown()
                            begin

                                ValueEntries2.CLEARMARKS;
                                ValueEntries2.RESET;
                                ValueEntries2.SETRANGE("Item Ledger Entry Type", ValueEntries2."Item Ledger Entry Type"::Purchase);
                                ValueEntries2.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
                                IF ValueEntries2.FINDSET THEN
                                    REPEAT
                                        ValueEntries2.MARK(TRUE);
                                    UNTIL ValueEntries2.NEXT = 0;
                                ValueEntries2.MARKEDONLY(TRUE);
                                PAGE.RUN(5802, ValueEntries2);
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

        Month := DATE2DMY(TODAY, 2);
        Year := DATE2DMY(TODAY, 3);
        StartingDateofTheMonth := DMY2DATE(1, Month, Year);
        OpenPurchaseOrderNoCalc;
        POOrderReadyToRecvCalc;
        QtyRecvNotInvoicedCalc;
        DelayedOrdersCalc;
        PartiallyReceivedCalc;
        PurchaseOrderCalc;
        PurchaseReceiptCalc;
        PurchaseInvoicesCalc;
        PurchaseReturnCalc;
        TotalPurchaseCalc;
        TopVendorCalc;
    end;

    var
        OpenPurchaseOrderNumber: Integer;
        OpenPurchaseOrderValue: Decimal;
        POOrderreadyToRecv: Integer;
        POOrderreadyToRecvValue: Decimal;
        QtyRecvNotInvoiced: Integer;
        QtyRecvNotInvoicedValue: Decimal;
        DelayedOrdersNumber: Integer;
        DelayedOrdersValue: Decimal;
        PartiallyReceived: Integer;
        PartiallyReceivedValue: Decimal;
        PurchaseOrdersCM: Integer;
        PurchaseOrdersValueCM: Decimal;
        PurchaseReceiptCM: Integer;
        PurchaseReceiptValueCM: Decimal;
        PurchaseInvoiceCM: Integer;
        PurchaseInvoicevalueCM: Decimal;
        PurchaseReturnOrderCM: Integer;
        PurchaseReturnOrderValueCM: Decimal;
        TotalPurchasesCM: Decimal;
        "//Variable": Integer;
        Month: Integer;
        Year: Integer;
        StartingDateofTheMonth: Date;
        PurchaseOrder: Record 38;
        PurchaseLine: Record 39;
        PurchaseOrder2: Record 38;
        PurchaseLine2: Record 39;
        PurchaseOrder3: Record 38;
        PurchaseLine3: Record 39;
        PurchaseOrder1: Record 38;
        PurchaseLine1: Record 39;
        PurchaseOrder4: Record 38;
        PurchaseLine4: Record 39;
        PurchRecpHeader: Record 120;
        PurchRecptLine: Record 121;
        PurchRecpHeader2: Record 120;
        PurchRecptLine2: Record 121;
        PurchaseInvoiceHeader: Record 122;
        PurchaseInvoiceLine: Record 123;
        PurchaseInvoiceHeader2: Record 122;
        PurchaseInvoiceLine2: Record 123;
        ReturnShipmentHeader: Record 6650;
        ReturnShipmentLine: Record 6651;
        ReturnShipmentHeader2: Record 6650;
        ReturnShipmentLine2: Record 6651;
        ValueEntries: Record 5802;
        ValueEntries2: Record 5802;
        VendorLedgerEntry: Record 25;
        VendorLedgerEntry2: Record 25;
        Vendor: Record 23;
        TopVendor: array[5] of Code[20];
        TotalPurchaseAmtVendorwise: Decimal;
        VendorPurchaseAmtGreater: Decimal;

    //  ////[Scope('Internal')]
    procedure OpenPurchaseOrderNoCalc()
    begin
        OpenPurchaseOrderNumber := 0;
        OpenPurchaseOrderValue := 0;

        PurchaseOrder.CLEARMARKS;
        PurchaseLine.RESET;
        PurchaseLine.SETFILTER("Qty. to Receive", '>%1', 0);
        IF PurchaseLine.FINDSET THEN
            REPEAT
                PurchaseOrder.GET(PurchaseLine."Document Type", PurchaseLine."Document No.");
                IF PurchaseOrder.Status = PurchaseOrder.Status::Open THEN
                    PurchaseOrder.MARK(TRUE);
            UNTIL PurchaseLine.NEXT = 0;
        PurchaseOrder.MARKEDONLY(TRUE);
        OpenPurchaseOrderNumber := PurchaseOrder.COUNT;

        PurchaseOrder.CLEARMARKS;
        PurchaseLine.RESET;
        PurchaseLine.SETFILTER("Qty. to Receive", '>%1', 0);
        IF PurchaseLine.FINDSET THEN
            REPEAT
                PurchaseOrder.GET(PurchaseLine."Document Type", PurchaseLine."Document No.");
                IF PurchaseOrder.Status = PurchaseOrder.Status::Open THEN
                    OpenPurchaseOrderValue += (PurchaseLine."Amount To Vendor" / PurchaseLine.Quantity) * PurchaseLine."Qty. to Receive";
            UNTIL PurchaseLine.NEXT = 0;
    end;

    // ////[Scope('Internal')]
    procedure POOrderReadyToRecvCalc()
    begin
        POOrderreadyToRecv := 0;
        POOrderreadyToRecvValue := 0;

        PurchaseOrder.CLEARMARKS;
        PurchaseLine.RESET;
        PurchaseLine.SETFILTER("Qty. to Receive", '>%1', 0);
        IF PurchaseLine.FINDSET THEN
            REPEAT
                PurchaseOrder.GET(PurchaseLine."Document Type", PurchaseLine."Document No.");
                IF PurchaseOrder.Status = PurchaseOrder.Status::Released THEN
                    PurchaseOrder.MARK(TRUE);
            UNTIL PurchaseLine.NEXT = 0;
        PurchaseOrder.MARKEDONLY(TRUE);
        POOrderreadyToRecv := PurchaseOrder.COUNT;

        PurchaseOrder.CLEARMARKS;
        PurchaseLine.RESET;
        PurchaseLine.SETFILTER("Qty. to Receive", '>%1', 0);
        IF PurchaseLine.FINDSET THEN
            REPEAT
                PurchaseOrder.GET(PurchaseLine."Document Type", PurchaseLine."Document No.");
                IF PurchaseOrder.Status = PurchaseOrder.Status::Released THEN
                    POOrderreadyToRecvValue += (PurchaseLine."Amount To Vendor" / PurchaseLine.Quantity) * PurchaseLine."Qty. to Receive";
            UNTIL PurchaseLine.NEXT = 0;
    end;

    //////[Scope('Internal')]
    procedure QtyRecvNotInvoicedCalc()
    begin
        QtyRecvNotInvoiced := 0;
        QtyRecvNotInvoicedValue := 0;

        PurchaseOrder.CLEARMARKS;
        PurchaseLine.RESET;
        PurchaseLine.SETFILTER("Qty. Rcd. Not Invoiced", '>%1', 0);
        IF PurchaseLine.FINDSET THEN
            REPEAT
                IF PurchaseOrder.GET(PurchaseLine."Document Type", PurchaseLine."Document No.") THEN
                    PurchaseOrder.MARK(TRUE);
            UNTIL PurchaseLine.NEXT = 0;
        PurchaseOrder.MARKEDONLY(TRUE);
        QtyRecvNotInvoiced := PurchaseOrder.COUNT;

        PurchaseOrder.CLEARMARKS;
        PurchaseLine.RESET;
        PurchaseLine.SETFILTER("Qty. Rcd. Not Invoiced", '>%1', 0);
        IF PurchaseLine.FINDSET THEN
            REPEAT
                QtyRecvNotInvoicedValue += (PurchaseLine."Amount To Vendor" / PurchaseLine.Quantity) * PurchaseLine."Qty. Rcd. Not Invoiced";
            UNTIL PurchaseLine.NEXT = 0;
    end;

    //////[Scope('Internal')]
    procedure DelayedOrdersCalc()
    begin
        DelayedOrdersNumber := 0;
        DelayedOrdersValue := 0;

        PurchaseOrder.CLEARMARKS;
        PurchaseLine.RESET;
        PurchaseLine.SETFILTER("Expected Receipt Date", '<%1', TODAY);
        PurchaseLine.SETFILTER("Qty. to Receive", '>%1', 0);
        IF PurchaseLine.FINDSET THEN
            REPEAT
                IF PurchaseOrder.GET(PurchaseLine."Document Type", PurchaseLine."Document No.") THEN
                    PurchaseOrder.MARK(TRUE);
            UNTIL PurchaseLine.NEXT = 0;
        PurchaseOrder.MARKEDONLY(TRUE);
        DelayedOrdersNumber := PurchaseOrder.COUNT;

        PurchaseOrder.CLEARMARKS;
        PurchaseLine.RESET;
        PurchaseLine.SETFILTER("Expected Receipt Date", '<%1', TODAY);
        PurchaseLine.SETFILTER("Qty. to Receive", '>%1', 0);
        IF PurchaseLine.FINDSET THEN
            REPEAT
                DelayedOrdersValue += (PurchaseLine."Amount To Vendor" / PurchaseLine.Quantity) * PurchaseLine."Qty. to Receive";
            UNTIL PurchaseLine.NEXT = 0;
    end;

    // ////[Scope('Internal')]
    procedure PartiallyReceivedCalc()
    begin
        PartiallyReceived := 0;
        PartiallyReceivedValue := 0;

        PurchaseOrder.CLEARMARKS;
        PurchaseLine.RESET;
        PurchaseLine.SETFILTER("Qty. to Receive", '>%1', 0);
        PurchaseLine.SETFILTER("Quantity Received", '>%1', 0);
        IF PurchaseLine.FINDSET THEN
            REPEAT
                IF PurchaseOrder.GET(PurchaseLine."Document Type", PurchaseLine."Document No.") THEN
                    PurchaseOrder.MARK(TRUE);
            UNTIL PurchaseLine.NEXT = 0;
        PurchaseOrder.MARKEDONLY(TRUE);
        PartiallyReceived := PurchaseOrder.COUNT;

        PurchaseOrder.CLEARMARKS;
        PurchaseLine.RESET;
        PurchaseLine.SETFILTER("Qty. to Receive", '>%1', 0);
        PurchaseLine.SETFILTER("Quantity Received", '>%1', 0);
        IF PurchaseLine.FINDSET THEN
            REPEAT
                PartiallyReceivedValue += (PurchaseLine."Amount To Vendor" / PurchaseLine.Quantity) * PurchaseLine."Quantity Received";
            UNTIL PurchaseLine.NEXT = 0;
    end;

    // ////[Scope('Internal')]
    procedure PurchaseOrderCalc()
    begin
        PurchaseOrdersCM := 0;
        PurchaseOrdersValueCM := 0;

        PurchaseOrder.CLEARMARKS;
        PurchaseOrder.RESET;
        PurchaseOrder.SETRANGE("Document Date", StartingDateofTheMonth, TODAY);
        IF PurchaseOrder.FINDSET THEN
            REPEAT
                PurchaseOrder.MARK(TRUE);
            UNTIL PurchaseOrder.NEXT = 0;
        PurchaseOrder.MARKEDONLY(TRUE);
        PurchaseOrdersCM := PurchaseOrder.COUNT;

        PurchaseOrder.CLEARMARKS;
        PurchaseOrder.RESET;
        PurchaseOrder.SETRANGE("Document Date", StartingDateofTheMonth, TODAY);
        IF PurchaseOrder.FINDSET THEN
            REPEAT
                PurchaseLine.RESET;
                PurchaseLine.SETRANGE("Document Type", PurchaseOrder."Document Type");
                PurchaseLine.SETRANGE("Document No.", PurchaseOrder."No.");
                IF PurchaseLine.FINDSET THEN
                    REPEAT
                        PurchaseOrdersValueCM += PurchaseLine."Amount To Vendor";
                    UNTIL PurchaseLine.NEXT = 0;
            UNTIL PurchaseOrder.NEXT = 0;
    end;

    // ////[Scope('Internal')]
    procedure PurchaseReceiptCalc()
    begin
        PurchaseReceiptCM := 0;
        PurchaseReceiptValueCM := 0;

        PurchRecpHeader.CLEARMARKS;
        PurchRecpHeader.RESET;
        PurchRecpHeader.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
        IF PurchRecpHeader.FINDSET THEN
            REPEAT
                PurchRecpHeader.MARK(TRUE);
            UNTIL PurchRecpHeader.NEXT = 0;
        PurchRecpHeader.MARKEDONLY(TRUE);
        PurchaseReceiptCM := PurchRecpHeader.COUNT;

        PurchRecpHeader.CLEARMARKS;
        PurchRecpHeader.RESET;
        PurchRecpHeader.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
        IF PurchRecpHeader.FINDSET THEN
            REPEAT
                PurchRecptLine.RESET;
                PurchRecptLine.SETRANGE("Document No.", PurchRecpHeader."No.");
                IF PurchRecptLine.FINDSET THEN
                    REPEAT
                        PurchaseReceiptValueCM += PurchRecptLine.Quantity * PurchRecptLine."Direct Unit Cost";
                    UNTIL PurchRecptLine.NEXT = 0;
            UNTIL PurchRecpHeader.NEXT = 0;
    end;

    // ////[Scope('Internal')]
    procedure PurchaseInvoicesCalc()
    begin
        PurchaseInvoiceCM := 0;
        PurchaseInvoicevalueCM := 0;

        PurchaseInvoiceHeader.CLEARMARKS;
        PurchaseInvoiceHeader.RESET;
        PurchaseInvoiceHeader.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
        IF PurchaseInvoiceHeader.FINDSET THEN
            REPEAT
                PurchaseInvoiceHeader.MARK(TRUE);
            UNTIL PurchaseInvoiceHeader.NEXT = 0;
        PurchaseInvoiceHeader.MARKEDONLY(TRUE);
        PurchaseInvoiceCM := PurchaseInvoiceHeader.COUNT;

        PurchaseInvoiceHeader.CLEARMARKS;
        PurchaseInvoiceHeader.RESET;
        PurchaseInvoiceHeader.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
        IF PurchaseInvoiceHeader.FINDSET THEN
            REPEAT
                PurchaseInvoiceLine.RESET;
                PurchaseInvoiceLine.SETRANGE("Document No.", PurchaseInvoiceHeader."No.");
                IF PurchaseInvoiceHeader.FINDSET THEN
                    REPEAT
                        PurchaseInvoicevalueCM += PurchaseInvoiceLine."Amount To Vendor";
                    UNTIL PurchaseInvoiceHeader.NEXT = 0;
            UNTIL PurchaseInvoiceHeader.NEXT = 0;
    end;

    ///  ////[Scope('Internal')]
    procedure PurchaseReturnCalc()
    begin
        PurchaseReturnOrderCM := 0;
        PurchaseReturnOrderValueCM := 0;

        ReturnShipmentHeader.CLEARMARKS;
        ReturnShipmentHeader.RESET;
        ReturnShipmentHeader.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
        IF ReturnShipmentHeader.FINDSET THEN
            REPEAT
                ReturnShipmentHeader.MARK(TRUE);
            UNTIL ReturnShipmentHeader.NEXT = 0;
        ReturnShipmentHeader.MARKEDONLY(TRUE);
        PurchaseReturnOrderCM := ReturnShipmentHeader.COUNT;

        ReturnShipmentHeader.CLEARMARKS;
        ReturnShipmentHeader.RESET;
        ReturnShipmentHeader.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
        IF ReturnShipmentHeader.FINDSET THEN
            REPEAT
                ReturnShipmentLine.RESET;
                ReturnShipmentLine.SETRANGE("Document No.", ReturnShipmentHeader."No.");
                IF ReturnShipmentLine.FINDSET THEN
                    REPEAT
                        PurchaseReturnOrderValueCM += ReturnShipmentLine.Quantity * ReturnShipmentLine."Direct Unit Cost";
                    UNTIL ReturnShipmentLine.NEXT = 0;
            UNTIL ReturnShipmentHeader.NEXT = 0;
    end;

    // ////[Scope('Internal')]
    procedure TotalPurchaseCalc()
    begin
        TotalPurchasesCM := 0;

        ValueEntries.CLEARMARKS;
        ValueEntries.RESET;
        ValueEntries.SETRANGE("Item Ledger Entry Type", ValueEntries."Item Ledger Entry Type"::Purchase);
        ValueEntries.SETRANGE("Posting Date", StartingDateofTheMonth, TODAY);
        IF ValueEntries.FINDSET THEN
            REPEAT
                TotalPurchasesCM += ValueEntries."Purchase Amount (Actual)" + ValueEntries."Purchase Amount (Expected)";
            UNTIL ValueEntries.NEXT = 0;
    end;

    // ////[Scope('Internal')]
    procedure TopVendorCalc()
    begin
    end;
}

