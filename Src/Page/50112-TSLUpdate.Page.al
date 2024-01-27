page 50112 TSL_Update
{
    PageType = List;
    Permissions = TableData 5745 = rimd;
    SourceTable = 5745;
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
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
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Inventory Posting Group"; rec."Inventory Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Quantity (Base)"; rec."Quantity (Base)")
                {
                    ApplicationArea = all;
                }
                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
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
                field("Unit Volume"; rec."Unit Volume")
                {
                    ApplicationArea = all;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                }
                field("Units per Parcel"; rec."Units per Parcel")
                {
                    ApplicationArea = all;
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = all;
                }
                field("Transfer Order No."; rec."Transfer Order No.")
                {
                    ApplicationArea = all;
                }
                field("Shipment Date"; rec."Shipment Date")
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
                field("In-Transit Code"; rec."In-Transit Code")
                {
                    ApplicationArea = all;
                }
                field("Transfer-from Code"; rec."Transfer-from Code")
                {
                    ApplicationArea = all;
                }
                field("Transfer-to Code"; rec."Transfer-to Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item Shpt. Entry No."; rec."Item Shpt. Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Shipping Time"; rec."Shipping Time")
                {
                    ApplicationArea = all;
                }
                field("Dimension Set ID"; rec."Dimension Set ID")
                {
                    ApplicationArea = all;
                }
                field("Item Category Code"; rec."Item Category Code")
                {
                    ApplicationArea = all;
                }
                // field("Product Group Code"; rec."Product Group Code")
                // {
                //     ApplicationArea = all;
                // }
                field("Transfer-from Bin Code"; rec."Transfer-from Bin Code")
                {
                    ApplicationArea = all;
                }
                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = all;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                // field("BED Amount"; rec."BED Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("AED(GSI) Amount"; rec."AED(GSI) Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("SED Amount"; rec."SED Amount")
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
                // field("eCess Amount"; rec."eCess Amount")
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
                // field("Excise Accounting Type"; rec."Excise Accounting Type")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Prod. Posting Group"; rec."Excise Prod. Posting Group")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Bus. Posting Group"; rec."Excise Bus. Posting Group")
                // {
                //     ApplicationArea = all;
                // }
                // field("Capital Item"; rec."Capital Item")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Base Quantity"; rec."Excise Base Quantity")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Base Amount"; rec."Excise Base Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Amount Added to Excise Base"; rec."Amount Added to Excise Base")
                // {
                //     ApplicationArea = all;
                // }
                // field("Amount Added to Inventory"; rec."Amount Added to Inventory")
                // {
                //     ApplicationArea = all;
                // }
                // field("Charges to Transfer"; rec."Charges to Transfer")
                // {
                //     ApplicationArea = all;
                // }
                // field("Total Amount to Transfer"; rec."Total Amount to Transfer")
                // {
                //     ApplicationArea = all;
                // }
                // field("Claim Deferred Excise"; rec."Claim Deferred Excise")
                // {
                //     ApplicationArea = all;
                // }
                // field("Unit Cost"; rec."Unit Cost")
                // {
                //     ApplicationArea = all;
                // }
                // field("ADET Amount"; rec."ADET Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("AED(TTA) Amount"; rec."AED(TTA) Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("ADE Amount"; rec."ADE Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Assessable Value"; rec."Assessable Value")
                // {
                //     ApplicationArea = all;
                // }
                // field("SHE Cess Amount"; rec."SHE Cess Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("ADC VAT Amount"; rec."ADC VAT Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("CIF Amount"; rec."CIF Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("BCD Amount"; rec."BCD Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field(CVD; rec.CVD)
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Loading on Inventory"; rec."Excise Loading on Inventory")
                // {
                //     ApplicationArea = all;
                // }
                // field("Captive Consumption %"; rec."Captive Consumption %")
                // {
                //     ApplicationArea = all;
                // }
                // field("Admin. Cost %"; rec."Admin. Cost %")
                // {
                //     ApplicationArea = all;
                // }
                // field("MRP Price"; rec."MRP Price")
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
                // field("Applies-to Entry (RG 23 D)"; rec."Applies-to Entry (RG 23 D)")
                // {
                //     ApplicationArea = all;
                // }
                // field("Cost of Production"; rec."Cost of Production")
                // {
                //     ApplicationArea = all;
                // }
                // field("Cost Of Prod. Incl. Admin Cost"; rec."Cost Of Prod. Incl. Admin Cost")
                // {
                //     ApplicationArea = all;
                // }
                // field("Custom eCess Amount"; rec."Custom eCess Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Custom SHECess Amount"; rec."Custom SHECess Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Effective Rate"; rec."Excise Effective Rate")
                // {
                //     ApplicationArea = all;
                // }
                // field("GST Base Amount"; rec."GST Base Amount")
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                // }
                // field("GST %"; rec."GST %")
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                // }
                // field("Total GST Amount"; rec."Total GST Amount")
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                // }
                field("GST Group Code"; rec."GST Group Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("HSN/SAC Code"; rec."HSN/SAC Code")
                {
                    ApplicationArea = all;
                }
                field("GST Credit"; rec."GST Credit")
                {
                    ApplicationArea = all;
                }
                // field("Transfer Indent No."; rec."Transfer Indent No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Transfer Indent Line No."; rec."Transfer Indent Line No.")
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

