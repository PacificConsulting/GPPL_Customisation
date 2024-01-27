page 60092 "Interview List"
{
    Editable = false;
    PageType = List;
    SourceTable = 60059;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Interview Call Date"; rec."Interview Call Date")
                {
                    ApplicationArea = all;
                }
                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Ending Date"; rec."Ending Date")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("No. Series"; rec."No. Series")
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

