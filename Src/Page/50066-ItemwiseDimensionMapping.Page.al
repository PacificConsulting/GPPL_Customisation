page 50066 "Item wise Dimension Mapping"
{
    PageType = List;
    SourceTable = 50007;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Dimension Code"; rec."Dimension Code")
                {
                    ApplicationArea = all;
                }
                field("Dimension Value"; rec."Dimension Value")
                {
                    ApplicationArea = all;
                }
                field("Dimension Name"; rec."Dimension Name")
                {
                    ApplicationArea = all;
                }
                field("Item Code"; rec."Item Code")
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

