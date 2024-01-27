page 60009 "Off days"
{
    // Date: 06-Jan-06

    DelayedInsert = true;
    PageType = List;
    SourceTable = 60006;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Day; Rec.Day)
                {
                    ApplicationArea = all;
                }
                field("Weekly Off"; Rec."Weekly Off")
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
    }

    var
        RecRef: RecordRef;
}

