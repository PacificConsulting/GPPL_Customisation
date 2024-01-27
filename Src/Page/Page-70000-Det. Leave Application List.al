page 70000 "Det. Leave Application List"
{
    Editable = false;
    PageType = List;
    SourceTable = 60001;
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
                field(Date; rec.Date)
                {
                    ApplicationArea = all;
                }
                field("Leave Code"; rec."Leave Code")
                {
                    ApplicationArea = all;
                }
                field(Applied; rec.Applied)
                {
                    ApplicationArea = all;
                }
                field(Approved; rec.Approved)
                {
                    ApplicationArea = all;
                }
                field(Reject; rec.Reject)
                {
                    ApplicationArea = all;
                }
                field("Leave Duration"; rec."Leave Duration")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

