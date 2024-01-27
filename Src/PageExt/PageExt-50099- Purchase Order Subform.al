
// MY PC 12 01 2024
pageextension 50099 "PurchaseOrderSubformExt" extends "Purchase Order Subform"
{
    layout
    {
        addafter("GST Assessable Value")
        {
            field("QC Applicable"; rec."QC Applicable")
            {
                ApplicationArea = all;

            }
            field("QC Approved"; rec."QC Approved")
            {
                ApplicationArea = all;
            }
            field("Density Factor"; rec."Density Factor")
            {
                ApplicationArea = all;
            }
            field("Bonded Rate"; rec."Bonded Rate")
            {
                ApplicationArea = all;
            }
            field("Exbond Rate"; rec."Exbond Rate")
            {
                ApplicationArea = all;
            }
            field("Landed Cost"; rec."Landed Cost")
            {
                ApplicationArea = all;
            }
            field("TDS Applicable"; rec."TDS Applicable")
            {
                ApplicationArea = all;
            }


        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}