codeunit 60015 "Update Emp Post to GL"
{

    trigger OnRun()
    begin

        Emp.INIT;
        EmpCount := Emp.COUNT;
        win.OPEN('updating Employees: #1#################\\' + Text001);
        win.UPDATE(3, EmpCount);
        //Emp.SETRANGE(Blocked,FALSE);
        IF Emp.FIND('-') THEN
            REPEAT
                CurrCount := CurrCount + 1;
                win.UPDATE(1, Emp."No.");
                win.UPDATE(2, CurrCount);
                MonAttendence.INIT;
                MonAttendence.RESET;
                MonAttendence.SETRANGE("Employee Code", Emp."No.");
                IF MonAttendence.FIND('-') THEN
                    REPEAT
                        MonAttendence."Post to GL" := Emp."Post to GL";
                        MonAttendence.MODIFY;
                    UNTIL MonAttendence.NEXT = 0;
            UNTIL Emp.NEXT = 0;

        win.CLOSE;

        /*
        Emp.INIT;
        IF Emp.FIND('-') THEN
          REPEAT
            IF NOT Emp.Blocked THEN
               Emp."Post to GL" := TRUE
            ELSE
               Emp."Post to GL" := FALSE;
            Emp.MODIFY;
         UNTIL Emp.NEXT = 0;
        */
        MESSAGE('completed');

    end;

    var
        Emp: Record 60019;
        MonAttendence: Record 60029;
        EmpCount: Integer;
        CurrCount: Integer;
        win: Dialog;
        Text001: Label 'Processing #2#### of #3######';
}

