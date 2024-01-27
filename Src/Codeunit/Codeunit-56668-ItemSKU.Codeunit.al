codeunit 56668 "Item SKU"
{

    trigger OnRun()
    begin
        recItemSKU.RESET;
        //recItemSKU.SETRANGE(recItemSKU.code,'FGIL0544');
        IF recItemSKU.FINDSET THEN
            REPEAT
                /*recItem.GET(recItemSKU.code);
                recItem."Excise Prod. Posting Group":='2710 19 80';
                recItem."MRP Value":=TRUE;
                recItem.MODIFY;*/
                recILE.RESET;
                recILE.SETRANGE(recILE."Item No.", recItemSKU.code);
                //recILE.SETRANGE(recILE.Open,TRUE);
                IF recILE.FINDSET THEN
                    REPEAT
                        recILE.VALIDATE("Item Category Code", 'CAT11');
                        recILE.MODIFY;
                        recItemSKU.done := TRUE;
                        recItemSKU.MODIFY;
                    UNTIL recILE.NEXT = 0;
            UNTIL recItemSKU.NEXT = 0;
        MESSAGE('Done');

    end;

    var
        recItemSKU: Record 56668;
        recDefaultDim: Record 352;
        recItem: Record 27;
        recILE: Record 32;
}

