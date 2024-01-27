table 60008 "Emp. TDS Setup"
{

    fields
    {
        field(1; "Employee Code"; Code[10])
        {
            TableRelation = Employee_;

            trigger OnValidate()
            begin
                Emp.GET("Employee Code");
                IF "Employee Code" <> '' THEN
                    "Employee Name" := Emp."First Name"
                ELSE
                    "Employee Name" := '';
            end;
        }
        field(2; "Employee Name"; Text[30])
        {
            Editable = false;
        }
        field(3; Month; Integer)
        {
        }
        field(4; Year; Integer)
        {
        }
        field(6; "TDS Amount"; Decimal)
        {
        }
        field(7; Processed; Boolean)
        {
            Editable = false;
        }
        field(8; Posted; Boolean)
        {
            Editable = false;
        }
        field(9; "Surcharge Amount"; Decimal)
        {
        }
        field(10; "e-Cess Amount"; Decimal)
        {
        }
        field(11; "SHE Cess Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", Month, Year)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TESTFIELD("TDS Amount");
    end;

    trigger OnModify()
    begin
        IF Posted THEN
            ERROR(Text001);
    end;

    var
        Emp: Record 60019;
        Text001: Label 'Posted Records Should not be Modified.....';
}

