pageextension 50064 "Sales Invoice SubformExtCstm" extends "Sales Invoice Subform"
{
    layout
    {
        addafter(Type)
        {
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = all;
            }

            field("Appiles to Inv.No."; Rec."Appiles to Inv.No.")
            {
                ApplicationArea = all;
            }

            field("Final Item No."; rec."Final Item No.")
            {
                ApplicationArea = all;

                trigger OnLookup(var Text: Text): Boolean
                var
                    SalesInvLine: Record "Sales Invoice Line";

                BEGIN
                    //EBT0002
                    SalesInvLine.RESET;
                    SalesInvLine.SETRANGE(SalesInvLine."Document No.", rec."Appiles to Inv.No.");
                    SalesInvLine.SETRANGE(SalesInvLine.Type, SalesInvLine.Type::Item);
                    //IF SalesInvLine.FINDFIRST THEN
                    //BEGIN
                    IF PAGE.RUNMODAL(50047, SalesInvLine) = ACTION::LookupOK THEN BEGIN
                        rec."Final Item No." := SalesInvLine."No.";
                        rec.VALIDATE("Unit of Measure Code", SalesInvLine."Unit of Measure Code");
                        rec.VALIDATE("Qty. per Unit of Measure", SalesInvLine."Qty. per Unit of Measure");
                        rec.VALIDATE(Quantity, SalesInvLine.Quantity);
                        rec.VALIDATE("Gen. Prod. Posting Group", SalesInvLine."Gen. Prod. Posting Group");
                        rec.VALIDATE("Tax Group Code", SalesInvLine."Tax Group Code");
                        //  VALIDATE("Excise Prod. Posting Group", SalesInvLine."Excise Prod. Posting Group");
                        rec.VALIDATE("Final Line No.", SalesInvLine."Line No.");
                        //  RemoveDimension(rec."Document No.", rec."Line No.");
                        CopyDimensionValue(rec."Appiles to Inv.No.", rec."Final Line No.");
                    END;
                    //END;
                    //EBT0002
                END;
            }
        }

    }


    actions
    {
        // Add changes to page actions here
    }


    var
        myInt: Integer;
        SalesInvLine: Record 37;

    // MY PC 05 01 2024
    PROCEDURE CopyDimensionValue(InvNo: Code[20]; LineNo: Integer);
    VAR
        TempDimSetEntry: Record 480 temporary;
        cduDimMgt: Codeunit 408;
        RecDimSetEntry: Record 480;
        lSalesInvLine: Record 113;
        DocumentDimension: Record 349;
        PostedDocumentDimension: Record 352; // MY PC 
    BEGIN

        //RSPL-TC +
        lSalesInvLine.RESET;
        lSalesInvLine.SETRANGE("Document No.", InvNo);
        lSalesInvLine.SETRANGE("Line No.", LineNo);
        IF lSalesInvLine.FINDSET THEN BEGIN
            TempDimSetEntry.RESET;
            TempDimSetEntry.DELETEALL;
            RecDimSetEntry.RESET;
            RecDimSetEntry.SETRANGE("Dimension Set ID", lSalesInvLine."Dimension Set ID");
            IF RecDimSetEntry.FINDSET THEN
                REPEAT
                    TempDimSetEntry.INIT;
                    TempDimSetEntry.VALIDATE("Dimension Code", RecDimSetEntry."Dimension Code");
                    TempDimSetEntry.VALIDATE("Dimension Value Code", RecDimSetEntry."Dimension Value Code");
                    TempDimSetEntry.INSERT;
                UNTIL RecDimSetEntry.NEXT = 0;
            rec."Dimension Set ID" := cduDimMgt.GetDimensionSetID(TempDimSetEntry);
        END;
        //RSPL-TC -
    END;
}