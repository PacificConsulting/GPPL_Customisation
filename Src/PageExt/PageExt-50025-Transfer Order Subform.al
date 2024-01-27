pageextension 50025 "Transfer Order SubformExtCstm" extends "Transfer Order Subform"
{
    layout
    {
        addafter("Item No.")
        {
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = all;
            }
            field("Document No."; Rec."Document No.")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Transfer Indent No."; Rec."Transfer Indent No.")
            {
                ApplicationArea = all;
            }
            field("Transfer Indent Line No."; Rec."Transfer Indent Line No.")
            {
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
            }
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = all;
            }
            // field("CESS Amount"; "CESS Amount")
            // {
            // }
            // field("SED Amount"; "SED Amount")
            // {
            // }
            field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Transfer Price of Base Unit"; Rec."Transfer Price of Base Unit")
            {
                DecimalPlaces = 4 : 4;
                Editable = TransferPriceEdit;
                ApplicationArea = all;
            }
            // field("Assessable Value"; "Assessable Value")
            // {
            //     DecimalPlaces = 4 : 4;
            // }
            // field("BED Amount"; "BED Amount")
            // {
            //     Editable = false;
            //     Style = AttentionAccent;
            //     StyleExpr = TRUE;
            // }
            // field("BCD Amount"; "BCD Amount")
            // {
            //     Editable = false;
            //     Style = AttentionAccent;
            //     StyleExpr = TRUE;
            // }
            field("BCD Value"; Rec."BCD Value")
            {
                Editable = false;
                ApplicationArea = all;
            }
            // field("NCCD Amount"; "NCCD Amount")
            // {
            //     Caption = 'CVD Amount';
            // }
            // field("eCess Amount"; "eCess Amount")
            // {
            //     Style = AttentionAccent;
            //     StyleExpr = TRUE;
            // }
            // field("SHE Cess Amount"; "SHE Cess Amount")
            // {
            //     Style = AttentionAccent;
            //     StyleExpr = TRUE;
            // }
            field("Transfer-from Code"; Rec."Transfer-from Code")
            {
                ApplicationArea = all;
            }
            field("Transfer-to Code"; Rec."Transfer-to Code")
            {
                ApplicationArea = all;
            }
            // field("Custom eCess Amount"; "Custom eCess Amount")
            // {
            //     Style = AttentionAccent;
            //     StyleExpr = TRUE;
            // }
            // field("Custom SHECess Amount"; "Custom SHECess Amount")
            // {
            //     Style = AttentionAccent;
            //     StyleExpr = TRUE;
            // }
            // field("ADE Amount"; "ADE Amount")
            // {
            //     Style = AttentionAccent;
            //     StyleExpr = TRUE;
            // }
            // field(CVD; CVD)
            // {
            // }
            // field("Applies-to Entry (RG 23 D)"; "Applies-to Entry (RG 23 D)")
            // {
            //     Editable = false;
            //     Enabled = false;
            //     HideValue = false;
            //     Visible = false;
            // }
            field("GRN Number"; Rec."GRN Number")
            {
                ApplicationArea = all;
            }


        }


        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //RSPLSUM 15Jun2020>>
                RecItem.RESET;
                IF RecItem.GET(Rec."Item No.") THEN BEGIN
                    IF RecItem.Editable THEN
                        EditDesc := TRUE
                    ELSE
                        EditDesc := FALSE;
                END;
                //RSPLSUM 15Jun2020<<


                //RSPLNC
                RecItem.SETRANGE("No.", Rec."Item No.");
                IF RecItem.FINDSET THEN BEGIN
                    ParentItemCode := RecItem.ParentItemCode;
                END;
                RemIn := 0;
                IF RecItem.GET(Rec."Item No.") THEN BEGIN   //RSPLDP
                    ItemLeg.RESET;
                    ItemLeg.SETRANGE("Item No.", RecItem.ParentItemCode);
                    ItemLeg.SETRANGE("Location Code", Rec."Transfer-from Code");
                    IF ItemLeg.FINDSET THEN BEGIN
                        ItemLeg.CALCSUMS("Remaining Quantity");  //RSPLDP
                        RemIn := ItemLeg."Remaining Quantity";
                    END;
                END;
                IF RemIn <> 0 THEN BEGIN
                    MESSAGE(Text002 + '%1\' + Text003 + '%2\', RemIn, ParentItemCode);
                    IF CONFIRM('Do you still want to proceed?', TRUE) THEN BEGIN
                        MESSAGE('Kindly take approval from the Business Head.');
                        Rec."Item No." := Rec."Item No."
                    END
                    ELSE BEGIN
                        Rec."Item No." := '';
                    END;
                END;
                //RSPLNC
                //            end;

            end;
        }
        modify(Description)
        {
            Editable = EditDesc;
        }
        modify("Transfer Price")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //26Mar2019
                //IF "Transfer Price of Base Unit" = 0 THEN
                IF rec."Transfer Price" <> 0 THEN BEGIN
                    rec."Transfer Price of Base Unit" := rec."Transfer Price";
                    rec.VALIDATE(rec."Transfer Price", rec."Transfer Price" * rec."Qty. per Unit of Measure");
                END;
                //

            end;
        }
    }
    actions
    {
        addafter(Receipt)
        {
            action(SplitLine)
            {

                trigger OnAction()
                begin
                    //EBT STIVAN---(03/07/2013)---For Split Line Functionality---------------------------------START
                    IF (Rec."Transfer-from Code" = 'PLANT01') OR (Rec."Transfer-from Code" = 'PLANT02')
                    OR (Rec."Transfer-from Code" = 'DEP0007') THEN BEGIN
                        SplitCurrentLine;
                    END
                    ELSE
                        ERROR('Not Allowed to Split other then Plant Location');
                    //EBT STIVAN---(03/07/2013)---For Split Line Functionality-----------------------------------END
                end;
            }
            action("Reserved Batches")
            {

                trigger OnAction()
                begin
                    Rec.ResevedBatchesLinewise;
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //RSPLSUM 15Jun2020>>
        RecItem.RESET;
        IF RecItem.GET(Rec."Item No.") THEN BEGIN
            IF RecItem.Editable THEN
                EditDesc := TRUE
            ELSE
                EditDesc := FALSE;
        END;
        //RSPLSUM 15Jun2020<<

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //>>30Dec2017 TransferPrice Not Editable for AUTOOILS & REPSOL
        CLEAR(TransferPriceEdit);
        IF (Rec."Inventory Posting Group" = 'AUTOOILS') OR (Rec."Inventory Posting Group" = 'REPSOL') THEN
            TransferPriceEdit := FALSE
        ELSE
            TransferPriceEdit := TRUE;

        //>>24Jan2018
        IF (Rec."Transfer-from Code" = 'CAPCON') THEN
            TransferPriceEdit := TRUE;

        IF (Rec."Transfer-to Code" = 'CAPCON') THEN
            TransferPriceEdit := TRUE;
        //<<24Jan2018

        //>>11Feb2019
        RepItmNo := '';
        IF Rec."Inventory Posting Group" = 'REPSOL' THEN BEGIN
            RepItmNo := COPYSTR(Rec."Item No.", 1, 4);
            IF RepItmNo <> '' THEN
                IF RepItmNo <> 'FGRP' THEN
                    TransferPriceEdit := TRUE;
        END;
        //<<11Feb2019
        //>>30Dec2017 TransferPrice Not Editable for AUTOOILS & REPSOL

        //RSPLSUM 15Jun2020>>
        RecItem.RESET;
        IF RecItem.GET(Rec."Item No.") THEN BEGIN
            IF RecItem.Editable THEN
                EditDesc := TRUE
            ELSE
                EditDesc := FALSE;
        END;
        //RSPLSUM 15Jun2020<<
    END;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        //>>30Jan2019
        TH.RESET;
        IF TH.GET(Rec."Document No.") THEN begin
            // IF TH.Structure = 'GSTIMPORT' THEN BEGIN
            //     IF Rec."Line No." > 10000 THEN
            //         ERROR('For GSTIMPORT Structure only 1 Item Line Allowed for Load Inventory');
            // END;
            //<<30Jan2019
        end;
    end;


    var
        myInt: Integer;
        RecItem: Record Item;
        "--------30Dec2017": Integer;
        TransferPriceEdit: Boolean;
        TH: Record 5740;
        RepItmNo: Code[20];

        EditDesc: Boolean;
        RemIn: Decimal;
        ItemLeg: Record 32;
        ParentItemCode: Code[50];
        Text002: Label 'The remaining quantity ';
        Text003: Label ' is available in the old Item code ';

    procedure SplitCurrentLine()
    begin
        Rec.SplitLine; //EBT STIVAN---(03/07/2013)---For Split Line Functionality
    end;





}