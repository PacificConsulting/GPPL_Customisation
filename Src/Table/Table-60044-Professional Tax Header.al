table 60044 "Professional Tax Header"
{
    DataCaptionFields = "Branch Code";
    DrillDownPageID = 60042;
    LookupPageID = 60042;

    fields
    {
        field(1; "Branch Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Effective Date"; Date)
        {

            trigger OnValidate()
            var
                ProfLine: Record 60045;
            begin
            end;
        }
    }

    keys
    {
        key(Key1; "Branch Code", "Effective Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ProfLine: Record 60045;
    begin
        ProfLine.RESET;
        ProfLine.SETRANGE("Branch Code", "Branch Code");
        ProfLine.SETRANGE("Effective Date", "Effective Date");
        IF ProfLine.FIND('-') THEN
            ProfLine.DELETEALL;
    end;
}

