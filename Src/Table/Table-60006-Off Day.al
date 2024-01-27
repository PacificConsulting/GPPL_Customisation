table 60006 "Off Day"
{
    // Date: 06-Jan-06


    fields
    {
        field(1; ID; Integer)
        {
        }
        field(2; Day; Option)
        {
            OptionMembers = " ",Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday;

            trigger OnValidate()
            begin
                IF Day = Day::Sunday THEN
                    "Day No." := 7
                ELSE
                    IF Day = Day::Saturday THEN
                        "Day No." := 6
                    ELSE
                        IF Day = Day::Friday THEN
                            "Day No." := 5
                        ELSE
                            IF Day = Day::Thursday THEN
                                "Day No." := 4
                            ELSE
                                IF Day = Day::Wednesday THEN
                                    "Day No." := 3
                                ELSE
                                    IF Day = Day::Tuesday THEN
                                        "Day No." := 2
                                    ELSE
                                        IF Day = Day::Monday THEN
                                            "Day No." := 1
                                        ELSE
                                            "Day No." := 0;
            end;
        }
        field(3; "Weekly Off"; Option)
        {
            OptionMembers = " ","Half Day","Full Day";
        }
        field(4; "Day No."; Integer)
        {
        }
        field(5; NonWorking; Boolean)
        {
        }
        field(6; "Week No."; Option)
        {
            OptionMembers = " ","1","2","3","4","5",All;
        }
        field(8; "Applicable Date"; Date)
        {
        }
        field(9; "Operation Type"; Code[50])
        {
            Caption = 'Office Type';
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('OFFICE TYPE'));
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF OffDay.FIND('+') THEN
            Num := OffDay.ID
        ELSE
            Num := 0;

        ID := Num + 1;
    end;

    var
        OffDay: Record "60006";
        Num: Integer;
}

