table 60058 "Training Line"
{
    // Date: 04-Jan-06


    fields
    {
        field(1; "Training Header No."; Code[20])
        {
        }
        field(2; "Training Line No."; Integer)
        {
        }
        field(3; "Employee No."; Code[20])
        {
            TableRelation = Employee_."No.";


            trigger OnValidate()
            begin
                TrainingLine.SETRANGE("Training Header No.", "Training Header No.");
                IF TrainingLine.FIND('-') THEN BEGIN
                    REPEAT
                        IF "Employee No." = TrainingLine."Employee No." THEN
                            ERROR('Employee already exixts');
                    UNTIL TrainingLine.NEXT = 0;
                END;

                Employee.SETRANGE("No.", "Employee No.");
                IF Employee.FIND('-') THEN BEGIN
                    "First Name" := Employee."First Name";
                    "Middle Name" := Employee."Middle Name";
                    Surname := Employee.Initials;
                    //"Department Code" := Employee."Department Code";
                    //Designation := Employee.Designation;
                END;
            end;
        }
        field(4; "First Name"; Text[30])
        {
        }
        field(5; "Employee Remarks"; Text[30])
        {
        }
        field(6; "Middle Name"; Text[30])
        {
        }
        field(7; Surname; Text[30])
        {
        }
        field(8; "Department Code"; Code[20])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
        }
        field(9; Designation; Code[50])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('DESIGNATIONS'));
            //ValidateTableRelation = false;

        }
        field(10; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Training Header No.", "Training Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record Employee;//60019;
        TrainingLine: Record 60058;

    [Scope('Internal')]
    procedure Attachments()
    var
        Attachment: Record 60000;
    begin
        /*Attachment.RESET;
        Attachment.SETRANGE("Year Start Date",DATABASE::"Off Day");
        Attachment.SETRANGE("Total Salary In the Year","Employee No.");
        FORM.RUNMODAL(FORM::"Lookup Types",Attachment);*/

    end;
}

