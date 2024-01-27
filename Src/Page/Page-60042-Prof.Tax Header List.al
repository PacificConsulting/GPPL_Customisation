page 60042 "Prof.Tax Header List"
{
    Editable = false;
    PageType = List;
    SourceTable = 60044;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Branch Code"; rec."Branch Code")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Effective Date"; rec."Effective Date")
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
            group("&PT")
            {
                Caption = '&PT';
                action(Card)
                {
                    ApplicationArea = ALL;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 60040;
                    RunPageLink = "Branch Code" = FIELD("Branch Code"),
                                  "Effective Date" = FIELD("Effective Date");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }

    var
        RecRef: RecordRef;
}

