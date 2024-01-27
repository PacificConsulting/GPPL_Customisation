page 50061 "Get HSN Details"
{
    PageType = Card;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(group1)
            {
                field("HSN Code"; HSNCode)
                {
                    ApplicationArea = all;
                    TableRelation = "HSN/SAC".Code;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(General)
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
                    begin
                        IF HSNCode = '' THEN
                            ERROR('Fill HSN Code');
                        //AKT_EWB 10202020
                        DetailedGSTLedgerEntry1.RESET;
                        DetailedGSTLedgerEntry1.SETRANGE("Document No.", DocumentNo);
                        DetailedGSTLedgerEntry1.SETRANGE("Document Type", TransacType);
                        IF DetailedGSTLedgerEntry1.FINDFIRST THEN BEGIN
                            GSTRegNo := DetailedGSTLedgerEntry1."Location  Reg. No.";
                        END;
                        //AKT_EWB 10202020

                        GeneralLedgerSetup.GET;
                        LocRec.GET(DetailedGSTLedgerEntry1."Location Code");
                        //GSTRegNo  :=  LocRec."EWB UserName";

                        //cuEwayBill.GetHsnDetailsByHsnCode(HSNCode,'27AAACN3451B1ZY','GOLiveNeelikon',GeneralLedgerSetup."EWB UserName", GeneralLedgerSetup."EWB Password");
                        /*
                        cuEwayBill.GetHsnDetailsByHsnCode(HSNCode, GSTRegNo, 'GOLiveNeelikon', LocRec."EWB UserName", LocRec."EWB Password");
                        */
                        CurrPage.CLOSE;
                    end;
                }
            }
        }
    }

    var
        HSNCode: Text;
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
        DocumentNo: Code[10];
        TransacType: Option Purchase,Sales;
        DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
        LocRec: Record 14;
        GSTRegNo: Code[20];

    // [Scope('Internal')]
    procedure SetData(prHSNCode: Text; DocNo: Code[20]; TransType: Option " ",Purchase,Sales)
    begin
        HSNCode := prHSNCode;
        DocumentNo := DocNo;
        TransacType := TransType;
    end;

    //  [Scope('Internal')]
    procedure GetDate(var prHSNCode: Text; prDocNo: Code[20]; prTransType: Option Purchase,Sales)
    begin
        prHSNCode := HSNCode;
        prDocNo := DocumentNo;
        prTransType := TransacType;
    end;
}

