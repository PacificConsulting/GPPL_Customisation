// MY PC 12 01 2024
pageextension 50095 "PostedPurchaseInvSubFormExt" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter(Type)
        {
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
            field("Sub Expense Code"; rec."Sub Expense Code")
            {
                ApplicationArea = all;
            }
            field("Import Invoice No."; rec."Import Invoice No.")
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