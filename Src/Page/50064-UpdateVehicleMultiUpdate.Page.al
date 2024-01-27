page 50064 "UpdateVehicle(MultiUpdate)"
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
                field("E-Way Bill No."; ewbNo)
                {
                    ApplicationArea = all;
                }
                field("Group No"; groupNo)
                {
                    ApplicationArea = all;
                }
                field("New Vehicle No"; newVehicleNo)
                {
                    ApplicationArea = all;
                }
                field("old vehicle No"; oldvehicleNo)
                {
                    ApplicationArea = all;
                }
                field("Old Tran No"; oldTranNo)
                {
                    ApplicationArea = all;
                }
                field("New Tran No"; newTranNo)
                {
                    ApplicationArea = all;
                }
            }
            group(group2)
            {
                field("Reason Code"; reasonCode)
                {
                    ApplicationArea = all;
                    TableRelation = "Reason Code";

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ReasonCodeRec.RESET;
                        ReasonCodeRec.FILTERGROUP(2);
                        ReasonCodeRec.SETRANGE(EWB, TRUE);
                        ReasonCodeRec.FILTERGROUP(0);
                        IF PAGE.RUNMODAL(0, ReasonCodeRec) = ACTION::LookupOK THEN
                            reasonCode := ReasonCodeRec.Code;
                    end;
                }
                field("Reason Rem"; reasonRem)
                {
                    ApplicationArea = all;
                }
                field("From Place"; fromPlace)
                {
                    ApplicationArea = all;
                }
                field("From State"; fromState)
                {
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF PAGE.RUNMODAL(13789, RecState) = ACTION::LookupOK THEN BEGIN

                            fromState := RecState."State Code (GST Reg. No.)";
                            Text := RecState."State Code (GST Reg. No.)";

                            CurrPage.UPDATE;
                            CLEAR(pgState);

                        END;
                    end;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(group3)
            {
                Image = Worksheets;
                action("Send Request")
                {
                    ApplicationArea = all;
                    Image = SendTo;
                    InFooterBar = true;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    RunPageMode = Edit;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        IF ewbNo = '' THEN
                            ERROR('Fill EwbNo');
                        IF groupNo = '' THEN
                            ERROR('Fill groupNo');
                        IF newVehicleNo = '' THEN
                            ERROR('Fill newVehicleNo');
                        IF oldvehicleNo = '' THEN
                            ERROR('Fill oldvehicleNo');
                        IF fromPlace = '' THEN
                            ERROR('Fill fromPlace');
                        IF fromState = '' THEN
                            ERROR('Fill fromState');
                        IF reasonCode = '' THEN
                            ERROR('Fill reasonCode');
                        IF reasonRem = '' THEN
                            ERROR('Fill reasonRem');
                        IF oldTranNo = '' THEN
                            ERROR('Fill oldTranNo');
                        IF newTranNo = '' THEN
                            ERROR('Fill newTranNo');
                        IF vehUpdDate = '' THEN
                            ERROR('Fill vehUpdDate');


                        CASE reasonCode OF
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

                        //cuEwayBill.VehUpdate(ewbNo,VehicleNo,fromPlace,fromState,ReasonCodeFinal,reasonRem,TransDocNo,TransDocDate,TransModeFinal,vehUpdDate,VehvalidUpto);  //AKT 03102019 Comment
                        //cuEwayBill.InitiateMultivehicleUpdate(ewbNo,groupNo,newVehicleNo,oldvehicleNo,fromPlace,fromState,reasonCode,reasonRem,oldTranNo,newTranNo,vehUpdDate); // AKT09122019

                        //AKT_EWB 10202020
                        GSTLedgerEntry1.RESET;
                        GSTLedgerEntry1.SETRANGE("E-Way Bill No.", ewbNo);
                        IF GSTLedgerEntry1.FINDFIRST THEN BEGIN
                            DocNumber := GSTLedgerEntry1."Document No.";
                        END;

                        DetailedGSTLedgerEntry1.RESET;
                        DetailedGSTLedgerEntry1.SETRANGE("Document No.", DocNumber);
                        IF DetailedGSTLedgerEntry1.FINDFIRST THEN BEGIN
                            GSTRegNo := DetailedGSTLedgerEntry1."Location  Reg. No.";
                        END;
                        //AKT_EWB 10202020

                        GeneralLedgerSetup.GET;
                        LocRec.GET(DetailedGSTLedgerEntry1."Location Code");
                        //GSTRegNo  :=  LocRec."EWB UserName";

                        /*
                        cuEwayBill.InitiateMultivehicleUpdate(ewbNo,groupNo,oldvehicleNo,newVehicleNo,oldTranNo,newTranNo,fromPlace,fromState,ReasonCodeFinal,reasonRem,vehUpdDate,GSTRegNo,AccessKey
                                                                        ,GeneralLedgerSetup."EWB UserName", GeneralLedgerSetup."EWB Password");
                        */
                        /*
                        cuEwayBill.InitiateMultivehicleUpdate(ewbNo, groupNo, oldvehicleNo, newVehicleNo, oldTranNo, newTranNo, fromPlace, fromState, ReasonCodeFinal, reasonRem, vehUpdDate, GSTRegNo, AccessKey
                                                                        , LocRec."EWB UserName", LocRec."EWB Password");
                                                                        */

                        //MultipleDetailedEWayBill.GET(cdGlDocNo,  ewbNo);
                        //DetailedEWayBill.RESET;
                        //DetailedEWayBill.SETRANGE("Document No.",cdGlDocNo);
                        //IF DetailedEWayBill.FINDFIRST THEN

                        /*
                        MultipleDetailedEWayBill.SETRANGE("Document No.",oldTranNo);
                        MultipleDetailedEWayBill.SETRANGE("EWB No.",ewbNo);
                        IF MultipleDetailedEWayBill.FINDFIRST THEN
                           EntryNo := MultipleDetailedEWayBill."GST Ledg. Entry No.";
                        */
                        MultipleDetailedEWayBill.SETRANGE("Document No.", newTranNo);
                        MultipleDetailedEWayBill.SETRANGE("EWB No.", ewbNo);
                        MultipleDetailedEWayBill.SETRANGE("Group No.", groupNo);
                        IF MultipleDetailedEWayBill.FINDFIRST THEN BEGIN
                            MultipleDetailedEWayBill."New Vehicle No." := newVehicleNo;
                            MultipleDetailedEWayBill."Old Vehicle No." := oldvehicleNo;
                            MultipleDetailedEWayBill."Old Tran No." := oldTranNo;
                            MultipleDetailedEWayBill."New Tran No." := newTranNo;
                            MultipleDetailedEWayBill.MODIFY;
                            //  MESSAGE('%1,%2',MultipleDetailedEWayBill."New Vehicle No.",MultipleDetailedEWayBill."Old Vehicle No.");
                        END;

                        CurrPage.CLOSE;

                    end;
                }
            }
        }
    }

    var
        VehicleNo: Text;
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
        VehvalidUpto: Text;
        DetailedEWayBill: Record 50044;
        cdGlDocNo: Text;
        RecState: Record State;
        pgState: Page States;
        RecLoc: Record 14;
        pgLoc: Page 15;
        ewbNo: Text;
        groupNo: Text;
        oldvehicleNo: Text;
        newVehicleNo: Text;
        oldTranNo: Text;
        newTranNo: Text;
        fromPlace: Text;
        fromState: Text;
        reasonCode: Text;
        reasonRem: Text;
        vehUpdDate: Text;
        MultipleDetailedEWayBill: Record 50043;
        EntryNo: Integer;
        GSTRegNo: Code[20];
        DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
        AccessKey1: Text;
        GSTLedgerEntry1: Record "GST Ledger Entry";
        DocNumber: Code[20];
        AccessKey: Label 'sd321e213213';
        GeneralLedgerSetup: Record 98;
        LocRec: Record 14;
        ReasonCodeRec: Record 231;

    // [Scope('Internal')]
    procedure SetData(PrewbNo: Text; PrgroupNo: Text; ProldvehicleNo: Text; PrnewVehicleNo: Text; ProldTranNo: Text; PrnewTranNo: Text; PrfromPlace: Text; PrfromState: Text; PrreasonCode: Text; PrreasonRem: Text; var PrvehUpdDate: Text)
    begin
        ewbNo := PrewbNo;
        groupNo := PrgroupNo;
        newVehicleNo := PrnewVehicleNo;
        oldvehicleNo := ProldvehicleNo;
        fromPlace := PrfromPlace;
        fromState := PrfromState;
        reasonCode := PrreasonCode;
        reasonRem := PrreasonRem;
        oldTranNo := ProldTranNo;
        newTranNo := PrnewTranNo;
        vehUpdDate := PrvehUpdDate;
    end;

    //  [Scope('Internal')]
    procedure GetDate(var PrewbNo: Text; var PrgroupNo: Text; var ProldvehicleNo: Text; var PrnewVehicleNo: Text; var ProldTranNo: Text; var PrnewTranNo: Text; var PrfromPlace: Text; var PrfromState: Text; var PrreasonCode: Text; var PrreasonRem: Text; var PrvehUpdDate: Text)
    begin
        PrewbNo := ewbNo;
        PrgroupNo := groupNo;
        PrnewVehicleNo := newVehicleNo;
        ProldvehicleNo := oldvehicleNo;
        PrfromPlace := fromPlace;
        PrfromState := fromState;
        PrreasonCode := reasonCode;
        PrreasonRem := reasonRem;
        ProldTranNo := oldTranNo;
        PrnewTranNo := newTranNo;
        PrvehUpdDate := vehUpdDate;
    end;
}

