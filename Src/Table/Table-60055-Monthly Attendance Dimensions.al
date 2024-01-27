table 60055 "Monthly Attendance Dimensions"
{

    fields
    {
        field(2; "Employee Code"; Code[20])
        {
        }
        field(3; Month; Integer)
        {
        }
        field(4; Year; Integer)
        {
        }
        field(5; "Mon Line No."; Integer)
        {
        }
        field(6; "Line No."; Integer)
        {
        }
        field(7; "Dimension Code"; Code[20])
        {
            TableRelation = Dimension;
        }
        field(8; "Dimension Value Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Dimension Code"));
        }
    }

    keys
    {
        key(Key1; "Employee Code", Month, Year, "Mon Line No.", "Dimension Code", "Dimension Value Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

