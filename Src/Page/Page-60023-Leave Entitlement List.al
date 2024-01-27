page 60023 "Leave Entitlement List"
{
    // Date: 10-Jan-06

    Editable = true;
    PageType = List;
    SourceTable = 60031;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Employee No."; rec."Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Leave Code"; rec."Leave Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Month; rec.Month)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Leave Avail. at the Month"; rec."Leave Avail. at the Month")
                {
                    ApplicationArea = all;
                }
                field(Year; rec.Year)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Leaves taken during Month"; rec."Leaves taken during Month")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Late Hours Deduction Days"; rec."Late Hours Deduction Days")
                {
                    ApplicationArea = all;
                }
                field("Leave Bal. at the Month End"; rec."Leave Bal. at the Month End")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
    }
}

