page 50021 "CNF Commission Setup"
{
    PageType = Document;
    SourceTable = 50011;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Commission Code"; rec."Commission Code")
                {
                    applicationarea = all;
                }
                field("Customer Type"; rec."Customer Type")
                {
                    applicationarea = all;
                }
                field("Calculation Date"; rec."Calculation Date")
                {
                    applicationarea = all;
                    Caption = 'Starting Date';
                }
                field("Location Code"; rec."Location Code")
                {
                    applicationarea = all;
                }
            }
            part(part1; 50020)
            {
                SubPageLink = "Commision Code" = FIELD("Commission Code");
            }
            group(Defaults)
            {
                Caption = 'Defaults';
                field("Value of Billing"; rec."Value of Billing")
                {
                    applicationarea = all;
                }
                field("Account (Form Expense)"; rec."Account (Form Expense)")
                {
                    applicationarea = all;
                }
                field("Fixed Exp. Rem. Account"; rec."Fixed Exp. Rem. Account")
                {
                    applicationarea = all;
                }
                field("Variable Exp. Rem. Account"; rec."Variable Exp. Rem. Account")
                {
                    applicationarea = all;
                }
                field("Handling Charge Account"; rec."Handling Charge Account")
                {
                    applicationarea = all;
                }
                field("Minimum Sales Volume Qty."; rec."Minimum Sales Volume Qty.")
                {
                    applicationarea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Create Purchase Orders")
            {
                Caption = '&Create Purchase Orders';
                action("Run Re&port")
                {
                    ApplicationArea = all;
                    Caption = 'Run Re&port';
                    //RunObject = Report 50093;
                    ShortCutKey = 'F9';
                }
            }
        }
    }
}

