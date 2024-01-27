pageextension 60008 Item_Journal_Ext extends "Item Journal"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Item No.")
        {
            // field("Lot No."; Rec."Lot No.")
            // {
            //     ApplicationArea = all;
            // }
        }
        addafter(Amount)
        {
            // field("Assessable Value"; rec."Assessable Value")
            // {
            //     ApplicationArea = all;
            // }
        }
        addafter("Transport Method")
        {
            /*  field("Bin Code"; Rec."Bin Code")
             {
                 ApplicationArea = all;
             } */
        }
        modify("Entry Type")
        {
            trigger OnAfterValidate()
            begin
                //>>07Mar2019
                ItmJnlBatch.RESET;
                ItmJnlBatch.SETRANGE("Journal Template Name", rec."Journal Template Name");
                ItmJnlBatch.SETRANGE(Name, rec."Journal Batch Name");
                IF ItmJnlBatch.FINDFIRST THEN BEGIN
                    IF ItmJnlBatch."Insurance Adjustment" THEN
                        IF rec."Entry Type" <> Rec."Entry Type"::"Negative Adjmt." THEN
                            ERROR('Only Negative Entry are allowed for this Batch');
                end;
            end;
        }
        // Add changes to page layout here
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                IF (USERID = 'ROBOSOFT.SUPPORT2') OR (USERID = 'ROBOSOFT.SUPPORT1') OR (USERID = 'GPUAE\FAHIM.AHMAD') OR (USERID = 'GPUAE\RAVI.KHAMBAL') THEN BEGIN
                    // CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec);
                    // CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                    // CurrPage.UPDATE(FALSE);
                END ELSE
                    MESSAGE('You dont have right to post.');
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            begin
                IF (USERID = 'ROBOSOFT.SUPPORT2') OR (USERID = 'ROBOSOFT.SUPPORT1') OR (USERID = 'GPUAE\FAHIM.AHMAD') OR (USERID = 'GPUAE\RAVI.KHAMBAL') THEN BEGIN
                    // CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post+Print", Rec);
                    // CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                    // CurrPage.UPDATE(FALSE);
                END ELSE
                    MESSAGE('You dont have right to post.');
            end;
        }

        // Add changes to page actions here
    }

    var
        myInt: Integer;
        tch: Record 233;
        ItmJnlBatch: Record 233;
}