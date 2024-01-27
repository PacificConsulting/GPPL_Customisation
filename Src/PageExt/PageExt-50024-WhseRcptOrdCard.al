pageextension 50024 WhseRcptOrdeCardExtCstm extends "Warehouse Receipt"
{
    layout
    {
        modify("Posting Date")
        {
            Editable = false;
        }
        addafter("Posting Date")
        {
            field("Receiving Date"; Rec."Receiving Date")
            {
                ApplicationArea = all;
            }
            field("Density Factor"; Rec."Density Factor")
            {
                ApplicationArea = all;
            }
            field("Vendor Quantity"; Rec."Vendor Quantity")
            {
                ApplicationArea = all;
            }
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = all;
            }
            field("Tare Weight"; Rec."Tare Weight")
            {

                ApplicationArea = all;
                Style = Attention;
                StyleExpr = TRUE;
            }
            field("Gate Entry No."; Rec."Gate Entry No.")
            {
                ApplicationArea = all;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = all;
            }
            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = all;
            }
            field("QC Status"; Rec."QC Status")
            {
                ApplicationArea = all;
            }

        }
    }

    actions
    {
        modify("Post Receipt")
        {
            trigger OnBeforeAction()
            var
                RecVendor: Record Vendor;
                RecWhseReceiptLine: Record "Warehouse Receipt Line";
                recWhsRcptLine: Record "Warehouse Receipt Line";
                RecPH: Record "Purchase Header";
                Qty2Receive: Decimal;
                RecWRL: Record "Warehouse Receipt Line";
            begin
                RecWhseReceiptLine.RESET;
                RecWhseReceiptLine.SETCURRENTKEY("Source Document", "No.");
                RecWhseReceiptLine.SETRANGE("Source Document", RecWhseReceiptLine."Source Document"::"Purchase Order");
                RecWhseReceiptLine.SETRANGE("No.", Rec."No.");
                IF RecWhseReceiptLine.FINDSET THEN begin
                    //REPEAT
                    RecPH.RESET;
                    IF RecPH.GET(RecPH."Document Type"::Order, RecWhseReceiptLine."Source No.") THEN BEGIN
                        RecVendor.RESET;
                        IF RecVendor.GET(RecPH."Buy-from Vendor No.") THEN BEGIN
                            IF RecVendor."IRN Applicable" THEN
                                MESSAGE('IRN is applicable for vendor=%1', RecVendor.Name);
                        END;
                    END;
                    // UNTIL RecWhseReceiptLine.NEXT = 0;
                end;

                //EBT STIVAN---(01/03/2013)---Error Message Pop Up,If Vendor Qty*Density Factor < Qty to Receive -----BEGIN
                IF (Rec."Density Factor" <> 0) AND (Rec."Vendor Quantity" <> 0) THEN BEGIN
                    //Qty2Receive := ROUND(("Vendor Quantity" * "Density Factor"),1.0,'=');
                    Qty2Receive := ROUND((Rec."Vendor Quantity" * Rec."Density Factor"), 1.0, '>'); //EBT091


                    recWhsRcptLine.RESET;
                    recWhsRcptLine.SETRANGE(recWhsRcptLine."Source Document", recWhsRcptLine."Source Document"::"Purchase Order");
                    recWhsRcptLine.SETRANGE(recWhsRcptLine."No.", Rec."No.");
                    IF recWhsRcptLine.FINDFIRST THEN BEGIN
                        IF Qty2Receive < recWhsRcptLine."Qty. to Receive" THEN
                            ERROR('Qty to Receive should not be greater then %1', Qty2Receive);
                    END;
                END;
                //EBT STIVAN---(01/03/2013)---Error Message Pop Up,If Vendor Qty*Density Factor < Qty to Receive -------END

                //RSPLSUM28688 23Feb21>>
                IF (Rec."QC Status" = Rec."QC Status"::Open) OR (Rec."QC Status" = Rec."QC Status"::"Pending for Approval") THEN BEGIN
                    RecWRL.RESET;
                    RecWRL.SETRANGE(RecWRL."Source Document", RecWRL."Source Document"::"Purchase Order");
                    RecWRL.SETRANGE(RecWRL."No.", Rec."No.");
                    RecWRL.SETRANGE("QC Applicable", TRUE);
                    IF RecWRL.FINDFIRST THEN
                        Rec.TESTFIELD("QC Status", Rec."QC Status"::Approved);
                END;
                //RSPLSUM28688 23Feb21<<

            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
                RecVendor: Record Vendor;
                RecWhseReceiptLine: Record "Warehouse Receipt Line";
                recWhsRcptLine: Record "Warehouse Receipt Line";
                RecPH: Record "Purchase Header";
                Qty2Receive: Decimal;
                RecWRL: Record "Warehouse Receipt Line";
            begin
                RecWhseReceiptLine.RESET;
                RecWhseReceiptLine.SETCURRENTKEY("Source Document", "No.");
                RecWhseReceiptLine.SETRANGE("Source Document", RecWhseReceiptLine."Source Document"::"Purchase Order");
                RecWhseReceiptLine.SETRANGE("No.", Rec."No.");
                IF RecWhseReceiptLine.FINDSET THEN begin
                    //REPEAT
                    RecPH.RESET;
                    IF RecPH.GET(RecPH."Document Type"::Order, RecWhseReceiptLine."Source No.") THEN BEGIN
                        RecVendor.RESET;
                        IF RecVendor.GET(RecPH."Buy-from Vendor No.") THEN BEGIN
                            IF RecVendor."IRN Applicable" THEN
                                MESSAGE('IRN is applicable for vendor=%1', RecVendor.Name);
                        END;
                    END;
                    // UNTIL RecWhseReceiptLine.NEXT = 0;
                end;

                //EBT STIVAN---(01/03/2013)---Error Message Pop Up,If Vendor Qty*Density Factor < Qty to Receive -----BEGIN
                IF (Rec."Density Factor" <> 0) AND (Rec."Vendor Quantity" <> 0) THEN BEGIN
                    //Qty2Receive := ROUND(("Vendor Quantity" * "Density Factor"),1.0,'=');
                    Qty2Receive := ROUND((Rec."Vendor Quantity" * Rec."Density Factor"), 1.0, '>'); //EBT091


                    recWhsRcptLine.RESET;
                    recWhsRcptLine.SETRANGE(recWhsRcptLine."Source Document", recWhsRcptLine."Source Document"::"Purchase Order");
                    recWhsRcptLine.SETRANGE(recWhsRcptLine."No.", Rec."No.");
                    IF recWhsRcptLine.FINDFIRST THEN BEGIN
                        IF Qty2Receive < recWhsRcptLine."Qty. to Receive" THEN
                            ERROR('Qty to Receive should not be greater then %1', Qty2Receive);
                    END;
                END;
                //EBT STIVAN---(01/03/2013)---Error Message Pop Up,If Vendor Qty*Density Factor < Qty to Receive -------END

                //RSPLSUM28688 23Feb21>>
                IF (Rec."QC Status" = Rec."QC Status"::Open) OR (Rec."QC Status" = Rec."QC Status"::"Pending for Approval") THEN BEGIN
                    RecWRL.RESET;
                    RecWRL.SETRANGE(RecWRL."Source Document", RecWRL."Source Document"::"Purchase Order");
                    RecWRL.SETRANGE(RecWRL."No.", Rec."No.");
                    RecWRL.SETRANGE("QC Applicable", TRUE);
                    IF RecWRL.FINDFIRST THEN
                        Rec.TESTFIELD("QC Status", Rec."QC Status"::Approved);
                END;
                //RSPLSUM28688 23Feb21<<

            end;
        }
        addafter(CalculateCrossDock)
        {
            action("Send for QC Approval")
            {
                Image = Change;

                trigger OnAction()
                var
                    RecWhseRcptLine: Record 7317;
                    TempVersionNo: Integer;
                    SAE17: Record 50009;
                    SalesApproval: Record 50008;
                    TempSeqNo: Integer;
                    SalesApprovalEntry: Record 50009;
                    PurPaySetup: Record 312;
                begin
                    /*
                    RecWhseRcptLine.RESET;
                    RecWhseRcptLine.SETCURRENTKEY("No.","QC Applicable");
                    RecWhseRcptLine.SETRANGE("No.","No.");
                    RecWhseRcptLine.SETRANGE("QC Applicable",TRUE);
                    IF RecWhseRcptLine.FINDSET THEN
                    REPEAT
                      RecWhseRcptLine.TESTFIELD("Expiry Date");
                    UNTIL RecWhseRcptLine.NEXT = 0;
                    */

                    //IF NOT "Sent For Approval" THEN
                    //BEGIN
                    IF Rec."QC Status" = Rec."QC Status"::Open THEN BEGIN
                        TempVersionNo := 0;
                        SAE17.RESET;
                        SAE17.SETCURRENTKEY("Document No.", "Version No.");
                        SAE17.SETRANGE("Document Type", SAE17."Document Type"::QC);
                        SAE17.SETRANGE("Document No.", Rec."No.");
                        IF SAE17.FINDLAST THEN BEGIN
                            TempVersionNo := SAE17."Version No.";
                        END;

                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SalesApproval."Document Type"::QC);
                        SalesApproval.SETRANGE(SalesApproval."User ID", USERID);
                        SalesApproval.SETFILTER("Approvar ID", '<>%1', '');
                        IF SalesApproval.FINDSET THEN BEGIN
                            TempSeqNo := 0;
                            REPEAT
                                TempSeqNo += 1;
                                SalesApprovalEntry.INIT;
                                SalesApprovalEntry."Document Type" := SalesApprovalEntry."Document Type"::QC;
                                SalesApprovalEntry."Document No." := Rec."No.";
                                SalesApprovalEntry."User ID" := USERID;
                                SalesApprovalEntry."User Name" := SalesApproval.Name;
                                SalesApprovalEntry."Approvar ID" := SalesApproval."Approvar ID";
                                SalesApprovalEntry."Approver Name" := SalesApproval."Approvar Name";
                                SalesApprovalEntry."Mandatory ID" := SalesApproval.Mandatory;
                                SalesApprovalEntry."Date Sent for Approval" := TODAY;
                                SalesApprovalEntry."Time Sent for Approval" := TIME;
                                SalesApprovalEntry."Version No." := TempVersionNo + 1;
                                SalesApprovalEntry."Sequence No." := TempSeqNo;
                                //SalesApprovalEntry."Division Code" := "Shortcut Dimension 1 Code";
                                SalesApprovalEntry.INSERT;
                            UNTIL SalesApproval.NEXT = 0;

                            PurPaySetup.GET;
                            IF PurPaySetup."QC Approval Email Alert" THEN
                                EmailNotification(0, Rec."No.", 1, USERID, '', '');

                            MESSAGE('Document No. %1 has been sent for Approval', Rec."No.");
                        END
                        ELSE
                            ERROR('QC Approval setup does not exists for User %1', USERID);
                    END
                    ELSE
                        ERROR('Document No. %1 has already been sent for approval');

                    Rec."QC Status" := Rec."QC Status"::"Pending for Approval";
                    Rec.MODIFY;

                    //"Sent For Approval" := TRUE;

                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    BEGIN


        //>>RB-N  29Jun2018
        IF rec."No." <> '' THEN
            IF rec."Posting Date" <> TODAY THEN BEGIN
                rec."Posting Date" := TODAY;
                rec.MODIFY;
            END;
        //>>RB-N  29Jun2018
    END;

    var
        myInt: Integer;

    procedure EmailNotification(DocType: Option "Warehouse Receipt"; DocNo: Code[20]; SeqNo: Integer; SenderID: Code[50]; ReceiveID: Code[50]; FirstID: Code[50])
    var
        //SMTPMail: Codeunit "400";
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
        AppEmail: Text;
        UnitOfMeasureCode: Code[20];
        RecWRL: Record 7317;
        QtyBaseWhseRec: Decimal;
        EmailMsg: Codeunit "Email Message";
        EmailObj: Codeunit Email;
        RecipientType: Enum "Email Recipient Type";
    begin
        // SMTPMailSetup.GET;//RSPLSUM06Apr21

        SubjectText := '';
        SenderName := '';
        SenderEmail := '';
        ReceiveEmail := '';
        Text18 := '';
        //DimText := '';
        //CLEAR(SMTPMail);
        /*
        //>>Division Value
        DimVal.RESET;
        DimVal.SETRANGE("Dimension Code",'DIVISION');
        DimVal.SETRANGE(Code,"Shortcut Dimension 1 Code");
        IF DimVal.FINDFIRST THEN
          DimText := DimVal.Name;
        //>>Division Value
        */
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
            SubjectText := 'Microsoft Dynamics NAV: Approval Mail - ';
            Text18 := 'Requires Approval.';
            ReceiveEmail := SenderEmail;
        END;

        IF SeqNo = 2 THEN BEGIN
            SubjectText := 'Microsoft Dynamics NAV: Approved Mail - ';
            Text18 := 'has been Approved.';

            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", Rec."No.");
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

        /*
        //>>CreditLimit
        CLEAR(CrAmt);
        CLEAR(OtAmt);
        CLEAR(ODAmt);
        Cust18.RESET;
        IF Cust18.GET("Sell-to Customer No.") THEN
        BEGIN
          Cust18.CALCFIELDS("Balance (LCY)");
          CrAmt := Cust18."Credit Limit (LCY)";
          OtAmt := Cust18."Balance (LCY)";
          ODAmt := Cust18.CalcOverdueBalance;
        END;
        //<<CreditLimit
        */
        //>>Email Body
        //RSPLSUM06Apr21--SMTPMail.CreateMessage(SenderName,SenderEmail,ReceiveEmail,SubjectText,'',TRUE);
        //SMTPMail.CreateMessage(SenderName, SMTPMailSetup."User ID", ReceiveEmail, SubjectText, '', TRUE);//RSPLSUM06Apr21
        EmailMsg.Create(ReceiveEmail, SubjectText, '', true);

        IF SeqNo = 1 THEN BEGIN
            SA18.RESET;
            SA18.SETCURRENTKEY("Document Type");
            SA18.SETRANGE("Document Type", DocType);
            SA18.SETRANGE("User ID", SenderID);
            IF SA18.FINDSET THEN
                REPEAT
                    User18.RESET;
                    User18.SETRANGE("User ID", SA18."Approvar ID");
                    IF User18.FINDFIRST THEN BEGIN
                        User18.TESTFIELD("E-Mail");
                        //SMTPMail.AddRecipients(User18."E-Mail");
                        EmailMsg.AddRecipient(RecipientType::"TO", User18."E-Mail");
                    END;
                UNTIL SA18.NEXT = 0;
        END;

        IF SeqNo = 2 THEN BEGIN
            SAE18.RESET;
            SAE18.SETCURRENTKEY("Document Type", "Document No.");
            SAE18.SETRANGE("Document Type", DocType);
            SAE18.SETRANGE("Document No.", Rec."No.");
            SAE18.SETRANGE(Approved, TRUE);
            IF SAE18.FINDLAST THEN BEGIN
                IF FirstID = '' THEN BEGIN
                    User18.RESET;
                    User18.SETRANGE("User ID", SAE18."Approvar ID");
                    IF User18.FINDFIRST THEN BEGIN
                        User18.TESTFIELD("E-Mail");
                        //SMTPMail.AddRecipients(User18."E-Mail");
                        EmailMsg.AddRecipient(RecipientType::"TO", User18."E-Mail");
                    END;
                END;
            END;
        END;

        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<B> Microsoft Dynamics NAV Document Approval System </B>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br> <B> Warehouse Receipt No.  - </B>' + '<B>' + Rec."No." + '</B>' + ' ' + Text18);
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Table  Border="1">');//Table Start
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Company Name </th>');
        EmailMsg.AppendToBody('<td>' + COMPANYNAME + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Warehouse Receipt No.</th>');
        EmailMsg.AppendToBody('<td>' + Rec."No." + '</td>');
        EmailMsg.AppendToBody('</tr>');
        /*
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Customer</th>');
        EmailMsg.AppendToBody('<td>'+"Sell-to Customer No."+'  '+"Sell-to Customer Name"+'</td>');
        EmailMsg.AppendToBody('</tr>');
        */
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Supply Location</th>');
        Loc21.RESET;
        IF Loc21.GET(Rec."Location Code") THEN;
        EmailMsg.AppendToBody('<td>' + Loc21.Name + '</td>');
        EmailMsg.AppendToBody('</tr>');

        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Quantity</th>');
        QtyBaseWhseRec := 0;
        RecWRL.RESET;
        RecWRL.SETCURRENTKEY("No.");
        RecWRL.SETRANGE("No.", Rec."No.");
        IF RecWRL.FINDSET THEN
            REPEAT
                QtyBaseWhseRec += RecWRL."Qty. (Base)";
            UNTIL RecWRL.NEXT = 0;

        EmailMsg.AppendToBody('<td>' + FORMAT(QtyBaseWhseRec, 0, '<Integer Thousand><Decimals,3>') + '</td>');
        EmailMsg.AppendToBody('</tr>');
        /*
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Gross Amount </th>');
        CALCFIELDS("Amount to Customer");
        EmailMsg.AppendToBody('<td>'+FORMAT("Amount to Customer",0,'<Integer Thousand><Decimals,3>')+'</td>');
        EmailMsg.AppendToBody('</tr>');
        */
        /*
        EmailMsg.AppendToBody('<tr>');
        EmailMsg.AppendToBody('<th>Due Date </th>');
        EmailMsg.AppendToBody('<td>'+FORMAT("Due Date")+'</td>');
        EmailMsg.AppendToBody('</tr>');
        */
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
        /*
        //>>Rejection Remarks
        IF (SeqNo = 5)  THEN
        BEGIN
          EmailMsg.AppendToBody('<tr>');
          EmailMsg.AppendToBody('<th>Rejection Remarks</th>');
          EmailMsg.AppendToBody('<td>'+"Approval Description"+'</td>');
          EmailMsg.AppendToBody('</tr>');
        END;
        //<<Rejection Remarks
        
        //>>Credit OverDue Remarks
        IF (SeqNo = 6) OR (SeqNo = 7) THEN
        BEGIN
          EmailMsg.AppendToBody('<tr>');
          EmailMsg.AppendToBody('<th>Rejection Remarks</th>');
          EmailMsg.AppendToBody('<td>'+"Credit / OverDue Remarks"+'</td>');
          EmailMsg.AppendToBody('</tr>');
        END;
        //<<Credit OverDue Remarks
        */
        EmailMsg.AppendToBody('</table>');//Table End
        EmailMsg.AppendToBody('<Br>');
        EmailMsg.AppendToBody('<Br>');
        //SMTPMail.Send;
        EmailObj.Send(EmailMsg, Enum::"Email Scenario"::Default);
        //<<Email Body

    end;

}