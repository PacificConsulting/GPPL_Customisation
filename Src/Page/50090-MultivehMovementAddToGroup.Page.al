page 50090 MultivehMovementAddToGroup
{
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(control01)
            {
                field("E-Way Bill No."; ewbNo)
                {
                    ApplicationArea = all;
                }
                field("Group No"; groupNo)
                {
                    ApplicationArea = all;
                }
                field("vehicle No"; vehicleNo)
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
                field(Quantity; quantity)
                {
                    ApplicationArea = all;
                }
                field("Veh Added Date"; vehAddedDate)
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
                            ERROR('Fill ewbNo');
                        IF groupNo = '' THEN
                            ERROR('Fill groupNo');
                        IF vehicleNo = '' THEN
                            ERROR('Fill vehicleNo');
                        IF transDocNo = '' THEN
                            ERROR('Fill transDocNo');
                        IF transDocDate = '' THEN
                            ERROR('Fill transDocDate');
                        IF quantity = '' THEN
                            ERROR('Fill quantity');

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
                        cuEwayBill.InitiateMultivehicleAddToGroup(ewbNo,groupNo,vehicleNo,transDocNo,transDocDate,quantity,vehAddedDate,GSTRegNo,AccessKey
                                            ,GeneralLedgerSetup."EWB UserName", GeneralLedgerSetup."EWB Password");  //YSr
                        */
                        /*
                        cuEwayBill.InitiateMultivehicleAddToGroup(ewbNo, groupNo, vehicleNo, transDocNo, transDocDate, quantity, vehAddedDate, GSTRegNo, AccessKey
                                            , LocRec."EWB UserName", LocRec."EWB Password");  //YSr

*/
                        MultipleDetailedEWayBill.SETRANGE("Document No.", transDocNo);
                        MultipleDetailedEWayBill.SETRANGE("EWB No.", ewbNo);
                        MultipleDetailedEWayBill.SETRANGE("Group No.", groupNo);
                        IF MultipleDetailedEWayBill.FINDFIRST THEN BEGIN
                            MultipleDetailedEWayBill."Vehicle No." := vehicleNo;
                            MultipleDetailedEWayBill."Trans Doc No." := transDocNo;
                            MultipleDetailedEWayBill."Trans Doc Date" := transDocDate;
                            MultipleDetailedEWayBill.Quantity := quantity;
                            MultipleDetailedEWayBill."Veh Added Date" := vehAddedDate;
                            MultipleDetailedEWayBill."Group No." := groupNo;
                            MultipleDetailedEWayBill.MODIFY;
                        END;

                        CurrPage.CLOSE;

                    end;
                }
            }
        }
    }

    var
        cancelRsnCode: Text;
        cancelRmrk: Text;
        GSTLedgerEntry: Record "GST Ledger Entry";
        //cuEwayBill: Codeunit 50012;
        DetailedEWayBill: Record 50044;
        cancelRsnCodeFinal: Text;
        cancelDate: Text;
        ewayBillNo: Text;
        cdDocNo: Code[20];
        ewbNo: Text;
        groupNo: Text;
        vehicleNo: Text;
        transDocNo: Text;
        transDocDate: Text;
        quantity: Text;
        vehAddedDate: Text;
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

    // [Scope('Internal')]
    procedure SetData(PrewbNo: Text; PrgroupNo: Text; PrvehicleNo: Text; PrtransDocNo: Text; PrtransDocDate: Text; Prquantity: Text; var PrvehAddedDate: Text)
    begin
        ewbNo := PrewbNo;
        groupNo := PrgroupNo;
        vehicleNo := PrvehicleNo;
        transDocNo := PrtransDocNo;
        transDocDate := PrtransDocDate;
        quantity := Prquantity;
        vehAddedDate := PrvehAddedDate;
    end;

    // [Scope('Internal')]
    procedure GetDate(var PrewbNo: Text; var PrgroupNo: Text; var PrvehicleNo: Text; var PrtransDocNo: Text; var PrtransDocDate: Text; var Prquantity: Text; var PrvehAddedDate: Text)
    begin

        PrewbNo := ewbNo;
        PrgroupNo := groupNo;
        PrvehicleNo := vehicleNo;
        PrtransDocNo := transDocNo;
        PrtransDocDate := transDocDate;
        Prquantity := quantity;
        PrvehAddedDate := vehAddedDate;
    end;
}

