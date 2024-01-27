page 50162 "MRP Master Update"
{
    PageType = List;
    Permissions = TableData 50013 = rm;
    SourceTable = 50013;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field(MRP; rec.MRP)
                {
                    ApplicationArea = all;
                }
                field("MRP Price"; rec."MRP Price")
                {
                    ApplicationArea = all;
                }
                field("Stock Transfer Price"; rec."Stock Transfer Price")
                {
                    ApplicationArea = all;
                }
                field("Unit Of Measure"; rec."Unit Of Measure")
                {
                    ApplicationArea = all;
                }
                field("Sales price"; rec."Sales price")
                {
                    ApplicationArea = all;
                }
                field("Assessable Value"; rec."Assessable Value")
                {
                    ApplicationArea = all;
                }
                field("Applicable Date"; rec."Applicable Date")
                {
                    ApplicationArea = all;
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("National Discount"; rec."National Discount")
                {
                    ApplicationArea = all;
                }
                field("Price Support"; rec."Price Support")
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

