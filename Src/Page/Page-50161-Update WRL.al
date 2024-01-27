page 50161 "Update WRL"
{
    PageType = List;
    Permissions = TableData 7317 = rm;
    SourceTable = 7317;
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
                }
                field("Qty. (Base)"; rec."Qty. (Base)")
                {
                    ApplicationArea = all;
                }
                field("Qty. Outstanding"; rec."Qty. Outstanding")
                {
                    ApplicationArea = all;
                }
                field("Qty. Outstanding (Base)"; rec."Qty. Outstanding (Base)")
                {
                    ApplicationArea = all;
                }
                field("Qty. to Receive"; rec."Qty. to Receive")
                {
                    ApplicationArea = all;
                }
                field("Qty. to Receive (Base)"; rec."Qty. to Receive (Base)")
                {
                    ApplicationArea = all;
                }
                field("Qty. Received"; rec."Qty. Received")
                {
                    ApplicationArea = all;
                }
                field("Qty. Received (Base)"; rec."Qty. Received (Base)")
                {
                    ApplicationArea = all;
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
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Sorting Sequence No."; rec."Sorting Sequence No.")
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
                field(Cubage; rec.Cubage)
                {
                    ApplicationArea = all;
                }
                field(Weight; rec.Weight)
                {
                    ApplicationArea = all;
                }
                field("Not upd. by Src. Doc. Post."; rec."Not upd. by Src. Doc. Post.")
                {
                    ApplicationArea = all;
                }
                field("Posting from Whse. Ref."; rec."Posting from Whse. Ref.")
                {
                    ApplicationArea = all;
                }
                field("Qty. to Cross-Dock"; rec."Qty. to Cross-Dock")
                {
                    ApplicationArea = all;
                }
                field("Qty. to Cross-Dock (Base)"; rec."Qty. to Cross-Dock (Base)")
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
                field("QC Applicable"; rec."QC Applicable")
                {
                    ApplicationArea = all;
                }
                field("QC Approved"; rec."QC Approved")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Gross Weight"; rec."Gross Weight")
                {
                    ApplicationArea = all;
                }
                field("Net Weight of Vehicle"; rec."Net Weight of Vehicle")
                {
                    ApplicationArea = all;
                }
                field("Expiry Date"; rec."Expiry Date")
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

