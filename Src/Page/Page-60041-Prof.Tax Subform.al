page 60041 "Prof.Tax Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = 60045;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Income From"; rec."Income From")
                {
                    ApplicationArea = ALL;
                }
                field("Income To"; rec."Income To")
                {
                    ApplicationArea = ALL;
                }
                field("Tax Amount"; rec."Tax Amount")
                {
                    ApplicationArea = ALL;
                }
            }
        }
    }

    actions
    {
    }

    var
        RecRef: RecordRef;
}

