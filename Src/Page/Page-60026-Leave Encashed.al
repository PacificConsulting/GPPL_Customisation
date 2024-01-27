page 60026 "Leave Encashed"
{
    // 13/03/06

    Editable = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = 60033;
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
                field("Leave Code"; rec."Leave Code")
                {
                    ApplicationArea = all;
                }
                field("Leave Balance"; rec."Leave Balance")
                {
                    ApplicationArea = all;
                }
                field("Leaves Encashed"; rec."Leaves Encashed")
                {
                    ApplicationArea = all;
                }
                field("Leaves to Encash"; rec."Leaves to Encash")
                {
                    ApplicationArea = all;
                }
                field("Encash Amount"; rec."Encash Amount")
                {
                    ApplicationArea = all;
                }
                field(Year; rec.Year)
                {
                    ApplicationArea = all;
                }
                field(Month; rec.Month)
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
}

