codeunit 60014 "Update Pay Elements"
{

    trigger OnRun()
    begin
        PayRevisionLine.INIT;

        win.OPEN('Employee No. #1############\' + Text001);
        TotCount := PayRevisionLine.COUNT;
        win.UPDATE(3, TotCount);
        IF PayRevisionLine.FIND('-') THEN
            REPEAT
                Currcount += 1;
                win.UPDATE(1, PayRevisionLine."No.");
                win.UPDATE(2, Currcount);

                PayElements.VALIDATE("Employee Code", PayRevisionLine."No.");
                PayElements.VALIDATE("Effective Start Date", PayRevisionLine."Effective Date");
                PayElements.VALIDATE("Pay Element Code", PayRevisionLine."Pay Element");
                PayElements.VALIDATE("Fixed/Percent", PayRevisionLine."Fixed / Percent");
                PayElements.VALIDATE("Computation Type", PayRevisionLine."Computation Type");
                PayElements.VALIDATE("Amount / Percent", PayRevisionLine."Revised Amount / Percent");
                PayElements.VALIDATE("Add/Deduct", PayRevisionLine."Add/Deduct");
                PayElements.VALIDATE("Applicable for OT");
                PayElements.VALIDATE(ESI);
                PayElements.VALIDATE(PF);
                PayElements."Pay Cadre" := PayRevisionLine.Grade;
                /*
                Emp.INIT;
                Emp.GET(PayRevisionLine."No.");
                IF Emp.FIND('-') THEN;
                PayElements.VALIDATE("Pay Cadre",Emp."Pay Cadre");
                */
                PayElements.VALIDATE(PayElements.Gratuity);
                PayElements.VALIDATE(PayElements.PT);
                PayrevHeader.INIT;
                PayrevHeader.RESET;
                PayrevHeader.SETRANGE("Id.", PayRevisionLine."Header No.");
                IF PayrevHeader.FIND('-') THEN BEGIN
                    PayrevHeader.Status := PayrevHeader.Status::Released;
                    PayrevHeader.MODIFY;
                END;
                PayElements.INSERT;
            UNTIL PayRevisionLine.NEXT = 0;

        win.CLOSE;

    end;

    var
        PayElements: Record 60025;
        PayRevisionLine: Record 60049;
        Emp: Record 60019;
        Text001: Label 'Processing #2#### of #3#####';
        TotCount: Integer;
        Currcount: Integer;
        win: Dialog;
        PayrevHeader: Record 60048;
}

