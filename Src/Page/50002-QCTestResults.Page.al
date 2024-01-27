page 50002 "QC Test Results"
{
    PageType = List;
    SourceTable = 50002;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control001)
            {
                field("Order No."; rec."Order No.")
                {
                    ApplicationArea = all;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field(Parameter; rec.Parameter)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Typical Value"; rec."Typical Value")
                {
                    ApplicationArea = all;
                }
                field("Min Range"; rec."Min Range")
                {
                    ApplicationArea = all;
                }
                field("Max Range"; rec."Max Range")
                {
                    ApplicationArea = all;
                }
                field(Result; rec.Result)
                {
                    ApplicationArea = all;
                }
                field(Approved; rec.Approved)
                {
                    ApplicationArea = all;
                }
                field(Rejected; rec.Rejected)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unction")
            {
                Caption = 'F&unction';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        PurPaySetup: Record 312;
                    begin
                        CurrPage.SAVERECORD;
                        /*QCTestResult.RESET;
                        QCTestResult.SETRANGE("Order No.","Order No.");
                        QCTestResult.SETRANGE("Line No.","Line No.");
                        QCTestResult.SETFILTER(QCTestResult."Qty to Approve",'<>%1',0);
                        IF QCTestResult.FINDFIRST THEN
                        BEGIN
                          QCTestResult1.RESET;
                          QCTestResult1.SETRANGE("Order No.",QCTestResult."Order No.");
                          QCTestResult1.SETRANGE("Line No.",QCTestResult."Line No.");
                          QCTestResult1.SETFILTER(Parameter,'<>%1',QCTestResult.Parameter);
                          IF QCTestResult1.FINDSET THEN
                          REPEAT
                            QCTestResult1."Qty to Approve" := QCTestResult."Qty to Approve";
                            QCTestResult1.MODIFY;
                          UNTIL QCTestResult1.NEXT = 0;
                        END;  */
                        Tested := FALSE;
                        QCTestResult.RESET;
                        QCTestResult.SETRANGE("Order No.", rec."Order No.");
                        QCTestResult.SETRANGE("Line No.", rec."Line No.");
                        IF QCTestResult.FINDSET THEN
                            REPEAT
                                QCTestResult.TESTFIELD(QCTestResult.Result);
                                IF QCTestResult.Result <> '' THEN
                                    Tested := TRUE
                                ELSE
                                    Tested := FALSE;
                            UNTIL QCTestResult.NEXT = 0;
                        IF Tested THEN BEGIN
                            QCTestResult.RESET;
                            QCTestResult.SETRANGE("Order No.", rec."Order No.");
                            QCTestResult.SETRANGE("Line No.", rec."Line No.");
                            IF QCTestResult.FINDSET THEN
                                REPEAT
                                    QCTestResult.Approved := TRUE;
                                    QCTestResult.MODIFY;
                                UNTIL QCTestResult.NEXT = 0;
                            //RSPLSUM28688--MESSAGE('Approved');
                        END;

                        //RSPLSUM28688>> Merge actions - Approve and Submit QC Result
                        //EBT/QC Func/0001
                        //CurrPage.SAVERECORD;
                        TestedQC := FALSE;
                        QCTestResultSubmit.RESET;
                        QCTestResultSubmit.SETRANGE("Order No.", rec."Order No.");
                        QCTestResultSubmit.SETRANGE("Line No.", rec."Line No.");
                        IF QCTestResultSubmit.FINDSET THEN
                            REPEAT
                                IF QCTestResultSubmit.Approved THEN
                                    TestedQC := TRUE
                                ELSE
                                    TestedQC := FALSE;
                            UNTIL QCTestResultSubmit.NEXT = 0;

                        IF TestedQC THEN BEGIN
                            PurchaseLine.RESET;
                            PurchaseLine.SETRANGE("Document No.", rec."Order No.");
                            PurchaseLine.SETRANGE("Line No.", rec."Line No.");
                            IF PurchaseLine.FINDFIRST THEN BEGIN
                                PurchaseLine."QC Approved" := TRUE;
                                //PurchaseLine.VALIDATE(PurchaseLine."Qty. to Receive",QCTestResult."Qty to Approve");
                                PurchaseLine.MODIFY;
                                WhsRecptLine.RESET;
                                WhsRecptLine.SETRANGE(WhsRecptLine."Source Type", 39);
                                WhsRecptLine.SETRANGE(WhsRecptLine."Source Document", WhsRecptLine."Source Document"::"Purchase Order");
                                WhsRecptLine.SETRANGE(WhsRecptLine."Source No.", rec."Order No.");
                                WhsRecptLine.SETRANGE(WhsRecptLine."Source Line No.", rec."Line No.");
                                IF WhsRecptLine.FINDFIRST THEN BEGIN
                                    WhsRecptLine."QC Approved" := TRUE;
                                    //WhsRecptLine.VALIDATE(WhsRecptLine."Qty. to Receive",QCTestResult."Qty to Approve");
                                    WhsRecptLine.MODIFY;
                                END;
                            END;

                            //RSPLSUM28688>>
                            RecWRL.SETRANGE(RecWRL."Source Type", 39);
                            RecWRL.SETRANGE(RecWRL."Source Document", RecWRL."Source Document"::"Purchase Order");
                            RecWRL.SETRANGE(RecWRL."Source No.", rec."Order No.");
                            IF RecWRL.FINDFIRST THEN BEGIN
                                RecWhseRcptLine.RESET;
                                RecWhseRcptLine.SETRANGE("No.", RecWRL."No.");
                                RecWhseRcptLine.SETRANGE("QC Applicable", TRUE);
                                RecWhseRcptLine.SETRANGE("QC Approved", FALSE);
                                IF NOT RecWhseRcptLine.FINDFIRST THEN BEGIN

                                    RecWRLNew.RESET;
                                    RecWRLNew.SETCURRENTKEY("No.", "QC Applicable");
                                    RecWRLNew.SETRANGE("No.", RecWRL."No.");
                                    RecWRLNew.SETRANGE("QC Applicable", TRUE);
                                    IF RecWRLNew.FINDSET THEN
                                        REPEAT
                                            RecWRLNew.TESTFIELD("Expiry Date");
                                        UNTIL RecWRLNew.NEXT = 0;

                                    SalApprove.RESET;
                                    SalApprove.SETCURRENTKEY("Document Type");
                                    SalApprove.SETRANGE("Document Type", SalApprove."Document Type"::QC);
                                    SalApprove.SETRANGE("Approvar ID", USERID);
                                    IF NOT SalApprove.FINDFIRST THEN
                                        ERROR('You donot have rights to Approve, Please Contact System Administrator');

                                    RecWRH.RESET;
                                    IF RecWRH.GET(RecWRL."No.") THEN BEGIN
                                        RecWRH.TESTFIELD("QC Status", RecWRH."QC Status"::"Pending for Approval");
                                        RecWRH.TESTFIELD("Reference No.");

                                        SalesApprovalEntry.RESET;
                                        SalesApprovalEntry.SETCURRENTKEY("Document Type", "Document No.");
                                        SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::QC);
                                        SalesApprovalEntry.SETRANGE("Document No.", RecWRH."No.");
                                        SalesApprovalEntry.SETRANGE("Approvar ID", USERID);
                                        IF SalesApprovalEntry.FINDLAST THEN BEGIN
                                            SalesApprovalEntry.Approved := TRUE;
                                            SalesApprovalEntry."Approval Date" := TODAY;
                                            SalesApprovalEntry."Approval Time" := TIME;
                                            SalesApprovalEntry.MODIFY;
                                        END ELSE
                                            ERROR('You donot have rights for L1 Approval, Please Contact System Administrator');

                                        SalesApprovalEntryNew.RESET;
                                        SalesApprovalEntryNew.SETCURRENTKEY("Document Type", "Document No.");
                                        SalesApprovalEntryNew.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::QC);
                                        SalesApprovalEntryNew.SETRANGE("Document No.", RecWRH."No.");
                                        SalesApprovalEntryNew.SETRANGE("Approvar ID", USERID);
                                        IF SalesApprovalEntryNew.FINDLAST THEN BEGIN
                                            IF SalesApprovalEntryNew."Mandatory ID" THEN BEGIN
                                                RecWRH."QC Status" := RecWRH."QC Status"::Approved;
                                                RecWRH.MODIFY;
                                            END;

                                            MESSAGE('Approved');

                                            SAE17.RESET;
                                            SAE17.SETCURRENTKEY("Document Type", "Document No.");
                                            SAE17.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::QC);
                                            SAE17.SETRANGE("Document No.", SalesApprovalEntry."Document No.");
                                            SAE17.SETRANGE("Version No.", SalesApprovalEntry."Version No.");
                                            SAE17.SETRANGE(Approved, FALSE);
                                            IF SAE17.FINDFIRST THEN BEGIN
                                                SAE17.DELETEALL(TRUE);
                                            END;
                                        END;

                                        PurPaySetup.GET;
                                        IF PurPaySetup."QC Approval Email Alert" THEN
                                            EmailNotification(0, RecWRH."No.", 2, USERID, '', 'YES');
                                    END;
                                END;
                            END;
                            //RSPLSUM28688<<

                            MESSAGE('QC has been approved');
                            CurrPage.CLOSE;
                        END
                        ELSE
                            MESSAGE('QC Test Result has been submited, Some parameters yet to be submited to approve the Test');
                        //EBT/QC Func/0001

                        //RSPLSUM28688<<

                    end;
                }
                action("Un Approve")
                {
                    Caption = 'Un Approve';

                    trigger OnAction()
                    begin
                        QCTestResult.RESET;
                        QCTestResult.SETRANGE(QCTestResult."Order No.", rec."Order No.");
                        QCTestResult.SETRANGE(QCTestResult."Line No.", rec."Line No.");
                        IF QCTestResult.FINDSET THEN
                            REPEAT
                                QCTestResult.Approved := FALSE;
                                QCTestResult.MODIFY;
                            UNTIL QCTestResult.NEXT = 0;
                        PurchaseLine.RESET;
                        PurchaseLine.SETRANGE(PurchaseLine."Document No.", rec."Order No.");
                        PurchaseLine.SETRANGE(PurchaseLine."Line No.", rec."Line No.");
                        IF PurchaseLine.FINDFIRST THEN
                            IF PurchaseLine."QC Approved" THEN BEGIN
                                PurchaseLine."QC Approved" := FALSE;
                                PurchaseLine.MODIFY;
                            END;
                        MESSAGE('Qc to be approved again');
                    end;
                }
                action(Rejected1)
                {
                    Caption = 'Rejected';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        WhsRecptLine1: Record 7317;
                        WarehouseReceiptHeader: Record 7316;
                    begin
                        //RSPLAM21072021  --
                        QCTestResult.RESET;
                        QCTestResult.SETRANGE(QCTestResult."Order No.", rec."Order No.");
                        QCTestResult.SETRANGE(QCTestResult."Line No.", rec."Line No.");
                        IF QCTestResult.FINDSET THEN
                            REPEAT
                                QCTestResult.Rejected := FALSE;
                                QCTestResult.MODIFY;
                            UNTIL QCTestResult.NEXT = 0;

                        WhsRecptLine1.RESET;
                        WhsRecptLine1.SETRANGE("Source Type", 39);
                        WhsRecptLine1.SETRANGE("Source Document", WhsRecptLine."Source Document"::"Purchase Order");
                        WhsRecptLine1.SETRANGE("Source No.", rec."Order No.");
                        WhsRecptLine1.SETRANGE("Source Line No.", rec."Line No.");
                        IF WhsRecptLine1.FINDFIRST THEN;
                        WarehouseReceiptHeader.RESET;
                        WarehouseReceiptHeader.SETRANGE("No.", WhsRecptLine1."No.");
                        IF WarehouseReceiptHeader.FINDFIRST THEN BEGIN
                            WarehouseReceiptHeader."QC Status" := WarehouseReceiptHeader."QC Status"::Rejected;
                            WarehouseReceiptHeader.MODIFY;
                        END;
                        //RSPLAM21072021  ++
                    end;
                }
                separator(ctrnl01)
                {
                }
                action("Submit QC Result")
                {
                    Caption = 'Submit QC Result';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //EBT/QC Func/0001
                        CurrPage.SAVERECORD;
                        Tested := FALSE;
                        QCTestResult.RESET;
                        QCTestResult.SETRANGE("Order No.", rec."Order No.");
                        QCTestResult.SETRANGE("Line No.", rec."Line No.");
                        IF QCTestResult.FINDSET THEN
                            REPEAT
                                IF QCTestResult.Approved THEN
                                    Tested := TRUE
                                ELSE
                                    Tested := FALSE;
                            UNTIL QCTestResult.NEXT = 0;
                        IF Tested THEN BEGIN
                            PurchaseLine.RESET;
                            PurchaseLine.SETRANGE("Document No.", rec."Order No.");
                            PurchaseLine.SETRANGE("Line No.", rec."Line No.");
                            IF PurchaseLine.FINDFIRST THEN BEGIN
                                PurchaseLine."QC Approved" := TRUE;
                                //PurchaseLine.VALIDATE(PurchaseLine."Qty. to Receive",QCTestResult."Qty to Approve");
                                PurchaseLine.MODIFY;
                                WhsRecptLine.RESET;
                                WhsRecptLine.SETRANGE(WhsRecptLine."Source Type", 39);
                                WhsRecptLine.SETRANGE(WhsRecptLine."Source Document", WhsRecptLine."Source Document"::"Purchase Order");
                                WhsRecptLine.SETRANGE(WhsRecptLine."Source No.", rec."Order No.");
                                WhsRecptLine.SETRANGE(WhsRecptLine."Source Line No.", rec."Line No.");
                                IF WhsRecptLine.FINDFIRST THEN BEGIN
                                    WhsRecptLine."QC Approved" := TRUE;
                                    //WhsRecptLine.VALIDATE(WhsRecptLine."Qty. to Receive",QCTestResult."Qty to Approve");
                                    WhsRecptLine.MODIFY;
                                END;
                            END;
                            MESSAGE('QC has been approved');
                            CurrPage.CLOSE;
                        END
                        ELSE
                            MESSAGE('QC Test Result has been submited, Some parameters yet to be submited to approve the Test');
                        //EBT/QC Func/0001
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE(PurchaseLine."Document No.", rec."Order No.");
        PurchaseLine.SETRANGE(PurchaseLine."Line No.", rec."Line No.");
        IF PurchaseLine.FINDFIRST THEN BEGIN
            IF PurchaseLine."Quantity Received" <> 0 THEN
                CurrPage.EDITABLE := FALSE
            ELSE
                CurrPage.EDITABLE := TRUE;
        END;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        ERROR('You cannot delete the QC Test Result');
    end;

    var
        PurchaseLine: Record 39;
        QCTestResult: Record 50002;
        Tested: Boolean;
        EntryNo: Integer;
        QCTestResult1: Record 50002;
        WhsRecptLine: Record 7317;
        TestedQC: Boolean;
        QCTestResultSubmit: Record 50002;
        RecWRL: Record 7317;
        RecWhseRcptLine: Record 7317;
        RecWRH: Record 7316;
        SalApprove: Record 50008;
        SalesApprovalEntry: Record 50009;
        SalesApprovalEntryNew: Record 50009;
        SAE17: Record 50009;
        RecWRLNew: Record 7317;
        SAE18: Record 50009;
    //SMTPMailSetup: Record 409;

    // [Scope('Internal')]
    procedure EmailNotification(DocType: Option QC; DocNo: Code[20]; SeqNo: Integer; SenderID: Code[50]; ReceiveID: Code[50]; FirstID: Code[50])
    var
        Emailmessage: Codeunit "Email Message"; //pcpl-064 11dec2023
                                                // SMTPMail: Codeunit 400;
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
        AppEmail: Text;
        UnitOfMeasureCode: Code[20];
        RecWRL: Record 7317;
        QtyBaseWhseRec: Decimal;
        RecWRH: Record 7316;
        ToRecipients: List of [text]; //pcpl-64 11dec2023   
    begin

        //     SMTPMailSetup.GET;//RSPLSUM01Apr21

        //     SubjectText := '';
        //     SenderName := '';
        //     SenderEmail := '';
        //     ReceiveEmail := '';
        //     Text18 := '';
        //     //DimText := '';
        //     CLEAR(SMTPMail);
        //     /*
        //     //>>Division Value
        //     DimVal.RESET;
        //     DimVal.SETRANGE("Dimension Code",'DIVISION');
        //     DimVal.SETRANGE(Code,"Shortcut Dimension 1 Code");
        //     IF DimVal.FINDFIRST THEN
        //       DimText := DimVal.Name;
        //     //>>Division Value
        //     */
        //     //>>SenderID
        //     User18.RESET;
        //     IF User18.GET(SenderID) THEN BEGIN
        //         User18.TESTFIELD("E-Mail");
        //         SenderEmail := User18."E-Mail";
        //         IF User18.Name <> '' THEN
        //             SenderName := User18.Name
        //         ELSE
        //             SenderName := SenderID;
        //     END;
        //     //<<SenderID

        //     IF SeqNo = 1 THEN BEGIN
        //         SubjectText := 'Microsoft Dynamics NAV: Approval Mail - ';
        //         Text18 := 'Requires Approval.';
        //         ReceiveEmail := SenderEmail;
        //     END;

        //     IF SeqNo = 2 THEN BEGIN
        //         SubjectText := 'Microsoft Dynamics NAV: Approved Mail - ';
        //         Text18 := 'has been Approved.';

        //         SAE18.RESET;
        //         SAE18.SETCURRENTKEY("Document Type", "Document No.");
        //         //RSPLSUM24Mar21--SAE18.SETRANGE("Document Type",DocType);
        //         IF DocType = DocType::QC THEN//RSPLSUM24Mar21
        //             SAE18.SETRANGE("Document Type", SAE18."Document Type"::QC);//RSPLSUM24Mar21
        //         SAE18.SETRANGE("Document No.", DocNo);
        //         SAE18.SETRANGE(Approved, TRUE);
        //         IF SAE18.FINDLAST THEN BEGIN
        //             User18.RESET;
        //             User18.SETRANGE("User ID", SAE18."User ID");
        //             IF User18.FINDFIRST THEN BEGIN
        //                 User18.TESTFIELD("E-Mail");
        //                 ReceiveEmail := User18."E-Mail";
        //             END;
        //         END;

        //     END;

        //     /*
        //     //>>CreditLimit
        //     CLEAR(CrAmt);
        //     CLEAR(OtAmt);
        //     CLEAR(ODAmt);
        //     Cust18.RESET;
        //     IF Cust18.GET("Sell-to Customer No.") THEN
        //     BEGIN
        //       Cust18.CALCFIELDS("Balance (LCY)");
        //       CrAmt := Cust18."Credit Limit (LCY)";
        //       OtAmt := Cust18."Balance (LCY)";
        //       ODAmt := Cust18.CalcOverdueBalance;
        //     END;
        //     //<<CreditLimit
        //     */
        //     //>>Email Body
        //     //RSPLSUM02Apr21--SMTPMail.CreateMessage(SenderName,SenderEmail,ReceiveEmail,SubjectText,'',TRUE);
        //     SMTPMail.CreateMessage(SenderName, SMTPMailSetup."User ID", ReceiveEmail, SubjectText, '', TRUE);//RSPLSUM02Apr21

        //     IF SeqNo = 1 THEN BEGIN
        //         SA18.RESET;
        //         SA18.SETCURRENTKEY("Document Type");
        //         SA18.SETRANGE("Document Type", DocType);
        //         SA18.SETRANGE("User ID", SenderID);
        //         IF SA18.FINDSET THEN
        //             REPEAT
        //                 User18.RESET;
        //                 User18.SETRANGE("User ID", SA18."Approvar ID");
        //                 IF User18.FINDFIRST THEN BEGIN
        //                     User18.TESTFIELD("E-Mail");
        //                     // SMTPMail.AddRecipients(User18."E-Mail"); //pcpl-064 11dec2023
        //                     ToRecipients.Add(User18."E-Mail"); //pcpl-064 11dec2023
        //                 END;
        //             UNTIL SA18.NEXT = 0;
        //     END;

        //     IF SeqNo = 2 THEN BEGIN
        //         SAE18.RESET;
        //         SAE18.SETCURRENTKEY("Document Type", "Document No.");
        //         SAE18.SETRANGE("Document Type", DocType);
        //         SAE18.SETRANGE("Document No.", DocNo);
        //         SAE18.SETRANGE(Approved, TRUE);
        //         IF SAE18.FINDLAST THEN BEGIN
        //             IF FirstID = '' THEN BEGIN
        //                 User18.RESET;
        //                 User18.SETRANGE("User ID", SAE18."Approvar ID");
        //                 IF User18.FINDFIRST THEN BEGIN
        //                     User18.TESTFIELD("E-Mail");
        //                     //SMTPMail.AddRecipients(User18."E-Mail"); //pcpl-064 11dec2023
        //                     ToRecipients.Add(User18."E-Mail"); //pcpl-064 11dec2023

        //                 END;
        //             END;
        //         END;
        //     END;

        //     Emailmessage.AppendToBody('<Br>');
        //     Emailmessage.AppendToBody('<Br>');
        //     Emailmessage.AppendToBody('<B> Microsoft Dynamics NAV Document Approval System </B>');
        //     Emailmessage.AppendToBody('<Br>');
        //     Emailmessage.AppendToBody('<Br> <B> Warehouse Receipt No.  - </B>' + '<B>' + DocNo + '</B>' + ' ' + Text18);
        //     Emailmessage.AppendToBody('<Br>');
        //     Emailmessage.AppendToBody('<Br>');
        //     Emailmessage.AppendToBody('<Table  Border="1">');//Table Start
        //     Emailmessage.AppendToBody('<tr>');
        //     Emailmessage.AppendToBody('<th>Company Name </th>');
        //     Emailmessage.AppendToBody('<td>' + COMPANYNAME + '</td>');
        //     Emailmessage.AppendToBody('</tr>');

        //     Emailmessage.AppendToBody('<tr>');
        //     Emailmessage.AppendToBody('<th>Warehouse Receipt No.</th>');
        //     Emailmessage.AppendToBody('<td>' + DocNo + '</td>');
        //     Emailmessage.AppendToBody('</tr>');
        //     /*
        //     SMTPMail.AppendBody('<tr>');
        //     SMTPMail.AppendBody('<th>Customer</th>');
        //     SMTPMail.AppendBody('<td>'+"Sell-to Customer No."+'  '+"Sell-to Customer Name"+'</td>');
        //     SMTPMail.AppendBody('</tr>');
        //     */
        //     Emailmessage.AppendToBody('<tr>');
        //     Emailmessage.AppendToBody('<th>Supply Location</th>');

        //     RecWRH.RESET;
        //     IF RecWRH.GET(DocNo) THEN;

        //     Loc21.RESET;
        //     IF Loc21.GET(RecWRH."Location Code") THEN;

        //     Emailmessage.AppendToBody('<td>' + Loc21.Name + '</td>');
        //     Emailmessage.AppendToBody('</tr>');

        //     Emailmessage.AppendToBody('<tr>');
        //     Emailmessage.AppendToBody('<th>Quantity</th>');
        //     QtyBaseWhseRec := 0;
        //     RecWRL.RESET;
        //     RecWRL.SETCURRENTKEY("No.");
        //     RecWRL.SETRANGE("No.", DocNo);
        //     IF RecWRL.FINDSET THEN
        //         REPEAT
        //             QtyBaseWhseRec += RecWRL."Qty. (Base)";
        //         UNTIL RecWRL.NEXT = 0;

        //     Emailmessage.AppendToBody('<td>' + FORMAT(QtyBaseWhseRec, 0, '<Integer Thousand><Decimals,3>') + '</td>');
        //     Emailmessage.AppendToBody('</tr>');
        //     /*
        //     SMTPMail.AppendBody('<tr>');
        //     SMTPMail.AppendBody('<th>Gross Amount </th>');
        //     CALCFIELDS("Amount to Customer");
        //     SMTPMail.AppendBody('<td>'+FORMAT("Amount to Customer",0,'<Integer Thousand><Decimals,3>')+'</td>');
        //     SMTPMail.AppendBody('</tr>');
        //     */
        //     /*
        //     SMTPMail.AppendBody('<tr>');
        //     SMTPMail.AppendBody('<th>Due Date </th>');
        //     SMTPMail.AppendBody('<td>'+FORMAT("Due Date")+'</td>');
        //     SMTPMail.AppendBody('</tr>');
        //     */
        //     Emailmessage.AppendToBody('<tr>');
        //     Emailmessage.AppendToBody('<th>Credit Limit </th>');
        //     Emailmessage.AppendToBody('<td>' + FORMAT(CrAmt, 0, '<Integer Thousand><Decimals,3>') + '</td>');
        //     Emailmessage.AppendToBody('</tr>');

        //     Emailmessage.AppendToBody('<tr>');
        //     Emailmessage.AppendToBody('<th>Total Outstanding Amount </th>');
        //     Emailmessage.AppendToBody('<td>' + FORMAT(OtAmt, 0, '<Integer Thousand><Decimals,3>') + '</td>');
        //     Emailmessage.AppendToBody('</tr>');

        //     Emailmessage.AppendToBody('<tr>');
        //     Emailmessage.AppendToBody('<th>Overdue Amount </th>');
        //     Emailmessage.AppendToBody('<td>' + FORMAT(ODAmt, 0, '<Integer Thousand><Decimals,3>') + '</td>');
        //     Emailmessage.AppendToBody('</tr>');
        //     /*
        //     //>>Rejection Remarks
        //     IF (SeqNo = 5)  THEN
        //     BEGIN
        //       SMTPMail.AppendBody('<tr>');
        //       SMTPMail.AppendBody('<th>Rejection Remarks</th>');
        //       SMTPMail.AppendBody('<td>'+"Approval Description"+'</td>');
        //       SMTPMail.AppendBody('</tr>');
        //     END;
        //     //<<Rejection Remarks

        //     //>>Credit OverDue Remarks
        //     IF (SeqNo = 6) OR (SeqNo = 7) THEN
        //     BEGIN
        //       SMTPMail.AppendBody('<tr>');
        //       SMTPMail.AppendBody('<th>Rejection Remarks</th>');
        //       SMTPMail.AppendBody('<td>'+"Credit / OverDue Remarks"+'</td>');
        //       SMTPMail.AppendBody('</tr>');
        //     END;
        //     //<<Credit OverDue Remarks
        //     */
        //     Emailmessage.AppendToBody('</table>');//Table End
        //     Emailmessage.AppendToBody('<Br>');
        //     Emailmessage.AppendToBody('<Br>');
        //     //SMTPMail.Send; //pcpl-64 11dec2023
        //     EMail.Send(Emailmessage, Enum::"Email Scenario"::Default);
        //     //<<Email Body

    end;
}

