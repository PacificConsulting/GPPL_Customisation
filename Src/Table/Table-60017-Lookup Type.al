table 60017 "Lookup Type"
{
    // B2B Software Technologies
    // ----------------------------------------------------------------------------------------------------------------------------
    // Project : Human Resource
    // B2B
    // No. sign      Date
    // -----------------------------------------------------------------------------------------------------------------------------
    // 01   B2B    13-dec-05
    // -- --------------------------------------------------------------------------------------------------------------------------
    // Description: We get Different LookupTypes this is used to identify the various
    //              lookup names from the LookupName Table
    // 
    // ----------------------------------------------------------------------------------------------------------------------------

    Caption = 'Lookup Type';
    DrillDownPageID = 60001;
    LookupPageID = 60001;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No';
            Description = 'No';
        }
        field(2; Name; Code[50])
        {
            Caption = 'Name';
            Description = 'Name';
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            Description = 'User Free text';
        }
        field(5; "System Defined"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF "System Defined" THEN
            ERROR(Text000);
    end;

    trigger OnInsert()
    begin
        IF LookupType.FIND('+') THEN
            "No." := LookupType."No." + 1
        ELSE
            "No." := 1;
    end;

    trigger OnModify()
    begin
        IF "System Defined" THEN
            ERROR(Text000);
    end;

    trigger OnRename()
    begin
        IF "System Defined" THEN
            ERROR(Text000);
    end;

    var
        LookupType: Record 60017;
        Text000: Label 'You cannot modify or delete the system defined records.';
}

