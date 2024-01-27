page 50035 "QC Certificate"
{
    Editable = false;
    PageType = List;
    SourceTable = 50016;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Certificate No."; rec."Certificate No.")
                {
                    ApplicationArea = all;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Item Description"; rec."Item Description")
                {
                    ApplicationArea = all;
                }
                field("Blend Order No."; rec."Blend Order No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Batch No."; rec."Batch No.")
                {
                    ApplicationArea = all;
                }
                field("Tentative Batch No."; rec."Tentative Batch No.")
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
                action("&QC Details")
                {
                    Caption = '&QC Details';
                    RunObject = Page 50030;
                    RunPageLink = "Item No." = FIELD("Item No."),
                                  "Certificate No." = FIELD("Certificate No."),
                                  "Batch No./DC No" = FIELD("Batch No."),
                                  "Blend Order No" = FIELD("Blend Order No.");
                }
                action("&Copy TC Details")
                {
                    Caption = '&Copy TC Details';

                    trigger OnAction()
                    begin

                        ItemVersionParameterResult.RESET;
                        ItemVersionParameterResult.SETRANGE(ItemVersionParameterResult."Blend Order No", ProdDocNo);
                        IF NOT ItemVersionParameterResult.FINDFIRST THEN BEGIN
                            ItemVersionParameterResult1.RESET;
                            ItemVersionParameterResult1.SETRANGE(ItemVersionParameterResult1."Certificate No.", rec."Certificate No.");
                            ItemVersionParameterResult1.SETRANGE(ItemVersionParameterResult1."Item No.", rec."Item No.");
                            ItemVersionParameterResult1.SETRANGE(ItemVersionParameterResult1."Blend Order No", rec."Blend Order No.");
                            IF ItemVersionParameterResult1.FINDSET THEN
                                REPEAT
                                    ItemVersionParameterResult2.INIT;
                                    ItemVersionParameterResult2.TRANSFERFIELDS(ItemVersionParameterResult1);
                                    ItemVersionParameterResult2."Item No." := ItemProdNo;
                                    ItemVersionParameterResult2."Batch No./DC No" := '';
                                    ItemVersionParameterResult2."Blend Order No" := ProdDocNo;
                                    ItemVersionParameterResult2.INSERT;
                                UNTIL ItemVersionParameterResult1.NEXT = 0;
                        END;

                        ItemVersionParameterResult.RESET;
                        //ItemvarParamresult1.SETRANGE(ItemvarParamresult1."Batch No./DC No",BatchNoFilter);

                        // MILAN (13092013)....Added Blend Order no. filter to reduce time for copy QC function......................................START
                        ItemVersionParameterResult.SETRANGE(ItemVersionParameterResult."Blend Order No", ItemVersionParameterResult2."Blend Order No");
                        // MILAN (13092013)....Added Blend Order no. filter to reduce time for copy QC function......................................END

                        ItemVersionParameterResult.SETRANGE("Test Result Approved", TRUE);
                        IF ItemVersionParameterResult.FINDSET THEN
                            REPEAT
                                ProductionOrder.RESET;
                                ProductionOrder.SETRANGE(ProductionOrder.Status, ProductionOrder.Status::Released);
                                ProductionOrder.SETRANGE(ProductionOrder."No.", ItemVersionParameterResult."Blend Order No");
                                IF ProductionOrder.FINDFIRST THEN BEGIN
                                    ProductionOrder."QC Tested" := TRUE;
                                    ProductionOrder.MODIFY;
                                END;
                            UNTIL ItemVersionParameterResult.NEXT = 0;
                        MESSAGE('Copied');
                        CurrPage.CLOSE;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //EBT STIVAN ---(11042013)--- To Filter QC Certificate Details as per the Location Code------START
        /*
        IF UserMgt.GetSalesFilter() <> '' THEN
        BEGIN
         FILTERGROUP(2);
         ProductionOrder.RESET;
         ProductionOrder.SETRANGE(ProductionOrder."No.",ProdDocNo);
         IF ProductionOrder.FINDFIRST THEN
         BEGIN
          SETRANGE("Location Code",ProductionOrder."Location Code");
         END;
         FILTERGROUP(0);
        END;
        */

        rec.FILTERGROUP(2);
        ProductionOrder.RESET;
        ProductionOrder.SETRANGE(ProductionOrder."No.", ProdDocNo);
        IF ProductionOrder.FINDFIRST THEN BEGIN
            CSOMAPPING.RESET;
            CSOMAPPING.SETRANGE(CSOMAPPING."User Id", UPPERCASE(USERID));
            IF CSOMAPPING.FINDFIRST THEN BEGIN
                QCcertificate.RESET;
                QCcertificate.SETFILTER(QCcertificate."Item No.", '%1', '@*BULK*');
                QCcertificate.SETRANGE(QCcertificate."Tentative Batch No.", ProductionOrder."Description 2");
                IF QCcertificate.FINDSET THEN
                    REPEAT
                        CSOmapping1.RESET;
                        CSOmapping1.SETRANGE(CSOmapping1."User Id", UPPERCASE(USERID));
                        CSOmapping1.SETRANGE(CSOmapping1.Type, CSOmapping1.Type::Location);
                        CSOmapping1.SETRANGE(CSOmapping1.Value, QCcertificate."Location Code");
                        IF CSOmapping1.FINDFIRST THEN
                            QCcertificate.MARK := TRUE;
                    UNTIL QCcertificate.NEXT = 0;
                QCcertificate.MARKEDONLY(TRUE);
                rec.COPY(QCcertificate);
            END;
        END;
        rec.FILTERGROUP(0);

        //EBT STIVAN ---(11042013)--- To Filter QC Certificate Details as per the Location Code--------END

    end;

    var
        ProdDocNo: Code[20];
        ItemVersionParameterResult: Record 50015;
        ItemVersionParameterResult1: Record 50015;
        ItemVersionParameter: Record 50025;
        ItemProdNo: Code[20];
        ItemVersionParameterResult2: Record 50015;
        ProductionOrder: Record 5405;
        //UserMgt: Codeunit 5700;
        CSOMAPPING: Record 50006;
        QCcertificate: Record 50016;
        CSOmapping1: Record 50006;

    //[Scope('Internal')]
    procedure SetDocNo(DocNo: Code[20]; ItemNo: Code[20])
    begin
        ProdDocNo := DocNo;
        ItemProdNo := ItemNo;
    end;
}

