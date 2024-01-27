table 50007 "Item wise Dimension Mapping"
{
    DrillDownPageID = 50066;
    LookupPageID = 50066;

    fields
    {
        field(1; "Dimension Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(2; "Dimension Value"; Text[30])
        {
            NotBlank = true;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Dimension Code"));
        }
        field(3; "Item Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Item;
        }
        field(50000; "Dimension Name"; Text[100])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Dimension Value")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Dimension Code", "Dimension Value", "Item Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Name; "Dimension Code", "Dimension Name", "Dimension Value")
        {
        }
    }
}

