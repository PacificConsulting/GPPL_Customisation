table 60043 ESI
{
    // 23-Jan-06

    LookupPageID = 60039;

    fields
    {
        field(1; Id; Integer)
        {
        }
        field(2; "Effective Date"; Date)
        {
        }
        field(3; "Employer %"; Decimal)
        {
        }
        field(4; "Employee %"; Decimal)
        {
        }
        field(5; "Rounding Amount"; Decimal)
        {
        }
        field(6; "Rounding Method"; Option)
        {
            OptionMembers = Nearest,Up,Down;
        }
        field(7; "ESI Salary Amount"; Decimal)
        {
        }
        field(8; "No. Series"; Code[20])
        {
        }
        field(9; "Employee Code No"; Code[30])
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
        IF ESI.FIND('+') THEN
            Id := ESI.Id + 1
        ELSE
            Id := 1;
    end;

    var
        ESI: Record 60043;
}

