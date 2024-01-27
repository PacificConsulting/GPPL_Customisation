pageextension 50034 WhseShpCardExtCstm extends "Warehouse Shipment"
{
    layout
    {
        addafter(Status)
        {
            field(Approve; Rec.Approve)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //RSPLSUM 09Nov2020>>
                RecWareShipLine.RESET;
                RecWareShipLine.SETRANGE("No.", rec."No.");
                RecWareShipLine.SETRANGE("Source Document", RecWareShipLine."Source Document"::"Sales Order");
                IF RecWareShipLine.FINDFIRST THEN BEGIN
                    RecSH.RESET;
                    IF RecSH.GET(RecSH."Document Type"::Order, RecWareShipLine."Source No.") THEN BEGIN
                        RecSalesLineNew.RESET;
                        RecSalesLineNew.SETCURRENTKEY("Document Type", "Document No.", Type);
                        RecSalesLineNew.SETRANGE("Document Type", RecSalesLineNew."Document Type"::Order);
                        RecSalesLineNew.SETRANGE("Document No.", RecSH."No.");
                        RecSalesLineNew.SETRANGE(RecSalesLineNew.Type, RecSalesLineNew.Type::Item);
                        IF RecSalesLineNew.FINDFIRST THEN
                            RecSH.TESTFIELD("Shipment Method Code");
                    END;
                END;

                RecWareShipLine.RESET;
                RecWareShipLine.SETRANGE("No.", rec."No.");
                RecWareShipLine.SETRANGE("Source Document", RecWareShipLine."Source Document"::"Outbound Transfer");
                IF RecWareShipLine.FINDFIRST THEN BEGIN
                    RecTH.RESET;
                    IF RecTH.GET(RecWareShipLine."Source No.") THEN BEGIN
                        RecTH.TESTFIELD("EWB Transaction Type");
                        RecTH.TESTFIELD("Shipment Method Code");
                    END;
                END;
                //RSPLSUM 09Nov2020<<

                //RSPLSUM-TCS>>
                RecWareShipLine.RESET;
                RecWareShipLine.SETCURRENTKEY("No.", "Source Document");
                RecWareShipLine.SETRANGE("No.", rec."No.");
                RecWareShipLine.SETRANGE("Source Document", RecWareShipLine."Source Document"::"Sales Order");
                IF RecWareShipLine.FINDSET THEN
                    REPEAT
                        RecSH.RESET;
                        IF RecSH.GET(RecSH."Document Type"::Order, RecWareShipLine."Source No.") THEN BEGIN
                            //IF RecSH."Customer Posting Group" <> 'FOREIGN' THEN BEGIN
                            IF RecSH."GST Customer Type" <> RecSH."GST Customer Type"::Export THEN BEGIN
                                RecSL29.RESET;
                                RecSL29.SETRANGE("Document Type", RecSL29."Document Type"::Order);
                                RecSL29.SETRANGE("Document No.", RecSH."No.");
                                RecSL29.SETFILTER("Inventory Posting Group", '%1', 'COAL');
                                IF NOT RecSL29.FINDFIRST THEN BEGIN
                                    RecSL28.RESET;
                                    RecSL28.SETRANGE("Document Type", RecSL28."Document Type"::Order);
                                    RecSL28.SETRANGE("Document No.", rec."No.");
                                    RecSL28.SETFILTER("TCS Nature of Collection", '%1', 'SCRAP');
                                    IF NOT RecSL28.FINDFIRST THEN BEGIN
                                        GLSetup.GET;
                                        CLEAR(CustAmt);
                                        RecCustomerN.RESET;
                                        IF RecCustomerN.GET(RecSH."Bill-to Customer No.") THEN BEGIN
                                            IF RecCustomerN."P.A.N. No." <> '' THEN BEGIN
                                                RecCustomerNP.RESET;
                                                RecCustomerNP.SETCURRENTKEY("P.A.N. No.");
                                                RecCustomerNP.SETRANGE("P.A.N. No.", RecCustomerN."P.A.N. No.");
                                                IF RecCustomerNP.FINDSET THEN
                                                    REPEAT
                                                        RecCustLedgEntry.RESET;
                                                        RecCustLedgEntry.SETCURRENTKEY("Customer No.", "Document Type", "Posting Date");
                                                        RecCustLedgEntry.SETRANGE("Customer No.", RecCustomerNP."No.");
                                                        RecCustLedgEntry.SETFILTER("Document Type", '%1|%2', RecCustLedgEntry."Document Type"::Invoice, RecCustLedgEntry."Document Type"::"Credit Memo");
                                                        RecCustLedgEntry.SETRANGE("Posting Date", GLSetup."TCS Threshold Starting Date", rec."Posting Date");
                                                        IF RecCustLedgEntry.FINDSET THEN
                                                            REPEAT
                                                                RecCustLedgEntry.CALCFIELDS("Amount (LCY)");
                                                                CustAmt += RecCustLedgEntry."Amount (LCY)";
                                                            UNTIL RecCustLedgEntry.NEXT = 0;
                                                    UNTIL RecCustomerNP.NEXT = 0;
                                            END ELSE BEGIN
                                                RecCustLedgEntry.RESET;
                                                RecCustLedgEntry.SETCURRENTKEY("Customer No.", "Document Type", "Posting Date");
                                                RecCustLedgEntry.SETRANGE("Customer No.", RecSH."Bill-to Customer No.");
                                                RecCustLedgEntry.SETFILTER("Document Type", '%1|%2', RecCustLedgEntry."Document Type"::Invoice, RecCustLedgEntry."Document Type"::"Credit Memo");
                                                RecCustLedgEntry.SETRANGE("Posting Date", GLSetup."TCS Threshold Starting Date", rec."Posting Date");
                                                IF RecCustLedgEntry.FINDSET THEN
                                                    REPEAT
                                                        RecCustLedgEntry.CALCFIELDS("Amount (LCY)");
                                                        CustAmt += RecCustLedgEntry."Amount (LCY)";
                                                    UNTIL RecCustLedgEntry.NEXT = 0;
                                            END;
                                        END;

                                        CLEAR(AmtToCustBill);
                                        RecSL30.RESET;
                                        RecSL30.SETCURRENTKEY("Document Type", "Document No.");
                                        RecSL30.SETRANGE("Document Type", RecSL30."Document Type"::Order);
                                        RecSL30.SETRANGE("Document No.", RecSH."No.");
                                        RecSL30.CALCSUMS("Amount To Customer");
                                        AmtToCustBill := RecSL30."Amount To Customer";

                                        RecSL31.RESET;
                                        RecSL31.SETRANGE("Document Type", RecSL31."Document Type"::Order);
                                        RecSL31.SETRANGE("Document No.", RecSH."No.");
                                        RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::"G/L Account");
                                        RecSL31.SETFILTER("TCS Nature of Collection", '<>%1', '');
                                        IF RecSL31.FINDFIRST THEN
                                            ERROR('Invalid TCS applied on line=%1', RecSL31."Line No.");

                                        IF (CustAmt + AmtToCustBill) <= GLSetup."TCS Threshold Amount" THEN BEGIN
                                            RecSL31.RESET;
                                            RecSL31.SETRANGE("Document Type", RecSL31."Document Type"::Order);
                                            RecSL31.SETRANGE("Document No.", RecSH."No.");
                                            RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                            RecSL31.SETFILTER("TCS Nature of Collection", '<>%1', '');
                                            IF RecSL31.FINDFIRST THEN
                                                ERROR('Invalid TCS applied on line=%1', RecSL31."Line No.");
                                        END ELSE BEGIN
                                            RecSL31.RESET;
                                            RecSL31.SETRANGE("Document Type", RecSL31."Document Type"::Order);
                                            RecSL31.SETRANGE("Document No.", RecSH."No.");
                                            RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                            RecSL31.SETFILTER("Assessee Code", '%1', '');
                                            IF RecSL31.FINDFIRST THEN BEGIN
                                                RecSH.TESTFIELD(RecSH."Assessee Code");
                                                ERROR('Please select Assessee Code in Sales Order Line=%1', RecSL31."Assessee Code");
                                            END;

                                            IF RecCustomerN.GET(RecSH."Bill-to Customer No.") THEN BEGIN //RSPl AM03072021  >>
                                                IF NOT RecCustomerN."Turnover Above 10 Crores" THEN BEGIN  //RSPl AM03072021  >>
                                                    RecSL31.RESET;
                                                    RecSL31.SETRANGE("Document Type", RecSL31."Document Type"::Order);
                                                    RecSL31.SETRANGE("Document No.", RecSH."No.");
                                                    RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                                    RecSL31.SETFILTER("TCS Nature of Collection", '%1', '');
                                                    IF RecSL31.FINDFIRST THEN BEGIN//RSPLSUM22Feb21>>
                                                        RecSL32.RESET;
                                                        RecSL32.SETRANGE("Document Type", RecSL32."Document Type");
                                                        RecSL32.SETRANGE("Document No.", RecSH."No.");
                                                        RecSL32.SETFILTER("No.", '<>%1', '');
                                                        RecSL32.SETRANGE("Free of Cost", FALSE);
                                                        IF RecSL32.FINDFIRST THEN
                                                            ERROR('Amount Exceeds TCS Threshold Amount, Please apply TCS');
                                                    END;//RSPLSUM22Feb21<<
                                                END; //RSPL AM03072021  <<
                                            END;//RSPL AM03072021 <<
                                        END;
                                    END;
                                END;
                            END;
                        END;
                    UNTIL RecWareShipLine.NEXT = 0;
                //RSPLSUM-TCS<<


            end;
        }
        modify("P&ost Shipment")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //RSPLSUM 09Nov2020>>
                RecWareShipLine.RESET;
                RecWareShipLine.SETRANGE("No.", rec."No.");
                RecWareShipLine.SETRANGE("Source Document", RecWareShipLine."Source Document"::"Sales Order");
                IF RecWareShipLine.FINDFIRST THEN BEGIN
                    RecSH.RESET;
                    IF RecSH.GET(RecSH."Document Type"::Order, RecWareShipLine."Source No.") THEN BEGIN
                        RecSalesLineNew.RESET;
                        RecSalesLineNew.SETCURRENTKEY("Document Type", "Document No.", Type);
                        RecSalesLineNew.SETRANGE("Document Type", RecSalesLineNew."Document Type"::Order);
                        RecSalesLineNew.SETRANGE("Document No.", RecSH."No.");
                        RecSalesLineNew.SETRANGE(RecSalesLineNew.Type, RecSalesLineNew.Type::Item);
                        IF RecSalesLineNew.FINDFIRST THEN
                            RecSH.TESTFIELD("Shipment Method Code");
                    END;
                END;
                //RSPLSUM 09Nov2020<<

                //RSPLSUM-TCS>>
                RecWareShipLine.RESET;
                RecWareShipLine.SETCURRENTKEY("No.", "Source Document");
                RecWareShipLine.SETRANGE("No.", rec."No.");
                RecWareShipLine.SETRANGE("Source Document", RecWareShipLine."Source Document"::"Sales Order");
                IF RecWareShipLine.FINDSET THEN
                    REPEAT
                        RecSH.RESET;
                        IF RecSH.GET(RecSH."Document Type"::Order, RecWareShipLine."Source No.") THEN BEGIN
                            //IF RecSH."Customer Posting Group" <> 'FOREIGN' THEN BEGIN
                            IF RecSH."GST Customer Type" <> RecSH."GST Customer Type"::Export THEN BEGIN
                                RecSL29.RESET;
                                RecSL29.SETRANGE("Document Type", RecSL29."Document Type"::Order);
                                RecSL29.SETRANGE("Document No.", RecSH."No.");
                                RecSL29.SETFILTER("Inventory Posting Group", '%1', 'COAL');
                                IF NOT RecSL29.FINDFIRST THEN BEGIN
                                    RecSL28.RESET;
                                    RecSL28.SETRANGE("Document Type", RecSL28."Document Type"::Order);
                                    RecSL28.SETRANGE("Document No.", rec."No.");
                                    RecSL28.SETFILTER("TCS Nature of Collection", '%1', 'SCRAP');
                                    IF NOT RecSL28.FINDFIRST THEN BEGIN
                                        GLSetup.GET;
                                        CLEAR(CustAmt);
                                        RecCustomerN.RESET;
                                        IF RecCustomerN.GET(RecSH."Bill-to Customer No.") THEN BEGIN
                                            IF RecCustomerN."P.A.N. No." <> '' THEN BEGIN
                                                RecCustomerNP.RESET;
                                                RecCustomerNP.SETCURRENTKEY("P.A.N. No.");
                                                RecCustomerNP.SETRANGE("P.A.N. No.", RecCustomerN."P.A.N. No.");
                                                IF RecCustomerNP.FINDSET THEN
                                                    REPEAT
                                                        RecCustLedgEntry.RESET;
                                                        RecCustLedgEntry.SETCURRENTKEY("Customer No.", "Document Type", "Posting Date");
                                                        RecCustLedgEntry.SETRANGE("Customer No.", RecCustomerNP."No.");
                                                        RecCustLedgEntry.SETFILTER("Document Type", '%1|%2', RecCustLedgEntry."Document Type"::Invoice, RecCustLedgEntry."Document Type"::"Credit Memo");
                                                        RecCustLedgEntry.SETRANGE("Posting Date", GLSetup."TCS Threshold Starting Date", rec."Posting Date");
                                                        IF RecCustLedgEntry.FINDSET THEN
                                                            REPEAT
                                                                RecCustLedgEntry.CALCFIELDS("Amount (LCY)");
                                                                CustAmt += RecCustLedgEntry."Amount (LCY)";
                                                            UNTIL RecCustLedgEntry.NEXT = 0;
                                                    UNTIL RecCustomerNP.NEXT = 0;
                                            END ELSE BEGIN
                                                RecCustLedgEntry.RESET;
                                                RecCustLedgEntry.SETCURRENTKEY("Customer No.", "Document Type", "Posting Date");
                                                RecCustLedgEntry.SETRANGE("Customer No.", RecSH."Bill-to Customer No.");
                                                RecCustLedgEntry.SETFILTER("Document Type", '%1|%2', RecCustLedgEntry."Document Type"::Invoice, RecCustLedgEntry."Document Type"::"Credit Memo");
                                                RecCustLedgEntry.SETRANGE("Posting Date", GLSetup."TCS Threshold Starting Date", rec."Posting Date");
                                                IF RecCustLedgEntry.FINDSET THEN
                                                    REPEAT
                                                        RecCustLedgEntry.CALCFIELDS("Amount (LCY)");
                                                        CustAmt += RecCustLedgEntry."Amount (LCY)";
                                                    UNTIL RecCustLedgEntry.NEXT = 0;
                                            END;
                                        END;

                                        CLEAR(AmtToCustBill);
                                        RecSL30.RESET;
                                        RecSL30.SETCURRENTKEY("Document Type", "Document No.");
                                        RecSL30.SETRANGE("Document Type", RecSL30."Document Type"::Order);
                                        RecSL30.SETRANGE("Document No.", RecSH."No.");
                                        RecSL30.CALCSUMS("Amount To Customer");
                                        AmtToCustBill := RecSL30."Amount To Customer";

                                        RecSL31.RESET;
                                        RecSL31.SETRANGE("Document Type", RecSL31."Document Type"::Order);
                                        RecSL31.SETRANGE("Document No.", RecSH."No.");
                                        RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::"G/L Account");
                                        RecSL31.SETFILTER("TCS Nature of Collection", '<>%1', '');
                                        IF RecSL31.FINDFIRST THEN
                                            ERROR('Invalid TCS applied on line=%1', RecSL31."Line No.");

                                        IF (CustAmt + AmtToCustBill) <= GLSetup."TCS Threshold Amount" THEN BEGIN
                                            RecSL31.RESET;
                                            RecSL31.SETRANGE("Document Type", RecSL31."Document Type"::Order);
                                            RecSL31.SETRANGE("Document No.", RecSH."No.");
                                            RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                            RecSL31.SETFILTER("TCS Nature of Collection", '<>%1', '');
                                            IF RecSL31.FINDFIRST THEN
                                                ERROR('Invalid TCS applied on line=%1', RecSL31."Line No.");
                                        END ELSE BEGIN
                                            RecSL31.RESET;
                                            RecSL31.SETRANGE("Document Type", RecSL31."Document Type"::Order);
                                            RecSL31.SETRANGE("Document No.", RecSH."No.");
                                            RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                            RecSL31.SETFILTER("Assessee Code", '%1', '');
                                            IF RecSL31.FINDFIRST THEN BEGIN
                                                RecSH.TESTFIELD(RecSH."Assessee Code");
                                                ERROR('Please select Assessee Code in Sales Order Line=%1', RecSL31."Assessee Code");
                                            END;

                                            IF RecCustomerN.GET(RecSH."Bill-to Customer No.") THEN BEGIN //RSPl AM03072021  >>
                                                IF NOT RecCustomerN."Turnover Above 10 Crores" THEN BEGIN  //RSPl AM03072021  >>
                                                    RecSL31.RESET;
                                                    RecSL31.SETRANGE("Document Type", RecSL31."Document Type"::Order);
                                                    RecSL31.SETRANGE("Document No.", RecSH."No.");
                                                    RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                                    RecSL31.SETFILTER("TCS Nature of Collection", '%1', '');
                                                    IF RecSL31.FINDFIRST THEN BEGIN//RSPLSUM22Feb21>>
                                                        RecSL32.RESET;
                                                        RecSL32.SETRANGE("Document Type", RecSL32."Document Type");
                                                        RecSL32.SETRANGE("Document No.", RecSH."No.");
                                                        RecSL32.SETFILTER("No.", '<>%1', '');
                                                        RecSL32.SETRANGE("Free of Cost", FALSE);
                                                        IF RecSL32.FINDFIRST THEN
                                                            ERROR('Amount Exceeds TCS Threshold Amount, Please apply TCS');
                                                    END;//RSPLSUM22Feb21<<
                                                END; //RSPL AM03072021  >>
                                            END; //RSPL AM03072021  >>
                                        END;
                                    END;
                                END;
                            END;
                        END;
                    UNTIL RecWareShipLine.NEXT = 0;
                //RSPLSUM-TCS<<


                //RSPLSUM 31Aug2020>>
                RecWareShipLine.RESET;
                RecWareShipLine.SETRANGE("No.", rec."No.");
                RecWareShipLine.SETRANGE("Source Document", RecWareShipLine."Source Document"::"Sales Order");
                IF RecWareShipLine.FINDFIRST THEN BEGIN
                    RecSH.RESET;
                    IF RecSH.GET(RecSH."Document Type"::Order, RecWareShipLine."Source No.") THEN BEGIN
                        IF RecSH."Shortcut Dimension 1 Code" <> 'DIV-14' THEN
                            RecSH.TESTFIELD("EWB Transaction Type");
                    END;
                END;

                RecWareShipLine.RESET;
                RecWareShipLine.SETRANGE("No.", rec."No.");
                RecWareShipLine.SETRANGE("Source Document", RecWareShipLine."Source Document"::"Outbound Transfer");
                IF RecWareShipLine.FINDFIRST THEN BEGIN
                    RecTH.RESET;
                    IF RecTH.GET(RecWareShipLine."Source No.") THEN BEGIN
                        RecTH.TESTFIELD("EWB Transaction Type");
                        RecTH.TESTFIELD("Shipment Method Code");//RSPLSUM 09Nov2020
                    END;//RSPLSUM 09Nov2020
                END;
                //RSPLSUM 31Aug2020<<

                //EBT STIVAN ---(11/12/2012)--- Approval Process as per Role-------------------START
                IF rec.Approve = FALSE THEN BEGIN
                    ERROR('Please Approve the Document');
                END;
                //EBT STIVAN ---(11/12/2012)--- Approval Process as per Role---------------------END
            end;
        }
        modify("Re&lease")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //RSPLSUM 09Nov2020>>
                RecWareShipLine.RESET;
                RecWareShipLine.SETRANGE("No.", rec."No.");
                RecWareShipLine.SETRANGE("Source Document", RecWareShipLine."Source Document"::"Sales Order");
                IF RecWareShipLine.FINDFIRST THEN BEGIN
                    RecSH.RESET;
                    IF RecSH.GET(RecSH."Document Type"::Order, RecWareShipLine."Source No.") THEN BEGIN
                        RecSalesLineNew.RESET;
                        RecSalesLineNew.SETCURRENTKEY("Document Type", "Document No.", Type);
                        RecSalesLineNew.SETRANGE("Document Type", RecSalesLineNew."Document Type"::Order);
                        RecSalesLineNew.SETRANGE("Document No.", RecSH."No.");
                        RecSalesLineNew.SETRANGE(RecSalesLineNew.Type, RecSalesLineNew.Type::Item);
                        IF RecSalesLineNew.FINDFIRST THEN
                            RecSH.TESTFIELD("Shipment Method Code");

                        //RSPLSUM 03Dec20>>
                        RecSalesLineNew.RESET;//RSPLSUM 05Dec2020>>
                        RecSalesLineNew.SETRANGE("Document No.", RecSH."No.");
                        RecSalesLineNew.SETRANGE("Document Type", RecSalesLineNew."Document Type"::Order);
                        RecSalesLineNew.SETFILTER(Quantity, '<>%1', 0);
                        RecSalesLineNew.SETRANGE("Free of Cost", FALSE);
                        IF RecSalesLineNew.FINDFIRST THEN BEGIN//RSPLSUM 05Dec2020<<
                            SL18.RESET;//RSPLSUM 19Dec2020>>
                            SL18.SETRANGE("Document No.", RecSH."No.");
                            SL18.SETRANGE("Document Type", SL18."Document Type"::Order);
                            SL18.SETFILTER("Inventory Posting Group", '<>%1', 'MERCH');
                            IF SL18.FINDFIRST THEN BEGIN//RSPLSUM 19Dec2020<<
                                RecDetGSTEntBuff.RESET;
                                RecDetGSTEntBuff.SETRANGE("Transaction Type", RecDetGSTEntBuff."Transaction Type"::Sales);
                                RecDetGSTEntBuff.SETRANGE("Document Type", RecDetGSTEntBuff."Document Type"::Order);
                                RecDetGSTEntBuff.SETRANGE("Document No.", RecSH."No.");
                                IF NOT RecDetGSTEntBuff.FINDFIRST THEN
                                    ERROR('Detailed GST Entry Buffer does not exist in sales order=%1, Please calculate structure values.', RecSH."No.");
                            END;
                        END;
                        //RSPLSUM 03Dec20<<
                    END;
                END;

                RecWareShipLine.RESET;
                RecWareShipLine.SETRANGE("No.", rec."No.");
                RecWareShipLine.SETRANGE("Source Document", RecWareShipLine."Source Document"::"Outbound Transfer");
                IF RecWareShipLine.FINDFIRST THEN BEGIN
                    RecTH.RESET;
                    IF RecTH.GET(RecWareShipLine."Source No.") THEN BEGIN
                        RecTH.TESTFIELD("EWB Transaction Type");
                        RecTH.TESTFIELD("Shipment Method Code");
                    END;
                END;
                //RSPLSUM 09Nov2020<<

                //RSPLSUM-TCS>>
                RecWareShipLine.RESET;
                RecWareShipLine.SETCURRENTKEY("No.", "Source Document");
                RecWareShipLine.SETRANGE("No.", rec."No.");
                RecWareShipLine.SETRANGE("Source Document", RecWareShipLine."Source Document"::"Sales Order");
                IF RecWareShipLine.FINDSET THEN
                    REPEAT
                        RecSH.RESET;
                        IF RecSH.GET(RecSH."Document Type"::Order, RecWareShipLine."Source No.") THEN BEGIN
                            //IF RecSH."Customer Posting Group" <> 'FOREIGN' THEN BEGIN
                            IF RecSH."GST Customer Type" <> RecSH."GST Customer Type"::Export THEN BEGIN
                                RecSL29.RESET;
                                RecSL29.SETRANGE("Document Type", RecSL29."Document Type"::Order);
                                RecSL29.SETRANGE("Document No.", RecSH."No.");
                                RecSL29.SETFILTER("Inventory Posting Group", '%1', 'COAL');
                                IF NOT RecSL29.FINDFIRST THEN BEGIN
                                    RecSL28.RESET;
                                    RecSL28.SETRANGE("Document Type", RecSL28."Document Type"::Order);
                                    RecSL28.SETRANGE("Document No.", rec."No.");
                                    RecSL28.SETFILTER("TCS Nature of Collection", '%1', 'SCRAP');
                                    IF NOT RecSL28.FINDFIRST THEN BEGIN
                                        GLSetup.GET;
                                        CLEAR(CustAmt);
                                        RecCustomerN.RESET;
                                        IF RecCustomerN.GET(RecSH."Bill-to Customer No.") THEN BEGIN
                                            IF RecCustomerN."P.A.N. No." <> '' THEN BEGIN
                                                RecCustomerNP.RESET;
                                                RecCustomerNP.SETCURRENTKEY("P.A.N. No.");
                                                RecCustomerNP.SETRANGE("P.A.N. No.", RecCustomerN."P.A.N. No.");
                                                IF RecCustomerNP.FINDSET THEN
                                                    REPEAT
                                                        RecCustLedgEntry.RESET;
                                                        RecCustLedgEntry.SETCURRENTKEY("Customer No.", "Document Type", "Posting Date");
                                                        RecCustLedgEntry.SETRANGE("Customer No.", RecCustomerNP."No.");
                                                        RecCustLedgEntry.SETFILTER("Document Type", '%1|%2', RecCustLedgEntry."Document Type"::Invoice, RecCustLedgEntry."Document Type"::"Credit Memo");
                                                        RecCustLedgEntry.SETRANGE("Posting Date", GLSetup."TCS Threshold Starting Date", rec."Posting Date");
                                                        IF RecCustLedgEntry.FINDSET THEN
                                                            REPEAT
                                                                RecCustLedgEntry.CALCFIELDS("Amount (LCY)");
                                                                CustAmt += RecCustLedgEntry."Amount (LCY)";
                                                            UNTIL RecCustLedgEntry.NEXT = 0;
                                                    UNTIL RecCustomerNP.NEXT = 0;
                                            END ELSE BEGIN
                                                RecCustLedgEntry.RESET;
                                                RecCustLedgEntry.SETCURRENTKEY("Customer No.", "Document Type", "Posting Date");
                                                RecCustLedgEntry.SETRANGE("Customer No.", RecSH."Bill-to Customer No.");
                                                RecCustLedgEntry.SETFILTER("Document Type", '%1|%2', RecCustLedgEntry."Document Type"::Invoice, RecCustLedgEntry."Document Type"::"Credit Memo");
                                                RecCustLedgEntry.SETRANGE("Posting Date", GLSetup."TCS Threshold Starting Date", rec."Posting Date");
                                                IF RecCustLedgEntry.FINDSET THEN
                                                    REPEAT
                                                        RecCustLedgEntry.CALCFIELDS("Amount (LCY)");
                                                        CustAmt += RecCustLedgEntry."Amount (LCY)";
                                                    UNTIL RecCustLedgEntry.NEXT = 0;
                                            END;
                                        END;

                                        CLEAR(AmtToCustBill);
                                        RecSL30.RESET;
                                        RecSL30.SETCURRENTKEY("Document Type", "Document No.");
                                        RecSL30.SETRANGE("Document Type", RecSL30."Document Type"::Order);
                                        RecSL30.SETRANGE("Document No.", RecSH."No.");
                                        RecSL30.CALCSUMS("Amount To Customer");
                                        AmtToCustBill := RecSL30."Amount To Customer";

                                        RecSL31.RESET;
                                        RecSL31.SETRANGE("Document Type", RecSL31."Document Type"::Order);
                                        RecSL31.SETRANGE("Document No.", RecSH."No.");
                                        RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::"G/L Account");
                                        RecSL31.SETFILTER("TCS Nature of Collection", '<>%1', '');
                                        IF RecSL31.FINDFIRST THEN
                                            ERROR('Invalid TCS applied on line=%1', RecSL31."Line No.");

                                        IF (CustAmt + AmtToCustBill) <= GLSetup."TCS Threshold Amount" THEN BEGIN
                                            RecSL31.RESET;
                                            RecSL31.SETRANGE("Document Type", RecSL31."Document Type"::Order);
                                            RecSL31.SETRANGE("Document No.", RecSH."No.");
                                            RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                            RecSL31.SETFILTER("TCS Nature of Collection", '<>%1', '');
                                            IF RecSL31.FINDFIRST THEN
                                                ERROR('Invalid TCS applied on line=%1', RecSL31."Line No.");
                                        END ELSE BEGIN
                                            RecSL31.RESET;
                                            RecSL31.SETRANGE("Document Type", RecSL31."Document Type"::Order);
                                            RecSL31.SETRANGE("Document No.", RecSH."No.");
                                            RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                            RecSL31.SETFILTER("Assessee Code", '%1', '');
                                            IF RecSL31.FINDFIRST THEN BEGIN
                                                RecSH.TESTFIELD(RecSH."Assessee Code");
                                                ERROR('Please select Assessee Code in Sales Order Line=%1', RecSL31."Assessee Code");
                                            END;

                                            IF RecCustomerN.GET(RecSH."Bill-to Customer No.") THEN BEGIN //RSPl AM03072021  >>
                                                IF NOT RecCustomerN."Turnover Above 10 Crores" THEN BEGIN  //RSPl AM03072021  >>
                                                    RecSL31.RESET;
                                                    RecSL31.SETRANGE("Document Type", RecSL31."Document Type"::Order);
                                                    RecSL31.SETRANGE("Document No.", RecSH."No.");
                                                    RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                                    RecSL31.SETFILTER("TCS Nature of Collection", '%1', '');
                                                    IF RecSL31.FINDFIRST THEN BEGIN//RSPLSUM22Feb21>>
                                                        RecSL32.RESET;
                                                        RecSL32.SETRANGE("Document Type", RecSL32."Document Type");
                                                        RecSL32.SETRANGE("Document No.", RecSH."No.");
                                                        RecSL32.SETFILTER("No.", '<>%1', '');
                                                        RecSL32.SETRANGE("Free of Cost", FALSE);
                                                        IF RecSL32.FINDFIRST THEN
                                                            ERROR('Amount Exceeds TCS Threshold Amount, Please apply TCS');
                                                    END;//RSPLSUM22Feb21<<
                                                END; //RSPl AM03072021  <<
                                            END; //RSPl AM03072021  <<
                                        END;
                                    END;
                                END;
                            END;
                        END;
                    UNTIL RecWareShipLine.NEXT = 0;
                //RSPLSUM-TCS<<

            end;
        }
    }
    trigger OnOpenPage()
    var
        AccessControl: Record "Access Control";
    begin
        //RSPL-TC +
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETRANGE("Role ID", 'WHS.SHIPMENTAPPROVAL');
        IF AccessControl.FINDFIRST THEN
            ApproveEditable := TRUE
        ELSE
            ApproveEditable := FALSE;
        //RSPL-TC -
    end;

    var
        ApproveEditable: Boolean;
        WhseDocPrint: Codeunit 5776;
        AccessControl: Record 2000000053;
        //        ApproveEditable: Boolean;
        RecWareShipLine: Record 7321;
        RecSH: Record 36;
        RecTH: Record 5740;
        RecCustLedgEntry: Record 21;
        GLSetup: Record 98;
        CustAmt: Decimal;
        RecSL30: Record 37;
        AmtToCustBill: Decimal;
        RecSL31: Record 37;
        RecSL29: Record 37;
        RecSL28: Record 37;
        RecCustomerN: Record 18;
        RecCustomerNP: Record 18;
        RecSalesLineNew: Record 37;
        RecDetGSTEntBuff: Record "Detailed GST Entry Buffer";
        SL18: Record 37;
        RecSL32: Record 37;
        Approve: Boolean;
}