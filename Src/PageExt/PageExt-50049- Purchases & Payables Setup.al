pageextension 50049 "PurchPayables SetupExtCstm" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter(General)
        {
            group("Email Notification")
            {
                field("Email Alert on Blanket PO"; Rec."Email Alert on Blanket PO")
                {
                    ApplicationArea = all;
                }
                field("Email Alert on GatePass"; Rec."Email Alert on GatePass")
                {
                    ApplicationArea = all;
                }
                field("QC Approval Email Alert"; Rec."QC Approval Email Alert")
                {
                    ApplicationArea = all;
                }
            }
        }
        addlast(General)
        {
            field("Posted GatePass Nos"; Rec."Posted GatePass Nos")
            {
                ApplicationArea = all;
            }
            field("Requistion GatePass Nos"; Rec."Requistion GatePass Nos")
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