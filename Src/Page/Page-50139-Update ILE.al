page 50139 "Update ILE"
{
    PageType = List;
    Permissions = TableData 32 = rm;
    SourceTable = 32;
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
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Source No."; rec."Source No.")
                {
                    ApplicationArea = all;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Remaining Quantity"; rec."Remaining Quantity")
                {
                    ApplicationArea = all;
                }
                field("Invoiced Quantity"; rec."Invoiced Quantity")
                {
                    ApplicationArea = all;
                }
                field("Applies-to Entry"; rec."Applies-to Entry")
                {
                    ApplicationArea = all;
                }
                field(Open; rec.Open)
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field(Positive; rec.Positive)
                {
                    ApplicationArea = all;
                }
                field("Source Type"; rec."Source Type")
                {
                    ApplicationArea = all;
                }
                field("Drop Shipment"; rec."Drop Shipment")
                {
                    ApplicationArea = all;
                }
                field("Transaction Type"; rec."Transaction Type")
                {
                    ApplicationArea = all;
                }
                field("Transport Method"; rec."Transport Method")
                {
                    ApplicationArea = all;
                }
                field("Country/Region Code"; rec."Country/Region Code")
                {
                    ApplicationArea = all;
                }
                field("Entry/Exit Point"; rec."Entry/Exit Point")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field(Area1; rec.Area)
                {
                    ApplicationArea = all;
                }
                field("Transaction Specification"; rec."Transaction Specification")
                {
                    ApplicationArea = all;
                }
                field("No. Series"; rec."No. Series")
                {
                    ApplicationArea = all;
                }
                field("Reserved Quantity"; rec."Reserved Quantity")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document Line No."; rec."Document Line No.")
                {
                    ApplicationArea = all;
                }
                field("Order Type"; rec."Order Type")
                {
                    ApplicationArea = all;
                }
                field("Order No."; rec."Order No.")
                {
                    ApplicationArea = all;
                }
                field("Order Line No."; rec."Order Line No.")
                {
                    ApplicationArea = all;
                }
                field("Dimension Set ID"; rec."Dimension Set ID")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Assemble to Order"; rec."Assemble to Order")
                {
                    ApplicationArea = all;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                }
                field("Job Task No."; rec."Job Task No.")
                {
                    ApplicationArea = all;
                }
                field("Job Purchase"; rec."Job Purchase")
                {
                    ApplicationArea = all;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Derived from Blanket Order"; rec."Derived from Blanket Order")
                {
                    ApplicationArea = all;
                }
                // field("Cross-Reference No."; rec."Cross-Reference No.")
                // {
                //     ApplicationArea = all;
                // }
                field("Originally Ordered No."; rec."Originally Ordered No.")
                {
                    ApplicationArea = all;
                }
                field("Originally Ordered Var. Code"; rec."Originally Ordered Var. Code")
                {
                    ApplicationArea = all;
                }
                field("Out-of-Stock Substitution"; rec."Out-of-Stock Substitution")
                {
                    ApplicationArea = all;
                }
                field("Item Category Code"; rec."Item Category Code")
                {
                    ApplicationArea = all;
                }
                field(Nonstock; rec.Nonstock)
                {
                    ApplicationArea = all;
                }
                field("Purchasing Code"; rec."Purchasing Code")
                {
                    ApplicationArea = all;
                }
                // field("Product Group Code"; rec."Product Group Code")
                // {
                //     ApplicationArea = all;
                // }
                field("Completely Invoiced"; rec."Completely Invoiced")
                {
                    ApplicationArea = all;
                }
                field("Last Invoice Date"; rec."Last Invoice Date")
                {
                    ApplicationArea = all;
                }
                field("Applied Entry to Adjust"; rec."Applied Entry to Adjust")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Expected)"; rec."Cost Amount (Expected)")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Cost Amount (Actual)"; rec."Cost Amount (Actual)")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Non-Invtbl.)"; rec."Cost Amount (Non-Invtbl.)")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Expected) (ACY)"; rec."Cost Amount (Expected) (ACY)")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Actual) (ACY)"; rec."Cost Amount (Actual) (ACY)")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Non-Invtbl.)(ACY)"; rec."Cost Amount (Non-Invtbl.)(ACY)")
                {
                    ApplicationArea = all;
                }
                field("Purchase Amount (Expected)"; rec."Purchase Amount (Expected)")
                {
                    ApplicationArea = all;
                }
                field("Purchase Amount (Actual)"; rec."Purchase Amount (Actual)")
                {
                    ApplicationArea = all;
                }
                field("Sales Amount (Expected)"; rec."Sales Amount (Expected)")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Sales Amount (Actual)"; rec."Sales Amount (Actual)")
                {
                    ApplicationArea = all;
                }
                field(Correction; rec.Correction)
                {
                    ApplicationArea = all;
                }
                field("Shipped Qty. Not Returned"; rec."Shipped Qty. Not Returned")
                {
                    ApplicationArea = all;
                }
                field("Prod. Order Comp. Line No."; rec."Prod. Order Comp. Line No.")
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
                }
                field("Warranty Date"; rec."Warranty Date")
                {
                    ApplicationArea = all;
                }
                field("Expiration Date"; rec."Expiration Date")
                {
                    ApplicationArea = all;
                }
                field("Item Tracking"; rec."Item Tracking")
                {
                    ApplicationArea = all;
                }
                field("Return Reason Code"; rec."Return Reason Code")
                {
                    ApplicationArea = all;
                }
                // field("DSA Entry No."; rec."DSA Entry No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("BED %"; rec."BED %")
                // {
                //     ApplicationArea = all;
                // }
                // field("BED Amount"; rec."BED Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Other Duties %"; rec."Other Duties %")
                // {
                //     ApplicationArea = all;
                // }
                // field("Other Duties Amount"; rec."Other Duties Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Laboratory Test"; rec."Laboratory Test")
                // {
                //     ApplicationArea = all;
                // }
                // field("Other Usage"; rec."Other Usage")
                // {
                //     ApplicationArea = all;
                // }
                // field("Nature of Disposal"; rec."Nature of Disposal")
                // {
                //     ApplicationArea = all;
                // }
                // field("Type of Disposal"; rec."Type of Disposal")
                // {
                //     ApplicationArea = all;
                // }
                // field("Reason Code"; rec."Reason Code")
                // {
                //     ApplicationArea = all;
                // }
                // field("Captive Consumption"; rec."Captive Consumption")
                // {
                //     ApplicationArea = all;
                // }
                // field("Re-Dispatch"; rec."Re-Dispatch")
                // {
                //     ApplicationArea = all;
                // }
                // field("Assessable Value"; rec."Assessable Value")
                // {
                //     ApplicationArea = all;
                // }
                field("Subcon Order No."; rec."Subcon Order No.")
                {
                    ApplicationArea = all;
                }
                field("Original Quantity"; rec."Original Quantity")
                {
                    ApplicationArea = all;
                }
                field("Quantity in Sales UOM"; rec."Quantity in Sales UOM")
                {
                    ApplicationArea = all;
                }
                field("Density Factor"; rec."Density Factor")
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

