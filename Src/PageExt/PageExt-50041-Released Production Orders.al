pageextension 50041 "ReleaProduction OrdersCstmext" extends "Released Production Orders"
{
    layout
    {
        addafter(Description)
        {
            field("Order Type"; Rec."Order Type")
            {
                ApplicationArea = all;
            }
            field("Man Hours"; Rec."Man Hours")
            {
                ApplicationArea = all;
            }
            field("Machine Hours"; Rec."Machine Hours")

            {
                ApplicationArea = all;
            }

        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                IF rec."Order Type" = rec."Order Type"::Primary THEN
                    IF rec.Quantity <> 0 THEN
                        IF Rec.Quantity <> xRec.Quantity THEN BEGIN
                            rec."Refresh ProdOrder Qty" := TRUE;
                            MESSAGE('Kindly Refresh Production Order');
                        END;
            end;
        }
    }

    actions
    {
        addafter("Change &Status")
        {
            action("Copy QC")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    QCCertificate: Page 50035;
                begin

                    //EBT/QC Func/0001
                    rec.TESTFIELD("Order Type", rec."Order Type"::Secondary);
                    CLEAR(QCCertificate);
                    //ItemRec.GET("Source No.");
                    QCCertificate.SetDocNo(rec."No.", rec."Source No.");
                    QCCertificate.RUNMODAL;
                    //EBT/QC Func/0001
                end;
            }
            action("Create &QC")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    ProductionLine: Record "Prod. Order Line";
                    VersionCode: Code[20];
                    "BatchNo.": Code[50];
                    ShowForm: Boolean;
                    ParameterResultForm: page "Item Version Parameter Result";
                    ItemParameter: Record "Item Version Parameters";
                    ParameterResult: Record "Item Version Parameters-Result";
                    ParameterResult1: Record "Item Version Parameters-Result";
                    ItemRec: Record Item;
                begin

                    Rec.TESTFIELD("Order Type", Rec."Order Type"::Primary);
                    ProductionLine.RESET;
                    ProductionLine.SETRANGE(ProductionLine.Status, rec.Status);
                    ProductionLine.SETRANGE(ProductionLine."Prod. Order No.", rec."No.");
                    IF ProductionLine.FINDFIRST THEN
                        VersionCode := ProductionLine."Production BOM Version Code";
                    //EBT STIVAN ---(11072012)--- To Flow Batch No and Item Description -----START
                    "BatchNo." := ProductionLine."Description 2";
                    //EBT STIVAN ---(11072012)--- To Flow Batch No and Item Description ---END

                    ShowForm := FALSE;
                    CLEAR(ParameterResultForm);
                    ItemParameter.RESET;
                    ItemParameter.SETRANGE(ItemParameter."Item No.", rec."Source No.");
                    ItemParameter.SETRANGE(ItemParameter."Version Code", VersionCode);
                    IF NOT ItemParameter.FINDFIRST THEN
                        ERROR('QC has not been defined for Item No. %1', rec."No.");

                    ParameterResult.RESET;
                    ParameterResult.SETRANGE(ParameterResult."Item No.", rec."Source No.");
                    ParameterResult.SETRANGE(ParameterResult."Version Code", VersionCode);
                    ParameterResult.SETRANGE(ParameterResult."Blend Order No", rec."No.");
                    IF ParameterResult.FINDFIRST THEN BEGIN
                        //MESSAGE('QC Already created for this Production Order');
                        ParameterResult.RESET;
                        ParameterResult.SETRANGE(ParameterResult."Item No.", rec."Source No.");
                        ParameterResult.SETRANGE(ParameterResult."Blend Order No", rec."No.");
                        ParameterResult.SETRANGE(ParameterResult."Version Code", VersionCode);
                        ParameterResultForm.SETTABLEVIEW(ParameterResult);
                        ParameterResultForm.RUNMODAL;
                    END;
                    ItemParameter.RESET;
                    ItemParameter.SETRANGE(ItemParameter."Item No.", rec."Source No.");
                    ItemParameter.SETRANGE(ItemParameter."Version Code", VersionCode);
                    IF ItemParameter.FINDSET THEN
                        REPEAT
                            ParameterResult1.RESET;
                            ParameterResult1.INIT;
                            ParameterResult1."Item No." := ItemParameter."Item No.";
                            ParameterResult1."Version Code" := ItemParameter."Version Code";
                            ParameterResult1.Parameter := ItemParameter.Parameter;
                            ParameterResult1."Testing Method" := ItemParameter."Test Method";
                            ParameterResult1."Blend Order No" := rec."No.";
                            ParameterResult1."Typical Value" := ItemParameter."Typical Value";
                            ParameterResult1."Min Value" := ItemParameter."Min Value";
                            ParameterResult1."Max Value" := ItemParameter."Max Value";
                            ParameterResult1.Result := ItemParameter.Result;
                            ParameterResult1."Line No." := ItemParameter."Line No.";
                            //EBT STIVAN ---(11072012)--- To Flow Batch No and Item Description -----START
                            ParameterResult1."Batch No./DC No" := "BatchNo.";
                            ItemRec.GET(ParameterResult1."Item No.");
                            ParameterResult1."Item Description" := ItemRec.Description;
                            //EBT STIVAN ---(11072012)--- To Flow Batch No and Item Description -------END
                            IF ParameterResult1.INSERT THEN
                                ShowForm := TRUE
                            ELSE
                                ShowForm := FALSE;
                        UNTIL ItemParameter.NEXT = 0;
                    IF ShowForm THEN
                        MESSAGE('QC has been created');
                    IF ShowForm THEN BEGIN
                        ParameterResult.RESET;
                        ParameterResult.SETRANGE(ParameterResult."Item No.", rec."Source No.");
                        ParameterResult.SETRANGE(ParameterResult."Blend Order No", rec."No.");
                        ParameterResultForm.SETTABLEVIEW(ParameterResult);
                        ParameterResultForm.RUN;
                    END;
                end;
            }
        }
        modify("Change &Status")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //>>20Oct2018
                IF rec."Order Type" = rec."Order Type"::Primary THEN
                    IF rec."Refresh ProdOrder Qty" THEN
                        ERROR('Kindly Refresh Production Order');
                //<<20Oct2018

                //>>01Aug2017 
                IF rec."Man Hours" = 0 THEN
                    ERROR('Please Specify Man Hours for %1 : Production Order No.', rec."No.");

                IF rec."Machine Hours" = 0 THEN
                    ERROR('Please Specify Machine Hours for %1 : Production Order No.', rec."No.");

                //<<01Aug2017

            end;
        }
    }

    var
        myInt: Integer;
}