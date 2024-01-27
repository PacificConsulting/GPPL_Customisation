page 50177 "Value Entry Relation Update"
{
    PageType = List;
    Permissions = TableData 6508 = rimd;
    SourceTable = 6508;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Value Entry No."; rec."Value Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Source RowId"; rec."Source RowId")
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

