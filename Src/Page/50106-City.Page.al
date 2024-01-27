page 50106 City
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = 50005;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("doc no"; rec."doc no")
                {
                    ApplicationArea = all;
                }
                field("Posting date"; rec."Posting date")
                {
                    ApplicationArea = all;
                }
                field("Form No."; rec."Form No.")
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

