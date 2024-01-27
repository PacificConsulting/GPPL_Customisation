pageextension 60009 Sales_Order_Subform_Ext extends "Sales Order Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Inventory Posting Group"; rec."Inventory Posting Group")
            {
                ApplicationArea = all;
            }
            field("MRP/Sales Price"; rec."MRP/Sales Price")
            {
                ApplicationArea = all;
                DecimalPlaces = 2 : 4;

                Style = Attention;
                StyleExpr = TRUE;
            }
            field("Structure Calculated"; rec."Structure Calculated")
            {
                ApplicationArea = all;
                Editable = FieldEditable;
            }
            field("Basic Price"; rec."Basic Price")
            {
                ApplicationArea = all;
                DecimalPlaces = 2 : 4;
                Editable = FieldEditable;
            }
            field("Freight/Other Chgs. Primary"; rec."Freight/Other Chgs. Primary")
            {
                ApplicationArea = all;
                Editable = FieldEditable;
            }
            field("Freight/Other Chgs. Secondary"; rec."Freight/Other Chgs. Secondary")
            {
                ApplicationArea = all;
                Editable = FieldEditable;
            }
            field("Split Line"; rec."Split Line")
            {
                ApplicationArea = all;
                Editable = FieldEditable;
            }
            field("Splited From Line"; rec."Splited From Line")
            {
                ApplicationArea = all;
                Editable = FieldEditable;
            }
            /*  field("Excise Amount"; rec."Excise Amount") this field is not available in BC
             {
                 ApplicationArea = all;
             } */
            /* field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group") //Already defined on page
            {
                ApplicationArea = all;

            } */
            /*  field("Charges To Customer"; rec."Charges To Customer")
             {
                 ApplicationArea = all;
             } */
            field("Quantity (Base)"; rec."Quantity (Base)")
            {
                ApplicationArea = all;
            }
            /* field("Excise Prod. Posting Group"; rec."Excise Prod. Posting Group")
            {
                ApplicationArea = all;
                Editable = FieldEditable;
            } */
            /*  field("Excise Bus. Posting Group"; rec."Excise Bus. Posting Group")
             {
                 ApplicationArea = all;
                 Editable = FieldEditable;
             } */
            /*  field("Tax Liable"; rec."Tax Liable")
             {
                 ApplicationArea = all;
             } */
            /*  field("Tax Area Code"; rec."Tax Area Code")
             {
                 ApplicationArea = all;
             } */
            /*  field("Variant Code";rec."Variant Code")
             {

             } */
            field(Closed; Rec.Closed)
            {
                ApplicationArea = all;
                Editable = FieldEditable;
            }
            field("Amount To Customer"; Rec."Amount To Customer")
            {
                ApplicationArea = all;
            }
            field("Free of Cost"; Rec."Free of Cost")
            {
                ApplicationArea = all;
                Editable = FieldEditable;
            }
            field("Closed Date"; Rec."Closed Date")
            {
                ApplicationArea = all;
                Editable = FieldEditable;
            }
            /*  field("Tax Amount"; rec."Tax Amount")
             {
                 ApplicationArea = all;
             } */
            field("National Discount Per Ltr"; rec."National Discount Per Ltr")  // MY PC 05 01 2024
            {
                ApplicationArea = all;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    rec."National Discount Amount" := rec."National Discount Per Ltr" * rec."Qty. to Invoice (Base)";  //CAS-03500-H4N0R8
                end;
            }
            field("Price Support Per Ltr"; rec."Price Support Per Ltr")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("List Price"; Rec."List Price")
            {
                ApplicationArea = all;
            }
            field("Last Billing Price"; rec."Last Billing Price")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Specification; Rec.Specification)
            {
                ApplicationArea = all;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    // IOPL                    //RSPLSUM 23May2020
                    RecSpecMaster.RESET;
                    CLEAR(PgSpecMasterList);
                    PgSpecMasterList.SETRECORD(RecSpecMaster);
                    PgSpecMasterList.SETTABLEVIEW(RecSpecMaster);
                    PgSpecMasterList.LOOKUPMODE(TRUE);
                    IF PgSpecMasterList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        PgSpecMasterList.GETRECORD(RecSpecMaster);
                        Text := RecSpecMaster.Specification;
                        EXIT(TRUE);
                    END;
                    //RSPLSUM 23May2020
                end;
            }
            field("TDS/TCS Amount"; Rec."TDS/TCS Amount")
            {
                ApplicationArea = all;
            }
        }

        addafter("Document No.") // MY PC 05 01 2024
        {
            field("Trading Location"; rec."Trading Location")
            {
                ApplicationArea = all;
                Editable = true;
            }
        }

        addafter("Reserved Quantity")
        {
            field("National Discount Amount"; rec."National Discount Amount")
            {
                ApplicationArea = all;
            }
        }

        addafter(ShortcutDimCode8) // MY PC 08/01/2024
        {
            field("Planned Delivery End Date"; rec."Planned Delivery End Date")
            {
                ApplicationArea = all;
                Editable = BunkerFieldsEditable;
            }
        }

        addafter("Planned Delivery End Date")
        {
            field("Minimum Quantity"; rec."Minimum Quantity")
            {
                ApplicationArea = all;
                Editable = BunkerFieldsEditable;
                trigger OnValidate()
                begin

                    IF (rec.Quantity <> 0) AND (rec."Minimum Quantity" <> 0) THEN BEGIN
                        IF rec."Minimum Quantity" > rec.Quantity THEN
                            ERROR('Minimum Quantity must be lesser than Quantity');
                    END;
                END;
            }
        }


        modify("Planned Delivery Date")
        {
            Editable = FieldEditable;
        }
        modify("Qty. to Ship")
        {
            trigger OnAfterValidate()
            begin
                //TC_LD +
                RecSH.RESET;//RSPLSUM 25May2020
                IF RecSH.GET(RecSH."Document Type", rec."Document No.") THEN BEGIN//RSPLSUM 25May2020
                    IF (RecSH."Shortcut Dimension 1 Code" <> 'DIV-14') OR (RecSH."Shortcut Dimension 1 Code" <> 'DIV-06') OR (RecSH."Shortcut Dimension 1 Code" <> 'DIV-10') THEN BEGIN//RSPLSUM 25May2020
                        IF (rec."Qty. to Ship" <> 0) THEN
                            IF rec.Quantity <> rec."Qty. to Ship" THEN
                                ERROR('Please do Split Line for  Item %1 and Line No. %2', rec."No.", rec."Line No.");
                    END;//RSPLSUM 25May2020
                END;//RSPLSUM 25May2020
                    //TC_LD -
            end;
        }
        modify("Line Amount")
        {
            Editable = FieldEditable;
        }
        modify("Unit Price")
        {
            Editable = FieldEditable;
        }
        modify("Reserved Quantity")
        {
            QuickEntry = FALSE;
        }
        modify(Quantity)
        {
            Editable = SplitQtyEditable;
            trigger OnAfterValidate()
            begin
                //>>22Aug2017 RB::N Sales Shipment Validation
                IF rec."Quantity Shipped" <> 0 THEN
                    ERROR('Shipment is already done for %1 Line No.', rec."Line No.");
                //<<22Aug2017 RB::N Sales Shipment Validation

                //>>26Mar2019
                rec.TESTFIELD("Free of Cost", FALSE);
                //<<26Mar2019
            end;
        }
        modify("Unit of Measure Code")
        {
            Editable = GLEditable;
        }
        modify("Location Code")
        {
            Editable = FieldEditable;
        }
        modify("Tax Group Code")
        {
            Editable = FieldEditable;
        }
        modify("Line Discount Amount")
        {
            visible = true;
            Editable = FALSE;
        }

        modify("Tax Liable")
        {
            Visible = true;
            Editable = FieldEditable;
        }
        modify("Tax Area Code")
        {
            Editable = FieldEditable;
            Visible = true;
        }
        modify("Variant Code")
        {
            Visible = true;
            Editable = FieldEditable;
        }

        modify(Type)
        {
            trigger OnAfterValidate()
            begin
                //>> RB-N 11Oct2017
                GLEditable := FALSE;
                GSTGroupEdit := FALSE;
                IF rec.Type = Rec.Type::"G/L Account" THEN BEGIN
                    GLEditable := TRUE;
                    GSTGroupEdit := TRUE;
                end;
            end;
        }
        // Add changes to page layout here
    }


    actions
    {
        modify(ItemTrackingLines)
        {
            trigger OnBeforeAction()
            begin
                IF SalesHeader.GET(SalesHeader."Document Type", rec."Document No.") THEN BEGIN
                    //EBT0002
                    IF SalesHeader.Status <> SalesHeader.Status::Released THEN
                        IF SalesHeader."Shortcut Dimension 1 Code" = 'DIV-03' THEN
                            ERROR('Status must be Released')
                        ELSE
                            IF SalesHeader."Shortcut Dimension 2 Code" = 'DIV-04' THEN
                                IF NOT SalesHeader.Trading THEN
                                    ERROR('Status must be Released');
                    //EBT0002
                end;
            end;
        }

        addafter(DeferralSchedule)
        {
            action("Split Line1")
            {
                Caption = 'Split Line';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    //>>22Aug2017 RB::N Sales Shipment Validation

                    IF rec."Completely Shipped" THEN
                        ERROR('Complete Shipment is already done for %1 Line No.', rec."Line No.");

                    //<<22Aug2017 RB::N Sales Shipment Validation

                    //RSPL-TC +
                    IF (rec."Inventory Posting Group" <> 'AUTOOILS') AND (rec."Inventory Posting Group" <> 'REPSOL') THEN //RB-N 15Nov2017
                        IF SalesHeader.GET(SalesHeader."Document Type", rec."Document No.") THEN
                            IF (SalesHeader.Status = SalesHeader.Status::Open) THEN
                                ERROR('The Document must be Approved');
                    //SplitLine;
                    //RSPL-TC -
                end;
            }
            action("Reserved Batches")
            {
                trigger OnAction()
                begin
                    ResevedBatchesLinewise;//RSPL-TC 
                end;
            }
        }

        // Add changes to page actions here
    }
    trigger OnOpenPage()
    begin
        //RSPLSUM 15Jun2020>>
        RecItem.RESET;
        IF RecItem.GET(rec."No.") THEN BEGIN
            IF RecItem.Editable THEN
                EditDesc := TRUE
            ELSE
                EditDesc := FALSE;
        END;
        //RSPLSUM 15Jun2020<<
    end;

    trigger OnAfterGetRecord()
    begin
        //>>Robosoft\Migration\Rahul
        IsEditable := FALSE;
        IF rec."Inventory Posting Group" = 'BASEOILS' THEN
            IsEditable := TRUE;
        //<<


        //>> RB-N 11Oct2017
        GLEditable := FALSE;
        GSTGroupEdit := FALSE;
        IF (rec.Type = Rec.Type::"G/L Account") OR (rec."Inventory Posting Group" = 'BITUMEN') OR (rec."Inventory Posting Group" = 'FUELOIL') OR (rec."Inventory Posting Group" = 'RPO') THEN BEGIN
            GLEditable := TRUE;
            GSTGroupEdit := TRUE;
        end;

        //>> RB-N 11Oct2017

        //>> Migration\Rahul
        IF (rec."Inventory Posting Group" = 'BASEOILS') THEN
            GLEditable := TRUE;
        //>> Migration\Rahul

        //>>RB-N 15Nov2017
        LotNoEdit := FALSE;
        IF rec."Location Code" = 'PLANT03' THEN
            LotNoEdit := TRUE
        ELSE
            LotNoEdit := FALSE;

        //<<RB-N 15Nov2017

        LineFieldsEditables;//RB-N 20Jun2018

        //RSPLSUM 10May2020>>
        RecSH.RESET;
        RecSH.SETRANGE("Document Type", rec."Document Type");
        RecSH.SETRANGE("No.", rec."Document No.");
        //RecSH.SETRANGE(Status,RecSH.Status::Open);
        IF RecSH.FINDFIRST THEN BEGIN
            IF (RecSH."Shortcut Dimension 1 Code" = 'DIV-14') AND (rec."Item Category Code" = 'CAT21') THEN
                BunkerFieldsEditable := TRUE
            ELSE
                BunkerFieldsEditable := FALSE;

        END;
        //RSPLSUM 10May2020<<

        //RSPLSUM 15Jun2020>>
        RecItem.RESET;
        IF RecItem.GET(rec."No.") THEN BEGIN
            IF RecItem.Editable THEN
                EditDesc := TRUE
            ELSE
                EditDesc := FALSE;
        END;
        //RSPLSUM 15Jun2020<<

        //RSPLSUM 13Jan21>>
        IF rec."Item Category Code" = 'CAT21' THEN
            EditDescFuelOil := TRUE
        ELSE
            EditDescFuelOil := FALSE;
        //RSPLSUM 13Jan21<<
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        rec.TESTFIELD("Quantity Shipped", 0);
    end;

    /* trigger OnRename()
    begin
        ERROR(Text001, TABLECAPTION);
    end; */

    var
        myInt: Integer;
        SalesHeader: Record "Sales Header";

        IsEditable: Boolean;
        "---------11Oct2017": Integer;
        GLEditable: Boolean;
        GSTGroupEdit: Boolean;
        "-------15Nov2017": Integer;
        LotNoEdit: Boolean;
        FieldEditable: Boolean;
        SplitQtyEditable: Boolean;
        BunkerFieldsEditable: Boolean;
        RecSH: Record 36;
        RecSpecMaster: Record 50048;
        PgSpecMasterList: Page 50130;
        RecSalesHeader: Record 36;
        RecItem: Record 27;
        EditDesc: Boolean;
        EditDescFuelOil: Boolean;
        RemIn: Decimal;
        ItemLeg: Record 32;
        ParentItemCode: Code[50];
        Text002: Label 'ENU="The remaining quantity "';
        Text003: Label 'ENU="is available in old Item code "';
        ReservationEntry: Record "Reservation Entry";
        cduDimMgt: Codeunit 408;
        DimMgt: Codeunit 408;
        Text053: Label 'You have changed one or more dimensions on the %1, which is already shipped. When you post the line with the changed dimension to General Ledger, amounts on the Inventory Interim account will be out of balance when reported per dimension.\\Do you want to keep the changed dimension?';
        Text054: Label 'Cancelled.';

    /*  LOCAL PROCEDURE ValidateSaveShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20]);
     BEGIN
         ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
         CurrPage.SAVERECORD;
     END; */

    PROCEDURE LineFieldsEditables();
    VAR
        SH: Record 36;
    BEGIN
        //>>20Jun2018
        FieldEditable := FALSE;
        SplitQtyEditable := FALSE;
        SH.RESET;
        SH.SETRANGE(SH."Document Type", rec."Document Type");
        SH.SETRANGE(SH."No.", rec."Document No.");
        SH.SETRANGE(SH.Status, SH.Status::Open);
        IF SH.FINDFIRST THEN BEGIN
            FieldEditable := TRUE;
            SplitQtyEditable := TRUE;
        END ELSE BEGIN
            FieldEditable := FALSE;
            GLEditable := FALSE;
            GSTGroupEdit := FALSE;
            LotNoEdit := FALSE;
            IsEditable := FALSE;
            SplitQtyEditable := FALSE;
            IF rec."IOPL Split Line No." <> 0 THEN
                SplitQtyEditable := TRUE;
        END;
    end;


    //<<20Jun2018
    procedure ResevedBatchesLinewise()
    begin
        ReservationEntry.RESET;
        ReservationEntry.SETRANGE(ReservationEntry."Item No.", rec."No.");
        ReservationEntry.SETRANGE(ReservationEntry."Location Code", rec."Location Code");
        IF ReservationEntry.FINDFIRST THEN BEGIN
            REPORT.RUN(50050, TRUE, FALSE, ReservationEntry);
        end;
    END;

    // [Scope('Internal')]
    // procedure SplitLine()
    // var
    //     SalesHEBT: Record 36;
    //     EBTSalesLin: Record 37;
    //     LineNumber: Integer;
    //     NewSalesLine: Record 37;
    // begin
    //     SalesHEBT.RESET;
    //     SalesHEBT.SETRANGE(SalesHEBT."No.", rec."Document No.");
    //     IF SalesHEBT.FINDFIRST THEN BEGIN

    //         //IF SalesHEBT."Location Code" <> 'PLANT01' THEN
    //         IF (SalesHEBT."Location Code" <> 'PLANT01') AND (SalesHEBT."Location Code" <> 'PLANT03') THEN BEGIN
    //             IF rec."Qty. to Ship" = 0 THEN
    //                 ERROR('Nothing to split');
    //             IF rec."Qty. to Ship" = 1 THEN
    //                 ERROR('There is no need to split the quantity as Qty. to Ship is 1');
    //         END;

    //         //EBT STIVAN ---(18/12/2012)---SplitLine Functionality at Vasai Plant on the Base of Qty -------START
    //         IF SalesHEBT."Location Code" = 'PLANT01' THEN BEGIN
    //             IF rec.Quantity = 0 THEN
    //                 ERROR('Nothing to split');
    //             IF rec.Quantity = 1 THEN
    //                 ERROR('There is no need to split the quantity as Qty. to Ship is 1');
    //         END;
    //         //EBT STIVAN ---(18/12/2012)---SplitLine Functionality at Vasai Plant on the Base of Qty ---------END
    //     END;

    //     EBTSalesLin.RESET;
    //     EBTSalesLin.SETRANGE(EBTSalesLin."Document No.", rec."Document No.");
    //     IF EBTSalesLin.FINDLAST THEN
    //         LineNumber := EBTSalesLin."Line No.";

    //     rec."Split Line" := TRUE;
    //     rec.MODIFY;
    //     NewSalesLine.INIT;
    //     NewSalesLine.TRANSFERFIELDS(Rec);
    //     NewSalesLine."Line No." := LineNumber + 10000;
    //     NewSalesLine.INSERT(TRUE);
    //     NewSalesLine.VALIDATE(NewSalesLine.Quantity, 0);
    //     NewSalesLine.modified := FALSE;
    //     //NewSalesLine."Split Line" := TRUE;
    //     //NewSalesLine.MODIFY;
    //     //NewSalesLine.VALIDATE(NewSalesLine."No.");
    //     NewSalesLine."Split Line" := FALSE;
    //     NewSalesLine."Splited From Line" := rec."Line No.";
    //     NewSalesLine."IOPL Split Line No." := rec."Line No."; //IOPL-TC
    //                                                           // NewSalesLine.CopyStructureDetails; //pcpl-64 27dec2023
    //     NewSalesLine.MODIFY;
    //     /*  //RSPL-TC
    //     //Dimension
    //     DocumentDim.RESET;
    //     DocumentDim.SETRANGE(DocumentDim."Table ID",37);
    //     DocumentDim.SETRANGE(DocumentDim."Document No.","Document No.");
    //     DocumentDim.SETRANGE(DocumentDim."Line No.","Line No.");
    //     IF DocumentDim.FINDSET THEN
    //     REPEAT
    //       DocumentDim1.INIT;
    //       DocumentDim1."Table ID" := 37;
    //       DocumentDim1."Document Type" := DocumentDim."Document Type";
    //       DocumentDim1."Document No." := DocumentDim."Document No.";
    //       DocumentDim1."Line No." := NewSalesLine."Line No.";
    //       DocumentDim1."Dimension Code" := DocumentDim."Dimension Code";
    //       DocumentDim1."Dimension Value Code" := DocumentDim."Dimension Value Code";
    //       DocumentDim1.INSERT;
    //     UNTIL DocumentDim.NEXT = 0;
    //     //Dimension
    //     */
    //     rec."Split Line" := FALSE;
    //     //SplittingLine := FALSE;
    // end;

    // [Scope('Internal')]
    /* procedure CopyStructureDetails()
    var
        StructureOrderLineDetails: Record 13795;
        StructureOrderLineDetails1: Record 13795;
    begin
        StructureOrderLineDetails.RESET;
        StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails."Document Type", rec."Document Type");
        StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails."Document No.", rec."Document No.");
        StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails."Item No.", rec."No.");
        StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails."Line No.", rec."Splited From Line");
        IF StructureOrderLineDetails.FINDSET THEN
            REPEAT
                StructureOrderLineDetails1.INIT;
                StructureOrderLineDetails1.TRANSFERFIELDS(StructureOrderLineDetails);
                StructureOrderLineDetails1."Line No." := "Line No.";
                StructureOrderLineDetails1.INSERT(TRUE);
            UNTIL StructureOrderLineDetails.NEXT = 0;
    end; */

    // [Scope('Internal')]
    /*  procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
     begin
         DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, rec."Dimension Set ID");
         VerifyItemLineDim;
     end;
  */
    /* local procedure VerifyItemLineDim()
    begin
        IF IsShippedReceivedItemDimChanged THEN
            ConfirmShippedReceivedItemDimChange;
    end;
 */
    // [Scope('Internal')]
    /*  procedure IsShippedReceivedItemDimChanged(): Boolean
     begin
         EXIT((rec."Dimension Set ID" <> xRec."Dimension Set ID") AND (rec.Type = Type::Item) AND
           ((Rec."Qty. Shipped Not Invoiced" <> 0) OR (rec."Return Rcd. Not Invd." <> 0)));
     end; */

    //  [Scope('Internal')]
    /*  procedure ConfirmShippedReceivedItemDimChange(): Boolean
     begin
         IF NOT CONFIRM(Text053, TRUE, ) THEN
             ERROR(Text054);

         EXIT(TRUE);
     end; */

}