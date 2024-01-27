table 59991 "GL Balance Upload"
{

    fields
    {
        field(1; "Posting Date"; Date)
        {
        }
        field(2; "Document No."; Code[20])
        {
        }
        field(3; "Document Date"; Date)
        {
        }
        field(4; "Account Type"; Code[20])
        {
        }
        field(5; "Account No."; Code[15])
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "Diem 1"; Code[10])
        {
        }
        field(8; "Diem 2"; Code[10])
        {
        }
        field(9; "Dimension Code"; Code[20])
        {
        }
        field(10; "Diemsion Value"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Account No.", "Diemsion Value")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

