table 60060 "Interview Line"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Interview Type"; Code[20])
        {
            Editable = true;
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('INTERVIEW TYPES'));
        }
        field(4; "Candidate Name"; Text[50])
        {
            TableRelation = Interviewee;
        }
        field(5; "Interview Date"; Date)
        {

            trigger OnValidate()
            begin
                InterviewHeader.RESET;
                InterviewHeader.SETRANGE("Document No.", "Document No.");
                IF InterviewHeader.FINDFIRST THEN BEGIN
                    IF InterviewHeader."Interview Call Date" <> 0D THEN
                        IF InterviewHeader."Interview Call Date" > "Interview Date" THEN
                            ERROR('Interview Date cannot be prior to Interview Call Date');
                    IF InterviewHeader."Starting Date" <> 0D THEN
                        IF InterviewHeader."Starting Date" > "Interview Date" THEN
                            ERROR('Interview Date cannot be prior to Starting Date');
                    IF InterviewHeader."Ending Date" <> 0D THEN
                        IF InterviewHeader."Ending Date" < "Interview Date" THEN
                            ERROR('Ending Date cannot be prior to Interview Date');

                END;
            end;
        }
        field(6; Remarks; Text[80])
        {
        }
        field(7; "Candidate No."; Code[10])
        {
            TableRelation = IF (Finish = CONST(false)) Interviewee."No." WHERE("Converted To Employee" = CONST(false))
            ELSE
            IF (Finish = CONST(true)) Interviewee."No.";

            trigger OnValidate()
            begin
                IF Interviewee.GET("Candidate No.") THEN
                    "Candidate Name" := Interviewee."First Name";
            end;
        }
        field(8; Finish; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Interviewee: Record 60061;
        InterviewHeader: Record 60059;
}

