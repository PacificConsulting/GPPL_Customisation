table 60052 Bonus
{
    DrillDownPageID = 60051;
    LookupPageID = 60051;

    fields
    {
        field(1; Id; Integer)
        {
        }
        field(2; "Effective Date"; Date)
        {
        }
        field(3; "Bonus%"; Decimal)
        {
        }
        field(4; "Ex-gratia%"; Decimal)
        {
        }
        field(5; "Min.Bonus sable Salary"; Decimal)
        {
        }
        field(6; "Bonus Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF Bonus.FIND('+') THEN
            Id := Bonus.Id + 1
        ELSE
            Id := 1;
    end;

    var
        Bonus: Record 60052;
}

