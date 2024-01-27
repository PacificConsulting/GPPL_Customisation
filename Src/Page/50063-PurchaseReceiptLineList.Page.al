page 50063 "Purchase Receipt Line List"
{
    PageType = List;
    Permissions = TableData 121 = rimd;
    SourceTable = 121;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Buy From Party Name"; "Buy From Party Name")
                {
                    ApplicationArea = all;
                    Caption = 'Buy From Party Name';
                }
                field("Sales Order No."; rec."Sales Order No.")
                {
                    ApplicationArea = all;
                }
                field("Sales Order Line No."; rec."Sales Order Line No.")
                {
                    ApplicationArea = all;
                }
                field("VAT Calculation Type"; rec."VAT Calculation Type")
                {
                    ApplicationArea = all;
                }
                field("Transport Method"; rec."Transport Method")
                {
                    ApplicationArea = all;
                }
                field("Use Tax"; rec."Use Tax")
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
                field("Quantity (Base)"; rec."Quantity (Base)")
                {
                    ApplicationArea = all;
                }
                field("FA Posting Date"; rec."FA Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Qty. Invoiced (Base)"; rec."Qty. Invoiced (Base)")
                {
                    ApplicationArea = all;
                }
                field("FA Posting Type"; rec."FA Posting Type")
                {
                    ApplicationArea = all;
                }
                field("Depreciation Book Code"; rec."Depreciation Book Code")
                {
                    ApplicationArea = all;
                }
                field("Salvage Value"; rec."Salvage Value")
                {
                    ApplicationArea = all;
                }
                field("Depr. until FA Posting Date"; rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Depr. Acquisition Cost"; rec."Depr. Acquisition Cost")
                {
                    ApplicationArea = all;
                }
                field("Maintenance Code"; rec."Maintenance Code")
                {
                    ApplicationArea = all;
                }
                field("Insurance No."; rec."Insurance No.")
                {
                    ApplicationArea = all;
                }
                field("Budgeted FA No."; rec."Budgeted FA No.")
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
                // field("Cross-Reference No."; rec."Cross-Reference No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Unit of Measure (Cross Ref.)"; rec."Unit of Measure (Cross Ref.)")
                // {
                //     ApplicationArea = all;
                // }
                // field("Cross-Reference Type"; rec."Cross-Reference Type")
                // {
                //     ApplicationArea = all;
                // }
                // field("Cross-Reference Type No."; rec."Cross-Reference Type No.")
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
                field("Special Order Sales No."; rec."Special Order Sales No.")
                {
                    ApplicationArea = all;
                }
                field("Special Order Sales Line No."; rec."Special Order Sales Line No.")
                {
                    ApplicationArea = all;
                }
                field("Requested Receipt Date"; rec."Requested Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Promised Receipt Date"; rec."Promised Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Lead Time Calculation"; rec."Lead Time Calculation")
                {
                    ApplicationArea = all;
                }
                field("Inbound Whse. Handling Time"; rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = all;
                }
                field("Planned Receipt Date"; rec."Planned Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Order Date"; rec."Order Date")
                {
                    ApplicationArea = all;
                }
                field("Item Charge Base Amount"; rec."Item Charge Base Amount")
                {
                    ApplicationArea = all;
                }
                field(Correction; rec.Correction)
                {
                    ApplicationArea = all;
                }
                field("Return Reason Code"; rec."Return Reason Code")
                {
                    ApplicationArea = all;
                }
                // field("Tax %"; rec."Tax %")
                // {
                //     ApplicationArea = all;
                // }
                // field("Form Code"; rec."Form Code")
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
                // field("Excise Bus. Posting Group"; rec."Excise Bus. Posting Group")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Prod. Posting Group"; rec."Excise Prod. Posting Group")
                // {
                //     ApplicationArea = all;
                // }
                // field("Amount Including Excise"; rec."Amount Including Excise")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Amount"; rec."Excise Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Base Quantity"; rec."Excise Base Quantity")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Accounting Type"; rec."Excise Accounting Type")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Base Amount"; rec."Excise Base Amount")
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
                // field("Claim VAT"; rec."Claim VAT")
                // {
                //     ApplicationArea = all;
                // }
                // field("Refund VAT"; rec."Refund VAT")
                // {
                //     ApplicationArea = all;
                // }
                // field("Consume VAT"; rec."Consume VAT")
                // {
                //     ApplicationArea = all;
                // }
                // field("Reverse VAT"; rec."Reverse VAT")
                // {
                //     ApplicationArea = all;
                // }
                // field("Set Off Available"; rec."Set Off Available")
                // {
                //     ApplicationArea = all;
                // }
                // field("Vendor Shipment No."; rec."Vendor Shipment No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax Group"; rec."Service Tax Group")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax %"; rec."Service Tax %")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax eCess %"; rec."Service Tax eCess %")
                // {
                //     ApplicationArea = all;
                // }
                // field("RG Record Type"; rec."RG Record Type")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise as Service Tax Credit"; rec."Excise as Service Tax Credit")
                // {
                //     ApplicationArea = all;
                // }
                // field("Service Tax as Excise Credit"; rec."Service Tax as Excise Credit")
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
                field(Supplementary; rec.Supplementary)
                {
                    ApplicationArea = all;
                }
                field("Source Document Type"; rec."Source Document Type")
                {
                    ApplicationArea = all;
                }
                field("Source Document No."; rec."Source Document No.")
                {
                    ApplicationArea = all;
                }
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
                // field("Notification Sl. No."; rec."Notification Sl. No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Notification No."; rec."Notification No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("CTSH No."; rec."CTSH No.")
                // {
                //     ApplicationArea = all;
                // }
                // field("Reason Code"; rec."Reason Code")
                // {
                //     ApplicationArea = all;
                // }
                // field("Excise Loading on Inventory"; rec."Excise Loading on Inventory")
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
                // field("Excise Refund"; rec."Excise Refund")
                // {
                //     ApplicationArea = all;
                // }
                // field("CWIP G/L Type"; rec."CWIP G/L Type")
                // {
                //     ApplicationArea = all;
                // }
                field("Density Factor"; rec."Density Factor")
                {
                    ApplicationArea = all;
                }
                field("Vendor Unit of Measure"; rec."Vendor Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("Vendor Quantity"; rec."Vendor Quantity")
                {
                    ApplicationArea = all;
                }
                field("Vendor Rate"; rec."Vendor Rate")
                {
                    ApplicationArea = all;
                }
                field("Vendor Amount"; rec."Vendor Amount")
                {
                    ApplicationArea = all;
                }
                field("Routing No."; rec."Routing No.")
                {
                    ApplicationArea = all;
                }
                field("Operation No."; rec."Operation No.")
                {
                    ApplicationArea = all;
                }
                field("Work Center No."; rec."Work Center No.")
                {
                    ApplicationArea = all;
                }
                field("Prod. Order Line No."; rec."Prod. Order Line No.")
                {
                    ApplicationArea = all;
                }
                field("Overhead Rate"; rec."Overhead Rate")
                {
                    ApplicationArea = all;
                }
                field("Routing Reference No."; rec."Routing Reference No.")
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
                field("Direct Unit Cost"; rec."Direct Unit Cost")
                {
                    ApplicationArea = all;
                }
                field("Unit Cost (LCY)"; rec."Unit Cost (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Unit Price (LCY)"; rec."Unit Price (LCY)")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        PurchReceptHeader.RESET;
        PurchReceptHeader.SETRANGE(PurchReceptHeader."No.", Rec."Document No.");
        IF PurchReceptHeader.FINDFIRST THEN
            "Buy From Party Name" := PurchReceptHeader."Buy-from Vendor Name";
    end;

    trigger OnOpenPage()
    begin
        PurchReceptHeader.RESET;
        PurchReceptHeader.SETRANGE(PurchReceptHeader."No.", Rec."Document No.");
        IF PurchReceptHeader.FINDFIRST THEN
            "Buy From Party Name" := PurchReceptHeader."Buy-from Vendor Name";
    end;

    var
        "Buy From Party Name": Text[50];
        PurchReceptHeader: Record 120;
}

