codeunit 54545 UpDtHQ
{

    trigger OnRun()
    begin
        HQUpdt.RESET;
        IF HQUpdt.FINDSET THEN
            REPEAT
                recCust.GET(HQUpdt.custno);
                HeadQ.RESET;
                HeadQ.SETRANGE(HeadQ.Code, HQUpdt.HQLoc);
                IF HeadQ.FINDFIRST THEN;
                recCust."Headquarter Location" := HeadQ.Name;
                recCust.MODIFY;
            UNTIL HQUpdt.NEXT = 0;
    end;

    var
        HQUpdt: Record 54545;
        recCust: Record 18;
        HeadQ: Record 50038;
}

