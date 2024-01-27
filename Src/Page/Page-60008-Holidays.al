page 60008 Holidays
{
    // Date: 06-Jan-06

    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = 60021;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Operation Type"; Rec."Operation Type")
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
            action("Update &Attendance")
            {
                Caption = 'Update &Attendance';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    rec.UpdateAttendance;
                end;
            }
        }
    }

    var
        RecRef: RecordRef;
}

