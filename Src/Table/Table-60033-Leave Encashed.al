table 60033 "Leave Encashed"
{
    // 13/03/06

    DrillDownPageID = 60026;
    LookupPageID = 60026;

    fields
    {
        field(1; "Leave Code"; Code[20])
        {
            TableRelation = "Leave Master";
        }
        field(2; "Employee Code"; Code[20])
        {
            TableRelation = Employee_;
        }
        field(3; "Leave Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Leave Entitlement"."Leave Bal. at the Month End" WHERE("Employee No." = FIELD("Employee Code"),
                                                                                       "Leave Code" = FIELD("Leave Code"),
                                                                                       Year = FIELD(Year),
                                                                                       Month=FIELD(Month)));
            
        }
        field(4;"Leaves Encashed";Decimal)
        {
        }
        field(5;"Leaves to Encash";Decimal)
        {
        }
        field(6;"Payment Date";Date)
        {
        }
        field(7;"Encash Amount";Decimal)
        {
        }
        field(8;Year;Integer)
        {
        }
        field(9;Month;Integer)
        {
        }
    }

    keys
    {
        key(Key1;"Leave Code","Employee Code",Year,Month)
        {
            Clustered = true;
            SumIndexFields = "Leaves to Encash","Encash Amount";
        }
    }

    fieldgroups
    {
    }
}

