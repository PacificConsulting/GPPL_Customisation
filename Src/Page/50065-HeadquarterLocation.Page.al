page 50065 "Headquarter Location"
{
    PageType = List;
    SourceTable = 50038;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(conrol01)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Name; rec.Name)
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

