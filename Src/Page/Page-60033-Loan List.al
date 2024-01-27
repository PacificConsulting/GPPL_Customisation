page 60033 "Loan List"
{
    // B2B Software Technologies
    // -----------------------------
    // Project : Human Resource
    // B2B
    // No. sign      Date
    // -----------------------------
    // 01   B2B    14-dec-05

    Editable = false;
    PageType = List;
    SourceTable = 60039;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field(Id; rec.Id)
                {
                    ApplicationArea = all;
                }
                field("Employee Code"; rec."Employee Code")
                {
                    ApplicationArea = all;
                }
                field("Loan Type"; rec."Loan Type")
                {
                    ApplicationArea = all;
                }
                field("Loan Amount"; rec."Loan Amount")
                {
                    ApplicationArea = all;
                }
                field("Effective Amount"; rec."Effective Amount")
                {
                    ApplicationArea = all;
                }
                field("Loan Balance"; rec."Loan Balance")
                {
                    ApplicationArea = all;
                }
                field("No of Installments"; rec."No of Installments")
                {
                    ApplicationArea = all;
                }
                field("Installment Amount"; rec."Installment Amount")
                {
                    ApplicationArea = all;
                }
                field("Loan Posting Group"; rec."Loan Posting Group")
                {
                    ApplicationArea = all;
                }
                field(Closed; rec.Closed)
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
            group("&Loan")
            {
                Caption = '&Loan';
                action(Card)
                {
                    ApplicationArea = ALL;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page 60032;
                    RunPageLink = Id = FIELD(Id);
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}

