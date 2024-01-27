page 50178 "Whs. Item Tracking Line Update"
{
    PageType = List;
    Permissions = TableData 6550 = rim;
    SourceTable = 6550;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Quantity (Base)"; rec."Quantity (Base)")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Source Type"; rec."Source Type")
                {
                    ApplicationArea = all;
                }
                field("Source Subtype"; rec."Source Subtype")
                {
                    ApplicationArea = all;
                }
                field("Source ID"; rec."Source ID")
                {
                    ApplicationArea = all;
                }
                field("Source Batch Name"; rec."Source Batch Name")
                {
                    ApplicationArea = all;
                }
                field("Source Prod. Order Line"; rec."Source Prod. Order Line")
                {
                    ApplicationArea = all;
                }
                field("Source Ref. No."; rec."Source Ref. No.")
                {
                    ApplicationArea = all;
                }
                field("Serial No."; rec."Serial No.")
                {
                    ApplicationArea = all;
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("Warranty Date"; rec."Warranty Date")
                {
                    ApplicationArea = all;
                }
                field("Expiration Date"; rec."Expiration Date")
                {
                    ApplicationArea = all;
                }
                field("Qty. to Handle (Base)"; rec."Qty. to Handle (Base)")
                {
                    ApplicationArea = all;
                }
                field("Qty. to Invoice (Base)"; rec."Qty. to Invoice (Base)")
                {
                    ApplicationArea = all;
                }
                field("Quantity Handled (Base)"; rec."Quantity Handled (Base)")
                {
                    ApplicationArea = all;
                }
                field("Quantity Invoiced (Base)"; rec."Quantity Invoiced (Base)")
                {
                    ApplicationArea = all;
                }
                field("Qty. to Handle"; rec."Qty. to Handle")
                {
                    ApplicationArea = all;
                }
                field("Buffer Status"; rec."Buffer Status")
                {
                    ApplicationArea = all;
                }
                field("Buffer Status2"; rec."Buffer Status2")
                {
                    ApplicationArea = all;
                }
                field("New Serial No."; rec."New Serial No.")
                {
                    ApplicationArea = all;
                }
                field("New Lot No."; rec."New Lot No.")
                {
                    ApplicationArea = all;
                }
                field("Source Type Filter"; rec."Source Type Filter")
                {
                    ApplicationArea = all;
                }
                field("Qty. Registered (Base)"; rec."Qty. Registered (Base)")
                {
                    ApplicationArea = all;
                }
                field("Put-away Qty. (Base)"; rec."Put-away Qty. (Base)")
                {
                    ApplicationArea = all;
                }
                field("Pick Qty. (Base)"; rec."Pick Qty. (Base)")
                {
                    ApplicationArea = all;
                }
                field("Created by Whse. Activity Line"; rec."Created by Whse. Activity Line")
                {
                    ApplicationArea = all;
                }
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = all;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                }
                field("New Expiration Date"; rec."New Expiration Date")
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

