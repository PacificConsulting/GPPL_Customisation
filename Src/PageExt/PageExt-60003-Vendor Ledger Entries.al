pageextension 60003 Vendor_led_entreis_Ext extends "Vendor Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            // field("Serv. Tax on Advance Payment"; rec."Serv. Tax on Advance Payment")
            // {
            //     ApplicationArea = all;
            // }
            /*   field("Debit Amount"; Rec."Debit Amount")
              {
                  ApplicationArea = all;
              }
              field("Credit Amount"; Rec."Credit Amount")
              {
                  ApplicationArea = all;
              }
              field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
              {
                  ApplicationArea = all;
              }
              field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
              {
                  ApplicationArea = all;
              } */

        }
        addafter("Bal. Account No.")
        {
            // field("TDS Nature of Deduction"; rec."TDS Nature of Deduction")
            // {
            //     ApplicationArea = all;
            // }
            field("Total TDS Including SHE CESS"; rec."Total TDS Including SHE CESS")
            {
                ApplicationArea = all;
            }
        }
        addafter("User ID")
        {
            /* field("Vendor Posting Group"; Rec."Vendor Posting Group")
            {
                ApplicationArea = all;
            } */
        }
        addafter("Reversed Entry No.")
        {
            field("Transaction No."; rec."Transaction No.")
            {
                ApplicationArea = all;
            }
        }

        // Add changes to page layout here
    }

    actions
    {
        addafter("Print Voucher")
        {
            action("Print Voucher GP")
            {
                Image = PrintVoucher;
                trigger OnAction()
                var
                    GLEntry: Record 17;
                begin
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
                    GLEntry.SETRANGE("Document No.", rec."Document No.");
                    GLEntry.SETRANGE("Posting Date", rec."Posting Date");
                    IF GLEntry.FIND('-') THEN
                        REPORT.RUNMODAL(50207, TRUE, TRUE, GLEntry);
                end;
            }

        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}