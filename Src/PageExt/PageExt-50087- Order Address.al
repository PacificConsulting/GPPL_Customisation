pageextension 50087 "OrderAddressExt" extends "Order Address"
{
    layout
    {
        addafter("Country/Region Code")
        {
            // field(State; rec.State)
            // {
            //     ApplicationArea = all;
            // }

            field("T.I.N. No."; rec."T.I.N. No.")
            {
                ApplicationArea = all;
            }
            field("L.S.T. No."; rec."L.S.T. No.")
            {
                ApplicationArea = all;
            }
            field("C.S.T. No."; rec."C.S.T. No.")
            {
                ApplicationArea = all;
            }
            field("E.C.C. No."; rec."E.C.C. No.")
            {
                ApplicationArea = all;
            }
            field("GST Vendor Type"; rec."GST Vendor Type")
            {
                ApplicationArea = all;
            }
            // field("GST Registration No."; rec."GST Registration No.")
            // {
            //     ApplicationArea = all;
            // }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}