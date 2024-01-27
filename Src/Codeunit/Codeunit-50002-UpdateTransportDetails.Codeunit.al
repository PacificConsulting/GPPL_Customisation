codeunit 50002 "Update Transport Details"
{

    trigger OnRun()
    begin
        RecTempTransDetail.RESET;
        IF RecTempTransDetail.FINDSET THEN
            REPEAT
                RecTD.RESET;
                IF NOT RecTD.GET(RecTempTransDetail."Invoice no") THEN BEGIN

                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE(SalesInvHeader."No.", RecTempTransDetail."Invoice no");
                    IF SalesInvHeader.FINDFIRST THEN BEGIN
                        recTransportDetails.INIT;
                        recTransportDetails."Invoice No." := SalesInvHeader."No.";
                        recTransportDetails."Invoice Date" := SalesInvHeader."Posting Date";
                        recTransportDetails."Customer Name" := SalesInvHeader."Sell-to Customer Name";
                        recTransportDetails."Shortcut Dimension 1 Code" := SalesInvHeader."Shortcut Dimension 1 Code";
                        EBTSalesInvLine.RESET;
                        EBTSalesInvLine.SETRANGE(EBTSalesInvLine."Document No.", SalesInvHeader."No.");
                        EBTSalesInvLine.SETRANGE(EBTSalesInvLine.Type, EBTSalesInvLine.Type::Item);
                        IF EBTSalesInvLine.FINDSET THEN
                            REPEAT
                                IF (EBTSalesInvLine."Unit of Measure" = 'Litres') OR (EBTSalesInvLine."Unit of Measure" = 'KGS') THEN BEGIN
                                    UOMTrans := EBTSalesInvLine."Unit of Measure"
                                END
                                ELSE
                                    UOMTrans := '';
                            UNTIL EBTSalesInvLine.NEXT = 0;
                        recTransportDetails.UOM := UOMTrans;
                        recTransportDetails.Type := recTransportDetails.Type::Invoice;

                        IF SalesInvHeader."Transport Type" = SalesInvHeader."Transport Type"::"Local+Intercity" THEN BEGIN
                            recTransportDetails."LR No." := '';
                            recTransportDetails."LR Date" := 0D;
                            recTransportDetails."Vehicle No." := '';
                            recTransportDetails."Local LR No." := SalesInvHeader."LR/RR No.";
                            recTransportDetails."Local LR Date" := SalesInvHeader."LR/RR Date";
                            recTransportDetails."Local Vehicle No." := SalesInvHeader."Vehicle No.";
                            recTransportDetails."Local Vehicle Capacity" := SalesInvHeader."Local Vehicle Capacity";  // EBT MILAN 171213
                            recTransportDetails."Vehicle Capacity" := SalesInvHeader."Vehicle Capacity";

                        END
                        ELSE BEGIN
                            recTransportDetails."LR No." := SalesInvHeader."LR/RR No.";
                            recTransportDetails."LR Date" := SalesInvHeader."LR/RR Date";
                            recTransportDetails."Vehicle No." := SalesInvHeader."Vehicle No.";
                            recTransportDetails."Local LR No." := '';
                            recTransportDetails."Local LR Date" := 0D;
                            recTransportDetails."Local Vehicle No." := '';
                            recTransportDetails."Local Vehicle Capacity" := SalesInvHeader."Local Vehicle Capacity";  // EBT MILAN 171213
                            recTransportDetails."Vehicle Capacity" := SalesInvHeader."Vehicle Capacity";

                        END;

                        recTransportDetails."Shipping Agent Code" := SalesInvHeader."Shipping Agent Code";

                        recShippingAgent.RESET;
                        recShippingAgent.SETRANGE(recShippingAgent.Code, SalesInvHeader."Shipping Agent Code");
                        IF recShippingAgent.FINDFIRST THEN BEGIN
                            recTransportDetails."Shipping Agent Name" := recShippingAgent.Name;
                        END;

                        IF SalesInvHeader."Shipping Agent Code" <> '' THEN BEGIN
                            recvendor.RESET;
                            recvendor.SETRANGE(recvendor."Shipping Agent Code", SalesInvHeader."Shipping Agent Code");
                            IF recvendor.FINDFIRST THEN BEGIN
                                recTransportDetails."Vendor Code" := recvendor."No.";
                                recTransportDetails."Vendor Name" := recvendor."Full Name";
                            END;
                        END;

                        recTransportDetails."From Location Code" := SalesInvHeader."Location Code";

                        recLoc.RESET;
                        recLoc.SETRANGE(recLoc.Code, SalesInvHeader."Location Code");
                        IF recLoc.FINDFIRST THEN BEGIN
                            recTransportDetails."From Location Name" := recLoc.Name;
                        END;

                        recTransportDetails.Destination := SalesInvHeader."Ship-to City";


                        recTransportDetails."Expected TPT Cost" := SalesInvHeader."Expected TPT Cost";

                        recTransportDetails."Local Expected TPT Cost" := SalesInvHeader."Local Expected TPT Cost";

                        recSIL.RESET;
                        recSIL.SETRANGE(recSIL."Document No.", SalesInvHeader."No.");
                        recSIL.SETRANGE(recSIL.Type, recSIL.Type::Item);
                        recSIL.SETFILTER(recSIL.Quantity, '<>%1', 0);
                        IF recSIL.FINDFIRST THEN
                            REPEAT
                                recTransportDetails.Quantity += recSIL."Quantity (Base)";
                            UNTIL recSIL.NEXT = 0;

                        recTransportDetails."Freight Type" := SalesInvHeader."Freight Type";

                        recTransportDetails.Open := TRUE;
                        recTransportDetails.INSERT;
                        RecTempTransDetail.Updated := TRUE;
                        RecTempTransDetail.MODIFY;
                    END;
                END;
            UNTIL RecTempTransDetail.NEXT = 0;
        MESSAGE('Transport Details are updted');
    end;

    var
        SalesInvHeader: Record 112;
        RecTD: Record 50020;
        RecTempTransDetail: Record 50036;
        EBTSalesInvLine: Record 113;
        UOMTrans: Text[100];
        recShippingAgent: Record 291;
        recvendor: Record 23;
        recLoc: Record 14;
        recSIL: Record 113;
        InvNo: Code[20];
        ShpInv: Code[20];
        recTrShipHdr: Record 5744;
        recTrShipLn: Record 5745;
        recTransportDetails: Record 50020;
}

