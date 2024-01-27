pageextension 50031 UserSetupExtstm extends "User Setup"
{
    layout
    {
        addafter("User ID")
        {
            field(Name; Rec.Name)
            {
                Caption = 'User Name';
                ApplicationArea = all;
            }
            field(Name1; Rec.Name)
            {
                Caption = 'Name';
                ApplicationArea = all;
            }
        }
        addafter("Register Time")
        {
            field("Credit Limit Approval"; Rec."Credit Limit Approval")
            {
                ApplicationArea = all;
            }
            field("TRO Deletion"; Rec."TRO Deletion")
            {
                ApplicationArea = all;
            }
            field("PO Creation"; Rec."PO Creation")
            {
                ApplicationArea = all;
            }
            field("JV Posting"; Rec."JV Posting")
            {
                ApplicationArea = all;
            }
            field("Insurance Adjustment"; Rec."Insurance Adjustment")
            {
                ApplicationArea = all;
            }

            field("Finance Approver"; Rec."Finance Approver")
            {
                ApplicationArea = all;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = all;
            }
            field("Blanket PO Creation"; Rec."Blanket PO Creation")
            {
                ApplicationArea = all;
            }
            field("Production BOM Edit"; Rec."Production BOM Edit")
            {
                ApplicationArea = all;
            }
            field("Packaging Prod. BOM Edit"; Rec."Packaging Prod. BOM Edit")
            {
                ApplicationArea = all;
            }
            field("Production BOM View"; Rec."Production BOM View")
            {
                ApplicationArea = all;
            }
            field("Credit Limit Update"; Rec."Credit Limit Update")
            {
                ApplicationArea = all;
            }
            field("Description 3 Visible"; Rec."Description 3 Visible")
            {
                ApplicationArea = all;
            }
            field("Shipping Agent List Editable"; Rec."Shipping Agent List Editable")
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