page 50128 "GP Approval Entries"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = 50009;
    SourceTableView = SORTING("Document No.")
                      WHERE("Document Type" = FILTER('Customer | Customer OCL|Customer KYC'),
                            Rejected = CONST(false),
                            Cancelled = CONST(false));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                    Caption = 'Customer No.';
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("User Name"; rec."User Name")
                {
                    ApplicationArea = all;
                }
                field("Approvar ID"; rec."Approvar ID")
                {
                    ApplicationArea = all;
                }
                field("Date Sent for Approval"; rec."Date Sent for Approval")
                {
                    ApplicationArea = all;
                }
                field("Time Sent for Approval"; rec."Time Sent for Approval")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approve)
            {
                Caption = '&Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ApproveVisible;
                ApplicationArea = all;
                trigger OnAction()
                var
                    ApprovalEntry: Record 50009;
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    IF ApprovalEntry.FIND('-') THEN
                        REPEAT
                            //ApprovalMgt.ApproveApprovalRequest(ApprovalEntry);
                            IF ApprovalEntry."Document Type" = ApprovalEntry."Document Type"::Customer THEN BEGIN
                                Cust01.RESET;
                                IF Cust01.GET(ApprovalEntry."Document No.") THEN BEGIN
                                    Cust01.Blocked := Cust01.Blocked::" ";
                                    Cust01.VALIDATE(Blocked);
                                    Cust01."Approval Status" := Cust01."Approval Status"::Approved;
                                    //RSPLSUM 19Jun2020>>
                                    IF Cust01."Customer Type" = Cust01."Customer Type"::"Local" THEN BEGIN
                                        Cust01."Credit Limit Approval" := FALSE;
                                        Cust01.VALIDATE("Credit Limit Approval Status", Cust01."Credit Limit Approval Status"::Approved);
                                    END;
                                    //RSPLSUM 19Jun2020<<
                                    Cust01.MODIFY(TRUE);
                                END;
                                ApprovalEntry.Approved := TRUE;
                                ApprovalEntry."Approval Date" := TODAY;
                                ApprovalEntry."Approval Time" := TIME;
                                ApprovalEntry.MODIFY;

                                SAE21.RESET;
                                SAE21.SETCURRENTKEY("Document No.", "Version No.");
                                SAE21.SETRANGE("Document Type", 9);
                                SAE21.SETRANGE("Document No.", ApprovalEntry."Document No.");
                                SAE21.SETRANGE("Version No.", ApprovalEntry."Version No.");
                                SAE21.SETRANGE(Approved, FALSE);
                                IF SAE21.FINDFIRST THEN BEGIN
                                    SAE21.DELETEALL(TRUE);
                                END;

                                //>>EmailAlert
                                SRSetup.GET;
                                IF SRSetup."Email Alert On Customer App" THEN
                                    EmailNotification(3, rec."Document No.", 1, USERID);
                                //<<EmailAlert
                            END;

                            IF ApprovalEntry."Document Type" = ApprovalEntry."Document Type"::"Customer OCL" THEN BEGIN
                                Cust01.RESET;
                                IF Cust01.GET(ApprovalEntry."Document No.") THEN BEGIN
                                    Cust01."Credit Limit Approval" := FALSE;
                                    Cust01.VALIDATE("Credit Limit Approval Status", Cust01."Credit Limit Approval Status"::Approved);
                                    Cust01.MODIFY(TRUE);
                                END;
                                ApprovalEntry.Approved := TRUE;
                                ApprovalEntry."Approval Date" := TODAY;
                                ApprovalEntry."Approval Time" := TIME;
                                ApprovalEntry.MODIFY;

                                SAE21.RESET;
                                SAE21.SETCURRENTKEY("Document No.", "Version No.");
                                SAE21.SETRANGE("Document Type", 10);
                                SAE21.SETRANGE("Document No.", ApprovalEntry."Document No.");
                                SAE21.SETRANGE("Version No.", ApprovalEntry."Version No.");
                                SAE21.SETRANGE(Approved, FALSE);
                                IF SAE21.FINDFIRST THEN BEGIN
                                    SAE21.DELETEALL(TRUE);
                                END;

                                //>>EmailAlert
                                SRSetup.GET;
                                IF SRSetup."Email Alert On Customer Credit" THEN
                                    EmailNotification(4, rec."Document No.", 2, USERID);
                                //<<EmailAlert

                            END;

                            //RSPLAM29597 ++Begin
                            IF ApprovalEntry."Document Type" = ApprovalEntry."Document Type"::"Customer KYC" THEN BEGIN
                                Cust01.RESET;
                                IF Cust01.GET(ApprovalEntry."Document No.") THEN BEGIN
                                    Cust01.VALIDATE("KYC Approval Status", Cust01."KYC Approval Status"::Approved);

                                    Cust01.MODIFY(TRUE);
                                END;
                                ApprovalEntry.Approved := TRUE;
                                ApprovalEntry."Approval Date" := TODAY;
                                ApprovalEntry."Approval Time" := TIME;
                                ApprovalEntry.MODIFY;

                                SAE21.RESET;
                                SAE21.SETCURRENTKEY("Document No.", "Version No.");
                                SAE21.SETRANGE("Document Type", 11);
                                SAE21.SETRANGE("Document No.", ApprovalEntry."Document No.");
                                SAE21.SETRANGE("Version No.", ApprovalEntry."Version No.");
                                SAE21.SETRANGE(Approved, FALSE);
                                IF SAE21.FINDFIRST THEN BEGIN
                                    SAE21.DELETEALL(TRUE);
                                END;

                                SRSetup.GET;
                                IF SRSetup."Email Alert On Customer KYC" THEN
                                    EmailNotification(5, rec."Document No.", 1, USERID);

                            END;
                        //RSPLAM29597 --END
                        UNTIL ApprovalEntry.NEXT = 0;
                end;
            }
            action(Reject)
            {
                Caption = '&Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = RejectVisible;
                ApplicationArea = all;
                trigger OnAction()
                var
                    ApprovalEntry: Record 50009;
                    //ApprovalSetup: Record 452;
                    ApprovalCommentLine: Record 455;
                    ApprovalComment: Page 660;
                begin
                    CurrPage.SETSELECTIONFILTER(ApprovalEntry);
                    IF ApprovalEntry.FIND('-') THEN
                        REPEAT

                            IF ApprovalEntry."Document Type" = ApprovalEntry."Document Type"::Customer THEN BEGIN
                                Cust01.RESET;
                                IF Cust01.GET(ApprovalEntry."Document No.") THEN BEGIN
                                    Cust01."Approval Status" := Cust01."Approval Status"::Rejected;
                                    Cust01.MODIFY(TRUE);
                                END;
                                ApprovalEntry.Rejected := TRUE;
                                ApprovalEntry."Rejected Date" := TODAY;
                                ApprovalEntry."Rejected Time" := TIME;
                                ApprovalEntry.MODIFY;
                                //>>EmailAlert
                                SRSetup.GET;
                                IF SRSetup."Email Alert On Customer App" THEN
                                    EmailNotification(3, rec."Document No.", 3, USERID);
                                //<<EmailAlert

                            END;

                            IF ApprovalEntry."Document Type" = ApprovalEntry."Document Type"::"Customer OCL" THEN BEGIN
                                Cust01.RESET;
                                IF Cust01.GET(ApprovalEntry."Document No.") THEN BEGIN
                                    Cust01.VALIDATE("Credit Limit Approval Status", Cust01."Credit Limit Approval Status"::Rejected);
                                    ;
                                    Cust01.MODIFY(TRUE);
                                END;
                                ApprovalEntry.Rejected := TRUE;
                                ApprovalEntry."Rejected Date" := TODAY;
                                ApprovalEntry."Rejected Time" := TIME;
                                ApprovalEntry.MODIFY;
                                //>>EmailAlert
                                SRSetup.GET;
                                IF SRSetup."Email Alert On Customer Credit" THEN
                                    EmailNotification(4, rec."Document No.", 4, USERID);
                                //<<EmailAlert

                            END;

                            //RSPLAM29597 --Begin
                            IF ApprovalEntry."Document Type" = ApprovalEntry."Document Type"::"Customer KYC" THEN BEGIN
                                Cust01.RESET;
                                IF Cust01.GET(ApprovalEntry."Document No.") THEN BEGIN
                                    Cust01.VALIDATE("KYC Approval Status", Cust01."KYC Approval Status"::Rejected);
                                    Cust01.MODIFY(TRUE);
                                END;
                                ApprovalEntry.Rejected := TRUE;
                                ApprovalEntry."Rejected Date" := TODAY;
                                ApprovalEntry."Rejected Time" := TIME;
                                ApprovalEntry.MODIFY;
                                //>>EmailAlert
                                SRSetup.GET;
                                IF SRSetup."Email Alert On Customer KYC" THEN
                                    EmailNotification(5, rec."Document No.", 4, USERID);
                                //<<EmailAlert

                            END;
                        //RSPLAM29597 ++End
                        UNTIL ApprovalEntry.NEXT = 0;
                end;
            }
            action("Show Customer Card")
            {
                Image = View;
                Promoted = true;
                Visible = RejectVisible;
                ApplicationArea = all;
                trigger OnAction()
                begin

                    Cus21.RESET;
                    IF Cus21.GET(rec."Document No.") THEN
                        PAGE.RUN(21, Cus21);
                end;
            }
        }
    }

    trigger OnInit()
    begin

        RejectVisible := TRUE;
        ApproveVisible := TRUE;
    end;

    trigger OnOpenPage()
    begin

        rec.SETCURRENTKEY("Document No.");
        rec.FILTERGROUP(2);
        rec.SETFILTER("Approvar ID", USERID);
        rec.SETRANGE(Approved, FALSE);
        rec.SETRANGE(Rejected, FALSE);
        rec.SETRANGE(Cancelled, FALSE);
        rec.FILTERGROUP(0);

        IF rec.COUNT = 0 THEN BEGIN
            ApproveVisible := FALSE;
            RejectVisible := FALSE;
        END;
    end;

    var
        SRSetup: Record 311;
        ApproveVisible: Boolean;
        RejectVisible: Boolean;
        Cust01: Record 18;
        SAE21: Record 50009;
        Cus21: Record 18;
    //SMTPMailSetup: Record 409;

    //  [Scope('Internal')]
    procedure EmailNotification(DocType: Option " ",SalesOrder,SalesInvoice,Customer,"Customer OCL","Customer KYC"; DocNo: Code[20]; SeqNo: Integer; SenderID: Code[50])
    var
        //SMTPMail: Codeunit 400;
        SAE18: Record 50009;
        SA18: Record 50008;
        SubjectText: Text;
        User18: Record 91;
        SenderName: Text;
        SenderEmail: Text;
        ReceiveEmail: Text;
        Text18: Text;
        Cust18: Record 18;
        CustName: Text;
        OtAmt: Decimal;
        CrAmt: Decimal;
    begin
        /*
        SMTPMailSetup.GET;//RSPLSUM06Apr21

        SubjectText := '';
        SenderName := '';
        SenderEmail := '';
        Text18 := '';
        CLEAR(SMTPMail);

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
            Text18 := 'Has Been Approved.';
        END;


        IF SeqNo = 2 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Credit Limit Approval Mail';
            Text18 := 'Credit Limit Has Been Approved.';
        END;

        IF SeqNo = 3 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Rejection Mail';
            Text18 := 'Has Been Rejected.';
        END;


        IF SeqNo = 4 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Credit Limit Approval Mail';
            Text18 := 'Credit Limit Approval Has Been Rejected.';
        END;


        //>>ReceiveEmail
        ReceiveEmail := '';
        User18.RESET;
        IF User18.GET("User ID") THEN BEGIN
            User18.TESTFIELD("E-Mail");
            ReceiveEmail := User18."E-Mail";
        END;
        //<<ReceiveEmail

        //>>CustomerName
        CustName := '';
        Cust18.RESET;
        IF Cust18.GET("Document No.") THEN
            CustName := Cust18.Name;
        //<<CustomerName

        //>>Email Body
        //RSPLSUM06Apr21--SMTPMail.CreateMessage(SenderName,SenderEmail,ReceiveEmail,SubjectText,'',TRUE);
        SMTPMail.CreateMessage(SenderName, SMTPMailSetup."User ID", ReceiveEmail, SubjectText, '', TRUE);//RSPLSUM06Apr21

        SMTPMail.AppendBody('<Br>');
        SMTPMail.AppendBody('<Br>');
        SMTPMail.AppendBody('<B> Microsoft Dynamics NAV Document Approval System </B>');
        SMTPMail.AppendBody('<Br>');
        SMTPMail.AppendBody('<Br> <B> Customer No.  - </B>' + '<B>' + "Document No." + '</B>' + ' ' + Text18);
        SMTPMail.AppendBody('<Br>');
        SMTPMail.AppendBody('<Br>');
        SMTPMail.AppendBody('<Table  Border="1">');//Table Start
        SMTPMail.AppendBody('<tr>');
        SMTPMail.AppendBody('<th>Company Name </th>');
        SMTPMail.AppendBody('<td>' + COMPANYNAME + '</td>');
        SMTPMail.AppendBody('</tr>');
        SMTPMail.AppendBody('<tr>');
        SMTPMail.AppendBody('<th>Customer</th>');
        SMTPMail.AppendBody('<td>' + "Document No." + '  ' + CustName + '</td>');
        SMTPMail.AppendBody('</tr>');
        /*
        SMTPMail.AppendBody('<tr>');
        SMTPMail.AppendBody('<th>Due Date </th>');
        SMTPMail.AppendBody('<td>'+FORMAT("Due Date")+'</td>');
        SMTPMail.AppendBody('</tr>');
        */
        /*
                SMTPMail.AppendBody('</table>');//Table End
                SMTPMail.AppendBody('<Br>');
                SMTPMail.AppendBody('<Br>');
                SMTPMail.Send;
                //<<Email Body
        */
    end;
}

