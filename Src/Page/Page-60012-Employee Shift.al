page 60012 "Employee Shift"
{
    PageType = List;
    SourceTable = 60023;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = all;
                }
                field("Shift Code"; Rec."Shift Code")
                {
                    ApplicationArea = all;
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
                action("Modify &Attendance")
                {
                    Caption = 'Modify &Attendance';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        Rec.UpdateShiftTimings;
                        MESSAGE('Attendance has been updated successfully');   //EBT paramita
                    end;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Rec.UpdateShiftTimings;
    end;

    var
        RecRef: RecordRef;
        ID: Integer;
}

