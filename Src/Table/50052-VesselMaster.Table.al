table 50052 "Vessel Master"
{
    Caption = 'Vessel Master';
    LookupPageID = 50125;

    fields
    {
        field(1; "Vessel Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; "Vessel Name"; Text[50])
        {
        }
        field(3; "IMO No."; Code[20])
        {
            Description = '09May2018 RB-N';
        }
    }

    keys
    {
        key(Key1; "Vessel Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Vessel Code", "Vessel Name", "IMO No.")
        {
        }
    }

    trigger OnRename()
    begin
        ERROR(Text001, TABLECAPTION);
    end;

    var
        Text001: Label 'You cannot rename a %1.';
}

