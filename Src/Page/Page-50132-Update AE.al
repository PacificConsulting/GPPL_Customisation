page 50132 "Update AE"
{
    PageType = List;
    Permissions = TableData 50009 = rm;
    SourceTable = 50009;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Approvar ID"; rec."Approvar ID")
                {
                    ApplicationArea = all;
                }
                field("Mandatory ID"; rec."Mandatory ID")
                {
                    ApplicationArea = all;
                }
                field(Approved; rec.Approved)
                {
                    ApplicationArea = all;
                }
                field("Approval Date"; rec."Approval Date")
                {
                    ApplicationArea = all;
                }
                field("Approval Time"; rec."Approval Time")
                {
                    ApplicationArea = all;
                }
                field("User Name"; rec."User Name")
                {
                    ApplicationArea = all;
                }
                field("Approver Name"; rec."Approver Name")
                {
                    ApplicationArea = all;
                }
                field("Version No."; rec."Version No.")
                {
                    ApplicationArea = all;
                }
                field("Date Sent for Approval"; rec."Date Sent for Approval")
                {
                    ApplicationArea = all;
                }
                field("Time Sent for Approval"; rec."Time Sent for Approval")
                {
                    ApplicationArea = all;
                }
                field("Credit Limit Approvar ID"; rec."Credit Limit Approvar ID")
                {
                    ApplicationArea = all;
                }
                field("Credit Limit Approvar Name"; rec."Credit Limit Approvar Name")
                {
                    ApplicationArea = all;
                }
                field("Credit Limit Approval Date"; rec."Credit Limit Approval Date")
                {
                    ApplicationArea = all;
                }
                field("Credit Limit Approval Time"; rec."Credit Limit Approval Time")
                {
                    ApplicationArea = all;
                }
                field("Over Due Approvar ID"; rec."Over Due Approvar ID")
                {
                    ApplicationArea = all;
                }
                field("Over Due Approvar Name"; rec."Over Due Approvar Name")
                {
                    ApplicationArea = all;
                }
                field("Over Due Approval Date"; rec."Over Due Approval Date")
                {
                    ApplicationArea = all;
                }
                field("Over Due Approval Time"; rec."Over Due Approval Time")
                {
                    ApplicationArea = all;
                }
                field("Level2 Approvar ID"; rec."Level2 Approvar ID")
                {
                    ApplicationArea = all;
                }
                field("Level2 Approvar Name"; rec."Level2 Approvar Name")
                {
                    ApplicationArea = all;
                }
                field("Level2 Approvar Date"; rec."Level2 Approvar Date")
                {
                    ApplicationArea = all;
                }
                field("Level2 Approvar Time"; rec."Level2 Approvar Time")
                {
                    ApplicationArea = all;
                }
                field("Sequence No."; rec."Sequence No.")
                {
                    ApplicationArea = all;
                }

                field("Division Code"; rec."Division Code")
                {
                    ApplicationArea = all;
                }
                field(Rejected; rec.Rejected)
                {
                    ApplicationArea = all;
                }
                field("Rejected Date"; rec."Rejected Date")
                {
                    ApplicationArea = all;
                }
                field("Rejected Time"; rec."Rejected Time")
                {
                    ApplicationArea = all;
                }
                field(Cancelled; rec.Cancelled)
                {
                    ApplicationArea = all;
                }
                field("Cancelled Date"; rec."Cancelled Date")
                {
                    ApplicationArea = all;
                }
                field("Cancelled Time"; rec."Cancelled Time")
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

