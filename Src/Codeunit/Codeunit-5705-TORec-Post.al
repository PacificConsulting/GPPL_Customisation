codeunit 50023 TOPostRecExtCstm
{
    trigger OnRun()
    begin

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnBeforeOnRun, '', false, false)]
    local procedure OnBeforeOnRun(var TransferHeader2: Record "Transfer Header"; HideValidationDialog: Boolean; SuppressCommit: Boolean; var IsHandled: Boolean);

    var
        AccessControl: Record "Access Control";
        CSOMapping: Record "CSO Mapping";
        RecLocation: Record 14;
        InvtSetup: Record "Inventory Setup";
    begin

        //EBT STIVAN ---(20022013)---Errror Message POP UP, If User is receiving other then his Location TRO-----START

        //RSPL-TC +
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETRANGE("Role ID", '%1', 'SUPER');
        IF NOT (AccessControl.FINDFIRST) THEN //RSPL-TC -
        BEGIN
            CSOMapping.RESET;
            CSOMapping.SETRANGE(CSOMapping.Type, CSOMapping.Type::Location);
            CSOMapping.SETRANGE(CSOMapping."User Id", USERID);
            CSOMapping.SETRANGE(CSOMapping.Value, TransferHeader2."Transfer-to Code");
            IF NOT (CSOMapping.FINDFIRST) THEN BEGIN
                ERROR('You can not Receive other then your Location');
            END;
        END;
        //EBT STIVAN ---(20022013)---Errror Message POP UP, If User is receiving other then his Location TRO-------END

        //EBT::For change dimension::start
        InvtSetup.GET;
        InvtSetup."Updating Dimension While Post" := TRUE;
        InvtSetup.MODIFY;
        RecLocation.GET(TransferHeader2."Transfer-to Code");
        //VALIDATE("Shortcut Dimension 1 Code",RecLocation."Global Dimension 1 Code");  //TC RSPL
        TransferHeader2.VALIDATE("Shortcut Dimension 2 Code", RecLocation."Global Dimension 2 Code");
        InvtSetup.GET;
        InvtSetup."Updating Dimension While Post" := FALSE;
        InvtSetup.MODIFY;

        //EBT::For change dimension::end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnAfterInsertTransRcptHeader, '', false, false)]
    local procedure OnAfterInsertTransRcptHeader(var TransRcptHeader: Record "Transfer Receipt Header"; var TransHeader: Record "Transfer Header");
    begin

        //EBT0001
        TransRcptHeader."Empty Vehicle Weight" := TransHeader."Empty Vehicle Weight";
        TransRcptHeader."Vehicle Weight After loading" := TransHeader."Vehicle Weight After loading";
        TransRcptHeader."Net Weight of the Truck" := TransHeader."Net Weight of the Truck";
        TransRcptHeader."WH Bill Entry No." := TransHeader."WH Bill Entry No.";
        TransRcptHeader."Time In/Out" := TransHeader."Time In/Out";
        TransRcptHeader."Debond Bill Entry No." := TransHeader."Debond Bill Entry No.";
        //EBT0001
        //EBT STIVAN ---(29052012)--- To Capture Transfer Indent No in Receipt------------START
        TransRcptHeader."Transfer Indent No." := TransHeader."Transfer Indent No";
        //EBT STIVAN ---(29052012)--- To Capture Transfer Indent No in Receipt--------------END

        //EBT STIVAN--(11122012)--To Update Road Permit No-----------START
        TransRcptHeader."Road Permit No." := TransHeader."Road Permit No.";
        //EBT STIVAN--(11122012)--To Update Road Permit No-----------START

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnBeforeInsertTransRcptLine, '', false, false)]
    local procedure OnBeforeInsertTransRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; TransferReceiptHeader: Record "Transfer Receipt Header");
    begin

        TransRcptLine."Transfer Indent No." := TransLine."Transfer Indent No.";             //EBT/TROIndent/0001
        TransRcptLine."Transfer Indent Line No." := TransLine."Transfer Indent Line No.";   //EBT/TROIndent/0001

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnAfterInsertTransRcptLine, '', false, false)]
    local procedure OnAfterInsertTransRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; TransferReceiptHeader: Record "Transfer Receipt Header");
    var
        InventoryPostingSetup: Record "Inventory Posting Setup";
        GenJnlLine: Record "Gen. Journal Line";
        TransHeader: Record "Transfer Header";
        TransferBuffer: array[2] of Record "Transfer Buffer" temporary;
    begin

        // TC IPOL
        //InventoryPostingSetup.TESTFIELD("Inventory Account"); // TC IPOL CORRECTED LIKE 2009
        //GenJnlLine."Account No." := InventoryPostingSetup."Inventory Account"; // TC IPOL CORRECTED LIKE 2009
        InventoryPostingSetup.TESTFIELD("Unrealized Profit Account"); // TC IPOL 19 FEB
        GenJnlLine."Account No." := InventoryPostingSetup."Unrealized Profit Account"; // TC IPOL 19 FEB


        //GenJnlLine.Amount := TransferBuffer[1]."Amount Loaded on Inventory" + TransferBuffer[1]."GST Amount";
        //>>RB-N
        GenJnlLine.Amount := TransferBuffer[1]."Amount Loaded on Inventory";
        IF TransferBuffer[1]."GST Amount Loaded on Inventory" <> 0 THEN
            GenJnlLine.Amount += TransferBuffer[1]."GST Amount";
        //<<RB-N


        GenJnlLine."Dimension Set ID" := TransHeader."Dimension Set ID"; //TC RSPL


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", OnBeforePostItemJnlLine, '', false, false)]
    local procedure OnBeforePostItemJnlLine(var TransferReceiptHeader: Record "Transfer Receipt Header"; var IsHandled: Boolean; TransferReceiptLine: Record "Transfer Receipt Line");
    var
        TransLine: Record "Transfer Line";
        decLoadAmt: Decimal;
    begin

        //>>RB-N 30Jan2019
        IF TransLine.Quantity <> TransLine."Qty. to Receive" THEN
            decLoadAmt := decLoadAmt / (TransLine.Quantity / TransLine."Qty. to Receive");
        //<<RB-N 30Jan2019

    end;




    var
        myInt: Integer;
}