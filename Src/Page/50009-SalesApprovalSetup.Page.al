page 50009 "Sales Approval Setup"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = 50008;
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'IPOL Approval Setup';
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                    Caption = 'User Name';
                    Editable = false;
                }
                field("Approvar ID"; rec."Approvar ID")
                {
                    ApplicationArea = all;
                }
                field("Approvar Name"; rec."Approvar Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Division Code 1"; rec."Division Code")
                {
                    ApplicationArea = all;
                    Caption = 'Division Code 1';
                }
                field("Division Code 2"; rec."Division Code 2")
                {
                    ApplicationArea = all;
                }
                field("Division Code 3"; rec."Division Code 3")
                {
                    ApplicationArea = all;
                }
                field("Division Code 4"; rec."Division Code 4")
                {
                    ApplicationArea = all;
                }
                field("Division Code 5"; rec."Division Code 5")
                {
                    ApplicationArea = all;
                }
                field(Mandatory; rec.Mandatory)
                {
                    ApplicationArea = all;
                }
                field(MD; rec.MD)
                {
                    ApplicationArea = all;
                }
                field("Purchase Approval Limit"; rec."Purchase Approval Limit")
                {
                    ApplicationArea = all;
                    Editable = BlanketPOApproval;
                }
                field("Level2 Approvar ID"; rec."Level2 Approvar ID")
                {
                    ApplicationArea = all;
                }
                field("Level2 Approvar Name"; rec."Level2 Approvar Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Credit Approvar ID"; rec."Credit Approvar ID")
                {
                    ApplicationArea = all;
                }
                field("Credit Approvar Name"; rec."Credit Approvar Name")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin

        //>>17May2018
        BlanketPOApproval := FALSE;
        IF rec."Document Type" = rec."Document Type"::"Blanket PO" THEN
            BlanketPOApproval := TRUE
        ELSE
            BlanketPOApproval := FALSE;
        //<<17May2018
    end;

    var
        BlanketPOApproval: Boolean;
}

