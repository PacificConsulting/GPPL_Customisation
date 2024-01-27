// MY PC 12 01 2024
pageextension 50098 "PostedPurchaseInvoicesExtcstm" extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("Amount Including VAT")
        {
            field("Handover To"; rec."Handover To")
            {
                ApplicationArea = all;
            }
            field("Date of Receipt"; rec."Date of Receipt")
            {
                ApplicationArea = all;
            }
            field("Date of Issue"; rec."Date of Issue")
            {
                ApplicationArea = all;
            }
            field("Total No. of Invoices"; rec."Total No. of Invoices")
            {
                ApplicationArea = all;
            }
            field("Period Form"; rec."Period Form")
            {
                ApplicationArea = all;
            }
            field("Period To"; rec."Period To")
            {
                ApplicationArea = all;
            }
            field("Form Issued Amount"; rec."Form Issued Amount")
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