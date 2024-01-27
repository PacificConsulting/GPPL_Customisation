page 50020 "C & F Commision Setup Line"
{
    AutoSplitKey = true;
    DelayedInsert = false;
    PageType = ListPart;
    SourceTable = 50012;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Commision Code"; rec."Commision Code")
                {
                    ApplicationArea = all;
                }
                field("Sales Volume From"; rec."Sales Volume From")
                {
                    ApplicationArea = all;
                }
                field("Sales Volume To"; rec."Sales Volume To")
                {
                    ApplicationArea = all;
                }
                field("Re - Imbursement"; rec."Re - Imbursement")
                {
                    ApplicationArea = all;
                }
                field("Other Expenses"; rec."Other Expenses")
                {
                    ApplicationArea = all;
                }
                field("Handling Charges"; rec."Handling Charges")
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

