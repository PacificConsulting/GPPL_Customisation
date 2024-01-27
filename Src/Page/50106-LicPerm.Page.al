page 50105 "Lic Perm"
{
    PageType = List;
    SourceTable = 2000000043;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Object Type"; rec."Object Type")
                {
                    ApplicationArea = all;
                }
                field("Object Number"; rec."Object Number")
                {
                    ApplicationArea = all;
                }
                field("Read Permission"; rec."Read Permission")
                {
                    ApplicationArea = all;
                }
                field("Insert Permission"; rec."Insert Permission")
                {
                    ApplicationArea = all;
                }
                field("Modify Permission"; rec."Modify Permission")
                {
                    ApplicationArea = all;
                }
                field("Delete Permission"; rec."Delete Permission")
                {
                    ApplicationArea = all;
                }
                field("Execute Permission"; rec."Execute Permission")
                {
                    ApplicationArea = all;
                }
                field("Limited Usage Permission"; rec."Limited Usage Permission")
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

