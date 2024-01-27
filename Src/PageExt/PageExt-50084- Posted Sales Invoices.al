// MY PC 11 01 2024
pageextension 50084 "PostedSalesInvoicesExt" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Sell-to Customer No.")
        {
            field("Cancelled Invoice"; rec."Cancelled Invoice")
            {
                ApplicationArea = all;
            }
            field("Supplimentary Invoice"; rec."Supplimentary Invoice")
            {
                ApplicationArea = all;
            }
            field("OverDue Balance"; rec."OverDue Balance")
            {
                ApplicationArea = all;
            }
            field("Commission Agent"; rec."Commission Agent")
            {
                ApplicationArea = all;
            }
            field("Driver's Name"; rec."Driver's Name")
            {
                ApplicationArea = all;
            }
            field("Driver's Mobile No."; rec."Driver's Mobile No.")
            {
                ApplicationArea = all;
            }
            field(Remarks; rec.Remarks)
            {
                ApplicationArea = all;
            }
            field("Invoice Print Time"; rec."Invoice Print Time")
            {
                ApplicationArea = all;
            }
            field("Print Invoice"; rec."Print Invoice")
            {
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    var
        InvoiceStatus: Text[30];
    begin
        //RB-N 03Jan2018
        IF rec."Cancelled Invoice" THEN
            InvoiceStatus := 'CANCELLED'
        ELSE
            InvoiceStatus := '';
        //RB-N 03Jan2018

    end;

    var
        myInt: Integer;
}