page 50121 "Update DGSTLE"
{
    PageType = List;
    Permissions = TableData "Detailed GST Ledger Entry" = rm;
    SourceTable = "Detailed GST Ledger Entry";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Transaction Type"; rec."Transaction Type")
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
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Product Type"; rec."Product Type")
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
                field("HSN/SAC Code"; rec."HSN/SAC Code")
                {
                    ApplicationArea = all;
                }
                field("GST Component Code"; rec."GST Component Code")
                {
                    ApplicationArea = all;
                }
                field("GST Group Code"; rec."GST Group Code")
                {
                    ApplicationArea = all;
                }
                field("GST Jurisdiction Type"; rec."GST Jurisdiction Type")
                {
                    ApplicationArea = all;
                }
                field("GST Base Amount"; rec."GST Base Amount")
                {
                    ApplicationArea = all;
                }
                field("GST %"; rec."GST %")
                {
                    ApplicationArea = all;
                }
                field("GST Amount"; rec."GST Amount")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("Amount Loaded on Item"; rec."Amount Loaded on Item")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("GST Without Payment of Duty"; rec."GST Without Payment of Duty")
                {
                    ApplicationArea = all;
                }
                field("G/L Account No."; rec."G/L Account No.")
                {
                    ApplicationArea = all;
                }
                field("Reversed by Entry No."; rec."Reversed by Entry No.")
                {
                    ApplicationArea = all;
                }
                field(Reversed; rec.Reversed)
                {
                    ApplicationArea = all;
                }
                // field("User ID"; rec."User ID")
                // {
                //     ApplicationArea = all;
                // }
                // field(Positive; rec.Positive)
                // {
                //     ApplicationArea = all;
                // }
                field("Document Line No."; rec."Document Line No.")
                {
                    ApplicationArea = all;
                }
                field("Item Charge Entry"; rec."Item Charge Entry")
                {
                    ApplicationArea = all;
                }
                field("Reverse Charge"; rec."Reverse Charge")
                {
                    ApplicationArea = all;
                }
                field("GST on Advance Payment"; rec."GST on Advance Payment")
                {
                    ApplicationArea = all;
                }
                // field("Nature of Supply"; rec."Nature of Supply")
                // {
                //     ApplicationArea = all;
                // }
                field("Payment Document No."; rec."Payment Document No.")
                {
                    ApplicationArea = all;
                }
                field("GST Exempted Goods"; rec."GST Exempted Goods")
                {
                    ApplicationArea = all;
                }
                // field("Location State Code"; rec."Location State Code")
                // {
                //     ApplicationArea = all;
                // }
                // field("Buyer/Seller State Code"; rec."Buyer/Seller State Code")
                // {
                //     ApplicationArea = all;
                // }
                // field("Shipping Address State Code"; rec."Shipping Address State Code")
                // {
                //     ApplicationArea = all;
                // }
                field("Location  Reg. No."; rec."Location  Reg. No.")
                {
                    ApplicationArea = all;
                }
                field("Buyer/Seller Reg. No."; rec."Buyer/Seller Reg. No.")
                {
                    ApplicationArea = all;
                }
                field("GST Group Type"; rec."GST Group Type")
                {
                    ApplicationArea = all;
                }
                field("GST Credit"; rec."GST Credit")
                {
                    ApplicationArea = all;
                }
                field("Reversal Entry"; rec."Reversal Entry")
                {
                    ApplicationArea = all;
                }
                field("Transaction No."; rec."Transaction No.")
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
                field("Application Doc. Type"; rec."Application Doc. Type")
                {
                    ApplicationArea = all;
                }
                field("Application Doc. No"; rec."Application Doc. No")
                {
                    ApplicationArea = all;
                }
                // field("Original Doc. Type"; rec."Original Doc. Type")
                // {
                //     ApplicationArea = all;
                // }
                // field("Original Doc. No."; rec."Original Doc. No.")
                // {
                //     ApplicationArea = all;
                // }
                field("Applied From Entry No."; rec."Applied From Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Reversed Entry No."; rec."Reversed Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Remaining Closed"; rec."Remaining Closed")
                {
                    ApplicationArea = all;
                }
                field("GST Rounding Precision"; rec."GST Rounding Precision")
                {
                    ApplicationArea = all;
                }
                field("GST Rounding Type"; rec."GST Rounding Type")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("GST Customer Type"; rec."GST Customer Type")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("GST Vendor Type"; rec."GST Vendor Type")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                // field("CLE/VLE Entry No."; rec."CLE/VLE Entry No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Bill Of Export No."; rec."Bill Of Export No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Bill Of Export Date"; rec."Bill Of Export Date")
                // {
                //     ApplicationArea = all;
                // }
                // field("e-Comm. Merchant Id"; rec."e-Comm. Merchant Id")
                // {
                //     ApplicationArea = all;
                // }
                // field("e-Comm. Operator GST Reg. No."; rec."e-Comm. Operator GST Reg. No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Invoice Type"; rec."Invoice Type")
                // {
                //     ApplicationArea = all;
                // }
                field("Original Invoice No."; rec."Original Invoice No.")
                {
                    ApplicationArea = all;
                }
                // field("Original Invoice Date"; rec."Original Invoice Date")
                // {
                //     ApplicationArea = all;
                // }
                field("Reconciliation Month"; rec."Reconciliation Month")
                {
                    ApplicationArea = all;
                }
                field("Reconciliation Year"; rec."Reconciliation Year")
                {
                    ApplicationArea = all;
                }
                field(Reconciled; rec.Reconciled)
                {
                    ApplicationArea = all;
                }
                field("Credit Availed"; rec."Credit Availed")
                {
                }
                field(Paid; rec.Paid)
                {
                    ApplicationArea = all;
                }
                // field("Amount to Customer/Vendor"; rec."Amount to Customer/Vendor")
                // {
                //     ApplicationArea = all;
                // }
                field("Credit Adjustment Type"; rec."Credit Adjustment Type")
                {
                    ApplicationArea = all;
                }
                // field("Adv. Pmt. Adjustment"; rec."Adv. Pmt. Adjustment")
                // {
                //     ApplicationArea = all;
                // }
                // field("Original Adv. Pmt Doc. No."; rec."Original Adv. Pmt Doc. No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Original Adv. Pmt Doc. Date"; rec."Original Adv. Pmt Doc. Date")
                // {
                //     ApplicationArea = all;
                // }
                // field("Payment Document Date"; rec."Payment Document Date")
                // {
                //     ApplicationArea = all;
                // }
                // field(Cess; rec.Cess)
                // {
                //     ApplicationArea = all;
                // }
                field(UnApplied; rec.UnApplied)
                {
                    ApplicationArea = all;
                }
                // field("Item Ledger Entry No."; rec."Item Ledger Entry No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Credit Reversal"; rec."Credit Reversal")
                // {
                //     ApplicationArea = all;
                // }
                field("GST Place of Supply"; rec."GST Place of Supply")
                {
                    ApplicationArea = all;
                }
                // field("Item Charge Assgn. Line No."; rec."Item Charge Assgn. Line No.")
                // {
                //     ApplicationArea = all;
                // }
                field("Payment Type"; rec."Payment Type")
                {
                    ApplicationArea = all;
                }
                field(Distributed; rec.Distributed)
                {
                    ApplicationArea = all;
                }
                field("Distributed Reversed"; rec."Distributed Reversed")
                {
                    ApplicationArea = all;
                }
                field("Input Service Distribution"; rec."Input Service Distribution")
                {
                    ApplicationArea = all;
                }
                field(Opening; rec.Opening)
                {
                    ApplicationArea = all;
                }
                // field("Remaining Amount Closed"; rec."Remaining Amount Closed")
                // {
                //     ApplicationArea = all;
                // }
                field("Remaining Base Amount"; rec."Remaining Base Amount")
                {
                    ApplicationArea = all;
                }
                field("Remaining GST Amount"; rec."Remaining GST Amount")
                {
                    ApplicationArea = all;
                }
                // field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                // {
                //     ApplicationArea = all;
                // }
                // field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                // {
                //     ApplicationArea = all;
                // }
                // field("Reason Code"; rec."Reason Code")
                // {
                //     ApplicationArea = all;
                // }
                field("Dist. Document No."; rec."Dist. Document No.")
                {
                    ApplicationArea = all;
                }
                field("Associated Enterprises"; rec."Associated Enterprises")
                {
                    ApplicationArea = all;
                }
                // field("Delivery Challan Amount"; rec."Delivery Challan Amount")
                // {
                //     ApplicationArea = all;
                // }
                field("Liable to Pay"; rec."Liable to Pay")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                // field("Subcon Document No."; rec."Subcon Document No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Last Credit Adjusted Date"; rec."Last Credit Adjusted Date")
                // {
                //     ApplicationArea = all;
                // }
                field("Dist. Input GST Credit"; rec."Dist. Input GST Credit")
                {
                    ApplicationArea = all;
                }
                // field("Component Calc. Type"; rec."Component Calc. Type")
                // {
                //     ApplicationArea = all;
                // }
                // field("Cess Amount Per Unit Factor"; rec."Cess Amount Per Unit Factor")
                // {
                //     ApplicationArea = all;
                // }
                // field("Cess UOM"; rec."Cess UOM")
                // {
                //     ApplicationArea = all;
                // }
                // field("Cess Factor Quantity"; rec."Cess Factor Quantity")
                // {
                //     ApplicationArea = all;
                // }
                field("Dist. Reverse Document No."; rec."Dist. Reverse Document No.")
                {
                    ApplicationArea = all;
                }
                // field(UOM; rec.UOM)
                // {
                //     ApplicationArea = all;
                // }
                // field("Distance in kms"; rec."Distance in kms")
                // {
                //     ApplicationArea = all;
                // }
                // field("QR Code"; rec."QR Code")
                // {
                //     ApplicationArea = all;
                // }
            }
        }
    }

    actions
    {
    }
}

