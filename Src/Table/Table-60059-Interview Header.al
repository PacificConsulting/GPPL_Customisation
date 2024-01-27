table 60059 "Interview Header"
{
    DrillDownPageID = 60092;
    LookupPageID = 60092;

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; Description; Text[60])
        {
        }
        field(3; "Description 2"; Text[60])
        {
        }
        field(4; "Interview Call Date"; Date)
        {
        }
        field(5; "Starting Date"; Date)
        {
        }
        field(6; "Ending Date"; Date)
        {
        }
        field(7; "User ID"; Code[10])
        {
        }
        field(8; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(9; Status; Option)
        {
            OptionCaption = 'Running,Finished';
            OptionMembers = Running,Finished;
        }
        field(10; "Finished Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        InterviewLine.RESET;
        InterviewLine.SETRANGE("Document No.", "Document No.");
        IF InterviewLine.FINDSET THEN
            InterviewLine.DELETEALL;
    end;

    trigger OnInsert()
    begin
        IF "Document No." = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup."Interview No.");
            //NoSeriesMgt.InitSeries(HRSetup."Interview No.", xRec."No. Series", 0D, "Document No.", "No. Series");
        END;

        "User ID" := USERID;
    end;

    var
        InterviewLine: Record 60060;
        HRSetup: Record 60016;
        //NoSeriesMgt: Codeunit 396;
        InterviewHeader: Record 60059;


    procedure AssistEdit(OldIntHeader: Record 60059): Boolean
    begin
        /*
        WITH InterviewHeader DO BEGIN
            InterviewHeader := Rec;
            HRSetup.GET;
            HRSetup.TESTFIELD("Interview No.");
            IF NoSeriesMgt.SelectSeries(HRSetup."Employee No.", OldIntHeader."No. Series", "No. Series") THEN BEGIN
                HRSetup.GET;
                HRSetup.TESTFIELD("Interview No.");
                NoSeriesMgt.SetSeries("Document No.");
                Rec := InterviewHeader;
                EXIT(TRUE);
            END;
        END;
        */
    end;
}

