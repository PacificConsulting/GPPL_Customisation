page 60034 "Loan Details"
{
    Editable = false;
    PageType = List;
    SourceTable = 60040;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Pay Date"; rec."Pay Date")
                {
                    ApplicationArea = all;
                }
                field("Loan Amount"; rec."Loan Amount")
                {
                    ApplicationArea = all;
                }
                field(Interest; rec.Interest)
                {
                    ApplicationArea = all;
                }
                field(Principal; rec.Principal)
                {
                    ApplicationArea = all;

                }
                field("EMI Amount"; rec."EMI Amount")
                {
                    ApplicationArea = all;
                }
                field("EMI Deducted"; rec."EMI Deducted")
                {
                    ApplicationArea = all;
                }
                field("Lump Sum Payment"; rec."Lump Sum Payment")
                {
                    ApplicationArea = all;
                }
                field(Balance; rec.Balance)
                {
                    ApplicationArea = all;
                }
                field("Paid Month"; rec."Paid Month")
                {
                    ApplicationArea = all;
                }
                field("Paid Year"; rec."Paid Year")
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

