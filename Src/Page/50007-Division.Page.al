page 50007 Division
{
    PageType = List;
    SourceTable = 50007;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Dimension Code"; rec."Dimension Code")
                {
                    ApplicationArea = all;
                }
                field("Dimension Value"; rec."Dimension Value")
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

