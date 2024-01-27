page 50018 "E-Way Bill Extend Validity"
{
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(general)
            {
                field("E-Way Bill No."; EwbNo)
                {
                    ApplicationArea = all;
                }
                field("Vehicle No"; vehicleNo)
                {
                    ApplicationArea = all;
                }
                field("From Place"; fromPlace)
                {
                    ApplicationArea = all;
                }
                field("From State Code"; fromStateCode)
                {
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF PAGE.RUNMODAL(13789, RecState) = ACTION::LookupOK THEN BEGIN

                            fromStateCode := RecState."State Code (GST Reg. No.)";
                            Text := RecState."State Code (GST Reg. No.)";

                            CurrPage.UPDATE;
                            //CLEAR(pgState);

                        END;
                    end;
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
                            //CLEAR(pgState);

                        END;
                    end;
                }
                field("Remaining Distance"; remainingDistance)
                {
                    ApplicationArea = all;
                }
                field("Trans Doc No"; transDocNo)
                {
                    ApplicationArea = all;
                }
                field("Trans Doc Date"; transDocDate)
                {
                    ApplicationArea = all;
                }
                field("Trans Mode"; TransMode)
                {
                    ApplicationArea = all;
                }
                field("Extn Rsn Code"; extnRsnCode)
                {
                    ApplicationArea = all;
                    TableRelation = "Reason Code";

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ReasonCode.RESET;
                        ReasonCode.FILTERGROUP(2);
                        ReasonCode.SETRANGE(EWB, TRUE);
                        ReasonCode.FILTERGROUP(0);
                        IF PAGE.RUNMODAL(0, ReasonCode) = ACTION::LookupOK THEN
                            extnRsnCode := ReasonCode.Code;
                    end;
                }
                field("Extn Remarks"; extnRemarks)
                {
                    ApplicationArea = all;
                }
                field(fromPincode; fromPincode)
                {
                    ApplicationArea = all;
                }
                field(consignmentStatus; consignmentStatus)
                {
                    ApplicationArea = all;
                }
                field(transitType; transitType)
                {
                    ApplicationArea = all;
                }
                field(addressLine1; addressLine1)
                {
                    ApplicationArea = all;
                }
                field(addressLine2; addressLine2)
                {
                    ApplicationArea = all;
                }
                field(addressLine3; addressLine3)
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
            group(general1)
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
                    begin
                        CASE extnRsnCode OF
                            'EWB1':
                                extnRsnCodeFinal := '1';
                            'EWB2':
                                extnRsnCodeFinal := '2';
                            'EWB3':
                                extnRsnCodeFinal := '3';
                            'EWB4':
                                extnRsnCodeFinal := '4';
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
                            TransMode::inTransit:
                                TransModeFinal := '5'; //14022020
                        END;

                        //AKT_EWB 10202020
                        DetailedGSTLedgerEntry1.RESET;
                        DetailedGSTLedgerEntry1.SETRANGE("Document No.", transDocNo);
                        IF DetailedGSTLedgerEntry1.FINDFIRST THEN BEGIN
                            GSTRegNo := DetailedGSTLedgerEntry1."Location  Reg. No.";
                        END;
                        //AKT_EWB 10202020

                        GeneralLedgerSetup.GET;
                        LocRec.GET(DetailedGSTLedgerEntry1."Location Code");
                        //GSTRegNo  :=  LocRec."EWB UserName";

                        /*
                        cuEwayBill.ExtendValidity(EwbNo,vehicleNo,fromPlace,fromStateCode,fromState,remainingDistance,transDocNo,transDocDate,TransModeFinal,extnRsnCodeFinal,extnRemarks,
                        updatedDate,validUpto,fromPincode,consignmentStatus+','+transitType,addressLine1+','+addressLine2+','+addressLine3,GSTRegNo+','+AccessKey+','+GeneralLedgerSetup."EWB UserName"+','+GeneralLedgerSetup."EWB Password");
                        */
                        /*
                        cuEwayBill.ExtendValidity(EwbNo, vehicleNo, fromPlace, fromStateCode, fromState, remainingDistance, transDocNo, transDocDate, TransModeFinal, extnRsnCodeFinal, extnRemarks,
                        updatedDate, validUpto, fromPincode, consignmentStatus + ',' + transitType, addressLine1 + ',' + addressLine2 + ',' + addressLine3, GSTRegNo + ',' + AccessKey + ',' + LocRec."EWB UserName" + ',' + LocRec."EWB Password");
*/
                        /*
                    DetailedEWayBill.GET(cdGlDocNo,EwbNo);
                    DetailedEWayBill."EWB Valid Upto" :=  validUpto;
                    DetailedEWayBill."EWB Updated Date" :=  updatedDate;
                    DetailedEWayBill.MODIFY;
                       */

                        IF validUpto <> '' THEN BEGIN
                            DetailedEWayBill.SETRANGE("Document No.", cdGlDocNo);
                            DetailedEWayBill.SETRANGE("EWB No.", EwbNo);
                            IF DetailedEWayBill.FINDSET THEN BEGIN
                                REPEAT
                                    DetailedEWayBill."EWB Valid Upto" := validUpto;
                                    DetailedEWayBill."EWB Updated Date" := updatedDate;
                                    DetailedEWayBill.MODIFY;
                                UNTIL DetailedEWayBill.NEXT = 0;
                            END;
                        END;

                        CurrPage.CLOSE;

                    end;
                }
            }
        }
    }

    var
        EwbNo: Text;
        vehicleNo: Text;
        fromPlace: Text;
        fromStateCode: Text;
        fromState: Text;
        remainingDistance: Text;
        transDocNo: Text;
        transDocDate: Text;
        extnRsnCode: Text;
        extnRemarks: Text;
        fromPincode: Text;
        consignmentStatus: Text;
        transitType: Text;
        addressLine1: Text;
        addressLine2: Text;
        addressLine3: Text;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        GSTLedgerEntry: Record "GST Ledger Entry";
        SalesInvoiceHeader: Record 112;
        //cuEwayBill: Codeunit 50012;
        DetailedEWayBill: Record 50044;
        TransMode: Option Road,Rail,Air,Ship,inTransit;
        TransModeFinal: Text;
        extnRsnCodeFinal: Text;
        cdGlDocNo: Code[20];
        updatedDate: Text;
        validUpto: Text;
        RecState: Record State;
        //pgState: Page 13789;
        RecLoc: Record 14;
        pgLoc: Page 15;
        AccessKey: Label 'sd321e213213';
        GSTRegNo: Code[20];
        DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
        AccessKey1: Text;
        GeneralLedgerSetup: Record 98;
        LocRec: Record 14;
        ReasonCode: Record 231;

    //  [Scope('Internal')]
    procedure SetData(PrEwbNo: Text; PrvehicleNo: Text; PrfromPlace: Text; PrfromStateCode: Text; PrfromState: Text; PrremainingDistance: Text; PrtransDocNo: Text; PrtransDocDate: Text; PrtransMode: Option Road,Rail,Air,Ship; PrextnRsnCode: Text; PrextnRemarks: Text; prcdGlDocNo: Code[20])
    begin
        EwbNo := PrEwbNo;
        vehicleNo := PrvehicleNo;
        fromPlace := PrfromPlace;
        fromStateCode := PrfromStateCode;
        fromState := PrfromState;
        remainingDistance := PrremainingDistance;
        transDocNo := PrtransDocNo;
        transDocDate := PrtransDocDate;
        TransMode := PrtransMode;
        extnRsnCode := PrextnRsnCode;
        extnRemarks := PrextnRemarks;
        cdGlDocNo := prcdGlDocNo;
    end;

    //  [Scope('Internal')]
    procedure GetData(var PrEwbNo: Text; var PrvehicleNo: Text; var PrfromPlace: Text; var PrfromStateCode: Text; var PrfromState: Text; var PrremainingDistance: Text; var PrtransDocNo: Text; var PrtransDocDate: Text; var PrtransMode: Text; var PrextnRsnCode: Text; var PrextnRemarks: Text)
    begin
        PrEwbNo := EwbNo;
        PrvehicleNo := vehicleNo;
        PrfromPlace := fromPlace;
        PrfromStateCode := fromStateCode;
        PrfromState := fromState;
        PrremainingDistance := remainingDistance;
        PrtransDocNo := transDocNo;
        PrtransDocDate := transDocDate;
        //PrtransMode:=transMode;
        PrextnRsnCode := extnRsnCode;
        PrextnRemarks := extnRemarks;
    end;
}

