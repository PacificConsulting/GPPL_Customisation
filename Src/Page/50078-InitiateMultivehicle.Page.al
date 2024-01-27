page 50078 InitiateMultivehicle
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
                field("To State"; ToState)
                {
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF PAGE.RUNMODAL(13789, RecState) = ACTION::LookupOK THEN BEGIN

                            ToState := RecState."State Code (GST Reg. No.)";
                            Text := RecState."State Code (GST Reg. No.)";

                            CurrPage.UPDATE;
                            CLEAR(pgState);

                        END;
                    end;
                }
                field("To Place"; ToPlace)
                {
                    ApplicationArea = all;
                }
                field("Tr Mode"; TrMode)
                {
                    ApplicationArea = all;
                }
                field("Total Qty"; TotalQty)
                {
                    ApplicationArea = all;
                }
                field("Unit Code"; UnitCode)
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
                    ApplicationArea = all;
                    Image = SendTo;
                    InFooterBar = true;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    RunPageMode = Edit;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        groupNo: Text;
                        createdDate: Text;
                    begin
                        IF ewbNo = '' THEN
                            ERROR('Fill EwbNo');
                        IF fromPlace = '' THEN
                            ERROR('Fill fromPlace');
                        IF fromState = '' THEN
                            ERROR('Fill fromState');
                        IF reasonCode = '' THEN
                            ERROR('Fill reasonCode');
                        IF reasonRem = '' THEN
                            ERROR('Fill reasonRem');
                        IF ToPlace = '' THEN
                            ERROR('Fill ToPlace');
                        IF ToState = '' THEN
                            ERROR('Fill ToState');
                        IF TotalQty = '' THEN
                            ERROR('Fill TotalQty');
                        IF UnitCode = '' THEN
                            ERROR('Fill UnitCode');
                        IF TrMode = '' THEN
                            ERROR('Fill TrMode');




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
                            //('%1',GSTRegNo);
                        END;
                        //AKT_EWB 10202020

                        GeneralLedgerSetup.GET;
                        LocRec.GET(DetailedGSTLedgerEntry1."Location Code");
                        //GSTRegNo  :=  LocRec."EWB UserName";

                        /*
                        cuEwayBill.InitiateMultivehicleMovement(ewbNo,ReasonCodeFinal,reasonRem,fromPlace,fromState,ToPlace,ToState,TrMode,TotalQty,UnitCode,groupNo,createdDate,GSTRegNo,AccessKey
                                                                        ,GeneralLedgerSetup."EWB UserName", GeneralLedgerSetup."EWB Password");
                        */
                        /*
                                                cuEwayBill.InitiateMultivehicleMovement(ewbNo, ReasonCodeFinal, reasonRem, fromPlace, fromState, ToPlace, ToState, TrMode, TotalQty, UnitCode, groupNo, createdDate, GSTRegNo, AccessKey
                                                                                                , LocRec."EWB UserName", LocRec."EWB Password");
                        */
                        MultipleDetailedEWayBill.INIT;
                        MultipleDetailedEWayBill."Group No." := groupNo;
                        MultipleDetailedEWayBill."Document No." := cdGlDocNo;
                        MultipleDetailedEWayBill."EWB No." := ewbNo;
                        MultipleDetailedEWayBill."Reason Code" := ReasonCodeFinal;
                        MultipleDetailedEWayBill."Reason Rem" := reasonRem;
                        MultipleDetailedEWayBill."From Place" := fromPlace;
                        MultipleDetailedEWayBill."From State" := fromState;
                        MultipleDetailedEWayBill."To State" := ToState;
                        MultipleDetailedEWayBill."To Place" := ToPlace;
                        MultipleDetailedEWayBill."Tr Mode" := TrMode;
                        MultipleDetailedEWayBill."Total Qty" := TotalQty;
                        MultipleDetailedEWayBill."Unit Code" := UnitCode;
                        MultipleDetailedEWayBill.INSERT;


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
        pgState: Page "States";
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
        ToState: Text;
        ToPlace: Text;
        TotalQty: Text;
        UnitCode: Text;
        TrMode: Text;
        CreateDate: Text;
        VarDate: Date;
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
    procedure SetData(PrewbNo: Text; PrreasonCode: Text; PrreasonRem: Text; PrfromPlace: Text; PrfromState: Text; ProToState: Text; ProToPlace: Text; ProTotalQty: Text; ProTrMode: Text; ProUnitCode: Text; PrcdDocNo: Text)
    begin
        ewbNo := PrewbNo;
        reasonCode := PrreasonCode;
        reasonRem := PrreasonRem;
        fromPlace := PrfromPlace;
        fromState := PrfromState;
        ToState := ProToState;
        ToPlace := ProToPlace;
        TotalQty := ProTotalQty;
        TrMode := ProTrMode;
        UnitCode := ProUnitCode;
        cdGlDocNo := PrcdDocNo;
        //groupNo:= PrgroupNo;
        //CreateDate:=PreCreatedDate;
    end;

    //[Scope('Internal')]
    procedure GetDate(var PrewbNo: Text; var PrreasonCode: Text; var PrreasonRem: Text; var PrfromPlace: Text; var PrfromState: Text; var PrToState: Text; var PrToPlace: Text; var PrTotalQty: Text; var PrTrMode: Text; var PrUnitCode: Text)
    begin
        PrewbNo := ewbNo;
        PrreasonCode := reasonCode;
        PrreasonRem := reasonRem;
        PrfromPlace := fromPlace;
        PrfromState := fromState;
        PrToState := ToState;
        PrToPlace := ToPlace;
        PrTotalQty := TotalQty;
        PrTrMode := TrMode;
        PrUnitCode := UnitCode;
        //PrgroupNo:=groupNo;
        //PreCreatedDate:=CreateDate;
    end;
}

