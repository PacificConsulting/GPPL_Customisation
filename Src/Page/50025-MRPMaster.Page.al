page 50025 "MRP Master"
{
    Editable = true;
    PageType = List;
    SourceTable = 50013;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(MRP; rec.MRP)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("MRP Price"; rec."MRP Price")
                {
                    ApplicationArea = all;
                }
                field("Sales price"; rec."Sales price")
                {
                    ApplicationArea = all;
                }
                field("National Discount"; rec."National Discount")
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

