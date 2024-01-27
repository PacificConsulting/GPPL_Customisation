table 60042 PF
{
    // 23-Jan-06

    DataCaptionFields = "Effective Date";
    LookupPageID = 60037;

    fields
    {
        field(1; Id; Integer)
        {
        }
        field(2; "Effective Date"; Date)
        {
        }
        field(3; "Employer Contribution"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(4; "Employee Contribution"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(5; "Rounding Amount"; Decimal)
        {
        }
        field(6; "Rounding Method"; Option)
        {
            OptionMembers = Nearest,Up,Down;
        }
        field(7; "EPS %"; Decimal)
        {
        }
        field(8; "Admin Charges %"; Decimal)
        {
        }
        field(9; "EDLI %"; Decimal)
        {
        }
        field(10; "RIFA %"; Decimal)
        {
        }
        field(11; "PF Amount"; Decimal)
        {
        }
        field(12; "Employer EPS Max.Amt Lmt"; Decimal)
        {
        }
        field(13; "No. Series"; Code[20])
        {
        }
        field(14; "Buisness No"; Code[20])
        {
        }
        field(15; "PF Code"; Code[20])
        {
        }
        field(17; "Designation Authorised officer"; Text[30])
        {
        }
        field(18; "Place of Attestation"; Text[30])
        {
        }
        field(19; "Establishment code"; Text[15])
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
        IF PF.FIND('+') THEN
            Id := PF.Id + 1
        ELSE
            Id := 1;
    end;

    var
        PF: Record 60042;
}

