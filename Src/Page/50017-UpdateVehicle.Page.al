page 50017 "Update Vehicle"
{
    PageType = List;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(general1)
            {
                field("E-Way Bill No."; EwbNo)
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; VehicleNo)
                {
                    ApplicationArea = all;
                }
                field("From Place"; FromPlace)
                {
                    ApplicationArea = all;
                }
                field("From State"; FromState)
                {
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF PAGE.RUNMODAL(13789, RecState) = ACTION::LookupOK THEN BEGIN

                            FromState := RecState."State Code (GST Reg. No.)";
                            Text := RecState."State Code (GST Reg. No.)";

                            CurrPage.UPDATE;
                            //CLEAR(pgState);

                        END;
                    end;
                }
            }
            group(general2)
            {
                field("Reason Code"; ReasonCode)
                {
                    ApplicationArea = all;
                    TableRelation = "Reason Code" WHERE(EWB = CONST(true));

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ReasonCodeRec.RESET;
                        ReasonCodeRec.FILTERGROUP(2);
                        ReasonCodeRec.SETRANGE(EWB, TRUE);
                        ReasonCodeRec.FILTERGROUP(0);
                        IF PAGE.RUNMODAL(0, ReasonCodeRec) = ACTION::LookupOK THEN
                            ReasonCode := ReasonCodeRec.Code;
                    end;
                }
                field("Reason Rem"; ReasonRem)
                {
                    ApplicationArea = all;
                }
                field("Trans. Doc. No."; TransDocNo)
                {
                    ApplicationArea = all;
                }
                field("Trans. Doc. Date"; TransDocDate)
                {
                    ApplicationArea = all;
                }
                field("Trans. Mode"; TransMode)
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
            group(general3)
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
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        DetailEwayBill: Record 50044;
                        DetailedEWayBill: Record 50044;
                        recTransportDetails: Record 50020;
                        recVendor: Record 23;
                        ShippingAgent: Record 291;
                    begin


                        IF EwbNo = '' THEN
                            ERROR('Fill EwbNo');
                        IF VehicleNo = '' THEN
                            ERROR('Fill VehicleNo');
                        IF FromPlace = '' THEN
                            ERROR('Fill FromPlace');
                        IF FromState = '' THEN
                            ERROR('Fill FromState');
                        IF ReasonCode = '' THEN
                            ERROR('Fill ReasonCode');
                        IF ReasonRem = '' THEN
                            ERROR('Fill ReasonRem');
                        IF TransDocNo = '' THEN
                            ERROR('Fill TransDocNo');
                        IF TransDocDate = 0D THEN
                            ERROR('Fill TransDocDate');

                        CASE ReasonCode OF
                            'EWB1':
                                ReasonCodeFinal := '1';
                            'EWB2':
                                ReasonCodeFinal := '2';
                            'EWB3':
                                ReasonCodeFinal := '3';
                            'EWB4':
                                ReasonCodeFinal := '4';
                        END;


                        CASE TransMode OF
                            TransMode::Road:
                                TransModeFinal := '1';
                            TransMode::Rail:
                                TransModeFinal := '2';
                            TransMode::Air:
                                TransModeFinal := '3';
                            TransMode::Ship:
                                TransModeFinal := '4';
                        END;

                        //AKT_EWB 10202020
                        DetailedGSTLedgerEntry1.RESET;
                        DetailedGSTLedgerEntry1.SETRANGE("Document No.", cdGlDocNo);
                        IF DetailedGSTLedgerEntry1.FINDFIRST THEN BEGIN
                            GSTRegNo := DetailedGSTLedgerEntry1."Location  Reg. No.";
                        END;
                        GeneralLedgerSetup.GET;
                        LocRec.GET(DetailedGSTLedgerEntry1."Location Code");

                        //GSTRegNo  :=  LocRec."EWB UserName";
                        //AKT_EWB 10202020
                        //cuEwayBill.VehUpdate(EwbNo,VehicleNo,FromPlace,FromState,ReasonCodeFinal,ReasonRem,TransDocNo,TransDocDate,TransModeFinal,VehUpdDate,VehvalidUpto,GSTRegNo,AccessKey
                        //                          ,GeneralLedgerSetup."EWB UserName", GeneralLedgerSetup."EWB Password");  //AKT 03102019 Comment
                        /*
                        cuEwayBill.VehUpdate(EwbNo, VehicleNo, FromPlace, FromState, ReasonCodeFinal, ReasonRem, TransDocNo, FORMAT(TransDocDate, 0, '<Day,2>/<Month,2>/<Year4>'), TransModeFinal, VehUpdDate, VehvalidUpto, GSTRegNo, AccessKey
                                                  , LocRec."EWB UserName", LocRec."EWB Password");  //AKT 03102019 Comment
                                                                                                    */
                        /*
                        DetailedEWayBill.GET(cdGlDocNo,  EwbNo);
                        DetailedEWayBill."Vehicle No."  :=  VehicleNo;
                        DetailedEWayBill."VH Valid Upto"  :=  VehvalidUpto;
                        EVALUATE(DetailedEWayBill."VH Updated Date",VehUpdDate);
                        DetailedEWayBill.MODIFY;
                        */

                        DetailEwayBill.RESET;
                        DetailEwayBill.SETRANGE("Document No.", cdGlDocNo);
                        DetailEwayBill.SETRANGE("EWB No.", EwbNo);
                        IF DetailEwayBill.FINDLAST THEN BEGIN
                            DetailedEWayBill.INIT;
                            DetailedEWayBill."Document No." := DetailEwayBill."Document No.";
                            DetailedEWayBill."EWB No." := DetailEwayBill."EWB No.";
                            DetailedEWayBill."EWB Valid Upto" := DetailEwayBill."EWB Valid Upto";
                            DetailedEWayBill."EWB Updated Date" := DetailEwayBill."EWB Updated Date";
                            DetailedEWayBill."EWB Creation date" := DetailEwayBill."EWB Creation date";
                            DetailedEWayBill."Created By User" := USERID;
                            DetailedEWayBill."GST Ledg. Entry No." := DetailEwayBill."GST Ledg. Entry No.";
                            DetailedEWayBill."Vehicle No." := VehicleNo;
                            DetailedEWayBill."VH Valid Upto" := VehvalidUpto;
                            DetailedEWayBill."VH Updated Date" := VehUpdDate;
                            DetailedEWayBill."Transporter Code" := DetailEwayBill."Transporter Code";
                            DetailedEWayBill."Transporter Name" := DetailEwayBill."Transporter Name";
                            DetailedEWayBill."Trans. Doc. No." := TransDocNo;//RSPLSUM
                            DetailedEWayBill."Trans. Doc. Date" := FORMAT(TransDocDate);//RSPLSUM
                            DetailedEWayBill."From Place" := FromPlace;//RSPLSUM
                            DetailedEWayBill.INSERT;

                            //RSPLSUM07Apr21>>
                            recTransportDetails.RESET;
                            recTransportDetails.SETRANGE(recTransportDetails."Invoice No.", cdGlDocNo);
                            IF recTransportDetails.FINDFIRST THEN BEGIN
                                ShippingAgent.RESET;
                                ShippingAgent.SETRANGE("GST Registration No.", DetailEwayBill."Transporter Code");
                                IF ShippingAgent.FINDFIRST THEN BEGIN
                                    recTransportDetails."Shipping Agent Code" := ShippingAgent.Code;
                                    recTransportDetails."Shipping Agent Name" := ShippingAgent.Name;
                                    recVendor.RESET;
                                    recVendor.SETRANGE(recVendor."Shipping Agent", TRUE);
                                    recVendor.SETRANGE(recVendor."Shipping Agent Code", ShippingAgent.Code);
                                    IF recVendor.FINDFIRST THEN BEGIN
                                        recTransportDetails."Vendor Code" := recVendor."No.";
                                        recTransportDetails."Vendor Name" := recVendor."Full Name";
                                    END;
                                END;
                                recTransportDetails."LR No." := TransDocNo;
                                recTransportDetails."LR Date" := TransDocDate;
                                recTransportDetails."Vehicle No." := VehicleNo;

                                recTransportDetails.MODIFY;
                            END;
                            //RSPLSUM07Apr21<<

                        END;

                        CurrPage.CLOSE;

                    end;
                }
            }
        }
    }

    var
        EwbNo: Text;
        VehicleNo: Text;
        FromPlace: Text;
        FromState: Text;
        ReasonCode: Text;
        ReasonRem: Text;
        TransDocNo: Text;
        TransDocDate: Date;
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
        RecState: Record State;
        //pgState: Page 13789;
        RecLoc: Record 14;
        pgLoc: Page 15;
        GSTRegNo: Code[20];
        DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
        AccessKey1: Text;
        AccessKey: Label 'sd321e213213';
        GeneralLedgerSetup: Record 98;
        LocRec: Record 14;
        ReasonCodeRec: Record 231;

    //[Scope('Internal')]
    procedure SetData(prEwbNo: Text; prVehicleNo: Text; prFromPlace: Text; prFromState: Text; prReasonCode: Text; prReasonRem: Text; prTransDocNo: Text; prTransDocDate: Date; prTransMode: Option Road,Rail,Air,Ship; DocNo: Code[20])
    begin
        EwbNo := prEwbNo;
        VehicleNo := prVehicleNo;
        FromPlace := prFromPlace;
        FromState := prFromState;
        ReasonCode := prReasonCode;
        ReasonRem := prReasonRem;
        TransDocNo := prTransDocNo;
        TransDocDate := prTransDocDate;
        TransMode := prTransMode;
        cdGlDocNo := DocNo;
    end;

    //[Scope('Internal')]
    procedure GetDate(var prEwbNo: Text; var prVehicleNo: Text; var prFromPlace: Text; var prFromState: Text; var prReasonCode: Text; var prReasonRem: Text; var prTransDocNo: Text; var prTransDocDate: Date; var prTransMode: Option Road,Rail,Air,Ship)
    begin
        prEwbNo := EwbNo;
        prVehicleNo := VehicleNo;
        prFromPlace := FromPlace;
        prFromState := FromState;
        prReasonCode := ReasonCode;
        prReasonRem := ReasonRem;
        prTransDocNo := TransDocNo;
        prTransDocDate := TransDocDate;
        prTransMode := TransMode;
    end;
}

