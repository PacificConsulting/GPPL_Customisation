page 60031 "Processed Salary List"
{
    Editable = false;
    PageType = List;
    SourceTable = 60038;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Employee Code"; rec."Employee Code")
                {
                    ApplicationArea = all;
                }
                field("Add/Deduct Code"; rec."Add/Deduct Code")
                {
                    ApplicationArea = all;
                }
                field(Year; rec.Year)
                {
                    ApplicationArea = all;
                }
                field("Pay Slip Month"; rec."Pay Slip Month")
                {
                    ApplicationArea = all;
                    Caption = 'Month';
                }
                field(Days; rec.Days)
                {
                    ApplicationArea = all;
                }
                field(Attendance; rec.Attendance)
                {
                    ApplicationArea = all;
                }
                field("Add/Deduct"; rec."Add/Deduct")
                {
                    ApplicationArea = all;
                }
                field("Computation Type"; rec."Computation Type")
                {
                    ApplicationArea = all;
                }
                field("Earned Amount"; rec."Earned Amount")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        RecRef: RecordRef;
        ID: Integer;
}

