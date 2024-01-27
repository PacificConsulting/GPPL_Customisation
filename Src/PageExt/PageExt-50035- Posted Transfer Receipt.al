pageextension 50035 "PostedTransferReceiptExtcstm" extends "Posted Transfer Receipt"
{
    layout
    {
        addafter("Foreign Trade")
        {
            group(Vehical)
            {
                field("Empty Vehicle Weight"; Rec."Empty Vehicle Weight")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vehicle Weight After loading"; Rec."Vehicle Weight After loading")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Net Weight of the Truck"; Rec."Net Weight of the Truck")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("WH Bill Entry No."; Rec."WH Bill Entry No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Time In/Out"; Rec."Time In/Out")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Debond Bill Entry No."; Rec."Debond Bill Entry No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Transfer Indent No."; Rec."Transfer Indent No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Road Permit No."; Rec."Road Permit No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
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