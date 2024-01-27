page 50036 "Co-Ordinator User Mapping"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = 50027;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Entry No"; rec."Entry No")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Login Date Time"; rec."Login Date Time")
                {
                    ApplicationArea = all;
                }
                field("Logout Date Time"; rec."Logout Date Time")
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

