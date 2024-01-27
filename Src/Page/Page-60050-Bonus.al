page 60050 Bonus
{
    PageType = Card;
    SourceTable = 60052;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Effective Date"; rec."Effective Date")
                {
                    ApplicationArea = all;
                }
                field("Bonus%"; rec."Bonus%")
                {
                    ApplicationArea = all;
                }
                field("Ex-gratia%"; rec."Ex-gratia%")
                {
                    ApplicationArea = all;
                }
                field("Min.Bonus sable Salary"; rec."Min.Bonus sable Salary")
                {
                    ApplicationArea = all;
                    Caption = 'Bonusable Salary';
                }
                field("Bonus Amount"; rec."Bonus Amount")
                {
                    ApplicationArea = all;
                    Caption = 'Bonus Limit';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Bonus")
            {
                Caption = '&Bonus';
                action(List)
                {
                    ApplicationArea = ALL;
                    Caption = 'List';
                    RunObject = Page 60051;
                    ShortCutKey = 'Shift+Ctrl+L';
                }
            }
        }
    }

    var
        RecRef: RecordRef;
}

