codeunit 66666 Serial
{

    trigger OnRun()
    begin
        MESSAGE('%1', SERIALNUMBER);
    end;
}

