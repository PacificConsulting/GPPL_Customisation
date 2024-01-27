page 60036 PF
{
    DataCaptionFields = "Effective Date";
    Editable = true;
    PageType = Card;
    SourceTable = 60042;
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
                field("Employer Contribution"; rec."Employer Contribution")
                {
                    ApplicationArea = all;
                }
                field("EPS %"; rec."EPS %")
                {
                    ApplicationArea = all;
                }
                field("Employee Contribution"; rec."Employee Contribution")
                {
                    ApplicationArea = all;
                }
                field("PF Amount"; rec."PF Amount")
                {
                    ApplicationArea = all;
                }
                field("Admin Charges %"; rec."Admin Charges %")
                {
                    ApplicationArea = all;
                }
                field("EDLI %"; rec."EDLI %")
                {
                    ApplicationArea = all;
                }
                field("RIFA %"; rec."RIFA %")
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
            group("&PF ")
            {
                Caption = '&PF ';
                action(List)
                {
                    ApplicationArea = ALL;
                    Caption = 'List';
                    RunObject = Page 60037;
                    ShortCutKey = 'Shift+Ctrl+L';
                }
            }
        }
    }

    var
        RecRef: RecordRef;
}

