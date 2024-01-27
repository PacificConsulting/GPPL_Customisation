pageextension 50069 BlanketPurchaseOrderExt extends "Blanket Purchase Order"
{
    layout
    {
        // Add changes to page layout here
        modify("No.")
        {
            Editable = false;
            Visible = true;
            trigger OnAssistEdit()
            var
                myInt: Integer;
            BEGIN
                IF rec.AssistEdit(xRec) THEN BEGIN
                    //RSPLSUM 14Apr2020>>
                    RecNoSeries.RESET;
                    IF RecNoSeries.GET(rec."No. Series") THEN BEGIN
                        IF RecNoSeries."Work Order" THEN
                            rec."Work Order" := TRUE;
                    END;
                    //RSPLSUM 14Apr2020<<
                    CurrPage.UPDATE;
                END;
            END;
        }
        modify("Location Code")
        {
            Editable = FieldEdtiable;
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN

                //>>21Jul2018 RB-N
                IF rec."Vendor Posting Group" <> 'FUELOIL' THEN BEGIN//RSPLSUM 19Jun2020
                    IF rec."Gen. Bus. Posting Group" = 'FOREIGN' THEN
                        rec.TESTFIELD("Location Code", 'BOND0001');
                END;//RSPLSUM 19Jun2020
                    //>>21Jul2018 RB-N
            END;
        }
        addafter("Buy-from Contact")
        {
            group(group)
            {
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ApplicationArea = all;
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                }
                field("Applies-to ID"; Rec."Applies-to ID")
                {
                    ApplicationArea = all;
                }

            }
            group("Advance Payment Details")
            {
                field("Paid Amount"; Rec."Paid Amount")
                {
                    ApplicationArea = all;
                    Editable = FieldEdtiable;
                }
                field("Paid Cheque No."; Rec."Paid Cheque No.")
                {
                    ApplicationArea = all;
                }
                field("Paid Cheque Date"; Rec."Paid Cheque Date")
                {
                    ApplicationArea = all;
                }
            }
            group("others")
            {
                field("Freight Type"; Rec."Freight Type")
                {
                    ApplicationArea = all;
                }
                field("Exp. TPT Cost"; Rec."Exp. TPT Cost")
                {
                    ApplicationArea = all;
                }
            }
            field("Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                ApplicationArea = all;
                // CaptionML =[ENU =Expected Delivery Date;
                //   ENN =Promised Receipt Date];
                // SourceExpr ="Promised Receipt Date";
                Editable = FieldEdtiable;
            }
            field("Shipping Agent Code"; Rec."Shipping Agent Code")
            {
                ApplicationArea = all;
            }
            field(Closed; Rec.Closed)
            {
                ApplicationArea = all;
            }
            field("Work Order"; Rec."Work Order")
            {
                ApplicationArea = all;
                Style = Unfavorable;
                StyleExpr = TRUE;
            }
            // field("Order Date"; Rec."Order Date")
            // {
            //     ApplicationArea = all;
            //     Editable = FieldEdtiable;
            // }
            field("Closing Date"; Rec."Closing Date")
            {
                ApplicationArea = all;
            }
            // field("No. of Archived Versions"; Rec."No. of Archived Versions")
            // {
            //     ApplicationArea = ALL;
            // }
            // field("Responsibility Center"; Rec."Responsibility Center")
            // {
            //     ApplicationArea = ALL;
            // }
            // field("Campaign No."; Rec."Campaign No.")
            // {
            //     ApplicationArea = all;
            //     Editable = FieldEdtiable;
            // }
            field("Finance Rejection Remarks"; Rec."Finance Rejection Remarks")
            {
                ApplicationArea = all;
                Editable = FinRemarksEdit;
            }
            field("Department Code"; Rec."Department Code")
            {
                ApplicationArea = all;
            }
            field("Deal Sheet No."; Rec."Deal Sheet No.")
            {
                ApplicationArea = all;
            }
            field("Deal Sheet Date"; Rec."Deal Sheet Date")
            {
                ApplicationArea = all;
            }
            field("Freight Charges"; rec."Freight Charges") // MY PC 08 01 2024
            {
                ApplicationArea = all;
            }




        }

    }

    actions
    {
        modify(Release)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;


            BEGIN
                //>> RB-N 16Nov2017 Releasing Blanket PO
                User15.RESET;
                User15.SETRANGE("User ID", USERID);
                User15.SETRANGE("PO Creation", TRUE);
                IF NOT User15.FINDFIRST THEN
                    ERROR('You do not have permission for releasing Blanket PO');
                //<< RB-N 16Nov2017 Releasing Blanket PO

                ERROR('You cannot release Document directly');

                //RSPLSUM 15Apr2020>>
                IF rec."Work Order" THEN BEGIN
                    rec.TESTFIELD("Department Code");
                    rec.TESTFIELD("Deal Sheet No.");
                END;
                //RSPLSUM 15Apr2020<<

                //RSPL060814
                recPurchLine.RESET;
                recPurchLine.SETRANGE(recPurchLine."Document No.", rec."No.");
                recPurchLine.SETRANGE(recPurchLine.Type, recPurchLine.Type::Item);
                IF recPurchLine.FINDSET THEN
                    REPEAT
                        recItem.GET(recPurchLine."No.");
                        IF recItem."Item Category Code" = 'CAT08' THEN
                            recPurchLine.TESTFIELD(recPurchLine."Landed Cost");
                    UNTIL recPurchLine.NEXT = 0;
                //RSPL
                //RSPL-Sourav020415
                cduArchveMgmt.StorePurchDocument(Rec, FALSE);
                //RSPL-Sourav020415
            end;
        }
        modify("Reopen")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;

            BEGIN

                //>>14Mar2018
                IF (USERID <> 'GPUAE\UNNIKRISHNAN.VS') AND (USERID <> 'GPUAE\KAUSTUBH.PARAB') THEN
                    IF rec."Level1 Approval" THEN BEGIN
                        SAE11.RESET;
                        SAE11.SETCURRENTKEY("Document No.", "Version No.");
                        SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Blanket PO");
                        SAE11.SETRANGE("Document No.", rec."No.");
                        SAE11.SETRANGE(Approved, TRUE);
                        IF SAE11.FINDLAST THEN BEGIN
                            SalesApproval.RESET;
                            SalesApproval.SETRANGE("Document Type", SAE11."Document Type");
                            SalesApproval.SETRANGE("User ID", SAE11."User ID");
                            SalesApproval.SETRANGE("Approvar ID", USERID);
                            IF NOT SalesApproval.FINDLAST THEN
                                ERROR('Required Level1 Approvar for Reopening %1 Document No.', rec."No.");
                        END;
                    END;

                IF (USERID <> 'GPUAE\UNNIKRISHNAN.VS') AND (USERID <> 'GPUAE\KAUSTUBH.PARAB') THEN
                    IF rec."Level2 Approval" THEN BEGIN
                        SAE11.RESET;
                        SAE11.SETCURRENTKEY("Document No.", "Version No.");
                        SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Blanket PO");
                        SAE11.SETRANGE("Document No.", rec."No.");
                        SAE11.SETRANGE(Approved, TRUE);
                        IF SAE11.FINDLAST THEN BEGIN

                            SalesApproval.RESET;
                            SalesApproval.SETRANGE("Document Type", SAE11."Document Type");
                            SalesApproval.SETRANGE("User ID", SAE11."User ID");
                            //SalesApproval.SETRANGE("Approvar ID",SAE11."Approvar ID");
                            SalesApproval.SETRANGE("Level2 Approvar ID", USERID);
                            IF NOT SalesApproval.FINDLAST THEN
                                ERROR('Required Level2 Approvar for Reopening %1 Document No.', rec."No.");
                        END;
                    END;

                SalesApprovalEntry.RESET;
                SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Blanket PO");
                SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                SalesApprovalEntry.SETRANGE(Approved, FALSE);
                IF SalesApprovalEntry.FINDFIRST THEN BEGIN
                    SalesApprovalEntry.DELETEALL(TRUE);
                END;

                rec."Send For Approval" := FALSE;
                rec."Approval Status" := rec."Approval Status"::Open;
                rec."Level1 Approval" := FALSE;
                rec."Level2 Approval" := FALSE;
                rec."Approved by Finance" := FALSE;//06May2019
                rec."Finance Rejected" := FALSE;//06May2019
                rec."Finance Rejection Remarks" := '';//06May2019
                rec.MODIFY;
                //>>14Mar2018
            end;

            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                FieldEdtiable := TRUE;//16Nov2017
                FieldEdtiable1 := TRUE;//16Nov2017
            end;
        }
        modify("SendApprovalRequest")
        {
            ApplicationArea = ALL;
            trigger OnAfterAction()
            var
                myInt: Integer;
            BEGIN
                //RSPL060814
                recPurchLine.RESET;
                recPurchLine.SETRANGE(recPurchLine."Document No.", rec."No.");
                recPurchLine.SETRANGE(recPurchLine.Type, recPurchLine.Type::Item);
                IF recPurchLine.FINDSET THEN
                    REPEAT
                        recItem.GET(recPurchLine."No.");
                        IF recItem."Item Category Code" = 'CAT08' THEN
                            recPurchLine.TESTFIELD(recPurchLine."Landed Cost");
                    UNTIL recPurchLine.NEXT = 0;
                //RSPL
            end;
        }
        // modify("Calculate Structure Values")
        // {

        //     trigger OnAfterAction()


        //     VAR
        //         PL: Record 39;
        //     BEGIN
        //         //>>07July2017 LineAmount Validation
        //         PL.RESET;
        //         PL.SETRANGE("Document No.", rec."No.");
        //         IF PL.FINDSET THEN
        //             REPEAT
        //                 IF PL.Amount = 0 THEN BEGIN
        //                     ERROR('Line Amount Cannot be Zero.\ Document No.: %1 \ Line No.: %2 ', PL."Document No.", PL."Line No.");

        //                 END;

        //             UNTIL PL.NEXT = 0;
        //         //<<07July2017 LineAmount Validation

        //         //>>05Aug2017 GST Calculation with or Without OrdessCode

        //         IF rec."Order Address Code" <> '' THEN BEGIN
        //             Ord05.RESET;
        //             IF Ord05.GET(rec."Buy-from Vendor No.", rec."Order Address Code") THEN BEGIN

        //                 IF Ord05."GST Registration No." = '' THEN
        //                     ERROR('Please update GST Regisration Order Address');
        //             END;

        //         END ELSE BEGIN
        //             Ven05.RESET;
        //             IF Ven05.GET(rec."Buy-from Vendor No.") THEN
        //                 IF Ven05."Gen. Bus. Posting Group" <> 'FOREIGN' THEN BEGIN
        //                     IF Ven05."GST Vendor Type" = Ven05."GST Vendor Type"::" " THEN
        //                         ERROR('Please update the Vendor master with GST Vendor Type');
        //                 END;

        //         END;
        //         //<<05Aug2017 GST Calculation with or Without OrdessCode
        //     end;
        // }
        modify("MakeOrder")
        {
            ApplicationArea = ALL;
            trigger OnAfterAction()
            var
                myInt: Integer;

            BEGIN
                rec.TESTFIELD(Status, rec.Status::Released);//RB-N 16Nov2017
                IF NOT rec."Approved by Finance" THEN
                    ERROR('Finance Approval is Required');

                //EBT STIVAN ---(08102012)--- A new Role has been created,as per the role the MAKE Order will be done ----START
                //                  {
                //                  Memberof.RESET;
                // Memberof.SETRANGE(Memberof."User ID", USERID);
                // Memberof.SETRANGE(Memberof."Role ID", 'MAKE PURCH. ORDER');
                // IF NOT (Memberof.FINDFIRST) THEN
                //     ERROR('You do not have permission to Make Purchase Order');
                //                  //EBT STIVAN ---(08102012)--- A new Role has been created,as per the role the MAKE Order will be done ------END
                //                  }
                //RSPL-TC +
                AccessControl.RESET;
                AccessControl.SETRANGE("User Name", USERID);
                AccessControl.SETRANGE("Role ID", 'MAKE PURCH. ORDER');
                IF NOT (AccessControl.FINDFIRST) THEN
                    ERROR('You do not have permission to Make Purchase Order');
                //RSPL-TC -
                //RSPL060814
                recPurchLine.RESET;
                recPurchLine.SETRANGE(recPurchLine."Document No.", rec."No.");
                recPurchLine.SETRANGE(recPurchLine.Type, recPurchLine.Type::Item);
                IF recPurchLine.FINDSET THEN
                    REPEAT
                        recItem.GET(recPurchLine."No.");
                        IF recItem."Item Category Code" = 'CAT08' THEN
                            recPurchLine.TESTFIELD(recPurchLine."Landed Cost");
                    UNTIL recPurchLine.NEXT = 0;
                //RSPL
                //RSPL-Sourav020415
                //TESTFIELD(Status,Status::Released);
                //RSPL-Sourav020415
            end;
        }
        addafter(Print)
        {
            action("Purchase Order - &Regular")
            {
                ApplicationArea = ALL;
                Image = Print;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN

                    IF rec."Payment Terms Code" = '' THEN
                        ERROR('Payment Terms Code is Blank');

                    //EBT STIVAN ---(1307012)-----------------------------------------------------START
                    IF rec."Order Address Code" <> '' THEN BEGIN
                        PurchLine.RESET;
                        PurchLine.SETRANGE(PurchLine."Document No.", rec."No.");
                        IF PurchLine.FINDSET THEN
                            IF (PurchLine."Tax Amount" <> 0) THEN BEGIN
                                IF rec."Vendor TIN No." = '' THEN BEGIN
                                    OrderAddress.GET(rec."Buy-from Vendor No.", rec."Order Address Code");
                                    IF (OrderAddress."L.S.T. No." = '') THEN
                                        ERROR('TIN No. is Blank');
                                    //MESSAGE('TIN No. is Blank');
                                END;
                            END;
                    END;

                    IF rec."Order Address Code" = '' THEN BEGIN
                        PurchLine.RESET;
                        PurchLine.SETRANGE(PurchLine."Document No.", rec."No.");
                        IF PurchLine.FINDSET THEN
                            IF (PurchLine."Tax Amount" <> 0) THEN BEGIN
                                IF rec."Vendor TIN No." = '' THEN BEGIN
                                    Vendor.GET(rec."Buy-from Vendor No.");
                                    IF (Vendor."L.S.T. No." = '') THEN
                                        ERROR('TIN No. is Blank');
                                    //MESSAGE('TIN No. is Blank');
                                END;
                            END;
                    END;
                    //EBT STIVAN ---(13072012)-------------------------------------------------------END

                    DocPrint.PrintPurchHeader(Rec);
                END;
            }
            action("Purchase Order - R&egular DetailedC")
            {
                ApplicationArea = ALL;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN
                    RecPurchheader.RESET;
                    RecPurchheader := Rec;
                    RecPurchheader.SETRECFILTER;
                    REPORT.RUNMODAL(50087, TRUE, FALSE, RecPurchheader);
                END;
            }
            action("Purchase Order - &Import1C")
            {
                ApplicationArea = ALL;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN
                    //RSPLSUM 06Dec19>>
                    IF rec."Approved by Finance" = FALSE THEN
                        ERROR('Financial approval is required');
                    //RSPLSUM 06Dec19<<

                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUNMODAL(50054, TRUE, FALSE, Rec)
                END;
            }
            action("Purchase Order - GSTC")
            {
                ApplicationArea = all;
                Image = Print;
                trigger OnAction()

                VAR
                    PH: Record 38;
                BEGIN
                    //RSPLSUM 06Dec19>>
                    IF rec."Approved by Finance" = FALSE THEN
                        ERROR('Financial approval is required');
                    //RSPLSUM 06Dec19<<

                    //>>05Aug2017 GST Calculation with or Without OrdessCode

                    IF rec."Order Address Code" <> '' THEN BEGIN
                        Ord05.RESET;
                        IF Ord05.GET(rec."Buy-from Vendor No.", rec."Order Address Code") THEN BEGIN

                            IF Ord05."GST Registration No." = '' THEN
                                ERROR('Please update GST Regisration Order Address');
                        END;

                    END ELSE BEGIN
                        Ven05.RESET;
                        IF Ven05.GET(rec."Buy-from Vendor No.") THEN
                            IF Ven05."Gen. Bus. Posting Group" <> 'FOREIGN' THEN BEGIN
                                IF Ven05."GST Vendor Type" = Ven05."GST Vendor Type"::" " THEN
                                    ERROR('Please update the Vendor master with GST Vendor Type');
                            END;

                    END;
                    //<<05Aug2017 GST Calculation with or Without OrdessCode

                    //>>06July2017
                    PH.RESET;
                    PH.SETRANGE("Document Type", rec."Document Type");
                    PH.SETRANGE("No.", rec."No.");
                    IF PH.FINDFIRST THEN
                        REPORT.RUNMODAL(50020, TRUE, TRUE, PH);

                    //<<06July2017
                END;
            }
            action("Purchase Order- GST LOGOC")
            {
                ApplicationArea = all;
                Image = Print;
                trigger OnAction()

                VAR
                    PH: Record 38;
                BEGIN
                    //RSPLSUM 06Dec19>>
                    IF rec."Approved by Finance" = FALSE THEN
                        ERROR('Financial approval is required');
                    //RSPLSUM 06Dec19<<

                    //>>17Nov2017 GST Calculation with or Without OrdessCode

                    IF rec."Order Address Code" <> '' THEN BEGIN
                        Ord05.RESET;
                        IF Ord05.GET(rec."Buy-from Vendor No.", rec."Order Address Code") THEN BEGIN

                            IF Ord05."GST Registration No." = '' THEN
                                ERROR('Please update GST Regisration Order Address');
                        END;

                    END ELSE BEGIN
                        Ven05.RESET;
                        IF Ven05.GET(rec."Buy-from Vendor No.") THEN
                            IF Ven05."Gen. Bus. Posting Group" <> 'FOREIGN' THEN BEGIN
                                IF Ven05."GST Vendor Type" = Ven05."GST Vendor Type"::" " THEN
                                    ERROR('Please update the Vendor master with GST Vendor Type');
                            END;

                    END;
                    //<<17Nov2017 GST Calculation with or Without OrdessCode

                    //>>17Nov2017
                    PH.RESET;
                    PH.SETRANGE("Document Type", rec."Document Type");
                    PH.SETRANGE("No.", rec."No.");
                    IF PH.FINDFIRST THEN
                        REPORT.RUNMODAL(50170, TRUE, TRUE, PH);

                    //<<17Nov2017
                end;

            }

        }
        // Add changes to page actions here
        addafter(Approve)
        {

            action("Detailed GST")
            {
                ApplicationArea = all;
                RunObject = Page "Detailed GST Entry Buffer";
                // RunPageLink = "Transaction Type" = FILTER(Purchase),
                //                   "Document Type" = FIELD("Document Type"),
                //                   "Document No." = FIELD("No.");
                Image = ServiceTax;


            }
            action("Send For Authorization")
            {
                ApplicationArea = ALL;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN

                    //>>06Feb2018
                    rec.TESTFIELD("Approval Status", rec."Approval Status"::Open);
                    rec.TESTFIELD(Status, rec.Status::Open);

                    //RSPLSUM 15Apr2020>>
                    IF rec."Work Order" THEN BEGIN
                        rec.TESTFIELD("Department Code");
                        rec.TESTFIELD("Deal Sheet No.");
                    END;
                    //RSPLSUM 15Apr2020<<

                    PL06.RESET;
                    PL06.SETRANGE("Document Type", rec."Document Type");
                    PL06.SETRANGE("Document No.", rec."No.");
                    PL06.SETRANGE(Type, PL06.Type::Item);
                    PL06.SETRANGE("Item Category Code", 'CAT08');
                    IF PL06.FINDSET THEN
                        REPEAT
                            PL06.TESTFIELD("Landed Cost");
                        UNTIL PL06.NEXT = 0;

                    //>>
                    PL06.RESET;
                    PL06.SETRANGE("Document Type", rec."Document Type");
                    PL06.SETRANGE("Document No.", rec."No.");
                    PL06.SETRANGE(Type, PL06.Type::Item);
                    IF PL06.FINDSET THEN
                        REPEAT
                            PL06.TESTFIELD("MR No");
                        UNTIL PL06.NEXT = 0;
                    //<<

                    PL06.RESET;
                    PL06.SETRANGE("Document Type", rec."Document Type");
                    PL06.SETRANGE("Document No.", rec."No.");
                    PL06.CALCSUMS(Quantity);
                    IF PL06.Quantity = 0 THEN
                        ERROR('Please enter No. of Qty');

                    IF NOT rec."Send For Approval" THEN BEGIN

                        TempVersionNo := 0;
                        SAE11.RESET;
                        SAE11.SETCURRENTKEY("Document No.", "Version No.");
                        SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Blanket PO");
                        SAE11.SETRANGE("Document No.", rec."No.");
                        IF SAE11.FINDLAST THEN BEGIN
                            TempVersionNo := SAE11."Version No.";
                        END;

                        SalesApproval.RESET;
                        SalesApproval.SETCURRENTKEY("Document Type");
                        SalesApproval.SETRANGE("Document Type", SalesApproval."Document Type"::"Blanket PO");
                        SalesApproval.SETRANGE("User ID", USERID);
                        SalesApproval.SETFILTER("Approvar ID", '<>%1', '');
                        IF SalesApproval.FINDSET THEN BEGIN
                            TempSeqNo := 0;//16May2018
                            REPEAT
                                TempSeqNo += 1;//16May2018
                                SalesApprovalEntry.INIT;
                                SalesApprovalEntry."Document Type" := SalesApprovalEntry."Document Type"::"Blanket PO";
                                SalesApprovalEntry."Document No." := rec."No.";
                                SalesApprovalEntry."User ID" := USERID;
                                SalesApprovalEntry."User Name" := SalesApproval.Name;
                                SalesApprovalEntry."Approvar ID" := SalesApproval."Approvar ID";
                                SalesApprovalEntry."Approver Name" := SalesApproval."Approvar Name";
                                SalesApprovalEntry."Mandatory ID" := SalesApproval.Mandatory;
                                SalesApprovalEntry."Date Sent for Approval" := TODAY;
                                SalesApprovalEntry."Time Sent for Approval" := TIME;
                                SalesApprovalEntry."Version No." := TempVersionNo + 1;
                                SalesApprovalEntry."Sequence No." := TempSeqNo;
                                SalesApprovalEntry.INSERT;
                            UNTIL SalesApproval.NEXT = 0;
                            MESSAGE('Document No. %1 has been sent for Approval', rec."No.");
                        END ELSE
                            ERROR('Blanket PO  Approval setup does not exists for User %1', USERID);
                    END ELSE
                        ERROR('Document No. %1 has already been sent for approval');

                    rec."Send For Approval" := TRUE;
                    rec."Approval Status" := rec."Approval Status"::"Pending for L1 Approval";
                    rec.Status := rec.Status::"Pending Approval";
                    rec.MODIFY;

                    //<<06Feb2018

                    //>>15May2018
                    PurPay.GET;
                    IF PurPay."Email Alert on Blanket PO" THEN
                        EmailNotification(1, rec."No.", 1, USERID, '', '');
                    //<<15May2018
                END;
            }
            action("Level1 Approval")
            {
                Image = Approvals;
                ApplicationArea = all;
                trigger OnAction()

                VAR
                    ReleasePurchDoc: Codeunit 415;
                BEGIN

                    //>>06Feb2018
                    rec.TESTFIELD("Approval Status", rec."Approval Status"::"Pending for L1 Approval");

                    SalesApproval.RESET;
                    SalesApproval.SETRANGE("Document Type", SalesApproval."Document Type"::"Blanket PO");
                    SalesApproval.SETRANGE("Approvar ID", USERID);
                    IF NOT SalesApproval.FINDFIRST THEN
                        ERROR('You donot have rights to Approve, Please Contact System Administrator');

                    SalesApprovalEntry.RESET;
                    SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Blanket PO");
                    SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                    SalesApprovalEntry.SETRANGE("Approvar ID", USERID);
                    SalesApprovalEntry.SETRANGE(Approved, FALSE);
                    IF NOT SalesApprovalEntry.FINDLAST THEN
                        ERROR('Approval Entry Not Found %1 Document', rec."No.");


                    CLEAR(LimitAmt06);
                    // rec.CALCFIELDS("Amount to Vendor");
                    // LimitAmt06 := rec."Amount to Vendor";


                    SalesApprovalEntry.RESET;
                    SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                    SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Blanket PO");
                    SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                    SalesApprovalEntry.SETRANGE("Approvar ID", USERID);
                    IF SalesApprovalEntry.FINDLAST THEN BEGIN

                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SalesApprovalEntry."Document Type");
                        SalesApproval.SETRANGE("User ID", SalesApprovalEntry."User ID");
                        SalesApproval.SETRANGE("Approvar ID", USERID);
                        IF SalesApproval.FINDFIRST THEN BEGIN

                            IF NOT CONFIRM(Text001, FALSE) THEN
                                EXIT;

                            IF SalesApproval."Purchase Approval Limit" >= LimitAmt06 THEN BEGIN
                                //MESSAGE('Limit is Greater');
                                SalesApprovalEntry.Approved := TRUE;
                                SalesApprovalEntry."Approval Date" := TODAY;
                                SalesApprovalEntry."Approval Time" := TIME;
                                SalesApprovalEntry.MODIFY;

                                //>>15May2018
                                PurPay.GET;
                                IF PurPay."Email Alert on Blanket PO" THEN
                                    EmailNotification(1, rec."No.", 2, USERID, '', 'YES');
                                //<<15May2018

                                ReleasePurchDoc.PerformManualRelease(Rec);
                                rec."Approval Status" := rec."Approval Status"::Approved;
                                rec."Level1 Approval" := TRUE;
                                rec.MODIFY;
                                MESSAGE('Approved');
                                cduArchveMgmt.StorePurchDocument(Rec, FALSE);

                                SAE11.RESET;
                                SAE11.SETCURRENTKEY("Document Type", "Document No.", "Version No.");
                                SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Blanket PO");
                                SAE11.SETRANGE("Document No.", SalesApprovalEntry."Document No.");
                                SAE11.SETRANGE("Version No.", SalesApprovalEntry."Version No.");
                                SAE11.SETRANGE(Approved, FALSE);
                                IF SAE11.FINDFIRST THEN BEGIN
                                    SAE11.DELETEALL(TRUE);
                                END;
                            END;

                            IF SalesApproval."Purchase Approval Limit" < LimitAmt06 THEN BEGIN
                                //MESSAGE('Limit is Lesser');
                                SalesApprovalEntry.Approved := TRUE;
                                SalesApprovalEntry."Approval Date" := TODAY;
                                SalesApprovalEntry."Approval Time" := TIME;
                                SalesApprovalEntry.MODIFY;

                                //>>15May2018
                                PurPay.GET;
                                IF PurPay."Email Alert on Blanket PO" THEN
                                    EmailNotification(1, rec."No.", 3, USERID, '', '');
                                //<<15May2018

                                rec."Approval Status" := rec."Approval Status"::"Pending for L2 Approval";
                                rec.MODIFY;

                                SAE11.RESET;
                                SAE11.SETCURRENTKEY("Document Type", "Document No.", "Version No.");
                                SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Blanket PO");
                                SAE11.SETRANGE("Document No.", SalesApprovalEntry."Document No.");
                                SAE11.SETRANGE("Version No.", SalesApprovalEntry."Version No.");
                                SAE11.SETRANGE(Approved, FALSE);
                                IF SAE11.FINDFIRST THEN BEGIN
                                    SAE11.DELETEALL(TRUE);
                                END;

                                CurrPage.UPDATE(TRUE);
                                MESSAGE('Purchase Approval Amount is Exceed,So it required Level2 Approval');
                                EXIT;

                            END;
                        END;
                    END;
                    //<<06Feb2018
                END;
            }
            action("Level2 Approval")
            {
                ApplicationArea = ALL;
                Image = Approvals;
                trigger OnAction()

                VAR
                    ReleasePurchDoc: Codeunit 415;
                BEGIN

                    //>>06Feb2018
                    rec.TESTFIELD("Approval Status", rec."Approval Status"::"Pending for L2 Approval");

                    SalesApproval.RESET;
                    SalesApproval.SETRANGE("Document Type", SalesApproval."Document Type"::"Blanket PO");
                    SalesApproval.SETRANGE("Level2 Approvar ID", USERID);
                    IF NOT SalesApproval.FINDFIRST THEN
                        ERROR('You donot have rights to Approve, Please Contact System Administrator');


                    SAE11.RESET;
                    SAE11.SETCURRENTKEY("Document Type", "Document No.");
                    SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Blanket PO");
                    SAE11.SETRANGE("Document No.", rec."No.");
                    SAE11.SETRANGE(Approved, TRUE);
                    IF SAE11.FINDLAST THEN BEGIN
                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SAE11."Document Type");
                        SalesApproval.SETRANGE("User ID", SAE11."User ID");
                        SalesApproval.SETRANGE("Approvar ID", SAE11."Approvar ID");
                        SalesApproval.SETRANGE("Level2 Approvar ID", USERID);
                        IF NOT SalesApproval.FINDFIRST THEN
                            ERROR('Blanket PO Approval Setup does not exists for Level2 Approval');
                    END;

                    IF NOT rec."Level2 Approval" THEN BEGIN

                        IF NOT CONFIRM(Text002, FALSE) THEN
                            EXIT;

                        SalesApprovalEntry.RESET;
                        SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                        SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Blanket PO");
                        SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                        SalesApprovalEntry.SETRANGE(Approved, TRUE);
                        IF SalesApprovalEntry.FINDLAST THEN BEGIN
                            UserName06 := '';
                            User06.RESET;
                            User06.SETRANGE("User Name", USERID);
                            IF User06.FINDFIRST THEN
                                UserName06 := User06."Full Name"
                            ELSE
                                UserName06 := USERID;

                            SalesApprovalEntry."Level2 Approvar ID" := USERID;
                            SalesApprovalEntry."Level2 Approvar Name" := UserName06;
                            SalesApprovalEntry."Level2 Approvar Date" := TODAY;
                            SalesApprovalEntry."Level2 Approvar Time" := TIME;
                            SalesApprovalEntry.MODIFY;

                            ReleasePurchDoc.PerformManualRelease(Rec);
                            rec."Approval Status" := rec."Approval Status"::Approved;
                            rec."Level2 Approval" := TRUE;
                            rec.MODIFY;
                            MESSAGE('Approved');
                            cduArchveMgmt.StorePurchDocument(Rec, FALSE);

                        END;
                    END;
                    //<<06Feb2018

                    //>>15May2018
                    PurPay.GET;
                    IF PurPay."Email Alert on Blanket PO" THEN
                        EmailNotification(1, rec."No.", 2, USERID, '', '');
                    //<<15May2018
                END;
            }
            action("Finance Approval")
            {
                ApplicationArea = ALL;
                Enabled = FinRemarksEdit;
                Image = Approvals;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN
                    rec.TESTFIELD(Status, rec.Status::Released);
                    UserSetup05.RESET;
                    UserSetup05.SETRANGE("User ID", USERID);
                    UserSetup05.SETRANGE("Finance Approver", TRUE);
                    IF NOT UserSetup05.FINDFIRST THEN
                        ERROR('You dont have permission for Financial Approval');

                    IF rec."Approved by Finance" THEN
                        ERROR('Already Approved by Finance');

                    IF rec."Finance Rejected" THEN
                        ERROR('Already Rejected by Finance');

                    rec."Approved by Finance" := TRUE;
                    rec."Finance Approver Date" := CURRENTDATETIME;
                    rec."Finance Approver ID" := USERID;
                    rec.MODIFY;

                    //RSPLSUM04May21>>
                    SalesApprovalEntry.RESET;
                    SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                    SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Blanket PO");
                    SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                    SalesApprovalEntry.SETRANGE(Approved, TRUE);
                    IF SalesApprovalEntry.FINDLAST THEN BEGIN
                        UserName06 := '';
                        User06.RESET;
                        User06.SETRANGE("User Name", USERID);
                        IF User06.FINDFIRST THEN
                            UserName06 := User06."Full Name"
                        ELSE
                            UserName06 := USERID;

                        SalesApprovalEntry."Finance Approver ID" := USERID;
                        SalesApprovalEntry."Finance Approver Name" := UserName06;
                        SalesApprovalEntry."Finance Approver Date" := TODAY;
                        SalesApprovalEntry."Finance Approver Time" := TIME;
                        SalesApprovalEntry.MODIFY;
                    END;
                    //RSPLSUM04May21<<

                    //>>06May2019
                    PurPay.GET;
                    IF PurPay."Email Alert on Blanket PO" THEN
                        EmailNotification(1, rec."No.", 5, USERID, '', '');
                    //<<06May2019

                    MESSAGE('%1 has been Approved', rec."No.");
                END;
            }
            action("Finance Rejection")
            {
                ApplicationArea = ALL;
                Enabled = FinRemarksEdit;
                Image = Reject;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN
                    rec.TESTFIELD(Status, rec.Status::Released);

                    UserSetup05.RESET;
                    UserSetup05.SETRANGE("User ID", USERID);
                    UserSetup05.SETRANGE("Finance Approver", TRUE);
                    IF NOT UserSetup05.FINDFIRST THEN
                        ERROR('You dont have permission for Financial Rejection');

                    IF rec."Finance Rejected" THEN
                        ERROR('Already Rejected by Finance');

                    IF rec."Approved by Finance" THEN
                        ERROR('Already Approved by Finance');

                    rec.TESTFIELD("Finance Rejection Remarks");

                    rec."Finance Rejected" := TRUE;
                    rec."Finance Rejection ID" := USERID;
                    rec."Finance Rejection Date" := CURRENTDATETIME;
                    rec.MODIFY;

                    //DJ 25012021
                    SalesApprovalEntry.RESET;
                    SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                    SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Blanket PO");
                    SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                    SalesApprovalEntry.SETRANGE(Approved, TRUE);
                    IF SalesApprovalEntry.FINDLAST THEN BEGIN
                        UserName06 := '';
                        User06.RESET;
                        User06.SETRANGE("User Name", USERID);
                        IF User06.FINDFIRST THEN
                            UserName06 := User06."Full Name"
                        ELSE
                            UserName06 := USERID;

                        SalesApprovalEntry."Finance Approver ID" := USERID;
                        SalesApprovalEntry."Finance Approver Name" := UserName06;
                        SalesApprovalEntry."Finance Approver Date" := TODAY;
                        SalesApprovalEntry."Finance Approver Time" := TIME;
                        SalesApprovalEntry.MODIFY;
                    END;
                    //DJ 25012021

                    //>>06May2019
                    PurPay.GET;
                    IF PurPay."Email Alert on Blanket PO" THEN
                        EmailNotification(1, rec."No.", 6, USERID, '', '');
                    //<<06May2019
                    MESSAGE('%1 has been Rejected', rec."No.");
                END;
            }
            action("Approval Entries")
            {
                ApplicationArea = ALL;
                Image = Ledger;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN

                    AppPage.Setfilters(1, rec."No.");
                    AppPage.RUN;
                END;
            }
            action("Email To Vendor")
            {
                ApplicationArea = ALL;
                Promoted = true;
                Image = Email;
                PromotedCategory = Process;
                trigger OnAction()

                VAR
                    // SMTPMail: Codeunit 400;
                    EmailMsg: Codeunit "Email Message";
                    EmailObj: Codeunit Email;
                    RecipientType: Enum "Email Recipient Type";

                    FileName: Text;
                    Path: Label 'ENU=\\192.168.45.9\Purchase\PO\Purchase Order - GST LOGO.pdf';
                    PurchOrderGSTLogo: Report 70170;
                    UserSetupRec: Record 91;
                    RecVend: Record 23;
                    VendorEmail: Text;
                    EmailSent: Label 'ENU=Email has been sent';
                    PH: Record 38;
                    RecSalesperPurchaser: Record 13;
                    ServerTempFile: Text;
                    FileMgmt: Codeunit 419;
                    Instr: InStream;
                BEGIN
                    // SMTPMailSetup.GET;//RSPLSUM02Apr21

                    //RSPLSUM 06Dec19>>
                    IF rec."Approved by Finance" = FALSE THEN
                        ERROR('Financial approval is required');
                    //RSPLSUM 06Dec19<<

                    //>>17Nov2017 GST Calculation with or Without OrdessCode
                    IF rec."Order Address Code" <> '' THEN BEGIN
                        Ord05.RESET;
                        IF Ord05.GET(rec."Buy-from Vendor No.", rec."Order Address Code") THEN BEGIN

                            IF Ord05."GST Registration No." = '' THEN
                                ERROR('Please update GST Regisration Order Address');
                        END;

                    END ELSE BEGIN
                        Ven05.RESET;
                        IF Ven05.GET(rec."Buy-from Vendor No.") THEN
                            IF Ven05."Gen. Bus. Posting Group" <> 'FOREIGN' THEN BEGIN
                                IF Ven05."GST Vendor Type" = Ven05."GST Vendor Type"::" " THEN
                                    ERROR('Please update the Vendor master with GST Vendor Type');
                            END;

                    END;
                    //<<17Nov2017 GST Calculation with or Without OrdessCode

                    CLEAR(EmailMsg);
                    CLEAR(VendorEmail);
                    CLEAR(FileName);

                    FileName := Path;

                    //  ServerTempFile := FileMgmt.ServerTempFileName('pdf');

                    PH.RESET;
                    PH.SETRANGE("Document Type", rec."Document Type");
                    PH.SETRANGE("No.", rec."No.");
                    IF PH.FINDFIRST THEN BEGIN
                        //IF REPORT.SAVEASPDF(50170, FileName, PH) THEN BEGIN
                        // IF REPORT.SAVEASPDF(50170, ServerTempFile, PH) THEN BEGIN
                        //FileMgmt.DownloadToFile(ServerTempFile,FileName); //copy to my network folder
                        IF DIALOG.CONFIRM('Do you want to send email to the vendor') THEN BEGIN
                            UserSetupRec.RESET;
                            IF UserSetupRec.GET(USERID) THEN;
                            RecVend.RESET;
                            IF RecVend.GET(rec."Buy-from Vendor No.") THEN BEGIN
                                RecVend.TESTFIELD("E-Mail");
                                VendorEmail := RecVend."E-Mail";
                            END;

                            //RSPLSUM02Apr21--SMTPMail.CreateMessage('',UserSetupRec."E-Mail",VendorEmail,'Purchase Order - GST LOGO','',TRUE);
                            // SMTPMail.CreateMessage('', SMTPMailSetup."User ID", VendorEmail, 'Purchase Order - GST LOGO', '', TRUE);//RSPLSUM02Apr21
                            EmailMsg.Create(VendorEmail, 'Purchase Order - GST LOGO', '', TRUE);


                            RecSalesperPurchaser.RESET;
                            IF RecSalesperPurchaser.GET(rec."Purchaser Code") THEN BEGIN
                                IF RecSalesperPurchaser."E-Mail" <> '' THEN
                                    // SMTPMail.AddCC(RecSalesperPurchaser."E-Mail");
                                    EmailMsg.AddRecipient(RecipientType::"Cc", RecSalesperPurchaser."E-Mail");
                            END;

                            EmailMsg.AppendToBody('Dear Sir/Madam,');
                            EmailMsg.AppendToBody('<br><br>');
                            EmailMsg.AppendToBody('Please find attached Purchase Order - GST LOGO.');
                            EmailMsg.AppendToBody('<br><br>');
                            EmailMsg.AppendToBody('<HR>');
                            EmailMsg.AppendToBody('This is a system generated mail.');

                            // SMTPMail.AddAttachment(ServerTempFile, 'Purchase Order - GST LOGO.pdf');
                            EmailMsg.AddAttachment('Purchase Order - GST LOGO.pdf', ServerTempFile, Instr);
                            // SMTPMail.Send;
                            EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);

                            //FileMgmt.DownloadToFile(ServerTempFile,FileName); //copy to my network folder
                            MESSAGE(EmailSent);
                        END;
                        //ERASE(FileName);
                    END ELSE
                        ERROR('Error while saving report as PDF');
                END;


            }

        }



    }
    trigger OnOpenPage()
    var
        myInt: Integer;

    BEGIN
        CLEAR(FieldEdtiable);
        CLEAR(FieldEdtiable1);
        //EBT STIVAN ---(29012013)--- A new Role has been created,as per the role the Blanket Order Form will get Editable ----START
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETRANGE("Role ID", 'BLANKET PURCH. ORDER');
        IF AccessControl.FINDFIRST THEN BEGIN
            FieldEdtiable := TRUE;
            CurrPage.EDITABLE(TRUE);
            //        {
            //        CurrForm."Buy-from Vendor No.".EDITABLE := TRUE;
            // CurrForm.Structure.EDITABLE := TRUE;
            // CurrForm."Buy-from Contact".EDITABLE := TRUE;
            // CurrForm."Order Date".EDITABLE := TRUE;
            // CurrForm."Document Date".EDITABLE := TRUE;
            // CurrForm."Vendor Order No.".EDITABLE := TRUE;
            // CurrForm."Vendor Shipment No.".EDITABLE := TRUE;
            // CurrForm."Order Address Code".EDITABLE := TRUE;
            // CurrForm."Purchaser Code".EDITABLE := TRUE;
            // CurrForm."Responsibility Center".EDITABLE := TRUE;
            // CurrForm."Assigned User ID".EDITABLE := TRUE;
            // CurrForm."Pay-to Vendor No.".EDITABLE := TRUE;
            // CurrForm."Pay-to Contact".EDITABLE := TRUE;
            // CurrForm."Shortcut Dimension 1 Code".EDITABLE := TRUE;
            // CurrForm."Shortcut Dimension 2 Code".EDITABLE := TRUE;
            // CurrForm."Payment Terms Code".EDITABLE := TRUE;
            // CurrForm."Due Date".EDITABLE := TRUE;
            // CurrForm."Payment Discount %".EDITABLE := TRUE;
            // CurrForm."Pmt. Discount Date".EDITABLE := TRUE;
            // CurrForm."Payment Method Code".EDITABLE := TRUE;
            // CurrForm."On Hold".EDITABLE := TRUE;
            // CurrForm."Prices Including VAT".EDITABLE := TRUE;
            // CurrForm."Location Code".EDITABLE := TRUE;
            // CurrForm."Shipping Agent Code".EDITABLE := TRUE;
            // CurrForm."Shipment Method Code".EDITABLE := TRUE;
            // CurrForm."Promised Receipt Date".EDITABLE := TRUE;
            // CurrForm."Transit Document".EDITABLE := TRUE;
            // CurrForm."Currency Code".EDITABLE := TRUE;
            // CurrForm."Transaction Type".EDITABLE := TRUE;
            // CurrForm."Transaction Specification".EDITABLE := TRUE;
            // CurrForm."Transport Method".EDITABLE := TRUE;
            // CurrForm."Entry Point".EDITABLE := TRUE;
            // CurrForm.Area.EDITABLE := TRUE;
            // CurrForm."GTA Service Type".EDITABLE := TRUE;
            // CurrForm."Consignment Note No.".EDITABLE := TRUE;
            // CurrForm."Declaration Form (GTA)".EDITABLE := TRUE;
            // CurrForm."Input Service Distribution".EDITABLE := TRUE;
            // CurrForm."Manufacturer E.C.C. No.".EDITABLE := TRUE;
            // CurrForm."Manufacturer Name".EDITABLE := TRUE;
            // CurrForm."Manufacturer Address".EDITABLE := TRUE;
            // CurrForm."Freight Charges".EDITABLE := TRUE;
            // CurrForm."C Form".EDITABLE := TRUE;
            // CurrForm."Form Code".EDITABLE := TRUE;
            // CurrForm."Form No.".EDITABLE := TRUE;
            // CurrForm."LC No.".EDITABLE := TRUE;
            // CurrForm.Trading.EDITABLE := TRUE;
            // CurrForm."Vendor TIN No.".EDITABLE := TRUE;
            // CurrForm."Applies-to Doc. Type".EDITABLE := TRUE;
            // CurrForm."Applies-to Doc. No.".EDITABLE := TRUE;
            // CurrForm."Applies-to ID".EDITABLE := TRUE;
            // CurrForm."Paid Amount".EDITABLE := TRUE;
            // CurrForm."Paid Cheque No.".EDITABLE := TRUE;
            // CurrForm."Paid Cheque Date".EDITABLE := TRUE;
            //        }

        END ELSE
            //CurrPage.EDITABLE(FALSE);
            FieldEdtiable := FALSE;
        //EBT STIVAN ---(29012013)--- A new Role has been created,as per the role the Blanket Order Form will get Editable ------END

        //          {
        //          //EBT STIVAN ---(03042013)--- As per Role,the Closed Field on Blanket Order Form will get Editable ----START
        //          Memberof.RESET;
        // Memberof.SETRANGE(Memberof."User ID", USERID);
        // Memberof.SETFILTER(Memberof."Role ID", '%1', 'POSHORTCLOSE');
        // IF Memberof.FINDFIRST THEN BEGIN }
        //>>RSPL/Migration/Rahul

        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETFILTER("Role ID", '%1', 'POSHORTCLOSE');
        IF AccessControl.FINDFIRST THEN BEGIN
            FieldEdtiable1 := TRUE;
        END;
        //UnCommented 25July2017

        //          {
        //          //EBT STIVAN ---(03042013)--- As per Role,the Closed Field on Blanket Order Form will get Editable ------END

        //          IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
        //     FILTERGROUP(2);
        //     SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
        //     FILTERGROUP(0);
        // END;

        // //          { // Commented by milan
        // //          // EBT MILAN 240114 ADDED TO Show only User Location----------------------START
        // //          CSOmapping.RESET;
        // // CSOmapping.SETRANGE(CSOmapping.Type, CSOmapping.Type::Location);
        // // CSOmapping.SETRANGE(CSOmapping."User Id", UPPERCASE(USERID));
        // // IF CSOmapping.FINDFIRST THEN BEGIN
        // //     FILTERGROUP(2);
        // //     SETRANGE("Location Code", CSOmapping.Value);
        // //     FILTERGROUP(0);
        // // END;
        // //          // EBT MILAN 240114 ADDED TO Show only User Location------------------------END
        // //          }
        // IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
        //     FILTERGROUP(2);
        //     SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter);
        //     FILTERGROUP(0);
        // END;
        //          }
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    BEGIN
        //>> RB-N 16Nov2017 Page Editable
        IF rec.Status = rec.Status::Released THEN BEGIN
            User15.RESET;
            User15.SETRANGE("User ID", USERID);
            User15.SETRANGE("PO Creation", TRUE);
            IF User15.FINDFIRST THEN BEGIN
                CurrPage.EDITABLE(TRUE);
                FieldEdtiable := TRUE;
                FieldEdtiable1 := TRUE;
                //MESSAGE('Editable %1',USERID);
            END ELSE BEGIN
                //CurrPage.EDITABLE(FALSE);
                FieldEdtiable := FALSE;
                FieldEdtiable1 := FALSE;
                //MESSAGE('Non Editable %1',USERID);
            END;
        END;
        //<< RB-N 16Nov2017 Page Editable

        //>>06May2019
        FinRemarksEdit := FALSE;
        UserSetup05.RESET;
        UserSetup05.SETRANGE("User ID", USERID);
        UserSetup05.SETRANGE("Finance Approver", TRUE);
        IF UserSetup05.FINDFIRST THEN
            FinRemarksEdit := TRUE;
        IF rec."Approved by Finance" THEN
            FinRemarksEdit := FALSE;
        //<<06May2019
    END;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    BEGIN
        rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        rec."Blanket Order Creation Date" := TODAY;//RSPLSUM 16Apr2020
        rec."Created By" := USERID;//RSPLSUM 16Apr2020
    END;

    var
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        cduArchveMgmt: Codeunit ArchiveManagement;
        FieldEdtiable1: Boolean;
        PurchLine: Record 39;
        AccessContro: Record 2000000053;
        FieldEdtiabl: Boolean;
        FieldEdtiable: Boolean;
        CSOmappin: Record 50006;
        recPurchLin: Record 39;
        recItem: Record 27;
        cduArchveMgm: Codeunit 5063;
        OrderAddress: Record 224;
        Vendor: Record 23;

        RecPurchheader: Record 38;
        "---05Aug2017": Integer;
        Ord05: Record 224;
        Ven05: Record 23;
        "------------15Nov2017": Integer;
        User15: Record 91;
        "-----------------06Feb2018---ApprovalProcess": Integer;
        TempVersionNo: Integer;


        SAE11: Record 50009;
        SalesApproval: Record 50008;
        SalesApprovalEntry: Record 50009;
        LimitAmt06: Decimal;
        User06: Record 2000000120;
        UserName06: Text;
        PL06: Record 39;
        AppPage: Page 50010;
        Text001: Label 'ENU=First Level Approval , Do you want to Approve.';
        Text002: Label 'ENU=Final Approval, Do you want to Approve.';
        PurPay: Record 312;
        TempSeqNo: Integer;
        UserSetup05: Record 91;
        FinRemarksEdit: Boolean;
        RecNoSeries: Record 308;
        // SMTPMailSetup: Record 409;
        AccessControl: Record 2000000053;
        recPurchLine: Record 39;


    PROCEDURE EmailNotification(DocType: option "Sales Order","Blanket PO"; DocNo: Code[20]; SeqNo: Integer; SenderID: Code[50]; ReceiveID: Code[50]; FirstID: Code[50]);
    VAR
        // SMTPMail: Codeunit 400;
        EmailMsg: Codeunit "Email Message";
        EmailObj: Codeunit Email;
        RecipientType: Enum "Email Recipient Type";

        SAE18: Record 50009;
        SA18: Record 50008;
        SubjectText: Text;
        User18: Record 91;
        SenderName: Text;
        SenderEmail: Text;
        ReceiveEmail: Text;
        Text18: Text;
        Cust18: Record 23;
        OtAmt: Decimal;
        CrAmt: Decimal;
    BEGIN
        // SMTPMailSetup.GET;//RSPLSUM01Apr21

        SubjectText := '';
        SenderName := '';
        SenderEmail := '';
        ReceiveEmail := '';
        Text18 := '';
        CLEAR(EmailMsg);

        //>>SenderID
        User18.RESET;
        IF User18.GET(SenderID) THEN BEGIN
            User18.TESTFIELD("E-Mail");
            SenderEmail := User18."E-Mail";
            IF User18.Name <> '' THEN
                SenderName := User18.Name
            ELSE
                SenderName := SenderID;

            ReceiveEmail := SenderEmail;
        END;
        //<<SenderID

        IF SeqNo = 1 THEN BEGIN
            //RSPLSUM21Apr21--SubjectText := 'Microsoft Dynamics NAV: Approval Mail';
            SubjectText := 'Microsoft Dynamics NAV: ' + rec."No." + ' required L1 Approval';//RSPLSUM21Apr21
            Text18 := 'Requires Approval.';
        END;

        IF SeqNo = 2 THEN BEGIN
            // SubjectText := 'Microsoft Dynamics NAV: Approved Mail';
            //Text18  := 'has been Approved.';
            SubjectText := 'Microsoft Dynamics NAV: Approval Mail';
            Text18 := 'Requires Finance Approval.';
        END;

        IF SeqNo = 3 THEN BEGIN
            //RSPLSUM21Apr21--SubjectText := 'Microsoft Dynamics NAV: Credit Limit Approval Mail';
            SubjectText := 'Microsoft Dynamics NAV: ' + rec."No." + ' required L2 Approval';//RSPLSUM21Apr21
            Text18 := 'Requires Level2 Approval.';
        END;

        IF SeqNo = 4 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Over Due Approval Mail';
            Text18 := 'Over Due Approval.';
        END;

        IF SeqNo = 5 THEN BEGIN
            //RSPLSUM21Apr21--SubjectText := 'Microsoft Dynamics NAV: Approved Mail';
            SubjectText := 'Microsoft Dynamics NAV: ' + rec."No." + ' has been Approved';//RSPLSUM21Apr21
            Text18 := 'has been Approved.';
        END;

        IF SeqNo = 6 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Rejection Mail';
            Text18 := 'Finance Rejection.';
        END;

        //>>CreditLimit
        CLEAR(OtAmt);
        Cust18.RESET;
        IF Cust18.GET(rec."Buy-from Vendor No.") THEN BEGIN
            Cust18.CALCFIELDS("Balance (LCY)");
            OtAmt := Cust18."Balance (LCY)";
        END;
        //<<CreditLimit

        //>>Email Body
        //RSPLSUM02Apr21--SMTPMail.CreateMessage(SenderName,SenderEmail,ReceiveEmail,SubjectText,'',TRUE);
        // SMTPMail.CreateMessage(SenderName, SMTPMailSetup."User ID", ReceiveEmail, SubjectText, '', TRUE);//RSPLSUM02Apr21
        EmailMsg.Create(ReceiveEmail, SubjectText, '', TRUE);
        IF SeqNo = 1 THEN BEGIN
            SA18.RESET;
            SA18.SETCURRENTKEY("Document Type");
            SA18.SETRANGE("Document Type", DocType);
            SA18.SETRANGE("User ID", SenderID);
            IF SA18.FINDSET THEN
                REPEAT
                    //>>Level1 Approvar
                    User18.RESET;
                    User18.SETRANGE("User ID", SA18."Approvar ID");
                    IF User18.FINDFIRST THEN BEGIN
                        User18.TESTFIELD("E-Mail");
                        ///  SMTPMail.AddRecipients(User18."E-Mail");
                        EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                    END;
                    //>>Level1 Approvar

                    //>>Level2 Approvar
                    IF SA18."Level2 Approvar ID" <> '' THEN BEGIN
                        User18.RESET;
                        User18.SETRANGE("User ID", SA18."Level2 Approvar ID");
                        IF User18.FINDFIRST THEN BEGIN
                            User18.TESTFIELD("E-Mail");
                            // SMTPMail.AddRecipients(User18."E-Mail");
                            EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                        END;
                    END;
                //>>Level2 Approvar

                UNTIL SA18.NEXT = 0;
        END;

        IF SeqNo = 2 THEN BEGIN
            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", rec."No.");
            SAE18.SETRANGE("Approvar ID", SenderID);
            SAE18.SETRANGE(Approved, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                User18.RESET;
                User18.SETRANGE("User ID", SAE18."User ID");
                IF User18.FINDFIRST THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    // SMTPMail.AddRecipients(User18."E-Mail");
                    EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");

                    SA18.RESET;
                    SA18.SETCURRENTKEY("Document Type");
                    SA18.SETRANGE("Document Type", DocType);
                    SA18.SETRANGE("User ID", SAE18."User ID");
                    SA18.SETFILTER("Approvar ID", '<>%1', SenderID);
                    IF SA18.FINDSET THEN
                        REPEAT
                            //>>Level1 Approvar
                            User18.RESET;
                            User18.SETRANGE("User ID", SA18."Approvar ID");
                            IF User18.FINDFIRST THEN BEGIN
                                User18.TESTFIELD("E-Mail");
                                //   SMTPMail.AddRecipients(User18."E-Mail");
                                EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                            END;
                            //>>Level1 Approvar

                            //>>Level2 Approvar
                            IF SA18."Level2 Approvar ID" <> '' THEN BEGIN
                                User18.RESET;
                                User18.SETRANGE("User ID", SA18."Level2 Approvar ID");
                                IF User18.FINDFIRST THEN BEGIN
                                    User18.TESTFIELD("E-Mail");
                                    // SMTPMail.AddRecipients(User18."E-Mail");
                                    EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                                END;
                            END;
                        //>>Level2 Approvar
                        UNTIL SA18.NEXT = 0;

                    IF FirstID <> '' THEN //Not Direct Approval
                    BEGIN
                        SA18.RESET;
                        SA18.SETCURRENTKEY("Document Type");
                        SA18.SETRANGE("Document Type", DocType);
                        SA18.SETRANGE("User ID", SAE18."User ID");
                        SA18.SETFILTER(SA18."Level2 Approvar ID", '<>%1', '');
                        IF SA18.FINDSET THEN
                            REPEAT
                                User18.RESET;
                                User18.SETRANGE("User ID", SA18."Level2 Approvar ID");
                                IF User18.FINDFIRST THEN BEGIN
                                    User18.TESTFIELD("E-Mail");
                                    // SMTPMail.AddRecipients(User18."E-Mail");
                                    EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                                END;
                            UNTIL SA18.NEXT = 0;
                    END;
                END;
            END;
            // {
            // //>>05May2019
            // UserSetup05.RESET;
            // UserSetup05.SETRANGE("Finance Approver",TRUE);
            // IF UserSetup05.FINDSET THEN
            // REPEAT
            //   UserSetup05.TESTFIELD("E-Mail");
            //   SMTPMail.AddRecipients(UserSetup05."E-Mail");
            // UNTIL UserSetup05.NEXT = 0;
            // //<<05May2019
            // }//Code Commented 19Jun2019
        END;

        IF (SeqNo = 3) THEN BEGIN
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
                    //  EmailMsg.AddRecipients(User18."E-Mail");
                    EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");

                END;

                User18.RESET;
                User18.SETRANGE("User ID", SAE18."Approvar ID");
                IF User18.FINDFIRST THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    //  SMTPMail.AddRecipients(User18."E-Mail");
                    EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                END;

                SA18.RESET;
                SA18.SETCURRENTKEY("Document Type");
                SA18.SETRANGE("Document Type", DocType);
                SA18.SETRANGE("User ID", SAE18."User ID");
                SA18.SETFILTER(SA18."Level2 Approvar ID", '<>%1', SenderID);
                IF SA18.FINDSET THEN
                    REPEAT
                        User18.RESET;
                        User18.SETRANGE("User ID", SA18."Level2 Approvar ID");
                        IF User18.FINDFIRST THEN BEGIN
                            User18.TESTFIELD("E-Mail");
                            //  SMTPMail.AddRecipients(User18."E-Mail");
                            EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                        END;
                    UNTIL SA18.NEXT = 0;
            END;
        END;

        //>>06May2019
        IF (SeqNo = 5) OR (SeqNo = 6) THEN BEGIN
            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document No.", "Version No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", rec."No.");
            SAE18.SETRANGE(Approved, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                User18.RESET;
                User18.SETRANGE("User ID", SAE18."User ID");
                IF User18.FINDFIRST THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    // SMTPMail.AddRecipients(User18."E-Mail");
                    EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");

                END;

                User18.RESET;
                User18.SETRANGE("User ID", SAE18."Approvar ID");
                IF User18.FINDFIRST THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    //  SMTPMail.AddRecipients(User18."E-Mail");
                    EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                END;
            END;
        END;
        //<<06May2019

        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<B> Microsoft Dynamics NAV Document Approval System </B>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br> <B> Blanket Purchase Order No.  - </B>' + '<B>' + rec."No." + '</B>' + ' ' + Text18);
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Table  Border="1">');//Table Start
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Company Name </th>');
        EmailMsg.AppendToBody('<td>' + COMPANYNAME + '</td>');
        EmailMsg.AppendToBody('</tr>');
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Amount (LCY) </th>');
        // rec.CALCFIELDS("Amount to Vendor");
        // EmailMsg.AppendToBody('<td>' + FORMAT(rec."Amount to Vendor", 0, '<Integer Thousand><Decimals,3>') + '</td>');
        EmailMsg.AppendToBody('</tr>');
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Vendor</th>');
        EmailMsg.AppendToBody('<td>' + rec."Buy-from Vendor No." + '  ' + rec."Buy-from Vendor Name" + '</td>');
        EmailMsg.AppendToBody('</tr>');
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Due Date </th>');
        EmailMsg.AppendToBody('<td>' + FORMAT(rec."Due Date") + '</td>');
        EmailMsg.AppendToBody('</tr>');
        //>>05May2019
        IF SeqNo = 6 THEN BEGIN
            EmailMsg.AppendToBody('<tr>');
            EmailMsg.AppendToBody('<th>Finance Rejection Remarks</th>');
            EmailMsg.AppendToBody('<td>' + rec."Finance Rejection Remarks" + '</td>');
            EmailMsg.AppendToBody('</tr>');
        END;
        //<<05May2019
        EmailMsg.AppendToBody('</table>');//Table End
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        //  SMTPMail.Send;
        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        //<<Email Body
    END;
}