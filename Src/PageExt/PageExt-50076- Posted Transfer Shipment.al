
// MY PC 10 01 2024
pageextension 50076 "PostedTransferShipmentExt" extends "Posted Transfer Shipment"
{
    layout
    {
        addafter("Transfer Order No.")
        {
            field("Frieght Type"; rec."Frieght Type")
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
            field("Empty Vehicle Weight"; rec."Empty Vehicle Weight")
            {
                ApplicationArea = all;
            }
            field("Vehicle Weight After loading"; rec."Vehicle Weight After loading")
            {
                ApplicationArea = all;
            }
            field("Net Weight of the Truck"; rec."Net Weight of the Truck")
            {
                ApplicationArea = all;
            }
            field("WH Bill Entry No."; rec."WH Bill Entry No.")
            {
                ApplicationArea = all;
            }
            field("Time In/Out"; rec."Time In/Out")
            {
                ApplicationArea = all;
            }

            field("Debond Bill Entry No."; rec."Debond Bill Entry No.")
            {
                ApplicationArea = all;
            }
            field("Transfer Indent No."; rec."Transfer Indent No.")
            {
                ApplicationArea = all;
            }
            field("F Form Date"; rec."F Form Date")
            {
                ApplicationArea = all;
            }
            field("F Form Amount"; rec."F Form Amount")
            {
                ApplicationArea = all;
            }
            field("F Form Issue Date"; rec."F Form Issue Date")
            {
                ApplicationArea = all;
            }
            field("F Form Rec. Date"; rec."F Form Rec. Date")
            {
                ApplicationArea = all;
            }
            field("F Form Remarks"; rec."F Form Remarks")
            {
                ApplicationArea = all;
            }
            field("F Form Period"; rec."F Form Period")
            {
                ApplicationArea = all;
            }
            field("Diff. Amount If any"; rec."Diff. Amount If any")
            {
                ApplicationArea = all;
            }
            field("BRT Cancelled Remarks"; rec."BRT Cancelled Remarks")
            {
                ApplicationArea = all;
            }

            field("Distance in kms"; rec."Distance in kms")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    myInt: Integer;
                    GSTLedgerEntry: Record "GST Ledger Entry";
                    RecGSTLE: Record "GST Ledger Entry";
                BEGIN
                    //RSPLSUM 11Jun2020
                    GSTLedgerEntry.RESET;
                    GSTLedgerEntry.SETRANGE("Document No.", rec."No.");
                    IF GSTLedgerEntry.FINDFIRST THEN BEGIN
                        IF GSTLedgerEntry."E-Way Bill No." = '' THEN BEGIN
                            RecGSTLE.RESET;
                            RecGSTLE.SETRANGE("Document No.", rec."No.");
                            IF RecGSTLE.FINDSET THEN
                                REPEAT
                                    RecGSTLE."Distance in kms" := rec."Distance in kms";
                                    RecGSTLE.MODIFY;
                                UNTIL RecGSTLE.NEXT = 0;
                        END ELSE
                            ERROR('E-Way Bill already generated');
                    END;
                    //RSPLSUM 11Jun2020
                END;
            }
            field("Road Permit No."; rec."Road Permit No.")
            {
                ApplicationArea = all;
            }

            field("Print BRT"; rec."Print BRT")
            {
                ApplicationArea = all;
            }
            field("Transporter Name"; rec."Transporter Name")
            {
                ApplicationArea = all;
            }
            field("Expected TPT Cost"; rec."Expected TPT Cost")
            {
                ApplicationArea = all;
            }
            field("Local Expected TPT Cost"; rec."Local Expected TPT Cost")
            {
                ApplicationArea = all;
            }
            field("EWB Transaction Type"; rec."EWB Transaction Type")
            {
                ApplicationArea = all;
            }
            field("EWB No."; rec."EWB No.")
            {
                ApplicationArea = all;
            }
            field("EWB Date"; rec."EWB Date")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here

        addafter("Attached Gate Entry")
        {

            action("Submit LR")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    recPostedGateEntry: Record "Posted Gate Entry Header";
                    //recGateLocSetup: Record "Gate Entry Location Setup";
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                begin
                    IF NOT (rec."Transport Type" = rec."Transport Type"::"Local+Intercity") THEN
                        ERROR('There is nothing to Submit');

                    rec.TESTFIELD(rec."LR/RR No.");
                    rec.TESTFIELD(rec."LR/RR Date");
                    rec.TESTFIELD(rec."Vehicle No.");

                    recPostedGateEntry.RESET;
                    recPostedGateEntry.SETRANGE(recPostedGateEntry."Gate Entry No.", rec."No.");
                    IF recPostedGateEntry.FINDFIRST THEN
                        ERROR('LR Details already submitted for this Shipment');
                    recPostedGateEntry.RESET;
                    recPostedGateEntry.INIT;
                    recPostedGateEntry."Entry Type" := recPostedGateEntry."Entry Type"::Outward;
                    //recGateLocSetup.GET(1, rec."Transfer-from Code");
                    //recPostedGateEntry."No. Series" := recGateLocSetup."Posting No. Series";
                    //recPostedGateEntry."No." := NoSeriesMgt.GetNextNo(recGateLocSetup."Posting No. Series", rec."Posting Date", TRUE);
                    recPostedGateEntry."Gate Entry No." := rec."No.";
                    recPostedGateEntry."Location Code" := rec."Transfer-from Code";
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
                END;



            }
        }
        addafter("&Navigate")
        {
            action("Transfer Invoice GSTCopy")
            {
                ApplicationArea = all;

                trigger OnAction()
                var
                    RecTSL: Record "Transfer Shipment Line";
                    TSH: Record "Transfer Shipment Header";
                begin

                    //CAS-22565-T8N8W6 13Aug2018
                    IF rec."Road Permit No." = '' THEN
                        ERROR('E-Way Bill No. cannot be blank');
                    //

                    //RSPLSUM 13Jan21


                    IF rec."Posting Date" > 20210113D THEN BEGIN
                        Rec.CALCFIELDS(rec.IRN);
                        RecTSL.RESET;
                        RecTSL.SETRANGE("Document No.", rec."No.");
                        RecTSL.SETFILTER(Quantity, '%1', 0);
                        //  RecTSL.SETFILTER(rec."Total GST Amount", '%1', 0);
                        IF RecTSL.FINDFIRST THEN BEGIN
                            IF rec.IRN = '' THEN
                                MESSAGE('Please generate IRN for this document');
                        END;
                    END;
                    //RSPLSUM 13Jan21

                    TSH.RESET;
                    TSH.SETRANGE("No.", rec."No.");
                    IF TSH.FINDFIRST THEN
                        REPORT.RUNMODAL(50154, TRUE, FALSE, TSH);
                end;

            }
        }
    }

    /// MY PC 10 01 2024
    trigger OnAfterGetRecord()
    var
        myInt: Integer;

        "LR/RRNoEditable": Boolean;
        "LR/RRDateEditable": Boolean;
        VehicaleNoEditable: Boolean;
        DrivNameEditable: Boolean;
        DrivLicNoEditable: Boolean;
        DrivMobNoEditable: Boolean;
        VechCapEtdiable: Boolean;
        ExpTPTCostEditable: Boolean;
        LocalLRNoEditable: Boolean;
        LocalLRDateEditable: Boolean;
        LocalVehicaleNoEditable: Boolean;
        LocalVechCapEtdiable: Boolean;
        LocalDrivNameEditable: Boolean;
        LocalDrivLicNoEditable: Boolean;
        LocalDrivMobNoEditable: Boolean;
        LocalExpTPTCostEditable: Boolean;
        BRTStatus: Text[30];
        BRTCancelledRemarEditable: Boolean;
        TransReceiptHeader: Record 5744;
        AccessControl: Record "Access Control";
        "TransferReceiptNo.": Text[100];
    BEGIN
        //RSPL-TC +
        CLEAR("LR/RRNoEditable");
        CLEAR("LR/RRDateEditable");
        CLEAR(VehicaleNoEditable);
        CLEAR(DrivNameEditable);
        CLEAR(DrivLicNoEditable);
        CLEAR(DrivMobNoEditable);
        CLEAR(VechCapEtdiable);
        CLEAR(ExpTPTCostEditable);
        CLEAR(LocalLRNoEditable);
        CLEAR(LocalLRDateEditable);
        CLEAR(LocalVehicaleNoEditable);
        CLEAR(LocalVechCapEtdiable);
        CLEAR(LocalDrivNameEditable);
        CLEAR(LocalDrivLicNoEditable);
        CLEAR(LocalDrivMobNoEditable);
        CLEAR(LocalExpTPTCostEditable);
        //RSPL-TC -

        //EBT STIVAN (29052012) --To Capture the Receipt No. -----START
        TransReceiptHeader.RESET;
        TransReceiptHeader.SETRANGE(TransReceiptHeader."Transfer Order No.", rec."Transfer Order No.");
        IF TransReceiptHeader.FIND('-') THEN
            "TransferReceiptNo." := TransReceiptHeader."No."
        ELSE
            "TransferReceiptNo." := '';

        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETRANGE("Role ID", 'LRDETAILS');
        IF AccessControl.FINDFIRST THEN BEGIN
            //EBT STIVAN ---(19072013)--- To make below Field EDITABLE as per ROLE Assigned -------END
            //EBT Stivan ---(28/11/2012)--- LR Details should be Editable as per Transport type ------START
            IF rec."Transport Type" = rec."Transport Type"::"Local+Intercity" THEN BEGIN

                // RSPL-TC +
                "LR/RRNoEditable" := FALSE;
                "LR/RRDateEditable" := FALSE;
                VehicaleNoEditable := FALSE;
                DrivNameEditable := FALSE;
                DrivLicNoEditable := FALSE;
                DrivMobNoEditable := FALSE;
                VechCapEtdiable := FALSE;

                LocalLRNoEditable := TRUE;
                LocalLRDateEditable := TRUE;
                LocalVehicaleNoEditable := TRUE;
                LocalVechCapEtdiable := TRUE;
                LocalDrivNameEditable := TRUE;
                LocalDrivLicNoEditable := TRUE;
                LocalDrivMobNoEditable := TRUE;
                // RSPL-TC -
            END;

            IF rec."Transport Type" = rec."Transport Type"::Intercity THEN BEGIN

                // RSPL-TC +
                "LR/RRNoEditable" := TRUE;
                "LR/RRDateEditable" := TRUE;
                VehicaleNoEditable := TRUE;
                DrivNameEditable := TRUE;
                DrivLicNoEditable := TRUE;
                DrivMobNoEditable := TRUE;
                VechCapEtdiable := TRUE;

                LocalLRNoEditable := FALSE;
                LocalLRDateEditable := FALSE;
                LocalVehicaleNoEditable := FALSE;
                LocalVechCapEtdiable := FALSE;
                LocalDrivNameEditable := FALSE;
                LocalDrivLicNoEditable := FALSE;
                LocalDrivMobNoEditable := FALSE;
                // RSPL-TC -
            END;

            IF (rec."Transport Type" = rec."Transport Type"::"Cust.Transport") THEN BEGIN

                // RSPL-TC +
                "LR/RRNoEditable" := FALSE;
                "LR/RRDateEditable" := FALSE;
                VehicaleNoEditable := FALSE;
                DrivNameEditable := FALSE;
                DrivLicNoEditable := FALSE;
                DrivMobNoEditable := FALSE;
                VechCapEtdiable := FALSE;

                LocalLRNoEditable := FALSE;
                LocalLRDateEditable := FALSE;
                LocalVehicaleNoEditable := FALSE;
                LocalVechCapEtdiable := FALSE;
                LocalDrivNameEditable := FALSE;
                LocalDrivLicNoEditable := FALSE;
                LocalDrivMobNoEditable := FALSE;
                // RSPL-TC -
            END;
            //EBT Stivan ---(28/11/2012)--- LR Details should be Editable as per Transport type --------END

        END;//EBT STIVAN ---(19072013)--- To make below Field EDITABLE as per ROLE Assigned

        IF rec."BRT Cancelled" = TRUE THEN BEGIN
            BRTStatus := 'CANCELLED';
            //CurrForm."BRT Cancelled Remarks".EDITABLE := TRUE;
            BRTCancelledRemarEditable := TRUE
        END
        ELSE BEGIN
            BRTStatus := '';
            //CurrForm."BRT Cancelled Remarks".EDITABLE := FALSE;
            BRTCancelledRemarEditable := FALSE;
        END;
    END;

    /// MY PC 10 01 2024
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
    BEGIN

        IF rec."BRT Cancelled" = TRUE THEN BEGIN
            IF rec."BRT Cancelled Remarks" = '' THEN
                ERROR('Please Update BRT Cancelled Remarks');
        END;
    END;


    var
        myInt: Integer;



}