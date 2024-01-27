page 50000 "QC Master List"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = 50000;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control001)
            {
                field("Inventory Posting Group"; rec."Inventory Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Parameter Code"; rec."Parameter Code")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Test Methods"; rec."Test Methods")
                {
                    ApplicationArea = all;
                }
                field("Typical Value"; rec."Typical Value")
                {
                    ApplicationArea = all;
                }
                field("Specifications Minimum"; rec."Specifications Minimum")
                {
                    ApplicationArea = all;
                }
                field("Specifications Maximum"; rec."Specifications Maximum")
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

