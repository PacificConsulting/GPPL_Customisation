pageextension 50012 SalesInvoiceExt extends "Sales Invoice"
{
    // SourceTableView=WHERE(Document Type=FILTER(Invoice),Debit Memo=CONST(No));
    layout
    {
        modify("Payment Terms Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN

                //>>28Aug2018
                DueDateGP;
                //<<28Aug2018
            END;
        }
        // Add changes to page layout here
        modify("Sell-to Customer No.")
        {

            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                //RSPLSUM 11May2020>>
                IF rec."Sell-to Customer No." <> '' THEN BEGIN
                    RecCustNew.RESET;
                    IF RecCustNew.GET(rec."Sell-to Customer No.") THEN BEGIN
                        IF (RecCustNew."Customer Posting Group" = 'FO') AND
                            (RecCustNew."Approval Status" <> RecCustNew."Approval Status"::Approved) THEN
                            ERROR('Customer must be approved');
                    END;
                END;
                //RSPLSUM 11May2020<<

                ///  SelltoCustomerNoOnAfterValidat;

                //>>28Aug2018
                DueDateGP;
                //<<28Aug2018
            END;
        }
        modify("External Document No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                //RSPLSUM BEGIN<<
                IF rec."External Document No." <> '' THEN
                    IF STRLEN(rec."External Document No.") > 16 THEN
                        ERROR('External Document No. should not be more than 16 characters');
                //RSPLSUM END<<
            END;
        }
        addafter(Status)
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = all;
            }
            field("Sales Order No"; rec."Sales Order No")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 11May2020>>  on OrderNo Validate
                    rec."External Document No." := '';
                    rec."Document Date" := 0D;
                    rec."Shortcut Dimension 1 Code" := '';
                    rec."Shortcut Dimension 2 Code" := '';
                    rec."Currency Code" := '';
                    rec."Currency Factor" := 0;
                    rec."Location Code" := '';
                    rec."Shipping Agent Code" := '';
                    rec."Shipment Method Code" := '';
                    rec."Shipment Date" := 0D;
                    //"Shipping Bill No" := '';
                    //"Shipping Bill  Date" := 0D;
                    //"B/L No." := '';
                    //"B/L Date" := 0D;
                    //"Port Code" := '' ;
                    //"Vessel Code" := '';
                    //"BDN No." := '';
                    //"BDN Date" := 0D;
                    //"Buyer's Order No" := '';
                    //"Buyer's Order Date" := 0D;
                    rec."Freight Type" := rec."Freight Type"::" ";
                    //"Port Description" := '';
                    //"Vessel Name" := '';
                    //"Terms Of Delivery" := "Terms Of Delivery"::" ";
                    //"Port Location Name" := "Port Location Name"::" ";
                    //"Pricing Type" := "Pricing Type"::"0";
                    rec."LR/RR No." := '';
                    rec."LR/RR Date" := 0D;
                    rec."Vehicle No." := '';
                    rec."Mode of Transport" := '';
                    // rec.Structure := '';
                    rec."Bank Account No." := '';
                    rec."Location State Code" := '';
                    //"BOE No." := '';//30Oct2017

                    rec.MODIFY;


                    IF rec."Sales Order No" <> '' THEN BEGIN

                        SH21.RESET;
                        SH21.SETRANGE("Document Type", SH21."Document Type"::Order);
                        SH21.SETRANGE("No.", rec."Sales Order No");
                        IF SH21.FINDFIRST THEN BEGIN

                            //SH21.CALCFIELDS(SH21."Port Description",SH21."Vessel Name");

                            rec."External Document No." := SH21."External Document No.";
                            rec."Document Date" := SH21."Document Date";
                            rec."Shortcut Dimension 1 Code" := SH21."Shortcut Dimension 1 Code";
                            rec."Shortcut Dimension 2 Code" := SH21."Shortcut Dimension 2 Code";
                            rec."Currency Code" := SH21."Currency Code";
                            rec."Currency Factor" := SH21."Currency Factor";
                            rec."Location Code" := SH21."Location Code";
                            rec."Shipping Agent Code" := SH21."Shipping Agent Code";
                            rec."Shipment Method Code" := SH21."Shipment Method Code";
                            rec."Shipment Date" := SH21."Shipment Date";
                            //"Shipping Bill No" := SH21."Shipping Bill No";
                            //"Shipping Bill  Date" := SH21."Shipping Bill  Date";
                            //"B/L No." := SH21."B/L No.";
                            //"B/L Date" := SH21."B/L Date";
                            //"Port Code" := SH21."Port Code" ;
                            //"Vessel Code" := SH21."Vessel Code";
                            //"BDN No." := SH21."BDN No.";
                            //"BDN Date" := SH21."BDN Date";
                            //"Buyer's Order No" := SH21."Buyer's Order No";
                            //"Buyer's Order Date" := SH21."Buyer's Order Date";
                            rec."Freight Type" := SH21."Freight Type";
                            //"Port Description" := SH21."Port Description";
                            //"Vessel Name" := SH21."Vessel Name";
                            //"Terms Of Delivery" := SH21."Terms Of Delivery";
                            //"Port Location Name" := SH21."Port Location Name";
                            //"Pricing Type" := SH21."Pricing Type";
                            rec."LR/RR No." := SH21."LR/RR No.";
                            rec."LR/RR Date" := SH21."LR/RR Date";
                            rec."Vehicle No." := SH21."Vehicle No.";
                            rec."Mode of Transport" := SH21."Mode of Transport";
                            // rec.Structure := SH21.Structure;
                            rec."Bank Account No." := SH21."Bank Account No.";
                            rec."Location State Code" := SH21."Location State Code";
                            //"BOE No." := SH21."BOE No.";//30Oct2017

                            rec.MODIFY;

                        END;

                    END;
                    //RSPLSUM 11May2020<<  on OrderNo Validate
                END;

            }
            field("Distance in kms"; rec."Distance in kms")
            {

            }

            // field(PoT; rec.PoT)
            // {

            // }


        }
    }

    actions
    {
        modify(PostAndNew)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            BEGIN
                //RSPLSUM 09Nov2020>>
                RecSalesLineNew.RESET;
                RecSalesLineNew.SETCURRENTKEY("Document Type", "Document No.", Type);
                RecSalesLineNew.SETRANGE("Document Type", rec."Document Type");
                RecSalesLineNew.SETRANGE("Document No.", rec."No.");
                RecSalesLineNew.SETRANGE(RecSalesLineNew.Type, RecSalesLineNew.Type::Item);
                IF RecSalesLineNew.FINDFIRST THEN
                    rec.TESTFIELD("Shipment Method Code");
                //RSPLSUM 09Nov2020<<

                //NB Start
                SalesLineRec1.RESET;
                SalesLineRec1.SETRANGE("Document No.", rec."No.");
                //SalesLineRec2.SETRANGE("Document No.",SalesLineRec1."Document No.");
                IF SalesLineRec1.FINDFIRST THEN
                    GSTGrpCode := SalesLineRec1."GST Group Code";

                SalesLineRec2.RESET;
                SalesLineRec2.SETRANGE("Document No.", rec."No.");
                IF SalesLineRec2.FINDFIRST THEN
                    REPEAT
                        IF SalesLineRec2."GST Group Code" <> GSTGrpCode THEN
                            ERROR('GST Group code should be same for each line');
                    UNTIL SalesLineRec2.NEXT = 0;
                //NB End

                //RSPLSUM-TCS>>
                //IF "Customer Posting Group" <> 'FOREIGN' THEN BEGIN
                IF rec."GST Customer Type" <> rec."GST Customer Type"::Export THEN BEGIN
                    RecSL29.RESET;
                    RecSL29.SETRANGE("Document Type", rec."Document Type");
                    RecSL29.SETRANGE("Document No.", rec."No.");
                    RecSL29.SETFILTER("Inventory Posting Group", '%1', 'COAL');
                    IF NOT RecSL29.FINDFIRST THEN BEGIN
                        RecSL28.RESET;
                        RecSL28.SETRANGE("Document Type", rec."Document Type");
                        RecSL28.SETRANGE("Document No.", rec."No.");
                        RecSL28.SETFILTER("TCS Nature of Collection", '%1', 'SCRAP');
                        IF NOT RecSL28.FINDFIRST THEN BEGIN
                            GLSetup.GET;
                            CLEAR(CustAmt);
                            RecCustomerN.RESET;
                            IF RecCustomerN.GET(rec."Bill-to Customer No.") THEN BEGIN
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
                                    RecCustLedgEntry.SETRANGE("Customer No.", rec."Bill-to Customer No.");
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
                            RecSL30.SETRANGE("Document Type", rec."Document Type");
                            RecSL30.SETRANGE("Document No.", rec."No.");
                            RecSL30.CALCSUMS("Amount To Customer");
                            AmtToCustBill := RecSL30."Amount To Customer";

                            RecSL31.RESET;
                            RecSL31.SETRANGE("Document Type", rec."Document Type");
                            RecSL31.SETRANGE("Document No.", rec."No.");
                            RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::"G/L Account");
                            RecSL31.SETFILTER("TCS Nature of Collection", '<>%1', '');
                            IF RecSL31.FINDFIRST THEN
                                ERROR('Invalid TCS applied on line=%1', RecSL31."Line No.");

                            IF (CustAmt + AmtToCustBill) <= GLSetup."TCS Threshold Amount" THEN BEGIN
                                RecSL31.RESET;
                                RecSL31.SETRANGE("Document Type", rec."Document Type");
                                RecSL31.SETRANGE("Document No.", rec."No.");
                                RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                RecSL31.SETFILTER("TCS Nature of Collection", '<>%1', '');
                                IF RecSL31.FINDFIRST THEN
                                    ERROR('Invalid TCS applied on line=%1', RecSL31."Line No.");
                            END ELSE BEGIN
                                RecSL31.RESET;
                                RecSL31.SETRANGE("Document Type", rec."Document Type");
                                RecSL31.SETRANGE("Document No.", rec."No.");
                                RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                RecSL31.SETFILTER("Assessee Code", '%1', '');
                                IF RecSL31.FINDFIRST THEN BEGIN
                                    rec.TESTFIELD("Assessee Code");
                                    ERROR('Please select Assessee Code in Sales Invoice Line=%1', RecSL31."Assessee Code");
                                END;

                                IF recCustomernew.GET(rec."Bill-to Customer No.") THEN BEGIN //RSPl AM03072021 >>
                                    IF NOT recCustomernew."Turnover Above 10 Crores" THEN BEGIN  //RSPl AM03072021 >>
                                        RecSL31.RESET;
                                        RecSL31.SETRANGE("Document Type", rec."Document Type");
                                        RecSL31.SETRANGE("Document No.", rec."No.");
                                        RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                        RecSL31.SETFILTER("TCS Nature of Collection", '%1', '');
                                        IF RecSL31.FINDFIRST THEN BEGIN//RSPLSUM22Feb21>>
                                            RecSL32.RESET;
                                            RecSL32.SETRANGE("Document Type", rec."Document Type");
                                            RecSL32.SETRANGE("Document No.", rec."No.");
                                            RecSL32.SETFILTER("No.", '<>%1', '');
                                            RecSL32.SETRANGE("Free of Cost", FALSE);
                                            IF RecSL32.FINDFIRST THEN
                                                ERROR('Amount Exceeds TCS Threshold Amount, Please apply TCS');
                                        END;//RSPLSUM22Feb21<<
                                    END; //RSPL AM03072021 <<
                                END;//RSPL AM03072021 <<
                            END;
                        END;
                    END;
                END;
                //RSPLSUM-TCS<<

                //RSPLSUM 11May2020>>
                CI22.GET;
                IF CI22."Customer Credit Validation" THEN
                    IF rec."Customer Posting Group" = 'FO' THEN //05Jul2018
                    BEGIN
                        Cust22.RESET;
                        IF Cust22.GET(rec."Sell-to Customer No.") THEN BEGIN
                            IF Cust22."Approval Status" <> Cust22."Approval Status"::Approved THEN
                                ERROR('Customer is Not Approved');

                            IF Cust22."Credit Limit Approval Status" <> Cust22."Credit Limit Approval Status"::Approved THEN
                                ERROR('Customer Credit Limit is Not Approved');
                        END;
                    END;
                //RSPLSUM 11May2020<<

                // Post(CODEUNIT::"Sales-Post + Print");
            END;
        }

        modify(Post)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            BEGIN
                //RSPLSUM 09Nov2020>>
                RecSalesLineNew.RESET;
                RecSalesLineNew.SETCURRENTKEY("Document Type", "Document No.", Type);
                RecSalesLineNew.SETRANGE("Document Type", rec."Document Type");
                RecSalesLineNew.SETRANGE("Document No.", rec."No.");
                RecSalesLineNew.SETRANGE(RecSalesLineNew.Type, RecSalesLineNew.Type::Item);
                IF RecSalesLineNew.FINDFIRST THEN
                    rec.TESTFIELD("Shipment Method Code");
                //RSPLSUM 09Nov2020<<

                //NB Start
                SalesLineRec1.RESET;
                SalesLineRec1.SETRANGE("Document No.", rec."No.");
                //SalesLineRec2.SETRANGE("Document No.",SalesLineRec1."Document No.");
                IF SalesLineRec1.FINDFIRST THEN
                    GSTGrpCode := SalesLineRec1."GST Group Code";

                SalesLineRec2.RESET;
                SalesLineRec2.SETRANGE("Document No.", rec."No.");
                IF SalesLineRec2.FINDFIRST THEN
                    REPEAT
                        IF SalesLineRec2."GST Group Code" <> GSTGrpCode THEN
                            ERROR('GST Group code should be same for each line');
                    UNTIL SalesLineRec2.NEXT = 0;
                //NB End

                //RSPLSUM-TCS>>
                //IF "Customer Posting Group" <> 'FOREIGN' THEN BEGIN
                IF rec."GST Customer Type" <> rec."GST Customer Type"::Export THEN BEGIN
                    RecSL29.RESET;
                    RecSL29.SETRANGE("Document Type", rec."Document Type");
                    RecSL29.SETRANGE("Document No.", rec."No.");
                    RecSL29.SETFILTER("Inventory Posting Group", '%1', 'COAL');
                    IF NOT RecSL29.FINDFIRST THEN BEGIN
                        RecSL28.RESET;
                        RecSL28.SETRANGE("Document Type", rec."Document Type");
                        RecSL28.SETRANGE("Document No.", rec."No.");
                        RecSL28.SETFILTER("TCS Nature of Collection", '%1', 'SCRAP');
                        IF NOT RecSL28.FINDFIRST THEN BEGIN
                            GLSetup.GET;
                            CLEAR(CustAmt);
                            RecCustomerN.RESET;
                            IF RecCustomerN.GET(rec."Bill-to Customer No.") THEN BEGIN
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
                                    RecCustLedgEntry.SETRANGE("Customer No.", rec."Bill-to Customer No.");
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
                            RecSL30.SETRANGE("Document Type", rec."Document Type");
                            RecSL30.SETRANGE("Document No.", rec."No.");
                            RecSL30.CALCSUMS("Amount To Customer");
                            AmtToCustBill := RecSL30."Amount To Customer";

                            RecSL31.RESET;
                            RecSL31.SETRANGE("Document Type", rec."Document Type");
                            RecSL31.SETRANGE("Document No.", rec."No.");
                            RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::"G/L Account");
                            RecSL31.SETFILTER("TCS Nature of Collection", '<>%1', '');
                            IF RecSL31.FINDFIRST THEN
                                ERROR('Invalid TCS applied on line=%1', RecSL31."Line No.");

                            IF (CustAmt + AmtToCustBill) <= GLSetup."TCS Threshold Amount" THEN BEGIN
                                RecSL31.RESET;
                                RecSL31.SETRANGE("Document Type", rec."Document Type");
                                RecSL31.SETRANGE("Document No.", rec."No.");
                                RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                RecSL31.SETFILTER("TCS Nature of Collection", '<>%1', '');
                                IF RecSL31.FINDFIRST THEN
                                    ERROR('Invalid TCS applied on line=%1', RecSL31."Line No.");
                            END ELSE BEGIN
                                RecSL31.RESET;
                                RecSL31.SETRANGE("Document Type", rec."Document Type");
                                RecSL31.SETRANGE("Document No.", rec."No.");
                                RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                RecSL31.SETFILTER("Assessee Code", '%1', '');
                                IF RecSL31.FINDFIRST THEN BEGIN
                                    rec.TESTFIELD("Assessee Code");
                                    ERROR('Please select Assessee Code in Sales Invoice Line=%1', RecSL31."Assessee Code");
                                END;

                                IF recCustomernew.GET(rec."Bill-to Customer No.") THEN BEGIN //RSPl AM03072021 >>
                                    IF NOT recCustomernew."Turnover Above 10 Crores" THEN BEGIN  //RSPl AM03072021 >>
                                        RecSL31.RESET;
                                        RecSL31.SETRANGE("Document Type", rec."Document Type");
                                        RecSL31.SETRANGE("Document No.", rec."No.");
                                        RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                        RecSL31.SETFILTER("TCS Nature of Collection", '%1', '');
                                        IF RecSL31.FINDFIRST THEN BEGIN//RSPLSUM22Feb21>>
                                            RecSL32.RESET;
                                            RecSL32.SETRANGE("Document Type", rec."Document Type");
                                            RecSL32.SETRANGE("Document No.", rec."No.");
                                            RecSL32.SETFILTER("No.", '<>%1', '');
                                            RecSL32.SETRANGE("Free of Cost", FALSE);
                                            IF RecSL32.FINDFIRST THEN
                                                ERROR('Amount Exceeds TCS Threshold Amount, Please apply TCS');
                                        END;//RSPLSUM22Feb21<<
                                    END;//RSPl AM03072021 <<
                                END; //RSPl AM03072021 <<
                            END;
                        END;
                    END;
                END;
                //RSPLSUM-TCS<<

                //RSPLSUM 11May2020>>
                CI22.GET;
                IF CI22."Customer Credit Validation" THEN
                    IF rec."Customer Posting Group" = 'FO' THEN //05Jul2018
                    BEGIN
                        Cust22.RESET;
                        IF Cust22.GET(rec."Sell-to Customer No.") THEN BEGIN
                            IF Cust22."Approval Status" <> Cust22."Approval Status"::Approved THEN
                                ERROR('Customer is Not Approved');

                            IF Cust22."Credit Limit Approval Status" <> Cust22."Credit Limit Approval Status"::Approved THEN
                                ERROR('Customer Credit Limit is Not Approved');
                        END;
                    END;
                //RSPLSUM 11May2020<<

                //  Post(CODEUNIT::"Sales-Post (Yes/No)");
            END;

        }
        modify("SendApprovalRequest")
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            BEGIN
                //NB Start
                SalesLineRec1.RESET;
                SalesLineRec1.SETRANGE("Document No.", rec."No.");
                //SalesLineRec2.SETRANGE("Document No.",SalesLineRec1."Document No.");
                IF SalesLineRec1.FINDFIRST THEN
                    GSTGrpCode := SalesLineRec1."GST Group Code";

                SalesLineRec2.RESET;
                SalesLineRec2.SETRANGE("Document No.", rec."No.");
                IF SalesLineRec2.FINDFIRST THEN
                    REPEAT
                        IF SalesLineRec2."GST Group Code" <> GSTGrpCode THEN
                            ERROR('GST Group code should be same for each line');
                    UNTIL SalesLineRec2.NEXT = 0;
                //NB End

                // IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
                // ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
            END;
        }
        // Add changes to page actions here
        modify(Release)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            BEGIN
                //RSPLSUM 09Nov2020>>
                RecSalesLineNew.RESET;
                RecSalesLineNew.SETCURRENTKEY("Document Type", "Document No.", Type);
                RecSalesLineNew.SETRANGE("Document Type", rec."Document Type");
                RecSalesLineNew.SETRANGE("Document No.", rec."No.");
                RecSalesLineNew.SETRANGE(RecSalesLineNew.Type, RecSalesLineNew.Type::Item);
                IF RecSalesLineNew.FINDFIRST THEN
                    rec.TESTFIELD("Shipment Method Code");
                //RSPLSUM 09Nov2020<<

                //NB Start
                SalesLineRec1.RESET;
                SalesLineRec1.SETRANGE("Document No.", rec."No.");
                //SalesLineRec2.SETRANGE("Document No.",SalesLineRec1."Document No.");
                IF SalesLineRec1.FINDFIRST THEN
                    GSTGrpCode := SalesLineRec1."GST Group Code";

                SalesLineRec2.RESET;
                SalesLineRec2.SETRANGE("Document No.", rec."No.");
                IF SalesLineRec2.FINDFIRST THEN
                    REPEAT
                        IF SalesLineRec2."GST Group Code" <> GSTGrpCode THEN
                            ERROR('GST Group code should be same for each line');
                    UNTIL SalesLineRec2.NEXT = 0;
                //NB End

                //RSPLSUM-TCS>>
                //IF "Customer Posting Group" <> 'FOREIGN' THEN BEGIN
                IF rec."GST Customer Type" <> rec."GST Customer Type"::Export THEN BEGIN
                    RecSL29.RESET;
                    RecSL29.SETRANGE("Document Type", rec."Document Type");
                    RecSL29.SETRANGE("Document No.", rec."No.");
                    RecSL29.SETFILTER("Inventory Posting Group", '%1', 'COAL');
                    IF NOT RecSL29.FINDFIRST THEN BEGIN
                        RecSL28.RESET;
                        RecSL28.SETRANGE("Document Type", rec."Document Type");
                        RecSL28.SETRANGE("Document No.", rec."No.");
                        RecSL28.SETFILTER("TCS Nature of Collection", '%1', 'SCRAP');
                        IF NOT RecSL28.FINDFIRST THEN BEGIN
                            GLSetup.GET;
                            CLEAR(CustAmt);
                            RecCustomerN.RESET;
                            IF RecCustomerN.GET(rec."Bill-to Customer No.") THEN BEGIN
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
                                    RecCustLedgEntry.SETRANGE("Customer No.", rec."Bill-to Customer No.");
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
                            RecSL30.SETRANGE("Document Type", rec."Document Type");
                            RecSL30.SETRANGE("Document No.", rec."No.");
                            RecSL30.CALCSUMS("Amount To Customer");
                            AmtToCustBill := RecSL30."Amount To Customer";

                            RecSL31.RESET;
                            RecSL31.SETRANGE("Document Type", rec."Document Type");
                            RecSL31.SETRANGE("Document No.", rec."No.");
                            RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::"G/L Account");
                            RecSL31.SETFILTER("TCS Nature of Collection", '<>%1', '');
                            IF RecSL31.FINDFIRST THEN
                                ERROR('Invalid TCS applied on line=%1', RecSL31."Line No.");

                            IF (CustAmt + AmtToCustBill) <= GLSetup."TCS Threshold Amount" THEN BEGIN
                                RecSL31.RESET;
                                RecSL31.SETRANGE("Document Type", rec."Document Type");
                                RecSL31.SETRANGE("Document No.", rec."No.");
                                RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                RecSL31.SETFILTER("TCS Nature of Collection", '<>%1', '');
                                IF RecSL31.FINDFIRST THEN
                                    ERROR('Invalid TCS applied on line=%1', RecSL31."Line No.");
                            END ELSE BEGIN
                                RecSL31.RESET;
                                RecSL31.SETRANGE("Document Type", rec."Document Type");
                                RecSL31.SETRANGE("Document No.", rec."No.");
                                RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                RecSL31.SETFILTER("Assessee Code", '%1', '');
                                IF RecSL31.FINDFIRST THEN BEGIN
                                    rec.TESTFIELD(rec."Assessee Code");
                                    ERROR('Please select Assessee Code in Sales Invoice Line=%1', RecSL31."Assessee Code");
                                END;

                                IF recCustomernew.GET(rec."Bill-to Customer No.") THEN BEGIN //RSPl AM03072021 >>
                                    IF NOT recCustomernew."Turnover Above 10 Crores" THEN BEGIN  //RSPl AM03072021 >>
                                        RecSL31.RESET;
                                        RecSL31.SETRANGE("Document Type", rec."Document Type");
                                        RecSL31.SETRANGE("Document No.", rec."No.");
                                        RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
                                        RecSL31.SETFILTER("TCS Nature of Collection", '%1', '');
                                        IF RecSL31.FINDFIRST THEN BEGIN//RSPLSUM22Feb21>>
                                            RecSL32.RESET;
                                            RecSL32.SETRANGE("Document Type", rec."Document Type");
                                            RecSL32.SETRANGE("Document No.", rec."No.");
                                            RecSL32.SETFILTER("No.", '<>%1', '');
                                            RecSL32.SETRANGE("Free of Cost", FALSE);
                                            IF RecSL32.FINDFIRST THEN
                                                ERROR('Amount Exceeds TCS Threshold Amount, Please apply TCS');
                                        END;//RSPLSUM22Feb21<<
                                    END; //RSPl AM03072021 <<
                                END; //RSPl AM03072021 <<
                            END;
                        END;
                    END;
                END;
                //RSPLSUM-TCS<<

                //RSPLSUM 03Dec20>>
                RecSLNew.RESET;//RSPLSUM 05Dec2020>>
                RecSLNew.SETRANGE("Document No.", rec."No.");
                RecSLNew.SETRANGE("Document Type", rec."Document Type");
                RecSLNew.SETFILTER(Quantity, '<>%1', 0);
                RecSLNew.SETRANGE("Free of Cost", FALSE);
                IF RecSLNew.FINDFIRST THEN BEGIN//RSPLSUM 05Dec2020<<
                    SL18.RESET;//RSPLSUM 19Dec2020>>
                    SL18.SETRANGE("Document No.", rec."No.");
                    SL18.SETRANGE("Document Type", rec."Document Type");
                    SL18.SETFILTER("Inventory Posting Group", '<>%1', 'MERCH');
                    IF SL18.FINDFIRST THEN BEGIN//RSPLSUM 19Dec2020<<
                        // RecDetGSTEntBuff.RESET;
                        // RecDetGSTEntBuff.SETRANGE(rec."Transaction Type", RecDetGSTEntBuff."Transaction Type"::Sales);
                        // RecDetGSTEntBuff.SETRANGE(rec."Document Type", rec."Document Type");
                        // RecDetGSTEntBuff.SETRANGE("Document No.", rec."No.");
                        // IF NOT RecDetGSTEntBuff.FINDFIRST THEN
                        //     ERROR('Detailed GST Entry Buffer does not exist, Please calculate structure values.');
                    END;

                END;
                //RSPLSUM 03Dec20<<

                //RSPLSUM 11May2020>>
                CI22.GET;
                IF CI22."Customer Credit Validation" THEN
                    IF rec."Customer Posting Group" = 'FO' THEN //05Jul2018
                    BEGIN
                        Cust22.RESET;
                        IF Cust22.GET(rec."Sell-to Customer No.") THEN BEGIN
                            IF Cust22."Approval Status" <> Cust22."Approval Status"::Approved THEN
                                ERROR('Customer is Not Approved');

                            IF Cust22."Credit Limit Approval Status" <> Cust22."Credit Limit Approval Status"::Approved THEN
                                ERROR('Customer Credit Limit is Not Approved');
                        END;
                    END;
                //RSPLSUM 11May2020<<


                //EBT STIVAN ---(24/08/2012)--- Release Rights as per Sales Approval Setup ----------------------START
                recSalesApproval.RESET;
                recSalesApproval.SETRANGE(recSalesApproval."Approvar ID", USERID);
                IF recSalesApproval.FINDFIRST THEN BEGIN
                    // ReleaseSalesDoc.PerformManualRelease(Rec);
                END ELSE
                    ERROR('You are not authorised to Release the Supplimentary Invoice');
                //EBT STIVAN ---(24/08/2012)--- Release Rights as per Sales Approval Setup ------------------------END
            END;

        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    BEGIN
        //          {
        //          CSOMapping2.RESET;
        // CSOMapping2.SETRANGE(CSOMapping2."User Id", UPPERCASE(USERID));
        // IF CSOMapping2.FINDFIRST THEN BEGIN
        //     //FILTERGROUP(2);
        //     SuppInv.RESET;
        //     SuppInv.SETRANGE(SuppInv."Document Type", "Document Type");
        //     SuppInv.SETFILTER(SuppInv."Short Close", '%1', FALSE);
        //     IF SuppInv.FINDSET THEN
        //         REPEAT
        //             CSOMapping.RESET;
        //             CSOMapping.SETRANGE(CSOMapping."User Id", UPPERCASE(USERID));
        //             CSOMapping.SETRANGE(CSOMapping.Type, CSOMapping.Type::"Responsibility Center");
        //             CSOMapping.SETRANGE(CSOMapping.Value, SuppInv."Responsibility Center");
        //             IF CSOMapping.FINDFIRST THEN
        //                 SuppInv.MARK := TRUE
        //             ELSE BEGIN
        //                 CSOMapping1.RESET;
        //                 CSOMapping1.SETRANGE("User Id", UPPERCASE(USERID));
        //                 CSOMapping1.SETRANGE(Type, CSOMapping.Type::Location);
        //                 CSOMapping1.SETRANGE(Value, SuppInv."Location Code");
        //                 IF CSOMapping1.FINDFIRST THEN
        //                     SuppInv.MARK := TRUE
        //             END;
        //         UNTIL SuppInv.NEXT = 0;
        //     SuppInv.MARKEDONLY(TRUE);
        //     COPY(SuppInv);
        //     //FILTERGROUP(0);
        // END
        // ELSE BEGIN
        //     IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
        //         FILTERGROUP(2);
        //         SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
        //         FILTERGROUP(0);
        //     END;
        // END;
        //          }
        //--RSPLSUM 18Mar2020--SETRANGE("Supplimentary Invoice",TRUE);

        //>>Robosoft\Migration
        IF rec."No." <> '' THEN BEGIN
            IF rec."Posting Date" <> TODAY THEN BEGIN
                rec."Posting Date" := TODAY;
                rec.MODIFY;
            END;

            IF rec."Shipment Date" <> TODAY THEN BEGIN
                rec."Shipment Date" := TODAY;
                SalesLine1.RESET;
                SalesLine1.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                SalesLine1.SETRANGE("Document Type", rec."Document Type");
                SalesLine1.SETRANGE("Document No.", rec."No.");
                IF SalesLine1.FINDSET THEN
                    REPEAT
                        SalesLine1."Shipment Date" := TODAY;
                        SalesLine1.MODIFY;
                    UNTIL SalesLine1.NEXT = 0;
                rec.MODIFY;
            END;
        END;

        //>>

        //>>28Aug2018
        DueDateGP;
        //<<28Aug2018

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        rec."Document Type" := rec."Document Type"::Invoice;
    end;



    var
        CSOMapping2: Record 50006;
        SuppInv: Record 36;
        CSOMapping: Record 50006;
        CSOMapping1: Record 50006;
        recSalesApproval: Record 50008;
        SalesLine1: Record 37;
        RecCustNew: Record 18;
        CI22: Record 79;
        Cust22: Record 18;
        SH21: Record 36;
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
        //  RecDetGSTEntBuff: Record 16412;
        RecSLNew: Record 37;
        SL18: Record 37;
        RecSL32: Record 37;
        SalesLineRec1: Record 37;
        SalesLineRec2: Record 37;
        GSTGrpCode: Code[10];
        recCustomernew: Record 18;
        PoT: Boolean;

    LOCAL PROCEDURE DueDateGP();
    VAR
        PayTerm05: Record 3;
        Cust05: Record 18;
    BEGIN
        //>>28Aug2018 RB-N
        IF (rec."No." <> '') THEN BEGIN
            rec."Date GP" := TODAY;
            IF (rec."Payment Terms Code" <> '') THEN BEGIN
                PayTerm05.GET(rec."Payment Terms Code");
                rec."Due Date" := CALCDATE(PayTerm05."Due Date Calculation", rec."Date GP");
            END;
            // {
            // IF rec."Sell-to Customer No." <> '' THEN BEGIN
            //         Cust05.RESET;
            //         IF Cust05.GET(rec."Sell-to Customer No.") THEN;
            //         rec."Due Date" := CALCDATE(Cust05."Approved Payment Days", rec."Due Date");
            //     END;
            // }//03Jan2019 Code Commented for Extra Grace Period
            rec.MODIFY;
        END;
        //<<28Aug2018 RB-N
    END;

}