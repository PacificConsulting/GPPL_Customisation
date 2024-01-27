page 50124 "Port List"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = 50051;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field("Port Description"; rec."Port Description")
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

