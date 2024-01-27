page 50146 "Update Capacity Ledger Entry"
{
    PageType = List;
    Permissions = TableData 5832 = rim;
    SourceTable = 5832;
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
                field("No."; rec."No.")
                {
                    ApplicationArea = all;

                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;

                }
                field(Type; rec.Type)
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
                field("Operation No."; rec."Operation No.")
                {
                    ApplicationArea = all;

                }
                field("Work Center No."; rec."Work Center No.")
                {
                    ApplicationArea = all;

                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;

                }
                field("Setup Time"; rec."Setup Time")
                {
                    ApplicationArea = all;

                }
                field("Run Time"; rec."Run Time")
                {
                    ApplicationArea = all;

                }
                field("Stop Time"; rec."Stop Time")
                {
                    ApplicationArea = all;

                }
                field("Invoiced Quantity"; rec."Invoiced Quantity")
                {
                    ApplicationArea = all;

                }
                field("Output Quantity"; rec."Output Quantity")
                {
                    ApplicationArea = all;

                }
                field("Scrap Quantity"; rec."Scrap Quantity")
                {
                    ApplicationArea = all;

                }
                field("Concurrent Capacity"; rec."Concurrent Capacity")
                {
                    ApplicationArea = all;

                }
                field("Cap. Unit of Measure Code"; rec."Cap. Unit of Measure Code")
                {
                    ApplicationArea = all;

                }
                field("Qty. per Cap. Unit of Measure"; rec."Qty. per Cap. Unit of Measure")
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
                field("Last Output Line"; rec."Last Output Line")
                {
                    ApplicationArea = all;

                }
                field("Completely Invoiced"; rec."Completely Invoiced")
                {
                    ApplicationArea = all;

                }
                field("Starting Time"; rec."Starting Time")
                {
                    ApplicationArea = all;

                }
                field("Ending Time"; rec."Ending Time")
                {
                    ApplicationArea = all;

                }
                field("Routing No."; rec."Routing No.")
                {
                    ApplicationArea = all;

                }
                field("Routing Reference No."; rec."Routing Reference No.")
                {
                    ApplicationArea = all;

                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;

                }
                field("Variant Code"; rec."Variant Code")
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
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;

                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;

                }
                field("Stop Code"; rec."Stop Code")
                {
                    ApplicationArea = all;

                }
                field("Scrap Code"; rec."Scrap Code")
                {
                    ApplicationArea = all;

                }
                field("Work Center Group Code"; rec."Work Center Group Code")
                {
                    ApplicationArea = all;

                }
                field("Work Shift Code"; rec."Work Shift Code")
                {
                    ApplicationArea = all;

                }
                field("Direct Cost"; rec."Direct Cost")
                {
                    ApplicationArea = all;

                }
                field("Overhead Cost"; rec."Overhead Cost")
                {
                    ApplicationArea = all;

                }
                field("Direct Cost (ACY)"; rec."Direct Cost (ACY)")
                {
                    ApplicationArea = all;

                }
                field("Overhead Cost (ACY)"; rec."Overhead Cost (ACY)")
                {
                    ApplicationArea = all;

                }
                field(Subcontracting; rec.Subcontracting)
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
            }
        }
    }

    actions
    {
    }
}

