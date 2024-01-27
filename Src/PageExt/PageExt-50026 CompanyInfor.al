pageextension 50026 CompInfoExtCstm extends "Company Information"
{
    layout
    {
        addbefore(Picture)
        {
            field("Insurance No."; Rec."Insurance No.")
            {
                ApplicationArea = all;
            }
            field("Insurance Provider"; Rec."Insurance Provider")
            {
                ApplicationArea = all;
            }

            field("Policy Expiration Date"; Rec."Policy Expiration Date")
            {
                ApplicationArea = all;
            }
            field("CIN No."; Rec."CIN No.")
            {
                ApplicationArea = all;
            }
            field("Customer Credit Validation"; Rec."Customer Credit Validation")
            {
                ApplicationArea = all;
            }
            field("Turnover Above 10 Crores"; Rec."Turnover Above 10 Crores")
            {
                ApplicationArea = all;
            }
            field("Name Picture"; Rec."Name Picture")
            {
                ApplicationArea = all;
            }
            field("Repsol Logo"; Rec."Repsol Logo")
            {
                ApplicationArea = all;
            }
        }
        addafter("Registration No.")
        {
            field("System Indicator Style1"; Rec."System Indicator Style")
            {
                ApplicationArea = all;
            }
            field("LBT No."; Rec."LBT No.")
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