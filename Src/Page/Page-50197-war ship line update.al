page 50197 "war ship line update"
{
    PageType = List;
    Permissions = TableData 7321 = rim;
    SourceTable = 7321;
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
                field("Qty. to Ship"; rec."Qty. to Ship")
                {
                    ApplicationArea = all;
                }
                field("Qty. to Ship (Base)"; rec."Qty. to Ship (Base)")
                {
                    ApplicationArea = all;
                }
                field("Qty. Picked"; rec."Qty. Picked")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Qty. Picked (Base)"; rec."Qty. Picked (Base)")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Qty. Shipped"; rec."Qty. Shipped")
                {
                    ApplicationArea = all;
                }
                field("Qty. Shipped (Base)"; rec."Qty. Shipped (Base)")
                {
                    ApplicationArea = all;
                }
                field("Pick Qty."; rec."Pick Qty.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Pick Qty. (Base)"; rec."Pick Qty. (Base)")
                {
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
                field("Destination Type"; rec."Destination Type")
                {
                    ApplicationArea = all;
                }
                field("Destination No."; rec."Destination No.")
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
                field("Shipping Advice"; rec."Shipping Advice")
                {
                    ApplicationArea = all;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = all;
                }
                field("Completely Picked"; rec."Completely Picked")
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
                field("Assemble to Order"; rec."Assemble to Order")
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

