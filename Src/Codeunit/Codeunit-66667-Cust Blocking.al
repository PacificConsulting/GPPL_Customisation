codeunit 66667 "Cust Blocking"
{

    trigger OnRun()
    begin
        IF recCustBlock.FINDSET THEN
            REPEAT
                recCust.GET(recCustBlock."Cust No.");
                recCust.Blocked := recCust.Blocked::All;
                recCust.MODIFY;
                recCustBlock.Blocked := TRUE;
                recCustBlock.MODIFY;
            UNTIL recCustBlock.NEXT = 0;

        MESSAGE('Done');
    end;

    var
        recCustBlock: Record 66666;
        recCust: Record 18;
}

