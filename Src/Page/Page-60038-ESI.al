page 60038 ESI
{
    Editable = true;
    PageType = Card;
    SourceTable = 60043;
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
                field("Employer %"; rec."Employer %")
                {
                    ApplicationArea = all;
                }
                field("Employee %"; rec."Employee %")
                {
                    ApplicationArea = all;
                }
                field("ESI Salary Amount"; rec."ESI Salary Amount")
                {
                    ApplicationArea = all;
                }
                field("Rounding Amount"; rec."Rounding Amount")
                {
                    ApplicationArea = all;
                }
                field("Rounding Method"; rec."Rounding Method")
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
            group("&ESI")
            {
                Caption = '&ESI';
                action("&List")
                {
                    ApplicationArea = ALL;
                    Caption = '&List';
                    RunObject = Page 60039;
                    ShortCutKey = 'Shift+Ctrl+L';
                }
            }
        }
    }

    var
        RecRef: RecordRef;
}

