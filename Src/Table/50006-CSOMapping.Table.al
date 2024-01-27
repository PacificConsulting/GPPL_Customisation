table 50006 "CSO Mapping"
{

    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = 'Responsibility Center,Location';
            OptionMembers = "Responsibility Center",Location;
        }
        field(2; "User Id"; Code[50])
        {
            TableRelation = "User Setup"."User ID";

            trigger OnValidate()
            begin
                //EBT STIVAN ---(19/04/2012)--- To Update Name Field when User Id is Selected -------START
                IF User1.GET("User Id") THEN
                    Name := User1.Name;
                //EBT STIVAN ---(19/04/2012)--- To Update Name Field when User Id is Selected ---------END
            end;
        }
        field(3; Value; Code[20])
        {
            TableRelation = IF (Type = CONST("Responsibility Center")) "Responsibility Center"
            ELSE
            IF (Type = CONST(Location)) Location;
        }
        field(4; Name; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; Type, "User Id", Value)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        User1: Record 91;
}

