codeunit 50022 TOPostShipExtCstm
{
    trigger OnRun()
    begin

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnBeforeOnRun, '', false, false)]
    local procedure OnBeforeOnRun(var TransferHeader: Record "Transfer Header"; var HideValidationDialog: Boolean; var SuppressCommit: Boolean; var IsHandled: Boolean);
    var
        RecLocNew: Record 14;
        recLoc1: Record 14;
        recLoc2: Record 14;
        recLocation: Record 14;
        TL18: Record "Transfer Line";
        RecTL: Record "Transfer Line";
        TransLine: Record "Transfer Line";
        TL30: Record "Transfer Line";
        InvtSetup: Record "Inventory Posting Setup";
        ILE30: Record "Item Ledger Entry";
        AccessControl: Record "Access Control";
        CSOMapping: Record "CSO Mapping";
    begin

        //TESTFIELD(Status,Status::Released); //EBT STIVAN (17/04/2013)-Error Message Pop is Status is not Released
        TransferHeader.TESTFIELD(Status, TransferHeader.Status::Released);  //EBT STIVAN (17/04/2013)-Error Message Pop is Status is not Released
                                                                            //EBT STIVAN (25012013) --Error Message Pop Up, If Structure is Blank for Trading Location----START
                                                                            //EBT STIVAN (25012013) --Error Message Pop Up, If Structure is Blank for Trading Location------END

        TransferHeader.TESTFIELD("Shipment Method Code");//RSPLSUM 10Nov2020

        //RSPLSUM BEGIN>>
        IF (TransferHeader."Transfer-from Code" <> 'CAPCON') AND (TransferHeader."Transfer-to Code" <> 'CAPCON') THEN BEGIN//RSPLSUM 12Dec2020
            RecLocNew.RESET;
            IF RecLocNew.GET(TransferHeader."Transfer-from Code") THEN BEGIN
                IF RecLocNew."Location Type" <> RecLocNew."Location Type"::Bonded THEN BEGIN
                    RecTL.RESET;
                    RecTL.SETRANGE("Document No.", TransferHeader."No.");
                    RecTL.SETFILTER("Inventory Posting Group", '%1', 'BULK');
                    IF NOT RecTL.FINDFIRST THEN BEGIN
                        // RecDetGSTEntBuff.RESET;
                        // RecDetGSTEntBuff.SETRANGE("Transaction Type", RecDetGSTEntBuff."Transaction Type"::Transfer);
                        // RecDetGSTEntBuff.SETRANGE("Document Type", RecDetGSTEntBuff."Document Type"::Quote);
                        // RecDetGSTEntBuff.SETRANGE("Document No.", "No.");
                        // IF NOT RecDetGSTEntBuff.FINDFIRST THEN
                        //     ERROR('Detailed GST Entry Buffer does not exist, Please calculate structure values.');
                    END;
                END;
            END;
        END;//RSPLSUM 12Dec2020
            //RSPLSUM END<<

        //>>RSPL/CUST/MERCH/001
        TransLine.RESET;
        TransLine.SETRANGE(TransLine."Document No.", TransferHeader."No.");
        IF TransLine.FINDSET THEN
            REPEAT
                IF TransLine."Inventory Posting Group" <> 'MERCH' THEN BEGIN
                    recLoc1.RESET;
                    recLoc1.SETRANGE(recLoc1.Code, TransferHeader."Transfer-from Code");
                    IF recLoc1.FINDFIRST THEN BEGIN
                        IF recLoc1."Trading Location" = TRUE THEN;
                        //  recLoc1.TESTFIELD(Structure);
                    END;

                    recLoc2.RESET;
                    recLoc2.SETRANGE(recLoc2.Code, TransferHeader."Transfer-to Code");
                    IF recLoc2.FINDFIRST THEN BEGIN
                        IF recLoc2."Trading Location" = TRUE THEN;
                        // TESTFIELD(Structure);
                    END;
                END;
            UNTIL TransLine.NEXT = 0;
        CLEAR(TransLine);
        //<<RSPL/CUST/MERCH/001

        //>>RB-N 30Oct2018
        // IF (Structure = 'GSTIMPORT') OR (Structure = 'GSTIMPCOAL') OR (Structure = 'GSTIMPFO') OR (Structure = 'GSTIMPBITU') OR (Structure = 'GSTIMPBITUMEN') THEN//RSPLSUM 24Jun2020--Added GSTIMPCOAL and GSTIMPFO // RSPLSID 29Dec2020--Added GSTIMPBITU
        // BEGIN
        TL30.RESET;
        TL30.SETRANGE("Document No.", TransferHeader."No.");
        TL30.SETFILTER(Quantity, '<>%1', 0);
        IF TL30.FINDSET THEN
            REPEAT
                TL30.TESTFIELD("GRN Number");
                ILE30.RESET;
                ILE30.SETCURRENTKEY("Document No.", "Item No.");
                ILE30.SETRANGE("Document No.", TL30."GRN Number");
                ILE30.SETRANGE("Item No.", TL30."Item No.");
                IF ILE30.FINDFIRST THEN
                    ILE30.TESTFIELD("Completely Invoiced", TRUE);
            UNTIL TL30.NEXT = 0;
        // END;
        //<<RB-N 30Oct2018



        //EBT STIVAN ---(20022013)---Errror Message POP UP, If User is Shipping other then his Location TRO-----START

        //RSPL-TC +
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETRANGE("Role ID", '%1', 'SUPER');
        IF NOT (AccessControl.FINDFIRST) THEN //RSPL-TC -
        BEGIN
            CSOMapping.RESET;
            CSOMapping.SETRANGE(CSOMapping.Type, CSOMapping.Type::Location);
            CSOMapping.SETRANGE(CSOMapping."User Id", USERID);
            CSOMapping.SETRANGE(CSOMapping.Value, TransferHeader."Transfer-from Code");
            IF NOT (CSOMapping.FINDFIRST) THEN BEGIN
                ERROR('You can not Ship other then your Location');
            END;
        END;
        //EBT STIVAN ---(20022013)---Errror Message POP UP, If User is Shipping other then his Location TRO-------END


        //EBT/LOCALINTERCITY/0001
        recLocation.RESET;
        recLocation.SETRANGE(recLocation.Code, TransferHeader."Transfer-from Code");
        IF recLocation.FINDFIRST THEN
            IF (recLocation."Require Receive" = FALSE) OR (recLocation."Require Shipment" = FALSE) THEN
                IF (TransferHeader."Transport Type" = 0) THEN
                    ERROR('You must specify the Transport Type');

        //EBT::For change dimension::start

        //EBT STIVAN---(01082013)----Error Message POP UP,
        //----IF Transport Type is InterCity then Expected TPT Cost is Mandatory &
        //----IF Transport Type is Local+InterCity then Local Expected TPT Cost & Expected TPT Cost is Mandatory------------------START

        //>>18May2017
        TL18.RESET; //18May2017
        TL18.SETRANGE("Document No.", TransferHeader."No."); //18May2017
        IF TL18.FINDFIRST THEN //18May2017
            REPEAT //18May2017
                IF TL18."Inventory Posting Group" <> 'MERCH' THEN //18May2017
                BEGIN //18May2017

                    IF (TransferHeader."Frieght Type" = TransferHeader."Frieght Type"::PAID) OR
                     (TransferHeader."Frieght Type" = TransferHeader."Frieght Type"::"PAY & ADD IN BILL") OR
                     (TransferHeader."Frieght Type" = TransferHeader."Frieght Type"::"TO PAY") THEN BEGIN

                        IF TransferHeader."Transport Type" = TransferHeader."Transport Type"::Intercity THEN BEGIN
                            IF TransferHeader."Expected TPT Cost" = 0 THEN
                                ERROR('Please Specify Expected TPT Cost');

                            IF TransferHeader."Vehicle Capacity" = '' THEN
                                ERROR('Please Specify Vehical Capacity');
                        END;

                        IF TransferHeader."Transport Type" = TransferHeader."Transport Type"::"Local+Intercity" THEN BEGIN
                            IF TransferHeader."Expected TPT Cost" = 0 THEN
                                ERROR('Please Specify Expected TPT Cost');

                            IF TransferHeader."Vehicle Capacity" = '' THEN
                                ERROR('Please Specify Vehical Capacity');

                            IF TransferHeader."Local Expected TPT Cost" = 0 THEN
                                ERROR('Please Specify Local Expected TPT Cost');

                            IF TransferHeader."Local Vehicle Capacity" = '' THEN
                                ERROR('Please Specify Local Vehical Capacity');

                        END;

                    END;
                END;//18May2017

            UNTIL TL18.NEXT = 0; //18May2017
                                 //<<18May2017
                                 //EBT STIVAN---(01082013)----Error Message POP UP,
                                 //----IF Transport Type is InterCity then Expected TPT Cost is Mandatory &
                                 //----IF Transport Type is Local+InterCity then Local Expected TPT Cost & Expected TPT Cost is Mandatory--------------------END

        recLocation.GET(TransferHeader."Transfer-from Code");
        InvtSetup.GET;
        // InvtSetup."Updating Dimension While Post" := TRUE; ///MY PC
        InvtSetup.MODIFY;
        //VALIDATE("Shortcut Dimension 1 Code",recLocation."Global Dimension 1 Code");  //TC RSPL
        // VALIDATE(TransHeader."Shortcut Dimension 2 Code", recLocation."Global Dimension 2 Code");  //Manish 24 01 2024
        recLocation."Global Dimension 2 Code" := TransferHeader."Shortcut Dimension 2 Code";
        InvtSetup.GET;
        // InvtSetup."Updating Dimension While Post" := FALSE;  ///MY PC
        InvtSetup.MODIFY;

        //EBT::For change dimension::end

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnAfterInsertTransShptHeader, '', false, false)]
    local procedure OnAfterInsertTransShptHeader(var TransferHeader: Record "Transfer Header"; var TransferShipmentHeader: Record "Transfer Shipment Header");
    begin

        //EBT0001
        TransferShipmentHeader."Empty Vehicle Weight" := TransferHeader."Empty Vehicle Weight";
        TransferShipmentHeader."Vehicle Weight After loading" := TransferHeader."Vehicle Weight After loading";
        TransferShipmentHeader."Net Weight of the Truck" := TransferHeader."Net Weight of the Truck";
        TransferShipmentHeader."WH Bill Entry No." := TransferHeader."WH Bill Entry No.";
        TransferShipmentHeader."Time In/Out" := TransferHeader."Time In/Out";
        TransferShipmentHeader."Debond Bill Entry No." := TransferHeader."Debond Bill Entry No.";
        //EBT0001
        //EBT STIVAN ---(04052012)--- To Capture Transporter Name in Shipment------------START
        TransferShipmentHeader."Transporter Name" := TransferHeader."Transporter Name";
        //EBT STIVAN ---(04052012)--- To Capture Transporter Name in Shipment--------------END
        //EBT STIVAN ---(29052012)--- To Capture Transfer Indent No in Shipment------------START
        TransferShipmentHeader."Transfer Indent No." := TransferHeader."Transfer Indent No";
        //EBT STIVAN ---(29052012)--- To Capture Transfer Indent No in Shipment--------------END
        //EBT/LOCALINTERCITY/0001
        TransferShipmentHeader."Driver's Name" := TransferHeader."Driver's Name";
        TransferShipmentHeader."Driver's License No." := TransferHeader."Driver's License No.";
        TransferShipmentHeader."Driver's Mobile No." := TransferHeader."Driver's Mobile No.";
        TransferShipmentHeader."Vehicle Capacity" := TransferHeader."Vehicle Capacity";
        TransferShipmentHeader."Vehicle For Location" := TransferHeader."Vehicle For Location";
        TransferShipmentHeader."Vehicle No." := TransferHeader."Vehicle No.";
        TransferShipmentHeader."Local Vehicle No." := TransferHeader."Local Vehicle No.";
        TransferShipmentHeader."Transport Type" := TransferHeader."Transport Type";
        TransferShipmentHeader."Local Driver's Name" := TransferHeader."Local Driver's Name";
        TransferShipmentHeader."Local Driver's License No." := TransferHeader."Local Driver's License No.";
        TransferShipmentHeader."Local Driver's Mobile No." := TransferHeader."Local Driver's Mobile No.";
        TransferShipmentHeader."Local Vehicle Capacity" := TransferHeader."Local Vehicle Capacity";
        TransferShipmentHeader."Local LR No." := TransferHeader."Local LR No.";
        TransferShipmentHeader."Local LR Date" := TransferHeader."Local LR Date";
        //EBT/LOCALINTERCITY/0001
        TransferShipmentHeader."Distance in kms" := TransferHeader."Distance in kms";//DJ 17/03/20
        TransferShipmentHeader."EWB Transaction Type" := TransferHeader."EWB Transaction Type";//RSPLSUM 23Jun2020


        //TransShptHeader."No. Series" := InvtSetup."Posted Transfer Shpt. Nos.";
        TransferShipmentHeader."No. Series" := TransferHeader."Shipping No. Series";   //EBT0001


        //EBT STIVAN ---(29062012)--- To Update the Form Code in Transfer Shipment Header -----START
        //     TransferShipmentHeader."Form Code" := TransferHeader."Form Code";
        //EBT STIVAN ---(29062012)--- To Update the Form Code in Transfer Shipment Header -------END

        //EBT STIVAN--(05122012)--To Update BRT PRINT TIME-----------START
        TransferShipmentHeader."BRT Print Time" := TIME;
        //EBT STIVAN--(05122012)--To Update BRT PRINT TIME-------------END

        //EBT STIVAN--(11122012)--To Update Road Permit No-----------START
        TransferShipmentHeader."Road Permit No." := TransferHeader."Road Permit No.";
        //EBT STIVAN--(11122012)--To Update Road Permit No-------------END

        //EBT STIVAN--(21062013)--To Update Expected TPT Cost-----------START
        TransferShipmentHeader."Expected TPT Cost" := TransferHeader."Expected TPT Cost";
        //EBT STIVAN--(21062013)--To Update Expected TPT Cost-------------END

        //EBT STIVAN--(31072013)--To Update Local Expected TPT Cost-----------START
        TransferShipmentHeader."Local Expected TPT Cost" := TransferHeader."Local Expected TPT Cost";
        //EBT STIVAN--(31072013)--To Update Local Expected TPT Cost-------------END

        //EBT STIVAN--(23072013)--To Update Freight Type-----------START
        TransferShipmentHeader."Frieght Type" := TransferHeader."Frieght Type";
        //EBT STIVAN--(23072013)--To Update Freight Type-------------END

        // //EBT/LOCALINTERCITY/0001
        // IF "Transport Type" = "Transport Type"::Intercity THEN BEGIN
        //     IF "Transfer-from Code" <> 'PLANT01' THEN BEGIN
        //         recPostedGateEntry.RESET;
        //         recPostedGateEntry.INIT;
        //         recPostedGateEntry."Entry Type" := recPostedGateEntry."Entry Type"::Outward;
        //         recGateLocSetup.GET(1, "Transfer-from Code");
        //         recPostedGateEntry."No. Series" := recGateLocSetup."Posting No. Series";
        //         recPostedGateEntry."No." := NoSeriesMgt.GetNextNo(recGateLocSetup."Posting No. Series", "Posting Date", TRUE);
        //         recPostedGateEntry."Gate Entry No." := TransShptHeader."No.";
        //         recPostedGateEntry."Location Code" := "Transfer-from Code";
        //         recPostedGateEntry."LR/RR No." := "LR/RR No.";
        //         recPostedGateEntry."LR/RR Date" := "LR/RR Date";
        //         recPostedGateEntry.Transporter := "Shipping Agent Code";
        //         recPostedGateEntry."Posting Date" := TODAY;
        //         recPostedGateEntry."Posting Time" := TIME;
        //         recPostedGateEntry."Vehicle No." := "Vehicle No.";
        //         recPostedGateEntry."Driver's Name" := "Driver's Name";
        //         recPostedGateEntry."Driver's License No." := "Driver's License No.";
        //         recPostedGateEntry."Driver's Mobile No." := "Driver's Mobile No.";
        //         recPostedGateEntry."Vehicle Capacity" := "Vehicle Capacity";
        //         recPostedGateEntry.INSERT;
        //     END;
        //     "LR/RR No." := '';
        //     "LR/RR Date" := 0D;
        //     "Vehicle No." := '';
        //     "Driver's Name" := '';
        //     "Driver's License No." := '';
        //     "Driver's Mobile No." := '';
        //     "Vehicle Capacity" := '';
        //     MODIFY;
        // END;
        // IF "Transport Type" = "Transport Type"::"Local+Intercity" THEN BEGIN
        //     IF "Transfer-from Code" <> 'PLANT01' THEN BEGIN
        //         recPostedGateEntry.RESET;
        //         recPostedGateEntry.INIT;
        //         recPostedGateEntry."Entry Type" := recPostedGateEntry."Entry Type"::Outward;
        //         recGateLocSetup.GET(1, "Transfer-from Code");
        //         recPostedGateEntry."No. Series" := recGateLocSetup."Posting No. Series";
        //         recPostedGateEntry."No." := NoSeriesMgt.GetNextNo(recGateLocSetup."Posting No. Series", "Posting Date", TRUE);
        //         recPostedGateEntry."Gate Entry No." := "No.";
        //         recPostedGateEntry."Location Code" := "Transfer-from Code";
        //         recPostedGateEntry."LR/RR No." := "Local LR No.";
        //         recPostedGateEntry."LR/RR Date" := "Local LR Date";
        //         recPostedGateEntry.Transporter := "Shipping Agent Code";
        //         recPostedGateEntry."Posting Date" := TODAY;
        //         recPostedGateEntry."Posting Time" := TIME;
        //         recPostedGateEntry."Vehicle No." := "Local Vehicle No.";
        //         recPostedGateEntry."Driver's Name" := "Local Driver's Name";
        //         recPostedGateEntry."Driver's License No." := "Local Driver's License No.";
        //         recPostedGateEntry."Driver's Mobile No." := "Local Driver's Mobile No.";
        //         recPostedGateEntry."Vehicle Capacity" := "Local Vehicle Capacity";
        //         recPostedGateEntry.INSERT;
        //     END;
        //     "Local LR No." := '';
        //     "Local LR Date" := 0D;
        //     "Local Vehicle No." := '';
        //     "Local Driver's Name" := '';
        //     "Local Driver's License No." := '';
        //     "Local Driver's Mobile No." := '';
        //     "Local Vehicle Capacity" := '';
        //     "Time In/Out" := 0T;
        //     "Empty Vehicle Weight" := 0;
        //     "Vehicle Weight After loading" := 0;
        //     "Net Weight of the Truck" := 0;
        //     "WH Bill Entry No." := '';
        //     "Debond Bill Entry No." := '';
        //     MODIFY;
        // END;
        // //EBT/LOCALINTERCITY/0001


        //EBT STIVAN ----(21/11/12)----- To Make Below Fields Blank after Shipment is posted--------START
        TransferHeader."Empty Vehicle Weight" := 0;
        TransferHeader."Vehicle Weight After loading" := 0;
        TransferHeader."Net Weight of the Truck" := 0;
        TransferHeader."WH Bill Entry No." := '';
        TransferHeader."Debond Bill Entry No." := '';
        TransferHeader."Time In/Out" := 0T;
        //EBT STIVAN ----(21/11/12)----- To Make Below Fields Blank after Shipment is posted----------END       

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnBeforeInsertTransShptLine, '', false, false)]
    local procedure OnBeforeInsertTransShptLine(var TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; TransShptHeader: Record "Transfer Shipment Header");

    begin
        TransShptLine."Transfer Indent No." := TransLine."Transfer Indent No.";             //EBT/TROIndent/0001
        TransShptLine."Transfer Indent Line No." := TransLine."Transfer Indent Line No.";   //EBT/TROIndent/0001
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", OnAfterInsertTransShptLine, '', false, false)]
    local procedure OnAfterInsertTransShptLine(var TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; TransShptHeader: Record "Transfer Shipment Header");
    var
        InventoryPostingSetup: Record "Inventory Posting Setup";
        GenJnlLine: Record "Gen. Journal Line";
        Location: Record 14;
        transtorespcenter: Record 14;
        transfromrespcenter: Record 14;
        recTransportDetails: Record "Transport Details";
        UOMTrans: Text[20];
        recShippingAgent: Record "Shipping Agent";
        recvendor: Record Vendor;
        recLoc: Record 14;
        recTSL: Record "Transfer Shipment Line";
        recTrnsfShpmnLine: Record "Transfer Shipment Line";
        ItemUOM: Record "Item Unit of Measure";
        Item: Record 27;
        RecILE: Record "Item Ledger Entry";
        RecILE1: Record "Item Ledger Entry";
        TransferHeader: Record 5740;
    begin

        // TC IPOL
        // InventoryPostingSetup.TESTFIELD("Inventory Account"); // TC IPOL CORRECTED LIKE 2009
        //GenJnlLine."Account No." := InventoryPostingSetup."Inventory Account"; // TC IPOL CORRECTED LIKE 2009
        InventoryPostingSetup.TESTFIELD("Unrealized Profit Account"); //TC IPOL 19 FEB
        GenJnlLine."Account No." := InventoryPostingSetup."Unrealized Profit Account"; // TC IPOL 19 FEB    

        //--------------------EBT/Excise/0001--------------------------------
        GenJnlLine."Post Excise Details" := Location."Post Excise Details";
        GenJnlLine."Entry Type" := GenJnlLine."Entry Type"::"Transfer Shipment";
        //--------------------EBT/Excise/0001--------------------------------



        //EBT STIVAN ---(10/06/2013)---Code to Update the Transport Details Table------------------------START
        //EBT MILAN -----(070214)-----Not to post in transport detail if resp. center is same------------START
        transtorespcenter.RESET;
        transtorespcenter.SETRANGE(transtorespcenter.Code, TransShptHeader."Transfer-from Code");
        IF transtorespcenter.FINDFIRST THEN;

        transfromrespcenter.RESET;
        transfromrespcenter.SETRANGE(transfromrespcenter.Code, TransShptHeader."Transfer-to Code");
        IF transfromrespcenter.FINDFIRST THEN;

        IF transtorespcenter."Global Dimension 2 Code" <> transfromrespcenter."Global Dimension 2 Code" THEN BEGIN

            IF NOT ((TransShptHeader."Transfer-from Code" = 'CAPCON') OR
                       (TransShptHeader."Transfer-to Code" = 'CAPCON') OR
                       //RSPL-Sourav010415
                       (TransShptHeader."Transfer-from Code" = 'INVADJ0001') OR (TransShptHeader."Transfer-to Code" = 'INVADJ0001')) THEN
               //RSPL-Sourav010415
               BEGIN
                recTransportDetails.RESET;
                recTransportDetails.SETRANGE(recTransportDetails."Invoice No.", TransShptHeader."No.");
                IF NOT (recTransportDetails.FINDFIRST) THEN BEGIN

                    recTransportDetails."Invoice No." := TransShptHeader."No.";
                    recTransportDetails."Invoice Date" := TransShptHeader."Posting Date";
                    recTransportDetails."Shortcut Dimension 1 Code" := TransShptHeader."Shortcut Dimension 1 Code";
                    TransShptLine.RESET;
                    TransShptLine.SETRANGE(TransShptLine."Document No.", TransShptHeader."No.");
                    IF TransShptLine.FINDFIRST THEN BEGIN
                        IF (TransShptLine."Unit of Measure" = 'LTRS') OR (TransShptLine."Unit of Measure" = 'KGS') THEN
                            UOMTrans := TransShptLine."Unit of Measure"
                        ELSE
                            UOMTrans := '';
                    END;
                    recTransportDetails.UOM := UOMTrans;
                    recTransportDetails.Type := recTransportDetails.Type::Transfer;


                    IF TransShptHeader."Transport Type" = TransShptHeader."Transport Type"::Intercity THEN BEGIN
                        recTransportDetails."LR No." := TransShptHeader."LR/RR No.";
                        recTransportDetails."LR Date" := TransShptHeader."LR/RR Date";
                        recTransportDetails."Vehicle No." := TransShptHeader."Vehicle No.";
                    END;

                    IF TransShptHeader."Transport Type" = TransShptHeader."Transport Type"::"Local+Intercity" THEN BEGIN
                        //recTransportDetails."LR No." := TransShptHeader."Local LR No.";
                        //recTransportDetails."LR Date" := TransShptHeader."Local LR Date";
                        //recTransportDetails."Vehicle No." := TransShptHeader."Local Vehicle No.";
                        recTransportDetails."Local LR No." := TransShptHeader."Local LR No.";
                        recTransportDetails."Local LR Date" := TransShptHeader."Local LR Date";
                        recTransportDetails."Local Vehicle No." := TransShptHeader."Local Vehicle No.";

                        //recTransportDetails."Local Shipment Agent Code" := TransShptHeader."Shipping Agent Code";

                        //recShippingAgent.RESET;
                        //recShippingAgent.SETRANGE(recShippingAgent.Code,TransShptHeader."Shipping Agent Code");
                        //IF recShippingAgent.FINDFIRST THEN
                        //BEGIN
                        // recTransportDetails."Local Shipment Agent Name" := recShippingAgent.Name;
                        //END;
                    END;

                    IF NOT ((TransShptHeader."Transport Type" = TransShptHeader."Transport Type"::Intercity) OR
                             (TransShptHeader."Transport Type" = TransShptHeader."Transport Type"::"Local+Intercity")) THEN BEGIN
                        recTransportDetails."LR No." := '';
                        recTransportDetails."LR Date" := 0D;
                        recTransportDetails."Vehicle No." := '';
                        recTransportDetails."Local LR No." := '';
                        recTransportDetails."Local LR Date" := 0D;
                        recTransportDetails."Local Vehicle No." := '';
                    END;

                    recTransportDetails."Shipping Agent Code" := TransShptHeader."Shipping Agent Code";

                    recShippingAgent.RESET;
                    recShippingAgent.SETRANGE(recShippingAgent.Code, TransShptHeader."Shipping Agent Code");
                    IF recShippingAgent.FINDFIRST THEN BEGIN
                        recTransportDetails."Shipping Agent Name" := recShippingAgent.Name;
                    END;

                    IF (TransShptHeader."Shipping Agent Code" <> '') THEN BEGIN
                        recvendor.RESET;
                        recvendor.SETRANGE(recvendor."Shipping Agent Code", TransShptHeader."Shipping Agent Code");
                        IF recvendor.FINDFIRST THEN BEGIN
                            recTransportDetails."Vendor Code" := recvendor."No.";
                            recTransportDetails."Vendor Name" := recvendor."Full Name";
                        END;
                    END;

                    recTransportDetails."From Location Code" := TransShptHeader."Transfer-from Code";

                    recLoc.RESET;
                    recLoc.SETRANGE(recLoc.Code, TransShptHeader."Transfer-from Code");
                    IF recLoc.FINDFIRST THEN BEGIN
                        recTransportDetails."From Location Name" := recLoc.Name;
                    END;

                    recTransportDetails.Destination := TransferHeader."Transfer-to Name";   // EBT MILAN 270214

                    recTransportDetails."Expected TPT Cost" := TransShptHeader."Expected TPT Cost";

                    recTransportDetails."Local Expected TPT Cost" := TransShptHeader."Local Expected TPT Cost";

                    //RSPLSUM 12July2019>>
                    recTransportDetails."Expected Loading" := TransferHeader."Expected Loading";
                    recTransportDetails."Expetced Unloading" := TransferHeader."Expected Unloading";
                    //RSPLSUM 12July2019>>

                    // EBT MILAN 171213
                    recTransportDetails."Vehicle Capacity" := TransShptHeader."Vehicle Capacity";
                    recTransportDetails."Local Vehicle Capacity" := TransShptHeader."Local Vehicle Capacity";

                    recTSL.RESET;
                    recTSL.SETRANGE(recTSL."Document No.", TransShptHeader."No.");
                    recTSL.SETFILTER(recTSL.Quantity, '<>%1', 0);
                    IF recTSL.FINDFIRST THEN
                        REPEAT
                            recTransportDetails.Quantity += recTSL."Quantity (Base)";
                        UNTIL recTSL.NEXT = 0;

                    //>> RB-N 14Nov2017 Transport Details---No. of Packs
                    recTSL.RESET;
                    recTSL.SETRANGE(recTSL."Document No.", TransShptHeader."No.");
                    recTSL.SETFILTER(recTSL.Quantity, '<>%1', 0);
                    IF recTSL.FINDFIRST THEN
                        REPEAT
                            recTransportDetails."No. of Packs" += recTSL.Quantity;
                        UNTIL recTSL.NEXT = 0;
                    //>> RB-N 14Nov2017 Transport Details---No. of Packs



                    recTransportDetails."To Location Code" := TransShptHeader."Transfer-to Code";

                    recLoc.RESET;
                    recLoc.SETRANGE(recLoc.Code, TransShptHeader."Transfer-to Code");
                    IF recLoc.FINDFIRST THEN BEGIN
                        recTransportDetails."To Location Name" := recLoc.Name;
                    END;

                    recTransportDetails."Freight Type" := TransShptHeader."Frieght Type";
                    recTransportDetails.Open := TRUE;
                    recTransportDetails.INSERT;
                END;
            END;
        END;
        //EBT STIVAN ---(10/06/2013)---Code to Update the Transport Details Table--------------------------END

        //RSPL-CAS-07045-Y1L4CB
        recTransportDetails.RESET;
        recTransportDetails.SETRANGE(recTransportDetails."Invoice No.", TransShptHeader."No.");
        IF (recTransportDetails.FINDFIRST) THEN BEGIN

            recTrnsfShpmnLine.RESET;
            recTrnsfShpmnLine.SETRANGE("Document No.", TransShptHeader."No.");
            IF recTrnsfShpmnLine.FINDSET THEN
                REPEAT
                    IF Item.GET(recTrnsfShpmnLine."Item No.") THEN BEGIN
                        IF Item."Base Unit of Measure" = 'LTRS' THEN BEGIN
                            ItemUOM.RESET;
                            ItemUOM.SETRANGE(ItemUOM."Item No.", recTrnsfShpmnLine."Item No.");
                            ItemUOM.SETRANGE(ItemUOM.Code, recTrnsfShpmnLine."Unit of Measure Code");
                            IF ItemUOM.FINDFIRST THEN BEGIN
                                recTransportDetails."Quantity in Ltrs." += recTrnsfShpmnLine.Quantity * ItemUOM."Qty. per Unit of Measure";
                                RecILE.RESET;
                                RecILE.SETRANGE(RecILE."Item No.", recTrnsfShpmnLine."Item No.");
                                RecILE.SETRANGE(RecILE."Document No.", recTrnsfShpmnLine."Document No.");
                                IF RecILE.FINDSET THEN BEGIN
                                    RecILE1.SETRANGE(RecILE1."Lot No.", RecILE."Lot No.");
                                    RecILE1.SETRANGE(RecILE1."Item No.", RecILE."Item No.");
                                    RecILE1.SETRANGE(RecILE1."Entry Type", RecILE1."Entry Type"::Output);
                                    IF RecILE1.FINDFIRST THEN
                                        recTransportDetails."Total Quantity in(Kg)" += recTrnsfShpmnLine.Quantity * ItemUOM."Qty. per Unit of Measure"
                                        * RecILE1."Density Factor";
                                END;
                            END;
                        END;
                        IF Item."Base Unit of Measure" = 'KGS' THEN BEGIN
                            ItemUOM.RESET;
                            ItemUOM.SETRANGE(ItemUOM."Item No.", recTrnsfShpmnLine."Item No.");
                            ItemUOM.SETRANGE(ItemUOM.Code, recTrnsfShpmnLine."Unit of Measure Code");
                            IF ItemUOM.FINDSET THEN BEGIN
                                recTransportDetails."Quantity in KGS" += recTrnsfShpmnLine.Quantity * ItemUOM."Qty. per Unit of Measure";
                                recTransportDetails."Total Quantity in(Kg)" += recTransportDetails."Quantity in KGS";
                            END;
                        END;
                    END;
                UNTIL recTrnsfShpmnLine.NEXT = 0;
            recTransportDetails.MODIFY;
        END;
        //RSPL-CAS-07045-Y1L4CB
    end;



    var
        myInt: Integer;
}