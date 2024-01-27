page 50156 "Item Parameters"
{
    PageType = List;
    Permissions = TableData 50025 = rim;
    SourceTable = 50025;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Version Code"; rec."Version Code")
                {
                    ApplicationArea = all;
                }
                field(Parameter; rec.Parameter)
                {
                    ApplicationArea = all;
                }
                field("Typical Value"; rec."Typical Value")
                {
                    ApplicationArea = all;
                }
                field("Min Value"; rec."Min Value")
                {
                    ApplicationArea = all;
                }
                field("Max Value"; rec."Max Value")
                {
                    ApplicationArea = all;
                }
                field(Mandatory; rec.Mandatory)
                {
                    ApplicationArea = all;
                }
                field(Result; rec.Result)
                {
                    ApplicationArea = all;
                }
                field("Test Method"; rec."Test Method")
                {
                    ApplicationArea = all;
                }
                field("Blend Order No."; rec."Blend Order No.")
                {
                    ApplicationArea = all;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field("Version Descrption"; rec."Version Descrption")
                {
                    ApplicationArea = all;
                }
                field("Test Result Approved"; rec."Test Result Approved")
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

