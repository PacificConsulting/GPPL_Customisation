page 50062 "GET HSN Detail List"
{
    Editable = false;
    PageType = List;
    SourceTable = "HSN/SAC";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("GST Group Code"; rec."GST Group Code")
                {
                    ApplicationArea = all;
                }
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
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
            group(group1)
            {
                Image = Worksheets;
                action("Get HSN Detail")
                {
                    applicationarea = all;
                    Image = SendTo;
                    InFooterBar = true;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    RunPageMode = Edit;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        pgRespectivePage: Page 50061;
                        TransType: Option " ",Purchase,Sales;
                    begin
                        pgRespectivePage.SetData(Rec.Code, '', TransType::" ");

                        pgRespectivePage.RUNMODAL;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

        HSNCode := '1001';
    end;

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

    // [Scope('Internal')]
    procedure SetData(prHSNCode: Text)
    begin
        HSNCode := prHSNCode;
    end;

    //[Scope('Internal')]
    procedure GetDate(var prHSNCode: Text)
    begin
        prHSNCode := HSNCode;
    end;
}

