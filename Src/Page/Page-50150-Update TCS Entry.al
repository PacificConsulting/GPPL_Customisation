page 50150 "Update TCS Entry"
{
    PageType = List;
    Permissions = TableData "TCS Entry" = rm;
    SourceTable = "TCS Entry";
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
                field("TCS Amount Including Surcharge"; rec."TCS Amount Including Surcharge")
                {
                    ApplicationArea = all;
                }
                field("TCS Base Amount"; rec."TCS Base Amount")
                {
                    ApplicationArea = all;
                }
                field("Entry No."; rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                // field("Party Type"; rec."Party Type")
                // {
                //     ApplicationArea = all;
                // }
                // field("Party Code"; rec."Party Code")
                // {
                //     ApplicationArea = all;
                // }
                field("TCS Nature of Collection"; rec."TCS Nature of Collection")
                {
                    ApplicationArea = all;
                }
                field("Assessee Code"; rec."Assessee Code")
                {
                    ApplicationArea = all;
                }
                field("TCS Paid"; rec."TCS Paid")
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
                field("TCS %"; rec."TCS %")
                {
                    ApplicationArea = all;
                }
                field(Adjusted; rec.Adjusted)
                {
                    ApplicationArea = all;
                }
                field("Adjusted TCS %"; rec."Adjusted TCS %")
                {
                    ApplicationArea = all;
                }
                field("Bal. TCS Including SHE CESS"; rec."Bal. TCS Including SHE CESS")
                {
                    ApplicationArea = all;
                }
                field("Pay TCS Document No."; rec."Pay TCS Document No.")
                {
                    ApplicationArea = all;
                }
                // field("Applies To"; rec."Applies To")
                // {
                //     ApplicationArea = all;
                // }

                // field("TCS Certificate No."; rec."TCS Certificate No.")
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
                // field("Work Tax Base Amount";rec. "Work Tax Base Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Work Tax %";rec. "Work Tax %")
                // {
                //     ApplicationArea = all;
                // }
                // field("Work Tax Amount"; rec."Work Tax Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Work Tax Paid";rec. "Work Tax Paid")
                // {
                //     ApplicationArea = all;
                // }
                // field("Pay Work Tax Document No."; rec."Pay Work Tax Document No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("No. Series";rec. "No. Series")
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
                field("Rem. Total TCS Incl. SHE CESS"; rec."Rem. Total TCS Incl. SHE CESS")
                {
                    ApplicationArea = all;
                }
                field(Applied; rec.Applied)
                {
                    ApplicationArea = all;
                }
                field("TCS Amount"; rec."TCS Amount")
                {
                    ApplicationArea = all;
                }
                field("Remaining Surcharge Amount"; rec."Remaining Surcharge Amount")
                {
                    ApplicationArea = all;
                }
                field("Remaining TCS Amount"; rec."Remaining TCS Amount")
                {
                    ApplicationArea = all;
                }
                field("Adjusted Surcharge %"; rec."Adjusted Surcharge %")
                {
                    ApplicationArea = all;
                }
                // field("TCS Extra Base Amount";rec. "TCS Extra Base Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("TCS Type"; rec."TCS Type")
                // {
                //     ApplicationArea = all;
                // }
                // field("Work Tax Group";rec. "Work Tax Group")
                // {
                //     ApplicationArea = all;
                // }
                field("Surcharge Base Amount"; rec."Surcharge Base Amount")
                {
                    ApplicationArea = all;
                }
                // field("Work Tax Nature Of Collection";rec. "Work Tax Nature Of Collection")
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
                field("Total TCS Including SHE CESS"; rec."Total TCS Including SHE CESS")
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
                field("T.C.A.N. No."; rec."T.C.A.N. No.")
                {
                    ApplicationArea = all;
                }
                // field("Party Account No."; rec."Party Account No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Collection Code"; rec."Collection Code")
                // {
                //     ApplicationArea = all;
                // }
                field("BSR Code"; rec."BSR Code")
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
                // field("Party P.A.N. No."; rec."Party P.A.N. No.")
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
                field("TCS Payment Date"; rec."TCS Payment Date")
                {
                    ApplicationArea = all;
                }
                field("Challan Register Entry No."; rec."Challan Register Entry No.")
                {
                    ApplicationArea = all;
                }
                // field(Duplicate; rec.Duplicate)
                // {
                //     ApplicationArea = all;
                // }
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
                field("Original TCS Base Amount"; rec."Original TCS Base Amount")
                {
                    ApplicationArea = all;
                }
                field("TCS Base Amount Adjusted"; rec."TCS Base Amount Adjusted")
                {
                    ApplicationArea = all;
                }
                // field("Receipt Number";rec. "Receipt Number")
                // {
                //     ApplicationArea = all;
                // }
                field("Minor Head Code"; rec."Minor Head Code")
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

