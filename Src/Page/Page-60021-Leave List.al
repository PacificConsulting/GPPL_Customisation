page 60021 "Leave List"
{
    // Date: 10-Jan-06

    Editable = false;
    PageType = List;
    SourceTable = 60030;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Leave Code"; rec."Leave Code")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("No. of Leaves in Year"; rec."No. of Leaves in Year")
                {
                    ApplicationArea = all;
                }
                field("Crediting Interval"; rec."Crediting Interval")
                {
                    ApplicationArea = all;
                }
                field("Crediting Type"; rec."Crediting Type")
                {
                    ApplicationArea = all;
                }
                field("Minimum Allowed"; rec."Minimum Allowed")
                {
                    ApplicationArea = all;
                }
                field("Maximum Allowed"; rec."Maximum Allowed")
                {
                    ApplicationArea = all;
                }
                field("Carry Forward"; rec."Carry Forward")
                {
                    ApplicationArea = all;
                }
                field("Applicable Date"; rec."Applicable Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Lea&ve")
            {
                Caption = 'Lea&ve';
                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 60020;
                    RunPageLink = "Leave Code" = FIELD("Leave Code");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }

    var
        RecRef: RecordRef;
}

