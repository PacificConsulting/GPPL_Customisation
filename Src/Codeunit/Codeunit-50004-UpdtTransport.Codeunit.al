codeunit 50004 "Updt Transport"
{

    trigger OnRun()
    begin
        recTDetail.RESET;
        recTDetail.SETRANGE(recTDetail."Applied Document No.", 'CLOSED-230115');
        IF recTDetail.FINDSET THEN
            REPEAT
                recTDetail.Posted := TRUE;
                recTDetail.MODIFY;
            UNTIL recTDetail.NEXT = 0;

        MESSAGE('Done');
    end;



    var
        recTDetail: Record 50020;
}

