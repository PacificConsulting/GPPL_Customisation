page 50041 "Transfer indent"
{
    // EBT091  29.03.2014  Validation added for short closed. If transfer indent date is less than 6th day of current month then
    //                     transfer indent will get short close.
    // Date        Version      Remarks
    // .....................................................................................
    // 09Mar2018   RB-N         Showing IndentLine with OutstandingQty not equal Zero (0)

    Caption = 'Transfer Indent';
    PageType = Document;
    Permissions = TableData 32 = rim;
    RefreshOnActivate = true;
    SourceTable = 50022;
    SourceTableView = WHERE("Captive Consumption" = FILTER(false),
                            "Short Closed" = CONST(false));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin

                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Transfer-from Code"; rec."Transfer-from Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Transfer-from Name"; rec."Transfer-from Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transfer-to Code"; rec."Transfer-to Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Transfer-to Name"; rec."Transfer-to Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("In-Transit Code"; rec."In-Transit Code")
                {
                    ApplicationArea = all;
                }
                field(Approve; rec.Approve)
                {
                    ApplicationArea = all;
                }
                field(Structure; rec.Structure)
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transfer indent Date"; rec."Transfer indent Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Short Closed"; rec."Short Closed")
                {
                    ApplicationArea = all;
                    Editable = "Short ClosedEditable";

                    trigger OnValidate()
                    begin
                        IF UPPERCASE(USERID) <> 'SA' THEN
                            ERROR('You dont have permission');
                    end;
                }
            }
            part(TransferLines; 50042)
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group("Transfer-from")
            {
                Caption = 'Transfer-from';
                field("Transfer-from Name 2"; rec."Transfer-from Name 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transfer-from Address"; rec."Transfer-from Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transfer-from Address 2"; rec."Transfer-from Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transfer-from Post Code"; rec."Transfer-from Post Code")
                {
                    ApplicationArea = all;
                    Caption = 'Transfer-from Post Code/City';
                    Editable = false;
                }
                field("Transfer-from City"; rec."Transfer-from City")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transfer-from Contact"; rec."Transfer-from Contact")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = all;
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
                {
                    ApplicationArea = all;
                }
                field("Shipping Time"; rec."Shipping Time")
                {
                    ApplicationArea = all;
                }
                field("Shipping Advice"; rec."Shipping Advice")
                {
                    ApplicationArea = all;
                }
            }
            group("Transfer-to")
            {
                Caption = 'Transfer-to';
                field("Transfer-to Name 2"; rec."Transfer-to Name 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transfer-to Address"; rec."Transfer-to Address")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transfer-to Address 2"; rec."Transfer-to Address 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transfer-to Post Code"; rec."Transfer-to Post Code")
                {
                    ApplicationArea = all;
                    Caption = 'Transfer-to Post Code/City';
                    Editable = false;
                }
                field("Transfer-to City"; rec."Transfer-to City")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transfer-to Contact"; rec."Transfer-to Contact")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Receipt Date"; rec."Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Vendor Invoice No."; rec."Vendor Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("Ship-To Code"; rec."Ship-To Code")
                {
                    ApplicationArea = all;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Transaction Type"; rec."Transaction Type")
                {
                    ApplicationArea = all;
                }
                field("Transaction Specification"; rec."Transaction Specification")
                {
                    ApplicationArea = all;
                }
                field("Transport Method"; rec."Transport Method")
                {
                    ApplicationArea = all;
                }
                field(Area1; rec.Area)
                {
                    ApplicationArea = all;
                }
                field("Entry/Exit Point"; rec."Entry/Exit Point")
                {
                    ApplicationArea = all;
                }
            }
            group(Others)
            {
                Caption = 'Others';
                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("Transporter Name"; rec."Transporter Name")
                {
                    ApplicationArea = all;
                }
                field("LR/RR No."; rec."LR/RR No.")
                {
                    ApplicationArea = all;
                }
                field("LR/RR Date"; rec."LR/RR Date")
                {
                    ApplicationArea = all;
                }
                field(Remarks; rec.Remarks)
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
            group("&Indent")
            {
                Caption = '&Indent';
                action(List)
                {
                    ApplicationArea = all;
                    Caption = 'List';
                    RunObject = Page 50043;
                    ShortCutKey = 'Shift+Ctrl+L';

                }
                action("Make &Order")
                {
                    ApplicationArea = all;

                    Caption = 'Make &Order';
                    Image = MakeOrder;


                    trigger OnAction()
                    begin
                        //for approval

                        transferindentLine.RESET;
                        transferindentLine.SETRANGE("Document No.", rec."No.");
                        transferindentLine.SETFILTER(transferindentLine."Qty. to Ship", '<>0');
                        IF transferindentLine.FINDFIRST THEN
                            REPEAT
                                transferindentLine.TESTFIELD(transferindentLine.Approve, TRUE);
                            UNTIL transferindentLine.NEXT = 0;

                        //EBT STIVAN ---(30102012)--- Validation, If Item No. is Blank in Lines -------START
                        TransLineAppr.RESET;
                        TransLineAppr.SETRANGE(TransLineAppr."Document No.", rec."No.");
                        TransLineAppr.SETRANGE(TransLineAppr.Approve, FALSE);
                        TransLineAppr.SETFILTER(TransLineAppr."Item No.", '=%1', '');
                        IF TransLineAppr.FINDFIRST THEN BEGIN
                            ERROR('Item No. is Blank in Line No. %1', TransLineAppr."Line No.");
                        END;
                        //EBT STIVAN ---(30102012)--- Validation, If Item No. is Blank in Lines ---------END
                        /*//RSPL-TC
                        //EBT STIVAN---(29/07/2013)---As per ROLE Assigned, MAke Order should be done-------START
                        Memberof.RESET;
                        Memberof.SETRANGE(Memberof."User ID",USERID);
                        Memberof.SETRANGE(Memberof."Role ID",'TROCREATION');
                        IF Memberof.FINDFIRST THEN */
                        //RSPL-TC +
                        AccessControl.RESET;
                        AccessControl.SETRANGE("User Name", USERID);
                        AccessControl.SETRANGE("Role ID", 'TROCREATION');
                        IF AccessControl.FINDFIRST THEN //RSPL-TC -
                        BEGIN
                            recTransferIndentHeader.CreateTransferOrder(Rec);
                        END
                        ELSE
                            ERROR('You dont have rights to create Transfer Order');
                        //EBT STIVAN---(29/07/2013)---As per ROLE Assigned, MAke Order should be done---------END

                    end;
                }
            }
        }
        area(reporting)
        {
            group("&Print")
            {
                Caption = '&Print';
                action("Print Order")
                {
                    ApplicationArea = all;
                    Caption = '&Print Order';
                    Image = Print;


                    trigger OnAction()
                    var
                        DocPrint: Codeunit 229;
                    begin
                        //EBT STIVAN ---(30102012)--- Validation, If Item No. is Blank in Lines -------START
                        TransLineAppr.RESET;
                        TransLineAppr.SETRANGE(TransLineAppr."Document No.", rec."No.");
                        TransLineAppr.SETRANGE(TransLineAppr.Approve, FALSE);
                        TransLineAppr.SETFILTER(TransLineAppr."Item No.", '=%1', '');
                        IF TransLineAppr.FINDFIRST THEN BEGIN
                            ERROR('Item No. is Blank in Line No. %1', TransLineAppr."Line No.");
                        END;
                        //EBT STIVAN ---(30102012)--- Validation, If Item No. is Blank in Lines ---------END

                        rectransferindent.RESET;
                        rectransferindent := Rec;
                        rectransferindent.SETRECFILTER;
                        REPORT.RUN(50148, TRUE, FALSE, rectransferindent);
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        rec.TESTFIELD(Status, rec.Status::Open);
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        IF RecordMarked = TRUE THEN BEGIN
            rec.MARK(TRUE);
            RecordMarked := FALSE;
        END;

        //rspl-Ragni
        IF rec.FIND(Which) THEN
            EXIT(TRUE)
        ELSE BEGIN
            rec.SETRANGE(rec."No.");
            EXIT(rec.FIND(Which));
        END;
        //rspl-Ragni
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        RecordMarked := TRUE;
    end;

    trigger OnOpenPage()
    begin
        YearPart := DATE2DMY(TODAY, 3);
        MonthPart := DATE2DMY(TODAY, 2);
        //>>RSPL-Rahul***Code moved to list page
        /*
        TIndentHeader.RESET();
        TIndentHeader.SETFILTER(TIndentHeader."Short Closed",'=%1',FALSE);
        TIndentHeader.SETFILTER(TIndentHeader."Transfer indent Date",'<>%1',0D);
        TIndentHeader.SETRANGE("No.","No.");  //>>RSPL-Rahul
        IF TIndentHeader.FINDFIRST THEN
        REPEAT
           NewDate :=  CALCDATE('-CM',TODAY)+ 5;     //EBT091
           IF NewDate <= TODAY THEN                   //EBT091
           BEGIN
            IF  (DATE2DMY(TIndentHeader."Transfer indent Date",3)<>YearPart) OR
                (DATE2DMY(TIndentHeader."Transfer indent Date",2) <> MonthPart)
                AND (TIndentHeader."Transfer indent Date" < NewDate) THEN       //EBT091
                BEGIN
                 TIndentHeader."Short Closed":=TRUE;
                 TIndentHeader.MODIFY();
                END;
           END;
        UNTIL TIndentHeader.NEXT=0;
        
        //EBT0001
        CSOMapping2.RESET;
        CSOMapping2.SETRANGE(CSOMapping2."User Id",UPPERCASE(USERID));
        IF CSOMapping2.FINDFIRST THEN
          BEGIN
          FILTERGROUP(2);
          TIH.RESET;
          TIH.SETRANGE("No.","No."); //RSPL/Migration/Rahul*****Allow to open card page for regarding document of list
          TIH.SETFILTER(TIH."Short Closed",'%1',FALSE);
          IF TIH.FINDSET THEN
          REPEAT
            CSOMapping.RESET;
            CSOMapping.SETRANGE(CSOMapping."User Id",UPPERCASE(USERID));
            CSOMapping.SETRANGE(CSOMapping.Type,CSOMapping.Type::"Responsibility Center");
            CSOMapping.SETRANGE(CSOMapping.Value,TIH."Responsibility Center");
            IF CSOMapping.FINDFIRST THEN
               TIH.MARK := TRUE
            ELSE
            BEGIN
              CSOMapping1.RESET;
              CSOMapping1.SETRANGE("User Id",UPPERCASE(USERID));
              CSOMapping1.SETRANGE(Type,CSOMapping.Type::Location);
              CSOMapping1.SETFILTER(Value,'%1|%2',TIH."Transfer-from Code",TIH."Transfer-to Code");
              IF CSOMapping1.FINDFIRST THEN
                 TIH.MARK := TRUE
             END;
          UNTIL TIH.NEXT = 0;
          TIH.MARKEDONLY(TRUE);
          COPY(TIH);
          FILTERGROUP(2);
        END;
        //EBT0001
        
        
        //EBT STIVAN (29052012) --- To Make Short Close Field Editable only to User ID SA -------START
        User.GET(USERID);
        IF (User."User ID" = 'SA') THEN
        "Short ClosedEditable" := TRUE;
        //EBT STIVAN (29052012) --- To Make Short Close Field Editable only to User ID SA ---------END
        */
        //<<RSPl-Rahul

    end;

    var
        //UserMgt: Codeunit 5700;
        Location: Record 14;
        Usersetup: Record 91;
        TrasnHdr: Record 50022;
        TransLine: Record 50023;
        i: Integer;
        TransferHeader: Record 50022;
        YearPart: Integer;
        MonthPart: Integer;
        RecordMarked: Boolean;
        Approve: Boolean;
        SalesSetup: Record 311;
        TransLineAppr: Record 50023;
        reclocationfrom: Record 14;
        reclocationto: Record 14;
        fromresp: Code[20];
        toresp: Code[20];
        recTransferIndentHeader: Record 50022;
        rectransferindent: Record 50022;
        transferindentLine: Record 50023;
        TIndentHeader: Record 50022;
        CSOMapping: Record 50006;
        CSOMapping1: Record 50006;
        CSOMapping2: Record 50006;
        TIH: Record 50022;
        SalesApproval: Record 50008;
        User: Record 91;
        NewDate: Date;
        // [InDataSet]
        "Short ClosedEditable": Boolean;
        AccessControl: Record 2000000053;
}

