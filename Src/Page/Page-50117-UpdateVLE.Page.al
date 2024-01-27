page 50117 "Update VLE"
{
    PageType = List;
    Permissions = TableData 25 = rimd;
    SourceTable = 25;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Remaining Amount"; rec."Remaining Amount")
                {
                    ApplicationArea = all;
                }
                field("Original Amt. (LCY)"; rec."Original Amt. (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Remaining Amt. (LCY)"; rec."Remaining Amt. (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Amount (LCY)"; rec."Amount (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Purchase (LCY)"; rec."Purchase (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Inv. Discount (LCY)"; rec."Inv. Discount (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Posting Group"; rec."Vendor Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Purchaser Code"; rec."Purchaser Code")
                {
                    ApplicationArea = all;
                }
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Source Code"; rec."Source Code")
                {
                    ApplicationArea = all;
                }
                field("On Hold"; rec."On Hold")
                {
                    ApplicationArea = all;
                }
                field("Applies-to Doc. Type"; rec."Applies-to Doc. Type")
                {
                    ApplicationArea = all;
                }
                field("Applies-to Doc. No."; rec."Applies-to Doc. No.")
                {
                    ApplicationArea = all;
                }
                field(Open; rec.Open)
                {
                    ApplicationArea = all;
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = all;
                }
                field("Pmt. Discount Date"; rec."Pmt. Discount Date")
                {
                    ApplicationArea = all;
                }
                field("Original Pmt. Disc. Possible"; rec."Original Pmt. Disc. Possible")
                {
                    ApplicationArea = all;
                }
                field("Pmt. Disc. Rcd.(LCY)"; rec."Pmt. Disc. Rcd.(LCY)")
                {
                    ApplicationArea = all;
                }
                field(Positive; rec.Positive)
                {
                    ApplicationArea = all;
                }
                field("Closed by Entry No."; rec."Closed by Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Closed at Date"; rec."Closed at Date")
                {
                    ApplicationArea = all;
                }
                field("Closed by Amount"; rec."Closed by Amount")
                {
                    ApplicationArea = all;
                }
                field("Applies-to ID"; rec."Applies-to ID")
                {
                    ApplicationArea = all;
                }
                field("Journal Batch Name"; rec."Journal Batch Name")
                {
                    ApplicationArea = all;
                }
                field("Reason Code"; rec."Reason Code")
                {
                    ApplicationArea = all;
                }
                field("Bal. Account Type"; rec."Bal. Account Type")
                {
                    ApplicationArea = all;
                }
                field("Bal. Account No."; rec."Bal. Account No.")
                {
                    ApplicationArea = all;
                }
                field("Transaction No."; rec."Transaction No.")
                {
                    ApplicationArea = all;
                }
                field("Closed by Amount (LCY)"; rec."Closed by Amount (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Debit Amount"; rec."Debit Amount")
                {
                    ApplicationArea = all;
                }
                field("Credit Amount"; rec."Credit Amount")
                {
                    ApplicationArea = all;
                }
                field("Debit Amount (LCY)"; rec."Debit Amount (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Credit Amount (LCY)"; rec."Credit Amount (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("No. Series"; rec."No. Series")
                {
                    ApplicationArea = all;
                }
                field("Closed by Currency Code"; rec."Closed by Currency Code")
                {
                    ApplicationArea = all;
                }
                field("Closed by Currency Amount"; rec."Closed by Currency Amount")
                {
                    ApplicationArea = all;
                }
                field("Adjusted Currency Factor"; rec."Adjusted Currency Factor")
                {
                    ApplicationArea = all;
                }
                field("Original Currency Factor"; rec."Original Currency Factor")
                {
                    ApplicationArea = all;
                }
                field("Original Amount"; rec."Original Amount")
                {
                    ApplicationArea = all;
                }
                field("Date Filter"; rec."Date Filter")
                {
                    ApplicationArea = all;
                }
                field("Remaining Pmt. Disc. Possible"; rec."Remaining Pmt. Disc. Possible")
                {
                    ApplicationArea = all;
                }
                field("Pmt. Disc. Tolerance Date"; rec."Pmt. Disc. Tolerance Date")
                {
                    ApplicationArea = all;
                }
                field("Max. Payment Tolerance"; rec."Max. Payment Tolerance")
                {
                    ApplicationArea = all;
                }
                field("Accepted Payment Tolerance"; rec."Accepted Payment Tolerance")
                {
                    ApplicationArea = all;
                }
                field("Accepted Pmt. Disc. Tolerance"; rec."Accepted Pmt. Disc. Tolerance")
                {
                    ApplicationArea = all;
                }
                field("Pmt. Tolerance (LCY)"; rec."Pmt. Tolerance (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Amount to Apply"; rec."Amount to Apply")
                {
                    ApplicationArea = all;
                }
                field("IC Partner Code"; rec."IC Partner Code")
                {
                    ApplicationArea = all;
                }
                field("Applying Entry"; rec."Applying Entry")
                {
                    ApplicationArea = all;
                }
                field(Reversed; rec.Reversed)
                {
                    ApplicationArea = all;
                }
                field("Reversed by Entry No."; rec."Reversed by Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Reversed Entry No."; rec."Reversed Entry No.")
                {
                    ApplicationArea = all;
                }
                field(Prepayment; rec.Prepayment)
                {
                    ApplicationArea = all;
                }
                field("Creditor No."; rec."Creditor No.")
                {
                    ApplicationArea = all;
                }
                field("Payment Reference"; rec."Payment Reference")
                {
                    ApplicationArea = all;
                }
                field("Payment Method Code"; rec."Payment Method Code")
                {
                    ApplicationArea = all;
                }
                field("Applies-to Ext. Doc. No."; rec."Applies-to Ext. Doc. No.")
                {
                    ApplicationArea = all;
                }
                field("Recipient Bank Account"; rec."Recipient Bank Account")
                {
                    ApplicationArea = all;
                }
                field("Message to Recipient"; rec."Message to Recipient")
                {
                    ApplicationArea = all;
                }
                field("Exported to Payment File"; rec."Exported to Payment File")
                {
                    ApplicationArea = all;
                }
                field("Dimension Set ID"; rec."Dimension Set ID")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                // field("TDS Nature of Deduction"; rec."TDS Nature of Deduction")
                // {
                //     ApplicationArea = all;
                // }
                // field("TDS Group"; rec."TDS Group")
                // {
                //     ApplicationArea = all;
                // }
                field("Total TDS Including SHE CESS"; rec."Total TDS Including SHE CESS")
                {
                    ApplicationArea = all;
                }
                // field("Serv. Tax on Advance Payment"; rec."Serv. Tax on Advance Payment")
                // {
                //     ApplicationArea = all;
                // }
                // field("Input Service Distribution"; rec."Input Service Distribution")
                // {
                //     ApplicationArea = all;
                // }
                // field(PoT; rec.PoT)
                // {
                //     ApplicationArea = all;
                // }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("GST on Advance Payment"; rec."GST on Advance Payment")
                {
                    ApplicationArea = all;
                }
                field("HSN/SAC Code"; rec."HSN/SAC Code")
                {
                    ApplicationArea = all;
                }
                field("GST Reverse Charge"; rec."GST Reverse Charge")
                {
                    ApplicationArea = all;
                }
                field("Adv. Pmt. Adjustment"; rec."Adv. Pmt. Adjustment")
                {
                    ApplicationArea = all;
                }
                field("Location State Code"; rec."Location State Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Buyer State Code"; rec."Buyer State Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Buyer GST Reg. No."; rec."Buyer GST Reg. No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("GST Vendor Type"; rec."GST Vendor Type")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Location GST Reg. No."; rec."Location GST Reg. No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("GST Jurisdiction Type"; rec."GST Jurisdiction Type")
                {
                    ApplicationArea = all;
                }
                field("GST Input Service Distribution"; rec."GST Input Service Distribution")
                {
                    ApplicationArea = all;
                }
                field("GST Group Code"; rec."GST Group Code")
                {
                    ApplicationArea = all;
                }
                field("Check Print Name"; rec."Check Print Name")
                {
                    ApplicationArea = all;
                }
                field("Applied Bank Payment Doc .No"; rec."Applied Bank Payment Doc .No")
                {
                    ApplicationArea = all;
                }
                field("Applied Amount of Bank Payment"; rec."Applied Amount of Bank Payment")
                {
                    ApplicationArea = all;
                }
                field("Purchase order No."; rec."Purchase order No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

