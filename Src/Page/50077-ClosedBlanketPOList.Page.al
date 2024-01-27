page 50077 "Closed Blanket PO List"
{
    // 
    // 17Jun2017 :: RB-N, New Page Creation CAS-17040-F7X6X8

    CardPageID = "Closed Blanket Purchase Order";
    PageType = List;
    SourceTable = 38;
    SourceTableView = WHERE("Document Type" = FILTER("Blanket Order"),
                            Closed = FILTER(true));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = all;
                }
                field("Order Creation Date"; Rec."Order Creation Date")
                {
                    ApplicationArea = all;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = all;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
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

