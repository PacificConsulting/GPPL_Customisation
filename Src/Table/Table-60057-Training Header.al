table 60057 "Training Header"
{
    DrillDownPageID = 60088;
    LookupPageID = 60088;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Course Name"; Text[30])
        {
        }
        field(3; "Need  for Training"; Text[30])
        {
        }
        field(4; "Initiating Dept"; Code[20])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
        }
        field(5; "Date of Creation"; Date)
        {
        }
        field(6; "Starting Date"; Date)
        {
        }
        field(7; "Ending Date"; Date)
        {
        }
        field(8; "Training Facility"; Option)
        {
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(9; "Training Premises"; Option)
        {
            OptionCaption = 'Outside Office,Within Office';
            OptionMembers = "Outside Office","Within Office";
        }
        field(10; "Training Type"; Text[30])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('TYPE OF TRAINING'));
        }
        field(11; Agency; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                IF Vendor.GET(Agency) THEN
                    "Agency Name" := Vendor.Name;
            end;
        }
        field(12; "No. of Employees"; Integer)
        {
            CalcFormula = Count("Training Line" WHERE("Training Header No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(13; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(14; "Training Subject"; Code[10])
        {
        }
        field(15; "Agency Name"; Text[60])
        {
        }
        field(16; Status; Option)
        {
            OptionCaption = 'Declared,Started,Closed';
            OptionMembers = Declared,Started,Closed;
        }
        field(17; "Actual Start Date"; Date)
        {
            Editable = false;
        }
        field(18; "Actual Closed Date"; Date)
        {
            Editable = false;
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
        TrainingLine.SETRANGE("Training Header No.", "No.");
        IF TrainingLine.FIND('-') THEN
            TrainingLine.DELETEALL;
    end;

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup.Training);
            //NoSeriesMgt.InitSeries(HRSetup.Training, xRec."No. Series", 0D, "No.", "No. Series");
        END;
        "Date of Creation" := TODAY;
        Status := Status::Declared;
    end;

    var
        HRSetup: Record 60016;
        //NoSeriesMgt: Codeunit 396;
        TrainingLine: Record 60058;
        Vendor: Record 23;

    [Scope('Internal')]
    procedure AssistEdit()
    begin
    end;

    [Scope('Internal')]
    procedure Attachments()
    begin
    end;
}

