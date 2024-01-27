table 50041 "Sub Expenditure"
{
    DrillDownPageID = 50084;
    LookupPageID = 50084;

    fields
    {
        field(1; "Code"; Integer)
        {
            BlankZero = true;
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Created Date"; Date)
        {
            Editable = false;
        }
        field(4; "Created Time"; Time)
        {
            Editable = false;
        }
        field(5; "Created By"; Text[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        "Created Date" := TODAY;
        "Created Time" := TIME;
        "Created By" := USERID;
    end;
}

