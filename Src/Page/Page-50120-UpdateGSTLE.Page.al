page 50120 "Update GSTLE"
{
    PageType = List;
    Permissions = TableData "GST Ledger Entry" = rm;
    SourceTable = "GST Ledger Entry";
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
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Transaction Type"; rec."Transaction Type")
                {
                    ApplicationArea = all;
                }
                field("GST Base Amount"; rec."GST Base Amount")
                {
                    ApplicationArea = all;
                }
                field("Source Type"; rec."Source Type")
                {
                    ApplicationArea = all;
                }
                field("Source No."; rec."Source No.")
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
                field("Reason Code"; rec."Reason Code")
                {
                    ApplicationArea = all;
                }
                field("Purchase Group Type"; rec."Purchase Group Type")
                {
                    ApplicationArea = all;
                }
                field("Transaction No."; rec."Transaction No.")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("GST Component Code"; rec."GST Component Code")
                {
                    ApplicationArea = all;
                }
                field("GST on Advance Payment"; rec."GST on Advance Payment")
                {
                    ApplicationArea = all;
                }
                field("Reverse Charge"; rec."Reverse Charge")
                {
                    ApplicationArea = all;
                }
                field("GST Amount"; rec."GST Amount")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field("Currency Factor"; rec."Currency Factor")
                {
                    ApplicationArea = all;
                }
                field(Reversed; rec.Reversed)
                {
                    ApplicationArea = all;
                }
                field("Reversed Entry No."; rec."Reversed Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Reversed by Entry No."; rec."Reversed by Entry No.")
                {
                    ApplicationArea = all;
                }
                field(UnApplied; rec.UnApplied)
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Payment Type"; rec."Payment Type")
                {
                    ApplicationArea = all;
                }
                field("Input Service Distribution"; rec."Input Service Distribution")
                {
                    ApplicationArea = all;
                }
                field(Availment; rec.Availment)
                {
                    ApplicationArea = all;
                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = all;
                }
                field("Bal. Account No."; rec."Bal. Account No.")
                {
                    ApplicationArea = all;
                }
                field("Bal. Account No. 2"; rec."Bal. Account No. 2")
                {
                    ApplicationArea = all;
                }
                field("Account No. 2"; rec."Account No. 2")
                {
                    ApplicationArea = all;
                }
                field("E-Way Bill No."; rec."E-Way Bill No.")
                {
                    ApplicationArea = all;
                }
                field("Distance in kms"; rec."Distance in kms")
                {
                    ApplicationArea = all;
                }
                field("Scan QrCode E-Invoice"; rec."Scan QrCode E-Invoice")
                {
                    ApplicationArea = all;
                }
                field("E-Inv Irn"; rec."E-Inv Irn")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("IRN Ack. Date"; rec."IRN Ack. Date")
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

