page 50045 "CSO Mapping"
{
    PageType = List;
    SourceTable = 50006;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field("User Id"; rec."User Id")
                {
                    ApplicationArea = all;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                }
                field(Value; rec.Value)
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

