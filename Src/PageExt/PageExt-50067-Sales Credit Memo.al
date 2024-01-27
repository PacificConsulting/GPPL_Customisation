pageextension 50067 SalesCreditMemoExt extends "Sales Credit Memo"
{
    // SourceTableView = WHERE(Document Type=FILTER(Credit Memo),   Short Close=CONST(No));
    layout
    {
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //   {
                //                              //>>RB-N 08Jan2018
                //                              IF "Sell-to Customer No." <> '' THEN BEGIN
                //                     Cust08.RESET;
                //                     IF Cust08.GET("Sell-to Customer No.") THEN BEGIN
                //                         Cust08.TESTFIELD(Blocked, Cust08.Blocked::" ");
                //                     END;
                //                 END;
                //                              //<<RB-N 08Jan2018
                //                              }//Code Commented 14Mar2019
                //>>28Aug2018
                IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN //RSPLSUM 10Jun2020
                    DueDateGP;
                //<<28Aug2018

            end;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                BEGIN
                    //RSPLSUM 10Jun2020>>
                    IF rec."Shortcut Dimension 1 Code" = 'DIV-14' THEN BEGIN
                        IF rec."Posting Date" < rec."Shipment Date" THEN
                            ERROR('Please enter date greater than or equal to shipment date');
                    END;
                    //RSPLSUM 10Jun2020<<
                END;
            end;
        }
        modify("Payment Terms Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                BEGIN

                    //>>28Aug2018
                    IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN //RSPLSUM 10Jun2020
                        DueDateGP;
                    //<<28Aug2018
                END

            end;
        }
        modify("Shipment Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                BEGIN
                    //RSPLSUM 10Jun2020>>
                    IF rec."Shortcut Dimension 1 Code" = 'DIV-14' THEN BEGIN
                        DueDateGPIPOL;
                    END;
                    //RSPLSUM 10Jun2020<<
                END;
            end;
        }
        modify("Currency Code")
        {
            Editable = true;
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                BEGIN
                    //RSPLSUM 24Dec2020>>
                    IF CurrCode = '' THEN BEGIN
                        rec."Currency Code" := '';
                        rec.MODIFY;
                    END;
                    //RSPLSUM 24Dec2020<<
                END;
            end;

            trigger OnAssistEdit()
            VAR
                ChangeExchangeRate: Page 511;
            BEGIN
                // CLEAR(ChangeExchangeRate);
                // IF "Posting Date" <> 0D THEN
                //     ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date")
                // ELSE
                //     ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", WORKDATE);
                // IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                //     VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                //     CurrPage.UPDATE;
                // END;
                // CLEAR(ChangeExchangeRate);

            end;
        }
        // Add changes to page layout here
        addafter("No.")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
                Editable = EditBunkerFields;
            }
            field("Approval Description"; Rec."Approval Description")
            {
                ApplicationArea = all;
            }
            // field("Approval Status"; rec."Approval Status")
            // {
            //     //SourceExpr =UPPERCASE("Campaign No.");
            //     Editable = FALSE;
            //     Style = Attention;
            //     StyleExpr = TRUE;
            // }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = ll;
            }



        }
    }

    actions
    {
        addafter("&Credit Memo")
        {
            action("Send For Authorization")
            {
                ApplicationArea = ALL;
                Image = Change;
                trigger OnAction()
                var
                // SL01: Record 37;
                // SAE01: Record "Sales Approval Entry";//50009;
                // SA01: Record "Sales Approval";//50008;
                // TempVersionNo: Integer;
                // SalesApprovalEntry: Record "Sales Approval Entry";//50009;
                // TempSeqNo: Integer;
                BEGIN

                    REC.TESTFIELD("Campaign No.", '');
                    REC.TESTFIELD("Location Code");
                    REC.TESTFIELD("Payment Terms Code");
                    REC.TESTFIELD("Payment Method Code");

                    SL01.RESET;
                    SL01.SETRANGE("Document Type", REC."Document Type");
                    SL01.SETRANGE("Document No.", REC."No.");
                    SL01.SETRANGE("Location Code", REC."Location Code");
                    IF NOT SL01.FINDFIRST THEN
                        ERROR('Location Code in Sales CrMemo Lines are differnet from header Level');

                    SL01.RESET;
                    SL01.SETRANGE("Document Type", REC."Document Type");
                    SL01.SETRANGE("Document No.", REC."No.");
                    IF NOT SL01.FINDFIRST THEN
                        ERROR('No Sales Credit Memo Line Found');

                    SL01.RESET;
                    SL01.SETRANGE("Document Type", REC."Document Type");
                    SL01.SETRANGE("Document No.", REC."No.");
                    SL01.CALCSUMS(Quantity);
                    IF SL01.Quantity = 0 THEN
                        ERROR('Please enter No. of Qty');

                    IF NOT REC."Sent For Approval" THEN BEGIN

                        TempVersionNo := 0;
                        SAE01.RESET;
                        SAE01.SETCURRENTKEY("Document No.", "Version No.");
                        SAE01.SETRANGE("Document Type", SAE01."Document Type"::"Sales CrMemo");
                        SAE01.SETRANGE("Document No.", REC."No.");
                        IF SAE01.FINDLAST THEN
                            TempVersionNo := SAE01."Version No." + 1
                        ELSE
                            TempVersionNo := 1;

                        SA01.RESET;
                        SA01.SETRANGE("Document Type", SA01."Document Type"::"Sales CrMemo");
                        SA01.SETRANGE("User ID", USERID);
                        SA01.SETFILTER("Approvar ID", '<>%1', '');
                        IF SA01.FINDSET THEN BEGIN
                            TempSeqNo := 0;
                            REPEAT
                                TempSeqNo += 1;
                                SalesApprovalEntry.INIT;
                                SalesApprovalEntry."Document Type" := SalesApprovalEntry."Document Type"::"Sales CrMemo";
                                SalesApprovalEntry."Document No." := REC."No.";
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
                            IF SRSetup."Email Notification On SalesCr" THEN
                                EmailNotification(3, REC."No.", 1, USERID, '', '');
                            //>>Email Notification
                            MESSAGE('Document No. %1 has been sent for Approval', REC."No.");
                        END
                        ELSE
                            ERROR('Sales CrMemo Approval setup does not exists for User %1', USERID);
                    END
                    ELSE
                        ERROR('Document No. %1 has already been sent for approval');

                    REC."Sent For Approval" := TRUE;
                    REC."Campaign No." := 'Pending for Approval';
                    REC.Status := rec.Status::"Pending Approval";
                    REC.MODIFY;
                END;
            }
            action("Level1 Approval")
            {
                ApplicationArea = ALL;
                Image = Approval;
                trigger OnAction()

                VAR
                    ArchiveManagement: Codeunit 5063;
                    ReleaseSalesDoc: Codeunit 414;
                    SA01: Record "Sales Approval";//50008;
                    SRSetup: Record 311;
                    SalesApprovalEntry: Record "Sales Approval Entry";//50009;
                    User06: Record 2000000120;
                    UserName06: Text;
                    EditBunkerFields: Boolean;
                    SAE17: Record "Sales Approval Entry";//50009;

                BEGIN
                    //----------Fahim 15-06-2022 Level 2 Approval on L1

                    //>>User Approval Validation
                    SA01.RESET;
                    SA01.SETCURRENTKEY("Document Type");
                    SA01.SETRANGE("Document Type", 3);
                    SA01.SETRANGE("Approvar ID", USERID);
                    IF NOT SA01.FINDFIRST THEN
                        ERROR('You donot have rights to Approve, Please Contact System Administrator');
                    //<<User Approval Validation

                    REC.TESTFIELD("Campaign No.", 'Pending For Approval');

                    IF NOT CONFIRM('Final Approval, Do you want to Approve.', FALSE) THEN
                        EXIT;

                    SalesApprovalEntry.RESET;
                    SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.", "Version No.");
                    SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Sales CrMemo");
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
                    IF SRSetup."Email Notification On SalesCr" THEN
                        EmailNotification(3, rec."No.", 4, USERID, '', '');
                    //>>Email Notification

                    ReleaseSalesDoc.PerformManualRelease(Rec);
                    REC."Campaign No." := 'Approved';
                    REC.MODIFY;
                    MESSAGE('Approved');

                    //>>
                    SAE17.RESET;
                    SAE17.SETCURRENTKEY("Document Type", "Document No.");
                    SAE17.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Sales CrMemo");
                    SAE17.SETRANGE("Document No.", SalesApprovalEntry."Document No.");
                    SAE17.SETRANGE("Version No.", SalesApprovalEntry."Version No.");
                    SAE17.SETRANGE(Approved, FALSE);
                    IF SAE17.FINDFIRST THEN BEGIN
                        SAE17.DELETEALL(TRUE);
                    END;

                    ArchiveManagement.ArchiveSalesDocument(Rec);
                    CurrPage.UPDATE(FALSE);


                    //----------End Fahim 15-06-2022 Level 2 Approval on L1


                    //>>User Approval Validation
                    //              {SA01.RESET;
                    // SA01.SETCURRENTKEY("Document Type");
                    // SA01.SETRANGE("Document Type", 3);
                    // SA01.SETRANGE("Approvar ID", USERID);
                    // IF NOT SA01.FINDFIRST THEN
                    //     ERROR('You donot have rights to Approve, Please Contact System Administrator');
                    // //<<User Approval Validation

                    // REC.TESTFIELD("Campaign No.", 'Pending For Approval');

                    // IF NOT CONFIRM('First Level Approval , Do you want to Approve.', FALSE) THEN
                    //     EXIT;

                    // SalesApprovalEntry.RESET;
                    // SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                    // SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Sales CrMemo");
                    // SalesApprovalEntry.SETRANGE("Document No.", "No.");
                    // SalesApprovalEntry.SETRANGE("Approvar ID", USERID);
                    // IF SalesApprovalEntry.FINDLAST THEN BEGIN
                    //     SalesApprovalEntry.Approved := TRUE;
                    //     SalesApprovalEntry."Approval Date" := TODAY;
                    //     SalesApprovalEntry."Approval Time" := TIME;
                    //     SalesApprovalEntry.MODIFY;
                    // END;
                    // //>>Email Notification
                    // SRSetup.GET;
                    // IF SRSetup."Email Notification On SalesCr" THEN
                    //     EmailNotification(3, "No.", 4, USERID, '', '');
                    // //>>Email Notification

                    // "Campaign No." := 'Pending L2 Approval';
                    // MODIFY;} //Fahim 15-06-22
                    //  {
                    //  //>>
                    //  SAE17.RESET;
                    //  SAE17.SETCURRENTKEY("Document Type","Document No.");
                    //  SAE17.SETRANGE("Document Type",SalesApprovalEntry."Document Type"::"Sales CrMemo");
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
            action("Level2 Approval")
            {
                ApplicationArea = ALL;
                Image = Approval;
                trigger OnAction()
                VAR
                    ArchiveManagement: Codeunit 5063;
                    ReleaseSalesDoc: Codeunit 414;
                BEGIN

                    //>>User Approval Validation
                    SA01.RESET;
                    SA01.SETCURRENTKEY("Document Type");
                    SA01.SETRANGE("Document Type", 3);
                    SA01.SETRANGE("Level2 Approvar ID", USERID);
                    IF NOT SA01.FINDFIRST THEN
                        ERROR('You donot have rights to Approve, Please Contact System Administrator');
                    //<<User Approval Validation

                    REC.TESTFIELD("Campaign No.", 'Pending L2 Approval');

                    IF NOT CONFIRM('Final Approval, Do you want to Approve.', FALSE) THEN
                        EXIT;

                    SalesApprovalEntry.RESET;
                    SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.", "Version No.");
                    SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Sales CrMemo");
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
                    IF SRSetup."Email Notification On SalesCr" THEN
                        EmailNotification(3, REC."No.", 2, USERID, '', '');
                    //>>Email Notification

                    ReleaseSalesDoc.PerformManualRelease(Rec);
                    REC."Campaign No." := 'Approved';
                    REC.MODIFY;
                    MESSAGE('Approved');

                    //>>
                    SAE17.RESET;
                    SAE17.SETCURRENTKEY("Document Type", "Document No.");
                    SAE17.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Sales CrMemo");
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
            action("Rejection")
            {
                ApplicationArea = ALL;
                Image = Reject;
                trigger OnAction()
                BEGIN

                    SA01.RESET;
                    SA01.SETCURRENTKEY("Document Type");
                    SA01.SETRANGE("Document Type", SA01."Document Type"::"Sales CrMemo");
                    SA01.SETRANGE("Approvar ID", USERID);
                    IF NOT SA01.FINDFIRST THEN
                        ERROR('You donot have rights to Reject, Please Contact System Administrator');

                    REC.TESTFIELD("Campaign No.", 'Pending For Approval');
                    REC.TESTFIELD("Approval Description");

                    //>>Reject Process
                    SalesApprovalEntry.RESET;
                    SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                    SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Sales CrMemo");
                    SalesApprovalEntry.SETRANGE("Document No.", REC."No.");
                    SalesApprovalEntry.SETRANGE("Approvar ID", USERID);
                    IF SalesApprovalEntry.FINDLAST THEN BEGIN

                        SalesApprovalEntry.Rejected := TRUE;
                        SalesApprovalEntry."Rejected Date" := TODAY;
                        SalesApprovalEntry."Rejected Time" := TIME;
                        SalesApprovalEntry.MODIFY;

                        REC."Sent For Approval" := FALSE;
                        REC."Campaign No." := '';
                        REC.Status := Rec.Status::Open;
                        REC.MODIFY(TRUE);

                        //>>EmailNotification
                        SRSetup.GET;
                        IF SRSetup."Email Notification On SalesCr" THEN
                            EmailNotification(3, REC."No.", 3, USERID, '', '');
                        //>>EmailNotification
                        MESSAGE('Rejected');

                        SAE17.RESET;
                        SAE17.SETCURRENTKEY("Document Type", "Document No.");
                        SAE17.SETRANGE("Document Type", SAE17."Document Type"::"Sales CrMemo");
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
                ApplicationArea = ALL;
                Image = Ledger;
                trigger OnAction()
                var
                    AppPage: Page "Sales Approval Entry";
                BEGIN

                    AppPage.Setfilters(3, rec."No.");
                    AppPage.RUN;
                END;
            }

        }
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            BEGIN
                //EBT STIVAN ---(26/07/2012)--- Error Message POP UP if Location Code is Blank -------START
                IF rec."Location Code" = '' THEN
                    ERROR('Location Code is Blank');
                //EBT STIVAN ---(26/07/2012)--- Error Message POP UP if Location Code is Blank ---------END

                //>>25Oct2018 Level2 Posting Validation
                //                  {SA01.RESET;
                // SA01.SETCURRENTKEY("Document Type");
                // SA01.SETRANGE("Document Type", 3);
                // SA01.SETRANGE("Level2 Approvar ID", USERID);
                // IF NOT SA01.FINDFIRST THEN
                //     ERROR('Only Level2 Approvar are allowed for Posting');} //Fahim 14-06-22
                //<<25Oct2018 25Oct2018 Level2 Posting Validation

            end;


        }
        modify(Reopen)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            BEGIN

                //>>
                SalesApprovalEntry.RESET;
                SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Sales CrMemo");
                SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                SalesApprovalEntry.SETRANGE(Approved, FALSE);
                SalesApprovalEntry.SETRANGE(Rejected, FALSE);
                IF SalesApprovalEntry.FINDFIRST THEN BEGIN
                    SalesApprovalEntry.DELETEALL(TRUE);
                END;

                rec."Sent For Approval" := FALSE;
                rec."Campaign No." := '';
                rec.MODIFY;

            end;
        }
        // Add changes to page actions here
        modify(Release)
        {
            trigger OnAfterAction()
            VAR

            BEGIN
                //EBT STIVAN ---(26/07/2012)--- Error Message POP UP if Location Code is Blank -------START
                IF rec."Location Code" = '' THEN
                    ERROR('Location Code is Blank');
                //EBT STIVAN ---(26/07/2012)--- Error Message POP UP if Location Code is Blank ---------END

                //EBT STIVAN ---(27072012)--- Error Message Pop if Posting No. Series is Blank ---START
                IF rec."Posting No. Series" = '' THEN
                    ERROR('Please Select Posting No. Series');
                //EBT STIVAN ---(27072012)--- Error Message Pop if Posting No. Series is Blank -----END

                ERROR('You cannot release Document directly'); //15Sep2018
                                                               //                  {
                                                               //                  //EBT STIVAN ---(24/08/2012)--- Release Rights as per Sales Approval Setup ----------------------START
                                                               //                  recSalesApproval.RESET;
                                                               // recSalesApproval.SETRANGE(recSalesApproval."Approvar ID", USERID);
                                                               // IF recSalesApproval.FINDFIRST THEN BEGIN
                                                               //     ReleaseSalesDoc.PerformManualRelease(Rec);

                // END ELSE
                //     ERROR('You are not authorised to Release the Sales Credit Memo');
                //                  //EBT STIVAN ---(24/08/2012)--- Release Rights as per Sales Approval Setup ------------------------END;
                //                  }
            END;
        }


    }

    // trigger OnNextRecord()
    // var
    //     myInt: Integer;
    // BEGIN
    //     rec."Document Type" := rec."Document Type"::"Credit Memo";
    // END;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        BEGIN
            //      {
            //      CSOMapping2.RESET;
            // CSOMapping2.SETRANGE(CSOMapping2."User Id", UPPERCASE(USERID));
            // IF CSOMapping2.FINDFIRST THEN BEGIN
            //     //FILTERGROUP(2);
            //     SCM.RESET;
            //     SCM.SETRANGE(SCM."Document Type", "Document Type");
            //     SCM.SETFILTER(SCM."Short Close", '%1', FALSE);
            //     IF SCM.FINDSET THEN
            //         REPEAT
            //             CSOMapping.RESET;
            //             CSOMapping.SETRANGE(CSOMapping."User Id", UPPERCASE(USERID));
            //             CSOMapping.SETRANGE(CSOMapping.Type, CSOMapping.Type::"Responsibility Center");
            //             CSOMapping.SETRANGE(CSOMapping.Value, SCM."Responsibility Center");
            //             IF CSOMapping.FINDFIRST THEN
            //                 SCM.MARK := TRUE
            //             ELSE BEGIN
            //                 CSOMapping1.RESET;
            //                 CSOMapping1.SETRANGE("User Id", UPPERCASE(USERID));
            //                 CSOMapping1.SETRANGE(Type, CSOMapping.Type::Location);
            //                 CSOMapping1.SETRANGE(Value, SCM."Location Code");
            //                 IF CSOMapping1.FINDFIRST THEN
            //                     SCM.MARK := TRUE
            //             END;
            //         UNTIL SCM.NEXT = 0;
            //     SCM.MARKEDONLY(TRUE);
            //     COPY(SCM);
            //     // FILTERGROUP(0);
            // END
            // ELSE BEGIN
            //     IF UserMgt.GetSalesFilter() <> '' THEN BEGIN

            //         FILTERGROUP(2);
            //         SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            //         FILTERGROUP(0);
            //     END;
            // END;
            //      }

            //>>28Aug2018
            IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN //RSPLSUM 10Jun2020
                DueDateGP;
            //<<28Aug2018

            //>>Robosoft\Migration
            IF rec."Shortcut Dimension 1 Code" <> 'DIV-14' THEN BEGIN//RSPLSUM 10Jun2020
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
            END;//RSPLSUM 10Jun2020
                //>>

            // SetDocNoVisible;

            //RSPLSUM 10Jun2020>>
            IF rec."Shortcut Dimension 1 Code" = 'DIV-14' THEN
                EditBunkerFields := TRUE
            ELSE
                EditBunkerFields := FALSE;
            //RSPLSUM 10Jun2020<<
        END;

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    BEGIN

        //                {
        //                //EBT0001
        //                IF "Posting Date" <> TODAY THEN
        //     "Posting Date" := TODAY;
        // IF "Shipment Date" <> TODAY THEN
        //     "Shipment Date" := TODAY;
        //                //EBT0001
        //                }

        //>> RB-N 05Jan2018
        CurrCode := '';
        IF rec."Currency Code" <> '' THEN
            CurrCode := rec."Currency Code"
        ELSE
            CurrCode := '';
        //<< RB-N 05Jan2018

        //RSPLSUM 10Jun2020>>
        IF rec."Shortcut Dimension 1 Code" = 'DIV-14' THEN
            EditBunkerFields := TRUE
        ELSE
            EditBunkerFields := FALSE;
        //RSPLSUM 10Jun2020<<
    END;



    var
        CSOMapping2: Record 50006;
        SCM: Record 36;
        CSOMapping: Record 50006;
        CSOMapping1: Record 50006;
        recSalesApproval: Record 50008;
        SalesLine1: Record 37;
        "----------16Sep2017": Integer;
        CurrCode: Code[20];
        "------------08Jan2018": Integer;
        Cust08: Record 18;
        "--------14Sep2018--AprrovalProcess": Integer;
        TempVersionNo: Integer;
        TempSeqNo: Integer;
        SL01: Record 37;
        SAE01: Record "Sales Approval Entry";//50009;
        SAE17: Record "Sales Approval Entry";//50009;
        SA01: Record "Sales Approval";//50008;
        SalesApprovalEntry: Record "Sales Approval Entry";//50009;
        SRSetup: Record 311;
        // AppPage: Page 50010; TEMPORY PCPL-065
        User06: Record 2000000120;
        UserName06: Text;
        EditBunkerFields: Boolean;
    //  SMTPMailSetup: Record 409;

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
            // IF "Sell-to Customer No." <> '' THEN BEGIN
            //         Cust05.RESET;
            //         IF Cust05.GET("Sell-to Customer No.") THEN;
            //         "Due Date" := CALCDATE(Cust05."Approved Payment Days", "Due Date");
            //     END;
            // }//03Jan2019 Code Commented for Extra Grace Period
            rec.MODIFY;
        END;
        //<<28Aug2018 RB-N
    END;

    PROCEDURE EmailNotification(DocType: Option "Sales Order","Blanket PO","Sales Invoice","Sales CrMemo","Purch Invoice","Purch CrMemo","Journal Voucher"; DocNo: Code[20]; SeqNo: Integer; SenderID: Code[50]; ReceiveID: Code[50]; FirstID: Code[50]);
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
            //RSPLSUM21Apr21--SubjectText := 'Microsoft Dynamics NAV: Approval Mail' ;
            SubjectText := 'Microsoft Dynamics NAV: ' + rec."No." + ' required L1 Approval';//RSPLSUM21Apr21
            Text18 := 'Requires Approval.';
            ReceiveEmail := SenderEmail;
        END;

        IF SeqNo = 2 THEN BEGIN
            //RSPLSUM21Apr21--SubjectText := 'Microsoft Dynamics NAV: Approved Mail';
            SubjectText := 'Microsoft Dynamics NAV: ' + rec."No." + ' has been Approved';//RSPLSUM21Apr21
            Text18 := 'has been Approved.';

            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", rec."No.");
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
            SAE18.SETRANGE("Document No.", rec."No.");
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
            //RSPLSUM21Apr21--SubjectText := 'Microsoft Dynamics NAV: Approval Mail' ;
            SubjectText := 'Microsoft Dynamics NAV: ' + rec."No." + ' required L2 Approval';//RSPLSUM21Apr21
            Text18 := 'Requires L2 Approval.';
            ReceiveEmail := SenderEmail;
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
        //RSPLSUM02Apr21--SMTPMail.CreateMessage(SenderName,SenderEmail,ReceiveEmail,SubjectText,'',TRUE);
        // EmailMsg.CreateMessage(SenderName, SMTPMailSetup."User ID", ReceiveEmail, SubjectText, '', TRUE);//RSPLSUM02Apr21
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
                        // EmailMsg.AddRecipients(User18."E-Mail");
                        EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                    END;
                UNTIL SA18.NEXT = 0;
        END;

        IF SeqNo = 2 THEN BEGIN
            //>>SalesPerson Email
            SP22.RESET;
            IF SP22.GET(rec."Salesperson Code") THEN BEGIN
                IF SP22."E-Mail" <> '' THEN
                    //EmailMsg.AddCC(SP22."E-Mail");
                EmailMsg.AddRecipient(RecipientType::"Cc", SP22."E-Mail");
            END;
            //<<SalesPerson Email

            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", rec."No.");
            SAE18.SETRANGE(Approved, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                IF FirstID = '' THEN BEGIN
                    User18.RESET;
                    IF User18.GET(SAE18."Approvar ID") THEN BEGIN
                        User18.TESTFIELD("E-Mail");
                        // EmailMsg.AddRecipients(User18."E-Mail");
                        EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");

                    END;
                END;
            END;
        END;

        IF SeqNo = 3 THEN BEGIN
            //>>SalesPerson Email
            SP22.RESET;
            IF SP22.GET(rec."Salesperson Code") THEN BEGIN
                IF SP22."E-Mail" <> '' THEN
                    // EmailMsg.AddCC(SP22."E-Mail");
                    EmailMsg.AddRecipient(RecipientType::"Cc", SP22."E-Mail");
            END;
            //<<SalesPerson Email
        END;

        IF SeqNo = 4 THEN BEGIN
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
                    // SMTPMail.AddRecipients(User18."E-Mail");
                    EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                END;

                User18.RESET;
                User18.SETRANGE("User ID", SAE18."Approvar ID");
                IF User18.FINDFIRST THEN BEGIN
                    User18.TESTFIELD("E-Mail");
                    // EmailMsg.AddRecipients(User18."E-Mail");
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
                            // EmailMsg.AddRecipients(User18."E-Mail");
                            EmailMsg.AddRecipient(RecipientType::"To", User18."E-Mail");
                        END;
                    UNTIL SA18.NEXT = 0;
            END;
        END;

        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<B> Microsoft Dynamics NAV Document Approval System </B>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br> <B> Sales Credit Note No.  - </B>' + '<B>' + rec."No." + '</B>' + ' ' + Text18);
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Table  Border="1">');//Table Start
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Company Name </th>');
        EmailMsg.AppendToBody('<td>' + COMPANYNAME + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Sales Credit Note No.</th>');
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
        SL21.CALCSUMS("Quantity (Base)");
        EmailMsg.AppendToBody('<td>' + FORMAT(SL21."Quantity (Base)", 0, '<Integer Thousand><Decimals,3>') + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Gross Amount </th>');
        rec.CALCFIELDS("Amount to Customer");
        EmailMsg.AppendToBody('<td>' + FORMAT(rec."Amount to Customer", 0, '<Integer Thousand><Decimals,3>') + '</td>');
        EmailMsg.AppendToBody('</tr>');
        //   {
        //   EmailMsg.AppendToBody('<tr>');
        //     EmailMsg.AppendToBody('<th>Credit Limit </th>');
        //     EmailMsg.AppendToBody('<td>' + FORMAT(CrAmt, 0, '<Integer Thousand><Decimals,3>') + '</td>');
        //     EmailMsg.AppendToBody('</tr>');

        //     EmailMsg.AppendToBody('<tr>');
        //     EmailMsg.AppendToBody('<th>Total Outstanding Amount </th>');
        //     EmailMsg.AppendToBody('<td>' + FORMAT(OtAmt, 0, '<Integer Thousand><Decimals,3>') + '</td>');
        //     EmailMsg.AppendToBody('</tr>');

        //     EmailMsg.AppendToBody('<tr>');
        //     EmailMsg.AppendToBody('<th>Overdue Amount </th>');
        //     EmailMsg.AppendToBody('<td>' + FORMAT(ODAmt, 0, '<Integer Thousand><Decimals,3>') + '</td>');
        //     EmailMsg.AppendToBody('</tr>');
        //   }
        //>>Rejection Remarks
        IF SeqNo = 3 THEN BEGIN
            EmailMsg.AppendToBody('<tr>');
            EmailMsg.AppendToBody('<th>Rejection Remarks</th>');
            EmailMsg.AppendToBody('<td>' + rec."Approval Description" + '</td>');
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
}