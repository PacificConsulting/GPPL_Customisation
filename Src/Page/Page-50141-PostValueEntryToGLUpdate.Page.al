page 50141 "Post Value Entry To G/L Update"
{
    PageType = List;
    Permissions = TableData 5811 = rimd;
    SourceTable = 5811;
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
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
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

