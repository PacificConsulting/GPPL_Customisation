page 50001 "QC Item Parameters"
{
    Caption = 'QC Item Parameters -  RM';
    PageType = List;
    SourceTable = 50001;
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(control001)
            {
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Parameter Code"; rec."Parameter Code")
                {
                    ApplicationArea = all;
                }
                field("Inventory Posting Group"; rec."Inventory Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Test Method"; rec."Test Method")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Typical value"; rec."Typical value")
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
            }
        }
    }

    actions
    {
    }
}

