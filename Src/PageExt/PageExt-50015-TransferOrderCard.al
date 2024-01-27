pageextension 50015 TransferOrderCardCstm extends "Transfer Order"
{

    layout
    {
        // Add changes to page layout here
        /// MY PC 09 01 2024
        addafter("No.")
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
            field("Shipping No. Series"; rec."Shipping No. Series")
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
            field("Distance in kms"; rec."Distance in kms")
            {
                ApplicationArea = all;
            }
            field("Road Permit No."; rec."Road Permit No.")
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

            field("Expected Loading"; rec."Expected Loading")
            {
                ApplicationArea = all;
            }
            field("Expected Unloading"; rec."Expected Unloading")
            {
                ApplicationArea = all;
            }
            field("EWB Transaction Type"; rec."EWB Transaction Type")
            {
                ApplicationArea = all;
            }
        }


    }


    actions
    {
        modify("Reo&pen")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
                TransferShipmentHeader: Record "Transfer Shipment Header";
                RecLoc: Record Location;
            begin
                IF (USERID <> 'GPUAE\FAHIM.AHMAD') AND (USERID <> 'GPUAE\RAVI.KHAMBAL') AND (UPPERCASE(USERID) <> 'GPUAE\ROBOSOFT-SUPPORT') THEN BEGIN
                    TransferShipmentHeader.RESET;
                    TransferShipmentHeader.SETRANGE(TransferShipmentHeader."Transfer Order No.", Rec."No.");
                    IF TransferShipmentHeader.FIND('-') THEN BEGIN
                        RecLoc.GET(Rec."Transfer-from Code"); //RSPL01
                        IF NOT (RecLoc."Location Type" = RecLoc."Location Type"::Bonded) THEN //RSPL01
                            ERROR('You can not Reopen the TRO as Shipment is posted')
                        //END
                        //ELSE
                        //ReleaseTransferDoc.Reopen(Rec);
                    END;// ELSE
                        //ReleaseTransferDoc.Reopen(Rec);
                END;//
                    //ELSE
                    //ReleaseTransferDoc.Reopen(Rec);
                    //EBT STIVAN---(06/08/2013)---Error Message Pop Up, IF Shipment of TRO is Done then user is not allowed to Reopem the TRO-----END

            end;

        }
        modify("Re&lease")
        {

            trigger OnBeforeAction()
            var
                TL09: Record 5741;
                FromCode09: Code[10];
                ToCode09: Code[10];
                Loc09: Record 14;
                TransferLineNew: Record 5741;
                TLNew: Record 5741;
                RecLocNew: Record 14;
                SalesLineRec1: Record "Sales Line";
                SalesLineRec2: Record "Sales Line";
                GSTGrpCode: Code[20];
                recSalesApproval: Record "Sales Approval";
            begin
                //TESTFIELD("Shipment Method Code");//RSPLSUM 09Nov2020

                Rec.TESTFIELD("Frieght Type"); //EBT STIVAN---(23/07/2013)
                                               //NB Start
                SalesLineRec1.RESET;
                SalesLineRec1.SETRANGE("Document No.", Rec."No.");
                //SalesLineRec2.SETRANGE("Document No.",SalesLineRec1."Document No.");
                IF SalesLineRec1.FINDFIRST THEN
                    GSTGrpCode := SalesLineRec1."GST Group Code";

                SalesLineRec2.RESET;
                SalesLineRec2.SETRANGE("Document No.", Rec."No.");
                IF SalesLineRec2.FINDFIRST THEN
                    REPEAT
                        IF SalesLineRec2."GST Group Code" <> GSTGrpCode THEN
                            ERROR('GST Group code should be same for each line');
                    UNTIL SalesLineRec2.NEXT = 0;
                //NB End

                //RSPLSUM BEGIN>>--Auto calculate structure values--
                RecLocNew.RESET;
                IF RecLocNew.GET(Rec."Transfer-from Code") THEN BEGIN
                    IF RecLocNew."Location Type" <> RecLocNew."Location Type"::Bonded THEN BEGIN
                        //>>07July2017 LineAmount Validation
                        IF (Rec."Transfer-from Code" <> 'CAPCON') AND (REc."Transfer-to Code" <> 'CAPCON') THEN //27July2017
                        BEGIN

                            TLNew.RESET;
                            TLNew.SETRANGE("Document No.", Rec."No.");
                            IF TLNew.FINDSET THEN
                                REPEAT
                                    IF TLNew.Amount = 0 THEN BEGIN
                                        ERROR('Line Amount Cannot be Zero.\ Document No.: %1 \ Line No.: %2 ', TLNew."Document No.", TLNew."Line No.");

                                    END;

                                UNTIL TLNew.NEXT = 0;
                        END;
                        //<<07July2017 LineAmount Validation 


                        // TransferLineNew.CalculateStructures(Rec);
                        // TransferLineNew.AdjustStructureAmounts(Rec);
                        // TransferLineNew.UpdateTransLines(Rec);

                        //>>RB-N 08Nov2017

                        // IF Structure = '' THEN BEGIN

                        //     DGST08.RESET;
                        //     DGST08.SETRANGE("Document No.", "No.");
                        //     IF DGST08.FINDFIRST THEN BEGIN
                        //         DGST08.DELETEALL(TRUE);
                        //     END;
                        // END;
                        //<<RB-N 08Nov2017

                    END;
                END;
                //RSPLSUM END<<
                IF NOT (Rec."Transfer-from Code" = 'GDN0002') THEN BEGIN
                    IF (Rec."Transfer-to Code" = 'INVADJ0001') AND (UPPERCASE(USERID) <> 'GPUAE\UNNIKRISHNAN.VS') AND (UPPERCASE(USERID) <> 'GPUAE\KAUSTUBH.PARAB') AND (UPPERCASE(USERID) <> 'GPUAE\robosoft.support1') THEN //RSPL-SOURAV 110215
                        ERROR('You are not authorised to Release the Transfer Order');  //RSPL-SOURAV 110215
                    recSalesApproval.RESET;
                    recSalesApproval.SETRANGE(recSalesApproval."Approvar ID", USERID);
                    IF recSalesApproval.FINDFIRST THEN BEGIN
                    END
                    ELSE
                        ERROR('You are not authorised to Release the Transfer order');
                END
                ELSE BEGIN
                    //ReleaseTransferDoc.RUN(Rec);
                END;


            end;

        }
        // MY PC 09 01 2024
        modify(Post)
        {
            trigger OnBeforeAction()

            var
                myInt: Integer;
                TL: Record 5741;
                TransferLine: Record 5741;
                TL09: Record 5741;
                Loc09: Record 14;
                FromCode09: Code[10];
                ToCode09: Code[10];

                SalesLineRec1: Record 37;
                SalesLineRec2: Record 37;
                GSTGrpCode: Code[10];
            // GST09: Record 16412;
            begin
                //TESTFIELD("Shipment Method Code");//RSPLSUM 09Nov2020

                rec.TESTFIELD("EWB Transaction Type");//RSPLSUM 11Jun2020

                //NB Start
                SalesLineRec1.RESET;
                SalesLineRec1.SETRANGE("Document No.", rec."No.");
                //SalesLineRec2.SETRANGE("Document No.",SalesLineRec1."Document No.");
                IF SalesLineRec1.FINDFIRST THEN
                    GSTGrpCode := SalesLineRec1."GST Group Code";

                SalesLineRec2.RESET;
                SalesLineRec2.SETRANGE("Document No.", rec."No.");
                IF SalesLineRec2.FINDFIRST THEN
                    REPEAT
                        IF SalesLineRec2."GST Group Code" <> GSTGrpCode THEN
                            ERROR('GST Group code should be same for each line');
                    UNTIL SalesLineRec2.NEXT = 0;
                //NB End

                //25Jul2017  CalculateStructure Before Posting

                //25July2017 LineAmount Validation
                IF (rec."Transfer-from Code" <> 'CAPCON') AND (rec."Transfer-to Code" <> 'CAPCON') THEN //27July2017
    BEGIN
                    TL.RESET;
                    TL.SETRANGE("Document No.", rec."No.");
                    IF TL.FINDSET THEN
                        REPEAT
                            IF TL.Amount = 0 THEN BEGIN
                                ERROR('Line Amount Cannot be Zero.\ Document No.: %1 \ Line No.: %2 ', TL."Document No.", TL."Line No.");

                            END;

                        UNTIL TL.NEXT = 0;
                END;
                //

                //09Aug2017 SplitLine GST Calaculation
                CLEAR(FromCode09);
                CLEAR(ToCode09);
                Loc09.RESET;
                IF Loc09.GET(rec."Transfer-from Code") THEN
                    FromCode09 := Loc09."State Code";

                Loc09.RESET;
                IF Loc09.GET(rec."Transfer-to Code") THEN
                    ToCode09 := Loc09."State Code";

                // IF (FromCode09 <> ToCode09) AND (Structure <> '') THEN BEGIN // MY PC 09 01 2024
                IF (FromCode09 <> ToCode09) THEN BEGIN
                    TL09.RESET;
                    TL09.SETRANGE("Document No.", rec."No.");
                    TL09.SETRANGE("Derived From Line No.", 0);
                    TL09.SETRANGE("Completely Shipped", FALSE);
                    TL09.SETRANGE("Split Line", TRUE);
                    TL09.SETFILTER("Splited From Line", '%1', 0);
                    IF TL09.FINDSET THEN
                        REPEAT

                        // GST09.RESET;
                        // GST09.SETRANGE("Document No.", TL09."Document No.");
                        // GST09.SETRANGE("Line No.", TL09."Line No.");
                        //  IF NOT GST09.FINDFIRST THEN BEGIN
                        //     ERROR('Please Calculate Structure Value for Split Line.\ Document No.: %1 \ Line No.: %2 ', TL09."Document No.", TL09."Line No.");

                        // END;

                        UNTIL TL09.NEXT = 0;
                END;
                //

                // TransferLine.CalculateStructures(Rec);
                // TransferLine.AdjustStructureAmounts(Rec);
                // TransferLine.UpdateTransLines(Rec);

                //

                CODEUNIT.RUN(CODEUNIT::"TransferOrder-Post (Yes/No)", Rec);
            END;


        }

    }
    /// MY PC 09 01 2024

    trigger OnOpenPage()
    var
        recTH: Record "Transfer Header";
        recTL: Record "Transfer Line";
        ReservEntr: Record 337;

    begin
        IF (rec."Transfer Indent No" = '') AND (rec."Last Shipment No." = '') AND (rec."Created Date" <> 0D) THEN BEGIN
            //  rec."7Days" := CALCDATE('-7D', TODAY);

            recTH.RESET;
            recTH.SETRANGE(recTH.Status, recTH.Status::Open);
            recTH.SETFILTER(recTH."Transfer Indent No", '%1', '');
            recTH.SETFILTER(recTH."Last Shipment No.", '%1', '');
            //  recTH.SETFILTER(recTH."Created Date", '%1..%2', 0D, rec."7Days");
            IF recTH.FINDFIRST THEN
                REPEAT

                    recTL.RESET;
                    recTL.SETRANGE(recTL."Document No.", recTH."No.");
                    IF recTL.FINDSET THEN BEGIN
                        recTL.DELETEALL;
                    END;

                    ReservEntr.RESET;
                    ReservEntr.SETRANGE(ReservEntr."Source ID", recTH."No.");
                    IF ReservEntr.FINDSET THEN BEGIN
                        ReservEntr.DELETEALL;
                    END;

                UNTIL recTH.NEXT = 0;

            recTH.RESET;
            recTH.SETRANGE(recTH.Status, recTH.Status::Open);
            recTH.SETFILTER(recTH."Transfer Indent No", '%1', '');
            recTH.SETFILTER(recTH."Last Shipment No.", '%1', '');
            // recTH.SETFILTER(recTH."Created Date", '%1..%2', 0D, rec."7Days");
            IF recTH.FINDSET THEN BEGIN
                recTH.DELETEALL;
            END;

        END;

        recTH.RESET;
        recTH.SETRANGE(recTH.Status, recTH.Status::Open);
        recTH.SETFILTER(recTH."Transfer Indent No", '%1', '');
        recTH.SETFILTER(recTH."Last Shipment No.", '%1', '');
        //  recTH.SETFILTER(recTH."Created Date", '%1..%2', 0D, rec."7Days");

        IF recTH.FINDFIRST THEN
            REPEAT

                recTL.RESET;
                recTL.SETRANGE(recTL."Document No.", recTH."No.");
                IF recTL.FINDSET THEN BEGIN
                    recTL.DELETEALL;
                END;

                ReservEntr.RESET;
                ReservEntr.SETRANGE(ReservEntr."Source ID", recTH."No.");
                IF ReservEntr.FINDSET THEN BEGIN
                    ReservEntr.DELETEALL;
                END;

            UNTIL recTH.NEXT = 0;

        recTH.RESET;
        recTH.SETRANGE(recTH.Status, recTH.Status::Open);
        recTH.SETFILTER(recTH."Transfer Indent No", '%1', '');
        recTH.SETFILTER(recTH."Last Shipment No.", '%1', '');
        recTH.SETFILTER(recTH."Created Date", '%1', TODAY - 1);
        IF recTH.FINDSET THEN BEGIN
            recTH.DELETEALL;
        END;

        IF rec."Posting Date" = 0D THEN BEGIN
            IF rec."Posting Date" = TODAY THEN BEGIN
                rec."Posting Date" := TODAY;
                rec.MODIFY;
            END;


            IF rec."Receipt Date" = TODAY THEN BEGIN
                rec."Receipt Date" := TODAY;
                rec.MODIFY;
            END;
        END;
    END;



    trigger OnAfterGetRecord()
    var
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
        TransferShipmentHeader: Record "Transfer Shipment Header";
        UserMaping: Record 2000000053;
        BRTNO: Code[20];


    begin
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

        TransferShipmentHeader.RESET;
        TransferShipmentHeader.SETRANGE(TransferShipmentHeader."Transfer Order No.", rec."No.");
        IF TransferShipmentHeader.FIND('-') THEN
            BRTNO := TransferShipmentHeader."No."
        ELSE
            BRTNO := '';

        IF rec."Transport Type" = rec."Transport Type"::"Local+Intercity" THEN BEGIN

            // RSPL-TC +
            "LR/RRNoEditable" := FALSE;
            "LR/RRDateEditable" := FALSE;
            VehicaleNoEditable := FALSE;
            DrivNameEditable := FALSE;
            DrivLicNoEditable := FALSE;
            DrivMobNoEditable := FALSE;
            //VechCapEtdiable := FALSE;
            VechCapEtdiable := TRUE;
            ExpTPTCostEditable := TRUE;

            LocalLRNoEditable := TRUE;
            LocalLRDateEditable := TRUE;
            LocalVehicaleNoEditable := TRUE;
            LocalVechCapEtdiable := TRUE;
            LocalDrivNameEditable := TRUE;
            LocalDrivLicNoEditable := TRUE;
            LocalDrivMobNoEditable := TRUE;
            LocalExpTPTCostEditable := TRUE;
            // RSPL-TC -
        END;

        IF rec."Transport Type" = rec."Transport Type"::Intercity THEN BEGIN

            "LR/RRNoEditable" := TRUE;
            "LR/RRDateEditable" := TRUE;
            VehicaleNoEditable := TRUE;
            DrivNameEditable := TRUE;
            DrivLicNoEditable := TRUE;
            DrivMobNoEditable := TRUE;
            VechCapEtdiable := TRUE;
            ExpTPTCostEditable := TRUE;

            LocalLRNoEditable := FALSE;
            LocalLRDateEditable := FALSE;
            LocalVehicaleNoEditable := FALSE;
            LocalVechCapEtdiable := FALSE;
            LocalDrivNameEditable := FALSE;
            LocalDrivLicNoEditable := FALSE;
            LocalDrivMobNoEditable := FALSE;
            LocalExpTPTCostEditable := FALSE;
            // RSPL-TC -
        END;

        IF (rec."Transport Type" = rec."Transport Type"::"Cust.Transport") THEN BEGIN

            "LR/RRNoEditable" := FALSE;
            "LR/RRDateEditable" := FALSE;
            VehicaleNoEditable := TRUE;
            DrivNameEditable := FALSE;
            DrivLicNoEditable := FALSE;
            DrivMobNoEditable := FALSE;
            VechCapEtdiable := FALSE;
            ExpTPTCostEditable := FALSE;

            LocalLRNoEditable := FALSE;
            LocalLRDateEditable := FALSE;
            LocalVehicaleNoEditable := FALSE;
            LocalVechCapEtdiable := FALSE;
            LocalDrivNameEditable := FALSE;
            LocalDrivLicNoEditable := FALSE;
            LocalDrivMobNoEditable := FALSE;
            LocalExpTPTCostEditable := FALSE;

        END;


        IF (rec."Transfer-from Code" = 'PLANT01') OR (rec."Transfer-from Code" = 'GDN0002') THEN BEGIN
            UserMaping.RESET;
            UserMaping.SETFILTER("User Name", '%1', USERID);
            UserMaping.SETFILTER("Role ID", '%1', 'TRANSPORTDETAILS');
            IF UserMaping.FINDFIRST THEN BEGIN
                IF rec."Transport Type" = rec."Transport Type"::"Local+Intercity" THEN BEGIN

                    ExpTPTCostEditable := TRUE;
                    LocalExpTPTCostEditable := TRUE;
                    VechCapEtdiable := TRUE;
                    LocalVechCapEtdiable := TRUE;
                END;
                IF rec."Transport Type" = rec."Transport Type"::Intercity THEN BEGIN

                    ExpTPTCostEditable := TRUE;
                    LocalExpTPTCostEditable := FALSE;
                    VechCapEtdiable := TRUE;
                    LocalVechCapEtdiable := FALSE;
                END;
                IF (rec."Transport Type" = rec."Transport Type"::"Cust.Transport") THEN BEGIN

                    ExpTPTCostEditable := FALSE;
                    LocalExpTPTCostEditable := FALSE;
                    VechCapEtdiable := FALSE;
                    LocalVechCapEtdiable := FALSE;
                END;
                IF (rec."Transport Type" = rec."Transport Type"::" ") THEN BEGIN

                    ExpTPTCostEditable := TRUE;
                    LocalExpTPTCostEditable := FALSE;
                    VechCapEtdiable := TRUE;
                    LocalVechCapEtdiable := FALSE;
                END;
            END ELSE BEGIN

                ExpTPTCostEditable := FALSE;
                LocalExpTPTCostEditable := FALSE;
                VechCapEtdiable := FALSE;
                LocalVechCapEtdiable := FALSE;
            END;
        END;

    END;


    var
        myInt: Integer;
}