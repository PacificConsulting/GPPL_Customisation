codeunit 50006 PMWeightUpdate
{

    trigger OnRun()
    begin
        PMWeight.RESET;
        IF PMWeight.FINDSET THEN
            REPEAT
                Item.GET(PMWeight.No);
                Item."Packing Material Weight in KG" := PMWeight."Packing Material Weight in KG";
                Item.MODIFY;
                PMWeight.uPDATE := TRUE;
                PMWeight.MODIFY;
            UNTIL PMWeight.NEXT = 0;
    end;

    var
        Item: Record 27;
        PMWeight: Record 50037;
}

