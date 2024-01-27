page 50093 "Cancel IRN/Eway Bill"
{
    Caption = 'Cancel';
    Permissions = TableData 112 = rm;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group("Cancel IRN")
            {
                Caption = 'Cancel IRN';
                Visible = IRNGroupVisible;
                field(IRN; IRN)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("IRN Cancel Reason Code"; cancelRsnCodeEinv)
                {
                    ApplicationArea = all;
                    Caption = 'Cancel Reason';
                    TableRelation = "Reason Code";

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ReasonCode.RESET;
                        ReasonCode.FILTERGROUP(2);
                        ReasonCode.SETRANGE(EWB, TRUE);
                        ReasonCode.FILTERGROUP(0);
                        IF PAGE.RUNMODAL(0, ReasonCode) = ACTION::LookupOK THEN
                            cancelRsnCodeEinv := ReasonCode.Code;
                    end;
                }
                field("IRN Cancel Remark"; cancelRmrkEinv)
                {
                    ApplicationArea = all;
                    Caption = 'Cancel Remark';
                }
            }
            group("Cancel E-Way Bill")
            {
                Caption = 'Cancel E-Way Bill';
                Visible = EwayBillGroupVisible;
                field(EwbNo1; EwbNo)
                {
                    ApplicationArea = all;
                    Caption = 'Ewb No';
                    Editable = false;
                }
                field("Eway Cancel Reason Code"; cancelRsnCodeEwaybill)
                {
                    ApplicationArea = all;
                    Caption = 'Cancel Reason';
                    TableRelation = "Reason Code";

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ReasonCode.RESET;
                        ReasonCode.FILTERGROUP(2);
                        ReasonCode.SETRANGE(EWB, TRUE);
                        ReasonCode.FILTERGROUP(0);
                        IF PAGE.RUNMODAL(0, ReasonCode) = ACTION::LookupOK THEN
                            cancelRsnCodeEwaybill := ReasonCode.Code;
                    end;
                }
                field("Eway Cancel Remark"; cancelRmrkEwaybill)
                {
                    ApplicationArea = all;
                    Caption = 'Cancel Remark';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(group1)
            {
                Image = Worksheets;
                action("Send Request")
                {
                    Image = SendTo;
                    InFooterBar = true;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    RunPageMode = Edit;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        //cuEInvoiceAPI: Codeunit 50011;
                        recCompInfo: Record 79;
                        ClientId: Text;
                        AuthToken: Text;
                        Sek: Text;
                        TokenExpiry: Text;
                        decryptedSek: Text;
                        recSalesInvHdr: Record 112;
                        RecTranShipHead: Record 5744;
                        PurchCrMemoHdr: Record 124;
                    begin

                        CASE cancelRsnCodeEinv OF
                            'EWB1':
                                cancelRsnCodeEinvFinal := '1';
                            'EWB2':
                                cancelRsnCodeEinvFinal := '2';
                            'EWB3':
                                cancelRsnCodeEinvFinal := '3';
                            'EWB4':
                                cancelRsnCodeEinvFinal := '4';
                        END;

                        CASE cancelRsnCodeEwaybill OF
                            'EWB1':
                                cancelRsnCodeEwaybillFinal := '1';
                            'EWB2':
                                cancelRsnCodeEwaybillFinal := '2';
                            'EWB3':
                                cancelRsnCodeEwaybillFinal := '3';
                            'EWB4':
                                cancelRsnCodeEwaybillFinal := '4';
                        END;


                        //Setting Lookup data *****-----End
                        IF RecTranShipHead.GET(cdDocNo) THEN BEGIN
                            IF LocRec.GET(RecTranShipHead."Transfer-from Code") THEN;
                            /*
                             cuEInvoiceAPI.SetLocation(RecTranShipHead."Transfer-from Code");
                             //DJ GSP API
                             cuEInvoiceAPI.GetToken(LocRec."E-Inv ClientId", LocRec."E-Inv Client_Secret", AuthToken, TokenExpiry);
                             cuEInvoiceAPI.CancelIRN(IRN, cancelRsnCodeEinvFinal, cancelRmrkEinv, AuthToken, cancelDate, LocRec."E-Inv Password", LocRec."GST Registration No.", LocRec."E-Inv UserName");
                             */
                            //DJ GSP API
                            //DJ Govt API Comment
                            /*
                            cuEInvoiceAPI.GetToken_Govt(LocRec."E-Inv UserName", LocRec."E-Inv Password", LocRec."E-Inv ForceRefreshAccessToken"
                              ,ClientId,AuthToken,Sek,TokenExpiry,decryptedSek,LocRec."E-Inv ClientId",LocRec."E-Inv Client_Secret");

                            cuEInvoiceAPI.CancelIRN_Govt(IRN,cancelRsnCodeEinvFinal,cancelRmrkEinv,AuthToken,Sek,cancelDate, LocRec."E-Inv ClientId",
                              LocRec."E-Inv Client_Secret",LocRec."GST Registration No.",LocRec."E-Inv UserName");
                            */
                            //DJ Govt API Comment
                            GSTLedgerEntry.RESET;
                            GSTLedgerEntry.SETRANGE("Document No.", RecTranShipHead."No.");
                            IF GSTLedgerEntry.FINDSET THEN BEGIN
                                REPEAT
                                    GSTLedgerEntry."Scan QrCode E-Invoice" := 'Cancelled';
                                    GSTLedgerEntry."E-Inv Irn" := 'Cancelled';
                                    GSTLedgerEntry.MODIFY;
                                UNTIL GSTLedgerEntry.NEXT = 0;
                            END;
                        END ELSE BEGIN

                            // Start Added Case Statement for Selection DJ 25/02/20
                            CASE Selection OF
                                1:
                                    BEGIN
                                        recCompInfo.GET;
                                        IF recSalesInvHdr.GET(cdDocNo) THEN BEGIN
                                            IF LocRec.GET(recSalesInvHdr."Location Code") THEN;
                                            /*
                                            cuEInvoiceAPI.SetLocation(recSalesInvHdr."Location Code");
                                            //DJ GSP API
                                            cuEInvoiceAPI.GetToken(LocRec."E-Inv ClientId", LocRec."E-Inv Client_Secret", AuthToken, TokenExpiry);
                                            cuEInvoiceAPI.CancelIRN(IRN, cancelRsnCodeEinvFinal, cancelRmrkEinv, AuthToken, cancelDate, LocRec."E-Inv Password", LocRec."GST Registration No.", LocRec."E-Inv UserName");
                                            
                                            */
                                            //DJ GSP API
                                            //DJ Govt API Comment
                                            /*
                                            cuEInvoiceAPI.GetToken_Govt(LocRec."E-Inv UserName", LocRec."E-Inv Password", LocRec."E-Inv ForceRefreshAccessToken"
                                                  ,ClientId,AuthToken,Sek,TokenExpiry,decryptedSek,LocRec."E-Inv ClientId",LocRec."E-Inv Client_Secret");

                                            cuEInvoiceAPI.CancelIRN_Govt(IRN,cancelRsnCodeEinvFinal,cancelRmrkEinv,AuthToken,Sek,cancelDate, LocRec."E-Inv ClientId",
                                                  LocRec."E-Inv Client_Secret",LocRec."GST Registration No.",LocRec."E-Inv UserName");
                                            */
                                            //DJ Govt API Comment
                                            GSTLedgerEntry.RESET;
                                            GSTLedgerEntry.SETRANGE("Document No.", recSalesInvHdr."No.");
                                            GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Sales);
                                            IF GSTLedgerEntry.FINDSET THEN BEGIN
                                                REPEAT
                                                    GSTLedgerEntry."Scan QrCode E-Invoice" := 'Cancelled';
                                                    GSTLedgerEntry."E-Inv Irn" := 'Cancelled';
                                                    GSTLedgerEntry.MODIFY;
                                                UNTIL GSTLedgerEntry.NEXT = 0;
                                            END;
                                        END ELSE BEGIN
                                            IF PurchCrMemoHdr.GET(cdDocNo) THEN BEGIN
                                                IF LocRec.GET(PurchCrMemoHdr."Location Code") THEN;
                                                /*
                                                cuEInvoiceAPI.SetLocation(PurchCrMemoHdr."Location Code");
                                                //DJ GSP API
                                                cuEInvoiceAPI.GetToken(LocRec."E-Inv ClientId", LocRec."E-Inv Client_Secret", AuthToken, TokenExpiry);
                                                cuEInvoiceAPI.CancelIRN(IRN, cancelRsnCodeEinvFinal, cancelRmrkEinv, AuthToken, cancelDate, LocRec."E-Inv Password", LocRec."GST Registration No.", LocRec."E-Inv UserName");
                                                */
                                                //DJ GSP API
                                                //DJ Govt API Comment
                                                /*
                                                cuEInvoiceAPI.GetToken_Govt(LocRec."E-Inv UserName", LocRec."E-Inv Password", LocRec."E-Inv ForceRefreshAccessToken"
                                                      ,ClientId,AuthToken,Sek,TokenExpiry,decryptedSek,LocRec."E-Inv ClientId",LocRec."E-Inv Client_Secret");

                                                cuEInvoiceAPI.CancelIRN_Govt(IRN,cancelRsnCodeEinvFinal,cancelRmrkEinv,AuthToken,Sek,cancelDate, LocRec."E-Inv ClientId",
                                                      LocRec."E-Inv Client_Secret",LocRec."GST Registration No.",LocRec."E-Inv UserName");
                                                */
                                                //DJ Govt API Comment
                                                GSTLedgerEntry.RESET;
                                                GSTLedgerEntry.SETRANGE("Document No.", PurchCrMemoHdr."No.");
                                                GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Purchase);
                                                IF GSTLedgerEntry.FINDSET THEN BEGIN
                                                    REPEAT
                                                        GSTLedgerEntry."Scan QrCode E-Invoice" := 'Cancelled';
                                                        GSTLedgerEntry."E-Inv Irn" := 'Cancelled';
                                                        GSTLedgerEntry.MODIFY;
                                                    UNTIL GSTLedgerEntry.NEXT = 0;
                                                END;
                                            END;
                                        END;
                                    END;
                                2:
                                    BEGIN
                                        DetailedGSTLedgerEntry1.RESET;
                                        DetailedGSTLedgerEntry1.SETRANGE("Document No.", cdDocNo);
                                        DetailedGSTLedgerEntry1.SETRANGE("Transaction Type", TranscType);
                                        IF DetailedGSTLedgerEntry1.FINDFIRST THEN BEGIN
                                            GSTRegNo := DetailedGSTLedgerEntry1."Location  Reg. No.";
                                        END;
                                        LocRec.GET(DetailedGSTLedgerEntry1."Location Code");
                                        /*
                                        cuEwayBill.CancelEWB(EwbNo, cancelRsnCodeEwaybillFinal, cancelRmrkEwaybill, EwayBillcancelDate, ewayBillNo, GSTRegNo, AccessKey, LocRec."EWB UserName", LocRec."EWB Password");
*/
                                        IF EwayBillcancelDate <> '' THEN BEGIN
                                            DetailedEWayBill.SETRANGE("Document No.", cdDocNo);
                                            DetailedEWayBill.SETRANGE(Cancelled, FALSE);
                                            DetailedEWayBill.SETRANGE("EWB No.", EwbNo);
                                            IF DetailedEWayBill.FINDSET THEN BEGIN
                                                REPEAT
                                                    DetailedEWayBill.Cancelled := TRUE;
                                                    DetailedEWayBill."Cancel Date" := EwayBillcancelDate;
                                                    DetailedEWayBill.MODIFY;
                                                UNTIL DetailedEWayBill.NEXT = 0;
                                            END;
                                            GSTLedgerEntry.RESET;
                                            GSTLedgerEntry.SETRANGE("Document No.", recSalesInvHdr."No.");
                                            GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Sales);
                                            IF GSTLedgerEntry.FINDSET THEN BEGIN
                                                GSTLedgerEntry.MODIFYALL("E-Way Bill No.", 'Cancelled');
                                            END;
                                        END;
                                    END;
                                3:
                                    BEGIN
                                        DetailedGSTLedgerEntry1.RESET;
                                        DetailedGSTLedgerEntry1.SETRANGE("Document No.", cdDocNo);
                                        DetailedGSTLedgerEntry1.SETRANGE("Transaction Type", TranscType);
                                        IF DetailedGSTLedgerEntry1.FINDFIRST THEN BEGIN
                                            GSTRegNo := DetailedGSTLedgerEntry1."Location  Reg. No.";
                                        END;

                                        /*
                                                                                cuEInvoiceAPI.SetLocation(recSalesInvHdr."Location Code");
                                                                                //DJ GSP API
                                                                                cuEInvoiceAPI.GetToken(LocRec."E-Inv ClientId", LocRec."E-Inv Client_Secret", AuthToken, TokenExpiry);
                                                                                cuEInvoiceAPI.CancelIRN(IRN, cancelRsnCodeEinvFinal, cancelRmrkEinv, AuthToken, cancelDate, LocRec."E-Inv Password", LocRec."GST Registration No.", LocRec."E-Inv UserName");
                                                                                */
                                        //DJ GSP API
                                        //DJ Govt API Comment
                                        /*
                                        cuEInvoiceAPI.GetToken_Govt(LocRec."E-Inv UserName", LocRec."E-Inv Password", LocRec."E-Inv ForceRefreshAccessToken"
                                              ,ClientId,AuthToken,Sek,TokenExpiry,decryptedSek
                                              ,LocRec."E-Inv ClientId",LocRec."E-Inv Client_Secret");

                                        cuEInvoiceAPI.CancelIRN_Govt(IRN,cancelRsnCodeEinvFinal,cancelRmrkEinv,AuthToken,Sek,cancelDate, LocRec."E-Inv ClientId",
                                              LocRec."E-Inv Client_Secret",GSTRegNo,LocRec."E-Inv UserName");
                                        */
                                        //DJ Govt API Comment
                                        IF cancelDate <> '' THEN BEGIN
                                            GSTLedgerEntry.RESET;
                                            GSTLedgerEntry.SETRANGE("Document No.", recSalesInvHdr."No.");
                                            GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Sales);
                                            IF GSTLedgerEntry.FINDSET THEN BEGIN
                                                REPEAT
                                                    GSTLedgerEntry."Scan QrCode E-Invoice" := 'Cancelled';
                                                    GSTLedgerEntry."E-Inv Irn" := 'Cancelled';
                                                    GSTLedgerEntry.MODIFY;
                                                UNTIL GSTLedgerEntry.NEXT = 0;
                                            END;
                                        END;
                                        GeneralLedgerSetup.GET;
                                        LocRec.GET(DetailedGSTLedgerEntry1."Location Code");
                                        /*
                                                                                cuEwayBill.CancelEWB(EwbNo, cancelRsnCodeEwaybillFinal, cancelRmrkEwaybill, EwayBillcancelDate, ewayBillNo, GSTRegNo, AccessKey, LocRec."EWB UserName", LocRec."EWB Password");
                                        */
                                        IF EwayBillcancelDate <> '' THEN BEGIN
                                            DetailedEWayBill.SETRANGE("Document No.", cdDocNo);
                                            DetailedEWayBill.SETRANGE(Cancelled, FALSE);
                                            DetailedEWayBill.SETRANGE("EWB No.", EwbNo);
                                            IF DetailedEWayBill.FINDSET THEN BEGIN
                                                REPEAT
                                                    DetailedEWayBill.Cancelled := TRUE;
                                                    DetailedEWayBill."Cancel Date" := EwayBillcancelDate;
                                                    DetailedEWayBill.MODIFY;
                                                UNTIL DetailedEWayBill.NEXT = 0;
                                            END;
                                            GSTLedgerEntry.RESET;
                                            GSTLedgerEntry.SETRANGE("Document No.", recSalesInvHdr."No.");
                                            GSTLedgerEntry.SETRANGE("Transaction Type", GSTLedgerEntry."Transaction Type"::Sales);
                                            IF GSTLedgerEntry.FINDSET THEN BEGIN
                                                GSTLedgerEntry.MODIFYALL("E-Way Bill No.", 'Cancelled');
                                            END;
                                        END;
                                    END;
                            END;
                        END;
                        CurrPage.CLOSE;

                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF (Selection = 1) OR (Selection = 3) THEN
            IRNGroupVisible := TRUE
        ELSE
            IRNGroupVisible := FALSE;

        IF (Selection = 2) OR (Selection = 3) THEN
            EwayBillGroupVisible := TRUE
        ELSE
            EwayBillGroupVisible := FALSE;
    end;

    var
        IRN: Text;
        EwbNo: Text;
        cancelRsnCodeEinv: Text;
        cancelRmrkEinv: Text;
        cancelRsnCodeEwaybill: Text;
        cancelRmrkEwaybill: Text;
        GSTLedgerEntry: Record "GST Ledger Entry";
        //cuEwayBill: Codeunit 50012;
        DetailedEWayBill: Record 50044;
        cancelRsnCodeFinal: Text;
        cancelDate: Text;
        ewayBillNo: Text;
        cdDocNo: Code[20];
        GSTRegNo: Code[20];
        DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
        AccessKey1: Text;
        AccessKey: Label 'sd321e213213';
        GSTLedgerEntry1: Record "GST Ledger Entry";
        DocNumber: Code[20];
        GeneralLedgerSetup: Record 98;
        AuthToken: Text;
        Sek: Text;
        EwayBillcancelDate: Text;
        Selection: Integer;
        Group1Visible: Boolean;
        Group2Visible: Boolean;
        IRNGroupVisible: Boolean;
        EwayBillGroupVisible: Boolean;
        TranscType: Option Purchase,Sales;
        LocRec: Record 14;
        cancelRsnCodeEwaybillFinal: Text;
        cancelRsnCodeEinvFinal: Text;
        ReasonCode: Record 231;

    // [Scope('Internal')]
    procedure SetData(prIrn: Text; EwayBillNo: Text; prcancelRsnCode: Text; prcancelRmrk: Text; prcdDocNo: Code[20]; prAuthToken: Text; prSek: Text; MenuSelection: Integer; TransType: Option Purchase,Sales)
    begin
        IRN := prIrn;
        cancelRsnCodeEinv := prcancelRsnCode;
        cancelRmrkEinv := prcancelRmrk;
        cdDocNo := prcdDocNo;
        AuthToken := prAuthToken;
        Sek := prSek;
        EwbNo := EwayBillNo;   // DJ 25/02/20
        Selection := MenuSelection; // DJ 25/02/20
        TranscType := TransType; // DJ 25/02/20
    end;

    // [Scope('Internal')]
    procedure GetDate(var prIrn: Text; var prcancelRsnCode: Text; var prcancelRmrk: Text; var prAuthToken: Text; var prSek: Text; var prEwayBillNo: Text; var prMenuSelection: Integer; var prTransType: Option Purchase,Sales)
    begin
        prIrn := IRN;
        prcancelRsnCode := cancelRsnCodeEinv;
        prcancelRmrk := cancelRmrkEinv;
        prAuthToken := AuthToken;
        prSek := Sek;
        prEwayBillNo := EwbNo;   // DJ 25/02/20
        prMenuSelection := Selection; // DJ 25/02/20
        prTransType := TranscType;
    end;
}

