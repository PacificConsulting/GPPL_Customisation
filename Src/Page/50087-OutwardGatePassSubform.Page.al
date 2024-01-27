page 50087 "Outward GatePass Subform"
{
    // Date        Version      Remarks
    // .....................................................................................
    // 14Nov2018   RB-N         New Page Development from P#6641

    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = 39;
    SourceTableView = WHERE("Document Type" = FILTER("Return Order"));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field(Type; rec.Type)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                // field("Cross-Reference No."; rec."Cross-Reference No.")
                // {
                //     ApplicationArea = all;
                //     Visible = false;

                //     trigger OnLookup(var Text: Text): Boolean
                //     begin
                //         CrossReferenceNoLookUp;
                //         InsertExtendedText(FALSE);
                //     end;

                //     trigger OnValidate()
                //     begin
                //         CrossReferenceNoOnAfterValidat;
                //     end;
                // }
                field("IC Partner Ref. Type"; rec."IC Partner Ref. Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("IC Partner Reference"; rec."IC Partner Reference")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Nonstock; rec.Nonstock)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Return Reason Code"; rec."Return Reason Code")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                // field("Excise Loading on Inventory"; rec."Excise Loading on Inventory")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("Assessable Value"; rec."Assessable Value")
                // {
                //     Visible = false;
                // }
                field("Reserved Quantity"; ReverseReservedQtySign)
                {
                    ApplicationArea = all;
                    // BlankZero = true;
                    // CaptionClass = FIELDCAPTION("Reserved Quantity");
                    // DecimalPlaces = 0 : 5;
                    // Visible = false;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        COMMIT;
                        Rec.ShowReservationEntries(TRUE);
                        UpdateForm(TRUE);
                    end;
                }
                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure"; rec."Unit of Measure")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Direct Unit Cost"; rec."Direct Unit Cost")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Indirect Cost %"; rec."Indirect Cost %")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Unit Cost (LCY)"; rec."Unit Cost (LCY)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Unit Price (LCY)"; rec."Unit Price (LCY)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Line Amount"; rec."Line Amount")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Line Discount %"; rec."Line Discount %")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Line Discount Amount"; rec."Line Discount Amount")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Allow Invoice Disc."; rec."Allow Invoice Disc.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Inv. Discount Amount"; rec."Inv. Discount Amount")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Return Qty. to Ship"; rec."Return Qty. to Ship")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Return Qty. Shipped"; rec."Return Qty. Shipped")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Qty. to Invoice"; rec."Qty. to Invoice")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Quantity Invoiced"; rec."Quantity Invoiced")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                }
                field("Allow Item Charge Assignment"; rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Qty. to Assign"; rec."Qty. to Assign")
                {
                    ApplicationArea = all;
                    BlankZero = true;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        Rec.ShowItemChargeAssgnt;
                        UpdateForm(FALSE);
                    end;
                }
                field("Qty. Assigned"; rec."Qty. Assigned")
                {
                    ApplicationArea = all;
                    BlankZero = true;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        Rec.ShowItemChargeAssgnt;
                        UpdateForm(FALSE);
                    end;
                }
                field("Prod. Order No."; rec."Prod. Order No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Insurance No."; rec."Insurance No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Budgeted FA No."; rec."Budgeted FA No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("FA Posting Type"; rec."FA Posting Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Depr. until FA Posting Date"; rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Depreciation Book Code"; rec."Depreciation Book Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Depr. Acquisition Cost"; rec."Depr. Acquisition Cost")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Blanket Order No."; rec."Blanket Order No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Blanket Order Line No."; rec."Blanket Order Line No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; rec."Appl.-to Item Entry")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Custom Duty Amount"; rec."Custom Duty Amount")
                {
                    ApplicationArea = all;
                }
                field("GST Assessable Value"; rec."GST Assessable Value")
                {
                    ApplicationArea = all;
                }
                field("Job No."; rec."Job No.")
                {
                    ApplicationArea = all;
                }
                field("Job Task No."; rec."Job Task No.")
                {
                    ApplicationArea = all;
                }
                field("Job Line Type"; rec."Job Line Type")
                {
                    ApplicationArea = all;
                }
                field("Deferral Code"; rec."Deferral Code")
                {
                    ApplicationArea = all;
                    //Enabled = (Type <> Type::"Fixed Asset") AND (Type <> Type::" ");
                    TableRelation = "Deferral Template"."Deferral Code";
                }
                field("Returns Deferral Start Date"; rec."Returns Deferral Start Date")
                {
                    ApplicationArea = all;
                    //Enabled = (Type <> Type::"Fixed Asset") AND (Type <> Type::" ");
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    ApplicationArea = all;
                    // CaptionClass = '1,2,3';
                    // TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3),
                    //                                               "Dimension Value Type"=CONST(Standard),
                    //                                               Blocked=CONST(No));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    ApplicationArea = all;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("GST Credit"; REC."GST Credit")
                {
                    applicationarea = all;
                }
                field("GST Group Code"; rec."GST Group Code")
                {
                    applicationarea = all;
                }
                field("GST Group Type"; rec."GST Group Type")
                {
                    applicationarea = all;
                }
                field("HSN/SAC Code"; rec."HSN/SAC Code")
                {
                    applicationarea = all;
                }
                field(Exempted; Rec.Exempted)
                {
                    applicationarea = all;
                }
                // field("CIF Amount"; rec."CIF Amount")
                // {
                //     applicationarea = all;
                //     Visible = false;
                // }
                // field("BCD Amount"; rec."BCD Amount")
                // {
                //     applicationarea = all;
                //     Visible = false;
                // }
                // field("BED Amount"; rec."BED Amount")
                // {
                //     applicationarea = all;
                //     Visible = false;
                // }
                // field("AED(GSI) Amount"; rec."AED(GSI) Amount")
                // {
                //     applicationarea = all;
                //     Visible = false;
                // }
                // field("SED Amount"; rec."SED Amount")
                // {
                //     applicationarea = all;
                //     Visible = false;
                // }
                // field("SAED Amount"; rec."SAED Amount")
                // {
                //     applicationarea = all;
                //     Visible = false;
                // }
                // field("CESS Amount"; rec."CESS Amount")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("NCCD Amount"; rec."NCCD Amount")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("eCess Amount"; rec."eCess Amount")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("SHE Cess Amount"; rec."SHE Cess Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("ADET Amount"; rec."ADET Amount")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("AED(TTA) Amount"; rec."AED(TTA) Amount")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("ADE Amount"; rec."ADE Amount")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("ADC VAT Amount"; rec."ADC VAT Amount")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                // field("Custom eCess Amount"; rec."Custom eCess Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Custom SHECess Amount"; rec."Custom SHECess Amount")
                // {
                //     ApplicationArea = all;
                // }
                field(Supplementary; rec.Supplementary)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                // field("GST Base Amount"; rec."GST Base Amount")
                // {
                //     ApplicationArea = all;
                // }
                // field("Total GST Amount"; rec."Total GST Amount")
                // {
                //     ApplicationArea = all;
                // }
                field("Source Document Type"; rec."Source Document Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Source Document No."; rec."Source Document No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    ApplicationArea = all;
                    // CaptionClass = '1,2,5';
                    // TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(5),
                    //                                               Dimension Value Type=CONST(Standard),
                    //                                               Blocked=CONST(No));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    ApplicationArea = all;
                    // CaptionClass = '1,2,6';
                    // TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(6),
                    //                                               Dimension Value Type=CONST(Standard),
                    //                                               Blocked=CONST(No));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    // TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(7),
                    //                                               Dimension Value Type=CONST(Standard),
                    //                                               Blocked=CONST(No));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                // field("Excise Refund"; rec."Excise Refund")
                // {
                //     ApplicationArea = all;
                // }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Job No.2"; rec."Job No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Job Task No.2"; rec."Job Task No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Job Line Type2"; rec."Job Line Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                // field("CWIP G/L Type"; rec."CWIP G/L Type")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
                field("Vendor Item No."; rec."Vendor Item No.")
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
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("E&xplode BOM")
                {
                    ApplicationArea = all;
                    AccessByPermission = TableData 90 = R;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;

                    trigger OnAction()
                    begin
                        ExplodeBOM;
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    ApplicationArea = all;
                    AccessByPermission = TableData 279 = R;
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;

                    trigger OnAction()
                    begin
                        InsertExtendedText(TRUE);
                    end;
                }
                action(Reserve)
                {
                    ApplicationArea = all;
                    Caption = '&Reserve';
                    Image = Reserve;

                    trigger OnAction()
                    begin
                        PageShowReservation;
                    end;
                }
                action("Order &Tracking")
                {
                    ApplicationArea = all;
                    Caption = 'Order &Tracking';
                    Image = OrderTracking;

                    trigger OnAction()
                    begin
                        ShowTracking;
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        ApplicationArea = all;
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = all;
                        Caption = 'Period';
                        Image = Period;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = all;
                        Caption = 'Variant';
                        Image = ItemVariant;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = all;
                        AccessByPermission = TableData 14 = R;
                        Caption = 'Location';
                        Image = Warehouse;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        ApplicationArea = all;
                        Caption = 'BOM Level';
                        Image = BOMLevel;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM)
                        end;
                    }
                }
                action(Dimensions)
                {
                    ApplicationArea = all;
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        Rec.ShowLineComments;
                    end;
                }
                action("Item Charge &Assignment")
                {
                    ApplicationArea = all;
                    AccessByPermission = TableData 5800 = R;
                    Caption = 'Item Charge &Assignment';
                    Image = ItemCosts;

                    trigger OnAction()
                    begin
                        ItemChargeAssgnt;
                    end;
                }
                action(ItemTrackingLines)
                {
                    ApplicationArea = all;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines;
                    end;
                }
                action(DeferralSchedule)
                {
                    ApplicationArea = all;
                    Caption = 'Deferral Schedule';
                    Enabled = Rec."Deferral Code" <> '';
                    Image = PaymentPeriod;

                    trigger OnAction()
                    var
                        PurchHeader: Record 38;
                        DeferralUtilities: Codeunit 1720;
                    begin
                        /*
                        PurchHeader.GET("Document Type", "Document No.");
                        IF ShowDeferrals(PurchHeader."Posting Date", PurchHeader."Currency Code") THEN BEGIN
                            "Returns Deferral Start Date" :=
                              DeferralUtilities.GetDeferralStartDate(DeferralUtilities.GetPurchDeferralDocType, "Document Type",
                                "Document No.", "Line No.", "Deferral Code", PurchHeader."Posting Date");
                            CurrPage.SAVERECORD;
                        END;
                        */
                    end;
                }
                action("Str&ucture Details")
                {
                    ApplicationArea = all;
                    Caption = 'Str&ucture Details';
                    Image = Hierarchy;

                    trigger OnAction()
                    begin
                        ShowStrDetailsForm;
                    end;
                }
                action("E&xcise Detail")
                {
                    ApplicationArea = all;
                    Caption = 'E&xcise Detail';
                    Image = Excise;

                    trigger OnAction()
                    begin
                        ShowExcisePostingSetup;
                    end;
                }
                action("Detailed Tax")
                {
                    ApplicationArea = all;
                    Caption = 'Detailed Tax';
                    Image = TaxDetail;

                    trigger OnAction()
                    begin
                        ShowDetailedTaxEntryBuffer;
                    end;
                }
                action("Detailed GST")
                {
                    ApplicationArea = all;
                    Caption = 'Detailed GST';
                    Image = ServiceTax;
                    // RunObject = Page 16412;
                    //                 RunPageLink = Transaction Type=FILTER(Purchase),
                    //               Document Type=FIELD(Document Type),
                    //               Document No.=FIELD(Document No.),
                    //               Line No.=FIELD(Line No.);
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit 99000834;
    begin
        IF (Rec.Quantity <> 0) AND Rec.ItemExists(Rec."No.") THEN BEGIN
            COMMIT;
            IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
                EXIT(FALSE);
            ReservePurchLine.DeleteLine(Rec);
        END;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitType;
        CLEAR(ShortcutDimCode);
    end;

    var
        TransferExtendedText: Codeunit 378;
        ItemAvailFormsMgt: Codeunit 353;
        ShortcutDimCode: array[8] of Code[20];

    //  [Scope('Internal')]
    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    local procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;

    local procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    local procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;

    local procedure PageShowReservation()
    begin
        REc.FIND;
        Rec.ShowReservation;
    end;

    local procedure ShowTracking()
    var
        TrackingForm: Page 99000822;
    begin
        TrackingForm.SetPurchLine(Rec);
        TrackingForm.RUNMODAL;
    end;

    local procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;

    //  [Scope('Internal')]
    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    //  [Scope('Internal')]
    // procedure ShowLineComments()
    // begin
    //     Rec.ShowLineComments;
    // end;

    //  [Scope('Internal')]
    procedure ShowStrDetailsForm()
    var
    //StrOrderLineDetails: Record 13795;
    //StrOrderLineDetailsForm: Page 16306;
    begin
        /*
         StrOrderLineDetails.RESET;
         StrOrderLineDetails.SETCURRENTKEY("Document Type", "Document No.", Type);
         StrOrderLineDetails.SETRANGE("Document Type", "Document Type");
         StrOrderLineDetails.SETRANGE("Document No.", "Document No.");
         StrOrderLineDetails.SETRANGE(Type, StrOrderLineDetails.Type::Purchase);
         StrOrderLineDetails.SETRANGE("Item No.", "No.");
         StrOrderLineDetails.SETRANGE("Line No.", "Line No.");
         StrOrderLineDetailsForm.SETTABLEVIEW(StrOrderLineDetails);
         StrOrderLineDetailsForm.RUNMODAL;
         */
    end;

    //  [Scope('Internal')]
    procedure ShowExcisePostingSetup()
    begin
        //GetExcisePostingSetup;
    end;

    //  [Scope('Internal')]
    procedure ShowDetailedTaxEntryBuffer()
    var
    //DetailedTaxEntryBuffer: Record "Detailed Tax Entry Buffer";
    begin
        /*
        DetailedTaxEntryBuffer.RESET;
        DetailedTaxEntryBuffer.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Line No.");
        DetailedTaxEntryBuffer.SETRANGE("Transaction Type", DetailedTaxEntryBuffer."Transaction Type"::Purchase);
        DetailedTaxEntryBuffer.SETRANGE("Document Type", "Document Type");
        DetailedTaxEntryBuffer.SETRANGE("Document No.", "Document No.");
        DetailedTaxEntryBuffer.SETRANGE("Line No.", "Line No.");
        PAGE.RUNMODAL(PAGE::"Purch. Detailed Tax", DetailedTaxEntryBuffer);
        */
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(FALSE);
    end;

    local procedure ReverseReservedQtySign(): Decimal
    begin
        Rec.CALCFIELDS("Reserved Quantity");
        EXIT(-Rec."Reserved Quantity");
    end;
}

