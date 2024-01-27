page 50114 ValEntry_Update
{
    PageType = List;
    Permissions = TableData 5802 = rimd;
    SourceTable = 5802;
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
                field("Item Ledger Entry Type"; rec."Item Ledger Entry Type")
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
                field("Inventory Posting Group"; rec."Inventory Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Source Posting Group"; rec."Source Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Item Ledger Entry No."; rec."Item Ledger Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Valued Quantity"; rec."Valued Quantity")
                {
                    ApplicationArea = all;
                }
                field("Item Ledger Entry Quantity"; rec."Item Ledger Entry Quantity")
                {
                    ApplicationArea = all;
                }
                field("Invoiced Quantity"; rec."Invoiced Quantity")
                {
                    ApplicationArea = all;
                }
                field("Cost per Unit"; rec."Cost per Unit")
                {
                    ApplicationArea = all;
                }
                field("Sales Amount (Actual)"; rec."Sales Amount (Actual)")
                {
                    ApplicationArea = all;
                }
                field("Salespers./Purch. Code"; rec."Salespers./Purch. Code")
                {
                    ApplicationArea = all;
                }
                field("Discount Amount"; rec."Discount Amount")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Source Code"; rec."Source Code")
                {
                    ApplicationArea = all;
                }
                field("Applies-to Entry"; rec."Applies-to Entry")
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
                field("Source Type"; rec."Source Type")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Actual)"; rec."Cost Amount (Actual)")
                {
                    ApplicationArea = all;
                }
                field("Cost Posted to G/L"; rec."Cost Posted to G/L")
                {
                    ApplicationArea = all;
                }
                field("Reason Code"; rec."Reason Code")
                {
                    ApplicationArea = all;
                }
                field("Drop Shipment"; rec."Drop Shipment")
                {
                    ApplicationArea = all;
                }
                field("Journal Batch Name"; rec."Journal Batch Name")
                {
                    ApplicationArea = all;
                }
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
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
                field("Cost Amount (Actual) (ACY)"; rec."Cost Amount (Actual) (ACY)")
                {
                    ApplicationArea = all;
                }
                field("Cost Posted to G/L (ACY)"; rec."Cost Posted to G/L (ACY)")
                {
                    ApplicationArea = all;
                }
                field("Cost per Unit (ACY)"; rec."Cost per Unit (ACY)")
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
                field("Expected Cost"; rec."Expected Cost")
                {
                    ApplicationArea = all;
                }
                field("Item Charge No."; rec."Item Charge No.")
                {
                    ApplicationArea = all;
                }
                field("Valued By Average Cost"; rec."Valued By Average Cost")
                {
                    ApplicationArea = all;
                }
                field("Partial Revaluation"; rec."Partial Revaluation")
                {
                    ApplicationArea = all;
                }
                field(Inventoriable; rec.Inventoriable)
                {
                    ApplicationArea = all;
                }
                field("Valuation Date"; rec."Valuation Date")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Variance Type"; rec."Variance Type")
                {
                    ApplicationArea = all;
                }
                field("Purchase Amount (Actual)"; rec."Purchase Amount (Actual)")
                {
                    ApplicationArea = all;
                }
                field("Purchase Amount (Expected)"; rec."Purchase Amount (Expected)")
                {
                    ApplicationArea = all;
                }
                field("Sales Amount (Expected)"; rec."Sales Amount (Expected)")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Expected)"; rec."Cost Amount (Expected)")
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
                field("Cost Amount (Non-Invtbl.)(ACY)"; rec."Cost Amount (Non-Invtbl.)(ACY)")
                {
                    ApplicationArea = all;
                }
                field("Expected Cost Posted to G/L"; rec."Expected Cost Posted to G/L")
                {
                    ApplicationArea = all;
                }
                field("Exp. Cost Posted to G/L (ACY)"; rec."Exp. Cost Posted to G/L (ACY)")
                {
                    ApplicationArea = all;
                }
                field("Dimension Set ID"; rec."Dimension Set ID")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                }
                field("Job Task No."; rec."Job Task No.")
                {
                    ApplicationArea = all;
                }
                field("Job Ledger Entry No."; rec."Job Ledger Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                }
                field(Adjustment; rec.Adjustment)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Average Cost Exception"; rec."Average Cost Exception")
                {
                    ApplicationArea = all;
                }
                field("Capacity Ledger Entry No."; rec."Capacity Ledger Entry No.")
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Return Reason Code"; rec."Return Reason Code")
                {
                    ApplicationArea = all;
                }
                //     field("BED %"; rec."BED %")
                //     {
                //         ApplicationArea = all;
                //     }
                //     field("BED Amount"; rec."BED Amount")
                //     {
                //         ApplicationArea = all;
                //     }
                //     field("Other Duties %"; rec."Other Duties %")
                //     {
                //         ApplicationArea = all;
                //     }
                //     field("Other Duties Amount"; rec."Other Duties Amount")
                //     {
                //         ApplicationArea = all;
                //     }
                //     field("Assessable Value"; rec."Assessable Value")
                //     {
                //         ApplicationArea = all;
                //     }
            }
        }
    }

}

