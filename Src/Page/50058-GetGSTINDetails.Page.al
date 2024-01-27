page 50058 "Get GSTIN Details"
{
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(group1)
            {
                field("GSTIN No."; GSTINNo)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(group2)
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
                        //CUEinvoice: Codeunit 50011;
                        ClientId: Text;
                        AuthToken: Text;
                        Sek: Text;
                        Client_ID: Text;
                        Client_Secret: Text;
                        TokenExpiry: Text;
                        decryptedSek: Text;
                    begin

                        IF GSTINNo = '' THEN
                            ERROR('Fill GSTIN No.');

                        //AKT_EWB 10202020
                        DetailedGSTLedgerEntry1.RESET;
                        DetailedGSTLedgerEntry1.SETRANGE("Document No.", DocumentNo);
                        DetailedGSTLedgerEntry1.SETRANGE("Transaction Type", TransacType);
                        IF DetailedGSTLedgerEntry1.FINDFIRST THEN BEGIN
                            GSTRegNo := DetailedGSTLedgerEntry1."Location  Reg. No.";
                        END;
                        //AKT_EWB 10202020
                        IF NOT EInvoice THEN BEGIN
                            LocRec.GET(DetailedGSTLedgerEntry1."Location Code");
                            /*
                            cuEwayBill.GetGSTINDetails(GSTINNo, GSTINNo, '', LocRec."EWB UserName", LocRec."EWB Password");
                            */
                        END ELSE BEGIN
                            LocRec.GET(GloLocVar);
                            /*
                            CUEinvoice.SetLocation(LocRec.Code);
                            //DJ GSP API
                            CUEinvoice.GetToken(LocRec."E-Inv ClientId", LocRec."E-Inv Client_Secret", AuthToken, TokenExpiry);
                            CUEinvoice.GetGSTINDetails(AuthToken, Sek, LocRec."E-Inv ClientId", LocRec."E-Inv Password", LocRec."GST Registration No.", LocRec."E-Inv UserName", GSTINNo, FALSE);
                            */
                            //DJ GSP API
                            //DJ Govt API Comment
                            /*
                            CUEinvoice.GetToken_Govt(LocRec."E-Inv UserName",LocRec."E-Inv Password",LocRec."E-Inv ForceRefreshAccessToken",ClientId,AuthToken,Sek,TokenExpiry,decryptedSek
                            ,LocRec."E-Inv ClientId",LocRec."E-Inv Client_Secret");
                            CUEinvoice.GetGSTINDetails_Govt(AuthToken,Sek,LocRec."E-Inv ClientId",LocRec."E-Inv Client_Secret",LocRec."GST Registration No.",LocRec."E-Inv UserName",GSTINNo,FALSE);
                            */
                            //DJ Govt API Comment
                        END;
                        CurrPage.CLOSE;

                    end;
                }
            }
        }
    }

    var
        GSTINNo: Text;
        VehicleNo: Text;
        FromPlace: Text;
        FromState: Text;
        ReasonCode: Text;
        ReasonRem: Text;
        TransDocNo: Text;
        TransDocDate: Text;
        TransMode: Option Road,Rail,Air,Ship;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GSTLedgerEntry: Record "GST Ledger Entry";
        SalesInvoiceHeader: Record 112;
        Boolean: Boolean;
        ReasonCodeFinal: Text;
        TransModeFinal: Text;
        //cuEwayBill: Codeunit 50012;
        VehUpdDate: Text;
        VehvalidUpto: Text;
        DetailedEWayBill: Record 50044;
        cdGlDocNo: Text;
        GeneralLedgerSetup: Record 98;
        DocumentNo: Code[20];
        TransacType: Option Purchase,Sales;
        DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
        LocRec: Record 14;
        GSTRegNo: Text;
        GloLocVar: Code[20];
        EInvoice: Boolean;

    // [Scope('Internal')]
    procedure SetData(prGSTINNo: Text; DocNo: Code[20]; TransType: Option Purchase,Sales)
    begin
        GSTINNo := prGSTINNo;
        DocumentNo := DocNo;
        TransacType := TransType;
    end;

    //[Scope('Internal')]
    procedure GetDate(var prGSTINNo: Text; var prDocNo: Code[20]; var prTransType: Option Purchase,Sales)
    begin
        prGSTINNo := GSTINNo;
        prDocNo := DocumentNo;
        prTransType := TransacType;
    end;

    // [Scope('Internal')]
    procedure SetIRNData(GstRegNo: Text; LocVar: Code[20])
    begin
        GSTINNo := GstRegNo;
        EInvoice := TRUE;
        GloLocVar := LocVar;
    end;
}

