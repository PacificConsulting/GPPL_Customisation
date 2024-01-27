page 50016 "Cancel E-Way Bill"
{
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(group1)
            {
                field("E-Way Bill No."; EwbNo)
                {
                    ApplicationArea = all;
                }
                field("Cancel Reason Code"; cancelRsnCode)
                {
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        ReasonCode.RESET;
                        ReasonCode.FILTERGROUP(2);
                        ReasonCode.SETRANGE(EWB, TRUE);
                        ReasonCode.FILTERGROUP(0);
                        IF PAGE.RUNMODAL(0, ReasonCode) = ACTION::LookupOK THEN
                            cancelRsnCode := ReasonCode.Code;
                    end;
                }
                field("Cancel Remark"; cancelRmrk)
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
                        LocRec: Record 14;
                    begin
                        IF cancelRmrk = '' THEN
                            ERROR('Fill Cancel Remark');
                        IF cancelRsnCode = '' THEN
                            ERROR('Fill Cancel Reason Code');

                        //Setting Lookup data *****-----Begin

                        CASE cancelRsnCode OF
                            'EWB1':
                                cancelRsnCodeFinal := '1';
                            'EWB2':
                                cancelRsnCodeFinal := '2';
                            'EWB3':
                                cancelRsnCodeFinal := '3';
                            'EWB4':
                                cancelRsnCodeFinal := '4';
                        END;

                        //Setting Lookup data *****-----End

                        //AKT_EWB 10202020
                        GSTLedgerEntry1.RESET;
                        GSTLedgerEntry1.SETRANGE("E-Way Bill No.", EwbNo);
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
                        /*
                        cuEwayBill.CancelEWB(EwbNo, cancelRsnCodeFinal, cancelRmrk, cancelDate, ewayBillNo, GSTRegNo, AccessKey, LocRec."EWB UserName", LocRec."EWB Password");
*/
                        IF cancelDate <> '' THEN BEGIN
                            DetailedEWayBill.SETRANGE("Document No.", cdDocNo);
                            DetailedEWayBill.SETRANGE(Cancelled, FALSE);
                            DetailedEWayBill.SETRANGE("EWB No.", EwbNo);
                            IF DetailedEWayBill.FINDSET THEN BEGIN
                                REPEAT
                                    DetailedEWayBill.Cancelled := TRUE;
                                    DetailedEWayBill."Cancel Date" := cancelDate;
                                    DetailedEWayBill.MODIFY;
                                UNTIL DetailedEWayBill.NEXT = 0;
                            END;
                        END;

                        GSTLedgerEntry.RESET;
                        GSTLedgerEntry.SETRANGE("Document No.", cdDocNo);
                        //GSTLedgerEntry.SETRANGE("Transaction Type",GSTLedgerEntry."Transaction Type"::Sales);
                        IF GSTLedgerEntry.FINDSET THEN BEGIN
                            GSTLedgerEntry.MODIFYALL("E-Way Bill No.", 'Cancelled');
                        END;

                        CurrPage.CLOSE;
                    end;
                }
            }
        }
    }

    var
        EwbNo: Text;
        cancelRsnCode: Text;
        cancelRmrk: Text;
        GSTLedgerEntry: Record "GST Ledger Entry";
        // cuEwayBill: Codeunit 50012;
        DetailedEWayBill: Record 50044;
        cancelRsnCodeFinal: Text;
        cancelDate: Text;
        ewayBillNo: Text;
        cdDocNo: Code[20];
        GSTRegNo: Code[20];
        DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
        AccessKey1: Text;
        AccessKey: Label 'sd321e213213';
        GSTLedgerEntry1: Record "GST Ledger Entry";
        DocNumber: Code[20];
        GeneralLedgerSetup: Record 98;
        ReasonCode: Record 231;

    //[Scope('Internal')]
    procedure SetData(prEwbNo: Text; prcancelRsnCode: Text; prcancelRmrk: Text; prcdDocNo: Code[20])
    begin
        EwbNo := prEwbNo;
        cancelRsnCode := prcancelRsnCode;
        cancelRmrk := prcancelRmrk;
        cdDocNo := prcdDocNo;
    end;

    //[Scope('Internal')]
    procedure GetDate(var prEwbNo: Text; var prcancelRsnCode: Text; var prcancelRmrk: Text)
    begin
        prEwbNo := EwbNo;
        prcancelRsnCode := cancelRsnCode;
        prcancelRmrk := cancelRmrk;
    end;
}

