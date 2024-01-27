pageextension 50030 "Item Journal BatchesExtcstm" extends "Item Journal Batches"
{
    layout
    {
        addafter("Reason Code")
        {
            field("Insurance Adjustment"; Rec."Insurance Adjustment")
            {
                ApplicationArea = all;
            }
            field("Insurance / Loss G/L No."; Rec."Insurance / Loss G/L No.")
            {
                ApplicationArea = all;
            }
            field("Purchase Account"; Rec."Purchase Account")
            {
                ApplicationArea = all;
            }
            field("GST Account"; Rec."GST Account")
            {
                ApplicationArea = all;
            }
            field("GST Percentage"; Rec."GST Percentage")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
        UserSetup: Record "User Setup";
    begin
        //07Mar2019
        IF Rec."Insurance Adjustment" THEN BEGIN
            UserSetup.RESET;
            IF UserSetup.GET(USERID) THEN;
            IF NOT UserSetup."Insurance Adjustment" THEN
                ERROR('You are not allowed to select %1 Batch', Rec.Name);
        END;
        //
    end;

    var
        myInt: Integer;
}