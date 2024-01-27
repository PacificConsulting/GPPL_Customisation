table 60013 "Employee Timings"
{
    DrillDownPageID = 60066;
    LookupPageID = 60066;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = Employee_;

            trigger OnValidate()
            begin
                IF Employee.GET("Employee No.") THEN
                    "Employee Name" := Employee."First Name";
            end;
        }
        field(2; "Employee Name"; Text[50])
        {
        }
        field(3; Date; Date)
        {
        }
        field(4; "Time In"; Time)
        {

            trigger OnValidate()
            var
                Difference: Decimal;
                MilliSec: Decimal;
                "Min": Decimal;
                Hrs: Decimal;
            begin
                IF "Time Out" <> 0T THEN BEGIN
                    Difference := "Time Out" - "Time In";
                    Hrs := Difference DIV 3600000;
                    MilliSec := Difference MOD 3600000;
                    IF MilliSec <> 0 THEN BEGIN
                        Min := (MilliSec) / (60000);
                        "No.of Hours" := ((Hrs * 100) + (Min)) / 100;
                    END ELSE
                        "No.of Hours" := ("Time Out" - "Time In") / (3600000);
                END;
            end;
        }
        field(5; "Time Out"; Time)
        {

            trigger OnValidate()
            var
                Difference: Decimal;
                MilliSec: Decimal;
                "Min": Decimal;
                Hrs: Decimal;
            begin
                IF "Time In" <> 0T THEN BEGIN
                    Difference := "Time Out" - "Time In";
                    Hrs := Difference DIV 3600000;
                    MilliSec := Difference MOD 3600000;
                    IF MilliSec <> 0 THEN BEGIN
                        Min := (MilliSec) / (60000);
                        "No.of Hours" := ((Hrs * 100) + (Min)) / 100;
                    END ELSE
                        "No.of Hours" := ("Time Out" - "Time In") / (3600000);
                END;
            end;
        }
        field(6; "No.of Hours"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", Date, "Time In")
        {
            Clustered = true;
            SumIndexFields = "No.of Hours";
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record 60019;
        Text000: Label 'Time out should be greater than Time in';
        Text001: Label 'Time in should be greater than %1';
}

