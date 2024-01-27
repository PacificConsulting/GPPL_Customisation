/*
codeunit 50007 "Update Charge Type - Strlin"
{

    trigger OnRun()
    begin
        StructureOrderLineDetails.RESET;
        StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails."Tax/Charge Type", 0);
        IF StructureOrderLineDetails.FINDSET THEN
            REPEAT
            BEGIN
                StructureOrderLineDetails."Charge Basis" := 2;
                StructureOrderLineDetails.MODIFY;
                //ERROR('%1',StructureOrderLineDetails.COUNT);
            END;
            UNTIL StructureOrderLineDetails.NEXT = 0;
        MESSAGE('Updated');
    end;

    var
        StructureOrderLineDetails: Record "Structure Order Line Details";
}
*/

