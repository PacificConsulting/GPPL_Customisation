pageextension 50027 "Contra VoucherExtCstm " extends "Contra Voucher"
{
    layout
    {
        addafter(Description)
        {
            field("Check Print Name"; Rec."Check Print Name")
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