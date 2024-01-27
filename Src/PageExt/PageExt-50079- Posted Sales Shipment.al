// MY PC 10 01 2024
pageextension 50079 "PostedSalesShipmentExt" extends "Posted Sales Shipment"
{
    layout
    {
        addafter("GST Customer Type")
        {
            field("Full Name"; rec."Full Name")
            {
                ApplicationArea = all;
            }
            field("Driver's Name"; rec."Driver's Name")
            {
                ApplicationArea = all;
            }
            field("Driver's License No."; rec."Driver's License No.")
            {
                ApplicationArea = all;
            }
            field("Driver's Mobile No."; rec."Driver's Mobile No.")
            {
                ApplicationArea = all;
            }
            field("Vehicle Capacity"; rec."Vehicle Capacity")
            {
                ApplicationArea = all;
            }
            field("Vehicle For Location"; rec."Vehicle For Location")
            {
                ApplicationArea = all;
            }
            field("Transport Type"; rec."Transport Type")
            {
                ApplicationArea = all;
            }

            field("Local Driver's Name"; rec."Local Driver's Name")
            {
                ApplicationArea = all;
            }

            field("Local Driver's License No."; rec."Local Driver's License No.")
            {
                ApplicationArea = all;
            }
            field("Local Driver's Mobile No."; rec."Local Driver's Mobile No.")
            {
                ApplicationArea = all;
            }
            field("Local Vehicle Capacity"; rec."Local Vehicle Capacity")
            {
                ApplicationArea = all;
            }
            field("Local Vehicle No."; rec."Local Vehicle No.")
            {
                ApplicationArea = all;
            }
            field("Local LR No."; rec."Local LR No.")
            {
                ApplicationArea = all;
            }
            field("Local LR Date"; rec."Local LR Date")
            {
                ApplicationArea = all;
            }
            field("CT3 Order"; rec."CT3 Order")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    //EBT Paramita
                    IF rec."CT3 Order" THEN BEGIN
                        IF rec."CT1 Order" THEN
                            ERROR('U cannot select CT3 And CT1 both');
                    END;
                    //EBT Paramita

                end;
            }
            field("CT3 No."; rec."CT3 No.")
            {
                ApplicationArea = all;
            }
            field("CT3 Date"; rec."CT3 Date")
            {
                ApplicationArea = all;
            }


            field("ARE3 No."; rec."ARE3 No.")
            {
                ApplicationArea = all;

            }
            field("ARE3 Date"; rec."ARE3 Date")
            {
                ApplicationArea = all;
            }
            field("CT1 Order"; rec."CT1 Order")
            {
                ApplicationArea = all;
            }
            field("CT1 No."; rec."CT1 No.")
            {
                ApplicationArea = all;
            }

            field("CT1 Date"; rec."CT1 Date")
            {
                ApplicationArea = all;
            }
            field("ARE1 No."; rec."ARE1 No.")
            {
                ApplicationArea = all;
            }
            field("ARE1 Date"; rec."ARE1 Date")
            {
                ApplicationArea = all;
            }
            field("Ex-Factory"; rec."Ex-Factory")
            {
                ApplicationArea = all;
            }
            field("Under Rebate"; rec."Under Rebate")
            {
                ApplicationArea = all;
            }

            field("Under LUT"; rec."Under LUT")
            {
                ApplicationArea = all;
            }

            field("Export Under Rebate"; rec."Export Under Rebate")
            {
                ApplicationArea = all;
            }
            field("Export Under LUT"; rec."Export Under LUT")
            {
                ApplicationArea = all;
            }
            field("Credit Limit Approval"; rec."Credit Limit Approval")
            {
                ApplicationArea = all;
            }
            field("Get Entry Outward"; rec."Get Entry Outward")
            {
                ApplicationArea = all;
            }
            field("Road Permit No."; rec."Road Permit No.")
            {
                ApplicationArea = all;
            }
            field("Freight Type"; rec."Freight Type")
            {
                ApplicationArea = all;

                //  OptionCaptionML = ENU =" ,PAID,TO PAY,PAY & ADD IN BILL,SELF PICKUP";
                // OptionString =[ ,PAID,TO PAY,PAY & ADD IN BILL,SELF PICKUP];

            }
            field("Freight Charges"; rec."Freight Charges")
            {
                ApplicationArea = all;
            }
            field("Sales Invoice No"; rec."Sales Invoice No")
            {
                ApplicationArea = all;
            }

            field("Cash Discount Percentage"; rec."Cash Discount Percentage")
            {
                ApplicationArea = all;
            }
            field("Sales Order No"; rec."Sales Order No")
            {
                ApplicationArea = all;
                TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order));
                Editable = false;
            }
        }

    }

    actions
    {
        // Add changes to page actions here

        addafter("&Navigate")

        {
            action("Submit &LR")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    recPostedGateEntry: Record "Posted Gate Entry Header";
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                begin
                    //EBT/LOCALINTERCITY/0001
                    IF (rec."Transport Type" = rec."Transport Type"::"Local+Intercity") THEN BEGIN
                        rec.TESTFIELD(rec."LR/RR No.");
                        rec.TESTFIELD(rec."LR/RR Date");
                        rec.TESTFIELD(rec."Vehicle No.");
                    END;
                    IF (rec."Transport Type" = rec."Transport Type"::Intercity) THEN BEGIN
                        rec.TESTFIELD(rec."Local LR No.");
                        rec.TESTFIELD(rec."Local LR Date");
                        rec.TESTFIELD(rec."Local Vehicle No.");
                    END;

                    IF (rec."Local Vehicle No." <> '') AND (rec."LR/RR No." <> '') THEN
                        ERROR('You can post only one LR details');

                    IF rec."LR/RR No." <> '' THEN BEGIN
                        recPostedGateEntry.RESET;
                        recPostedGateEntry.SETRANGE(recPostedGateEntry."Gate Entry No.", rec."No.");
                        IF recPostedGateEntry.FINDFIRST THEN
                            ERROR('LR Details already submitted for this Shipment');
                        recPostedGateEntry.RESET;
                        recPostedGateEntry.INIT;
                        recPostedGateEntry."Entry Type" := recPostedGateEntry."Entry Type"::Outward;
                        //  recGateLocSetup.GET(1, "Location Code");
                        // recPostedGateEntry."No. Series" := recGateLocSetup."Posting No. Series";
                        // recPostedGateEntry."No." := NoSeriesMgt.GetNextNo(recGateLocSetup."Posting No. Series", "Posting Date", TRUE);
                        recPostedGateEntry."Gate Entry No." := rec."No.";
                        recPostedGateEntry."Location Code" := rec."Location Code";
                        recPostedGateEntry."LR/RR No." := rec."LR/RR No.";
                        recPostedGateEntry."LR/RR Date" := rec."LR/RR Date";
                        recPostedGateEntry.Transporter := rec."Shipping Agent Code";
                        recPostedGateEntry."Posting Date" := WORKDATE;
                        recPostedGateEntry."Posting Time" := TIME;
                        recPostedGateEntry."Vehicle No." := rec."Vehicle No.";
                        recPostedGateEntry."Driver's Name" := rec."Driver's Name";
                        recPostedGateEntry."Driver's License No." := rec."Driver's License No.";
                        recPostedGateEntry."Driver's Mobile No." := rec."Driver's Mobile No.";
                        recPostedGateEntry."Vehicle Capacity" := rec."Vehicle Capacity";
                        recPostedGateEntry.INSERT;
                        MESSAGE('LR details have been updated successfully');
                    END
                    ELSE
                        IF rec."Local LR No." <> '' THEN BEGIN
                            recPostedGateEntry.RESET;
                            recPostedGateEntry.SETRANGE(recPostedGateEntry."Gate Entry No.", rec."No.");
                            IF recPostedGateEntry.FINDFIRST THEN
                                ERROR('LR Details already submitted for this Shipment');
                            recPostedGateEntry.RESET;
                            recPostedGateEntry.INIT;
                            recPostedGateEntry."Entry Type" := recPostedGateEntry."Entry Type"::Outward;
                            // recGateLocSetup.GET(1, rec."Location Code");
                            //  recPostedGateEntry."No. Series" := recGateLocSetup."Posting No. Series";
                            // recPostedGateEntry."No." := NoSeriesMgt.GetNextNo(recGateLocSetup."Posting No. Series", rec."Posting Date", TRUE);
                            recPostedGateEntry."Gate Entry No." := rec."No.";
                            recPostedGateEntry."Location Code" := rec."Location Code";
                            recPostedGateEntry."LR/RR No." := rec."Local LR No.";
                            recPostedGateEntry."LR/RR Date" := rec."Local LR Date";
                            recPostedGateEntry.Transporter := rec."Shipping Agent Code";
                            recPostedGateEntry."Posting Date" := WORKDATE;
                            recPostedGateEntry."Posting Time" := TIME;
                            recPostedGateEntry."Vehicle No." := rec."Local Vehicle No.";
                            recPostedGateEntry."Driver's Name" := rec."Local Driver's Name";
                            recPostedGateEntry."Driver's License No." := rec."Local Driver's License No.";
                            recPostedGateEntry."Driver's Mobile No." := rec."Local Driver's Mobile No.";
                            recPostedGateEntry."Vehicle Capacity" := rec."Local Vehicle Capacity";
                            recPostedGateEntry.INSERT;
                            MESSAGE('LR details have been updated successfully');

                        END;
                    //EBT/LOCALINTERCITY/0001
                end;

            }
        }
    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        SalesInvoiceHeader: Record 112;
        "PostedSalesInvoiceNo.": Code[20];
        "LR/RRNoEditable": Boolean;
        "LR/RRDateEditable": Boolean;
        VehicaleNoEditable: Boolean;
        DrivNameEditable: Boolean;
        DrivLicNoEditable: Boolean;
        DrivMobNoEditable: Boolean;
        VechCapEtdiable: Boolean;
        LocalLRNoEditable: Boolean;
        LocalLRDateEditable: Boolean;
        LocalVehicaleNoEditable: Boolean;
        LocalVechCapEtdiable: Boolean;
        LocalDrivNameEditable: Boolean;
        LocalDrivLicNoEditable: Boolean;
        LocalDrivMobNoEditable: Boolean;

    BEGIN

        IF rec."Sales Invoice No" = '' THEN BEGIN
            SalesInvoiceHeader.RESET;
            SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Order No.", rec."Order No.");
            IF SalesInvoiceHeader.FIND('-') THEN BEGIN
                "PostedSalesInvoiceNo." := SalesInvoiceHeader."No."
            END
        END
        ELSE
            "PostedSalesInvoiceNo." := '';

        IF rec."Transport Type" = rec."Transport Type"::"Local+Intercity" THEN BEGIN

            // RSPL-TC +
            "LR/RRNoEditable" := TRUE;
            "LR/RRDateEditable" := TRUE;
            VehicaleNoEditable := TRUE;
            DrivNameEditable := TRUE;
            DrivLicNoEditable := TRUE;
            DrivMobNoEditable := TRUE;
            VechCapEtdiable := TRUE;
            // RSPL-TC -
        END
        ELSE BEGIN

            // RSPL-TC +
            "LR/RRNoEditable" := FALSE;
            "LR/RRDateEditable" := FALSE;
            VehicaleNoEditable := FALSE;
            DrivNameEditable := FALSE;
            DrivLicNoEditable := FALSE;
            DrivMobNoEditable := FALSE;
            VechCapEtdiable := FALSE;
            // RSPL-TC -
        END;
        //EBT/LOCALINTERCITY/0001
    END;

    var
        myInt: Integer;
}