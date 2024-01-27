codeunit 56667 "Dim Update"
{

    trigger OnRun()
    begin
        recDimUpdt.RESET;
        IF recDimUpdt.FINDSET THEN
            REPEAT
                recDimDef.GET(18, recDimUpdt.Cust, 'DIVISION');
                recDimDef."Dimension Value Code" := 'DIV-05';
                recDimDef.MODIFY;
                recDimUpdt.Done := TRUE;
                recDimUpdt.MODIFY;
            UNTIL recDimUpdt.NEXT = 0;

        MESSAGE('Done');
    end;

    var
        recDimUpdt: Record 56667;
        recDimDef: Record 352;
        recCust: Record 18;
        recDefDim: Record 352;
}

