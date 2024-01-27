table 50005 "Form Update sales Invoice"
{

    fields
    {
        field(1; "doc no"; Code[30])
        {
        }
        field(2; "Posting date"; Date)
        {
        }
        field(3; "Form No."; Code[30])
        {
        }
        field(4; "C Form Amount"; Decimal)
        {
        }
        field(5; "C Form Date"; Date)
        {
        }
        field(6; "C Form Received Date"; Date)
        {
        }
        field(7; "Period From"; Date)
        {
        }
        field(8; "Period To"; Date)
        {
        }
        field(9; "DN/CN No."; Code[20])
        {
        }
        field(10; "DN/CN Type"; Text[50])
        {
        }
        field(11; "Diff. Reason"; Text[100])
        {
        }
        field(12; "Diff.Amount"; Decimal)
        {
        }
        field(13; Update; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "doc no")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

