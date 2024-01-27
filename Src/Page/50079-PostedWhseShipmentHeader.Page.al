page 50079 "Posted Whse. Shipment Header"
{
    Editable = true;
    PageType = List;
    Permissions = TableData 7322 = rm;
    SourceTable = 7322;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Assigned User ID"; rec."Assigned User ID")
                {
                    ApplicationArea = all;
                }
                field("Assignment Date"; rec."Assignment Date")
                {
                    ApplicationArea = all;
                }
                field("Assignment Time"; rec."Assignment Time")
                {
                    ApplicationArea = all;
                }
                field("No. Series"; rec."No. Series")
                {
                    ApplicationArea = all;
                }
                field(Comment; rec.Comment)
                {
                    ApplicationArea = all;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    ApplicationArea = all;
                }
                field("Zone Code"; rec."Zone Code")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
                {
                    ApplicationArea = all;
                }
                field("Shipment Method Code"; rec."Shipment Method Code")
                {
                    ApplicationArea = all;
                }
                field("Whse. Shipment No."; rec."Whse. Shipment No.")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field(Approve; rec.Approve)
                {
                    ApplicationArea = all;
                }
                field("Approval User ID"; rec."Approval User ID")
                {
                    ApplicationArea = all;
                }
                field("Created By User ID"; rec."Created By User ID")
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

