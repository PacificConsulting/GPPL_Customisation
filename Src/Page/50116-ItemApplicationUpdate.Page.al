page 50116 "Item Application Update"
{
    PageType = List;
    Permissions = TableData 339 = rimd;
    SourceTable = 339;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Item Ledger Entry No."; rec."Item Ledger Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Inbound Item Entry No."; rec."Inbound Item Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Outbound Item Entry No."; rec."Outbound Item Entry No.")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Transferred-from Entry No."; rec."Transferred-from Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Creation Date"; rec."Creation Date")
                {
                    ApplicationArea = all;
                }
                field("Created By User"; rec."Created By User")
                {
                    ApplicationArea = all;
                }
                field("Last Modified Date"; rec."Last Modified Date")
                {
                    ApplicationArea = all;
                }
                field("Last Modified By User"; rec."Last Modified By User")
                {
                    ApplicationArea = all;
                }
                field("Cost Application"; rec."Cost Application")
                {
                    ApplicationArea = all;
                }
                field("Output Completely Invd. Date"; rec."Output Completely Invd. Date")
                {
                    ApplicationArea = all;
                }
                field("Outbound Entry is Updated"; rec."Outbound Entry is Updated")
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

