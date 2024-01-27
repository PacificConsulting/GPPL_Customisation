codeunit 50005 creditLimit_update
{

    trigger OnRun()
    begin
        RecCustNew.RESET;
        IF RecCustNew.FINDSET THEN
            REPEAT
                RecCust.GET(RecCustNew.No);
                RecCust."Credit Limit (LCY)" := RecCustNew."Credit Limit";
                RecCust.MODIFY;
                RecCustNew.Update := TRUE;
                RecCustNew.MODIFY;
            UNTIL RecCustNew.NEXT = 0;
        MESSAGE('Done');
    end;

    var
        RecCust: Record 18;
        RecCustNew: Record 50032;
}

