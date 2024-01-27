codeunit 60017 "Update Processed Sal"
{

    trigger OnRun()
    begin
        MonAtt.INIT;
        MonAtt.SETRANGE(Posted, TRUE);
        win.OPEN('Processing' + Text001);
        win.UPDATE(2, MonAtt.COUNT);
        IF MonAtt.FIND('-') THEN
            REPEAT
                ProcessedSal.RESET;
                ProcessedSal.SETRANGE("Employee Code", MonAtt."Employee Code");
                ProcessedSal.SETRANGE("Pay Slip Month", MonAtt."Pay Slip Month");
                ProcessedSal.SETRANGE(Year, MonAtt.Year);
                IF ProcessedSal.FIND('-') THEN
                    REPEAT
                        CurrCount += 1;
                        win.UPDATE(1, CurrCount);
                        ProcessedSal."Document No" := MonAtt."Document No.";
                        ProcessedSal.MODIFY;
                    UNTIL ProcessedSal.NEXT = 0;
            UNTIL MonAtt.NEXT = 0;

        win.CLOSE;
        MESSAGE('completed');
    end;

    var
        MonAtt: Record 60029;
        ProcessedSal: Record 60038;
        win: Dialog;
        Text001: Label '#1#### of #2####';
        CurrCount: Integer;
}

