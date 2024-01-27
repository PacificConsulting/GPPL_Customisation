page 50199 "Res. Entry Update"
{
    PageType = List;
    Permissions = TableData 337 = rimd;
    SourceTable = 337;
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
                field("Reservation Status"; rec."Reservation Status")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Creation Date"; rec."Creation Date")
                {
                    ApplicationArea = all;
                }
                field("Transferred from Entry No."; rec."Transferred from Entry No.")
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
                field("Item Ledger Entry No."; rec."Item Ledger Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Expected Receipt Date"; rec."Expected Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = all;
                }
                field("Serial No."; rec."Serial No.")
                {
                    ApplicationArea = all;
                }
                field("Created By"; rec."Created By")
                {
                    ApplicationArea = all;
                }
                field("Changed By"; rec."Changed By")
                {
                    ApplicationArea = all;
                }
                field(Positive; rec.Positive)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Action Message Adjustment"; rec."Action Message Adjustment")
                {
                    ApplicationArea = all;
                }
                field(Binding; rec.Binding)
                {
                    ApplicationArea = all;
                }
                field("Suppressed Action Msg."; rec."Suppressed Action Msg.")
                {
                    ApplicationArea = all;
                }
                field("Planning Flexibility"; rec."Planning Flexibility")
                {
                    ApplicationArea = all;
                }
                field("Appl.-to Item Entry"; rec."Appl.-to Item Entry")
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
                field("Quantity Invoiced (Base)"; rec."Quantity Invoiced (Base)")
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
                field("Disallow Cancellation"; rec."Disallow Cancellation")
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
                field("Appl.-from Item Entry"; rec."Appl.-from Item Entry")
                {
                    ApplicationArea = all;
                }
                field(Correction; rec.Correction)
                {
                    ApplicationArea = all;
                }
                field("New Expiration Date"; rec."New Expiration Date")
                {
                    ApplicationArea = all;
                }
                field("Item Tracking"; rec."Item Tracking")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
    }
}

