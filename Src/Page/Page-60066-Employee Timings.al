page 60066 "Employee Timings"
{
    PageType = List;
    SourceTable = 60013;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field(Date; rec.Date)
                {
                    ApplicationArea = all;
                }
                field("Time In"; rec."Time In")
                {
                    ApplicationArea = all;
                }
                field("Time Out"; rec."Time Out")
                {
                    ApplicationArea = all;
                }
                field("No.of Hours"; rec."No.of Hours")
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

