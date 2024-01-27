pageextension 70002 Vendor_List_ExtCstm extends "Vendor List"
{
    layout
    {
        addafter("Payment Terms Code")
        {
            // field("Linking of Aadhaar with PAN"; rec."Linking of Aadhaar with PAN")
            // {
            //     ApplicationArea = all;
            // }
            // field("ITR filled for last 02 years"; rec."ITR filled for last 02 years")
            // {
            //     ApplicationArea = all;
            // }
            // field("Exclude From Bal Confir Mail"; rec."Exclude From Bal Confir Mail")
            // {
            //     ApplicationArea = all;
            // }
            // field("IRN Applicable"; rec."IRN Applicable")
            // {
            //     ApplicationArea = all;
            // }
            // field("MSME Status"; Rec."MSME Status")
            // {
            //     ApplicationArea = all;
            // }
            // field("Shipping Agent"; Rec."Shipping Agent")
            // {
            //     ApplicationArea = all;
            // }
            // field("Creation Date"; Rec."Creation Date")
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }
        }
    }


    actions
    {
        // Add changes to page actions here
    }
    //end;

    var
        myInt: Integer;
        ShippingAgentCode: Boolean;
        User: Record 91;
        AccessControl: Record 2000000053;

        MSMERegNoEdit: Boolean;
}