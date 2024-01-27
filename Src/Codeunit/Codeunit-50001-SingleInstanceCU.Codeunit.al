codeunit 50001 "Single Instance CU"
{
    SingleInstance = true;

    trigger OnRun()
    begin
        IF NOT StoreToTemp THEN BEGIN
            StoreToTemp := TRUE;
        END ELSE
            PAGE.RUN(0, TempGLEntry);
    end;

    var
        TempGLEntry: Record 17 temporary;
        StoreToTemp: Boolean;


    // [Scope('Internal')]
    procedure InsertGL(GLEntry: Record 17)
    begin
        IF StoreToTemp THEN BEGIN
            TempGLEntry := GLEntry;
            IF NOT TempGLEntry.INSERT THEN BEGIN
                TempGLEntry.DELETEALL;
                TempGLEntry.INSERT;
            END;
        END;
    end;





}

