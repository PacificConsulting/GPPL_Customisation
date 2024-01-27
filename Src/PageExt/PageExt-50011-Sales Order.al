pageextension 50011 SalesOrderExt extends "Sales Order"
{
    // SourceTableView=WHERE(Document Type=CONST(Order),   Short Close=FILTER(No));
    layout
    {
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

                //EBT STIVAN ---(18102012)--- To Update the Sell to State Desc and Ship to State Desc on Form Level------START
                CLEAR(StateDesc);
                CLEAR(Ship2StateDesc);
                recState.RESET;
                recState.SETRANGE(recState.Code, rec.State);
                IF recState.FINDFIRST THEN BEGIN
                    StateDesc := recState.Description;
                    Ship2StateDesc := recState.Description;
                END;
                //EBT STIVAN ---(18102012)--- To Update the Sell to State Desc and Ship to State Desc on Form Level--------END

                // SelltoCustomerNoOnAfterValidat;

                //>>05Jul2018
                IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN //RSPLSUM 28May2020
                    DueDateGP;
                //<<05Jul2018
            END;
        }


        modify("Ship-to Code")
        {
            Importance = Promoted;
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                //EBT STIVAN ---(18102012)--- To Update the Sell to State Desc and Ship to State Desc on Form Level------START
                IF rec."Ship-to Code" <> '' THEN BEGIN
                    Ship2Add.RESET;
                    Ship2Add.SETRANGE(Ship2Add."Customer No.", rec."Sell-to Customer No.");
                    Ship2Add.SETRANGE(Ship2Add.Code, rec."Ship-to Code");
                    IF Ship2Add.FINDFIRST THEN BEGIN
                        CLEAR(Ship2StateDesc);
                        recState1.RESET;
                        recState1.SETRANGE(recState1.Code, Ship2Add.State);
                        IF recState1.FINDFIRST THEN BEGIN
                            Ship2StateDesc := recState1.Description;
                        END;
                    END;
                END ELSE BEGIN
                    CLEAR(Ship2StateDesc);
                    recState1.RESET;
                    recState1.SETRANGE(recState1.Code, rec.State);
                    IF recState1.FINDFIRST THEN BEGIN
                        Ship2StateDesc := recState1.Description;
                    END;
                END;
                //EBT STIVAN ---(18102012)--- To Update the Sell to State Desc and Ship to State Desc on Form Level--------END
            END;
        }
        modify("Payment Method Code")
        {
            ApplicationArea = all;
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                //>>05Jul2018
                IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN //RSPLSUM 28May2020
                    DueDateGP;
                //<<05Jul2018
            END;
        }
        modify("Payment Terms Code")
        {
            Editable = (PayTermEditable) OR (EditBunkerFields);
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN

                //>>05Jul2018
                IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN //RSPLSUM 28May2020
                    DueDateGP;
                //<<05Jul2018
            END;
        }
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                //EBT STIVAN ---(21062012)--- To make SalesPerson Code Editable if Division is DIV-03 ----------START
                //CurrForm."Salesperson Code".EDITABLE := "Shortcut Dimension 1 Code" = 'DIV-03';
                //RSPL-TC +
                IF rec."Shortcut Dimension 1 Code" = 'DIV-03' THEN
                    SalesPerCodeEditable := TRUE;
                //EBT STIVAN ---(21062012)--- To make SalesPerson Code Editable if Division is DIV-03 ------------END
                //RSPL-TC -
                // ShortcutDimension1CodeOnAfterV;
            END;
        }
        modify("External Document No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                //RSPLSUM BEGIN>>
                //          {
                //          //RSPL-TC +
                //          IF "External Document No." <> '' THEN
                // IF STRLEN("External Document No.") > 20 THEN
                //     ERROR('External Document No. should not more then 20 characters');
                //          //RSPL-TC -
                //          }

                IF rec."External Document No." <> '' THEN
                    IF STRLEN(rec."External Document No.") > 16 THEN
                        ERROR('External Document No. should not be more than 16 characters');
                //RSPLSUM END<<
            END;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                //RSPLSUM 25May2020>>
                IF rec."Shortcut Dimension 1 Code" = 'DIV-14' THEN BEGIN
                    IF rec."Posting Date" < rec."Shipment Date" THEN
                        ERROR('Please enter date greater than or equal to shipment date');
                END;
                //RSPLSUM 25May2020<<
            END;
        }
        modify("Shipment Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                //RSPLSUM 25May2020>>
                IF rec."Shortcut Dimension 1 Code" = 'DIV-14' THEN BEGIN
                    DueDateGPIPOL;
                END;
            END;
        }
        addafter("No.")
        {

            field("Transport Type"; rec."Transaction Type")
            {

                ApplicationArea = all;
            }
            field("Dispatch Code"; Rec."Dispatch Code")
            {
                ApplicationArea = all;
            }
            field("EWB Transaction Type"; Rec."EWB Transaction Type")
            {
                ApplicationArea = all;
            }
            field("E-Way Bill No."; Rec."E-Way Bill No.")
            {
                ApplicationArea = all;
            }
            field("Bank Account No."; rec."Bank Account No.")
            {
                ApplicationArea = all;
            }
            field("Loading Port Name"; Rec."Loading Port Name")
            {
                ApplicationArea = all;
            }
            field(Ship2StateDesc; Ship2StateDesc)
            {
                Caption = 'Ship-to State';
                ApplicationArea = all;
            }
            field("Shipping No."; Rec."Shipping No.")
            {
                ApplicationArea = all;
            }
            field("Shipping No. Series"; rec."Shipping No. Series")
            {
                ApplicationArea = all;
            }
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = all;
                Editable = FALSE;
            }
            field("Posting No. Series"; rec."Posting No. Series")
            {
                ApplicationArea = all;
            }
            field(Amount; rec.Amount)
            {
                ApplicationArea = all;
            }
            field("Mintifi Channel Finance"; rec."Mintifi Channel Finance")
            {
                ApplicationArea = all;
                Editable = EditMintifiFinChnl;
            }
            field("Approval Description"; rec."Approval Description")
            {
                ApplicationArea = all;
                Editable = AppDescEditable;
            }
            field("Credit / OverDue Remarks"; rec."Credit / OverDue Remarks")
            {
                ApplicationArea = all;
            }
            field("Sent For Approval"; rec."Sent For Approval")
            {
                ApplicationArea = all;
                Visible = FALSE;
                Editable = FALSE;
            }
            field("Credit Limit Approval"; rec."Credit Limit Approval")
            {
                ApplicationArea = all;
                Editable = FALSE;
                Style = Attention;
                StyleExpr = TRUE;
            }
            field("Dimension Set ID"; rec."Dimension Set ID")

            {
                ApplicationArea = all;
                Visible = FALSE;
            }
            field("Distance in kms"; rec."Distance in kms")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Customer Kms"; rec."Customer Kms")
            {
                ApplicationArea = all;
            }
            field("Cr. Approved"; rec."Cr. Approved")
            {
                ApplicationArea = all;
            }


            field("Get Entry Outward"; rec."Get Entry Outward")
            {
                ApplicationArea = all;
                Visible = FALSE;
                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                BEGIN
                    //NB28902 Start
                    GateEntryHeader.RESET;
                    GateEntryHeader.SETRANGE("Location Code", rec."Location Code");
                    GateEntryHeader.SETRANGE(Transporter, rec."Shipping Agent Code");
                    CLEAR(OutwardEntryPage);
                    OutwardEntryPage.SETRECORD(GateEntryHeader);
                    OutwardEntryPage.SETTABLEVIEW(GateEntryHeader);
                    OutwardEntryPage.LOOKUPMODE(TRUE);
                    IF OutwardEntryPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        OutwardEntryPage.GETRECORD(GateEntryHeader);
                        rec."Get Entry Outward" := GateEntryHeader."No.";
                    END;
                    //NB28902 End
                    //NB28902 Start
                    GateEntryHeader.RESET;
                    GateEntryHeader.SETRANGE(GateEntryHeader."No.", rec."Get Entry Outward");
                    IF GateEntryHeader.FINDFIRST THEN BEGIN
                        rec.VALIDATE("Driver's Name", GateEntryHeader."Driver's Name");
                        rec.VALIDATE("Driver's License No.", GateEntryHeader."Driver's License No.");
                        rec.VALIDATE("Vehicle No.", GateEntryHeader."Vehicle No.");
                        rec.VALIDATE("Vehicle Capacity", GateEntryHeader."Vehicle Capacity");
                    END;
                    CurrPage.UPDATE(TRUE);
                    //NB28902 end
                END;
            }
            field("Short Close"; rec."Short Close")
            {
                ApplicationArea = all;
                Editable = ShortCloseEdtiable;
            }
            field("Short Close Date"; rec."Short Close Date")
            {
                ApplicationArea = all;
            }
            field("Sales Order Type"; rec."Sales Order Type")
            {
                ApplicationArea = all;
                Editable = FALSE;
            }

            field("Suppy Location"; rec."Supply Location Name")
            {
                ApplicationArea = all;
                //  SourceExpr =UPPERCASE("Supply Location Name");
                Editable = false;
                Style = Favorable;
                StyleExpr = TRUE;
            }

            group("Local+Intercity Details")
            {
                field("Local LR No."; Rec."Local LR No.")
                {
                    ApplicationArea = all;
                }
                field("Local LR Date"; Rec."Local LR Date")
                {
                    ApplicationArea = all;
                }
                field("Local Vehicle No."; Rec."Local Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("Local Driver's Name"; Rec."Local Driver's Name")
                {
                    ApplicationArea = all;
                }
                field("Local Vehicle Capacity"; Rec."Local Vehicle Capacity")
                {
                    ApplicationArea = all;
                }
                field("Local Expected TPT Cost"; Rec."Local Expected TPT Cost")
                {
                    ApplicationArea = all;
                }
            }
            group("Intercity Details")
            {
                field("Freight Type"; Rec."Freight Type")
                {
                    ApplicationArea = all;
                }
                // field("Vehicle No."; Rec."Vehicle No.")
                // {
                //     ApplicationArea = all;
                //     trigger OnValidate()
                //     var
                //         myInt: Integer;
                //     BEGIN
                //         //RSPLSUM 17Mar2020>>
                //         IF rec."Vehicle No." <> '' THEN BEGIN
                //             j := 32;
                //             FOR i := 1 TO 16 DO BEGIN
                //                 SCArray[i] := j;
                //                 j += 1;
                //             END;

                //             j := 58;
                //             FOR i := 17 TO 23 DO BEGIN
                //                 SCArray[i] := j;
                //                 j += 1;
                //             END;

                //             j := 91;
                //             FOR i := 24 TO 29 DO BEGIN
                //                 SCArray[i] := j;
                //                 j += 1;
                //             END;

                //             j := 123;
                //             FOR i := 30 TO 33 DO BEGIN
                //                 SCArray[i] := j;
                //                 j += 1;
                //             END;

                //             FOR i := 1 TO 33 DO BEGIN
                //                 Pos := STRPOS(rec."Vehicle No.", FORMAT(SCArray[i]));
                //                 IF Pos <> 0 THEN
                //                     ERROR('Special character and space are not allowed');
                //             END;
                //         END;
                //         //RSPLSUM 17Mar2020<<
                //     END;

                field("Driver's Name"; rec."Driver's Name")
                {
                    ApplicationArea = all;
                }
                field("Driver's License No."; rec."Driver's License No.")
                {
                    ApplicationArea = all;
                    Editable = DrivLicNoEditable;
                }
                field("Driver's Mobile No."; rec."Driver's Mobile No.")
                {
                    Editable = DrivMobNoEditable;
                }
                field("Vehicle Capacity"; rec."Vehicle Capacity")
                {
                    Editable = VechCapEtdiable;
                }
                field("Expected TPT Cost"; rec."Expected TPT Cost")
                {
                    ApplicationArea = all;
                }
                field("Expected Loading"; rec."Expected Loading")
                {
                    ApplicationArea = all;
                }

            }
            group(Others)
            {


                field("Freight Charges"; rec."Freight Charges")
                {
                    ApplicationArea = all;

                }
                field("Export Under Rebate"; rec."Export Under Rebate")
                {
                    ApplicationArea = all;

                }
                field("Under Rebate"; rec."Under Rebate")
                {
                    ApplicationArea = all;
                    caption = 'Export Under Rebate Check';
                }
                field("Export Under LUT"; rec."Export Under LUT")
                {
                    ApplicationArea = all;

                }
                field("Under LUT"; rec."Under LUT")
                {
                    ApplicationArea = all;
                    caption = 'Export Under LUT Check';

                }
                field("Ex-Factory"; rec."Ex-Factory")
                {
                    ApplicationArea = all;
                }

            }
            group("CT3 Details")
            {
                field("CT3 Order"; rec."CT3 Order")
                {
                    ApplicationArea = all;
                }
                field("CT3 No."; rec."CT3 No.")
                {
                    ApplicationArea = all;
                }
                field("CT3 Date"; rec."CT3 Date")
                {
                    ApplicationArea = all;
                }
                field("ARE3 No."; rec."ARE3 No.")
                {
                    ApplicationArea = all;
                }
                field("ARE3 Date"; rec."ARE3 Date")
                {
                    ApplicationArea = all;
                }

            }
            group("CT1 Details")
            {
                field("CT1 Order"; rec."CT1 Order")
                {
                    ApplicationArea = all;
                }
                field("CT1 No."; rec."CT1 No.")
                {
                    ApplicationArea = all;
                }
                field("CT1 Date"; rec."CT1 Date")
                {
                    ApplicationArea = all;
                }
                field("ARE1 No."; rec."ARE1 No.")
                {
                    ApplicationArea = all;
                }
                field("ARE1 Date"; rec."ARE1 Date")
                {
                    ApplicationArea = all;
                }
            }

        }
        // Add changes to page layout here


    }

    actions
    {


        // modify(Print)
        // {
        //     ActionContainerType =Reports;
        //     trigger OnAfterAction()
        //     var
        //         myInt: Integer;
        //     begin

        //     end;
        // }
        // modify(Post)
        // {
        //     trigger OnAfterAction()
        //     VAR
        //         SalesPostPrint: Codeunit 82;
        //     BEGIN
        //         //RSPLSUM 09Nov2020>>
        //         RecSalesLineNew.RESET;
        //         RecSalesLineNew.SETCURRENTKEY("Document Type", "Document No.", Type);
        //         RecSalesLineNew.SETRANGE("Document Type", rec."Document Type");
        //         RecSalesLineNew.SETRANGE("Document No.", rec."No.");
        //         RecSalesLineNew.SETRANGE(RecSalesLineNew.Type, RecSalesLineNew.Type::Item);
        //         IF RecSalesLineNew.FINDFIRST THEN
        //             rec.TESTFIELD("Shipment Method Code");
        //         //RSPLSUM 09Nov2020<<

        //         //RSPLSUM-TCS>>
        //         //IF "Customer Posting Group" <> 'FOREIGN' THEN BEGIN
        //         IF rec."GST Customer Type" <> "GST Customer Type"::Export THEN BEGIN
        //             RecSL29.RESET;
        //             RecSL29.SETRANGE("Document Type", rec."Document Type");
        //             RecSL29.SETRANGE("Document No.", rec."No.");
        //             RecSL29.SETFILTER("Inventory Posting Group", '%1', 'COAL');
        //             IF NOT RecSL29.FINDFIRST THEN BEGIN
        //                 RecSL28.RESET;
        //                 RecSL28.SETRANGE("Document Type", rec."Document Type");
        //                 RecSL28.SETRANGE("Document No.", rec."No.");
        //                 RecSL28.SETFILTER("TCS Nature of Collection", '%1', 'SCRAP');
        //                 IF NOT RecSL28.FINDFIRST THEN BEGIN
        //                     GLSetup.GET;
        //                     CLEAR(CustAmt);
        //                     RecCustomerN.RESET;
        //                     IF RecCustomerN.GET(rec."Bill-to Customer No.") THEN BEGIN
        //                         IF RecCustomerN."P.A.N. No." <> '' THEN BEGIN
        //                             RecCustomerNP.RESET;
        //                             RecCustomerNP.SETCURRENTKEY("P.A.N. No.");
        //                             RecCustomerNP.SETRANGE("P.A.N. No.", RecCustomerN."P.A.N. No.");
        //                             IF RecCustomerNP.FINDSET THEN
        //                                 REPEAT
        //                                     RecCustLedgEntry.RESET;
        //                                     RecCustLedgEntry.SETCURRENTKEY("Customer No.", "Document Type", "Posting Date");
        //                                     RecCustLedgEntry.SETRANGE("Customer No.", RecCustomerNP."No.");
        //                                     RecCustLedgEntry.SETFILTER("Document Type", '%1|%2', RecCustLedgEntry."Document Type"::Invoice, RecCustLedgEntry."Document Type"::"Credit Memo");
        //                                     RecCustLedgEntry.SETRANGE("Posting Date", GLSetup."TCS Threshold Starting Date", rec."Posting Date");
        //                                     IF RecCustLedgEntry.FINDSET THEN
        //                                         REPEAT
        //                                             RecCustLedgEntry.CALCFIELDS("Amount (LCY)");
        //                                             CustAmt += RecCustLedgEntry."Amount (LCY)";
        //                                         UNTIL RecCustLedgEntry.NEXT = 0;
        //                                 UNTIL RecCustomerNP.NEXT = 0;
        //                         END ELSE BEGIN
        //                             RecCustLedgEntry.RESET;
        //                             RecCustLedgEntry.SETCURRENTKEY("Customer No.", "Document Type", "Posting Date");
        //                             RecCustLedgEntry.SETRANGE("Customer No.", rec."Bill-to Customer No.");
        //                             RecCustLedgEntry.SETFILTER("Document Type", '%1|%2', RecCustLedgEntry."Document Type"::Invoice, RecCustLedgEntry."Document Type"::"Credit Memo");
        //                             RecCustLedgEntry.SETRANGE("Posting Date", GLSetup."TCS Threshold Starting Date", rec."Posting Date");
        //                             IF RecCustLedgEntry.FINDSET THEN
        //                                 REPEAT
        //                                     RecCustLedgEntry.CALCFIELDS("Amount (LCY)");
        //                                     CustAmt += RecCustLedgEntry."Amount (LCY)";
        //                                 UNTIL RecCustLedgEntry.NEXT = 0;
        //                         END;
        //                     END;

        //                     CLEAR(AmtToCustBill);
        //                     RecSL30.RESET;
        //                     RecSL30.SETCURRENTKEY("Document Type", "Document No.");
        //                     RecSL30.SETRANGE("Document Type", rec."Document Type");
        //                     RecSL30.SETRANGE("Document No.", rec."No.");
        //                     RecSL30.CALCSUMS("Amount To Customer");
        //                     AmtToCustBill := RecSL30."Amount To Customer";

        //                     RecSL31.RESET;
        //                     RecSL31.SETRANGE("Document Type", rec."Document Type");
        //                     RecSL31.SETRANGE("Document No.", rec."No.");
        //                     RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::"G/L Account");
        //                     RecSL31.SETFILTER("TCS Nature of Collection", '<>%1', '');
        //                     IF RecSL31.FINDFIRST THEN
        //                         ERROR('Invalid TCS applied on line=%1', RecSL31."Line No.");

        //                     IF (CustAmt + AmtToCustBill) <= GLSetup."TCS Threshold Amount" THEN BEGIN
        //                         RecSL31.RESET;
        //                         RecSL31.SETRANGE("Document Type", rec."Document Type");
        //                         RecSL31.SETRANGE("Document No.", rec."No.");
        //                         RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
        //                         RecSL31.SETFILTER("TCS Nature of Collection", '<>%1', '');
        //                         IF RecSL31.FINDFIRST THEN
        //                             ERROR('Invalid TCS applied on line=%1', RecSL31."Line No.");
        //                     END ELSE BEGIN
        //                         RecSL31.RESET;
        //                         RecSL31.SETRANGE("Document Type", rec."Document Type");
        //                         RecSL31.SETRANGE("Document No.", rec."No.");
        //                         RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
        //                         RecSL31.SETFILTER("Assessee Code", '%1', '');
        //                         IF RecSL31.FINDFIRST THEN BEGIN
        //                             rec.TESTFIELD("Assessee Code");
        //                             ERROR('TCS Applicable. Please select Assessee Code in Sales Order Line=%1', RecSL31."Assessee Code");
        //                         END;

        //                         IF recCustomernew.GET(rec."Bill-to Customer No.") THEN BEGIN //RSPl AM03072021 >>
        //                             IF NOT recCustomernew."Turnover Above 10 Crores" THEN BEGIN  //RSPl AM03072021 >>
        //                                 RecSL31.RESET;
        //                                 RecSL31.SETRANGE("Document Type", rec."Document Type");
        //                                 RecSL31.SETRANGE("Document No.", rec."No.");
        //                                 RecSL31.SETRANGE(RecSL31.Type, RecSL31.Type::Item);
        //                                 RecSL31.SETFILTER("TCS Nature of Collection", '%1', '');
        //                                 IF RecSL31.FINDFIRST THEN BEGIN//RSPLSUM22Feb21>>
        //                                     RecSL32.RESET;
        //                                     RecSL32.SETRANGE("Document Type", rec."Document Type");
        //                                     RecSL32.SETRANGE("Document No.", rec."No.");
        //                                     RecSL32.SETFILTER("No.", '<>%1', '');
        //                                     RecSL32.SETRANGE("Free of Cost", FALSE);
        //                                     IF RecSL32.FINDFIRST THEN
        //                                         ERROR('Amount Exceeds TCS Threshold Amount, Please apply TCS');
        //                                 END;//RSPLSUM22Feb21<<
        //                             END; //RSPL AM03072021  <<
        //                         END; //RSPL AM03072021 <<
        //                     END;
        //                 END;
        //             END;
        //         END;
        //         //RSPLSUM-TCS<<

        //         rec.TESTFIELD("Distance in kms");//RSPLSUM 12Mar2020
        //         rec.TESTFIELD("EWB Transaction Type");//RSPLSUM 19Mar2020
        //         IF rec."Shortcut Dimension 1 Code" = 'DIV-14' THEN //RSPLSUM 28May2020
        //             rec.TESTFIELD("Bank Account No.");//RSPLSUM 28May2020
        //         FOCValidation;//03Apr2019
        //         rec.TESTFIELD("Freight Type");
        //         SalesPostPrint.PostAndEmail(Rec);
        //     END;
        // }

        // modify("Post and Print")
        // {
        //     trigger OnAfterAction()
        //     var
        //         myInt: Integer;
        //     begin
        //     end;

        // }
        // modify("Calc&ulate Structure Values")
        // {
        //     Image = CalculateHierarchy;
        //     trigger OnAfterAction()
        //     var
        //         myInt: Integer;
        //     begin

        //     end;

        // }
        modify(Reopen)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                //EBT/OVERDUE/APV/0001
                //                  {
                //                  SalesApprovalEntry.RESET;
                // SalesApprovalEntry.SETRANGE(SalesApprovalEntry."Document No.", "No.");
                // IF SalesApprovalEntry.FINDFIRST THEN BEGIN
                //     SalesApprovalEntry.DELETE;
                // END;
                //                  }

                //>>RB-N 17Nov2017
                SL17.RESET;
                SL17.SETRANGE("Document Type", rec."Document Type");
                SL17.SETRANGE("Document No.", rec."No.");
                SL17.CALCSUMS("Quantity Shipped");
                IF SL17.FINDFIRST THEN BEGIN
                    SalesApprovalEntry.RESET;
                    SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Sales Order");
                    SalesApprovalEntry.SETRANGE(SalesApprovalEntry."Document No.", rec."No.");
                    SalesApprovalEntry.SETRANGE(Approved, FALSE);//RB-N 20Dec2017
                    SalesApprovalEntry.SETRANGE(Rejected, FALSE);//RB-N 23May2018
                    IF SalesApprovalEntry.FINDFIRST THEN BEGIN
                        SalesApprovalEntry.DELETEALL(TRUE);
                    END;
                END;
                //>>RB-N 17Nov2017

                rec."Cr. Approved" := FALSE;
                rec."Sent For Approval" := FALSE;
                rec."Campaign No." := '';            //EBT STIVAN --(02052012)-- For Approval Process.
                                                     //RSPL022 >>  Credit Limit Approval ------------------------------
                rec."Credit Limit Approval" := rec."Credit Limit Approval"::Open;
                //RSPL022 <<  Credit Limit Approval ------------------------------

                rec."Over Due Approval" := FALSE; //RB-N 08Sep2017
                rec."Credit Approval Rejection" := FALSE;//RB-N 03Jul2018
                rec."OverDue Approval Rejection" := FALSE;//RB-N 03Jul2018

                rec.MODIFY;
                //EBT/OVERDUE/APV/0001
            END;


        }
        modify(Release)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            BEGIN
                //EBT0002
                IF rec."Shortcut Dimension 1 Code" = 'DIV-04' THEN BEGIN
                    IF rec.Trading THEN BEGIN
                        SaleLineNew.RESET;
                        SaleLineNew.SETRANGE(SaleLineNew."Document No.", rec."No.");
                        SaleLineNew.SETRANGE(SaleLineNew.Type, SaleLineNew.Type::Item);
                        IF SaleLineNew.FINDSET THEN
                            REPEAT
                                IF SaleLineNew."Inventory Posting Group" <> 'MERCH' THEN//RSPL301215
                                    IF SaleLineNew."Lot No." = '' THEN
                                        ERROR('You need to select Item Tracking Before Releasing the Document');
                            UNTIL SaleLineNew.NEXT = 0;
                    END;
                END;
                //EBT0002

                IF rec."Shipping Agent Code" = '' THEN
                    ERROR('Shipping Agent Code is Blank');
                //EBT/APV/0001
                IF UPPERCASE(USERID) = rec."Created By" THEN
                    ERROR('You are not authorised to release the Document.');
                IF UPPERCASE(USERID) <> 'SA' THEN
                    ERROR('You cannot release Document directly');
                //EBT/APV/0001


                //EBT/OVERDUE/APV/0001
                //                  {
                //                  IF "Required MD Approval" THEN
                //     ERROR('Document No %1 must be approved by MD as Customer No. %2 has excceded his Credit Tolarance Level.', "No.",
                //            "Sell-to Customer No.");
                // IF ("Cust. Overdue Balance" OR "Cust. Over Cr. Limit") THEN BEGIN
                //     IF NOT "Cr. Approved" THEN
                //         ERROR('Sales Order %1 must be approved for Overdue/Cr. Limit', "No.");
                // END;
                //                  }
                //EBT/OVERDUE/APV/0001

            end;


        }
        modify(Statistics)
        {
            trigger OnAfterAction()

            VAR
                SL07: Record 37;
            BEGIN
                //>>13July2017

                //>> LineAmount Validation
                SL07.RESET;
                SL07.SETRANGE("Document No.", rec."No.");
                IF SL07.FINDSET THEN
                    REPEAT

                        IF NOT SL07."Free of Cost" THEN
                            IF SL07."Line Amount" = 0 THEN BEGIN

                                ERROR('Line Amount Cannot be Zero.\ Document No.: %1 \ Line No.: %2 ', SL07."Document No.", SL07."Line No.");

                            END;


                    UNTIL SL07.NEXT = 0;
                //<< LineAmount Validation
                // SalesLine.CalculateStructures(Rec); tempory comment
                // SalesLine.AdjustStructureAmounts(Rec);tempory comment
                // SalesLine.UpdateSalesLines(Rec);tempory comment

                //<<13July2017

            end;



        }
        modify(Post)
        {
            trigger OnBeforeAction()
            VAR
                SL09: Record 37;
                GST09: Record "Detailed GST Entry Buffer"; //16412;
                Itm24: Record 27;
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
                                    RecCustLedgEntry.SETRANGE("Posting Date", GLSetup."TCS Threshold Starting Date", Rec."Posting Date");
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
                                    ERROR('TCS Applicable. Please select Assessee Code in Sales Order Line=%1', RecSL31."Assessee Code");
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
                                            IF RecSL32.FINDFIRST THEN BEGIN
                                                //DJ 190621
                                                RecLocation.GET(rec."Location Code");
                                                IF RecLocation."Location Type" <> RecLocation."Location Type"::"High Seas" THEN
                                                    ERROR('Amount Exceeds TCS Threshold Amount, Please apply TCS');
                                            END;
                                            //DJ 190621
                                        END;//RSPLSUM22Feb21<<
                                    END;//RSPl AM03072021 <<
                                END;//RSPl AM03072021 <<
                            END;
                        END;
                    END;
                END;
                //RSPLSUM-TCS<<

                //TESTFIELD("Distance in kms");//RSPLSUM 12Mar2020
                //RSPLSUM09Apr21--TESTFIELD("Get Entry Outward"); //Nb 28902
                IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN
                    rec.TESTFIELD("EWB Transaction Type");//RSPLSUM 19Mar2020
                                                          //RSPLSUM 13Nov2019>>
                rec.TESTFIELD("Salesperson Code");
                SalespersonPurchaser.RESET;
                IF SalespersonPurchaser.GET(rec."Salesperson Code") THEN
                    SalespersonPurchaser.TESTFIELD("E-Mail");
                UserSetupRec.RESET;
                IF UserSetupRec.GET(USERID) THEN
                    UserSetupRec.TESTFIELD("E-Mail");
                //RSPLSUM 13Nov2019<<

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

                IF rec."Shortcut Dimension 1 Code" = 'DIV-14' THEN //RSPLSUM 28May2020
                    rec.TESTFIELD("Bank Account No.");//RSPLSUM 28May2020

                FOCValidation;//03Apr2019
                              //>>09Aug2017 SplitLine GST Calculation
                              // IF (rec.Structure <> '') THEN BEGIN
                              //     SL09.RESET;
                              //     SL09.SETRANGE("Document No.", rec."No.");
                              //     SL09.SETRANGE("Free of Cost", FALSE);
                              //     SL09.SETFILTER("Inventory Posting Group", '<>%1', 'MERCH');
                              //     SL09.SETFILTER("IOPL Split Line No.", '<>%1', 0);
                              //     IF SL09.FINDSET THEN
                              //         REPEAT

                //             GST09.RESET;
                //             GST09.SETRANGE("Document No.", SL09."Document No.");
                //             GST09.SETRANGE("Line No.", SL09."Line No.");
                //             GST09.SETRANGE(Quantity, 0);
                //             IF GST09.FINDFIRST THEN BEGIN
                //                 ERROR('Please Calculate Structure Value for Split Line.\ Document No.: %1 \ Line No.: %2 ', SL09."Document No.", SL09."Line No.");

                //             END;

                //         UNTIL SL09.NEXT = 0;
                // END;
                //<<09Aug2017 SplitLine GST Calculation

                //TESTFIELD("Freight Type");
                //CAS-18282-F9P4T1 RB-N 10Oct2017
                IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN BEGIN
                    SL10.RESET;
                    SL10.SETRANGE("Document No.", rec."No.");
                    IF SL10.FINDSET THEN
                        REPEAT
                            IF SL10.Type <> SL10.Type::"G/L Account" THEN BEGIN
                                rec.TESTFIELD("Freight Type");
                                rec.TESTFIELD("Transport Type");
                            END;
                        UNTIL SL10.NEXT = 0;
                END;
                //CAS-18282-F9P4T1 RB-N

                lDimSetEntry.RESET;
                lDimSetEntry.SETRANGE("Dimension Set ID", rec."Dimension Set ID");
                lDimSetEntry.SETFILTER("Dimension Value Code", '%1|%2', '', 'PLEASE TAG DIMENSION');
                IF lDimSetEntry.FINDSET THEN
                    ERROR('Please Specify Correct Dimension Value');
                //RSPL008 >>>> Dimension Validation
                recSalLine.RESET;
                recSalLine.SETCURRENTKEY("Document No.", "Line No.");
                recSalLine.SETRANGE("Document No.", rec."No.");
                recSalLine.SETRANGE(Type, recSalLine.Type::Item);
                recSalLine.SETFILTER("No.", '<>%1', '');
                recSalLine.SETRANGE("Item Category Code", 'CAT14');
                IF recSalLine.FINDFIRST THEN
                    REPEAT
                        CLEAR(vInventQty);
                        //RSPL-TC +
                        lDimSetEntry.RESET;
                        lDimSetEntry.SETRANGE("Dimension Set ID", recSalLine."Dimension Set ID");
                        lDimSetEntry.SETFILTER("Dimension Value Code", '%1|%2', '', 'PLEASE TAG DIMENSION');
                        IF lDimSetEntry.FINDSET THEN
                            ERROR('Please Specify Correct Dimension Value');

                        RecDimSetEntry.RESET;
                        RecDimSetEntry.SETRANGE("Dimension Set ID", recSalLine."Dimension Set ID");
                        RecDimSetEntry.SETRANGE("Dimension Code", 'MERCH');
                        IF RecDimSetEntry.FINDSET THEN BEGIN
                            lDimSetEntry.RESET;
                            lDimSetEntry.SETRANGE("Dimension Code", RecDimSetEntry."Dimension Code");
                            lDimSetEntry.SETRANGE("Dimension Value Code", RecDimSetEntry."Dimension Value Code");
                            IF lDimSetEntry.FINDSET THEN
                                REPEAT
                                    recIlentry.RESET;
                                    recIlentry.SETRANGE("Dimension Set ID", lDimSetEntry."Dimension Set ID");
                                    recIlentry.SETRANGE("Item No.", recSalLine."No.");
                                    recIlentry.SETRANGE("Location Code", rec."Location Code");
                                    IF recIlentry.FINDSET THEN
                                        REPEAT
                                            vInventQty := vInventQty + recIlentry.Quantity
                                        UNTIL recIlentry.NEXT = 0;
                                UNTIL lDimSetEntry.NEXT = 0;
                            IF vInventQty < recSalLine.Quantity THEN
                                ERROR('Avaliable Qty %1 for the Item %2 Line %3', vInventQty, recSalLine."No.", recSalLine."Line No.");
                        END;
                    //RSPL-TC -
                    //    { //RSPL-TC
                    //      recDocDim.RESET;
                    //      recDocDim.SETRANGE("Table ID",37);
                    //      recDocDim.SETRANGE("Document Type","Document Type"::Order);
                    //      recDocDim.SETRANGE("Document No.",recSalLine."Document No.");
                    //      recDocDim.SETRANGE("Line No.",recSalLine."Line No.");
                    //      recDocDim.SETRANGE("Dimension Code",'MERCH');
                    //      IF recDocDim.FINDFIRST THEN BEGIN
                    //        recLedEntyDim.RESET;
                    //        recLedEntyDim.SETRANGE("Table ID",32);
                    //        recLedEntyDim.SETRANGE("Dimension Code",recDocDim."Dimension Code");
                    //        recLedEntyDim.SETRANGE("Dimension Value Code",recDocDim."Dimension Value Code");
                    //        IF recLedEntyDim.FINDFIRST THEN REPEAT
                    //           recIlentry.RESET;
                    //           recIlentry.SETCURRENTKEY("Entry No.");
                    //           recIlentry.SETRANGE("Entry No.",recLedEntyDim."Entry No.");
                    //           recIlentry.SETRANGE("Item No.",recSalLine."No.");
                    //           recIlentry.SETRANGE("Location Code","Location Code");
                    //           IF recIlentry.FINDFIRST THEN
                    //              vInventQty :=vInventQty+ recIlentry.Quantity
                    //             ELSE
                    //              vInventQty :=vInventQty;
                    //         UNTIL recLedEntyDim.NEXT=0;
                    //      IF  vInventQty < recSalLine.Quantity THEN
                    //         ERROR('Avaliable Qty %1 for the Item %2',vInventQty,recSalLine."No.");
                    //      END;}
                    UNTIL recSalLine.NEXT = 0;
                //RSPL008 <<<< Dimension Validation


                //>>RSPL/CUST/MERCH/001
                IF rec."No." <> 'CSO/45/1819/0009' THEN BEGIN//CAS-20803-Q6L8D4
                    recsalesLineTable.RESET;
                    recsalesLineTable.SETRANGE(recsalesLineTable."Document No.", rec."No.");
                    recsalesLineTable.SETFILTER(recsalesLineTable."Qty. to Ship", '<>%1', 0);
                    IF recsalesLineTable.FINDFIRST THEN
                        REPEAT
                            IF recsalesLineTable."Inventory Posting Group" = 'MERCH' THEN
                                recsalesLineTable.TESTFIELD("Line Amount", 0);
                        UNTIL recsalesLineTable.NEXT = 0;
                END;//CAS-20803-Q6L8D4
                    //<<RSPL/CUST/MERCH/001


                //<<Code commented as per suggested by Unni Sir  26-02-2016
                //  {
                //  //>>RSPL-Rahul
                //   PostDay := DATE2DMY("Posting Date",1);
                //   SalesLine2.RESET;
                //   SalesLine2.SETRANGE(SalesLine2."Document No.","No.");
                //   SalesLine2.SETRANGE(SalesLine2."Document Type","Document Type");
                //   SalesLine2.SETRANGE(SalesLine2."Inventory Posting Group",'AUTOOILS');
                //   IF SalesLine2.FINDFIRST THEN  REPEAT
                //      IF PostDay > 28 THEN
                //        ERROR('You can not Post after date 28');
                //   UNTIL SalesLine2.NEXT =0;
                //  //<<RSPL-RAHUL
                //  }

                //EBT STIVAN---(01022013)----Error Message POP UP, IF Tracking QTY & Sales Line Aty to Ship does not Match----START
                IF rec."Location Code" <> 'BOND0001' THEN BEGIN
                    IF NOT ((rec."Location Code" = 'PLANT01') OR (rec."Location Code" = 'PLANT02') OR (rec."Location Code" = 'GDN0002')) THEN BEGIN
                        recsalesLineTable.RESET;
                        recsalesLineTable.SETRANGE(recsalesLineTable."Document No.", rec."No.");
                        recsalesLineTable.SETFILTER(recsalesLineTable."Qty. to Ship", '<>%1', 0);
                        //recsalesLineTable.SETFILTER(recsalesLineTable."Inventory Posting Group",'%1','AUTOOILS');
                        IF recsalesLineTable.FINDFIRST THEN
                            REPEAT
                                //>>24Oct2018
                                Itm24.RESET;
                                IF Itm24.GET(recsalesLineTable."No.") THEN
                                    IF Itm24."Item Tracking Code" <> '' THEN BEGIN
                                        CLEAR(ResEntryQty);
                                        recResEntry.RESET;
                                        recResEntry.SETRANGE(recResEntry."Source Type", 37);
                                        recResEntry.SETRANGE(recResEntry."Source ID", recsalesLineTable."Document No.");
                                        recResEntry.SETRANGE(recResEntry."Location Code", recsalesLineTable."Location Code");
                                        recResEntry.SETRANGE(recResEntry."Item No.", recsalesLineTable."No.");
                                        recResEntry.SETRANGE(recResEntry."Source Ref. No.", recsalesLineTable."Line No.");
                                        recResEntry.SETFILTER(recResEntry."Transferred from Entry No.", '%1', 0);
                                        IF recResEntry.FINDFIRST THEN
                                            REPEAT
                                                ResEntryQty := ResEntryQty + recResEntry.Quantity;
                                            UNTIL recResEntry.NEXT = 0;

                                        IF recsalesLineTable."Qty. to Ship" <> ABS(ResEntryQty) THEN BEGIN
                                            //mayuri
                                            IF (recsalesLineTable."Inventory Posting Group" = 'AUTOOILS') OR
                                            (recsalesLineTable."Inventory Posting Group" = 'INDOILS') OR (recsalesLineTable."Inventory Posting Group" = 'BOILS')
                                            OR (recsalesLineTable."Inventory Posting Group" = 'TOILS') OR (recsalesLineTable."Inventory Posting Group" = 'RPO')
                                            OR (recsalesLineTable."Inventory Posting Group" = 'REPSOL') THEN
                                                ERROR('Please check the Item Tracking of Item No. %1 of Line No. %2. Please reduce the Qty'
                                                , recsalesLineTable."No.", recsalesLineTable."Line No.");
                                        END;
                                    END;//>>24Oct2018
                            UNTIL recsalesLineTable.NEXT = 0;
                    END;
                END;
                //EBT STIVAN---(01022013)----Error Message POP UP, IF Tracking QTY & Sales Line Aty to Ship does not Match------END

                //  {
                //  //EBT STIVAN---(01082013)----Error Message POP UP,
                //  //----IF Transport Type is InterCity then Expected TPT Cost is Mandatory &
                //  //----IF Transport Type is Local+InterCity then Local Expected TPT Cost & Expected TPT Cost is Mandatory------------------START

                //  IF ("Freight Type" = "Freight Type" :: PAID) OR ("Freight Type" = "Freight Type" ::"PAY & ADD IN BILL") THEN
                //  BEGIN

                //   IF "Transport Type" = "Transport Type" :: Intercity THEN
                //   BEGIN
                //    IF "Expected TPT Cost" = 0 THEN
                //    ERROR('Please Specify Expected TPT Cost');
                //   END;

                //   IF "Transport Type" = "Transport Type" :: "Local+Intercity" THEN
                //   BEGIN
                //    IF "Expected TPT Cost" = 0 THEN
                //    ERROR('Please Specify Expected TPT Cost');

                //    IF "Local Expected TPT Cost" = 0 THEN
                //    ERROR('Please Specify Local Expected TPT Cost');
                //   END;

                //  END;


                //  //EBT STIVAN---(01082013)----Error Message POP UP,
                //  //----IF Transport Type is InterCity then Expected TPT Cost is Mandatory &
                //  //----IF Transport Type is Local+InterCity then Local Expected TPT Cost & Expected TPT Cost is Mandatory--------------------END
                //  }//Commented 18May2017

                //EBT STIVAN---(01082013)----Error Message POP UP,
                //----IF Transport Type is InterCity then Expected TPT Cost is Mandatory &
                //----IF Transport Type is Local+InterCity then Local Expected TPT Cost & Expected TPT Cost is Mandatory------------------START

                //>>18May2017 Allow MERCH Inventory Posting Group as 0 TPT Cost
                IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN BEGIN
                    SL18.RESET; //18May2017
                    SL18.SETRANGE("Document No.", rec."No."); //18May2017
                    IF SL18.FINDFIRST THEN //18May2017
                        REPEAT //18May2017

                            IF SL18."Inventory Posting Group" <> 'MERCH' THEN //18May2017
                            BEGIN //18May2017
                                // IF (rec."Freight Type" = "Freight Type"::PAID) OR (rec."Freight Type" = rec."Freight Type"::"PAY & ADD IN BILL") THEN BEGIN
                                //     IF rec."Transport Type" = "Transport Type"::Intercity THEN BEGIN
                                //         IF rec."Expected TPT Cost" = 0 THEN
                                //             ERROR('Please Specify Expected TPT Cost');
                                //     END;

                                //     IF rec."Transport Type" = rec."Transport Type"::"Local+Intercity" THEN BEGIN
                                //         IF rec."Expected TPT Cost" = 0 THEN
                                //             ERROR('Please Specify Expected TPT Cost');

                                //         IF rec."Local Expected TPT Cost" = 0 THEN
                                //             ERROR('Please Specify Local Expected TPT Cost');
                                //     END;

                                // END;

                            END; //18May2017

                        UNTIL SL18.NEXT = 0; //18May2017
                END;

                //<<18May2017

                //EBT STIVAN---(01082013)----Error Message POP UP,
                //----IF Transport Type is InterCity then Expected TPT Cost is Mandatory &
                //----IF Transport Type is Local+InterCity then Local Expected TPT Cost & Expected TPT Cost is Mandatory--------------------END

                //EBT STIVAN---(01022013)----Error Message POP UP, IF Tracking QTY & Sales Line Aty to Ship does not Match----START
                IF rec."Location Code" <> 'BOND0001' THEN BEGIN
                    recsalesLineTable.RESET;
                    recsalesLineTable.SETRANGE(recsalesLineTable."Document No.", rec."No.");
                    recsalesLineTable.SETFILTER(recsalesLineTable."Qty. to Ship", '<>%1', 0);
                    IF recsalesLineTable.FINDFIRST THEN
                        REPEAT
                            //>>24Oct2018
                            Itm24.RESET;
                            IF Itm24.GET(recsalesLineTable."No.") THEN
                                IF Itm24."Item Tracking Code" <> '' THEN BEGIN
                                    CLEAR(ResEntryQty);
                                    recResEntry.RESET;
                                    recResEntry.SETRANGE(recResEntry."Source Type", 37);
                                    recResEntry.SETRANGE(recResEntry."Source ID", recsalesLineTable."Document No.");
                                    recResEntry.SETRANGE(recResEntry."Location Code", recsalesLineTable."Location Code");
                                    recResEntry.SETRANGE(recResEntry."Item No.", recsalesLineTable."No.");
                                    recResEntry.SETRANGE(recResEntry."Source Ref. No.", recsalesLineTable."Line No.");
                                    recResEntry.SETFILTER(recResEntry."Transferred from Entry No.", '%1', 0);
                                    IF recResEntry.FINDFIRST THEN
                                        REPEAT
                                            ResEntryQty := ResEntryQty + recResEntry.Quantity;
                                        UNTIL recResEntry.NEXT = 0;
                                    IF recsalesLineTable."Qty. to Ship" <> ABS(ResEntryQty) THEN BEGIN
                                        //mayuri
                                        IF (recsalesLineTable."Inventory Posting Group" = 'AUTOOILS') OR
                                        (recsalesLineTable."Inventory Posting Group" = 'INDOILS') OR (recsalesLineTable."Inventory Posting Group" = 'BOILS')
                                        OR (recsalesLineTable."Inventory Posting Group" = 'TOILS') OR (recsalesLineTable."Inventory Posting Group" = 'RPO')
                                        OR (recsalesLineTable."Inventory Posting Group" = 'REPSOL') THEN
                                            ERROR('Please check the Item Tracking of Item No. %1 of Line No. %2. Please reduce the Qty'
                                            , recsalesLineTable."No.", recsalesLineTable."Line No.");
                                    END;
                                END;//24Oct2018
                        UNTIL recsalesLineTable.NEXT = 0;
                END;
                //EBT STIVAN---(01022013)----Error Message POP UP, IF Tracking QTY & Sales Line Aty to Ship does not Match------END

                //EBT STIVAN ---(25012013)--- TO Check Header and Line Location Differ the Error Message POP UP------START
                SaleLineNew.RESET;
                SaleLineNew.SETRANGE(SaleLineNew."Document No.", rec."No.");
                //SaleLineNew.SETRANGE(SaleLineNew.Type,SaleLineNew.Type::Item);//CAS-18282-F9P4T1 RB-N 10Oct2017
                SaleLineNew.SETRANGE(SaleLineNew."Location Code", rec."Location Code");
                IF NOT (SaleLineNew.FINDSET) THEN BEGIN
                    ERROR('Location Code in Sales Lines are differenet from header Level');
                END;
                //EBT STIVAN ---(25012013)--- TO Check Header and Line Location Differ the Error Message POP UP--------END
                // EBT MILAN (14012014)- IF Structure is filled and trading then calculate structure value is mendatory----------------------START
                // IF (rec.Structure <> '') AND (rec.Trading = TRUE) THEN BEGIN
                //     Saaleslinerec.RESET;
                //     Saaleslinerec.SETRANGE(Saaleslinerec."Document Type", rec."Document Type");
                //     Saaleslinerec.SETRANGE(Saaleslinerec."Document No.", rec."No.");
                //     Saaleslinerec.SETRANGE(Saaleslinerec.Type, Saaleslinerec.Type::Item);
                //     IF Saaleslinerec.FINDSET THEN
                //         REPEAT
                //             IF Saaleslinerec."Inventory Posting Group" <> 'MERCH' THEN//Sourav
                //                 IF Saaleslinerec."Structure Calculated" = FALSE THEN
                //                     ERROR('Please Calculate Structure Value');
                //         UNTIL Saaleslinerec.NEXT = 0;
                // END;
                // EBT MILAN (14012014)- IF Structure is filled and trading then calculate structure value is mendatory------------------------END

                //  {
                //  // Start DJ RSPL 11/11/19
                //  IF Invoice THEN BEGIN
                //  CALCFIELDS("Amount to Customer");
                //  SaleLines.RESET;
                //  SaleLines.SETRANGE("Document Type","Document Type");
                //  SaleLines.SETRANGE("Document No.","No.");
                //  SaleLines.CALCSUMS("Quantity (Base)");
                //  IF Invoice THEN BEGIN
                //    SetSalespersonEmailValues("Posting Date","No.","Amount to Customer","Bill-to Customer No.","Vehicle No.","Shipping Agent Code","Driver's Name","Driver's Mobile No.","Salesperson Code","Location Code",SaleLines.Quantity);
                //  END;
                //  END;
                //  // DJ RSPL 11/11/19 End
                //  }
            end;

            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                LRDetailsClr; //TC_IOPL

                //>>RB-N 17Nov2017
                SL.RESET;
                SL.SETRANGE("Document Type", rec."Document Type");
                SL.SETRANGE("Document No.", rec."No.");
                SL.CALCSUMS(Quantity, "Quantity Shipped");
                IF SL.Quantity <> SL."Quantity Shipped" THEN
                    IF (rec."Shortcut Dimension 1 Code" = 'DIV-04') OR (rec."Shortcut Dimension 1 Code" = 'DIV-08') THEN BEGIN

                        ReleaseSalesDoc.PerformManualReopen(Rec);
                        rec."Cr. Approved" := FALSE;
                        rec."Sent For Approval" := FALSE;
                        rec."Campaign No." := '';
                        rec."Credit Limit Approval" := rec."Credit Limit Approval"::Open;
                        rec.MODIFY;
                    END;
                //>>RB-N 17Nov2017

                // Start DJ RSPL 11/11/19
                // IF Invoice THEN BEGIN
                //SalespersonEmailNotification;
                //END;
                // DJ RSPL 11/11/19 END
            END;


        }
        modify(PostAndNew)
        {
            trigger OnBeforeAction()
            VAR
                SL09: Record 37;
                GST09: Record "Detailed GST Entry Buffer"; //16412;
                Itm24: Record 27;
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
                                    RecCustLedgEntry.SETRANGE("Posting Date", GLSetup."TCS Threshold Starting Date", Rec."Posting Date");
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
                                    ERROR('TCS Applicable. Please select Assessee Code in Sales Order Line=%1', RecSL31."Assessee Code");
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
                                            IF RecSL32.FINDFIRST THEN BEGIN
                                                //DJ 190621
                                                RecLocation.GET(rec."Location Code");
                                                IF RecLocation."Location Type" <> RecLocation."Location Type"::"High Seas" THEN
                                                    ERROR('Amount Exceeds TCS Threshold Amount, Please apply TCS');
                                            END;
                                            //DJ 190621
                                        END;//RSPLSUM22Feb21<<
                                    END;//RSPl AM03072021 <<
                                END;//RSPl AM03072021 <<
                            END;
                        END;
                    END;
                END;
                //RSPLSUM-TCS<<

                //TESTFIELD("Distance in kms");//RSPLSUM 12Mar2020
                //RSPLSUM09Apr21--TESTFIELD("Get Entry Outward"); //Nb 28902
                IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN
                    rec.TESTFIELD("EWB Transaction Type");//RSPLSUM 19Mar2020
                                                          //RSPLSUM 13Nov2019>>
                rec.TESTFIELD("Salesperson Code");
                SalespersonPurchaser.RESET;
                IF SalespersonPurchaser.GET(rec."Salesperson Code") THEN
                    SalespersonPurchaser.TESTFIELD("E-Mail");
                UserSetupRec.RESET;
                IF UserSetupRec.GET(USERID) THEN
                    UserSetupRec.TESTFIELD("E-Mail");
                //RSPLSUM 13Nov2019<<

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

                IF rec."Shortcut Dimension 1 Code" = 'DIV-14' THEN //RSPLSUM 28May2020
                    rec.TESTFIELD("Bank Account No.");//RSPLSUM 28May2020

                FOCValidation;//03Apr2019
                              //>>09Aug2017 SplitLine GST Calculation
                              // IF (rec.Structure <> '') THEN BEGIN
                              //     SL09.RESET;
                              //     SL09.SETRANGE("Document No.", rec."No.");
                              //     SL09.SETRANGE("Free of Cost", FALSE);
                              //     SL09.SETFILTER("Inventory Posting Group", '<>%1', 'MERCH');
                              //     SL09.SETFILTER("IOPL Split Line No.", '<>%1', 0);
                              //     IF SL09.FINDSET THEN
                              //         REPEAT

                //             GST09.RESET;
                //             GST09.SETRANGE("Document No.", SL09."Document No.");
                //             GST09.SETRANGE("Line No.", SL09."Line No.");
                //             GST09.SETRANGE(Quantity, 0);
                //             IF GST09.FINDFIRST THEN BEGIN
                //                 ERROR('Please Calculate Structure Value for Split Line.\ Document No.: %1 \ Line No.: %2 ', SL09."Document No.", SL09."Line No.");

                //             END;

                //         UNTIL SL09.NEXT = 0;
                // END;
                //<<09Aug2017 SplitLine GST Calculation

                //TESTFIELD("Freight Type");
                //CAS-18282-F9P4T1 RB-N 10Oct2017
                IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN BEGIN
                    SL10.RESET;
                    SL10.SETRANGE("Document No.", rec."No.");
                    IF SL10.FINDSET THEN
                        REPEAT
                            IF SL10.Type <> SL10.Type::"G/L Account" THEN BEGIN
                                rec.TESTFIELD("Freight Type");
                                rec.TESTFIELD("Transport Type");
                            END;
                        UNTIL SL10.NEXT = 0;
                END;
                //CAS-18282-F9P4T1 RB-N

                lDimSetEntry.RESET;
                lDimSetEntry.SETRANGE("Dimension Set ID", rec."Dimension Set ID");
                lDimSetEntry.SETFILTER("Dimension Value Code", '%1|%2', '', 'PLEASE TAG DIMENSION');
                IF lDimSetEntry.FINDSET THEN
                    ERROR('Please Specify Correct Dimension Value');
                //RSPL008 >>>> Dimension Validation
                recSalLine.RESET;
                recSalLine.SETCURRENTKEY("Document No.", "Line No.");
                recSalLine.SETRANGE("Document No.", rec."No.");
                recSalLine.SETRANGE(Type, recSalLine.Type::Item);
                recSalLine.SETFILTER("No.", '<>%1', '');
                recSalLine.SETRANGE("Item Category Code", 'CAT14');
                IF recSalLine.FINDFIRST THEN
                    REPEAT
                        CLEAR(vInventQty);
                        //RSPL-TC +
                        lDimSetEntry.RESET;
                        lDimSetEntry.SETRANGE("Dimension Set ID", recSalLine."Dimension Set ID");
                        lDimSetEntry.SETFILTER("Dimension Value Code", '%1|%2', '', 'PLEASE TAG DIMENSION');
                        IF lDimSetEntry.FINDSET THEN
                            ERROR('Please Specify Correct Dimension Value');

                        RecDimSetEntry.RESET;
                        RecDimSetEntry.SETRANGE("Dimension Set ID", recSalLine."Dimension Set ID");
                        RecDimSetEntry.SETRANGE("Dimension Code", 'MERCH');
                        IF RecDimSetEntry.FINDSET THEN BEGIN
                            lDimSetEntry.RESET;
                            lDimSetEntry.SETRANGE("Dimension Code", RecDimSetEntry."Dimension Code");
                            lDimSetEntry.SETRANGE("Dimension Value Code", RecDimSetEntry."Dimension Value Code");
                            IF lDimSetEntry.FINDSET THEN
                                REPEAT
                                    recIlentry.RESET;
                                    recIlentry.SETRANGE("Dimension Set ID", lDimSetEntry."Dimension Set ID");
                                    recIlentry.SETRANGE("Item No.", recSalLine."No.");
                                    recIlentry.SETRANGE("Location Code", rec."Location Code");
                                    IF recIlentry.FINDSET THEN
                                        REPEAT
                                            vInventQty := vInventQty + recIlentry.Quantity
                                        UNTIL recIlentry.NEXT = 0;
                                UNTIL lDimSetEntry.NEXT = 0;
                            IF vInventQty < recSalLine.Quantity THEN
                                ERROR('Avaliable Qty %1 for the Item %2 Line %3', vInventQty, recSalLine."No.", recSalLine."Line No.");
                        END;
                    //RSPL-TC -
                    //    { //RSPL-TC
                    //      recDocDim.RESET;
                    //      recDocDim.SETRANGE("Table ID",37);
                    //      recDocDim.SETRANGE("Document Type","Document Type"::Order);
                    //      recDocDim.SETRANGE("Document No.",recSalLine."Document No.");
                    //      recDocDim.SETRANGE("Line No.",recSalLine."Line No.");
                    //      recDocDim.SETRANGE("Dimension Code",'MERCH');
                    //      IF recDocDim.FINDFIRST THEN BEGIN
                    //        recLedEntyDim.RESET;
                    //        recLedEntyDim.SETRANGE("Table ID",32);
                    //        recLedEntyDim.SETRANGE("Dimension Code",recDocDim."Dimension Code");
                    //        recLedEntyDim.SETRANGE("Dimension Value Code",recDocDim."Dimension Value Code");
                    //        IF recLedEntyDim.FINDFIRST THEN REPEAT
                    //           recIlentry.RESET;
                    //           recIlentry.SETCURRENTKEY("Entry No.");
                    //           recIlentry.SETRANGE("Entry No.",recLedEntyDim."Entry No.");
                    //           recIlentry.SETRANGE("Item No.",recSalLine."No.");
                    //           recIlentry.SETRANGE("Location Code","Location Code");
                    //           IF recIlentry.FINDFIRST THEN
                    //              vInventQty :=vInventQty+ recIlentry.Quantity
                    //             ELSE
                    //              vInventQty :=vInventQty;
                    //         UNTIL recLedEntyDim.NEXT=0;
                    //      IF  vInventQty < recSalLine.Quantity THEN
                    //         ERROR('Avaliable Qty %1 for the Item %2',vInventQty,recSalLine."No.");
                    //      END;}
                    UNTIL recSalLine.NEXT = 0;
                //RSPL008 <<<< Dimension Validation


                //>>RSPL/CUST/MERCH/001
                IF rec."No." <> 'CSO/45/1819/0009' THEN BEGIN//CAS-20803-Q6L8D4
                    recsalesLineTable.RESET;
                    recsalesLineTable.SETRANGE(recsalesLineTable."Document No.", rec."No.");
                    recsalesLineTable.SETFILTER(recsalesLineTable."Qty. to Ship", '<>%1', 0);
                    IF recsalesLineTable.FINDFIRST THEN
                        REPEAT
                            IF recsalesLineTable."Inventory Posting Group" = 'MERCH' THEN
                                recsalesLineTable.TESTFIELD("Line Amount", 0);
                        UNTIL recsalesLineTable.NEXT = 0;
                END;//CAS-20803-Q6L8D4
                    //<<RSPL/CUST/MERCH/001


                //<<Code commented as per suggested by Unni Sir  26-02-2016
                //  {
                //  //>>RSPL-Rahul
                //   PostDay := DATE2DMY("Posting Date",1);
                //   SalesLine2.RESET;
                //   SalesLine2.SETRANGE(SalesLine2."Document No.","No.");
                //   SalesLine2.SETRANGE(SalesLine2."Document Type","Document Type");
                //   SalesLine2.SETRANGE(SalesLine2."Inventory Posting Group",'AUTOOILS');
                //   IF SalesLine2.FINDFIRST THEN  REPEAT
                //      IF PostDay > 28 THEN
                //        ERROR('You can not Post after date 28');
                //   UNTIL SalesLine2.NEXT =0;
                //  //<<RSPL-RAHUL
                //  }

                //EBT STIVAN---(01022013)----Error Message POP UP, IF Tracking QTY & Sales Line Aty to Ship does not Match----START
                IF rec."Location Code" <> 'BOND0001' THEN BEGIN
                    IF NOT ((rec."Location Code" = 'PLANT01') OR (rec."Location Code" = 'PLANT02') OR (rec."Location Code" = 'GDN0002')) THEN BEGIN
                        recsalesLineTable.RESET;
                        recsalesLineTable.SETRANGE(recsalesLineTable."Document No.", rec."No.");
                        recsalesLineTable.SETFILTER(recsalesLineTable."Qty. to Ship", '<>%1', 0);
                        //recsalesLineTable.SETFILTER(recsalesLineTable."Inventory Posting Group",'%1','AUTOOILS');
                        IF recsalesLineTable.FINDFIRST THEN
                            REPEAT
                                //>>24Oct2018
                                Itm24.RESET;
                                IF Itm24.GET(recsalesLineTable."No.") THEN
                                    IF Itm24."Item Tracking Code" <> '' THEN BEGIN
                                        CLEAR(ResEntryQty);
                                        recResEntry.RESET;
                                        recResEntry.SETRANGE(recResEntry."Source Type", 37);
                                        recResEntry.SETRANGE(recResEntry."Source ID", recsalesLineTable."Document No.");
                                        recResEntry.SETRANGE(recResEntry."Location Code", recsalesLineTable."Location Code");
                                        recResEntry.SETRANGE(recResEntry."Item No.", recsalesLineTable."No.");
                                        recResEntry.SETRANGE(recResEntry."Source Ref. No.", recsalesLineTable."Line No.");
                                        recResEntry.SETFILTER(recResEntry."Transferred from Entry No.", '%1', 0);
                                        IF recResEntry.FINDFIRST THEN
                                            REPEAT
                                                ResEntryQty := ResEntryQty + recResEntry.Quantity;
                                            UNTIL recResEntry.NEXT = 0;

                                        IF recsalesLineTable."Qty. to Ship" <> ABS(ResEntryQty) THEN BEGIN
                                            //mayuri
                                            IF (recsalesLineTable."Inventory Posting Group" = 'AUTOOILS') OR
                                            (recsalesLineTable."Inventory Posting Group" = 'INDOILS') OR (recsalesLineTable."Inventory Posting Group" = 'BOILS')
                                            OR (recsalesLineTable."Inventory Posting Group" = 'TOILS') OR (recsalesLineTable."Inventory Posting Group" = 'RPO')
                                            OR (recsalesLineTable."Inventory Posting Group" = 'REPSOL') THEN
                                                ERROR('Please check the Item Tracking of Item No. %1 of Line No. %2. Please reduce the Qty'
                                                , recsalesLineTable."No.", recsalesLineTable."Line No.");
                                        END;
                                    END;//>>24Oct2018
                            UNTIL recsalesLineTable.NEXT = 0;
                    END;
                END;
                //EBT STIVAN---(01022013)----Error Message POP UP, IF Tracking QTY & Sales Line Aty to Ship does not Match------END

                //  {
                //  //EBT STIVAN---(01082013)----Error Message POP UP,
                //  //----IF Transport Type is InterCity then Expected TPT Cost is Mandatory &
                //  //----IF Transport Type is Local+InterCity then Local Expected TPT Cost & Expected TPT Cost is Mandatory------------------START

                //  IF ("Freight Type" = "Freight Type" :: PAID) OR ("Freight Type" = "Freight Type" ::"PAY & ADD IN BILL") THEN
                //  BEGIN

                //   IF "Transport Type" = "Transport Type" :: Intercity THEN
                //   BEGIN
                //    IF "Expected TPT Cost" = 0 THEN
                //    ERROR('Please Specify Expected TPT Cost');
                //   END;

                //   IF "Transport Type" = "Transport Type" :: "Local+Intercity" THEN
                //   BEGIN
                //    IF "Expected TPT Cost" = 0 THEN
                //    ERROR('Please Specify Expected TPT Cost');

                //    IF "Local Expected TPT Cost" = 0 THEN
                //    ERROR('Please Specify Local Expected TPT Cost');
                //   END;

                //  END;


                //  //EBT STIVAN---(01082013)----Error Message POP UP,
                //  //----IF Transport Type is InterCity then Expected TPT Cost is Mandatory &
                //  //----IF Transport Type is Local+InterCity then Local Expected TPT Cost & Expected TPT Cost is Mandatory--------------------END
                //  }//Commented 18May2017

                //EBT STIVAN---(01082013)----Error Message POP UP,
                //----IF Transport Type is InterCity then Expected TPT Cost is Mandatory &
                //----IF Transport Type is Local+InterCity then Local Expected TPT Cost & Expected TPT Cost is Mandatory------------------START

                //>>18May2017 Allow MERCH Inventory Posting Group as 0 TPT Cost
                IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN BEGIN
                    SL18.RESET; //18May2017
                    SL18.SETRANGE("Document No.", rec."No."); //18May2017
                    IF SL18.FINDFIRST THEN //18May2017
                        REPEAT //18May2017

                            IF SL18."Inventory Posting Group" <> 'MERCH' THEN //18May2017
                            BEGIN //18May2017
                                // IF (rec."Freight Type" = "Freight Type"::PAID) OR (rec."Freight Type" = rec."Freight Type"::"PAY & ADD IN BILL") THEN BEGIN
                                //     IF rec."Transport Type" = "Transport Type"::Intercity THEN BEGIN
                                //         IF rec."Expected TPT Cost" = 0 THEN
                                //             ERROR('Please Specify Expected TPT Cost');
                                //     END;

                                //     IF rec."Transport Type" = rec."Transport Type"::"Local+Intercity" THEN BEGIN
                                //         IF rec."Expected TPT Cost" = 0 THEN
                                //             ERROR('Please Specify Expected TPT Cost');

                                //         IF rec."Local Expected TPT Cost" = 0 THEN
                                //             ERROR('Please Specify Local Expected TPT Cost');
                                //     END;

                                // END;

                            END; //18May2017

                        UNTIL SL18.NEXT = 0; //18May2017
                END;

                //<<18May2017

                //EBT STIVAN---(01082013)----Error Message POP UP,
                //----IF Transport Type is InterCity then Expected TPT Cost is Mandatory &
                //----IF Transport Type is Local+InterCity then Local Expected TPT Cost & Expected TPT Cost is Mandatory--------------------END

                //EBT STIVAN---(01022013)----Error Message POP UP, IF Tracking QTY & Sales Line Aty to Ship does not Match----START
                IF rec."Location Code" <> 'BOND0001' THEN BEGIN
                    recsalesLineTable.RESET;
                    recsalesLineTable.SETRANGE(recsalesLineTable."Document No.", rec."No.");
                    recsalesLineTable.SETFILTER(recsalesLineTable."Qty. to Ship", '<>%1', 0);
                    IF recsalesLineTable.FINDFIRST THEN
                        REPEAT
                            //>>24Oct2018
                            Itm24.RESET;
                            IF Itm24.GET(recsalesLineTable."No.") THEN
                                IF Itm24."Item Tracking Code" <> '' THEN BEGIN
                                    CLEAR(ResEntryQty);
                                    recResEntry.RESET;
                                    recResEntry.SETRANGE(recResEntry."Source Type", 37);
                                    recResEntry.SETRANGE(recResEntry."Source ID", recsalesLineTable."Document No.");
                                    recResEntry.SETRANGE(recResEntry."Location Code", recsalesLineTable."Location Code");
                                    recResEntry.SETRANGE(recResEntry."Item No.", recsalesLineTable."No.");
                                    recResEntry.SETRANGE(recResEntry."Source Ref. No.", recsalesLineTable."Line No.");
                                    recResEntry.SETFILTER(recResEntry."Transferred from Entry No.", '%1', 0);
                                    IF recResEntry.FINDFIRST THEN
                                        REPEAT
                                            ResEntryQty := ResEntryQty + recResEntry.Quantity;
                                        UNTIL recResEntry.NEXT = 0;
                                    IF recsalesLineTable."Qty. to Ship" <> ABS(ResEntryQty) THEN BEGIN
                                        //mayuri
                                        IF (recsalesLineTable."Inventory Posting Group" = 'AUTOOILS') OR
                                        (recsalesLineTable."Inventory Posting Group" = 'INDOILS') OR (recsalesLineTable."Inventory Posting Group" = 'BOILS')
                                        OR (recsalesLineTable."Inventory Posting Group" = 'TOILS') OR (recsalesLineTable."Inventory Posting Group" = 'RPO')
                                        OR (recsalesLineTable."Inventory Posting Group" = 'REPSOL') THEN
                                            ERROR('Please check the Item Tracking of Item No. %1 of Line No. %2. Please reduce the Qty'
                                            , recsalesLineTable."No.", recsalesLineTable."Line No.");
                                    END;
                                END;//24Oct2018
                        UNTIL recsalesLineTable.NEXT = 0;
                END;
                //EBT STIVAN---(01022013)----Error Message POP UP, IF Tracking QTY & Sales Line Aty to Ship does not Match------END

                //EBT STIVAN ---(25012013)--- TO Check Header and Line Location Differ the Error Message POP UP------START
                SaleLineNew.RESET;
                SaleLineNew.SETRANGE(SaleLineNew."Document No.", rec."No.");
                //SaleLineNew.SETRANGE(SaleLineNew.Type,SaleLineNew.Type::Item);//CAS-18282-F9P4T1 RB-N 10Oct2017
                SaleLineNew.SETRANGE(SaleLineNew."Location Code", rec."Location Code");
                IF NOT (SaleLineNew.FINDSET) THEN BEGIN
                    ERROR('Location Code in Sales Lines are differenet from header Level');
                END;
                //EBT STIVAN ---(25012013)--- TO Check Header and Line Location Differ the Error Message POP UP--------END
                // EBT MILAN (14012014)- IF Structure is filled and trading then calculate structure value is mendatory----------------------START
                // IF (rec.Structure <> '') AND (rec.Trading = TRUE) THEN BEGIN
                //     Saaleslinerec.RESET;
                //     Saaleslinerec.SETRANGE(Saaleslinerec."Document Type", rec."Document Type");
                //     Saaleslinerec.SETRANGE(Saaleslinerec."Document No.", rec."No.");
                //     Saaleslinerec.SETRANGE(Saaleslinerec.Type, Saaleslinerec.Type::Item);
                //     IF Saaleslinerec.FINDSET THEN
                //         REPEAT
                //             IF Saaleslinerec."Inventory Posting Group" <> 'MERCH' THEN//Sourav
                //                 IF Saaleslinerec."Structure Calculated" = FALSE THEN
                //                     ERROR('Please Calculate Structure Value');
                //         UNTIL Saaleslinerec.NEXT = 0;
                // END;
                // EBT MILAN (14012014)- IF Structure is filled and trading then calculate structure value is mendatory------------------------END

                //  {
                //  // Start DJ RSPL 11/11/19
                //  IF Invoice THEN BEGIN
                //  CALCFIELDS("Amount to Customer");
                //  SaleLines.RESET;
                //  SaleLines.SETRANGE("Document Type","Document Type");
                //  SaleLines.SETRANGE("Document No.","No.");
                //  SaleLines.CALCSUMS("Quantity (Base)");
                //  IF Invoice THEN BEGIN
                //    SetSalespersonEmailValues("Posting Date","No.","Amount to Customer","Bill-to Customer No.","Vehicle No.","Shipping Agent Code","Driver's Name","Driver's Mobile No.","Salesperson Code","Location Code",SaleLines.Quantity);
                //  END;
                //  END;
                //  // DJ RSPL 11/11/19 End
                //  }
            end;

            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                LRDetailsClr; //TC_IOPL

                //>>RB-N 17Nov2017
                SL.RESET;
                SL.SETRANGE("Document Type", rec."Document Type");
                SL.SETRANGE("Document No.", rec."No.");
                SL.CALCSUMS(Quantity, "Quantity Shipped");
                IF SL.Quantity <> SL."Quantity Shipped" THEN
                    IF (rec."Shortcut Dimension 1 Code" = 'DIV-04') OR (rec."Shortcut Dimension 1 Code" = 'DIV-08') THEN BEGIN

                        ReleaseSalesDoc.PerformManualReopen(Rec);
                        rec."Cr. Approved" := FALSE;
                        rec."Sent For Approval" := FALSE;
                        rec."Campaign No." := '';
                        rec."Credit Limit Approval" := rec."Credit Limit Approval"::Open;
                        rec.MODIFY;
                    END;
                //>>RB-N 17Nov2017

                // Start DJ RSPL 11/11/19
                // IF Invoice THEN BEGIN
                //SalespersonEmailNotification;
                //END;
                // DJ RSPL 11/11/19 END
            END;


        }
        // Add changes to page actions 
        addafter("O&rder")
        {
            action("Single CU")
            {
                RunObject = Codeunit 50001;
            }
            action("Sales ConfirmationC")
            {
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN
                    SH.RESET;
                    SH := Rec;
                    SH.SETRECFILTER;
                    REPORT.RUN(50231, TRUE, FALSE, SH);
                END;
            }
            action("Sales Order Export/RPO - GSTC")
            {
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN
                    SH.RESET;
                    SH := Rec;
                    SH.SETRECFILTER;
                    REPORT.RUN(50155, TRUE, FALSE, SH);
                END;
            }
            action("Sales Order Industrial - GSTC")
            {
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN
                    SH.RESET;
                    SH := Rec;
                    SH.SETRECFILTER;
                    REPORT.RUN(50013, TRUE, FALSE, SH);
                END;
            }
            action("Sales Order Automotive - GSTC")
            {
                Image = Print;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN
                    SH.RESET;
                    SH := Rec;
                    SH.SETRECFILTER;
                    REPORT.RUN(50014, TRUE, FALSE, SH);
                END;
            }
            action("Sales Order - &IndustrialC")
            {
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN
                    //DocPrint.PrintSalesHeader(Rec);
                    SH.RESET;
                    SH := Rec;
                    SH.SETRECFILTER;
                    REPORT.RUN(50011, TRUE, FALSE, SH);
                END;
            }

            action("Sales Order - &Autolubes")
            {
                Visible = FALSE;
                Image = Print;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN
                    SH.RESET;
                    SH := Rec;
                    SH.SETRECFILTER;
                    REPORT.RUN(50012, TRUE, FALSE, SH);
                END;
            }
            action("Sales Order - & Structure DetailsC")
            {
                Image = Print;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN
                    SH.RESET;
                    SH := Rec;
                    SH.SETRECFILTER;
                    REPORT.RUN(50140, TRUE, FALSE, SH);
                END;
            }

            // action("Calculate Cash Discount")
            // {
            //     Visible = false;
            //     trigger OnAction()
            //     VAR
            //     BEGIN
            //         SalesLine.CalculateCashDisc(Rec);
            //     END;
            // }
            action("Get St&d. Cust. Sales Code")
            {
                trigger OnAction()
                VAR
                    StdCustSalesCode: Record 172;
                BEGIN
                    StdCustSalesCode.InsertSalesLines(Rec);
                END;
            }
            action("Approval Entries")
            {
                Image = Ledger;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN

                    AppPage.Setfilters(0, rec."No.");
                    AppPage.RUN;
                END;
            }
            action("C Form Approval")
            {
                Visible = FALSE;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN
                    //IPOL/OVERDUE/01 >>>>
                    rec.TESTFIELD("Credit Limit Approval", rec."Credit Limit Approval"::"Pending for C Form Approval");
                    UserSetupT.RESET;
                    UserSetupT.SETRANGE(UserSetupT."User ID", USERID);
                    UserSetupT.SETRANGE("Credit Limit Approval", TRUE);
                    IF UserSetupT.FINDFIRST THEN BEGIN
                        IF NOT CONFIRM(Text1004, FALSE) THEN
                            EXIT;
                        recSH.RESET;
                        recSH.SETRANGE("Document Type", rec."Document Type");
                        recSH.SETRANGE("No.", rec."No.");
                        IF recSH.FINDFIRST THEN BEGIN
                            recSH."Credit Limit Approval" := recSH."Credit Limit Approval"::"Approved C Form";
                            recSH.MODIFY;
                        END;
                    END ELSE
                        ERROR('You donot have rights to Approve, Please Contact System Administrator');
                    //IPOL/OVERDUE/01 <<<<
                END;

            }
            action("Over Due Rejection")
            {
                Visible = FALSE;
                Image = Reject;
                trigger OnAction()
                var
                    myInt: Integer;

                BEGIN

                    rec.TESTFIELD("Credit Limit Approval", rec."Credit Limit Approval"::"Pending For Over Due Approval");
                    rec.TESTFIELD("Approval Description");
                    rec.TESTFIELD("OverDue Approval Rejection", FALSE);

                    //>>Over Due Rejection
                    UserSetupT.RESET;
                    UserSetupT.SETRANGE("User ID", USERID);
                    UserSetupT.SETRANGE("Credit Limit Approval", TRUE);
                    IF NOT UserSetupT.FINDFIRST THEN
                        ERROR('You donot have rights to Over Due Rejection, Please Contact System Administrator');
                    //<<Over Due Rejection


                    //>>
                    SAE11.RESET;
                    SAE11.SETCURRENTKEY("Document Type", "Document No.");
                    SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Sales Order");
                    SAE11.SETRANGE("Document No.", rec."No.");
                    SAE11.SETRANGE(Approved, TRUE);
                    IF SAE11.FINDLAST THEN BEGIN
                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SAE11."Document Type");
                        SalesApproval.SETRANGE("User ID", SAE11."User ID");
                        SalesApproval.SETRANGE("Approvar ID", SAE11."Approvar ID");
                        SalesApproval.SETRANGE("Credit Approvar ID", USERID);
                        IF NOT SalesApproval.FINDFIRST THEN
                            ERROR('Sales Over Due Rejection setup does not exists for User %1', USERID);
                    END;
                    //<<

                    rec."OverDue Approval Rejection" := TRUE;
                    rec.MODIFY;

                    //>>EmailNotification
                    SRSetup.GET;
                    IF SRSetup."Email Notification On SO" THEN
                        EmailNotification(0, rec."No.", 7, USERID, '', '');
                    //>>EmailNotification
                END;



            }
            action("Over Due Approve")
            {
                Image = AuthorizeCreditCard;

                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN

                    //>>RB-N 08Sep2017 User OverDueApproval Validation
                    UserSetupT.RESET;
                    UserSetupT.SETRANGE("User ID", USERID);
                    UserSetupT.SETRANGE("Credit Limit Approval", TRUE);
                    IF NOT UserSetupT.FINDFIRST THEN
                        ERROR('You donot have rights to Approve, Please Contact System Administrator');
                    //<<RB-N 08Sep2017 User OverDueApproval Validation

                    //>>20Jun2018
                    SAE11.RESET;
                    SAE11.SETCURRENTKEY("Document Type", "Document No.");
                    SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Sales Order");
                    SAE11.SETRANGE("Document No.", rec."No.");
                    SAE11.SETRANGE(Approved, TRUE);
                    IF SAE11.FINDLAST THEN BEGIN
                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SAE11."Document Type");
                        SalesApproval.SETRANGE("User ID", SAE11."User ID");
                        SalesApproval.SETRANGE("Approvar ID", SAE11."Approvar ID");
                        SalesApproval.SETRANGE("Credit Approvar ID", USERID);
                        IF NOT SalesApproval.FINDFIRST THEN
                            ERROR('Sales OverDue Approval setup does not exists for User %1', USERID);
                    END;
                    //<<20Jun2018

                    //IPOL/OVERDUE/01 >>>>  Over Due Order Approval based User setup Rights
                    //TESTFIELD("Credit Limit Approval","Credit Limit Approval"::"Pending For Over Due Approval");
                    //>>05Feb2019
                    IF (rec."Credit Limit Approval" <> rec."Credit Limit Approval"::"Pending For Over Due Approval") AND
                       (rec."Credit Limit Approval" <> rec."Credit Limit Approval"::"Over Due Rejected") THEN
                        ERROR('%1 Status cannot be Approved', rec."Credit Limit Approval");
                    //<<05Feb2019
                    UserSetupT.RESET;
                    UserSetupT.SETRANGE(UserSetupT."User ID", USERID);
                    UserSetupT.SETRANGE("Credit Limit Approval", TRUE);
                    IF UserSetupT.FINDFIRST THEN BEGIN

                        CLEAR(FormAvCrd);
                        FormAvCrd.GetCustomerNo(rec."Bill-to Customer No.");
                        FormAvCrd.GetOrderNo(rec."No.");
                        FormAvCrd.RUNMODAL;

                        IF NOT CONFIRM(Text1003, FALSE) THEN
                            EXIT;


                        recSHd.RESET;
                        recSHd.SETCURRENTKEY("Document Type", "No.");
                        recSHd.SETRANGE("Document Type", rec."Document Type");
                        recSHd.SETRANGE("No.", rec."No.");
                        IF recSHd.FINDFIRST THEN BEGIN
                            recSHd."Credit Limit Approval" := recSHd."Credit Limit Approval"::"Approved Over Due";
                            recSHd.MODIFY(TRUE);
                        END;

                        //>>Approval Process
                        SalesApprovalEntry.RESET;
                        SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                        SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Sales Order");
                        SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                        SalesApprovalEntry.SETRANGE(Approved, TRUE);
                        IF SalesApprovalEntry.FINDLAST THEN BEGIN
                            CLEAR(UserName14);
                            User14.RESET;
                            User14.SETRANGE("User Name", USERID);
                            IF User14.FINDFIRST THEN
                                UserName14 := User14."Full Name"
                            ELSE
                                UserName14 := USERID;
                            SalesApprovalEntry."Over Due Approvar ID" := USERID;
                            SalesApprovalEntry."Over Due Approvar Name" := UserName14;
                            SalesApprovalEntry."Over Due Approval Date" := TODAY;
                            SalesApprovalEntry."Over Due Approval Time" := TIME;

                            SalesApprovalEntry.MODIFY;
                            IF SalesApprovalEntry."Mandatory ID" THEN BEGIN
                                rec."Cr. Approved" := TRUE;
                                ReleaseSalesDoc.PerformManualRelease(Rec);
                                rec."Campaign No." := 'Approved';
                                rec."Credit Limit Approval" := rec."Credit Limit Approval"::Approved;
                                rec.MODIFY(TRUE);
                                MESSAGE('Approved');
                            END;

                            SAE17.RESET;
                            SAE17.SETCURRENTKEY("Document Type", "Document No.");
                            SAE17.SETRANGE("Document Type", SAE17."Document Type"::"Sales Order");
                            SAE17.SETRANGE("Document No.", SalesApprovalEntry."Document No.");
                            SAE17.SETRANGE("Version No.", SalesApprovalEntry."Version No.");
                            SAE17.SETRANGE(Approved, FALSE);
                            IF SAE17.FINDFIRST THEN BEGIN
                                SAE17.DELETEALL(TRUE);
                            END;
                            //ArchiveManagement.StoreSalesDocument(Rec, FALSE);
                        END;
                        //<<
                    END ELSE
                        ERROR('You donot have rights to Approve, Please Contact System Administrator');
                    //IPOL/OVERDUE/01 <<<<<  Over Due Order Approval based User setup Rights


                    //>>15May2018
                    SRSetup.GET;
                    IF SRSetup."Email Notification On SO" THEN
                        EmailNotification(0, rec."No.", 2, USERID, '', '');
                    //>>15May2018
                END;




            }

            action("Credit Limit Rejection")
            {
                ApplicationArea = all;
                Visible = FALSE;
                Image = Reject;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN

                    rec.TESTFIELD("Credit Limit Approval", rec."Credit Limit Approval"::"Pending for Credit Approval");
                    rec.TESTFIELD("Approval Description");
                    rec.TESTFIELD("Credit Approval Rejection", FALSE);

                    //>>CreditLimit Rejection
                    UserSetupT.RESET;
                    UserSetupT.SETRANGE("User ID", USERID);
                    UserSetupT.SETRANGE("Credit Limit Approval", TRUE);
                    IF NOT UserSetupT.FINDFIRST THEN
                        ERROR('You donot have rights to Credit Limit Rejection, Please Contact System Administrator');
                    //<<CreditLimit Rejection


                    //>>
                    SAE11.RESET;
                    SAE11.SETCURRENTKEY("Document Type", "Document No.");
                    SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Sales Order");
                    SAE11.SETRANGE("Document No.", rec."No.");
                    SAE11.SETRANGE(Approved, TRUE);
                    IF SAE11.FINDLAST THEN BEGIN
                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SAE11."Document Type");
                        SalesApproval.SETRANGE("User ID", SAE11."User ID");
                        SalesApproval.SETRANGE("Approvar ID", SAE11."Approvar ID");
                        SalesApproval.SETRANGE("Credit Approvar ID", USERID);
                        IF NOT SalesApproval.FINDFIRST THEN
                            ERROR('Sales Credit Credit Limit Rejection setup does not exists for User %1', USERID);
                    END;
                    //<<

                    rec."Credit Approval Rejection" := TRUE;
                    rec.MODIFY;

                    //>>EmailNotification
                    SRSetup.GET;
                    IF SRSetup."Email Notification On SO" THEN
                        EmailNotification(0, rec."No.", 6, USERID, '', '');
                    //>>EmailNotification
                END;


            }

            action("Credit Limit Approve")
            {
                ApplicationArea = all;
                Image = AuthorizeCreditCard;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN

                    //>>RB-N 08Sep2017 User CreditLimitApproval Validation
                    UserSetupT.RESET;
                    UserSetupT.SETRANGE("User ID", USERID);
                    UserSetupT.SETRANGE("Credit Limit Approval", TRUE);
                    IF NOT UserSetupT.FINDFIRST THEN
                        ERROR('You donot have rights to Approve, Please Contact System Administrator');
                    //<<RB-N 08Sep2017 User CreditLimitApproval Validation


                    //>>15May2018
                    SAE11.RESET;
                    SAE11.SETCURRENTKEY("Document Type", "Document No.");
                    SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Sales Order");
                    SAE11.SETRANGE("Document No.", rec."No.");
                    SAE11.SETRANGE(Approved, TRUE);
                    IF SAE11.FINDLAST THEN BEGIN
                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SAE11."Document Type");
                        SalesApproval.SETRANGE("User ID", SAE11."User ID");
                        SalesApproval.SETRANGE("Approvar ID", SAE11."Approvar ID");
                        SalesApproval.SETRANGE("Credit Approvar ID", USERID);
                        IF NOT SalesApproval.FINDFIRST THEN
                            ERROR('Sales Credit Approval setup does not exists for User %1', USERID);
                    END;
                    //<<15May2018

                    //IPOL/OVERDUE/01 >>  Credit Limit Approval ------------------------------
                    //TESTFIELD("Credit Limit Approval","Credit Limit Approval"::"Pending for Credit Approval");
                    //>>05Feb2019
                    IF (rec."Credit Limit Approval" <> rec."Credit Limit Approval"::"Pending for Credit Approval") AND
                       (rec."Credit Limit Approval" <> rec."Credit Limit Approval"::"Credit Rejected") THEN
                        ERROR('%1 Status cannot be Approved', rec."Credit Limit Approval");
                    //<<05Feb2019

                    CLEAR(FormAvCrd);
                    FormAvCrd.GetCustomerNo(rec."Bill-to Customer No.");
                    FormAvCrd.GetOrderNo(rec."No.");
                    FormAvCrd.RUNMODAL;

                    UserSetupT.RESET;
                    UserSetupT.SETRANGE(UserSetupT."User ID", USERID);
                    IF UserSetupT.FINDFIRST THEN BEGIN
                        IF UserSetupT."Credit Limit Approval" = TRUE THEN BEGIN
                            IF NOT CONFIRM(Text1002, FALSE) THEN
                                EXIT;

                            SalesHeadT.RESET;
                            SalesHeadT.SETRANGE("Document Type", rec."Document Type");
                            SalesHeadT.SETRANGE("No.", rec."No.");
                            IF SalesHeadT.FINDFIRST THEN BEGIN
                                SalesHeadT."Credit Limit Approval" := SalesHeadT."Credit Limit Approval"::"Approved Credit Limit";
                                SalesHeadT."Over Due Approval" := FALSE;
                                SalesHeadT.MODIFY;
                            END;

                            //>>14Mar2018 Approval Process
                            SalesApprovalEntry.RESET;
                            SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                            SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Sales Order");
                            SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                            SalesApprovalEntry.SETRANGE(Approved, TRUE);
                            IF SalesApprovalEntry.FINDLAST THEN BEGIN
                                SalesApprovalEntry."Credit Limit Approvar ID" := USERID;
                                CLEAR(UserName14);
                                User14.RESET;
                                User14.SETRANGE("User Name", USERID);
                                IF User14.FINDFIRST THEN
                                    UserName14 := User14."Full Name"
                                ELSE
                                    UserName14 := USERID;
                                SalesApprovalEntry."Credit Limit Approvar Name" := UserName14;
                                SalesApprovalEntry."Credit Limit Approval Date" := TODAY;
                                SalesApprovalEntry."Credit Limit Approval Time" := TIME;
                                SalesApprovalEntry.MODIFY;
                            END;
                            //<<14Mar2018 Approval Process

                        END ELSE
                            ERROR('You donot have rights to Approve, Please Contact System Administrator');
                    END;


                    //IPOL/OVERDUE/01 <<  Credit Limit Approval ------------------------------

                    IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN BEGIN//RSPLSUM 08Jun2020 -- To Skip Division - FUEL OIL (DIV-14) from overdue approval
                                                                             //>>14Mar2018
                                                                             //OVERDUE Validation
                        IF rec."Over Due Approval" = FALSE THEN BEGIN
                            CLEAR(vRemAmt);
                            CustomerT.RESET;
                            CustomerT.SETRANGE(CustomerT."No.", rec."Bill-to Customer No.");
                            IF CustomerT.FINDFIRST THEN
                                expr1 := CustomerT."Approved Payment Days";

                            CustLedEntryT.RESET;
                            CustLedEntryT.SETRANGE(CustLedEntryT."Document Type", CustLedEntryT."Document Type"::Invoice);
                            CustLedEntryT.SETRANGE(CustLedEntryT."Customer No.", rec."Bill-to Customer No.");
                            CustLedEntryT.SETFILTER(CustLedEntryT."Remaining Amount", '<>%1', 0);
                            IF CustLedEntryT.FINDSET THEN
                                REPEAT
                                    //IF CALCDATE(expr1,CustLedEntryT."Due Date") < WORKDATE THEN
                                    //>>RB-N 24Jan2018
                                    CLEAR(DiffDate);
                                    DiffDate := CustLedEntryT."Due Date" - CustLedEntryT."Document Date";
                                    IF CALCDATE(expr1, CustLedEntryT."Posting Date" + DiffDate) < WORKDATE THEN
                                     //<<RB-N 24Jan2018
                                     BEGIN
                                        CustLedEntryT.CALCFIELDS(CustLedEntryT."Remaining Amount");
                                        vRemAmt := vRemAmt + CustLedEntryT."Remaining Amount";
                                    END;
                                UNTIL CustLedEntryT.NEXT = 0;

                            IF vRemAmt <> 0 THEN BEGIN
                                recSH.RESET;
                                recSH.SETRANGE("Document Type", rec."Document Type");
                                recSH.SETRANGE("No.", rec."No.");
                                IF recSH.FINDFIRST THEN BEGIN
                                    recSH."Credit Limit Approval" := recSH."Credit Limit Approval"::"Pending For Over Due Approval";
                                    recSH."Over Due Approval" := TRUE;
                                    recSH.MODIFY;
                                    MESSAGE('Order Customer %1 is Over Due By Amount %2, Needs Over Due Approval', rec."Bill-to Name", vRemAmt);
                                    EXIT;
                                END;
                            END;
                        END;
                        //OVERDUE Validation
                    END;//RSPLSUM 08Jun2020

                    //>>Approval
                    SalesApprovalEntry.RESET;
                    SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                    SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Sales Order");
                    SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                    //SalesApprovalEntry.SETRANGE("Approvar ID",USERID);
                    SalesApprovalEntry.SETRANGE(Approved, TRUE);
                    IF SalesApprovalEntry.FINDLAST THEN BEGIN
                        IF SalesApprovalEntry."Mandatory ID" THEN BEGIN
                            rec."Cr. Approved" := TRUE;
                            ReleaseSalesDoc.PerformManualRelease(Rec);
                            rec."Campaign No." := 'Approved';
                            rec."Credit Limit Approval" := rec."Credit Limit Approval"::Approved;
                        END;
                        rec.MODIFY;
                        MESSAGE('Approved');

                        SAE17.RESET;
                        SAE17.SETCURRENTKEY("Document Type", "Document No.");
                        SAE17.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Sales Order");
                        SAE17.SETRANGE("Document No.", SalesApprovalEntry."Document No.");
                        SAE17.SETRANGE("Version No.", SalesApprovalEntry."Version No.");
                        SAE17.SETRANGE(Approved, FALSE);
                        IF SAE17.FINDFIRST THEN BEGIN
                            SAE17.DELETEALL(TRUE);
                        END;
                    END;

                    // ArchiveManagement.ArchiveSalesDocument(Rec);
                    CurrPage.UPDATE(FALSE);
                    //<<Approval
                    //<<14Mar2018


                    //>>15May2018
                    SRSetup.GET;
                    IF SRSetup."Email Notification On SO" THEN
                        EmailNotification(0, rec."No.", 2, USERID, '', '');
                    //>>15May2018
                END;
            }
            action("Short Close CSO")
            {
                ApplicationArea = all;
                Visible = FALSE;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    BEGIN
                        //EBT/SHORTCLOSE/0001
                        IF CONFIRM('Do you want to short close the sales order?', TRUE) THEN BEGIN
                            rec."Short Close" := TRUE;
                            rec."Short Close Date" := TODAY;
                            rec.MODIFY;
                            SalesLineRec.RESET;
                            SalesLineRec.SETRANGE(SalesLineRec."Document No.", rec."No.");
                            SalesLineRec.SETRANGE(SalesLineRec.Closed, FALSE);
                            IF SalesLineRec.FINDSET THEN
                                REPEAT
                                    SalesLineRec.Closed := TRUE;
                                    SalesLineRec."Closed Date" := TODAY;
                                    SalesLineRec.MODIFY;
                                UNTIL SalesLineRec.NEXT = 0;
                        END;
                        //EBT/SHORTCLOSE/0001
                    END;

                end;

            }
            action("GP Approval")
            {
                ApplicationArea = all;
            }
            action("Send For Authorization")
            {
                ApplicationArea = all;
                Image = Change;
                trigger OnAction()
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
                                        ERROR('TCS Applicable. Please select Assessee Code in Sales Order Line=%1', RecSL31."Assessee Code");
                                    END;

                                    IF recCustomernew.GET(rec."Bill-to Customer No.") THEN BEGIN  //RSPLAM03072021 <<
                                        IF NOT recCustomernew."Turnover Above 10 Crores" THEN BEGIN  //RSPLAM03072021 <<
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
                                                IF RecSL32.FINDFIRST THEN BEGIN
                                                    //DJ 190621
                                                    RecLocation.GET(rec."Location Code");
                                                    IF RecLocation."Location Type" <> RecLocation."Location Type"::"High Seas" THEN
                                                        ERROR('Amount Exceeds TCS Threshold Amount, Please apply TCS');
                                                END;
                                                //DJ 190621
                                            END;//RSPLSUM22Feb21<<
                                        END;//RSPLAM03072021 >>
                                    END; //RSPLAM03072021 >>
                                END;
                            END;
                        END;
                    END;
                    //RSPLSUM-TCS<<

                    FOCValidation;//03Apr2019

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
                            RecDetGSTEntBuff.RESET;
                            RecDetGSTEntBuff.SETRANGE("Transaction Type", RecDetGSTEntBuff."Transaction Type"::Sales);
                            //RecDetGSTEntBuff.SETRANGE("Document Type", SL18."Document Type");
                            RecDetGSTEntBuff.SETRANGE("Document No.", rec."No.");
                            IF NOT RecDetGSTEntBuff.FINDFIRST THEN
                                ERROR('Detailed GST Entry Buffer does not exist, Please calculate structure values.');
                        END;
                    END;
                    //RSPLSUM 03Dec20<<

                    //RSPLSUM 11Aug2020>>
                    //RSPLSUM 28Aug2020>>
                    RecSLNew.RESET;
                    RecSLNew.SETRANGE("Document No.", rec."No.");
                    RecSLNew.SETFILTER("Inventory Posting Group", '%1|%2', 'AUTOOILS', 'REPSOL');
                    IF RecSLNew.FINDFIRST THEN
                        rec.TESTFIELD("Mintifi Channel Finance");
                    //RSPLSUM 28Aug2020<<
                    //RSPLSUM 28Aug2020--IF ("Shortcut Dimension 1 Code" = 'DIV-04') OR ("Shortcut Dimension 1 Code" = 'DIV-08') THEN
                    //RSPLSUM 28Aug2020TESTFIELD("Mintifi Channel Finance");
                    //RSPLSUM 11Aug2020<<

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



                    //>>RB-N 18Sep2017 MERCH Validation for GST Buffer Entry
                    IF rec."No." <> 'CSO/45/1819/0009' THEN BEGIN//CAS-20803-Q6L8D4
                        SL18.RESET;
                        SL18.SETRANGE("Document No.", rec."No.");
                        SL18.SETRANGE("Inventory Posting Group", 'MERCH');
                        IF SL18.FINDFIRST THEN BEGIN
                            DGST18.RESET;
                            DGST18.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Line No.");
                            DGST18.SETRANGE("Document No.", SL18."Document No.");
                            IF DGST18.FINDFIRST THEN
                                ERROR('Kindly Calculate Structure Value');

                        END;
                    END;//CAS-20803-Q6L8D4
                        //>>RB-N 18Sep2017 MERCH Validation for GST Buffer Entry

                    //>>RB-N 20Sep2017 Port Name Validation for Foreign Customer Group
                    IF rec."Customer Posting Group" = 'FOREIGN' THEN BEGIN
                        IF rec."Loading Port Name" = rec."Loading Port Name"::" " THEN
                            ERROR('Kindly Enter Loading Port Details');
                    END;
                    //>>RB-N 20Sep2017 Port Name Validation for Foreign Customer Group

                    IF rec."Location Code" <> 'BOND0001' THEN BEGIN
                        //>>RSPL/CUST/MERCH/001
                        SaleLineNew.RESET;
                        SaleLineNew.SETRANGE(SaleLineNew."Document No.", rec."No.");
                        IF SaleLineNew.FINDSET THEN
                            REPEAT
                            // IF SaleLineNew."Inventory Posting Group" <> 'MERCH' THEN
                            //  rec.TESTFIELD(Structure);
                            UNTIL SaleLineNew.NEXT = 0;
                        //<<RSPL/CUST/MERCH/001

                        //CAS-18282-F9P4T1 RB-N 10Oct2017
                        IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN BEGIN
                            SL10.RESET;
                            SL10.SETRANGE("Document No.", rec."No.");
                            IF SL10.FINDSET THEN
                                REPEAT
                                    IF SL10.Type <> SL10.Type::"G/L Account" THEN
                                        rec.TESTFIELD("Freight Type");
                                UNTIL SL10.NEXT = 0;
                        END;
                        //CAS-18282-F9P4T1 RB-N

                    END;

                    //RSPL008 >>>> Dimension Validation
                    recSalLine.RESET;
                    recSalLine.SETCURRENTKEY("Document No.", "Line No.");
                    recSalLine.SETRANGE("Document No.", rec."No.");
                    recSalLine.SETRANGE(Type, recSalLine.Type::Item);
                    recSalLine.SETFILTER("No.", '<>%1', '');
                    recSalLine.SETRANGE("Item Category Code", 'CAT14');
                    IF recSalLine.FINDFIRST THEN
                        REPEAT
                            CLEAR(vInventQty);
                            //        {  //RSPL-TC
                            //          recDocDim.RESET;
                            // recDocDim.SETRANGE("Table ID", 37);
                            // recDocDim.SETRANGE("Document Type", "Document Type"::Order);
                            // recDocDim.SETRANGE("Document No.", recSalLine."Document No.");
                            // recDocDim.SETRANGE("Line No.", recSalLine."Line No.");
                            // recDocDim.SETRANGE("Dimension Code", 'MERCH');
                            // IF recDocDim.FINDFIRST THEN BEGIN
                            //     recLedEntyDim.RESET;
                            //     recLedEntyDim.SETRANGE("Table ID", 32);
                            //     recLedEntyDim.SETRANGE("Dimension Code", recDocDim."Dimension Code");
                            //     recLedEntyDim.SETRANGE("Dimension Value Code", recDocDim."Dimension Value Code");
                            //     IF recLedEntyDim.FINDSET THEN
                            //         REPEAT
                            //             recIlentry.RESET;
                            //             recIlentry.SETCURRENTKEY("Entry No.");
                            //             recIlentry.SETRANGE("Entry No.", recLedEntyDim."Entry No.");
                            //             recIlentry.SETRANGE("Item No.", recSalLine."No.");
                            //             recIlentry.SETRANGE("Location Code", "Location Code");
                            //             IF recIlentry.FINDFIRST THEN
                            //                 vInventQty := vInventQty + recIlentry.Quantity
                            //             ELSE
                            //                 vInventQty := vInventQty;
                            //         UNTIL recLedEntyDim.NEXT = 0;

                            //     IF vInventQty < recSalLine.Quantity THEN
                            //         ERROR('Avaliable Qty %1 for the Item %2 Line %3', vInventQty, recSalLine."No.", recSalLine."Line No.");
                            // END;
                            //          }
                            //RSPL-TC +
                            RecDimSetEntry.RESET;
                            RecDimSetEntry.SETRANGE("Dimension Set ID", recSalLine."Dimension Set ID");
                            RecDimSetEntry.SETRANGE("Dimension Code", 'MERCH');
                            IF RecDimSetEntry.FINDSET THEN BEGIN
                                lDimSetEntry.RESET;
                                lDimSetEntry.SETRANGE("Dimension Code", RecDimSetEntry."Dimension Code");
                                lDimSetEntry.SETRANGE("Dimension Value Code", RecDimSetEntry."Dimension Value Code");
                                IF lDimSetEntry.FINDSET THEN
                                    REPEAT
                                        recIlentry.RESET;
                                        recIlentry.SETRANGE("Dimension Set ID", lDimSetEntry."Dimension Set ID");
                                        recIlentry.SETRANGE("Item No.", recSalLine."No.");
                                        recIlentry.SETRANGE("Location Code", rec."Location Code");
                                        IF recIlentry.FINDSET THEN
                                            REPEAT
                                                vInventQty := vInventQty + recIlentry.Quantity
                                            UNTIL recIlentry.NEXT = 0;
                                    UNTIL lDimSetEntry.NEXT = 0;
                                IF vInventQty < recSalLine.Quantity THEN
                                    ERROR('Avaliable Qty %1 for the Item %2 Line %3', vInventQty, recSalLine."No.", recSalLine."Line No.");
                            END;
                        //RSPL-TC -
                        UNTIL recSalLine.NEXT = 0;
                    //RSPL008 <<<< Dimension Validation


                    //EBT STIVAN---(01022013)----Error Message POP UP, IF Tracking QTY & Sales Line Aty to Ship does not Match----START
                    //              {
                    //              IF "Location Code" <> 'BOND0001' THEN BEGIN
                    //     IF NOT (("Location Code" = 'PLANT01') OR ("Location Code" = 'PLANT02') OR ("Location Code" = 'GDN0002')) THEN BEGIN
                    //         recsalesLineTable.RESET;
                    //         recsalesLineTable.SETRANGE(recsalesLineTable."Document No.", "No.");
                    //         recsalesLineTable.SETFILTER(recsalesLineTable."Qty. to Ship", '<>%1', 0);
                    //         recsalesLineTable.SETFILTER(recsalesLineTable."Inventory Posting Group", '%1', 'AUTOOILS');
                    //         IF recsalesLineTable.FINDFIRST THEN
                    //             REPEAT
                    //                 CLEAR(ResEntryQty);
                    //                 recResEntry.RESET;
                    //                 recResEntry.SETRANGE(recResEntry."Source Type", 37);
                    //                 recResEntry.SETRANGE(recResEntry."Source ID", recsalesLineTable."Document No.");
                    //                 recResEntry.SETRANGE(recResEntry."Location Code", recsalesLineTable."Location Code");
                    //                 recResEntry.SETRANGE(recResEntry."Item No.", recsalesLineTable."No.");
                    //                 recResEntry.SETRANGE(recResEntry."Source Ref. No.", recsalesLineTable."Line No.");
                    //                 recResEntry.SETFILTER(recResEntry."Transferred from Entry No.", '%1', 0);
                    //                 IF recResEntry.FINDFIRST THEN
                    //                     //BEGIN
                    //                     REPEAT
                    //                         ResEntryQty := ResEntryQty + recResEntry.Quantity;
                    //                     UNTIL recResEntry.NEXT = 0;

                    //                 IF recsalesLineTable."Qty. to Ship" <> ABS(ResEntryQty) THEN BEGIN
                    //                     //    {
                    //                     //    //mayuri
                    //                     //    IF (recsalesLineTable."Inventory Posting Group" = 'AUTOOILS') OR
                    //                     //    (recsalesLineTable."Inventory Posting Group" = 'INDOILS') THEN
                    //                     //     }
                    //                     ERROR('Please check the Item Tracking of Item No. %1 of Line No. %2. Please reduce the Qty'
                    //                     , recsalesLineTable."No.", recsalesLineTable."Line No.");
                    //                 END;
                    //             //END;
                    //             UNTIL recsalesLineTable.NEXT = 0;
                    //     END;
                    // END;
                    //              }
                    //EBT STIVAN---(01022013)----Error Message POP UP, IF Tracking QTY & Sales Line Aty to Ship does not Match------END

                    //EBT STIVAN ---(25012013)--- TO Check Header and Line Location Differ the Error Message POP UP------START
                    SaleLineNew.RESET;
                    SaleLineNew.SETRANGE(SaleLineNew."Document No.", rec."No.");
                    //SaleLineNew.SETRANGE(SaleLineNew.Type,SaleLineNew.Type::Item);//CAS-18282-F9P4T1 RB-N 10Oct2017
                    SaleLineNew.SETRANGE(SaleLineNew."Location Code", rec."Location Code");
                    IF NOT (SaleLineNew.FINDSET) THEN BEGIN
                        ERROR('Location Code in Sales Lines are differenet from header Level');
                    END;
                    //EBT STIVAN ---(25012013)--- TO Check Header and Line Location Differ the Error Message POP UP--------END

                    //EBT0002
                    IF rec."Location Code" <> 'BOND0001' THEN BEGIN
                        IF (rec."Shortcut Dimension 1 Code" = 'DIV-04') AND
                           ((rec."Location Code" <> 'PLANT01') OR (rec."Location Code" <> 'PLANT02')) THEN BEGIN
                            IF rec.Trading THEN BEGIN
                                IF (rec."Location Code" <> 'GDN0002') THEN BEGIN
                                    SaleLineNew.RESET;
                                    SaleLineNew.SETRANGE(SaleLineNew."Document No.", rec."No.");
                                    SaleLineNew.SETRANGE(SaleLineNew.Type, SaleLineNew.Type::Item);
                                    IF SaleLineNew.FINDSET THEN
                                        REPEAT
                                            IF SaleLineNew."Inventory Posting Group" <> 'MERCH' THEN//RSPL301215
                                                IF SaleLineNew."Lot No." = '' THEN
                                                    //      {
                                                    //    //mayuri
                                                    //    IF (SaleLineNew."Inventory Posting Group" = 'AUTOOILS' ) OR
                                                    //    (SaleLineNew."Inventory Posting Group" = 'INDOILS' ) THEN
                                                    //       }
                                                    ERROR('You need to select Item Tracking Before Releasing the Document');
                                        UNTIL SaleLineNew.NEXT = 0;
                                END;
                            END;
                        END;
                    END;
                    //EBT0002

                    //EBT STIVAN ---(21032012)--- Error Message POP UP if Shipment Method Code is Blank--------START
                    IF rec."Shipment Method Code" = '' THEN
                        ERROR('Shipment Method Code is Blank');
                    //EBT STIVAN ---(21032012)--- Error Message POP UP if Shipment Method Code is Blank----------END

                    //EBT STIVAN (29052012) -- If Ship to Code is Blank then Message Pop Up,
                    //
                    //                       if Sell to Customer No. State and Location Code State not Equal-------START

                    //  {
                    //  IF "Location Code" <> 'BOND0001' THEN
                    //  BEGIN
                    //    IF "Form Code" = '' THEN
                    //    BEGIN
                    //     IF "Ship-to Code" = '' THEN
                    //     BEGIN
                    //      recCust.RESET;
                    //      recCust.SETRANGE(recCust."No.","Sell-to Customer No.");
                    //      IF recCust.FINDFIRST THEN
                    //      CustState := recCust."State Code";

                    //      recLoc.RESET;
                    //      recLoc.SETRANGE(recLoc.Code,"Location Code");
                    //      IF recLoc.FINDFIRST THEN
                    //      LocState := recLoc."State Code";

                    //      IF CustState <> LocState THEN
                    //      MESSAGE('%1', 'Please Select Form Code');
                    //     END;
                    //    END;
                    //  END;
                    //  }//Commented as per UNNI Sir 27July2017

                    //EBT STIVAN (29052012) -- If Ship to Code is Blank then Message Pop Up,
                    //                         if Sell to Customer No. State and Location Code State not Equal---------END


                    //EBT STIVAN (29052012) -- If Ship to Code is NOT Blank then Message Pop Up,
                    //                         if Ship to Code State and Location Code State not Equal-------START
                    // IF rec."Location Code" <> 'BOND0001' THEN BEGIN
                    //     IF "Form Code" = '' THEN BEGIN
                    //         IF NOT (rec."Ship-to Code" = '') THEN BEGIN
                    //             recShiptoAdd.RESET;
                    //             recShiptoAdd.SETRANGE(recShiptoAdd."Customer No.", rec."Sell-to Customer No.");
                    //             IF recShiptoAdd.FINDFIRST THEN
                    //                 ShiptoCodeState := recShiptoAdd.State;

                    //             recLoc.RESET;
                    //             recLoc.SETRANGE(recLoc.Code, rec."Location Code");
                    //             IF recLoc.FINDFIRST THEN
                    //                 LocState := recLoc."State Code";

                    //             IF ShiptoCodeState <> LocState THEN
                    //                 MESSAGE('%1', 'Please Select Form Code');
                    //         END;
                    //     END;
                    // END;

                    //>>17May2018 CashCustomer--C15574
                    IF rec."Sell-to Customer No." = 'C15574' THEN BEGIN
                        rec.TESTFIELD("Salesperson Code");//19Nov2018
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                        rec."Campaign No." := 'Approved';
                        rec."Sent For Approval" := TRUE;
                        rec.MODIFY;
                        MESSAGE('Approved');
                        EXIT;
                    END;
                    //<<17May2018 CashCustomer

                    //EBT STIVAN (29052012) -- If Ship to Code is NOT Blank then Message Pop Up,
                    //                         if Ship to Code State and Location Code State not Equal---------END

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

                    //Credit Limit form attached  rspl022
                    CLEAR(FormAvCrd);
                    FormAvCrd.GetCustomerNo(rec."Bill-to Customer No.");
                    FormAvCrd.GetOrderNo(rec."No.");
                    FormAvCrd.RUNMODAL;
                    //Credit Limit form attached  rspl022



                    //EBT STIVAN ---(30072012)--- To Insert Dimension Code for Industrial without Dimension Value Code-------START
                    IF rec."Location Code" <> 'BOND0001' THEN BEGIN
                        IF rec."Shortcut Dimension 1 Code" = 'DIV-03' THEN BEGIN
                            //    {  //RSPL-TC
                            //     DocDimension.RESET;
                            //     DocDimension.SETRANGE(DocDimension."Table ID",36);
                            //     DocDimension.SETRANGE(DocDimension."Document Type",DocDimension."Document Type"::Order);
                            //     DocDimension.SETRANGE(DocDimension."Document No.","No.");
                            //     DocDimension.SETRANGE(DocDimension."Dimension Code",'REGHEADS');
                            //     IF DocDimension.FINDFIRST THEN
                            //     IF DocDimension."Dimension Value Code" = '' THEN
                            //     ERROR('Please Specify Regional Head in Dimension Value');

                            //     DocDimension.RESET;
                            //     DocDimension.SETRANGE(DocDimension."Table ID",36);
                            //     DocDimension.SETRANGE(DocDimension."Document Type",DocDimension."Document Type"::Order);
                            //     DocDimension.SETRANGE(DocDimension."Document No.","No.");
                            //     DocDimension.SETRANGE(DocDimension."Line No.",recSL."Line No.");
                            //     DocDimension.SETRANGE(DocDimension."Dimension Code",'THEADS');
                            //     IF DocDimension.FINDFIRST THEN
                            //     IF DocDimension."Dimension Value Code" = '' THEN
                            //     ERROR('Please Specify Territory Head in Dimension Value');

                            //     DocDimension.RESET;
                            //     DocDimension.SETRANGE(DocDimension."Table ID",36);
                            //     DocDimension.SETRANGE(DocDimension."Document Type",DocDimension."Document Type"::Order);
                            //     DocDimension.SETRANGE(DocDimension."Document No.","No.");
                            //     DocDimension.SETRANGE(DocDimension."Line No.",recSL."Line No.");
                            //     DocDimension.SETRANGE(DocDimension."Dimension Code",'HOD');
                            //     IF DocDimension.FINDFIRST THEN
                            //     IF DocDimension."Dimension Value Code" = '' THEN
                            //     ERROR('Please Specify Head of Department in Dimension Value');

                            //     DocDimension.RESET;
                            //     DocDimension.SETRANGE(DocDimension."Table ID",36);
                            //     DocDimension.SETRANGE(DocDimension."Document Type",DocDimension."Document Type"::Order);
                            //     DocDimension.SETRANGE(DocDimension."Document No.","No.");
                            //     DocDimension.SETRANGE(DocDimension."Line No.",recSL."Line No.");
                            //     DocDimension.SETRANGE(DocDimension."Dimension Code",'SALESPERSON');
                            //     IF DocDimension.FINDFIRST THEN
                            //     IF DocDimension."Dimension Value Code" = '' THEN
                            //     ERROR('Please Specify SalesPerson in Dimension Value');
                            //     }
                            //RSPL-TC +

                            //21July2017 as per UNI SIr
                            //     {
                            //     lDimSetEntry.RESET;
                            //     lDimSetEntry.SETRANGE("Dimension Set ID","Dimension Set ID");
                            //     lDimSetEntry.SETRANGE("Dimension Code",'REGHEADS');
                            //     IF lDimSetEntry.FINDSET THEN
                            //       IF (lDimSetEntry."Dimension Value Code" = '') OR (lDimSetEntry."Dimension Value Code" ='PLEASE TAG DIMENSION') THEN
                            //        ERROR('Please Specify Regional Head in Dimension Value');

                            //     lDimSetEntry.RESET;
                            //     lDimSetEntry.SETRANGE("Dimension Set ID","Dimension Set ID");
                            //     lDimSetEntry.SETRANGE("Dimension Code",'THEADS');
                            //     IF lDimSetEntry.FINDSET THEN
                            //       IF (lDimSetEntry."Dimension Value Code" = '') OR (lDimSetEntry."Dimension Value Code" ='PLEASE TAG DIMENSION') THEN
                            //        ERROR('Please Specify Territory Head in Dimension Value');

                            //     lDimSetEntry.SETRANGE("Dimension Set ID","Dimension Set ID");
                            //     lDimSetEntry.SETRANGE("Dimension Code",'HOD');
                            //     IF lDimSetEntry.FINDSET THEN
                            //       IF (lDimSetEntry."Dimension Value Code" = '') OR (lDimSetEntry."Dimension Value Code" ='PLEASE TAG DIMENSION') THEN
                            //        ERROR('Please Specify Head of Department in Dimension Value');
                            //    }
                            //21July2017 as per UNNI SIr


                            lDimSetEntry.SETRANGE("Dimension Set ID", REC."Dimension Set ID");
                            lDimSetEntry.SETRANGE("Dimension Code", 'SALESPERSON');
                            IF lDimSetEntry.FINDSET THEN
                                IF (lDimSetEntry."Dimension Value Code" = '') OR (lDimSetEntry."Dimension Value Code" = 'PLEASE TAG DIMENSION') THEN
                                    ERROR('Please Specify SalesPerson in Dimension Value');
                            //RSPL-Tc -
                        END;
                    END;
                    //EBT STIVAN ---(30072012)--- To Insert Dimension Code for Industrial without Dimension Value Code---------END



                    //EBT STIVAN ---(18042012)--- To Insert Dimension Code for Indoils without Dimension Value Code-------START
                    IF REC."Location Code" <> 'BOND0001' THEN BEGIN
                        recSL.RESET;
                        recSL.SETRANGE(recSL."Document No.", REC."No.");
                        recSL.SETRANGE(recSL."Inventory Posting Group", 'INDOILS');
                        IF recSL.FINDSET THEN
                            REPEAT
                                //    { //RSPL-TC
                                //     DocDimension.RESET;
                                // DocDimension.SETRANGE(DocDimension."Table ID", 37);
                                // DocDimension.SETRANGE(DocDimension."Document Type", DocDimension."Document Type"::Order);
                                // DocDimension.SETRANGE(DocDimension."Document No.", recSL."Document No.");
                                // DocDimension.SETRANGE(DocDimension."Line No.", recSL."Line No.");
                                // DocDimension.SETRANGE(DocDimension."Dimension Code", 'SALEGROUP');
                                // IF DocDimension.FINDFIRST THEN
                                //     IF DocDimension."Dimension Value Code" = '' THEN
                                //         ERROR('Please Specify SalesGroup in Dimension Value in Line No. %1', recSL."Line No.");

                                // DocDimension.RESET;
                                // DocDimension.SETRANGE(DocDimension."Table ID", 37);
                                // DocDimension.SETRANGE(DocDimension."Document Type", DocDimension."Document Type"::Order);
                                // DocDimension.SETRANGE(DocDimension."Document No.", recSL."Document No.");
                                // DocDimension.SETRANGE(DocDimension."Line No.", recSL."Line No.");
                                // DocDimension.SETRANGE(DocDimension."Dimension Code", 'REGHEADS');
                                // IF DocDimension.FINDFIRST THEN
                                //     IF DocDimension."Dimension Value Code" = '' THEN
                                //         ERROR('Please Specify Regional Head in Dimension Value in Line No. %1', recSL."Line No.");

                                // DocDimension.RESET;
                                // DocDimension.SETRANGE(DocDimension."Table ID", 37);
                                // DocDimension.SETRANGE(DocDimension."Document Type", DocDimension."Document Type"::Order);
                                // DocDimension.SETRANGE(DocDimension."Document No.", recSL."Document No.");
                                // DocDimension.SETRANGE(DocDimension."Line No.", recSL."Line No.");
                                // DocDimension.SETRANGE(DocDimension."Dimension Code", 'THEADS');
                                // IF DocDimension.FINDFIRST THEN
                                //     IF DocDimension."Dimension Value Code" = '' THEN
                                //         ERROR('Please Specify Territory Head in Dimension Value in Line No. %1', recSL."Line No.");

                                // DocDimension.RESET;
                                // DocDimension.SETRANGE(DocDimension."Table ID", 37);
                                // DocDimension.SETRANGE(DocDimension."Document Type", DocDimension."Document Type"::Order);
                                // DocDimension.SETRANGE(DocDimension."Document No.", recSL."Document No.");
                                // DocDimension.SETRANGE(DocDimension."Line No.", recSL."Line No.");
                                // DocDimension.SETRANGE(DocDimension."Dimension Code", 'HOD');
                                // IF DocDimension.FINDFIRST THEN
                                //     IF DocDimension."Dimension Value Code" = '' THEN
                                //         ERROR('Please Specify Head of Department in Dimension Value in Line No. %1', recSL."Line No.");

                                // DocDimension.RESET;
                                // DocDimension.SETRANGE(DocDimension."Table ID", 37);
                                // DocDimension.SETRANGE(DocDimension."Document Type", DocDimension."Document Type"::Order);
                                // DocDimension.SETRANGE(DocDimension."Document No.", recSL."Document No.");
                                // DocDimension.SETRANGE(DocDimension."Line No.", recSL."Line No.");
                                // DocDimension.SETRANGE(DocDimension."Dimension Code", 'SALESPERSON');
                                // IF DocDimension.FINDFIRST THEN
                                //     IF DocDimension."Dimension Value Code" = '' THEN
                                //         ERROR('Please Specify SalesPerson in Dimension Value in Line No. %1', recSL."Line No.");
                                //     }

                                //21July2017 as per UNNI SIr
                                //             {

                                //             lDimSetEntry.RESET;
                                // lDimSetEntry.SETRANGE("Dimension Set ID", recSL."Dimension Set ID");
                                // lDimSetEntry.SETRANGE("Dimension Code", 'SALEGROUP');
                                // IF lDimSetEntry.FINDSET THEN
                                //     IF (lDimSetEntry."Dimension Value Code" = '') OR (lDimSetEntry."Dimension Value Code" = 'PLEASE TAG DIMENSION') THEN
                                //         ERROR('Please Specify SalesGroup in Dimension Value in Line No. %1', recSL."Line No.");

                                // lDimSetEntry.RESET;
                                // lDimSetEntry.SETRANGE("Dimension Set ID", recSL."Dimension Set ID");
                                // lDimSetEntry.SETRANGE("Dimension Code", 'REGHEADS');
                                // IF lDimSetEntry.FINDSET THEN
                                //     IF (lDimSetEntry."Dimension Value Code" = '') OR (lDimSetEntry."Dimension Value Code" = 'PLEASE TAG DIMENSION') THEN
                                //         ERROR('Please Specify Regional Head in Dimension Value in Line No. %1', recSL."Line No.");

                                // lDimSetEntry.RESET;
                                // lDimSetEntry.SETRANGE("Dimension Set ID", recSL."Dimension Set ID");
                                // lDimSetEntry.SETRANGE("Dimension Code", 'THEADS');
                                // IF lDimSetEntry.FINDSET THEN
                                //     IF (lDimSetEntry."Dimension Value Code" = '') OR (lDimSetEntry."Dimension Value Code" = 'PLEASE TAG DIMENSION') THEN
                                //         ERROR('Please Specify Territory Head in Dimension Value in Line No. %1', recSL."Line No.");

                                // lDimSetEntry.RESET;
                                // lDimSetEntry.SETRANGE("Dimension Set ID", recSL."Dimension Set ID");
                                // lDimSetEntry.SETRANGE("Dimension Code", 'HOD');
                                // IF lDimSetEntry.FINDSET THEN
                                //     IF (lDimSetEntry."Dimension Value Code" = '') OR (lDimSetEntry."Dimension Value Code" = 'PLEASE TAG DIMENSION') THEN
                                //         ERROR('Please Specify Head of Department in Dimension Value in Line No. %1', recSL."Line No.");

                                //             }
                                //             //21July2017 as per UNNI SIr

                                lDimSetEntry.RESET;
                                lDimSetEntry.SETRANGE("Dimension Set ID", recSL."Dimension Set ID");
                                lDimSetEntry.SETRANGE("Dimension Code", 'SALESPERSON');
                                IF lDimSetEntry.FINDSET THEN
                                    IF (lDimSetEntry."Dimension Value Code" = '') OR (lDimSetEntry."Dimension Value Code" = 'PLEASE TAG DIMENSION') THEN
                                        ERROR('Please Specify SalesPerson in Dimension Value in Line No. %1', recSL."Line No.");
                            UNTIL recSL.NEXT = 0;
                    END;
                    //EBT STIVAN ---(18042012)--- To Insert Dimension Code for Indoils without Dimension Value Code---------END


                    //EBT/OVERDUE/APV/0001
                    IF NOT REC."Sent For Approval" THEN BEGIN

                        //>>RB-N 17Nov2017
                        TempVersionNo := 0;
                        SAE17.RESET;
                        SAE17.SETCURRENTKEY("Document No.", "Version No.");
                        SAE17.SETRANGE("Document Type", SAE17."Document Type"::"Sales Order");
                        SAE17.SETRANGE("Document No.", REC."No.");
                        IF SAE17.FINDLAST THEN BEGIN
                            TempVersionNo := SAE17."Version No.";
                        END;
                        //<<RB-N 17Nov2017

                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SalesApproval."Document Type"::"Sales Order");
                        SalesApproval.SETRANGE(SalesApproval."User ID", USERID);
                        SalesApproval.SETFILTER("Approvar ID", '<>%1', '');
                        IF SalesApproval.FINDSET THEN BEGIN
                            TempSeqNo := 0;//16May2018
                            REPEAT
                                EnableDim := FALSE;
                                IF (SalesApproval."Division Code" = '') AND (SalesApproval."Division Code 2" = '') AND (SalesApproval."Division Code 3" = '')
                                AND (SalesApproval."Division Code 4" = '') AND (SalesApproval."Division Code 5" = '') THEN
                                    EnableDim := TRUE;

                                IF (SalesApproval."Division Code" = rec."Shortcut Dimension 1 Code") OR (SalesApproval."Division Code 2" = rec."Shortcut Dimension 1 Code")
                                OR (SalesApproval."Division Code 3" = rec."Shortcut Dimension 1 Code") OR (SalesApproval."Division Code 4" = rec."Shortcut Dimension 1 Code")
                                OR (SalesApproval."Division Code 5" = rec."Shortcut Dimension 1 Code") THEN
                                    EnableDim := TRUE;

                                //>>21May2018
                                IF NOT EnableDim THEN BEGIN
                                    Cus21.RESET;
                                    IF Cus21.GET(rec."Sell-to Customer No.") THEN
                                        IF (SalesApproval."Division Code" = Cus21."Global Dimension 1 Code") OR (SalesApproval."Division Code 2" = Cus21."Global Dimension 1 Code")
                                        OR (SalesApproval."Division Code 3" = Cus21."Global Dimension 1 Code") OR (SalesApproval."Division Code 3" = Cus21."Global Dimension 1 Code")
                                        OR (SalesApproval."Division Code 5" = Cus21."Global Dimension 1 Code") THEN
                                            EnableDim := TRUE;
                                END;
                                //<<21May2018
                                IF EnableDim THEN BEGIN
                                    TempSeqNo += 1;//16May2018
                                    SalesApprovalEntry.INIT;
                                    SalesApprovalEntry."Document Type" := SalesApprovalEntry."Document Type"::"Sales Order";
                                    SalesApprovalEntry."Document No." := rec."No.";
                                    SalesApprovalEntry."User ID" := USERID;
                                    SalesApprovalEntry."User Name" := SalesApproval.Name;
                                    SalesApprovalEntry."Approvar ID" := SalesApproval."Approvar ID";
                                    SalesApprovalEntry."Approver Name" := SalesApproval."Approvar Name";
                                    SalesApprovalEntry."Mandatory ID" := SalesApproval.Mandatory;
                                    SalesApprovalEntry."Date Sent for Approval" := TODAY;
                                    SalesApprovalEntry."Time Sent for Approval" := TIME;
                                    SalesApprovalEntry."Version No." := TempVersionNo + 1;//RB-N 17Nov2017
                                    SalesApprovalEntry."Sequence No." := TempSeqNo;//16May2018
                                    SalesApprovalEntry."Division Code" := rec."Shortcut Dimension 1 Code";//17May2018
                                    SalesApprovalEntry.INSERT;
                                END;
                            UNTIL SalesApproval.NEXT = 0;
                            //>>15May2018
                            SRSetup.GET;
                            IF SRSetup."Email Notification On SO" THEN
                                EmailNotification(0, rec."No.", 1, USERID, '', '');
                            //>>15May2018

                            //RSPLSUM 14Jan21>>
                            IF SRSetup."Email PDF of SO to SalesPeople" THEN BEGIN
                                RecDimValueNew.RESET;
                                RecDimValueNew.SETRANGE("Dimension Code", 'DIVISION');
                                RecDimValueNew.SETRANGE(Code, rec."Shortcut Dimension 1 Code");
                                RecDimValueNew.SETFILTER("Email PDF of SO", '%1', TRUE);
                                IF RecDimValueNew.FINDFIRST THEN
                                    EmailToSalesperson;
                            END;
                            //RSPLSUM 14Jan21<<

                            MESSAGE('Document No. %1 has been sent for Approval', rec."No.");
                        END
                        ELSE
                            ERROR('Sales Approval setup does not exists for User %1', USERID);
                    END
                    ELSE
                        ERROR('Document No. %1 has already been sent for approval');
                    //EBT/OVERDUE/APV/0001

                    //EBT STIVAN ---(02052012)--- For Approval Process --------START
                    rec."Sent For Approval" := TRUE;
                    rec."Campaign No." := 'Pending for Approval';
                    rec.MODIFY;
                    //EBT STIVAN ---(02052012)--- For Approval Process ----------END
                END;

            }
            action("Structure Header Details")
            {
                //tempory comment
                // ApplicationArea = all;
                // RunObject = Page 50054;
                // RunPageLink = Type = CONST(Sale),
                //                   "Document Type" = FIELD("Document Type"),
                //                   "Document No." = FIELD("No."),
                //                   "Structure Code" = FIELD(Structure),
                //                   "Document Line No." = FILTER(0),
                //                   "Header/Line" = CONST(Header);
                // Visible = False



            }
            action("Bunker Info")
            {
                trigger OnAction()
                VAR
                    RecSL: Record 37;
                BEGIN
                    IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN
                        ERROR('Bunker Info applicable only for Fuel Oil division');

                    //              {RecSL.RESET;
                    // RecSL.SETRANGE("Document No.", "No.");
                    // IF RecSL.FINDSET THEN BEGIN
                    //     REPEAT
                    //         IF RecSL."Item Category Code" <> 'CAT21' THEN
                    //             ERROR('You do not have permission, please contact system administrator');
                    //     UNTIL RecSL.NEXT = 0;
                    // END ELSE
                    //     ERROR('You do not have permission, please contact system administrator');
                    //              }

                    RecSHAddInfo.RESET;
                    IF NOT RecSHAddInfo.GET(rec."Document Type", rec."No.") THEN BEGIN
                        RecSHAddInfo.INIT;
                        //  RecSHAddInfo."Document Type" := rec."Document Type";
                        RecSHAddInfo."No." := rec."No.";
                        RecSHAddInfo.INSERT;
                    END;

                    AddInfo.RESET;
                    AddInfo.SETRANGE("Document Type", rec."Document Type");
                    AddInfo.SETRANGE("No.", rec."No.");
                    PAGE.RUN(PAGE::"Sales Order Additional Info", AddInfo);
                END;


            }

        }
    }


    trigger OnOpenPage()
    var
        myInt: Integer;
    BEGIN
        // RSPL-TC +
        CLEAR(SalesPerCodeEditable);
        CLEAR(ShortCloseEdtiable);
        CLEAR(AppDescEditable);
        //RSPL-TC +
        //EBT STIVAN ---(21062012)--- To make SalesPerson Code Editable if Division is DIV-03 ----------START
        //CurrForm."Salesperson Code".EDITABLE := "Shortcut Dimension 1 Code" = 'DIV-03';
        IF rec."Shortcut Dimension 1 Code" = 'DIV-03' THEN //RSPL-TC
            SalesPerCodeEditable := TRUE; //RSPL-TC
                                          //EBT STIVAN ---(21062012)--- To make SalesPerson Code Editable if Division is DIV-03 ------------END

        //>>05Jul2018 RB-N
        IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN //RSPLSUM 28May2020
            DueDateGP;
        //<<05Jul2018 RB-N

        //EBT01 start
        SalesHead.RESET();
        SalesHead.SETRANGE(SalesHead."Document Type", SalesHead."Document Type"::Order);
        SalesHead.SETRANGE(SalesHead."Short Close", FALSE);
        IF SalesHead.FINDFIRST THEN
            REPEAT

                //RSPLSUM 15May2020>>
                CLEAR(ShortCloseDaysFound);
                CLEAR(ShortCloseDateCheck);
                IF SalesHead."Shortcut Dimension 1 Code" <> '' THEN BEGIN
                    RecDimValue.RESET;
                    RecDimValue.SETRANGE("Dimension Code", 'DIVISION');
                    RecDimValue.SETRANGE(Code, SalesHead."Shortcut Dimension 1 Code");
                    RecDimValue.SETFILTER("Short Close Days", '<>%1', 0);
                    IF RecDimValue.FINDFIRST THEN
                        ShortCloseDaysFound := TRUE
                    ELSE
                        ShortCloseDaysFound := FALSE;
                END ELSE
                    ShortCloseDaysFound := FALSE;

                IF NOT ShortCloseDaysFound THEN
                    ShortCloseDateCheck := SalesHead."Document Date" + 30
                ELSE
                    ShortCloseDateCheck := SalesHead."Document Date" + RecDimValue."Short Close Days";
                //RSPLSUM 15May2020<<

                //RSPLSUM 15May2020--IF WORKDATE > SalesHead."Document Date"+30 THEN
                IF WORKDATE > ShortCloseDateCheck THEN//RSPLSUM 15May2020
                BEGIN
                    ReservEntr.RESET;
                    ReservEntr.SETRANGE(ReservEntr."Source ID", SalesHead."No.");
                    IF ReservEntr.FINDSET THEN
                        ReservEntr.DELETEALL;

                    //EBT STIVAN---(20032012)--- To Delete Detail RG 23 D Table,if its short Closed------------------START
                    /*  recDetailRG23D.RESET;
                      recDetailRG23D.SETRANGE(recDetailRG23D."Document Type", recDetailRG23D."Document Type"::Order);
                      recDetailRG23D.SETRANGE(recDetailRG23D."Order No.", SalesHead."No.");
                      recDetailRG23D.SETFILTER(recDetailRG23D."Document No.", '%1', '');
                      IF recDetailRG23D.FINDSET THEN
                          recDetailRG23D.DELETEALL;*/
                    //EBT STIVAN---(20032012)--- To Delete Detail RG 23 D Table,if its short Closed--------------------END

                    SalesHead1.GET(SalesHead."Document Type", SalesHead."No.");
                    SalesHead1."Short Close" := TRUE;
                    SalesHead1."Short Close Date" := WORKDATE;//RSPLSUM 15May2020
                    SalesHead1.MODIFY;

                    //RSPLSUM 15May2020>>
                    RecSalesLine.RESET;
                    RecSalesLine.SETRANGE("Document Type", SalesHead."Document Type");
                    RecSalesLine.SETRANGE("Document No.", SalesHead."No.");
                    IF RecSalesLine.FINDFIRST THEN
                        RecSalesLine.MODIFYALL("Short Close", TRUE);
                    //RSPLSUM 15May2020<<

                END;
            UNTIL SalesHead.NEXT = 0;
        //EBT01 end

        //          {
        //          //EBT0001
        //          CSOMapping2.RESET;
        // CSOMapping2.SETRANGE(CSOMapping2."User Id", UPPERCASE(USERID));
        // IF CSOMapping2.FINDFIRST THEN BEGIN
        //     FILTERGROUP(2);
        //     CSO.RESET;
        //     CSO.SETRANGE(CSO."Document Type", "Document Type"::Order);
        //     CSO.SETFILTER(CSO."Short Close", '%1', FALSE);
        //     IF CSO.FINDSET THEN
        //         REPEAT
        //             CSOMapping.RESET;
        //             CSOMapping.SETRANGE(CSOMapping."User Id", UPPERCASE(USERID));
        //             CSOMapping.SETRANGE(CSOMapping.Type, CSOMapping.Type::"Responsibility Center");
        //             CSOMapping.SETRANGE(CSOMapping.Value, CSO."Responsibility Center");
        //             IF CSOMapping.FINDFIRST THEN
        //                 CSO.MARK := TRUE
        //             ELSE BEGIN
        //                 CSOMapping1.RESET;
        //                 CSOMapping1.SETRANGE("User Id", UPPERCASE(USERID));
        //                 CSOMapping1.SETRANGE(Type, CSOMapping.Type::Location);
        //                 CSOMapping1.SETRANGE(Value, CSO."Location Code");
        //                 IF CSOMapping1.FINDFIRST THEN
        //                     CSO.MARK := TRUE
        //             END;
        //         UNTIL CSO.NEXT = 0;
        //     CSO.MARKEDONLY(TRUE);
        //     COPY(CSO);
        //     FILTERGROUP(0);
        // END
        // ELSE BEGIN
        //     IF UserMgt.GetSalesFilter <> '' THEN BEGIN
        //         FILTERGROUP(2);
        //         SETRANGE("Responsibility Center", UserMgt.GetSalesFilter);
        //         FILTERGROUP(0);
        //     END;
        // END;
        //          }

        rec.SETRANGE("Date Filter", 0D, WORKDATE - 1);

        ShortCloseEdtiable := FALSE;
        //EBT STIVAN (29052012) --- To Make Short Close Field Editable only to User ID SA -------START
        User.GET(USERID);
        IF (User."User ID" = 'GPUAE\FAHIM.AHMAD') OR (User."User ID" = 'GPUAE\RAVI.KHAMBAL') OR (User."User ID" = 'GPUAE\DEEPAK.TIWARI') THEN
            //CurrForm."Short Close".EDITABLE := TRUE;
            ShortCloseEdtiable := TRUE //RSPL-TC
        ELSE
            ShortCloseEdtiable := FALSE;
        //EBT STIVAN (29052012) --- To Make Short Close Field Editable only to User ID SA ---------END

        //EBT STIVAN ---(19022013)---To make Approval Description Field Editable only to the Approval ID from Sales Approval Table----START

        recSalesApproval.RESET;
        //recSalesApproval.SETRANGE(recSalesApproval."User ID",USERID);
        recSalesApproval.SETRANGE("Document Type", recSalesApproval."Document Type"::"Sales Order");
        recSalesApproval.SETRANGE(recSalesApproval."Approvar ID", USERID);
        IF recSalesApproval.FINDFIRST THEN BEGIN
            //CurrForm."Approval Description".EDITABLE := TRUE;
            AppDescEditable := TRUE;
        END;
        //EBT STIVAN ---(19022013)---To make Approval Description Field Editable only to the Approval ID from Sales Approval Table------END

        // EBT MILAN TO NON-EDITABLE FRAIIGHT TYPE AFTER APPRUVE 310114-------------------------START
        IF (UPPERCASE(USERID) <> 'GPUAE\FAHIM.AHMAD') AND (UPPERCASE(USERID) <> 'GPUAE\RAVI.KHAMBAL') THEN BEGIN
            recSalesApproval.RESET;
            //recSalesApproval.SETRANGE(recSalesApproval."User ID",USERID);
            recSalesApproval.SETRANGE("Document Type", recSalesApproval."Document Type"::"Sales Order");
            recSalesApproval.SETRANGE(recSalesApproval."Approvar ID", USERID);
            IF recSalesApproval.FINDFIRST THEN BEGIN
                //CurrForm."Approval Description".EDITABLE := TRUE;
                //CurrForm."Freight Type".EDITABLE := TRUE;
                //CurrForm."Freight Charges".EDITABLE := TRUE;
                AppDescEditable := TRUE; //RSPL-TC
                FreightTypeEditable := TRUE; //RSPL-TC
                FreightChargesEditable := TRUE //RSPL-TC
            END
            ELSE BEGIN
                IF rec."Campaign No." = 'APPROVED' THEN BEGIN
                    //CurrForm."Freight Type".EDITABLE := FALSE;
                    //CurrForm."Freight Charges".EDITABLE := FALSE;
                    FreightChargesEditable := FALSE;
                    FreightTypeEditable := FALSE;
                END ELSE
                // IF "Campaign No." = '' THEN
                BEGIN
                    //CurrForm."Freight Type".EDITABLE := TRUE;
                    //CurrForm."Freight Charges".EDITABLE := TRUE;
                    FreightTypeEditable := TRUE; //RSPL-TC
                    FreightChargesEditable := TRUE; //RSPL-TC
                END;

            END;
        END;

        //EBT0001
        //>>Robosoft\Migratuon\Rahul***Code added to modify posting date
        IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN BEGIN
            IF rec."No." <> '' THEN BEGIN
                IF rec."Posting Date" <> TODAY THEN BEGIN
                    //VALIDATE("Posting Date",TODAY);
                    rec."Posting Date" := TODAY;
                    SalesLine1.RESET;
                    SalesLine1.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    SalesLine1.SETRANGE("Document Type", rec."Document Type");
                    SalesLine1.SETRANGE("Document No.", rec."No.");
                    IF SalesLine1.FINDSET THEN
                        REPEAT
                            SalesLine1."Posting Date" := TODAY;
                            SalesLine1.MODIFY;
                        UNTIL SalesLine1.NEXT = 0;
                    rec.MODIFY;
                END;

                IF rec."Shipment Date" <> TODAY THEN BEGIN
                    // VALIDATE("Shipment Date",TODAY);
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
        END;
        //EBT0001

        // EBT MILAN TO NON-EDITABLE FRAIIGHT TYPE AFTER APPRUVE 310114---------------------------END
        //  SetDocNoVisible;

        // CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;

        //RSPLSUM 25May2020>>
        IF (rec."Shortcut Dimension 1 Code" = 'DIV-14') OR (rec."Shortcut Dimension 1 Code" = 'DIV-10') THEN
            EditBunkerFields := TRUE
        ELSE
            EditBunkerFields := FALSE;
        //RSPLSUM 25May2020<<
    END;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    BEGIN
        //RSPL-TC +
        CLEAR(SalesPerCodeEditable);
        CLEAR("LR/RRNoEditable");
        CLEAR("LR/RRDateEditable");
        CLEAR(VehicaleNoEditable);
        CLEAR(DrivNameEditable);
        CLEAR(DrivLicNoEditable);
        CLEAR(DrivMobNoEditable);
        CLEAR(VechCapEtdiable);
        CLEAR(ExpTPTCostEditable);
        CLEAR(LocalLRNoEditable);
        CLEAR(LocalLRDateEditable);
        CLEAR(LocalVehicaleNoEditable);
        CLEAR(LocalVechCapEtdiable);
        CLEAR(LocalDrivNameEditable);
        CLEAR(LocalDrivLicNoEditable);
        CLEAR(LocalDrivMobNoEditable);
        CLEAR(LocalExpTPTCostEditable);
        CLEAR(SalesPerCodeEditable);
        //CLEAR(ShortCloseEdtiable);
        CLEAR(AppDescEditable);
        //RSPL-TC -

        //SetControlVisibility;
        // IF "Re-Dispatch" THEN
        //     ReturnOrderNoVisible := TRUE
        // ELSE
        //     ReturnOrderNoVisible := FALSE;

        recSalesApprovalEntry1.RESET;
        recSalesApprovalEntry1.SETRANGE(recSalesApprovalEntry1."Document Type", recSalesApprovalEntry1."Document Type"::"Sales Order");
        recSalesApprovalEntry1.SETRANGE(recSalesApprovalEntry1."Document No.", rec."No.");
        recSalesApprovalEntry1.SETRANGE(recSalesApprovalEntry1."Mandatory ID", TRUE);
        IF recSalesApprovalEntry1.FINDFIRST THEN BEGIN
            IF NOT (recSalesApprovalEntry1.Approved) THEN
                ApprovalStatus := 'Pending For Approval';
        END ELSE BEGIN
            ApprovalStatus := '';
        END;


        recSalesApprovalEntry1.RESET;
        recSalesApprovalEntry1.SETRANGE(recSalesApprovalEntry1."Document Type", recSalesApprovalEntry1."Document Type"::"Sales Order");
        recSalesApprovalEntry1.SETRANGE(recSalesApprovalEntry1."Document No.", rec."No.");
        recSalesApprovalEntry1.SETRANGE(recSalesApprovalEntry1."Mandatory ID", TRUE);
        recSalesApprovalEntry1.SETRANGE(recSalesApprovalEntry1.Approved, TRUE);
        IF recSalesApprovalEntry1.FINDFIRST THEN BEGIN
            ApprovalStatus := 'Approved';
        END ELSE BEGIN
            ApprovalStatus := '';
        END;
        //RSPL/Migration/Rahul****Allow back entries

        //EBT0001
        //                {
        //                IF "Posting Date" <> TODAY THEN
        //     "Posting Date" := TODAY;
        // IF "Shipment Date" <> TODAY THEN
        //     "Shipment Date" := TODAY;
        //                }
        //EBT0001

        //EBT STIVAN ---(21062012)--- To make SalesPerson Code Editable if Division is DIV-03 ----------START
        //CurrForm."Salesperson Code".EDITABLE := "Shortcut Dimension 1 Code" = 'DIV-03';
        IF rec."Shortcut Dimension 1 Code" = 'DIV-03' THEN
            SalesPerCodeEditable := TRUE;
        //EBT STIVAN ---(21062012)--- To make SalesPerson Code Editable if Division is DIV-03 ------------END

        //EBT STIVAN ---(18102012)--- To Update the Sell to State Desc and Ship to State Desc on Form Level------START
        IF rec."Sell-to Customer No." <> '' THEN BEGIN
            CLEAR(StateDesc);
            CLEAR(Ship2StateDesc);
            recState.RESET;
            recState.SETRANGE(recState.Code, rec.State);
            IF recState.FINDFIRST THEN BEGIN
                StateDesc := recState.Description;
                Ship2StateDesc := recState.Description;
            END;
        END
        ELSE BEGIN
            StateDesc := '';
            Ship2StateDesc := '';
        END;

        IF rec."Ship-to Code" <> '' THEN BEGIN
            CLEAR(Ship2StateDesc);
            recState1.RESET;
            recState1.SETRANGE(recState1.Code, rec."Ship-to State Code");
            IF recState1.FINDFIRST THEN BEGIN
                Ship2StateDesc := recState1.Description;
            END;
        END
        ELSE BEGIN
            CLEAR(Ship2StateDesc);
            recState1.RESET;
            recState1.SETRANGE(recState1.Code, rec.State);
            IF recState1.FINDFIRST THEN BEGIN
                Ship2StateDesc := recState1.Description;
            END;
        END;
        //EBT STIVAN ---(18102012)--- To Update the Sell to State Desc and Ship to State Desc on Form Level--------END

        //EBT STIVAN--(31072013)--To Make Below Editable and Uneditable as per Transport Type-------------START
        IF rec."Transport Type" = rec."Transport Type"::"Local+Intercity" THEN BEGIN
            //              {
            //              CurrForm."LR/RR No.".EDITABLE := FALSE;
            // CurrForm."LR/RR Date".EDITABLE := FALSE;
            // CurrForm."Vehicle No.".EDITABLE := FALSE;
            // CurrForm."Driver's Name".EDITABLE := FALSE;
            // CurrForm."Driver's License No.".EDITABLE := FALSE;
            // CurrForm."Driver's Mobile No.".EDITABLE := FALSE;
            // CurrForm."Vehicle Capacity".EDITABLE := TRUE;  // MILAN 201213 was FALSE
            // CurrForm."Expected TPT Cost".EDITABLE := TRUE;

            // CurrForm."Local LR No.".EDITABLE := TRUE;
            // CurrForm."Local LR Date".EDITABLE := TRUE;
            // CurrForm."Local Vehicle No.".EDITABLE := TRUE;
            // CurrForm."Local Vehicle Capacity".EDITABLE := TRUE;
            // CurrForm."Local Driver's Mobile No.".EDITABLE := TRUE;
            // CurrForm."Local Driver's License No.".EDITABLE := TRUE;
            // CurrForm."Local Driver's Name".EDITABLE := TRUE;
            // CurrForm."Local Expected TPT Cost".EDITABLE := TRUE;
            //              }
            // RSPL-TC +
            "LR/RRNoEditable" := FALSE;
            "LR/RRDateEditable" := FALSE;
            VehicaleNoEditable := FALSE;
            DrivNameEditable := FALSE;
            DrivLicNoEditable := FALSE;
            DrivMobNoEditable := FALSE;
            VechCapEtdiable := TRUE; // MILAN 201213 was FALSE
            ExpTPTCostEditable := TRUE;

            LocalLRNoEditable := TRUE;
            LocalLRDateEditable := TRUE;
            LocalVehicaleNoEditable := TRUE;
            LocalVechCapEtdiable := TRUE;
            LocalDrivNameEditable := TRUE;
            LocalDrivLicNoEditable := TRUE;
            LocalDrivMobNoEditable := TRUE;
            LocalExpTPTCostEditable := TRUE;
            // RSPL-TC -
        END;

        IF rec."Transport Type" = rec."Transport Type"::Intercity THEN BEGIN
            //  {
            //  CurrForm."LR/RR No.".EDITABLE := TRUE;
            //  CurrForm."LR/RR Date".EDITABLE := TRUE;
            //  CurrForm."Vehicle No.".EDITABLE := TRUE;
            //  CurrForm."Driver's Name".EDITABLE := TRUE;
            //  CurrForm."Driver's License No.".EDITABLE := TRUE;
            //  CurrForm."Driver's Mobile No.".EDITABLE := TRUE;
            //  CurrForm."Vehicle Capacity".EDITABLE := TRUE;
            //  CurrForm."Expected TPT Cost".EDITABLE := TRUE;

            //  CurrForm."Local LR No.".EDITABLE := FALSE;
            //  CurrForm."Local LR Date".EDITABLE := FALSE;
            //  CurrForm."Local Vehicle No.".EDITABLE := FALSE;
            //  CurrForm."Local Vehicle Capacity".EDITABLE := FALSE;
            //  CurrForm."Local Driver's Mobile No.".EDITABLE := FALSE;
            //  CurrForm."Local Driver's License No.".EDITABLE := FALSE;
            //  CurrForm."Local Driver's Name".EDITABLE := FALSE;
            //  CurrForm."Local Expected TPT Cost".EDITABLE := FALSE;
            //  }
            // RSPL-TC +
            "LR/RRNoEditable" := TRUE;
            "LR/RRDateEditable" := TRUE;
            VehicaleNoEditable := TRUE;
            DrivNameEditable := TRUE;
            DrivLicNoEditable := TRUE;
            DrivMobNoEditable := TRUE;
            VechCapEtdiable := TRUE;
            ExpTPTCostEditable := TRUE;

            LocalLRNoEditable := FALSE;
            LocalLRDateEditable := FALSE;
            LocalVehicaleNoEditable := FALSE;
            LocalVechCapEtdiable := FALSE;
            LocalDrivNameEditable := FALSE;
            LocalDrivLicNoEditable := FALSE;
            LocalDrivMobNoEditable := FALSE;
            LocalExpTPTCostEditable := FALSE;
            // RSPL-TC -
        END;

        IF (rec."Transport Type" = rec."Transport Type"::"Cust.Transport") THEN BEGIN
            //              {
            //              CurrForm."LR/RR No.".EDITABLE := FALSE;
            // CurrForm."LR/RR Date".EDITABLE := FALSE;
            // CurrForm."Vehicle No.".EDITABLE := TRUE;
            // CurrForm."Driver's Name".EDITABLE := FALSE;
            // CurrForm."Driver's License No.".EDITABLE := FALSE;
            // CurrForm."Driver's Mobile No.".EDITABLE := FALSE;
            // CurrForm."Vehicle Capacity".EDITABLE := FALSE;
            // CurrForm."Expected TPT Cost".EDITABLE := FALSE;

            // CurrForm."Local LR No.".EDITABLE := FALSE;
            // CurrForm."Local LR Date".EDITABLE := FALSE;
            // CurrForm."Local Vehicle No.".EDITABLE := FALSE;
            // CurrForm."Local Vehicle Capacity".EDITABLE := FALSE;
            // CurrForm."Local Driver's Mobile No.".EDITABLE := FALSE;
            // CurrForm."Local Driver's License No.".EDITABLE := FALSE;
            // CurrForm."Local Driver's Name".EDITABLE := FALSE;
            // CurrForm."Local Expected TPT Cost".EDITABLE := FALSE;
            //              }
            // RSPL-TC +
            "LR/RRNoEditable" := FALSE;
            "LR/RRDateEditable" := FALSE;
            VehicaleNoEditable := TRUE;
            DrivNameEditable := FALSE;
            DrivLicNoEditable := FALSE;
            DrivMobNoEditable := FALSE;
            VechCapEtdiable := FALSE;
            ExpTPTCostEditable := FALSE;

            LocalLRNoEditable := FALSE;
            LocalLRDateEditable := FALSE;
            LocalVehicaleNoEditable := FALSE;
            LocalVechCapEtdiable := FALSE;
            LocalDrivNameEditable := FALSE;
            LocalDrivLicNoEditable := FALSE;
            LocalDrivMobNoEditable := FALSE;
            LocalExpTPTCostEditable := FALSE;
            // RSPL-TC -
        END;
        //EBT STIVAN--(31072013)--To Make Below Editable and Uneditable as per Transport Type---------------END

        //    {
        //    // EBT MILAN--(03122013)---To UnEditable Exp Tpt Cost and TPT Cost if User is not having TRansportdetails Role--------START
        //    IF ("Location Code" = 'PLANT01') OR ("Location Code" = 'GDN0002') THEN
        //    BEGIN
        //     AccessControl.RESET;
        //     AccessControl.SETFILTER("User name",'%1',USERID);
        //     AccessControl.SETFILTER("Role ID",'%1','TRANSPORTDETAILS');
        //     IF AccessControl.FINDFIRST THEN
        //     BEGIN
        //       IF "Transport Type" = "Transport Type" :: "Local+Intercity" THEN
        //       BEGIN
        //         //   {
        //         //   CurrForm."Expected TPT Cost".EDITABLE := TRUE;
        //         //   CurrForm."Local Expected TPT Cost".EDITABLE := TRUE;
        //         //   }
        //           ExpTPTCostEditable := true;
        //           LocalExpTPTCostEditable := true;
        //       END;
        //       IF "Transport Type" = "Transport Type" :: Intercity THEN
        //       BEGIN
        //         //   {
        //         //   CurrForm."Expected TPT Cost".EDITABLE := TRUE;
        //         //   CurrForm."Local Expected TPT Cost".EDITABLE := FALSE;
        //         //   }
        //           ExpTPTCostEditable := true;
        //           LocalExpTPTCostEditable := false;
        //       END;
        //       IF ("Transport Type" = "Transport Type" :: "Cust.Transport") THEN
        //       BEGIN
        //         //   {
        //         //   CurrForm."Expected TPT Cost".EDITABLE := FALSE;
        //         //   CurrForm."Local Expected TPT Cost".EDITABLE := FALSE;
        //         //   }
        //           ExpTPTCostEditable := false;
        //           LocalExpTPTCostEditable := false;
        //       END;
        //       IF ("Transport Type" = "Transport Type" :: " ") THEN
        //       BEGIN
        //         //    {
        //         //   CurrForm."Expected TPT Cost".EDITABLE := TRUE;
        //         //   CurrForm."Local Expected TPT Cost".EDITABLE := FALSE;
        //         //   }
        //           ExpTPTCostEditable := true;
        //           LocalExpTPTCostEditable := false;
        //       END;
        //     END ELSE
        //     //       {
        //     //   CurrForm."Expected TPT Cost".EDITABLE := FALSE;
        //     //   CurrForm."Local Expected TPT Cost".EDITABLE := FALSE;
        //     //   }
        //       ExpTPTCostEditable := false;
        //       LocalExpTPTCostEditable := false;
        //    END;

        //    // EBT MILAN--(03122013)---To UnEditable Exp Tpt Cost and TPT Cost if User is not having TRansportdetails Role--------END
        //    }

        // EBT MILAN
        IF (rec."Location Code" = 'PLANT01') OR (rec."Location Code" = 'GDN0002') THEN BEGIN
            AccessControl.RESET;
            AccessControl.SETFILTER("User Name", '%1', USERID);
            AccessControl.SETFILTER("Role ID", '%1', 'TRANSPORTDETAILS');
            IF AccessControl.FINDFIRST THEN BEGIN
                IF rec."Transport Type" = rec."Transport Type"::"Local+Intercity" THEN BEGIN
                    //           {
                    //           CurrForm."Expected TPT Cost".EDITABLE := TRUE;
                    // CurrForm."Local Expected TPT Cost".EDITABLE := TRUE;
                    // CurrForm."Vehicle Capacity".EDITABLE := TRUE;
                    // CurrForm."Local Vehicle Capacity".EDITABLE := TRUE;
                    //           }
                    // RSPL-TC +
                    ExpTPTCostEditable := TRUE;
                    LocalExpTPTCostEditable := TRUE;
                    VechCapEtdiable := TRUE;
                    LocalVechCapEtdiable := TRUE;
                    // RSPL-TC -
                END;
                IF rec."Transport Type" = rec."Transport Type"::Intercity THEN BEGIN
                    //  {
                    //   CurrForm."Expected TPT Cost".EDITABLE := TRUE;
                    //   CurrForm."Local Expected TPT Cost".EDITABLE := FALSE;
                    //   CurrForm."Vehicle Capacity".EDITABLE := TRUE;
                    //   CurrForm."Local Vehicle Capacity".EDITABLE := FALSE;
                    //   }
                    // RSPL-TC +
                    ExpTPTCostEditable := TRUE;
                    LocalExpTPTCostEditable := FALSE;
                    VechCapEtdiable := TRUE;
                    LocalVechCapEtdiable := FALSE;
                    // RSPL-TC -
                END;
                IF (rec."Transport Type" = rec."Transport Type"::"Cust.Transport") THEN BEGIN
                    //   {
                    //   CurrForm."Expected TPT Cost".EDITABLE := FALSE;
                    //   CurrForm."Local Expected TPT Cost".EDITABLE := FALSE;
                    //   CurrForm."Vehicle Capacity".EDITABLE := FALSE;
                    //   CurrForm."Local Vehicle Capacity".EDITABLE := FALSE;
                    //   }
                    // RSPL-TC +
                    ExpTPTCostEditable := FALSE;
                    LocalExpTPTCostEditable := FALSE;
                    VechCapEtdiable := FALSE;
                    LocalVechCapEtdiable := FALSE;
                    // RSPL-TC -
                END;
                IF (rec."Transport Type" = rec."Transport Type"::" ") THEN BEGIN
                    //   {
                    //   CurrForm."Expected TPT Cost".EDITABLE := TRUE;
                    //   CurrForm."Local Expected TPT Cost".EDITABLE := FALSE;
                    //   CurrForm."Vehicle Capacity".EDITABLE := TRUE;
                    //   CurrForm."Local Vehicle Capacity".EDITABLE := FALSE;
                    //   }
                    // RSPL-TC +
                    ExpTPTCostEditable := TRUE;
                    LocalExpTPTCostEditable := FALSE;
                    VechCapEtdiable := TRUE;
                    LocalVechCapEtdiable := FALSE;
                    // RSPL-TC -
                END;
            END ELSE
                //   {
                //   CurrForm."Expected TPT Cost".EDITABLE := FALSE;
                //   CurrForm."Local Expected TPT Cost".EDITABLE := FALSE;
                //   CurrForm."Vehicle Capacity".EDITABLE := FALSE;
                //   CurrForm."Local Vehicle Capacity".EDITABLE := FALSE;
                //   }
                // RSPL-TC +
                ExpTPTCostEditable := FALSE;
            LocalExpTPTCostEditable := FALSE;
            VechCapEtdiable := FALSE;
            LocalVechCapEtdiable := FALSE;
            // RSPL-TC -
        END;

        // EBT MILAN TO NON-EDITABLE FRAIIGHT TYPE AFTER APPRUVE 310114-------------------------START
        IF UPPERCASE(USERID) <> 'SA' THEN BEGIN
            recSalesApproval.RESET;
            //recSalesApproval.SETRANGE(recSalesApproval."User ID",USERID);
            recSalesApproval.SETRANGE("Document Type", recSalesApproval."Document Type"::"Sales Order");
            recSalesApproval.SETRANGE(recSalesApproval."Approvar ID", USERID);
            IF recSalesApproval.FINDFIRST THEN BEGIN
                // {
                // CurrForm."Approval Description".EDITABLE := TRUE;
                // CurrForm."Freight Type".EDITABLE := TRUE;
                // CurrForm."Freight Charges".EDITABLE := TRUE;
                // }
                // RSPL-TC +
                AppDescEditable := TRUE;
                FreightTypeEditable := TRUE;
                FreightChargesEditable := TRUE;
                // RSPL-TC -
            END
            ELSE BEGIN
                IF rec."Campaign No." = 'APPROVED' THEN BEGIN
                    //  {
                    //  CurrForm."Freight Type".EDITABLE := FALSE;
                    //  CurrForm."Freight Charges".EDITABLE := FALSE;
                    //  }
                    // RSPL-TC +
                    FreightTypeEditable := FALSE;
                    FreightChargesEditable := FALSE;
                    // RSPL-TC -
                END ELSE
                // IF "Campaign No." = '' THEN
                BEGIN
                    //  {
                    //  CurrForm."Freight Type".EDITABLE := TRUE;
                    //  CurrForm."Freight Charges".EDITABLE := TRUE;
                    //  }
                    // RSPL-TC +
                    FreightTypeEditable := TRUE;
                    FreightChargesEditable := TRUE;
                    // RSPL-TC -
                END;
            END;
        END;
        // EBT MILAN TO NON-EDITABLE FRAIIGHT TYPE AFTER APPRUVE 310114---------------------------END

        //>>13Nov2018
        PayTermEditable := FALSE;
        IF rec.Status <> rec.Status::Released THEN BEGIN
            UserSetupT.RESET;
            UserSetupT.SETRANGE("User ID", USERID);
            UserSetupT.SETRANGE("Credit Limit Approval", TRUE);
            IF UserSetupT.FINDFIRST THEN BEGIN
                SalesApproval.RESET;
                SalesApproval.SETRANGE("Document Type", SalesApproval."Document Type"::"Sales Order");
                SalesApproval.SETRANGE("Credit Approvar ID", USERID);
                IF SalesApproval.FINDFIRST THEN
                    PayTermEditable := TRUE
                ELSE
                    PayTermEditable := FALSE;
            END;
        END ELSE
            PayTermEditable := FALSE;
        //<<13Nov2018

        //>>19Nov2018
        SalesPersonEditable := FALSE;
        IF rec."Sell-to Customer No." = 'C15574' THEN
            SalesPersonEditable := TRUE
        ELSE
            SalesPersonEditable := FALSE;
        //<<19Nov2018

        //RSPLSUM 05Jun2020>>
        IF (rec."Shortcut Dimension 1 Code" = 'DIV-14') OR (rec."Shortcut Dimension 1 Code" = 'DIV-10') THEN
            EditBunkerFields := TRUE
        ELSE
            EditBunkerFields := FALSE;
        //RSPLSUM 05Jun2020<<

        //RSPLSUM 11Aug2020>>
        IF (rec."Shortcut Dimension 1 Code" = 'DIV-04') OR (rec."Shortcut Dimension 1 Code" = 'DIV-08') THEN
            EditMintifiFinChnl := TRUE
        ELSE
            EditMintifiFinChnl := FALSE;
        //RSPLSUM 11Aug2020<<

        //  CurrPage.SalesLines.PAGE.LineFieldsEditables;//21Jun2018 tempory comment
    END;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        rec."Document Type" := rec."Document Type"::Order;

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        RecordMarked := TRUE;

    end;




    var
        SalesLine: Record "Sales Line";

        SalesPerCodeEditable: Boolean;
        SalesHead: Record 36;
        ReservEntr: Record 337;
        // recDetailRG23D: Record 16533;
        SalesHead1: Record 36;
        ShortCloseEdtiable: Boolean;
        User: Record 91;
        recSalesApprovalEntry1: Record 50009;
        CSOMapping2: Record 50006;
        CSO: Record 36;
        CSOMapping: Record 50006;
        CSOMapping1: Record 50006;
        recSalesApprovalEntry: Record 50009;
        recSalesApproval: Record 50008;
        AppDescEditable: Boolean;
        FreightTypeEditable: Boolean;
        FreightChargesEditable: Boolean;
        RecordMarked: Boolean;
        ApprovalStatus: Text[30];
        StateDesc: Text[30];
        Ship2StateDesc: Text[30];
        recState: Record State;//13762;
        recState1: Record State;//13762;
        "LR/RRNoEditable": Boolean;
        "LR/RRDateEditable": Boolean;
        VehicaleNoEditable: Boolean;
        DrivNameEditable: Boolean;
        DrivLicNoEditable: Boolean;
        DrivMobNoEditable: Boolean;
        VechCapEtdiable: Boolean;
        ExpTPTCostEditable: Boolean;
        LocalLRNoEditable: Boolean;
        LocalLRDateEditable: Boolean;
        LocalVehicaleNoEditable: Boolean;
        LocalVechCapEtdiable: Boolean;
        LocalDrivNameEditable: Boolean;
        LocalDrivLicNoEditable: Boolean;
        LocalDrivMobNoEditable: Boolean;
        LocalExpTPTCostEditable: Boolean;
        Ship2Add: Record 222;
        SaleLineNew: Record 37;
        SalesApprovalEntry: Record 50009;
        recSalLine: Record 37;
        vInventQty: Decimal;
        recIlentry: Record 32;
        recsalesLineTable: Record 37;
        ResEntryQty: Decimal;
        recResEntry: Record 337;
        recCust: Record 18;
        CustState: Code[10];
        recLoc: Record 14;
        LocState: Code[10];
        recShiptoAdd: Record 222;
        ShiptoCodeState: Code[10];
        FormAvCrd: Page "Available Credit Copy";//50069;
        recSL: Record 37;
        SalesApproval: Record 50008;
        Saaleslinerec: Record 37;
        SH: Record 36;
        AccessControl: Record 2000000053;
        vItemCat: Boolean;
        recSLine: Record 37;
        vRemAmount: Decimal;
        vBalanceAmt: Decimal;
        vCurrentOrdAmt: Decimal;
        vCreditLimit: Decimal;
        UserSetupT: Record 91;
        SalesHeadT: Record 36;
        recSHd: Record 36;
        CustLedEntryT: Record 21;
        CustomerT: Record 18;
        vRemAmt: Decimal;
        expr1: DateFormula;
        recSH: Record 36;
        ReleaseSalesDoc: Codeunit 414;
        SalesLineRec: Record 37;
        Text1002: Label 'ENU=This Order exceeds Credit Limit, Do you want to continue';
        Text1003: Label 'ENU=Customer is Over Due, Do you want to Approve';
        Text1004: Label 'ENU=Do you want to Approve';
        RecDimSetEntry: Record 480;
        lDimSetEntry: Record 480;
        SL: Record 37;
        "---": Integer;
        SalesLine1: Record 37;
        "-----18May2017": Integer;
        SL18: Record 37;
        "---08Sep2017": Integer;
        SalApprove: Record 50008;
        "----18Sep2017": Integer;
        DGST18: Record "Detailed GST Entry Buffer";//16412;
        "-----10Oct2017": Integer;
        SL10: Record 37;
        "------17Nov2017": Integer;
        SL17: Record 37;
        SAE17: Record 50009;
        TempVersionNo: Integer;
        "------24Jan2018": Integer;
        Expr24: DateFormula;
        DiffDate: Integer;
        "------14Mar2018": Integer;
        UserName14: Text;
        User14: Record 2000000120;
        AppPage: Page 50010;
        SAE11: Record 50009;
        TempSeqNo: Integer;
        SRSetup: Record 311;
        DimVal: Record 349;
        DimText: Text;
        EnableDim: Boolean;
        Cus21: Record 18;
        SP22: Record 13;
        SP28: Record 13;
        PayTerm05: Record 3;
        Cust05: Record 18;
        "------13Nov2018": Integer;
        PayTermEditable: Boolean;
        SalesPersonEditable: Boolean;
        "------Start11Nov2019": Integer;
        GloInvoiceDate: Date;
        GloInvoiceNo: Code[30];
        GloInvoicevalue: Decimal;
        GloCustomerName: Text[100];
        GloVehicleno: Code[20];
        GloTransporteraName: Text[100];
        GloDriverName: Text[100];
        GloDriverMobileNo: Code[20];
        GloReciepientEmail: Code[30];
        UserSetupRec: Record 91;
        SalespersonPurchaser: Record 13;
        GloLocationName: Text[100];
        LocRec: Record 14;
        ShippingAgent: Record 291;
        SaleLines: Record 37;
        GloInvoiceQuantity: Decimal;
        "------11Nov2019End": Integer;
        Text1005: Label 'ENU=Mail notification has been sent to salesperson.';
        SalesInvHead: Record 112;
        SalesInvLine: Record 113;
        GloExtDocNo: Text;
        SCArray: ARRAY[33] OF Char;
        i: Integer;
        j: Integer;
        Pos: Integer;
        RecCustNew: Record 18;
        AddInfo: Record 50053;
        RecSHAddInfo: Record 50053;
        CI22: Record 79;
        Cust22: Record 18;
        ShortCloseDaysFound: Boolean;
        RecDimValue: Record 349;
        ShortCloseDateCheck: Date;
        RecSalesLine: Record 37;
        EditBunkerFields: Boolean;
        EditMintifiFinChnl: Boolean;
        RecSLNew: Record 37;
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
        RecDetGSTEntBuff: Record "Detailed GST Entry Buffer";//16412;
        RecDimValueNew: Record 349;
        RecSL32: Record 37;
        SalesLineRec1: Record 37;
        SalesLineRec2: Record 37;
        GSTGrpCode: Code[10];
        //  SMTPMailSetup: Record 409;
        OutwardEntryPage: Page 50076;
        GateEntryHeader: Record "Gate Entry Header";//16552;
        RecLocation: Record 14;
        recCustomernew: Record 18;

        ReturnOrderNoVisible: Boolean;



    LOCAL PROCEDURE LRDetailsClr();
    BEGIN
        SL.RESET;
        SL.SETRANGE("Document Type", rec."Document Type");
        SL.SETRANGE("Document No.", rec."No.");
        SL.CALCSUMS(Quantity, "Quantity Shipped");
        IF SL.Quantity <> SL."Quantity Shipped" THEN BEGIN
            rec."Transport Type" := rec."Transport Type"::" ";
            rec."Local LR No." := '';
            rec."Local LR Date" := 0D;
            rec."Local Vehicle No." := '';
            rec."Local Driver's Name" := '';
            rec."Local Driver's License No." := '';
            rec."Local Driver's Mobile No." := '';
            rec."Local Vehicle Capacity" := '';
            rec."Local Expected TPT Cost" := 0;
            rec."LR/RR No." := '';
            rec."LR/RR Date" := 0D;
            rec."Vehicle No." := '';
            rec."Driver's Name" := '';
            rec."Driver's License No." := '';
            rec."Driver's Mobile No." := '';
            rec."Vehicle Capacity" := '';
            rec."Expected TPT Cost" := 0;
            // "Posting Date" :=  0D;                   //Robosoft/Rahul
            //"Time of Removal" := 0 ;
            // "Freight Type" :=  "Freight Type"::" "; //Robosoft/Rahul***Code commented to allow previous freight type value
            rec."Freight Charges" := '';
            rec."Export Under Rebate" := '';
            CLEAR(rec."Under Rebate");
            rec."Export Under LUT" := '';
            CLEAR(rec."Under LUT");
            rec."Ex-Factory" := '';
            CLEAR(rec."CT3 Order");
            rec."CT3 No." := '';
            rec."CT3 Date" := 0D;
            rec."ARE3 No." := '';
            rec."ARE3 Date" := 0D;
            CLEAR(rec."CT1 Order");
            rec."CT1 No." := '';
            rec."CT1 Date" := 0D;
            rec."ARE1 No." := '';
            rec."ARE1 Date" := 0D;
            rec.MODIFY;
        END;

    end;

    LOCAL PROCEDURE FOCValidation();
    VAR
        SL03: Record 37;
    BEGIN
        //>>03Apr2019
        SL03.RESET;
        SL03.SETRANGE("Document Type", rec."Document Type");
        SL03.SETRANGE("Document No.", rec."No.");
        IF SL03.FINDSET THEN
            REPEAT
                IF SL03."Amount To Customer" < 0 THEN
                    ERROR('Please Calculate Structure Value');
            UNTIL SL03.NEXT = 0;
        //<<03Apr2019
    END;

    LOCAL PROCEDURE DueDateGP();
    BEGIN
        //>>05Jul2018 RB-N
        IF (rec."No." <> '') THEN BEGIN
            rec."Date GP" := TODAY;
            IF (rec."Payment Terms Code" <> '') THEN BEGIN
                IF PayTerm05.GET(rec."Payment Terms Code") THEN;
                rec."Due Date" := CALCDATE(PayTerm05."Due Date Calculation", rec."Date GP");
            END;
            // {
            // IF "Sell-to Customer No." <> '' THEN BEGIN
            //         Cust05.RESET;
            //         IF Cust05.GET("Sell-to Customer No.") THEN;
            //         "Due Date" := CALCDATE(Cust05."Approved Payment Days", "Due Date");
            //     END;
            // }//03Jan2019 Code Commented for Extra Grace Period
            rec.MODIFY;
        END;
        //<<05Jul2018 RB-N
    END;

    PROCEDURE EmailNotification(DocType: Option "Sales Order","Blanket PO"; DocNo: Code[20]; SeqNo: Integer; SenderID: Code[50]; ReceiveID: Code[50]; FirstID: Code[50]);
    VAR
        EmailMsg: Codeunit "Email Message";//SMTPMail: Codeunit 400;
        RecipientType: Enum "Email Recipient Type";
        Instr: InStream;
        EmailObj: Codeunit Email;

        SAE18: Record 50009;
        SA18: Record 50008;
        SubjectText: Text;
        User18: Record 91;
        SenderName: Text;
        SenderEmail: Text;
        Text18: Text;
        Cust18: Record 18;
        OtAmt: Decimal;
        CrAmt: Decimal;
        ODAmt: Decimal;
        ReceiveEmail: Text;
        DimEnable: Boolean;
        Loc21: Record 14;
        SL21: Record 37;
        AppEmail: Text;
        SL22: Record 37;
        UnitOfMeasureCode: Code[20];
        SH: Record 36;
        RecSalesperPurchaser: Record 13;
        ServerTempFile: Text;
        FileMgmt: Codeunit 419;
        RecSpForRegionHead: Record 13;
        RecSpForHOD: Record 13;
        RecSpForLevelOne: Record 13;
        ReportNo: Integer;
        Report50014: Report 70014;
        Report50013: Report 70013;
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        //Instr: InStream;
        TempApprID: Code[50];
        TempCreditApprID: Code[100];
    BEGIN
        // SMTPMailSetup.GET;//RSPLSUM02Apr21

        SubjectText := '';
        SenderName := '';
        SenderEmail := '';
        ReceiveEmail := '';
        Text18 := '';
        DimText := '';
        CLEAR(EmailMsg);

        //>>Division Value
        DimVal.RESET;
        DimVal.SETRANGE("Dimension Code", 'DIVISION');
        DimVal.SETRANGE(Code, rec."Shortcut Dimension 1 Code");
        IF DimVal.FINDFIRST THEN
            DimText := DimVal.Name;
        //>>Division Value

        //>>SenderID
        User18.RESET;
        IF User18.GET(SenderID) THEN BEGIN
            User18.TESTFIELD("E-Mail");
            SenderEmail := User18."E-Mail";
            IF User18.Name <> '' THEN
                SenderName := User18.Name
            ELSE
                SenderName := SenderID;
        END;
        //<<SenderID

        IF SeqNo = 1 THEN BEGIN
            //RSPLSUM 01Feb21--SubjectText := 'Microsoft Dynamics NAV: Approval Mail - ' ;
            SubjectText := 'CSO for Approval - ';//RSPLSUM 01Feb21
            Text18 := 'Requires Approval.';
            ReceiveEmail := SenderEmail;
            //RSPLSUM 01Feb21--DimText := DimText + ' - ' +"No."+ ' - ' +"Sell-to Customer Name"//RSPLSUM 22Jan21
            DimText := rec."No." + ' - ' + rec."Sell-to Customer Name";//RSPLSUM 01Feb21
        END;

        IF SeqNo = 2 THEN BEGIN
            //RSPLSUM 01Feb21--SubjectText := 'Microsoft Dynamics NAV: Approved Mail - ';
            SubjectText := 'Approved CSO - ';//RSPLSUM 01Feb21
            Text18 := 'has been Approved.';
            DimText := rec."No." + ' - ' + rec."Sell-to Customer Name";//RSPLSUM 01Feb21

            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", rec."No.");
            //IF FirstID <> '' THEN
            //SAE18.SETRANGE("Approvar ID",SenderID);
            SAE18.SETRANGE(Approved, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                User18.RESET;
                User18.SETRANGE("User ID", SAE18."User ID");
                IF User18.FINDFIRST THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    ReceiveEmail := User18."E-Mail";
                END;
            END;

        END;

        IF SeqNo = 3 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Credit Limit Approval Mail - ';
            Text18 := 'Requires Credit Limit Approval.';
        END;

        IF SeqNo = 4 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Over Due Approval Mail - ';
            Text18 := 'Over Due Approval.';
        END;


        IF SeqNo = 5 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Rejection Mail';
            Text18 := 'has been Rejected.';

            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", rec."No.");
            SAE18.SETRANGE(Rejected, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                User18.RESET;
                User18.SETRANGE("User ID", SAE18."User ID");
                IF User18.FINDFIRST THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    ReceiveEmail := User18."E-Mail";
                END;
            END;
        END;

        IF (SeqNo = 3) OR (SeqNo = 4) THEN BEGIN

            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", rec."No.");
            SAE18.SETRANGE(Approved, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                SA18.RESET;
                SA18.SETCURRENTKEY("Document Type");
                SA18.SETRANGE("Document Type", SAE18."Document Type");
                SA18.SETRANGE("User ID", SAE18."User ID");
                SA18.SETRANGE("Approvar ID", SAE18."Approvar ID");
                IF SA18.FINDFIRST THEN BEGIN
                    User18.RESET;
                    User18.SETRANGE("User ID", SA18."Credit Approvar ID");
                    IF User18.FINDFIRST THEN BEGIN
                        User18.TESTFIELD("E-Mail");
                        ReceiveEmail := User18."E-Mail";
                    END;
                END;
            END;

        END;

        IF SeqNo = 6 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Credit Limit Rejection Mail';
            Text18 := 'Credit Limit Rejected.';

            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", rec."No.");
            SAE18.SETRANGE(Approved, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                User18.RESET;
                User18.SETRANGE("User ID", SAE18."User ID");
                IF User18.FINDFIRST THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    ReceiveEmail := User18."E-Mail";
                END;
                AppEmail := '';
                User18.RESET;
                User18.SETRANGE("User ID", SAE18."Approvar ID");
                IF User18.FINDFIRST THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    AppEmail := User18."E-Mail";
                END;

            END;
        END;

        IF SeqNo = 7 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Over Due Rejection Mail';
            Text18 := 'Over Due Rejected.';

            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", rec."No.");
            SAE18.SETRANGE(Approved, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                User18.RESET;
                User18.SETRANGE("User ID", SAE18."User ID");
                IF User18.FINDFIRST THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    ReceiveEmail := User18."E-Mail";
                END;
                AppEmail := '';
                User18.RESET;
                User18.SETRANGE("User ID", SAE18."Approvar ID");
                IF User18.FINDFIRST THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    AppEmail := User18."E-Mail";
                END;
            END;
        END;

        //>>CreditLimit
        CLEAR(CrAmt);
        CLEAR(OtAmt);
        CLEAR(ODAmt);
        Cust18.RESET;
        IF Cust18.GET(rec."Sell-to Customer No.") THEN BEGIN
            Cust18.CALCFIELDS("Balance (LCY)");
            CrAmt := Cust18."Credit Limit (LCY)";
            OtAmt := Cust18."Balance (LCY)";
            ODAmt := Cust18.CalcOverdueBalance;
        END;

        //<<CreditLimit

        //>>Email Body
        //RSPLSUM02Apr21--SMTPMail.CreateMessage(SenderName,SenderEmail,ReceiveEmail,SubjectText+DimText,'',TRUE);
        //SMTPMail.CreateMessage(SenderName, SMTPMailSetup."User ID", ReceiveEmail, SubjectText + DimText, '', TRUE);//RSPLSUM02Apr21

        EmailMsg.Create(ReceiveEmail, SubjectText + DimText, '', true);
        CLEAR(TempApprID);//RSPLSUM24May21
        CLEAR(TempCreditApprID); //DJ 29420
        IF SeqNo = 1 THEN BEGIN
            SA18.RESET;
            SA18.SETCURRENTKEY("Document Type");
            SA18.SETRANGE("Document Type", DocType);
            SA18.SETRANGE("User ID", SenderID);
            IF SA18.FINDSET THEN BEGIN
                REPEAT
                    DimEnable := FALSE;
                    IF (SA18."Division Code" = '') AND (SA18."Division Code 2" = '') AND (SA18."Division Code 3" = '')
                    AND (SA18."Division Code 4" = '') AND (SA18."Division Code 5" = '') THEN
                        DimEnable := TRUE;

                    IF (SA18."Division Code" = rec."Shortcut Dimension 1 Code")
                    OR (SA18."Division Code 2" = rec."Shortcut Dimension 1 Code")
                    OR (SA18."Division Code 3" = rec."Shortcut Dimension 1 Code")
                    OR (SA18."Division Code 4" = rec."Shortcut Dimension 1 Code")
                    OR (SA18."Division Code 5" = rec."Shortcut Dimension 1 Code") THEN
                        DimEnable := TRUE;

                    //>>21May2018
                    IF NOT DimEnable THEN BEGIN
                        Cus21.RESET;
                        IF Cus21.GET(rec."Sell-to Customer No.") THEN
                            IF (SA18."Division Code" = Cus21."Global Dimension 1 Code") OR (SA18."Division Code 2" = Cus21."Global Dimension 1 Code")
                            OR (SA18."Division Code 3" = Cus21."Global Dimension 1 Code") OR (SA18."Division Code 3" = Cus21."Global Dimension 1 Code")
                            OR (SA18."Division Code 5" = Cus21."Global Dimension 1 Code") THEN
                                DimEnable := TRUE;
                    END;
                    //<<21May2018
                    IF DimEnable THEN BEGIN
                        IF TempApprID <> SA18."Approvar ID" THEN BEGIN//RSPLSUM24May21
                            TempApprID := SA18."Approvar ID";//RSPLSUM24May21
                            User18.RESET;
                            User18.SETRANGE("User ID", SA18."Approvar ID");
                            IF User18.FINDFIRST THEN BEGIN
                                User18.TESTFIELD("E-Mail");
                                // SMTPMail.AddRecipients(User18."E-Mail");
                                EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");

                            END;
                        END;//RSPLSUM24May21
                    END;
                UNTIL SA18.NEXT = 0;

                //RSPLSUM 22Jan21>>
                CLEAR(ServerTempFile);

                // ServerTempFile := FileMgmt.ServerTempFileName('pdf');

                SH.RESET;
                SH.SETRANGE("Document Type", rec."Document Type");
                SH.SETRANGE("No.", rec."No.");
                IF SH.FINDFIRST THEN BEGIN
                    //RSPLSUM19May21>>
                    CLEAR(ReportNo);
                    IF (rec."Shortcut Dimension 1 Code" = 'DIV-04') OR (rec."Shortcut Dimension 1 Code" = 'DIV-08') THEN begin
                        ReportNo := 50014
                    end

                    ELSE begin
                        ReportNo := 50013;
                    end;

                    //RSPLSUM19May21<<
                    Clear(TempBlob);
                    TempBlob.CreateOutStream(OutStr);
                    //RSPLSUM19May21--IF REPORT.SAVEASPDF(50013, ServerTempFile, SH) THEN BEGIN
                    //IF REPORT.SAVEASPDF(ReportNo, ServerTempFile, SH) THEN BEGIN//RSPLSUM19May21
                    IF Report.SaveAs(ReportNo, '', ReportFormat::Pdf, OutStr) then begin

                        //Add Salesperson Email>>
                        RecSalesperPurchaser.RESET;
                        IF RecSalesperPurchaser.GET(rec."Salesperson Code") THEN BEGIN
                            IF RecSalesperPurchaser."E-Mail" <> '' THEN
                                EmailMsg.AddRecipient(RecipientType::"To", RecSalesperPurchaser."E-Mail");
                        END;
                        //Add Salesperson Email<<

                        //Add Email of Region Head Code, HOD and L1>>
                        RecSalesperPurchaser.RESET;
                        IF RecSalesperPurchaser.GET(rec."Salesperson Code") THEN BEGIN

                            IF RecSalesperPurchaser."Region Head Code" <> '' THEN BEGIN
                                RecSpForRegionHead.RESET;
                                IF RecSpForRegionHead.GET(RecSalesperPurchaser."Region Head Code") THEN BEGIN
                                    IF RecSpForRegionHead."E-Mail" <> '' THEN
                                        // EmailMsg.AddRecipients(RecSpForRegionHead."E-Mail");
                                        EmailMsg.AddRecipient(RecipientType::"To", RecSpForRegionHead."E-Mail");

                                END;
                            END;

                            IF RecSalesperPurchaser.HOD <> '' THEN BEGIN
                                RecSpForHOD.RESET;
                                IF RecSpForHOD.GET(RecSalesperPurchaser.HOD) THEN BEGIN
                                    IF RecSpForHOD."E-Mail" <> '' THEN
                                        EmailMsg.AddRecipient(RecipientType::"To", RecSpForHOD."E-Mail");
                                END;
                            END;

                            IF RecSalesperPurchaser.L1 <> '' THEN BEGIN
                                RecSpForLevelOne.RESET;
                                IF RecSpForLevelOne.GET(RecSalesperPurchaser.L1) THEN BEGIN
                                    IF RecSpForLevelOne."E-Mail" <> '' THEN
                                        EmailMsg.AddRecipient(RecipientType::"To", RecSpForLevelOne."E-Mail");
                                END;
                            END;

                        END;
                        //Add Email of Region Head Code, HOD and L1<<

                    END ELSE
                        ERROR('Error while saving report as PDF');
                END;
                //RSPLSUM 22Jan21<<

            END;//RSPLSUM 22Jan21

            //DJ 29420
            SA18.RESET;
            SA18.SETCURRENTKEY("Credit Approvar ID");
            SA18.SETRANGE("Document Type", DocType);
            SA18.SETRANGE("User ID", SenderID);
            SA18.SETFILTER("Credit Approvar ID", '<>%1', '');
            IF SA18.FINDSET THEN BEGIN
                REPEAT
                    DimEnable := FALSE;
                    IF (SA18."Division Code" = '') AND (SA18."Division Code 2" = '') AND (SA18."Division Code 3" = '')
                    AND (SA18."Division Code 4" = '') AND (SA18."Division Code 5" = '') THEN
                        DimEnable := TRUE;

                    IF (SA18."Division Code" = rec."Shortcut Dimension 1 Code")
                    OR (SA18."Division Code 2" = rec."Shortcut Dimension 1 Code")
                    OR (SA18."Division Code 3" = rec."Shortcut Dimension 1 Code")
                    OR (SA18."Division Code 4" = rec."Shortcut Dimension 1 Code")
                    OR (SA18."Division Code 5" = rec."Shortcut Dimension 1 Code") THEN
                        DimEnable := TRUE;


                    IF NOT DimEnable THEN BEGIN
                        Cus21.RESET;
                        IF Cus21.GET(rec."Sell-to Customer No.") THEN
                            IF (SA18."Division Code" = Cus21."Global Dimension 1 Code") OR (SA18."Division Code 2" = Cus21."Global Dimension 1 Code")
                            OR (SA18."Division Code 3" = Cus21."Global Dimension 1 Code") OR (SA18."Division Code 3" = Cus21."Global Dimension 1 Code")
                            OR (SA18."Division Code 5" = Cus21."Global Dimension 1 Code") THEN
                                DimEnable := TRUE;
                    END;

                    IF DimEnable THEN BEGIN
                        IF TempCreditApprID <> SA18."Credit Approvar ID" THEN BEGIN
                            TempCreditApprID := SA18."Credit Approvar ID";
                            User18.RESET;
                            User18.SETRANGE("User ID", SA18."Credit Approvar ID");
                            IF User18.FINDFIRST THEN BEGIN
                                User18.TESTFIELD("E-Mail");
                                //  SMTPMail.AddRecipients(User18."E-Mail");
                                EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                            END;
                        END;
                    END;
                UNTIL SA18.NEXT = 0;
            END;
            //DJ 29420
        END;

        IF SeqNo = 2 THEN BEGIN
            //>>SalesPerson Email
            SP22.RESET;
            IF SP22.GET(rec."Salesperson Code") THEN BEGIN
                IF SP22."E-Mail" <> '' THEN
                    //  SMTPMail.AddCC(SP22."E-Mail");
                    EmailMsg.AddRecipient(RecipientType::"Cc", SP22."E-Mail");
                //>>RegionHead
                IF SP22."Region Head Code" <> '' THEN BEGIN
                    SP28.RESET;
                    IF SP28.GET(SP22."Region Head Code") THEN
                        IF SP28."E-Mail" <> '' THEN
                            // SMTPMail.AddCC(SP28."E-Mail");
                            EmailMsg.AddRecipient(RecipientType::"Cc", SP28."E-Mail");
                END;
                //<<RegionHead
            END;
            //<<SalesPerson Email

            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", rec."No.");
            //SAE18.SETRANGE("Approvar ID",SenderID);
            SAE18.SETRANGE(Approved, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                IF FirstID = '' THEN BEGIN
                    User18.RESET;
                    User18.SETRANGE("User ID", SAE18."Approvar ID");
                    IF User18.FINDFIRST THEN BEGIN
                        User18.TESTFIELD("E-Mail");
                        // SMTPMail.AddRecipients(User18."E-Mail");
                        EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                    END;
                END;
                //   {
                //   SA18.RESET;
                //         SA18.SETRANGE("Document Type", DocType);
                //         SA18.SETRANGE("User ID", SAE18."User ID");
                //         SA18.SETFILTER("Approvar ID", '<>%1', SenderID);
                //         IF SA18.FINDSET THEN
                //             REPEAT
                //                 User18.RESET;
                //                 User18.SETRANGE("User ID", SA18."Approvar ID");
                //                 IF User18.FINDFIRST THEN BEGIN
                //                     User18.TESTFIELD("E-Mail");
                //                     SMTPMail.AddRecipients(User18."E-Mail");
                //                 END;
                //             UNTIL SA18.NEXT = 0;
                //   }//Commented on 16May2018

                //   {
                //   IF FirstID = '' THEN //Not Direct Approval
                //   BEGIN
                //     SA18.RESET;
                //     SA18.SETCURRENTKEY("Document Type");
                //     SA18.SETRANGE("Document Type",DocType);
                //     SA18.SETRANGE("User ID",SAE18."User ID");
                //     SA18.SETRANGE("Approvar ID",SAE18."Approvar ID");
                //     SA18.SETFILTER("Credit Approvar ID",'<>%1','');
                //     IF SA18.FINDSET THEN
                //     REPEAT
                //       DimEnable := FALSE;
                //     IF (SA18."Division Code" = '') AND (SA18."Division Code 2" = '') AND (SA18."Division Code 3" = '' )
                //     AND (SA18."Division Code 4" = '' ) AND (SA18."Division Code 5" = '' ) THEN
                //       DimEnable := TRUE;

                //     IF (SA18."Division Code" = "Shortcut Dimension 1 Code" )
                //     OR (SA18."Division Code 2" = "Shortcut Dimension 1 Code" )
                //     OR (SA18."Division Code 3" = "Shortcut Dimension 1 Code" )
                //     OR (SA18."Division Code 4" = "Shortcut Dimension 1 Code" )
                //     OR (SA18."Division Code 5" = "Shortcut Dimension 1 Code" ) THEN
                //       DimEnable := TRUE;

                //   //>>21May2018
                //   IF NOT DimEnable THEN
                //   BEGIN
                //     Cus21.RESET;
                //     IF Cus21.GET("Sell-to Customer No.") THEN
                //     IF (SA18."Division Code" = Cus21."Global Dimension 1 Code") OR (SA18."Division Code 2" = Cus21."Global Dimension 1 Code")
                //     OR (SA18."Division Code 3" = Cus21."Global Dimension 1 Code") OR (SA18."Division Code 3" = Cus21."Global Dimension 1 Code")
                //     OR (SA18."Division Code 5" = Cus21."Global Dimension 1 Code") THEN
                //       DimEnable := TRUE;
                //   END;
                //   //<<21May2018

                //     IF DimEnable THEN BEGIN
                //       User18.RESET;
                //       User18.SETRANGE("User ID",SA18."Credit Approvar ID");
                //       IF User18.FINDFIRST THEN
                //       BEGIN
                //         User18.TESTFIELD("E-Mail");
                //         IF User18."User ID" <> SenderID THEN
                //         SMTPMail.AddRecipients(User18."E-Mail");
                //       END;
                //     END;
                //     UNTIL SA18.NEXT = 0;
                //   END;
                //   }//Commented on 28Jun2018
            END;
        END;

        IF (SeqNo = 3) OR (SeqNo = 4) THEN BEGIN

            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", rec."No.");
            SAE18.SETRANGE(Approved, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                //   {
                //   User18.RESET;
                //   User18.SETRANGE("User ID",SAE18."User ID");
                //   IF User18.FINDFIRST THEN
                //   BEGIN
                //     User18.TESTFIELD("E-Mail");
                //     SMTPMail.AddRecipients(User18."E-Mail");
                //   END;

                //   User18.RESET;
                //   User18.SETRANGE("User ID",SAE18."Approvar ID");
                //   IF User18.FINDFIRST THEN
                //   BEGIN
                //     User18.TESTFIELD("E-Mail");
                //     SMTPMail.AddRecipients(User18."E-Mail");
                //   END;
                //   }

                SA18.RESET;
                SA18.SETCURRENTKEY("Document Type");
                SA18.SETRANGE("Document Type", DocType);
                SA18.SETRANGE("User ID", SAE18."User ID");
                SA18.SETRANGE("Approvar ID", SAE18."Approvar ID");
                SA18.SETFILTER("Credit Approvar ID", '<>%1', ReceiveEmail);
                IF SA18.FINDSET THEN
                    REPEAT
                        DimEnable := FALSE;
                        IF (SA18."Division Code" = '') AND (SA18."Division Code 2" = '') AND (SA18."Division Code 3" = '')
                        AND (SA18."Division Code 4" = '') AND (SA18."Division Code 5" = '') THEN
                            DimEnable := TRUE;

                        IF (SA18."Division Code" = rec."Shortcut Dimension 1 Code")
                        OR (SA18."Division Code 2" = rec."Shortcut Dimension 1 Code")
                        OR (SA18."Division Code 3" = rec."Shortcut Dimension 1 Code")
                        OR (SA18."Division Code 4" = rec."Shortcut Dimension 1 Code")
                        OR (SA18."Division Code 5" = rec."Shortcut Dimension 1 Code") THEN
                            DimEnable := TRUE;

                        //>>21May2018
                        IF NOT DimEnable THEN BEGIN
                            Cus21.RESET;
                            IF Cus21.GET(rec."Sell-to Customer No.") THEN
                                IF (SA18."Division Code" = Cus21."Global Dimension 1 Code") OR (SA18."Division Code 2" = Cus21."Global Dimension 1 Code")
                                OR (SA18."Division Code 3" = Cus21."Global Dimension 1 Code") OR (SA18."Division Code 3" = Cus21."Global Dimension 1 Code")
                                OR (SA18."Division Code 5" = Cus21."Global Dimension 1 Code") THEN
                                    DimEnable := TRUE;
                        END;
                        //<<21May2018

                        IF DimEnable THEN BEGIN
                            User18.RESET;
                            User18.SETRANGE("User ID", SA18."Credit Approvar ID");
                            IF User18.FINDFIRST THEN BEGIN
                                User18.TESTFIELD("E-Mail");
                                // SMTPMail.AddRecipients(User18."E-Mail");
                                EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                            END;
                        END;
                    UNTIL SA18.NEXT = 0;
            END;
        END;

        IF SeqNo = 5 THEN BEGIN
            //>>SalesPerson Email
            SP22.RESET;
            IF SP22.GET(rec."Salesperson Code") THEN BEGIN
                IF SP22."E-Mail" <> '' THEN
                    //  SMTPMail.AddCC(SP22."E-Mail");
                    EmailMsg.AddRecipient(RecipientType::"Cc", SP22."E-Mail");
                //>>RegionHead
                IF SP22."Region Head Code" <> '' THEN BEGIN
                    SP28.RESET;
                    IF SP28.GET(SP22."Region Head Code") THEN
                        IF SP28."E-Mail" <> '' THEN
                            // SMTPMail.AddCC(SP28."E-Mail");
                            EmailMsg.AddRecipient(RecipientType::"Cc", SP28."E-Mail");
                END;
                //<<RegionHead
            END;
            //<<SalesPerson Email
        END;

        //>>
        IF (SeqNo = 6) OR (SeqNo = 7) THEN BEGIN
            //>>SalesPerson Email
            SP22.RESET;
            IF SP22.GET(rec."Salesperson Code") THEN
                IF SP22."E-Mail" <> '' THEN
                    // SMTPMail.AddCC(SP22."E-Mail");
                    EmailMsg.AddRecipient(RecipientType::"Cc", SP22."E-Mail");

            //<<SalesPerson Email
            IF AppEmail <> '' THEN
                // SMTPMail.AddRecipients(AppEmail);
                EmailMsg.AddRecipient(RecipientType::"To", AppEmail);
        END;
        //<<

        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<B> Microsoft Dynamics NAV Document Approval System </B>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br> <B> Sales Order No.  - </B>' + '<B>' + rec."No." + '</B>' + ' ' + Text18);
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Table  Border="1">');//Table Start
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Company Name </th>');
        EmailMsg.AppendToBody('<td>' + COMPANYNAME + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Sales Order No.</th>');
        EmailMsg.AppendToBody('<td>' + rec."No." + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Customer</th>');
        EmailMsg.AppendToBody('<td>' + rec."Sell-to Customer No." + '  ' + rec."Sell-to Customer Name" + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Supply Location</th>');
        Loc21.RESET;
        IF Loc21.GET(rec."Location Code") THEN;
        EmailMsg.AppendToBody('<td>' + Loc21.Name + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Quantity</th>');
        SL21.RESET;
        SL21.SETRANGE("Document Type", rec."Document Type");
        SL21.SETRANGE("Document No.", rec."No.");
        SL21.CALCSUMS("Quantity (Base)", Quantity);//RSPLSUM 06Jun2020--SL21.CALCSUMS("Quantity (Base)");
                                                   //RSPLSUM 06Jun2020>>--To show Quantity and UOM for COAL division (DIV-09)--
        IF rec."Shortcut Dimension 1 Code" = 'DIV-09' THEN BEGIN
            CLEAR(UnitOfMeasureCode);
            SL22.RESET;
            SL22.SETRANGE("Document Type", rec."Document Type");
            SL22.SETRANGE("Document No.", rec."No.");
            SL22.SETFILTER(Quantity, '<>%1', 0);
            IF SL22.FINDFIRST THEN
                UnitOfMeasureCode := SL22."Unit of Measure Code";

            EmailMsg.AppendToBody('<td>' + FORMAT(SL21.Quantity, 0, '<Integer Thousand><Decimals,3>') + ' ' + UnitOfMeasureCode + '</td>');
        END ELSE//RSPLSUM 06Jun2020<<
            EmailMsg.AppendToBody('<td>' + FORMAT(SL21."Quantity (Base)", 0, '<Integer Thousand><Decimals,3>') + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Gross Amount </th>');
        rec.CALCFIELDS("Amount to Customer");
        EmailMsg.AppendToBody('<td>' + FORMAT(rec."Amount to Customer", 0, '<Integer Thousand><Decimals,3>') + '</td>');
        EmailMsg.AppendToBody('</tr>');
        //   {
        //   EmailMsg.AppendToBody('<tr>');
        //     EmailMsg.AppendToBody('<th>Due Date </th>');
        //     EmailMsg.AppendToBody('<td>' + FORMAT("Due Date") + '</td>');
        //     EmailMsg.AppendToBody('</tr>');
        //   }
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Credit Limit </th>');
        EmailMsg.AppendToBody('<td>' + FORMAT(CrAmt, 0, '<Integer Thousand><Decimals,3>') + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Total Outstanding Amount </th>');
        EmailMsg.AppendToBody('<td>' + FORMAT(OtAmt, 0, '<Integer Thousand><Decimals,3>') + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Overdue Amount </th>');
        EmailMsg.AppendToBody('<td>' + FORMAT(ODAmt, 0, '<Integer Thousand><Decimals,3>') + '</td>');
        EmailMsg.AppendToBody('</tr>');

        //>>Rejection Remarks
        IF (SeqNo = 5) THEN BEGIN
            EmailMsg.AppendToBody('<tr>');
            EmailMsg.AppendToBody('<th>Rejection Remarks</th>');
            EmailMsg.AppendToBody('<td>' + rec."Approval Description" + '</td>');
            EmailMsg.AppendToBody('</tr>');
        END;
        //<<Rejection Remarks

        //>>Credit OverDue Remarks
        IF (SeqNo = 6) OR (SeqNo = 7) THEN BEGIN
            EmailMsg.AppendToBody('<tr>');
            EmailMsg.AppendToBody('<th>Rejection Remarks</th>');
            EmailMsg.AppendToBody('<td>' + rec."Credit / OverDue Remarks" + '</td>');
            EmailMsg.AppendToBody('</tr>');
        END;
        //<<Credit OverDue Remarks

        EmailMsg.AppendToBody('</table>');//Table End
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');

        //RSPLSUM 22Jan21>>
        IF SeqNo = 1 THEN BEGIN
            //  SMTPMail.AddAttachment(ServerTempFile, 'Sales Order.pdf');
            TempBlob.CreateInStream(InStr);
            EmailMsg.AddAttachment('Sales Order', '.pdf', InStr);



        END;
        //RSPLSUM 22Jan21<<

        //SMTPMail.Send;
        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);

        //<<Email Body
    END;

    PROCEDURE SalespersonEmailNotification();
    VAR

        EmailMsg: Codeunit "Email Message";//SMTPMail: Codeunit 400;
        EmailObj: Codeunit Email;
        RecipientType: Enum "Email Recipient Type";
        SAE18: Record 50009;
        SA18: Record 50008;
        SubjectText: Text;
        User18: Record 91;
        SenderName: Text;
        SenderEmail: Text;
        Text18: Text;
        Cust18: Record 18;
        OtAmt: Decimal;
        CrAmt: Decimal;
        ODAmt: Decimal;
        ReceiveEmail: Text;
        DimEnable: Boolean;
        Loc21: Record 14;
        SL21: Record 37;
        AppEmail: Text;
    BEGIN
        // SMTPMailSetup.GET;//RSPLSUM02Apr21

        SubjectText := '';
        SenderName := '';
        SenderEmail := '';
        ReceiveEmail := '';
        Text18 := '';
        CLEAR(EmailMsg);
        UserSetupRec.GET(USERID);
        UserSetupRec.TESTFIELD("E-Mail");

        //>>Email Body
        //RSPLSUM02Apr21--SMTPMail.CreateMessage('',UserSetupRec."E-Mail",GloReciepientEmail,'','',TRUE);
        //  SMTPMail.CreateMessage('', SMTPMailSetup."User ID", GloReciepientEmail, '', '', TRUE);//RSPLSUM02Apr21
        EmailMsg.Create(GloReciepientEmail, '', '', true);


        //SMTPMail.AddRecipients(GloReciepientEmail);


        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<B> New invoice dispatched from </B>' + GloLocationName);
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');

        //Table Start
        EmailMsg.AppendToBody('<Table  Border="1">');
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Invoice No </th>');
        EmailMsg.AppendToBody('<td>' + rec."Last Posting No." + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>InvoiceDate</th>');
        EmailMsg.AppendToBody('<td>' + FORMAT(GloInvoiceDate) + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Customer Name</th>');
        EmailMsg.AppendToBody('<td>' + GloCustomerName + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        SalesInvLine.SETRANGE("Document No.", rec."Last Posting No.");
        SalesInvLine.CALCSUMS("Quantity (Base)");
        EmailMsg.AppendToBody('<th>Quantity</th>');
        EmailMsg.AppendToBody('<td>' + FORMAT(SalesInvLine."Quantity (Base)", 0, '<Integer Thousand><Decimals,3>') + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Invoice value </th>');
        EmailMsg.AppendToBody('<td>' + FORMAT(GloInvoicevalue, 0, '<Integer Thousand><Decimals,3>') + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<th>Purchase Order No </th>');
        EmailMsg.AppendToBody('<td>' + GloExtDocNo + '</td>');
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Vehicle No </th>');
        EmailMsg.AppendToBody('<td>' + GloVehicleno + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Transport Name </th>');
        EmailMsg.AppendToBody('<td>' + GloTransporteraName + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Driver Name</th>');
        EmailMsg.AppendToBody('<td>' + GloDriverName + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Driver Mobile No</th>');
        EmailMsg.AppendToBody('<td>' + GloDriverMobileNo + '</td>');
        EmailMsg.AppendToBody('</tr>');
        EmailMsg.AppendToBody('</table>');
        //Table End

        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        //  SMTPMail.Send;
        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        MESSAGE(Text1005);
        //<<Email Body
    END;

    LOCAL PROCEDURE SetSalespersonEmailValues(InvoiceDate: Date; InvoiceNo: Code[20]; Invoicevalue: Decimal; CustomerName: Text[100]; Vehicleno: Code[10]; TransporterName: Text[100]; DriverName: Text[100]; DriverMobileNo: Text[100]; ReciepientName: Text[100]; LocationCode: Code[100]; InvoiceQuantity: Decimal);
    VAR
        CustRec: Record 18;
    BEGIN
        rec.TESTFIELD("Bill-to Customer No.");
        CustRec.GET(rec."Bill-to Customer No.");
        rec.TESTFIELD("Salesperson Code");
        SalespersonPurchaser.GET(rec."Salesperson Code");
        SalespersonPurchaser.TESTFIELD("E-Mail");
        LocRec.GET(LocationCode);
        ShippingAgent.GET(TransporterName);
        GloInvoiceDate := InvoiceDate;
        GloInvoiceNo := InvoiceNo;
        GloInvoicevalue := Invoicevalue;
        GloCustomerName := CustRec.Name;
        GloVehicleno := Vehicleno;
        GloTransporteraName := ShippingAgent.Name;
        GloDriverName := DriverName;
        GloDriverMobileNo := DriverMobileNo;
        GloReciepientEmail := SalespersonPurchaser."E-Mail";
        GloLocationName := LocRec.Name;
        GloInvoiceQuantity := InvoiceQuantity;
        GloExtDocNo := rec."External Document No.";
    END;

    LOCAL PROCEDURE DueDateGPIPOL();
    VAR
        PayTerm02: Record 3;
    BEGIN
        //RSPLSUM 25May2020>>
        IF (rec."No." <> '') THEN
            IF rec."Shipment Date" <> 0D THEN BEGIN
                rec."Date GP" := TODAY;
                IF (rec."Payment Terms Code" <> '') THEN BEGIN
                    IF PayTerm02.GET(rec."Payment Terms Code") THEN;
                    rec."Due Date" := CALCDATE(PayTerm02."Due Date Calculation", rec."Shipment Date");
                END;
                rec.MODIFY;
            END;
        //RSPLSUM 25May2020<<
    END;

    LOCAL PROCEDURE EmailToSalesperson();
    VAR

        EmailMsg: Codeunit "Email Message";//SMTPMail: Codeunit 400;
        EmailObj: Codeunit Email;
        RecipientType: Enum "Email Recipient Type";

        UserSetupRec: Record 91;
        SH: Record 36;
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        Instr: InStream;
        RecSalesperPurchaser: Record 13;
        ServerTempFile: Text;
        SalespersonEmail: Text[100];
        FileMgmt: Codeunit 419;
        RecSpForRegionHead: Record 13;
        RecSpForHOD: Record 13;
        Loc21: Record 14;
        SL21: Record 37;
        UnitOfMeasureCode: Code[20];
        SL22: Record 37;
        Cust18: Record 18;
        CrAmt: Decimal;
        OtAmt: Decimal;
        ODAmt: Decimal;
    BEGIN
        //  SMTPMailSetup.GET;//RSPLSUM02Apr21

        //RSPLSUM 14Jan21>>
        CLEAR(EmailMsg);
        CLEAR(SalespersonEmail);
        CLEAR(ServerTempFile);

        //  ServerTempFile := FileMgmt.ServerTempFileName('pdf');

        SH.RESET;
        SH.SETRANGE("Document Type", rec."Document Type");
        SH.SETRANGE("No.", rec."No.");
        IF SH.FINDFIRST THEN BEGIN
            Clear(TempBlob);
            TempBlob.CreateOutStream(OutStr);
            //IF REPORT.SAVEASPDF(50013, ServerTempFile, SH) THEN BEGIN
            if Report.SaveAs(50013, '', ReportFormat::Pdf, OutStr) then begin
                //IF DIALOG.CONFIRM('Do you want to send email to the vendor') THEN BEGIN
                UserSetupRec.RESET;
                IF UserSetupRec.GET(USERID) THEN;

                //Add Salesperson Email>>
                RecSalesperPurchaser.RESET;
                IF RecSalesperPurchaser.GET(rec."Salesperson Code") THEN BEGIN
                    IF RecSalesperPurchaser."E-Mail" <> '' THEN
                        SalespersonEmail := RecSalesperPurchaser."E-Mail";
                END;
                //Add Salesperson Email<<

                //RSPLSUM02Apr21--SMTPMail.CreateMessage('',UserSetupRec."E-Mail",SalespersonEmail,"No."+' - '+"Sell-to Customer Name",'',TRUE);
                // SMTPMail.CreateMessage('', SMTPMailSetup."User ID", SalespersonEmail, rec."No." + ' - ' + rec."Sell-to Customer Name", '', TRUE);//RSPLSUM02Apr21
                //  EmailMsg.Create(GloReciepientEmail, '', '', true);
                EmailMsg.Create(SalespersonEmail, rec."No." + ' - ' + rec."Sell-to Customer Name", '');

                //Add Email of Region Head Code and HOD>>
                RecSalesperPurchaser.RESET;
                IF RecSalesperPurchaser.GET(rec."Salesperson Code") THEN BEGIN

                    IF RecSalesperPurchaser."Region Head Code" <> '' THEN BEGIN
                        RecSpForRegionHead.RESET;
                        IF RecSpForRegionHead.GET(RecSalesperPurchaser."Region Head Code") THEN BEGIN
                            IF RecSpForRegionHead."E-Mail" <> '' THEN
                                // SMTPMail.AddRecipients(RecSpForRegionHead."E-Mail");
                                EmailMsg.AddRecipient(RecipientType::"To", RecSpForRegionHead."E-Mail");
                        END;
                    END;

                    IF RecSalesperPurchaser.HOD <> '' THEN BEGIN
                        RecSpForHOD.RESET;
                        IF RecSpForHOD.GET(RecSalesperPurchaser.HOD) THEN BEGIN
                            IF RecSpForHOD."E-Mail" <> '' THEN
                                //  SMTPMail.AddRecipients(RecSpForHOD."E-Mail");
                                EmailMsg.AddRecipient(RecipientType::"To", RecSpForHOD."E-Mail");


                        END;
                    END;
                END;
                //Add Email of Region Head Code and HOD<<

                //>>CreditLimit
                CLEAR(CrAmt);
                CLEAR(OtAmt);
                CLEAR(ODAmt);
                Cust18.RESET;
                IF Cust18.GET(rec."Sell-to Customer No.") THEN BEGIN
                    Cust18.CALCFIELDS("Balance (LCY)");
                    CrAmt := Cust18."Credit Limit (LCY)";
                    OtAmt := Cust18."Balance (LCY)";
                    ODAmt := Cust18.CalcOverdueBalance;
                END;
                //<<CreditLimit

                EmailMsg.AppendToBody('Dear Sir/Madam,');
                EmailMsg.AppendToBody('<br><br>');
                EmailMsg.AppendToBody('Please find attached ' + rec."No." + ' for your approval');
                EmailMsg.AppendToBody('<br><br>');

                EmailMsg.AppendToBody('<Table  Border="1">');//Table Start
                EmailMsg.AppendToBody('<tr>');
                EmailMsg.AppendToBody('<th>Company Name </th>');
                EmailMsg.AppendToBody('<td>' + COMPANYNAME + '</td>');
                EmailMsg.AppendToBody('</tr>');

                EmailMsg.AppendToBody('<tr>');
                EmailMsg.AppendToBody('<th>Sales Order No.</th>');
                EmailMsg.AppendToBody('<td>' + rec."No." + '</td>');
                EmailMsg.AppendToBody('</tr>');

                EmailMsg.AppendToBody('<tr>');
                EmailMsg.AppendToBody('<th>Customer</th>');
                EmailMsg.AppendToBody('<td>' + rec."Sell-to Customer No." + '  ' + rec."Sell-to Customer Name" + '</td>');
                EmailMsg.AppendToBody('</tr>');

                EmailMsg.AppendToBody('<tr>');
                EmailMsg.AppendToBody('<th>Supply Location</th>');
                Loc21.RESET;
                IF Loc21.GET(rec."Location Code") THEN;
                EmailMsg.AppendToBody('<td>' + Loc21.Name + '</td>');
                EmailMsg.AppendToBody('</tr>');

                EmailMsg.AppendToBody('<tr>');
                EmailMsg.AppendToBody('<th>Quantity</th>');
                SL21.RESET;
                SL21.SETRANGE("Document Type", rec."Document Type");
                SL21.SETRANGE("Document No.", rec."No.");
                SL21.CALCSUMS("Quantity (Base)", Quantity);//RSPLSUM 06Jun2020--SL21.CALCSUMS("Quantity (Base)");
                                                           //RSPLSUM 06Jun2020>>--To show Quantity and UOM for COAL division (DIV-09)--
                IF rec."Shortcut Dimension 1 Code" = 'DIV-09' THEN BEGIN
                    CLEAR(UnitOfMeasureCode);
                    SL22.RESET;
                    SL22.SETRANGE("Document Type", rec."Document Type");
                    SL22.SETRANGE("Document No.", rec."No.");
                    SL22.SETFILTER(Quantity, '<>%1', 0);
                    IF SL22.FINDFIRST THEN
                        UnitOfMeasureCode := SL22."Unit of Measure Code";

                    EmailMsg.AppendToBody('<td>' + FORMAT(SL21.Quantity, 0, '<Integer Thousand><Decimals,3>') + ' ' + UnitOfMeasureCode + '</td>');
                END ELSE//RSPLSUM 06Jun2020<<
                    EmailMsg.AppendToBody('<td>' + FORMAT(SL21."Quantity (Base)", 0, '<Integer Thousand><Decimals,3>') + '</td>');
                EmailMsg.AppendToBody('</tr>');

                EmailMsg.AppendToBody('<tr>');
                EmailMsg.AppendToBody('<th>Gross Amount </th>');
                rec.CALCFIELDS("Amount to Customer");
                EmailMsg.AppendToBody('<td>' + FORMAT(rec."Amount to Customer", 0, '<Integer Thousand><Decimals,3>') + '</td>');
                EmailMsg.AppendToBody('</tr>');

                EmailMsg.AppendToBody('<tr>');
                EmailMsg.AppendToBody('<th>Credit Limit </th>');
                EmailMsg.AppendToBody('<td>' + FORMAT(CrAmt, 0, '<Integer Thousand><Decimals,3>') + '</td>');
                EmailMsg.AppendToBody('</tr>');

                EmailMsg.AppendToBody('<tr>');
                EmailMsg.AppendToBody('<th>Total Outstanding Amount </th>');
                EmailMsg.AppendToBody('<td>' + FORMAT(OtAmt, 0, '<Integer Thousand><Decimals,3>') + '</td>');
                EmailMsg.AppendToBody('</tr>');

                EmailMsg.AppendToBody('<tr>');
                EmailMsg.AppendToBody('<th>Overdue Amount </th>');
                EmailMsg.AppendToBody('<td>' + FORMAT(ODAmt, 0, '<Integer Thousand><Decimals,3>') + '</td>');
                EmailMsg.AppendToBody('</tr>');

                EmailMsg.AppendToBody('</table>');//Table End
                EmailMsg.AppendToBody('<Br>');
                EmailMsg.AppendToBody('<Br>');

                EmailMsg.AppendToBody('<HR>');
                EmailMsg.AppendToBody('This is a system generated mail.');

                //SMTPMail.AddAttachment(ServerTempFile, 'Sales Order Industrial - GST.pdf');
                //EmailMsg.AddAttachment('Sales Order Industrial - GST.pdf', ServerTempFile,);
                TempBlob.CreateInStream(InStr);
                EmailMsg.AddAttachment('Sales Order Industrial - GST', '.pdf', InStr);
                // SMTPMail.Send;
                EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);

                //MESSAGE(EmailSent);
                //END;
            END ELSE
                ERROR('Error while saving report as PDF');
        END;

        //RSPLSUM 14Jan21<<
    END;


}