pageextension 70001 ApprovalEntExtcstm extends 658
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;




    Procedure Setfilters(TableId: Integer; DocumentType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order"; DocumentNo: Code[20])
    var
    begin

        IF TableId <> 0 THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETCURRENTKEY("Table ID", "Document Type", "Document No.");
            Rec.SETRANGE("Table ID", TableId);
            Rec.SETRANGE("Document Type", DocumentType);
            IF DocumentNo <> '' THEN
                Rec.SETRANGE("Document No.", DocumentNo);
            Rec.FILTERGROUP(0);
        END;

    end;
}