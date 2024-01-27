pageextension 50068 SalesReturnOrderExt extends "Sales Return Order"
{
    layout
    {
        // Add changes to page layout here
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                //>>RB-N 08Jan2018
                IF rec."Sell-to Customer No." <> '' THEN BEGIN
                    Cust08.RESET;
                    IF Cust08.GET(rec."Sell-to Customer No.") THEN BEGIN
                        Cust08.TESTFIELD(Blocked, Cust08.Blocked::" ");
                    END;
                END;
                //<<RB-N 08Jan2018
            end;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                //RSPLSUM 10Jun2020>>
                IF rec."Shortcut Dimension 1 Code" = 'DIV-14' THEN BEGIN
                    IF rec."Posting Date" < rec."Shipment Date" THEN
                        ERROR('Please enter date greater than or equal to shipment date');
                END;
                //RSPLSUM 10Jun2020<<
            END;
        }
        modify("Applies-to Doc. Type")
        {
            ApplicationArea = all;
            Importance = Promoted;
            trigger OnAfterValidate()
            var
                myInt: Integer;
            BEGIN
                rec.SETRANGE("Cancelled Invoice", FALSE);
            END;

        }
        modify("Applies-to Doc. No.")
        {
            ApplicationArea = all;
            Importance = Promoted;
            Editable = TRUE;
            trigger OnAfterValidate()
            var
                recSIH: Record 112;
            BEGIN
                rec.SETRANGE("Cancelled Invoice", FALSE);
                //EBT STIVAN (13092012)--- To Capture the Applies To Document Nos Date -------------START
                recSIH.RESET;
                recSIH.SETRANGE(recSIH."No.", rec."Applies-to Doc. No.");
                IF recSIH.FINDFIRST THEN BEGIN
                    AppliedDocDate := recSIH."Posting Date";
                END ELSE
                    AppliedDocDate := 0D;
                //EBT STIVAN (13092012)--- To Capture the Applies To Document Nos Date ---------------END

                //              {
                //              SROMonthName := FORMAT("Posting Date", 0, '<Month Text> <Year4>');
                // InvMonthName := FORMAT(AppliedDocDate, 0, '<Month Text> <Year4>');


                // //EBT STIIVAN---(18012013)---Dialog Box Pop UP on SRO whether the Invoice is Cancelled---START
                // IF TODAY <> AppliedDocDate THEN BEGIN
                //     IF HideValidationDialog OR NOT GUIALLOWED THEN
                //         confirmed := TRUE
                //     ELSE
                //         confirmed := CONFIRM('Is it Cancel Invoice ?', FALSE);


                //     IF (confirmed) AND (SROMonthName = InvMonthName) THEN BEGIN
                //         "Cancelled Invoice" := TRUE;
                //         "Posting No. Series" := 'CINV SALE';
                //     END;

                //     IF (confirmed) AND NOT (SROMonthName = InvMonthName) THEN BEGIN
                //         "Cancelled Invoice" := FALSE;
                //         MESSAGE('You can not Cancel the Invoice which is not of the same month');
                //     END;

                //     IF NOT confirmed THEN BEGIN
                //         "Cancelled Invoice" := FALSE;
                //     END;

                // END;
                //              //EBT STIIVAN---(18012013)---Dialog Box Pop UP on SRO whether the Invoice is Cancelled-----END
                //              }
            END;
        }
        // modify("Applies to Doc. Date")
        // {
        //     trigger OnAfterAction()
        //     var
        //         myInt: Integer;
        //     begin

        //     end;
        // }
        modify("Payment Method Code")
        {
            ApplicationArea = all;
        }
        modify("Payment Terms Code")
        {
            ApplicationArea = all;
        }
        modify("Tax Area Code")
        {
            ApplicationArea = ALL;
        }
        // modify("Applies-to ID")
        // {
        //     ApplicationArea = ALL;
        //     trigger OnAfterValidate()
        //     var
        //         myInt: Integer;
        //     BEGIN
        //         REC.SETRANGE("Cancelled Invoice", FALSE);
        //     END;
        // }

        addafter("Sell-to Address")
        {
            field("Cancelled Invoice"; Rec."Cancelled Invoice")
            {
                ApplicationArea = all;
            }
            field("Last Year Sales Return"; Rec."Last Year Sales Return")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    //EBT STIVAN ---(20072012)--- To make the Location Code Editable if its Last Year Sale Return -----START
                    IF REC."Last Year Sales Return" = TRUE THEN
                        //CurrForm."Location Code".EDITABLE := TRUE
                        LocationCodeEditable := TRUE //RSPL-TC
                    ELSE
                        //CurrForm."Location Code".EDITABLE := FALSE;
                        LocationCodeEditable := FALSE; //RSPL-TC
                                                       //EBT STIVAN ---(20072012)--- To make the Location Code Editable if its Last Year Sale Return -----START
                END;

            }
            field("Short Close"; Rec."Short Close")
            {
                ApplicationArea = all;
                Editable = ShortcloseEdtiable;
            }
            field("Created Date"; Rec."Created Date")
            {
                ApplicationArea = all;
            }
            field("Approval Description"; Rec."Approval Description")
            {
                ApplicationArea = all;
            }
            // field("Tax Area Code"; Rec."Tax Area Code")
            // {
            //     ApplicationArea = ALL;
            // }

            // field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
            // {
            //     ApplicationArea = all;
            //     Importance = Promoted;
            //     trigger OnValidate()
            //     var
            //         myInt: Integer;
            //     BEGIN
            //         rec.SETRANGE("Cancelled Invoice", FALSE);
            //     END;

            // }

            field(AppliedDocDate; AppliedDocDate)
            {
                ApplicationArea = ALL;
                Caption = 'Applies to Doc. Date';
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    REC.SETRANGE("Cancelled Invoice", FALSE);

                    //RSPL-PARAG 15.12.2017
                    GSTCust := 20170630D;/*300617D*/

                    IF (AppliedDocDate < GSTCust) THEN
                        GSTCustTypeBoolean := TRUE;
                    //RSPL-PARAG 15.12.2017
                END;
            }
            field("Applies-to ID1"; Rec."Applies-to ID")
            {
                ApplicationArea = ALL;
                trigger OnValidate()
                var
                    myInt: Integer;
                BEGIN
                    REC.SETRANGE("Cancelled Invoice", FALSE);
                END;
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = ALL;
            }
            FIELD("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = ALL;
            }
            field(FOC; Rec.FOC)
            {
                ApplicationArea = ALL;
            }

            // field("Payment Method Code"; Rec."Payment Method Code")
            // {
            //     ApplicationArea = ALL;
            // }
            // field("Payment Terms Code"; Rec."Payment Terms Code")
            // {
            //     ApplicationArea = ALL;
            // }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Print")
        {
            action("Structure Header Details")
            {
                ApplicationArea = all;
                //RunObject = Page 50054;
                // RunPageLink = Type = CONST(Sale),
                //                   "Document Type" = FIELD("Document Type"),
                //                   "Document No." = FIELD("No."),
                //                   "Structure Code" = FIELD(Structure),
                //                   "Document Line No." = FILTER(0),
                //                   "Header/Line" = CONST(Header)
            }
        }
        addafter(Approvals)
        {
            action("Send For Authorization")
            {
                ApplicationArea = all;
                Image = Change;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN

                    rec.TESTFIELD("Campaign No.", '');
                    rec.TESTFIELD("Location Code");
                    rec.TESTFIELD("Payment Terms Code");
                    rec.TESTFIELD("Payment Method Code");

                    SL01.RESET;
                    SL01.SETRANGE("Document Type", rec."Document Type");
                    SL01.SETRANGE("Document No.", rec."No.");
                    SL01.SETRANGE("Location Code", rec."Location Code");
                    IF NOT SL01.FINDFIRST THEN
                        ERROR('Location Code in Sales CrMemo Lines are differnet from header Level');

                    SL01.RESET;
                    SL01.SETRANGE("Document Type", rec."Document Type");
                    SL01.SETRANGE("Document No.", rec."No.");
                    IF NOT SL01.FINDFIRST THEN
                        ERROR('No Sales Credit Memo Line Found');

                    SL01.RESET;
                    SL01.SETRANGE("Document Type", rec."Document Type");
                    SL01.SETRANGE("Document No.", rec."No.");
                    SL01.CALCSUMS(Quantity);
                    IF SL01.Quantity = 0 THEN
                        ERROR('Please enter No. of Qty');

                    IF NOT rec."Sent For Approval" THEN BEGIN

                        TempVersionNo := 0;
                        SAE01.RESET;
                        SAE01.SETCURRENTKEY("Document No.", "Version No.");
                        SAE01.SETRANGE("Document Type", 8);
                        SAE01.SETRANGE("Document No.", rec."No.");
                        IF SAE01.FINDLAST THEN
                            TempVersionNo := SAE01."Version No." + 1
                        ELSE
                            TempVersionNo := 1;

                        SA01.RESET;
                        SA01.SETRANGE("Document Type", 8);
                        SA01.SETRANGE("User ID", USERID);
                        SA01.SETFILTER("Approvar ID", '<>%1', '');
                        IF SA01.FINDSET THEN BEGIN
                            TempSeqNo := 0;
                            REPEAT
                                TempSeqNo += 1;
                                SalesApprovalEntry.INIT;
                                SalesApprovalEntry."Document Type" := SalesApprovalEntry."Document Type"::SalesReturnOrder;
                                SalesApprovalEntry."Document No." := rec."No.";
                                SalesApprovalEntry."User ID" := USERID;
                                SalesApprovalEntry."User Name" := SA01.Name;
                                SalesApprovalEntry."Approvar ID" := SA01."Approvar ID";
                                SalesApprovalEntry."Approver Name" := SA01."Approvar Name";
                                SalesApprovalEntry."Mandatory ID" := SA01.Mandatory;
                                SalesApprovalEntry."Date Sent for Approval" := TODAY;
                                SalesApprovalEntry."Time Sent for Approval" := TIME;
                                SalesApprovalEntry."Version No." := TempVersionNo;
                                SalesApprovalEntry."Sequence No." := TempSeqNo;
                                SalesApprovalEntry.INSERT;
                            UNTIL SA01.NEXT = 0;

                            //>>Email Notification
                            SRSetup.GET;
                            IF SRSetup."Email Alert On SalesReturn" THEN
                                EmailNotification(8, rec."No.", 1, USERID, '', '');
                            //>>Email Notification
                            MESSAGE('Document No. %1 has been sent for Approval', rec."No.");
                        END
                        ELSE
                            ERROR('Sales Return Approval setup does not exists for User %1', USERID);
                    END
                    ELSE
                        ERROR('Document No. %1 has already been sent for approval');

                    rec."Sent For Approval" := TRUE;
                    rec."Campaign No." := 'Pending for Approval';
                    rec.Status := rec.Status::"Pending Approval";
                    rec.MODIFY;
                END;
            }
            action("Level1 Approval")
            {
                ApplicationArea = all;
                Image = Approval;
                trigger OnAction()

                VAR
                    ArchiveManagement: Codeunit 5063;
                    ReleaseSalesDoc: Codeunit 414;
                BEGIN

                    //>>User Approval Validation
                    SA01.RESET;
                    SA01.SETCURRENTKEY("Document Type");
                    SA01.SETRANGE("Document Type", 8);
                    SA01.SETRANGE("Approvar ID", USERID);
                    IF NOT SA01.FINDFIRST THEN
                        ERROR('You donot have rights to Approve, Please Contact System Administrator');
                    //<<User Approval Validation

                    rec.TESTFIELD("Campaign No.", 'Pending For Approval');

                    IF NOT CONFIRM('First Level Approval , Do you want to Approve.', FALSE) THEN
                        EXIT;

                    SalesApprovalEntry.RESET;
                    SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                    SalesApprovalEntry.SETRANGE("Document Type", 8);
                    SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                    SalesApprovalEntry.SETRANGE("Approvar ID", USERID);
                    IF SalesApprovalEntry.FINDLAST THEN BEGIN
                        SalesApprovalEntry.Approved := TRUE;
                        SalesApprovalEntry."Approval Date" := TODAY;
                        SalesApprovalEntry."Approval Time" := TIME;
                        SalesApprovalEntry.MODIFY;
                    END ELSE
                        ERROR('%1 User Not found for the Level 1 Approver', USERID);
                    //>>Email Notification
                    SRSetup.GET;
                    IF SRSetup."Email Alert On SalesReturn" THEN
                        EmailNotification(8, rec."No.", 4, USERID, '', '');
                    //>>Email Notification

                    ReleaseSalesDoc.PerformManualRelease(Rec);

                    rec."Campaign No." := 'Pending L2 Approval';
                    rec."Credit Approval" := FALSE;
                    rec.MODIFY;

                    //>>
                    SAE17.RESET;
                    SAE17.SETCURRENTKEY("Document Type", "Document No.");
                    SAE17.SETRANGE("Document Type", 8);
                    SAE17.SETRANGE("Document No.", SalesApprovalEntry."Document No.");
                    SAE17.SETRANGE("Version No.", SalesApprovalEntry."Version No.");
                    SAE17.SETRANGE(Approved, FALSE);
                    IF SAE17.FINDFIRST THEN BEGIN
                        SAE17.DELETEALL(TRUE);
                    END;
                    ArchiveManagement.ArchiveSalesDocument(Rec);
                    CurrPage.UPDATE(FALSE);
                END;
            }
            action("Level2 Approval")
            {
                ApplicationArea = all;
                Image = Approval;
                trigger OnAction()

                VAR
                    ArchiveManagement: Codeunit 5063;
                    ReleaseSalesDoc: Codeunit 414;
                BEGIN

                    //>>User Approval Validation
                    SA01.RESET;
                    SA01.SETCURRENTKEY("Document Type");
                    SA01.SETRANGE("Document Type", 8);
                    SA01.SETRANGE("Level2 Approvar ID", USERID);
                    IF NOT SA01.FINDFIRST THEN
                        ERROR('You donot have rights to Approve, Please Contact System Administrator');
                    //<<User Approval Validation

                    rec.TESTFIELD("Campaign No.", 'Pending L2 Approval');

                    IF rec."Credit Approval" THEN
                        ERROR('Document is Not approved from Level 1');

                    IF NOT CONFIRM('Final Approval, Do you want to Approve.', FALSE) THEN
                        EXIT;

                    SalesApprovalEntry.RESET;
                    SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.", "Version No.");
                    SalesApprovalEntry.SETRANGE("Document Type", 8);
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
                        SalesApprovalEntry."Approval Date" := TODAY;
                        SalesApprovalEntry."Approval Time" := TIME;
                        SalesApprovalEntry.MODIFY;
                    END;

                    //>>Email Notification
                    SRSetup.GET;
                    IF SRSetup."Email Alert On SalesReturn" THEN
                        EmailNotification(8, rec."No.", 2, USERID, '', '');
                    //>>Email Notification

                    //ReleaseSalesDoc.PerformManualRelease(Rec);
                    rec."Campaign No." := 'Approved';
                    rec."Credit Approval" := TRUE;
                    rec.MODIFY;
                    MESSAGE('Approved');

                    //  {
                    //  //>>
                    //  SAE17.RESET;
                    //  SAE17.SETCURRENTKEY("Document Type","Document No.");
                    //  SAE17.SETRANGE("Document Type",8);
                    //  SAE17.SETRANGE("Document No.",SalesApprovalEntry."Document No.");
                    //  SAE17.SETRANGE("Version No.",SalesApprovalEntry."Version No.");
                    //  SAE17.SETRANGE(Approved,FALSE);
                    //  IF SAE17.FINDFIRST THEN
                    //  BEGIN
                    //    SAE17.DELETEALL(TRUE);
                    //  END;

                    //  ArchiveManagement.ArchiveSalesDocument(Rec);
                    //  CurrPage.UPDATE(FALSE);
                    //  }
                END;
            }
            action("Rejection")
            {
                ApplicationArea = all;
                Image = Reject;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN

                    SA01.RESET;
                    SA01.SETCURRENTKEY("Document Type");
                    SA01.SETRANGE("Document Type", 8);
                    SA01.SETRANGE("Approvar ID", USERID);
                    IF NOT SA01.FINDFIRST THEN
                        ERROR('You donot have rights to Reject, Please Contact System Administrator');

                    rec.TESTFIELD("Campaign No.", 'Pending For Approval');
                    rec.TESTFIELD("Approval Description");

                    //>>Reject Process
                    SalesApprovalEntry.RESET;
                    SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                    SalesApprovalEntry.SETRANGE("Document Type", 8);
                    SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                    SalesApprovalEntry.SETRANGE("Approvar ID", USERID);
                    IF SalesApprovalEntry.FINDLAST THEN BEGIN

                        SalesApprovalEntry.Rejected := TRUE;
                        SalesApprovalEntry."Rejected Date" := TODAY;
                        SalesApprovalEntry."Rejected Time" := TIME;
                        SalesApprovalEntry.MODIFY;

                        rec."Sent For Approval" := FALSE;
                        rec."Campaign No." := '';
                        rec.Status := rec.Status::Open;
                        rec.MODIFY(TRUE);

                        //>>EmailNotification
                        SRSetup.GET;
                        IF SRSetup."Email Alert On SalesReturn" THEN
                            EmailNotification(8, rec."No.", 3, USERID, '', '');
                        //>>EmailNotification
                        MESSAGE('Rejected');

                        SAE17.RESET;
                        SAE17.SETCURRENTKEY("Document Type", "Document No.");
                        SAE17.SETRANGE("Document Type", 8);
                        SAE17.SETRANGE("Document No.", SalesApprovalEntry."Document No.");
                        SAE17.SETRANGE("Version No.", SalesApprovalEntry."Version No.");
                        SAE17.SETRANGE(Approved, FALSE);
                        SAE17.SETRANGE(Rejected, FALSE);
                        IF SAE17.FINDFIRST THEN BEGIN
                            SAE17.DELETEALL(TRUE);
                        END;

                    END;
                    //>>Reject Process
                END;
            }
            action("Approval Entries")
            {
                ApplicationArea = all;
                Image = Ledger;
                trigger OnAction()
                var
                    myInt: Integer;
                BEGIN

                    AppPage.Setfilters(8, rec."No.");
                    AppPage.RUN;
                END;
            }

        }
        modify(Reopen)
        {
            trigger OnAfterAction()

            VAR
                ReleaseSalesDoc: Codeunit 414;
            BEGIN
                //>>
                SalesApprovalEntry.RESET;
                SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::SalesReturnOrder);
                SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                SalesApprovalEntry.SETRANGE(Approved, FALSE);
                SalesApprovalEntry.SETRANGE(Rejected, FALSE);
                IF SalesApprovalEntry.FINDFIRST THEN BEGIN
                    SalesApprovalEntry.DELETEALL(TRUE);
                END;

                rec."Sent For Approval" := FALSE;
                rec."Credit Approval" := FALSE;
                rec."Campaign No." := '';
                rec.MODIFY;
                //<<
            end;
        }
        modify(Release)
        {
            // Image = ReleaseDoc;
            trigger OnBeforeAction()

            VAR
                ReleaseSalesDoc: Codeunit 414;
            BEGIN
                //EBT STIVAN---(30012013)---Error Message POP UP, IF Structure is Blank------START
                // IF Structure = '' THEN BEGIN
                //     ERROR('Structure is Blank');
                // END;
                //EBT STIVAN---(30012013)---Error Message POP UP, IF Structure is Blank------END


                //EBT STIVAN ---(20072012)--- Error Meesage POP if Assessable Value in case of Last year Sale Return is Blank ----START
                IF rec."Last Year Sales Return" = TRUE THEN BEGIN
                    recSCL.RESET;
                    recSCL.SETRANGE(recSCL."Document Type", recSCL."Document Type"::"Return Order");
                    recSCL.SETRANGE(recSCL."Document No.", rec."No.");
                    IF recSCL.FINDSET THEN
                        REPEAT
                        // IF recSCL."Assessable Value" = 0 THEN
                        //     ERROR('Assessable value is Zero')
                        UNTIL recSCL.NEXT = 0;
                END;
                //EBT STIVAN ---(20072012)--- Error Meesage POP if Assessable Value in case of Last year Sale Return is Blank ------END

                //ERROR('You cannot release Document directly'); //26Jun2019

                //EBT STIVAN ---(24/08/2012)--- Release Rights as per Sales Approval Setup ----------------------START
                recSalesApproval.RESET;
                recSalesApproval.SETRANGE(recSalesApproval."Approvar ID", USERID);
                IF recSalesApproval.FINDFIRST THEN BEGIN
                    ReleaseSalesDoc.PerformManualRelease(Rec);
                END ELSE
                    ERROR('You are not authorised to Release the Sales Return order');
                //EBT STIVAN ---(24/08/2012)--- Release Rights as per Sales Approval Setup ------------------------END
            END;




        }
        modify(CopyDocument)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            BEGIN
                CopySalesDoc.SetSalesHeader(Rec);
                CopySalesDoc.RUNMODAL;
                CLEAR(CopySalesDoc);
                IF rec.GET(rec."Document Type", rec."No.") THEN;

                //                  {
                //                  //EBT STIIVAN---(18012013)---Dialog Box Pop UP on SRO whether the Invoice is Cancelled---START
                //                  recSIH.RESET;
                // recSIH.SETRANGE(recSIH."No.", "Applies-to Doc. No.");
                // IF recSIH.FINDFIRST THEN BEGIN
                //     AppliedDocDate := recSIH."Posting Date";
                // END ELSE
                //     AppliedDocDate := 0D;


                // SROMonthName := FORMAT("Posting Date", 0, '<Month Text> <Year4>');
                // InvMonthName := FORMAT(AppliedDocDate, 0, '<Month Text> <Year4>');

                // //                  {
                // //                  IF TODAY <> AppliedDocDate THEN BEGIN
                // //     IF HideValidationDialog OR NOT GUIALLOWED THEN
                // //         confirmed := TRUE
                // //     ELSE
                // //         confirmed := CONFIRM('Is it Cancel Invoice ?', FALSE);

                // //     IF confirmed THEN BEGIN
                // //         "Cancelled Invoice" := TRUE;
                // //         "Posting No. Series" := 'CINV SALE';
                // //     END;

                // //     IF NOT confirmed THEN BEGIN
                // //         "Cancelled Invoice" := FALSE;
                // //     END;
                // // END;
                // //                  }
                // IF TODAY <> AppliedDocDate THEN BEGIN
                //     IF HideValidationDialog OR NOT GUIALLOWED THEN
                //         confirmed := TRUE
                //     ELSE
                //         confirmed := CONFIRM('Is it Cancel Invoice ?', FALSE);


                //     IF (confirmed) AND (SROMonthName = InvMonthName) THEN BEGIN
                //         "Cancelled Invoice" := TRUE;
                //         "Posting No. Series" := 'CINV SALE';
                //     END;

                //     IF (confirmed) AND NOT (SROMonthName = InvMonthName) THEN BEGIN
                //         "Cancelled Invoice" := FALSE;
                //         MESSAGE('You can not Cancel the Invoice which is not of the same month');
                //     END;

                //     IF NOT confirmed THEN BEGIN
                //         "Cancelled Invoice" := FALSE;
                //     END;

                // END;
                //                     }
                //EBT STIIVAN---(18012013)---Dialog Box Pop UP on SRO whether the Invoice is Cancelled-----END
            END;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            BEGIN

                //>>RSPL/CUST/FOC/RET001
                IF rec.FOC THEN
                    rec.TESTFIELD("Applies-to Doc. No.");
                //<<RSPL/CUST/FOC/RET001

                //EBT STIVAN ---(20072012)--- Error Meesage POP if Assessable Value in case of Last year Sale Return is Blank ----START
                IF rec."Last Year Sales Return" = TRUE THEN BEGIN
                    recSCL.RESET;
                    recSCL.SETRANGE(recSCL."Document Type", recSCL."Document Type"::"Return Order");
                    recSCL.SETRANGE(recSCL."Document No.", rec."No.");
                    IF recSCL.FINDSET THEN
                        REPEAT
                        // IF recSCL."Assessable Value" = 0 THEN
                        //     ERROR('Assessable value is Zero')
                        UNTIL recSCL.NEXT = 0;
                END;
                //EBT STIVAN ---(20072012)--- Error Meesage POP if Assessable Value in case of Last year Sale Return is Blank ------END
                // EBT MILAN ----(10092013)---Error Message POP if Excise Amount is ZERO-------------------------------------------START
                //                  {
                //                  IF "Currency Code" = '' THEN BEGIN
                //     recSCL.RESET;
                //     recSCL.SETRANGE(recSCL."Document No.", "No.");
                //     recSCL.SETRANGE(recSCL.Type, recSCL.Type::Item);
                //     IF recSCL.FINDSET THEN
                //         REPEAT
                //             IF (recSCL."Item Category Code" = 'CAT02') OR (recSCL."Item Category Code" = 'CAT03') OR (recSCL."Item Category Code" = 'CAT11')
                //             OR (recSCL."Item Category Code" = 'CAT12') OR (recSCL."Item Category Code" = 'CAT15') THEN
                //                 IF (recSCL."Excise Amount" = 0) THEN BEGIN
                //                     ERROR('Please Calculate Structure Value, Excise Amount is not calculated');
                //                 END;
                //         UNTIL recSCL.NEXT = 0;
                // END;
                //                  }//Commented as per UNI SIR 12July2017
                // EBT MILAN ----(10092013)---Error Message POP if Excise Amount is ZERO-------------------------------------------END
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            BEGIN
                //EBT STIVAN ---(20072012)--- Error Meesage POP if Assessable Value in case of Last year Sale Return is Blank ----START
                IF rec."Last Year Sales Return" = TRUE THEN BEGIN
                    recSCL.RESET;
                    recSCL.SETRANGE(recSCL."Document Type", recSCL."Document Type"::"Return Order");
                    recSCL.SETRANGE(recSCL."Document No.", rec."No.");
                    IF recSCL.FINDSET THEN
                        REPEAT
                        // IF recSCL."Assessable Value" = 0 THEN
                        //     ERROR('Assessable value is Zero')
                        UNTIL recSCL.NEXT = 0;
                END;
                //EBT STIVAN ---(20072012)--- Error Meesage POP if Assessable Value in case of Last year Sale Return is Blank ------END

            END;
        }
    }
    trigger OnOpenPage()
    BEGIN
        //TC-RSPL +
        //          {
        //          IF CSOMapping2.FINDFIRST THEN BEGIN
        //     //FILTERGROUP(2);
        //     SRO.RESET;
        //     SRO.SETRANGE(SRO."Document Type", "Document Type");
        //     IF SRO.FINDSET THEN
        //         REPEAT
        //             CSOMapping.RESET;
        //             CSOMapping.SETRANGE(CSOMapping."User Id", UPPERCASE(USERID));
        //             CSOMapping.SETRANGE(CSOMapping.Type, CSOMapping.Type::"Responsibility Center");
        //             CSOMapping.SETRANGE(CSOMapping.Value, SRO."Responsibility Center");
        //             IF CSOMapping.FINDFIRST THEN
        //                 SRO.MARK := TRUE
        //             ELSE BEGIN
        //                 CSOMapping1.RESET;
        //                 CSOMapping1.SETRANGE("User Id", UPPERCASE(USERID));
        //                 CSOMapping1.SETRANGE(Type, CSOMapping.Type::Location);
        //                 CSOMapping1.SETRANGE(Value, SRO."Location Code");
        //                 IF CSOMapping1.FINDFIRST THEN
        //                     SRO.MARK := TRUE
        //             END;
        //         UNTIL SRO.NEXT = 0;
        //     SRO.MARKEDONLY(TRUE);
        //     COPY(SRO);
        //     //FILTERGROUP(0);
        // END
        // ELSE BEGIN
        //          }
        //          //Robosoft\migration
        //          {
        //          IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
        //            FILTERGROUP(2);
        //            SETRANGE("Responsibility Center",UserMgt.GetSalesFilter());
        //            FILTERGROUP(0);
        //          END;
        //          }
        //END;
        //TC-RSPL -
        //>>Robosoft\Migratuon\Rahul***Code added to modify posting date

        //RSPL-PARAG 15/12/2017
        GSTCustTypeBoolean := FALSE;
        //RSPL-PARAG 15/12/2017

        IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN BEGIN//RSPLSUM 10Jun2020
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
        END;//RSPLSUM 10Jun2020
            //<<


        //EBT STIVAN (29052012) --- To Make Short Close Field Editable only to User ID SA -------START
        IF User.GET(USERID) THEN;
        IF (User."User ID" = 'GPUAE\KAUSTUBH.PARAB') OR (User."User ID" = 'GPUAE\UNNIKRISHNAN.VS') THEN
            //CurrForm."Short Close".EDITABLE := TRUE;
            ShortcloseEdtiable := TRUE; //RSPL-TC
                                        //EBT STIVAN (29052012) --- To Make Short Close Field Editable only to User ID SA ---------END

        IF (rec."Document Type" = rec."Document Type"::"Return Order") AND (rec."Created Date" <> 0D) THEN BEGIN
            "7Days" := CALCDATE('-7D', TODAY);

            recSH.RESET;
            recSH.SETRANGE(recSH."Document Type", recSH."Document Type"::"Return Order");
            recSH.SETRANGE(recSH.Status, recSH.Status::Open);
            recSH.SETFILTER(recSH."Created Date", '%1..%2', 0D, "7Days");
            IF recSH.FINDFIRST THEN
                REPEAT

                    recSL.RESET;
                    recSL.SETRANGE(recSL."Document No.", recSH."No.");
                    IF recSL.FINDSET THEN BEGIN
                        recSL.DELETEALL;
                    END;

                    ReservEntr.RESET;
                    ReservEntr.SETRANGE(ReservEntr."Source ID", recSH."No.");
                    IF ReservEntr.FINDSET THEN BEGIN
                        ReservEntr.DELETEALL;
                    END;

                UNTIL recSH.NEXT = 0;

            recSH.RESET;
            recSH.SETRANGE(recSH."Document Type", recSH."Document Type"::"Return Order");
            recSH.SETRANGE(recSH.Status, recSH.Status::Open);
            recSH.SETFILTER(recSH."Created Date", '%1..%2', 0D, "7Days");
            IF recSH.FINDSET THEN BEGIN
                recSH.DELETEALL;
            END;
        END;

        //  SetDocNoVisible;

        //RSPLSUM 10Jun2020>>
        IF rec."Shortcut Dimension 1 Code" = 'DIV-14' THEN
            EditBunkerFields := TRUE
        ELSE
            EditBunkerFields := FALSE;
        //RSPLSUM 10Jun2020<<
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    BEGIN
        //                {
        //                IF "Posting Date" <> TODAY THEN
        //     "Posting Date" := TODAY;
        // IF "Shipment Date" <> TODAY THEN
        //     "Shipment Date" := TODAY;
        //                }
        //EBT STIVAN ---(20072012)--- To make the Location Code Editable if its Last Year Sale Return -----START
        IF rec."Last Year Sales Return" = TRUE THEN
            //CurrForm."Location Code".EDITABLE := TRUE
            LocationCodeEditable := TRUE
        ELSE
            //CurrForm."Location Code".EDITABLE := FALSE;
            LocationCodeEditable := FALSE;
        //EBT STIVAN ---(20072012)--- To make the Location Code Editable if its Last Year Sale Return -------END

        //EBT STIVAN (13092012)--- To Capture the Applies To Document Nos Date -------------START
        recSIH.RESET;
        recSIH.SETRANGE(recSIH."No.", rec."Applies-to Doc. No.");
        IF recSIH.FINDFIRST THEN BEGIN
            AppliedDocDate := recSIH."Posting Date";
        END ELSE
            AppliedDocDate := 0D;
        //EBT STIVAN (13092012)--- To Capture the Applies To Document Nos Date ---------------END
        // SetControlAppearance;

        //RSPLSUM 10Jun2020>>
        IF rec."Shortcut Dimension 1 Code" = 'DIV-14' THEN
            EditBunkerFields := TRUE
        ELSE
            EditBunkerFields := FALSE;
        //RSPLSUM 10Jun2020<<
    END;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        rec."Document Type" := rec."Document Type"::"Return Order";
    end;

    var
        CSOMapping: Record 50006;
        CSOMapping1: Record 50006;
        CSOMapping2: Record 50006;
        SRO: Record 36;
        "7Days": Date;
        recSH: Record 36;
        recSL: Record 37;
        ReservEntr: Record 337;
        User: Record 91;
        ShortcloseEdtiable: Boolean;
        LocationCodeEditable: Boolean;
        recSIH: Record 112;
        recSCL: Record 37;
        AppliedDocDate: Date;
        SROMonthName: Text[30];
        InvMonthName: Text[30];
        confirmed: Boolean;
        HideValidationDialog: Boolean;
        recSalesApproval: Record 50008;
        "---Robosoft---": Integer;
        SalesLine1: Record 37;
        GSTCustTypeBoolean: Boolean;
        GSTCust: Date;
        "--------------08Jan2018": Integer;
        Cust08: Record 18;
        "-------------28Jun2019---ApprovalProcess": Integer;
        AppPage: Page 50010;
        TempVersionNo: Integer;
        SAE11: Record 50009;
        SalesApproval: Record 50008;
        SalesApprovalEntry: Record 50009;
        SL01: Record 37;
        User11: Record 91;
        QtyFound: Boolean;
        Cus11: Record 18;
        CrLimitAmt: Decimal;
        OverDueAmt: Decimal;
        CustCrLimitAmt: Decimal;
        BalanceAmt: Decimal;
        CurrentAmt: Decimal;
        User06: Record 2000000120;
        UserName06: Text;
        SL24: Record 37;
        RejEditable: Boolean;
        AppUserID: Code[50];
        TempSeqNo: Integer;
        SL12: Record 37;
        SRSetup: Record 311;
        SAE01: Record 50009;
        SA01: Record 50008;
        SAE17: Record 50009;
        CopySalesDoc: Report 292;

        EditBunkerFields: Boolean;
        PG: Page "Blanket Purchase Order";

    // SMTPMailSetup : Record 409;


    LOCAL PROCEDURE PostingValidation();
    BEGIN
        REC.TESTFIELD(Status, REC.Status::Released);
    END;



    PROCEDURE EmailNotification(DocType: Option "Sales Order","Blanket PO","Sales Invoice","Sales CrMemo","Purch Invoice","Purch CrMemo","Journal Voucher","GatePass","SalesReturnOrder"; DocNo: Code[20]; SeqNo: Integer; SenderID: Code[50]; ReceiveID: Code[50]; FirstID: Code[50]);
    VAR
        //  SMTPMail : Codeunit 400;
        EmailMsg: Codeunit "Email Message";
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
        SP22: Record 13;
    BEGIN
        // SMTPMailSetup.GET;//RSPLSUM02Apr21

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
        END;
        //<<SenderID

        IF SeqNo = 1 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Approval Mail';
            Text18 := 'Requires Approval.';
            ReceiveEmail := SenderEmail;
        END;

        IF SeqNo = 2 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Approved Mail';
            Text18 := 'has been Approved.';

            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", REC."No.");
            SAE18.SETRANGE(Approved, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                User18.RESET;
                IF User18.GET(SAE18."User ID") THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    ReceiveEmail := User18."E-Mail";
                END;
            END;

        END;

        IF SeqNo = 3 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Rejection Mail';
            Text18 := 'has been Rejected.';

            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", REC."No.");
            SAE18.SETRANGE(Rejected, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                User18.RESET;
                IF User18.GET(SAE18."User ID") THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    ReceiveEmail := User18."E-Mail";
                END;
            END;
        END;

        IF SeqNo = 4 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Approval Mail';
            Text18 := 'Requires L2 Approval.';
            ReceiveEmail := SenderEmail;
        END;

        //>>CreditLimit
        CLEAR(CrAmt);
        CLEAR(OtAmt);
        CLEAR(ODAmt);
        Cust18.RESET;
        IF Cust18.GET(REC."Sell-to Customer No.") THEN BEGIN
            Cust18.CALCFIELDS("Balance (LCY)");
            CrAmt := Cust18."Credit Limit (LCY)";
            OtAmt := Cust18."Balance (LCY)";
            ODAmt := Cust18.CalcOverdueBalance;
        END;
        //<<CreditLimit

        //>>Email Body
        //RSPLSUM02Apr21--SMTPMail.CreateMessage(SenderName,SenderEmail,ReceiveEmail,SubjectText,'',TRUE);
        // SMTPMail.CreateMessage(SenderName, SMTPMailSetup."User ID", ReceiveEmail, SubjectText, '', TRUE);//RSPLSUM02Apr21
        EmailMsg.Create(ReceiveEmail, SubjectText, '', true);

        IF SeqNo = 1 THEN BEGIN
            SA18.RESET;
            SA18.SETCURRENTKEY("Document Type");
            SA18.SETRANGE("Document Type", DocType);
            SA18.SETRANGE("User ID", SenderID);
            IF SA18.FINDSET THEN
                REPEAT
                    User18.RESET;
                    IF User18.GET(SA18."Approvar ID") THEN BEGIN
                        User18.TESTFIELD("E-Mail");
                        // SMTPMail.AddRecipients(User18."E-Mail");
                        EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                    END;
                UNTIL SA18.NEXT = 0;
        END;

        IF SeqNo = 2 THEN BEGIN
            //>>SalesPerson Email
            SP22.RESET;
            IF SP22.GET(REC."Salesperson Code") THEN BEGIN
                IF SP22."E-Mail" <> '' THEN
                    //  SMTPMail.AddCC(SP22."E-Mail");
                    EmailMsg.AddRecipient(RecipientType::"Cc", SP22."E-Mail");
            END;
            //<<SalesPerson Email

            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", REC."No.");
            SAE18.SETRANGE(Approved, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                IF FirstID = '' THEN BEGIN
                    User18.RESET;
                    IF User18.GET(SAE18."Approvar ID") THEN BEGIN
                        User18.TESTFIELD("E-Mail");
                        // SMTPMail.AddRecipients(User18."E-Mail");
                        EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                    END;
                END;
            END;
        END;

        IF SeqNo = 3 THEN BEGIN
            //>>SalesPerson Email
            SP22.RESET;
            IF SP22.GET(REC."Salesperson Code") THEN BEGIN
                IF SP22."E-Mail" <> '' THEN
                    // SMTPMail.AddCC(SP22."E-Mail");
                    EmailMsg.AddRecipient(RecipientType::"Cc", SP22."E-Mail");
            END;
            //<<SalesPerson Email
        END;

        IF SeqNo = 4 THEN BEGIN
            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", REC."No.");
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
                    // SMTPMail.AddRecipients(User18."E-Mail");
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
                            //SMTPMail.AddRecipients(User18."E-Mail");
                            EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                        END;
                    UNTIL SA18.NEXT = 0;
            END;
        END;

        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<B> Microsoft Dynamics NAV Document Approval System </B>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br> <B> Sales Return Order No.  - </B>' + '<B>' + REC."No." + '</B>' + ' ' + Text18);
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Table  Border="1">');//Table Start
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Company Name </th>');
        EmailMsg.AppendToBody('<td>' + COMPANYNAME + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Sales Return Order No.</th>');
        EmailMsg.AppendToBody('<td>' + REC."No." + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Customer</th>');
        EmailMsg.AppendToBody('<td>' + REC."Sell-to Customer No." + '  ' + REC."Sell-to Customer Name" + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Supply Location</th>');
        Loc21.RESET;
        IF Loc21.GET(REC."Location Code") THEN;
        EmailMsg.AppendToBody('<td>' + Loc21.Name + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Quantity</th>');
        SL21.RESET;
        SL21.SETRANGE("Document Type", REC."Document Type");
        SL21.SETRANGE("Document No.", REC."No.");
        SL21.CALCSUMS("Quantity (Base)");
        EmailMsg.AppendToBody('<td>' + FORMAT(SL21."Quantity (Base)", 0, '<Integer Thousand><Decimals,3>') + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Gross Amount </th>');
        REC.CALCFIELDS("Amount to Customer");
        EmailMsg.AppendToBody('<td>' + FORMAT(REC."Amount to Customer", 0, '<Integer Thousand><Decimals,3>') + '</td>');
        EmailMsg.AppendToBody('</tr>');

        //>>Rejection Remarks
        IF SeqNo = 3 THEN BEGIN
            EmailMsg.AppendToBody('<tr>');
            EmailMsg.AppendToBody('<th>Rejection Remarks</th>');
            EmailMsg.AppendToBody('<td>' + REC."Approval Description" + '</td>');
            EmailMsg.AppendToBody('</tr>');
        END;
        //<<Rejection Remarks

        EmailMsg.AppendToBody('</table>');//Table End
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        // SMTPMail.Send;
        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        //<<Email Body
    END;

    LOCAL PROCEDURE DueDateGPIPOL();
    VAR
        PayTerm02: Record 3;
    BEGIN
        //RSPLSUM 25May2020>>
        IF (REC."No." <> '') THEN
            IF REC."Shipment Date" <> 0D THEN BEGIN
                REC."Date GP" := TODAY;
                IF (REC."Payment Terms Code" <> '') THEN BEGIN
                    IF PayTerm02.GET(REC."Payment Terms Code") THEN;
                    REC."Due Date" := CALCDATE(PayTerm02."Due Date Calculation", REC."Shipment Date");
                END;
                REC.MODIFY;
            END;
        //RSPLSUM 25May2020<<
    END;

}