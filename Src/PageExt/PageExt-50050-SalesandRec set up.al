pageextension 50050 SalesRecSetupExtcstm extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("GST Dependency Type")
        {
            field("Sales Approval Max Level"; Rec."Sales Approval Max Level")
            {
                ApplicationArea = all;
            }
            field("OverDue Cr. Period Tolarance"; Rec."OverDue Cr. Period Tolarance")
            {
                ApplicationArea = all;
            }
            field("OverDue Cr. Limit Tolarance"; Rec."OverDue Cr. Limit Tolarance")
            {
                ApplicationArea = all;
            }
            field("Posted Cancelled Invoice Nos."; Rec."Posted Cancelled Invoice Nos.")
            {
                ApplicationArea = all;
            }
            field("Posted Cancelled.Shipment Nos."; Rec."Posted Cancelled.Shipment Nos.")
            {
                ApplicationArea = all;
            }
            field("C Form Track No."; Rec."C Form Track No.")
            {
                ApplicationArea = all;
            }
            field("Dummy Sales Order Nos."; Rec."Dummy Sales Order Nos.")
            {
                ApplicationArea = all;
            }
            field("Dummy Order"; Rec."Dummy Order")
            {
                ApplicationArea = all;
            }
            field("AVP Discount Account"; Rec."AVP Discount Account")
            {
                ApplicationArea = all;
            }
            field("Spot Discount Account"; Rec."Spot Discount Account")
            {
                ApplicationArea = all;
            }
            field("Special Mgm Account"; Rec."Special Mgm Account")
            {
                ApplicationArea = all;
            }
            field("Price Difference Account"; Rec."Price Difference Account")
            {
                ApplicationArea = all;
            }
            field("CT3 Excise Bus. Posting Group"; Rec."CT3 Excise Bus. Posting Group")
            {
                ApplicationArea = all;
            }
            field("Email Notification On SO"; Rec."Email Notification On SO")
            {
                ApplicationArea = all;
            }
            field("Email Notification On SalesCr"; Rec."Email Notification On SalesCr")
            {
                ApplicationArea = all;
            }
            field("Email Alert On SalesReturn"; Rec."Email Alert On SalesReturn")
            {
                ApplicationArea = all;
                Caption = 'Email Notification On Sales Return';

            }
            field("Email Alert on Sales Inv Post"; Rec."Email Alert on Sales Inv Post")
            {
                ApplicationArea = all;
                Caption = 'Email Notification on Sales Invoice Post';
            }
            field("Email Alert On Customer App"; Rec."Email Alert On Customer App")
            {
                ApplicationArea = all;
            }
            field("Email Alert On Customer Credit"; Rec."Email Alert On Customer Credit")
            {
                ApplicationArea = all;
            }
            field("Email PDF of SO to SalesPeople"; Rec."Email PDF of SO to SalesPeople")
            {
                ApplicationArea = all;
            }
            field("Email Alert On Customer KYC"; Rec."Email Alert On Customer KYC")
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