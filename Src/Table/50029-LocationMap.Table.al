table 50029 "Location Map"
{

    fields
    {
        field(1; "Location Code"; Text[250])
        {
        }
        field(2; "Area"; Code[200])
        {
        }
        field(3; "User ID"; Code[50])
        {
            TableRelation = "User Setup";

            trigger OnValidate()
            begin
                //EBT STIVAN ---(19/04/2012)--- To Update Name Field when User Id is Selected -------START
                User1.GET("User ID");
                Name := User1.Name;
                //EBT STIVAN ---(19/04/2012)--- To Update Name Field when User Id is Selected ---------END
            end;
        }
        field(4; "User Type"; Option)
        {
            OptionCaption = 'Customer';
            OptionMembers = Customer;
        }
        field(5; Customer; Boolean)
        {
        }
        field(6; Name; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "User ID", "User Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "User Type" = "User Type"::Customer THEN
            Customer := TRUE
        ELSE
            IF "User Type" = "User Type"::Customer THEN;
        //CSO := TRUE;
    end;

    var
        User1: Record 91;
}

