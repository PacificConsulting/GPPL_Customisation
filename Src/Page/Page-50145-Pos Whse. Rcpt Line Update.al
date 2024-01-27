page 50145 "Pos Whse. Rcpt Line Update"
{
    PageType = List;
    Permissions = TableData 7319 = rim;
    SourceTable = 7319;
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
                field("Line No."; rec."Line No.")
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
                field("Source No."; rec."Source No.")
                {
                    ApplicationArea = all;
                }
                field("Source Line No."; rec."Source Line No.")
                {
                    ApplicationArea = all;
                }
                field("Source Document"; rec."Source Document")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Shelf No."; rec."Shelf No.")
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
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Qty. (Base)"; rec."Qty. (Base)")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Qty. Put Away"; rec."Qty. Put Away")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Qty. Put Away (Base)"; rec."Qty. Put Away (Base)")
                {
                    ApplicationArea = all;
                }
                field("Put-away Qty."; rec."Put-away Qty.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Put-away Qty. (Base)"; rec."Put-away Qty. (Base)")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = all;
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = all;
                }
                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Qty. Cross-Docked"; rec."Qty. Cross-Docked")
                {
                    ApplicationArea = all;
                }
                field("Qty. Cross-Docked (Base)"; rec."Qty. Cross-Docked (Base)")
                {
                    ApplicationArea = all;
                }
                field("Cross-Dock Zone Code"; rec."Cross-Dock Zone Code")
                {
                    ApplicationArea = all;
                }
                field("Cross-Dock Bin Code"; rec."Cross-Dock Bin Code")
                {
                    ApplicationArea = all;
                }
                field("Posted Source Document"; rec."Posted Source Document")
                {
                    ApplicationArea = all;
                }
                field("Posted Source No."; rec."Posted Source No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Vendor Shipment No."; rec."Vendor Shipment No.")
                {
                    ApplicationArea = all;
                }
                field("Whse. Receipt No."; rec."Whse. Receipt No.")
                {
                    ApplicationArea = all;
                }
                field("Whse Receipt Line No."; rec."Whse Receipt Line No.")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Serial No."; rec."Serial No.")
                {
                    ApplicationArea = all;
                }
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = all;
                    AssistEdit = false;
                    Editable = false;
                    //  Image = "<Undefined>";
                }
                field("Warranty Date"; rec."Warranty Date")
                {
                    ApplicationArea = all;
                }
                field("Expiration Date"; rec."Expiration Date")
                {
                    ApplicationArea = all;
                }
                field("QC Applicable"; rec."QC Applicable")
                {
                    ApplicationArea = all;
                }
                field("QC Approved"; rec."QC Approved")
                {
                    ApplicationArea = all;
                }
                field("Gross Weight"; rec."Gross Weight")
                {
                    ApplicationArea = all;
                }
                field("Net Weight of Vehicle"; rec."Net Weight of Vehicle")
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

