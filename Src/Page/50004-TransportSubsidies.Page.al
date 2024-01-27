page 50004 "Transport Subsidies"
{
    PageType = List;
    SourceTable = 50003;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control001)
            {
                field("Minimum Distance"; rec."Minimum Distance")
                {
                    ApplicationArea = all;
                }
                field("Maximum Distance"; rec."Maximum Distance")
                {
                    ApplicationArea = all;
                }
                field("Minimum Quantity"; rec."Minimum Quantity")
                {
                    ApplicationArea = all;
                }
                field("Maximum Quantity"; rec."Maximum Quantity")
                {
                    ApplicationArea = all;
                }
                field("Transport Subsidy"; rec."Transport Subsidy")
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

