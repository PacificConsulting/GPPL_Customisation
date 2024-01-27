// MY PC 11 01 2024
pageextension 50088 "PostedSalesCreditMemoExtCstm" extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter("GST Without Payment of Duty")
        {
            field("Full Name"; rec."Full Name")
            {
                ApplicationArea = all;
            }
            field("Last Year Sales Return"; rec."Last Year Sales Return")

            {
                ApplicationArea = all;
            }
            field(IRN; rec.IRN)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here

        addafter("&Navigate")
        {
            action("Credit Note GSTC")

            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    RecSalesCrMemoLine: Record 115;
                    SalesCreditMemoHeader: Record "Sales Cr.Memo Header";

                begin
                    //  IF rec."Posting Date" > 211230D THEN BEGIN
                    rec.CALCFIELDS(rec.IRN);
                    RecSalesCrMemoLine.RESET;
                    RecSalesCrMemoLine.SETRANGE("Document No.", rec."No.");
                    RecSalesCrMemoLine.SETFILTER(Quantity, '%1', 0);
                    // RecSalesCrMemoLine.SETFILTER(rec."Total GST Amount", '%1', 0);
                    IF RecSalesCrMemoLine.FINDFIRST THEN BEGIN
                        IF rec.IRN = '' THEN
                            MESSAGE('Please generate IRN for this document');
                    END;
                    //  END;
                    //RSPLSUM 13Jan21

                    SalesCreditMemoHeader.RESET;
                    SalesCreditMemoHeader := Rec;
                    SalesCreditMemoHeader.SETRECFILTER;
                    REPORT.RUN(50074, TRUE, FALSE, SalesCreditMemoHeader);
                end;
            }
            action("Generate IRNs")

            {
                ApplicationArea = all;
                trigger OnAction()
                var

                begin

                end;
            }

            action("Update IRN Detail")

            {
                ApplicationArea = all;
                trigger OnAction()
                var
                //   UpdateIRNDetail: Report 50250;
                begin
                    rec.CALCFIELDS(rec.IRN);
                    rec.TESTFIELD(rec.IRN, '');
                    //  UpdateIRNDetail.SetDocument(rec."Location Code", rec."No.", rec.IRN);
                    //  UpdateIRNDetail.RUN;
                end;
            }
        }
    }

    var
        myInt: Integer;
}