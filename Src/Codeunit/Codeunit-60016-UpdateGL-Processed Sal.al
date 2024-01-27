codeunit 60016 "UpdateGL-Processed Sal"
{

    trigger OnRun()
    begin
        /*
        ProcessedSal.INIT;
        ProcessedSal.SETRANGE("Computation Type",'LOAN');
        ProcessedSal.SETFILTER("Account No.",'<>%1','23000');
        win.OPEN('Processing...'+Text001);
        TotCount := ProcessedSal.COUNT;
        win.UPDATE(2,TotCount);
        IF ProcessedSal.FIND('-') THEN
          REPEAT
            CurrCount += 1;
            win.UPDATE(1,CurrCount);
            Monthname2;
            AddDesc := 'Salary Advance';
            GLEntry.INIT;
            GLEntry.RESET;
            GLEntry.SETCURRENTKEY("Document No.");
            GLEntry.SETRANGE("Document No.",ProcessedSal."Document No");
            GLEntry.SETRANGE("G/L Account No.",ProcessedSal."Account No.");
            GLEntry.SETRANGE("Credit Amount",ProcessedSal."Earned Amount");
            IF GLEntry.FIND('-') THEN
              BEGIN
                GLEntry."G/L Account No." := '23000';
                GLEntry.Description := AddDesc + ' '+ MonthName +' '+ FORMAT(ProcessedSal.Year);
                GLEntry.MODIFY;
              END;
            ProcessedSal."Account No." := '23000';
            ProcessedSal.MODIFY;
         UNTIL ProcessedSal.NEXT = 0;
        
        win.CLOSE;
        */

    end;

    var
        ProcessedSal: Record 60038;
        GLEntry: Record 17;
        MonthName: Text[30];
        AddDesc: Text[30];
        win: Dialog;
        TotCount: Integer;
        CurrCount: Integer;
        Text001: Label '#1### of #2#####';

    // [Scope('Internal')]
    procedure Monthname2()
    begin
        IF ProcessedSal."Pay Slip Month" = 1 THEN
            MonthName := 'JAN';
        IF ProcessedSal."Pay Slip Month" = 2 THEN
            MonthName := 'FEB';
        IF ProcessedSal."Pay Slip Month" = 3 THEN
            MonthName := 'MAR';
        IF ProcessedSal."Pay Slip Month" = 4 THEN
            MonthName := 'APR';
        IF ProcessedSal."Pay Slip Month" = 5 THEN
            MonthName := 'MAY';
        IF ProcessedSal."Pay Slip Month" = 6 THEN
            MonthName := 'JUN';
        IF ProcessedSal."Pay Slip Month" = 7 THEN
            MonthName := 'JUL';
        IF ProcessedSal."Pay Slip Month" = 8 THEN
            MonthName := 'AUG';
        IF ProcessedSal."Pay Slip Month" = 9 THEN
            MonthName := 'SEPT';
        IF ProcessedSal."Pay Slip Month" = 10 THEN
            MonthName := 'OCT';
        IF ProcessedSal."Pay Slip Month" = 11 THEN
            MonthName := 'NOV';
        IF ProcessedSal."Pay Slip Month" = 12 THEN
            MonthName := 'DEC';
    end;
}

