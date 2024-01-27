table 60022 "Shift Master"
{
    LookupPageID = 60011;

    fields
    {
        field(1; "Shift Code"; Code[20])
        {
        }
        field(2; Decription; Text[50])
        {
        }
        field(3; "Starting Time"; Time)
        {
        }
        field(4; "Ending Time"; Time)
        {
        }
        field(5; "Break Start Time"; Time)
        {

            trigger OnValidate()
            begin
                IF ("Break End time" <> 0T) THEN BEGIN
                    CheckTime := 130000T;
                    Day := WORKDATE;

                    IF ("Break Start Time" > CheckTime) AND ("Break End time" < CheckTime) THEN BEGIN
                        StartDateTime := CREATEDATETIME(Day, "Break Start Time");
                        EndDateTime := CREATEDATETIME((Day + 1), "Break End time");
                        "Break Duration" := ABS((StartDateTime - EndDateTime) / 3600000);
                    END ELSE
                        "Break Duration" := ABS(("Break Start Time" - "Break End time") / 3600000);
                END;
            end;
        }
        field(6; "Break End time"; Time)
        {

            trigger OnValidate()
            begin
                IF ("Break Start Time" <> 0T) AND ("Break End time" <> 0T) THEN BEGIN
                    CheckTime := 130000T;
                    Day := WORKDATE;

                    IF ("Break Start Time" > CheckTime) AND ("Break End time" < CheckTime) THEN BEGIN
                        StartDateTime := CREATEDATETIME(Day, "Break Start Time");
                        EndDateTime := CREATEDATETIME((Day + 1), "Break End time");
                        "Break Duration" := ABS((StartDateTime - EndDateTime) / 3600000);
                    END ELSE
                        "Break Duration" := ABS(("Break Start Time" - "Break End time") / 3600000);
                END;
            end;
        }
        field(7; "Break Duration"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Shift Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        Day: Date;
        CheckTime: Time;
}

