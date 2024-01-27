page 50107 GLE_Update
{
    PageType = List;
    Permissions = TableData 17 = rimd;
    SourceTable = 17;
    SourceTableView = SORTING("G/L Account No.", "Posting Date");
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
                field("G/L Account No."; rec."G/L Account No.")
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
                field("Bal. Account No."; rec."Bal. Account No.")
                {
                    ApplicationArea = all;
                }
                field(Amount; rec.Amount)
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
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Source Code"; rec."Source Code")
                {
                    ApplicationArea = all;
                }
                field("System-Created Entry"; rec."System-Created Entry")
                {
                    ApplicationArea = all;
                }
                field("Prior-Year Entry"; rec."Prior-Year Entry")
                {
                    ApplicationArea = all;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("VAT Amount"; rec."VAT Amount")
                {
                    ApplicationArea = all;
                }
                field("Business Unit Code"; rec."Business Unit Code")
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
                field("Gen. Posting Type"; rec."Gen. Posting Type")
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
                field("Bal. Account Type"; rec."Bal. Account Type")
                {
                    ApplicationArea = all;
                }
                field("Transaction No."; rec."Transaction No.")
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
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; rec."External Document No.")
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
                field("No. Series"; rec."No. Series")
                {
                    ApplicationArea = all;
                }
                field("Tax Area Code"; rec."Tax Area Code")
                {
                    ApplicationArea = all;
                }
                field("Tax Liable"; rec."Tax Liable")
                {
                    ApplicationArea = all;
                }
                field("Tax Group Code"; rec."Tax Group Code")
                {
                    ApplicationArea = all;
                }
                field("Use Tax"; rec."Use Tax")
                {
                    ApplicationArea = all;
                }
                field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("VAT Prod. Posting Group"; rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Additional-Currency Amount"; rec."Additional-Currency Amount")
                {
                    ApplicationArea = all;
                }
                field("Add.-Currency Debit Amount"; rec."Add.-Currency Debit Amount")
                {
                    ApplicationArea = all;
                }
                field("Add.-Currency Credit Amount"; rec."Add.-Currency Credit Amount")
                {
                    ApplicationArea = all;
                }
                field("Close Income Statement Dim. ID"; rec."Close Income Statement Dim. ID")
                {
                    ApplicationArea = all;
                }
                field("IC Partner Code"; rec."IC Partner Code")
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
                field("G/L Account Name"; rec."G/L Account Name")
                {
                    ApplicationArea = all;
                }
                field("Dimension Set ID"; rec."Dimension Set ID")
                {
                    ApplicationArea = all;
                }
                field("Prod. Order No."; rec."Prod. Order No.")
                {
                    ApplicationArea = all;
                }
                field("FA Entry Type"; rec."FA Entry Type")
                {
                    ApplicationArea = all;
                }
                field("FA Entry No."; rec."FA Entry No.")
                {
                    ApplicationArea = all;
                }
                // field("Tax Amount"; rec."Tax Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Location Code"; rec."Location Code")
                // {
                //     ApplicationArea = all;
                // }
                field("Check Print Name"; rec."Check Print Name")
                {
                    ApplicationArea = all;
                }
                field("Exp/Purchase Invoice Doc. No."; rec."Exp/Purchase Invoice Doc. No.")
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

