page 50172 "TDS Entry Update"
{
    PageType = List;
    Permissions = TableData "TDS Entry" = rm;
    SourceTable = "TDS Entry";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Type"; rec."Account Type")
                {
                    ApplicationArea = all;
                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                // field(Description; rec.Description)
                // {
                //     ApplicationArea = all;
                // }
                field("TDS Amount Including Surcharge"; rec."TDS Amount Including Surcharge")
                {
                    ApplicationArea = all;
                }
                field("TDS Base Amount"; rec."TDS Base Amount")
                {
                    ApplicationArea = all;
                }
                // field("Base Includes Service Tax"; rec."Base Includes Service Tax")
                // {
                //     ApplicationArea = all;
                // }
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Party Type"; rec."Party Type")
                {
                    ApplicationArea = all;
                }
                field("Party Code"; rec."Party Code")
                {
                    ApplicationArea = all;
                }
                // field("TDS Nature of Deduction"; rec."TDS Nature of Deduction")
                // {
                //     ApplicationArea = all;
                // }
                field("Assessee Code"; rec."Assessee Code")
                {
                    ApplicationArea = all;
                }
                field("TDS Paid"; rec."TDS Paid")
                {
                    ApplicationArea = all;
                }
                // field("Applied To"; rec."Applied To")
                // {
                //     ApplicationArea = all;
                // }
                field("Challan Date"; rec."Challan Date")
                {
                    ApplicationArea = all;
                }
                field("Challan No."; rec."Challan No.")
                {
                    ApplicationArea = all;
                }
                field("Bank Name"; rec."Bank Name")
                {
                    ApplicationArea = all;
                }
                field("TDS %"; rec."TDS %")
                {
                    ApplicationArea = all;
                }
                field(Adjusted; rec.Adjusted)
                {
                    ApplicationArea = all;
                }
                field("Adjusted TDS %"; rec."Adjusted TDS %")
                {
                    ApplicationArea = all;
                }
                field("Bal. TDS Including SHE CESS"; rec."Bal. TDS Including SHE CESS")
                {
                    ApplicationArea = all;
                }
                field("Pay TDS Document No."; rec."Pay TDS Document No.")
                {
                    ApplicationArea = all;
                }
                // field("Applies To"; rec."Applies To")
                // {
                //     ApplicationArea = all;
                // }
                // field("TDS Category"; rec."TDS Category")
                // {
                //     ApplicationArea = all;
                // }
                // field("TDS Certificate No."; rec."TDS Certificate No.")
                // {
                //     ApplicationArea = all;
                // }
                field("Surcharge %"; rec."Surcharge %")
                {
                    ApplicationArea = all;
                }
                field("Surcharge Amount"; rec."Surcharge Amount")
                {
                    ApplicationArea = all;
                }
                // field("No. Printed"; rec."No. Printed")
                // {
                //     ApplicationArea = all;
                // }
                field("Concessional Code"; rec."Concessional Code")
                {
                    ApplicationArea = all;
                }
                // field("Concessional Form"; rec."Concessional Form")
                // {
                //     ApplicationArea = all;
                // }
                // field("Work Tax Base Amount"; rec."Work Tax Base Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Work Tax %"; rec."Work Tax %")
                // {
                //     ApplicationArea = all;
                // }
                // field("Work Tax Amount"; rec."Work Tax Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Return Type"; rec."Return Type")
                // {
                //     ApplicationArea = all;
                // }
                // field("Work Tax Paid"; rec."Work Tax Paid")
                // {
                //     ApplicationArea = all;
                // }
                // field("Pay Work Tax Document No."; rec."Pay Work Tax Document No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("No. Series"; rec."No. Series")
                // {
                //     ApplicationArea = all;
                // }
                // field("Certificate Period"; rec."Certificate Period")
                // {
                //     ApplicationArea = all;
                // }
                // field("Balance Work Tax Amount"; rec."Balance Work Tax Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Work Tax Account"; rec."Work Tax Account")
                // {
                //     ApplicationArea = all;
                // }
                field("Invoice Amount"; rec."Invoice Amount")
                {
                    ApplicationArea = all;
                }
                // field("Certificate Date"; rec."Certificate Date")
                // {
                //     ApplicationArea = all;
                // }
                // field("Rem. Total TDS Incl. SHE CESS"; rec."Rem. Total TDS Incl. SHE CESS")
                // {
                //     ApplicationArea = all;
                // }
                field(Applied; rec.Applied)
                {
                    ApplicationArea = all;
                }
                field("TDS Amount"; rec."TDS Amount")
                {
                    ApplicationArea = all;
                }
                field("Remaining Surcharge Amount"; rec."Remaining Surcharge Amount")
                {
                    ApplicationArea = all;
                }
                field("Remaining TDS Amount"; rec."Remaining TDS Amount")
                {
                    ApplicationArea = all;
                }
                field("Adjusted Surcharge %"; rec."Adjusted Surcharge %")
                {
                    ApplicationArea = all;
                }
                // field("TDS Extra Base Amount"; rec."TDS Extra Base Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("TDS Group"; rec."TDS Group")
                // {
                //     ApplicationArea = all;
                // }
                // field("Work Tax Group"; rec."Work Tax Group")
                // {
                //     ApplicationArea = all;
                // }
                field("Surcharge Base Amount"; rec."Surcharge Base Amount")
                {
                    ApplicationArea = all;
                }
                // field("Work Tax Nature Of Deduction"; rec."Work Tax Nature Of Deduction")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax Including eCess"; rec."Service Tax Including eCess")
                // {
                //     ApplicationArea = all;
                // }
                field("eCESS %"; rec."eCESS %")
                {
                    ApplicationArea = all;
                }
                field("eCESS Amount"; rec."eCESS Amount")
                {
                    ApplicationArea = all;
                }
                field("Total TDS Including SHE CESS"; rec."Total TDS Including SHE CESS")
                {
                    ApplicationArea = all;
                }
                field("Adjusted eCESS %"; rec."Adjusted eCESS %")
                {
                    ApplicationArea = all;
                }
                field("Per Contract"; rec."Per Contract")
                {
                    ApplicationArea = all;
                }
                field("T.A.N. No."; rec."T.A.N. No.")
                {
                    ApplicationArea = all;
                }
                field("Party Account No."; rec."Party Account No.")
                {
                    ApplicationArea = all;
                }
                // field("TDS Section"; rec."TDS Section")
                // {
                //     ApplicationArea = all;
                // }
                field("BSR Code"; rec."BSR Code")
                {
                    ApplicationArea = all;
                }
                field("Non Resident Payments"; rec."Non Resident Payments")
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
                field("User ID"; rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Source Code"; rec."Source Code")
                {
                    ApplicationArea = all;
                }
                field("Transaction No."; rec."Transaction No.")
                {
                    ApplicationArea = all;
                }
                // field("Deductee P.A.N. No."; rec."Deductee P.A.N. No.")
                // {
                //     ApplicationArea = all;
                // }
                field("Check/DD No."; rec."Check/DD No.")
                {
                    ApplicationArea = all;
                }
                field("Check Date"; rec."Check Date")
                {
                    ApplicationArea = all;
                }
                field("TDS Payment Date"; rec."TDS Payment Date")
                {
                    ApplicationArea = all;
                }
                field("Challan Register Entry No."; rec."Challan Register Entry No.")
                {
                    ApplicationArea = all;
                }
                field("SHE Cess %"; rec."SHE Cess %")
                {
                    ApplicationArea = all;
                }
                field("SHE Cess Amount"; rec."SHE Cess Amount")
                {
                    ApplicationArea = all;
                }
                field("Adjusted SHE CESS %"; rec."Adjusted SHE CESS %")
                {
                    ApplicationArea = all;
                }
                // field("Adjusted Work Tax %"; rec."Adjusted Work Tax %")
                // {
                //     ApplicationArea = all;
                // }
                field("Original TDS Base Amount"; rec."Original TDS Base Amount")
                {
                    ApplicationArea = all;
                }
                field("TDS Base Amount Adjusted"; rec."TDS Base Amount Adjusted")
                {
                    ApplicationArea = all;
                }
                // field("Original Work Tax Base Amount"; rec."Original Work Tax Base Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Work Tax Base Amount Adjusted"; rec."Work Tax Base Amount Adjusted")
                // {
                //     ApplicationArea = all;
                // }
                // field("Receipt Number"; rec."Receipt Number")
                // {
                //     ApplicationArea = all;
                // }
                field("TDS Line Amount"; rec."TDS Line Amount")
                {
                    ApplicationArea = all;
                }
                field("NIL Challan Indicator"; rec."NIL Challan Indicator")
                {
                    ApplicationArea = all;
                }
                field("Minor Head Code"; rec."Minor Head Code")
                {
                    ApplicationArea = all;
                }
                field("Nature of Remittance"; rec."Nature of Remittance")
                {
                    ApplicationArea = all;
                }
                field("Act Applicable"; rec."Act Applicable")
                {
                    ApplicationArea = all;
                }
                field("Country Code"; rec."Country Code")
                {
                    ApplicationArea = all;
                }
                // field("Party Name"; rec."Party Name")
                // {
                //     ApplicationArea = all;
                // }
                // field("Receipt Number 1"; rec."Receipt Number 1")
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

