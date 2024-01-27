page 50109 "Sales Order Archives Temp"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 5108;
    SourceTableView = SORTING("Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", "Line No.")
                      WHERE("Document Type" = CONST(Order));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Line No."; rec."Line No.")
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
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Posting Group"; rec."Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Quantity Disc. Code"; rec."Quantity Disc. Code")
                {
                    ApplicationArea = all;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Outstanding Quantity"; rec."Outstanding Quantity")
                {
                    ApplicationArea = all;
                }
                field("Qty. to Invoice"; rec."Qty. to Invoice")
                {
                    ApplicationArea = all;
                }
                field("Qty. to Ship"; rec."Qty. to Ship")
                {
                    ApplicationArea = all;
                }
                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = all;
                }
                field("Unit Cost (LCY)"; rec."Unit Cost (LCY)")
                {
                    ApplicationArea = all;
                }
                field("VAT %"; rec."VAT %")
                {
                    ApplicationArea = all;
                }
                field("Quantity Disc. %"; rec."Quantity Disc. %")
                {
                    ApplicationArea = all;
                }
                field("Line Discount %"; rec."Line Discount %")
                {
                    ApplicationArea = all;
                }
                field("Line Discount Amount"; rec."Line Discount Amount")
                {
                    ApplicationArea = all;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Amount Including VAT"; rec."Amount Including VAT")
                {
                    ApplicationArea = all;
                }
                field("Allow Invoice Disc."; rec."Allow Invoice Disc.")
                {
                    ApplicationArea = all;
                }
                field("Gross Weight"; rec."Gross Weight")
                {
                    ApplicationArea = all;
                }
                field("Net Weight"; rec."Net Weight")
                {
                    ApplicationArea = all;
                }
                field("Units per Parcel"; rec."Units per Parcel")
                {
                    ApplicationArea = all;
                }
                field("Unit Volume"; rec."Unit Volume")
                {
                    ApplicationArea = all;
                }
                field("Appl.-to Item Entry"; rec."Appl.-to Item Entry")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Price Group Code"; rec."Price Group Code")
                {
                    ApplicationArea = all;
                }
                field("Allow Quantity Disc."; rec."Allow Quantity Disc.")
                {
                    ApplicationArea = all;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                }
                field("Work Type Code"; rec."Work Type Code")
                {
                    ApplicationArea = all;
                }
                field("Cust./Item Disc. %"; rec."Cust./Item Disc. %")
                {
                    ApplicationArea = all;
                }
                field("Outstanding Amount"; rec."Outstanding Amount")
                {
                    ApplicationArea = all;
                }
                field("Qty. Shipped Not Invoiced"; rec."Qty. Shipped Not Invoiced")
                {
                    ApplicationArea = all;
                }
                field("Shipped Not Invoiced"; rec."Shipped Not Invoiced")
                {
                    ApplicationArea = all;
                }
                field("Quantity Shipped"; rec."Quantity Shipped")
                {
                    ApplicationArea = all;
                }
                field("Quantity Invoiced"; rec."Quantity Invoiced")
                {
                    ApplicationArea = all;
                }
                field("Shipment No."; rec."Shipment No.")
                {
                    ApplicationArea = all;
                }
                field("Shipment Line No."; rec."Shipment Line No.")
                {
                    ApplicationArea = all;
                }
                field("Profit %"; rec."Profit %")
                {
                    ApplicationArea = all;
                }
                field("Bill-to Customer No."; rec."Bill-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Inv. Discount Amount"; rec."Inv. Discount Amount")
                {
                    ApplicationArea = all;
                }
                field("Purchase Order No."; rec."Purchase Order No.")
                {
                    ApplicationArea = all;
                }
                field("Purch. Order Line No."; rec."Purch. Order Line No.")
                {
                    ApplicationArea = all;
                }
                field("Drop Shipment"; rec."Drop Shipment")
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
                field("VAT Calculation Type"; rec."VAT Calculation Type")
                {
                    ApplicationArea = all;
                }
                field("Transaction Type"; rec."Transaction Type")
                {
                    ApplicationArea = all;
                }
                field("Transport Method"; rec."Transport Method")
                {
                    ApplicationArea = all;
                }
                field("Attached to Line No."; rec."Attached to Line No.")
                {
                    ApplicationArea = all;
                }
                field("Exit Point"; rec."Exit Point")
                {
                    ApplicationArea = all;
                }
                field(Area1; rec.Area)
                {
                    ApplicationArea = all;
                }
                field("Transaction Specification"; rec."Transaction Specification")
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
                field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("VAT Prod. Posting Group"; rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field("Outstanding Amount (LCY)"; rec."Outstanding Amount (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Shipped Not Invoiced (LCY)"; rec."Shipped Not Invoiced (LCY)")
                {
                    ApplicationArea = all;
                }
                field(Reserve; rec.Reserve)
                {
                    ApplicationArea = all;
                }
                field("Blanket Order No."; rec."Blanket Order No.")
                {
                    ApplicationArea = all;
                }
                field("Blanket Order Line No."; rec."Blanket Order Line No.")
                {
                    ApplicationArea = all;
                }
                field("VAT Base Amount"; rec."VAT Base Amount")
                {
                    ApplicationArea = all;
                }
                field("Unit Cost"; rec."Unit Cost")
                {
                    ApplicationArea = all;
                }
                field("System-Created Entry"; rec."System-Created Entry")
                {
                    ApplicationArea = all;
                }
                field("Line Amount"; rec."Line Amount")
                {
                    ApplicationArea = all;
                }
                field("VAT Difference"; rec."VAT Difference")
                {
                    ApplicationArea = all;
                }
                field("Inv. Disc. Amount to Invoice"; rec."Inv. Disc. Amount to Invoice")
                {
                    ApplicationArea = all;
                }
                field("VAT Identifier"; rec."VAT Identifier")
                {
                    ApplicationArea = all;
                }
                field("IC Partner Ref. Type"; rec."IC Partner Ref. Type")
                {
                    ApplicationArea = all;
                }
                field("IC Partner Reference"; rec."IC Partner Reference")
                {
                    ApplicationArea = all;
                }
                field("Prepayment %"; rec."Prepayment %")
                {
                    ApplicationArea = all;
                }
                field("Prepmt. Line Amount"; rec."Prepmt. Line Amount")
                {
                    ApplicationArea = all;
                }
                field("Prepmt. Amt. Inv."; rec."Prepmt. Amt. Inv.")
                {
                    ApplicationArea = all;
                }
                field("Prepmt. Amt. Incl. VAT"; rec."Prepmt. Amt. Incl. VAT")
                {
                    ApplicationArea = all;
                }
                field("Prepayment Amount"; rec."Prepayment Amount")
                {
                    ApplicationArea = all;
                }
                field("Prepmt. VAT Base Amt."; rec."Prepmt. VAT Base Amt.")
                {
                    ApplicationArea = all;
                }
                field("Prepayment VAT %"; rec."Prepayment VAT %")
                {
                    ApplicationArea = all;
                }
                field("Prepmt. VAT Calc. Type"; rec."Prepmt. VAT Calc. Type")
                {
                    ApplicationArea = all;
                }
                field("Prepayment VAT Identifier"; rec."Prepayment VAT Identifier")
                {
                    ApplicationArea = all;
                }
                field("Prepayment Tax Area Code"; rec."Prepayment Tax Area Code")
                {
                    ApplicationArea = all;
                }
                field("Prepayment Tax Liable"; rec."Prepayment Tax Liable")
                {
                    ApplicationArea = all;
                }
                field("Prepayment Tax Group Code"; rec."Prepayment Tax Group Code")
                {
                    ApplicationArea = all;
                }
                field("Prepmt Amt to Deduct"; rec."Prepmt Amt to Deduct")
                {
                    ApplicationArea = all;
                }
                field("Prepmt Amt Deducted"; rec."Prepmt Amt Deducted")
                {
                    ApplicationArea = all;
                }
                field("Prepayment Line"; rec."Prepayment Line")
                {
                    ApplicationArea = all;
                }
                field("Prepmt. Amount Inv. Incl. VAT"; rec."Prepmt. Amount Inv. Incl. VAT")
                {
                    ApplicationArea = all;
                }
                field("IC Partner Code"; rec."IC Partner Code")
                {
                    ApplicationArea = all;
                }
                field("Dimension Set ID"; rec."Dimension Set ID")
                {
                    ApplicationArea = all;
                }
                field("Deferral Code"; rec."Deferral Code")
                {
                    ApplicationArea = all;
                }
                field("Returns Deferral Start Date"; rec."Returns Deferral Start Date")
                {
                    ApplicationArea = all;
                }
                field("Version No."; rec."Version No.")
                {
                    ApplicationArea = all;
                }
                field("Doc. No. Occurrence"; rec."Doc. No. Occurrence")
                {
                    ApplicationArea = all;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    ApplicationArea = all;
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field(Planned; rec.Planned)
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Quantity (Base)"; rec."Quantity (Base)")
                {
                    ApplicationArea = all;
                }
                field("Outstanding Qty. (Base)"; rec."Outstanding Qty. (Base)")
                {
                    ApplicationArea = all;
                }
                field("Qty. to Invoice (Base)"; rec."Qty. to Invoice (Base)")
                {
                    ApplicationArea = all;
                }
                field("Qty. to Ship (Base)"; rec."Qty. to Ship (Base)")
                {
                    ApplicationArea = all;
                }
                field("Qty. Shipped Not Invd. (Base)"; rec."Qty. Shipped Not Invd. (Base)")
                {
                    ApplicationArea = all;
                }
                field("Qty. Shipped (Base)"; rec."Qty. Shipped (Base)")
                {
                    ApplicationArea = all;
                }
                field("Qty. Invoiced (Base)"; rec."Qty. Invoiced (Base)")
                {
                    ApplicationArea = all;
                }
                field("FA Posting Date"; rec."FA Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Depreciation Book Code"; rec."Depreciation Book Code")
                {
                    ApplicationArea = all;
                }
                field("Depr. until FA Posting Date"; rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Duplicate in Depreciation Book"; rec."Duplicate in Depreciation Book")
                {
                    ApplicationArea = all;
                }
                field("Use Duplication List"; rec."Use Duplication List")
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field("Out-of-Stock Substitution"; rec."Out-of-Stock Substitution")
                {
                    ApplicationArea = all;
                }
                field("Substitution Available"; rec."Substitution Available")
                {
                    ApplicationArea = all;
                }
                field("Originally Ordered No."; rec."Originally Ordered No.")
                {
                    ApplicationArea = all;
                }
                field("Originally Ordered Var. Code"; rec."Originally Ordered Var. Code")
                {
                    ApplicationArea = all;
                }
                // field("Cross-Reference No.";rec. "Cross-Reference No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Unit of Measure (Cross Ref.)"; rec."Unit of Measure (Cross Ref.)")
                // {
                //     ApplicationArea = all;
                // }
                // field("Cross-Reference Type";rec. "Cross-Reference Type")
                // {
                //     ApplicationArea = all;
                // }
                // field("Cross-Reference Type No.";rec. "Cross-Reference Type No.")
                // {
                //     ApplicationArea = all;
                // }
                field("Item Category Code"; rec."Item Category Code")
                {
                    ApplicationArea = all;
                }
                field(Nonstock; rec.Nonstock)
                {
                    ApplicationArea = all;
                }
                field("Purchasing Code"; rec."Purchasing Code")
                {
                    ApplicationArea = all;
                }
                // field("Product Group Code"; rec."Product Group Code")
                // {
                //     ApplicationArea = all;
                // }
                field("Special Order"; rec."Special Order")
                {
                    ApplicationArea = all;
                }
                field("Special Order Purchase No."; rec."Special Order Purchase No.")
                {
                    ApplicationArea = all;
                }
                field("Special Order Purch. Line No."; rec."Special Order Purch. Line No.")
                {
                    ApplicationArea = all;
                }
                field("Completely Shipped"; rec."Completely Shipped")
                {
                    ApplicationArea = all;
                }
                field("Requested Delivery Date"; rec."Requested Delivery Date")
                {
                    ApplicationArea = all;
                }
                field("Promised Delivery Date"; rec."Promised Delivery Date")
                {
                    ApplicationArea = all;
                }
                field("Shipping Time"; rec."Shipping Time")
                {
                    ApplicationArea = all;
                }
                field("Outbound Whse. Handling Time"; rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = all;
                }
                field("Planned Delivery Date"; rec."Planned Delivery Date")
                {
                    ApplicationArea = all;
                }
                field("Planned Shipment Date"; rec."Planned Shipment Date")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Service Code"; rec."Shipping Agent Service Code")
                {
                    ApplicationArea = all;
                }
                field("Allow Item Charge Assignment"; rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = all;
                }
                field("Return Qty. to Receive"; rec."Return Qty. to Receive")
                {
                    ApplicationArea = all;
                }
                field("Return Qty. to Receive (Base)"; rec."Return Qty. to Receive (Base)")
                {
                    ApplicationArea = all;
                }
                field("Return Qty. Rcd. Not Invd."; rec."Return Qty. Rcd. Not Invd.")
                {
                    ApplicationArea = all;
                }
                field("Ret. Qty. Rcd. Not Invd.(Base)"; rec."Ret. Qty. Rcd. Not Invd.(Base)")
                {
                    ApplicationArea = all;
                }
                field("Return Amt. Rcd. Not Invd."; rec."Return Amt. Rcd. Not Invd.")
                {
                    ApplicationArea = all;
                }
                field("Ret. Amt. Rcd. Not Invd. (LCY)"; rec."Ret. Amt. Rcd. Not Invd. (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Return Qty. Received"; rec."Return Qty. Received")
                {
                    ApplicationArea = all;
                }
                field("Return Qty. Received (Base)"; rec."Return Qty. Received (Base)")
                {
                    ApplicationArea = all;
                }
                field("Appl.-from Item Entry"; rec."Appl.-from Item Entry")
                {
                    ApplicationArea = all;
                }
                field("Service Contract No."; rec."Service Contract No.")
                {
                    ApplicationArea = all;
                }
                field("Service Order No."; rec."Service Order No.")
                {
                    ApplicationArea = all;
                }
                field("Service Item No."; rec."Service Item No.")
                {
                    ApplicationArea = all;
                }
                field("Appl.-to Service Entry"; rec."Appl.-to Service Entry")
                {
                    ApplicationArea = all;
                }
                field("Service Item Line No."; rec."Service Item Line No.")
                {
                    ApplicationArea = all;
                }
                field("Serv. Price Adjmt. Gr. Code"; rec."Serv. Price Adjmt. Gr. Code")
                {
                    ApplicationArea = all;
                }
                field("BOM Item No."; rec."BOM Item No.")
                {
                    ApplicationArea = all;
                }
                field("Return Receipt No."; rec."Return Receipt No.")
                {
                    ApplicationArea = all;
                }
                field("Return Receipt Line No."; rec."Return Receipt Line No.")
                {
                    ApplicationArea = all;
                }
                field("Return Reason Code"; rec."Return Reason Code")
                {
                    ApplicationArea = all;
                }
                field("Allow Line Disc."; rec."Allow Line Disc.")
                {
                    ApplicationArea = all;
                }
                field("Customer Disc. Group"; rec."Customer Disc. Group")
                {
                    ApplicationArea = all;
                }
                // field("Tax Amount"; rec."Tax Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Bus. Posting Group"; rec."Excise Bus. Posting Group")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Prod. Posting Group"; rec."Excise Prod. Posting Group")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Amount"; rec."Excise Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Amount Including Excise"; rec."Amount Including Excise")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Base Amount";rec. "Excise Base Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Accounting Type"; rec."Excise Accounting Type")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Base Quantity"; rec."Excise Base Quantity")
                // {
                //     ApplicationArea = all;
                // }
                // field("Tax %";rec. "Tax %")
                // {
                //     ApplicationArea = all;
                // }
                // field("Amount Including Tax"; rec."Amount Including Tax")
                // {
                //     ApplicationArea = all;
                // }
                // field("Amount Added to Excise Base";rec. "Amount Added to Excise Base")
                // {
                //     ApplicationArea = all;
                // }
                // field("Amount Added to Tax Base"; rec."Amount Added to Tax Base")
                // {
                //     ApplicationArea = all;
                // }
                // field("Tax Base Amount"; rec."Tax Base Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Surcharge %";rec. "Surcharge %")
                // {
                //     ApplicationArea = all;
                // }
                // field("Surcharge Amount";rec. "Surcharge Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Concessional Code"; rec."Concessional Code")
                // {
                //     ApplicationArea = all;
                // }
                // field("Assessee Code"; rec."Assessee Code")
                // {
                //     ApplicationArea = all;
                // }
                // field("TDS %"; rec."TDS %")
                // {
                //     ApplicationArea = all;
                // }
                // field("Bal. TDS Including SHE CESS"; rec."Bal. TDS Including SHE CESS")
                // {
                //     ApplicationArea = all;
                // }
                // field("Claim Deferred Excise"; rec."Claim Deferred Excise")
                // {
                //     ApplicationArea = all;
                // }
                // field("Capital Item"; rec."Capital Item")
                // {
                //     ApplicationArea = all;
                // }
                // field("BED Amount"; rec."BED Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("AED(GSI) Amount"; rec."AED(GSI) Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("SED Amount";rec. "SED Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("SAED Amount"; rec."SAED Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("CESS Amount"; rec."CESS Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("NCCD Amount"; rec."NCCD Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("eCess Amount";rec. "eCess Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Form Code";rec. "Form Code")
                // {
                //     ApplicationArea = all;
                // }
                // field("Form No."; rec."Form No.")
                // {
                //     ApplicationArea = all;
                // }
                // field(State; rec.State)
                // {
                //     ApplicationArea = all;
                // }
                // field("TDS Amount"; rec."TDS Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Amount To Customer"; rec."Amount To Customer")
                // {
                //     ApplicationArea = all;
                // }
                // field("Charges To Customer"; "Charges To Customer")
                // {
                //     ApplicationArea = all;
                // }
                // field("TDS Base Amount";rec. "TDS Base Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Surcharge Base Amount";rec. "Surcharge Base Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Temp TDS Base"; rec."Temp TDS Base")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax Group"; rec."Service Tax Group")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax Base";rec. "Service Tax Base")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax Amount"; rec."Service Tax Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax Registration No."; rec."Service Tax Registration No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("eCESS % on TDS"; rec."eCESS % on TDS")
                // {
                //     ApplicationArea = all;
                // }
                // field("eCESS on TDS Amount"; rec."eCESS on TDS Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Total TDS Including SHE CESS"; rec."Total TDS Including SHE CESS")
                // {
                //     ApplicationArea = all;
                // }
                // field("Per Contract"; rec."Per Contract")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax eCess Amount";rec. "Service Tax eCess Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("ADET Amount"; rec."ADET Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("AED(TTA) Amount";rec. "AED(TTA) Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Free Supply";rec. "Free Supply")
                // {
                //     ApplicationArea = all;
                // }
                // field("ADE Amount";rec. "ADE Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Assessable Value";rec. "Assessable Value")
                // {
                //     ApplicationArea = all;
                // }
                // field("SHE Cess Amount";rec. "SHE Cess Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax SHE Cess Amount"; rec."Service Tax SHE Cess Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Direct Debit To PLA / RG";rec. "Direct Debit To PLA / RG")
                // {
                //     ApplicationArea = all;
                // }
                // field(Supplementary; rec.Supplementary)
                // {
                //     ApplicationArea = all;
                // }
                // field("Source Document Type"; rec."Source Document Type")
                // {
                //     ApplicationArea = all;
                // }
                // field("Source Document No.";rec. "Source Document No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Process Carried Out"; rec."Process Carried Out")
                // {
                //     ApplicationArea = all;
                // }
                // field("Identification Mark"; rec."Identification Mark")
                // {
                //     ApplicationArea = all;
                // }
                // field("Re-Dispatch";rec. "Re-Dispatch")
                // {
                //     ApplicationArea = all;
                // }
                // field("Return Rcpt line No.";rec. "Return Rcpt line No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Qty. to be Re-Dispatched"; rec."Qty. to be Re-Dispatched")
                // {
                //     ApplicationArea = all;
                // }
                // field("Return Re-Dispatch Rcpt. No."; rec."Return Re-Dispatch Rcpt. No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("SHE Cess % on TDS/TCS";rec. "SHE Cess % on TDS/TCS")
                // {
                //     ApplicationArea = all;
                // }
                // field("SHE Cess on TDS/TCS Amount"; rec."SHE Cess on TDS/TCS Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("MRP Price";rec. "MRP Price")
                // {
                //     ApplicationArea = all;
                // }
                // field(MRP; rec.MRP)
                // {
                //     ApplicationArea = all;
                // }
                // field("Abatement %"; rec."Abatement %")
                // {
                //     ApplicationArea = all;
                // }
                // field("PIT Structure";rec. "PIT Structure")
                // {
                //     ApplicationArea = all;
                // }
                // field("Price Inclusive of Tax"; rec."Price Inclusive of Tax")
                // {
                //     ApplicationArea = all;
                // }
                // field("Unit Price Incl. of Tax"; rec."Unit Price Incl. of Tax")
                // {
                //     ApplicationArea = all;
                // }
                // field("Amount To Customer UPIT";rec. "Amount To Customer UPIT")
                // {
                //     ApplicationArea = all;
                // }
                // field("UPIT Rounding Inserted"; rec."UPIT Rounding Inserted")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Effective Rate"; rec."Excise Effective Rate")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax SBC %"; rec."Service Tax SBC %")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax SBC Amount";rec. "Service Tax SBC Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax SBC Amount (Intm)"; rec."Service Tax SBC Amount (Intm)")
                // {
                //     ApplicationArea = all;
                // }
                // field("KK Cess%"; rec."KK Cess%")
                // {
                //     ApplicationArea = all;
                // }
                // field("KK Cess Amount";rec. "KK Cess Amount")
                // {
                //     ApplicationArea = all;
                // }
                field("GST Place of Supply"; rec."GST Place of Supply")
                {
                    ApplicationArea = all;
                }
                field("GST Group Code"; rec."GST Group Code")
                {
                    ApplicationArea = all;
                }
                field("GST Group Type"; rec."GST Group Type")
                {
                    ApplicationArea = all;
                }
                // field("GST Base Amount"; rec."GST Base Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("GST %"; rec."GST %")
                // {
                //     ApplicationArea = all;
                // }
                // field("Total GST Amount";rec. "Total GST Amount")
                // {
                //     ApplicationArea = all;
                // }
                field("HSN/SAC Code"; rec."HSN/SAC Code")
                {
                    ApplicationArea = all;
                }
                field("GST Jurisdiction Type"; rec."GST Jurisdiction Type")
                {
                    ApplicationArea = all;
                }
                field("Invoice Type"; rec."Invoice Type")
                {
                    ApplicationArea = all;
                }
                field(Exempted; rec.Exempted)
                {
                    ApplicationArea = all;
                }
                field("National Discount"; rec."National Discount")
                {
                    ApplicationArea = all;
                }
                field("Free of Cost"; rec."Free of Cost")
                {
                    ApplicationArea = all;
                }
                field("Basic Price"; rec."Basic Price")
                {
                    ApplicationArea = all;
                }
                field("Freight/Other Chgs. Primary"; rec."Freight/Other Chgs. Primary")
                {
                    ApplicationArea = all;
                }
                field("Freight/Other Chgs. Secondary"; rec."Freight/Other Chgs. Secondary")
                {
                    ApplicationArea = all;
                }
                field("Price Support"; rec."Price Support")
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

