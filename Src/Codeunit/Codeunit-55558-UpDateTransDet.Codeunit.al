codeunit 55558 UpDateTransDet
{

    trigger OnRun()
    begin
        recupdateTransDet.RESET;
        IF recupdateTransDet.FINDSET THEN
            REPEAT
                rec50020.RESET;
                rec50020.SETRANGE(rec50020."Invoice No.", recupdateTransDet."InvNo.");
                IF rec50020.FINDFIRST THEN BEGIN
                    rec50020.Open := FALSE;
                    rec50020.Applied := TRUE;
                    rec50020."Applied Document No." := recupdateTransDet.applDocNo;
                    rec50020."Applied Date" := recupdateTransDet.AppDate;
                    rec50020.Posted := TRUE;
                    rec50020.MODIFY;
                    recupdateTransDet.Done := TRUE;
                    recupdateTransDet.MODIFY;
                END;
            UNTIL recupdateTransDet.NEXT = 0;
        MESSAGE('Done');
    end;

    var
        rec50020: Record 50020;
        recupdateTransDet: Record 55558;
}

