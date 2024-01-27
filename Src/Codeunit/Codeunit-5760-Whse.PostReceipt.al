codeunit 50025 WhsePostRecptExtCstm
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnAfterRun, '', false, false)]
    local procedure OnAfterRun(var WarehouseReceiptLine: Record "Warehouse Receipt Line");
    var
        "WhseNo.": code[10];
        WhseRcptHeader: Record "Warehouse Receipt Header";
    begin

        //>>Robosoft\Migration\Rahul**
        IF "WhseNo." <> WhseRcptHeader."No." THEN
            MESSAGE('Posted document is %1', WhseRcptHeader."No.");
        "WhseNo." := WhseRcptHeader."No.";
        //<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnBeforeInitSourceDocumentLines, '', false, false)]
    local procedure OnBeforeInitSourceDocumentLines(var WhseReceiptLine: Record "Warehouse Receipt Line"; var IsHandled: Boolean);
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine."Qty. per Unit of Measure" := 1;    //EBTParamita
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", OnBeforeInsertTempWhseJnlLine, '', false, false)]
    local procedure OnBeforeInsertTempWhseJnlLine(var TempWarehouseJournalLine: Record "Warehouse Journal Line" temporary; PostedWhseReceiptLine: Record "Posted Whse. Receipt Line");
    var

    begin
        TempWarehouseJournalLine."Unit of Measure Code" := PostedWhseReceiptLine."Unit of Measure Code";  //EBTParamita
    end;



    var
        myInt: Integer;
}