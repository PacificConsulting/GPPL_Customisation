codeunit 50024 TOPostYNExtCstm
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post (Yes/No)", OnBeforePost, '', false, false)]
    local procedure OnBeforePost(var TransHeader: Record "Transfer Header"; var IsHandled: Boolean; var TransferOrderPostShipment: Codeunit "TransferOrder-Post Shipment"; var TransferOrderPostReceipt: Codeunit "TransferOrder-Post Receipt"; var PostBatch: Boolean; var TransferOrderPost: Enum "Transfer Order Post");
    var
        recLoc1: Record Location;
        recLoc2: Record Location;
        TransferFrm: code[10];
        TransferTo: code[10];
        recState: Record State;
    begin

        //EBT STIVAN ---(11122012)--- POP Up of ERROR Message if Road Permit is True in state and Road Permit No. is Blank at TO------START
        recLoc1.GET(TransHeader."Transfer-from Code");
        TransferFrm := recLoc1."State Code";
        recLoc2.GET(TransHeader."Transfer-to Code");
        TransferTo := recLoc2."State Code";
        IF TransferFrm <> TransferTo THEN BEGIN
            recState.RESET;
            recState.SETRANGE(recState.Code, TransferTo);
            IF recState.FINDFIRST THEN BEGIN
                //  IF recState."Road Permit" = TRUE THEN BEGIN  /// MY PC field not found;
                IF TransHeader."Road Permit No." = '' THEN
                    ERROR('Please Specify Road Permit No.');
            END;
            // END;
        END;
        //EBT STIVAN ---(11122012)--- POP Up of ERROR Message if Road Permit is True in state and Road Permit No. is Blank at TO--------END

        //Start DJ 13/03/20 Calculate Distance in KM for Eway Bill
        IF TransHeader."Distance in kms" = 0 THEN BEGIN
            IF (TransHeader."Transfer-from Post Code" <> '') AND (TransHeader."Transfer-to Post Code" <> '') THEN BEGIN
                //  TransHeader."Distance in kms" := CUEwayAPI.DistanceMatrix(TransHeader."Transfer-from Post Code", TransHeader."Transfer-to Post Code");
                TransHeader.MODIFY;
            END;
        END;
        // DJ 13/03/20 END Calculate Distance in KM for Eway Bill
    end;


    var
        myInt: Integer;
}