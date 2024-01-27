table 60001 "Detailed Applied Leave"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            TableRelation = Employee_;
        }
        field(2; Date; Date)
        {
        }
        field(3; "Leave Code"; Code[10])
        {
            TableRelation = "Leave Master";
        }
        field(4; Applied; Boolean)
        {
        }
        field(5; Approved; Boolean)
        {
        }
        field(6; Day; Decimal)
        {
        }
        field(7; Reject; Boolean)
        {
        }
        field(8; "Leave Duration"; Option)
        {
            OptionCaption = ' ,Half Day,Full Day';
            OptionMembers = " ","Half Day","Full Day";
        }
    }

    keys
    {
        key(Key1; "Employee Code", Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

