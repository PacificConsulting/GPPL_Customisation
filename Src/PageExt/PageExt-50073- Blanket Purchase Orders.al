
// MY PC 08 01 2024
pageextension 50073 "BlanketPurchaseOrdesrExt" extends "Blanket Purchase Orders"
{
    layout
    {
        // Add changes to page layout here


        addafter(Status)
        {
            field("Approval Status"; rec."Approval Status")
            {
                ApplicationArea = all;
            }
        }
    }


    // MY PC 08 01 2024

    actions
    {
        // Add changes to page actions here

        modify(Reopen)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
                SAE11: Record 50009;
                SalesApproval: Record 50008;
                ReleasePurchDoc: Codeunit 415;
                SalesApprovalEntry: Record 50009;
            begin
                //14Mar2018
                IF rec."Level1 Approval" THEN BEGIN
                    SAE11.RESET;
                    SAE11.SETCURRENTKEY("Document No.", "Version No.");
                    SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Blanket PO");
                    SAE11.SETRANGE("Document No.", rec."No.");
                    SAE11.SETRANGE(Approved, TRUE);
                    IF SAE11.FINDLAST THEN BEGIN
                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SAE11."Document Type");
                        SalesApproval.SETRANGE("User ID", SAE11."User ID");
                        SalesApproval.SETRANGE("Approvar ID", USERID);
                        IF NOT SalesApproval.FINDLAST THEN
                            ERROR('Required Level1 Approvar for Reopening %1 Document No.', rec."No.");
                    END;
                END;

                IF rec."Level2 Approval" THEN BEGIN
                    SAE11.RESET;
                    SAE11.SETCURRENTKEY("Document No.", "Version No.");
                    SAE11.SETRANGE("Document Type", SAE11."Document Type"::"Blanket PO");
                    SAE11.SETRANGE("Document No.", rec."No.");
                    SAE11.SETRANGE(Approved, TRUE);
                    IF SAE11.FINDLAST THEN BEGIN

                        SalesApproval.RESET;
                        SalesApproval.SETRANGE("Document Type", SAE11."Document Type");
                        SalesApproval.SETRANGE("User ID", SAE11."User ID");
                        //SalesApproval.SETRANGE("Approvar ID",SAE11."Approvar ID");
                        SalesApproval.SETRANGE("Level2 Approvar ID", USERID);
                        IF NOT SalesApproval.FINDFIRST THEN
                            ERROR('Required Level2 Approvar for Reopening %1 Document No.', rec."No.");
                    END;
                END;

                SalesApprovalEntry.RESET;
                SalesApprovalEntry.SETRANGE("Document Type", SalesApprovalEntry."Document Type"::"Blanket PO");
                SalesApprovalEntry.SETRANGE("Document No.", rec."No.");
                SalesApprovalEntry.SETRANGE(Approved, FALSE);
                IF SalesApprovalEntry.FINDFIRST THEN BEGIN
                    SalesApprovalEntry.DELETEALL(TRUE);
                END;

                rec."Send For Approval" := FALSE;
                rec."Approval Status" := rec."Approval Status"::Open;
                rec."Level1 Approval" := FALSE;
                rec."Level2 Approval" := FALSE;
                rec."Approved by Finance" := FALSE;//06May2019
                rec."Finance Rejected" := FALSE;//06May2019
                rec."Finance Rejection Remarks" := '';//06May2019
                rec.MODIFY;
                //

                ReleasePurchDoc.PerformManualReopen(Rec);
            END;


        }


        addafter(Print)
        {
            action("Purchase Order - &Regular")
            {
                ApplicationArea = ALL;
                trigger OnAction()
                var
                    myInt: Integer;
                    PurchLine: Record "Purchase Line";
                    OrderAddress: Record 224;
                    vendor: Record 23;
                BEGIN

                    IF rec."Payment Terms Code" = '' THEN
                        ERROR('Payment Terms Code is Blank');

                    //EBT STIVAN ---(1307012)-----------------------------------------------------START
                    IF rec."Order Address Code" <> '' THEN BEGIN
                        PurchLine.RESET;
                        PurchLine.SETRANGE(PurchLine."Document No.", rec."No.");
                        IF PurchLine.FINDSET THEN
                            IF (PurchLine."Tax Amount" <> 0) THEN BEGIN
                                IF rec."Vendor TIN No." = '' THEN BEGIN
                                    OrderAddress.GET(rec."Buy-from Vendor No.", rec."Order Address Code");
                                    IF (OrderAddress."L.S.T. No." = '') THEN
                                        ERROR('TIN No. is Blank');
                                    //MESSAGE('TIN No. is Blank');
                                END;
                            END;
                    END;

                    IF rec."Order Address Code" = '' THEN BEGIN
                        PurchLine.RESET;
                        PurchLine.SETRANGE(PurchLine."Document No.", rec."No.");
                        IF PurchLine.FINDSET THEN
                            IF (PurchLine."Tax Amount" <> 0) THEN BEGIN
                                IF rec."Vendor TIN No." = '' THEN BEGIN
                                    Vendor.GET(rec."Buy-from Vendor No.");
                                    IF (Vendor."L.S.T. No." = '') THEN
                                        ERROR('TIN No. is Blank');
                                    //MESSAGE('TIN No. is Blank');
                                END;
                            END;
                    END;
                    //EBT STIVAN ---(13072012)-------------------------------------------------------END

                    //  DocPrint.PrintPurchHeader(Rec);
                END;
            }
        }
    }

    var
        myInt: Integer;
}