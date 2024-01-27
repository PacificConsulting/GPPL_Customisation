pageextension 50046 "Item Tracking SummaryExtcstm" extends "Item Tracking Summary"
{
    layout
    {
        addafter("Current Pending Quantity")
        {
            field("Quantity in Sales UOM"; Rec."Quantity in Sales UOM")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("MRP Price"; Rec."MRP Price")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("List Price"; Rec."List Price")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Manufacturing Date"; Rec."Manufacturing Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SETCURRENTKEY("Manufacturing Date"); //RB-N 18Nov2017
    end;

    var
        myInt: Integer;
}