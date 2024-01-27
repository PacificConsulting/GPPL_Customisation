// MY PC 05 01 2024
pageextension 50066 "Sales Ret_Order SubformExtCstm" extends "Sales Return Order Subform"
{
    layout
    {
        addafter(Type)
        {
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = all;
            }

            field("Unit Price Per Lt"; rec."Unit Price Per Lt")
            {
                ApplicationArea = all;
            }

            field("Free of Cost"; rec."Free of Cost")
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