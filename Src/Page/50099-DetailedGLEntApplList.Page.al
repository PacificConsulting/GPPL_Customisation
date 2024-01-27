page 50099 "Detailed GL Ent. Appl. List"
{
    PageType = List;
    SourceTable = 50058;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("G/L Application Entry No."; rec."G/L Application Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; rec."Entry Type")
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
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Amount (LCY)"; rec."Amount (LCY)")
                {
                }
                field("G/L Account No."; rec."G/L Account No.")
                {
                }
                field("User ID"; rec."User ID")
                {
                }
                field("Source Code"; rec."Source Code")
                {
                }
                field("Transaction No."; rec."Transaction No.")
                {
                }
                field("Debit Amount"; rec."Debit Amount")
                {
                }
                field("Credit Amount"; rec."Credit Amount")
                {
                }
                field("Debit Amount (LCY)"; rec."Debit Amount (LCY)")
                {
                }
                field("Credit Amount (LCY)"; rec."Credit Amount (LCY)")
                {
                }
                field("Initial Entry Global Dim. 1"; rec."Initial Entry Global Dim. 1")
                {
                }
                field("Initial Entry Global Dim. 2"; rec."Initial Entry Global Dim. 2")
                {
                }
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                }
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                }
                field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
                {
                }
                field("VAT Prod. Posting Group"; rec."VAT Prod. Posting Group")
                {
                }
                field("Initial Document Type"; rec."Initial Document Type")
                {
                }
                field("Applied G/L Appl Entry No."; rec."Applied G/L Appl Entry No.")
                {
                }
                field(Unapplied; rec.Unapplied)
                {
                }
                field("Unapplied by Entry No."; rec."Unapplied by Entry No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

