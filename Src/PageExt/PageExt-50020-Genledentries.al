pageextension 50020 genledentextcstm extends "General Ledger Entries"
{
    layout
    {
        addafter("External Document No.")
        {
            // field("Exp/Purchase Invoice Doc. No."; Rec."Exp/Purchase Invoice Doc. No.")
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



    trigger OnAfterGetRecord()
    var

    begin
        //Fahim 29-09-2021
        CLEAR(BLPUORNo);
        IF rec."Source Type" = rec."Source Type"::Vendor THEN BEGIN
            PuInvHeader.RESET;
            IF PuInvHeader.GET(rec."Document No.") THEN
                BLPUORNo := PuInvHeader."Blanket Order No.";
        END;


    end;

    var
        myInt: Integer;
        PuInvHeader: Record "Purch. Inv. Header";
        BLPUORNo: Text[50];

}