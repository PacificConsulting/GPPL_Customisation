table 50046 Transporter
{
    DrillDownPageID = 50198;
    LookupPageID = 50198;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "GSTIN No."; Code[15])
        {

            trigger OnValidate()
            begin
                IF STRLEN("GSTIN No.") <> 15 THEN
                    ERROR('Length of GSTIN should be 15');
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

