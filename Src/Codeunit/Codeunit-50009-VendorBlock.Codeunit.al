codeunit 50009 "Vendor Block"
{

    trigger OnRun()
    begin
        vendBlock.RESET;
        IF vendBlock.FINDSET THEN
            REPEAT
                recVend.GET(vendBlock.Vendor);
                recVend.Blocked := recVend.Blocked::All;
                recVend.MODIFY;
            UNTIL vendBlock.NEXT = 0;

        MESSAGE('Done');
    end;

    var
        vendBlock: Record 50033;
        recVend: Record 23;
}

