page 60085 Investment
{
    PageType = List;
    SourceTable = 60003;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Investment Plan"; rec."Investment Plan")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Section; rec.Section)
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

