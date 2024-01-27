page 60070 "Leave Sanc. Incharge"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = 60011;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Sanctioning Incharge"; rec."Sanctioning Incharge")
                {
                    ApplicationArea = all;
                }
                field(Hierarchy; rec.Hierarchy)
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

