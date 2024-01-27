page 60068 "Loan Repayment List"
{
    Editable = false;
    PageType = List;
    SourceTable = 60041;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Payment Date"; rec."Payment Date")
                {
                    ApplicationArea = all;
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

