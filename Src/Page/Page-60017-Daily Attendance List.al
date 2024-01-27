page 60017 "Daily Attendance List"
{
    Editable = true;
    PageType = List;
    SourceTable = 60028;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Apply; Rec.Apply)
                {
                    ApplicationArea = all;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Attendance Type"; Rec."Attendance Type")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("OT Approved Hrs"; Rec."OT Approved Hrs")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Non-Working"; Rec."Non-Working")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Cancel Leave")
                {
                    Caption = 'Cancel Leave';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        Cancel: Boolean;
                    begin
                        //VE-026>>
                        Cancel := CONFIRM(Text002);
                        IF Cancel THEN
                            rec.SETRANGE(Apply, TRUE);
                        IF rec.FIND('-') THEN
                            REPEAT
                                Rec."Attendance Type" := Rec."Attendance Type"::Present;
                                Rec."Leave Code" := '';
                                Rec.MODIFY;
                            UNTIL rec.NEXT = 0;
                        //VE-026<<
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DateOnFormat;
    end;

    var
        Text002: Label 'Are You Sure To Cancel Leave For EmployeeNo %1';

    local procedure DateOnFormat()
    begin
        IF rec."Non-Working" THEN;
    end;
}

