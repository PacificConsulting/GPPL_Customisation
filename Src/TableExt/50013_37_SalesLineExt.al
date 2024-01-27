tableextension 50013 SalesLineExtCutm extends "Sales Line"
{



    // trigger OnInsert()
    // begin
    // //    IF (("Appiles to Inv.No."<>'') AND ("Final Item No."<>'')) THEN BEGIN
    //  RemoveDimension("Document No.", "Line No.");
    // CopyDimension;
    // END;
    //EBT STIVAN ---(18042012)--- To Insert Dimension Code for INDOILS without Dimension Value Code---------END
    // END;


    fields
    {
        field(50000; "Inventory Posting Group"; Code[20])
        {
            Description = 'EBT/CSO/Item filter/0001';
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group";

            trigger OnValidate()
            var
                EBTSalesLine: Record 37;
                recSH: Record 36;
                DivisionDim: Code[10];
            begin
                //EBT/CSO/Item filter/0001
                IF Type = Type::Item THEN BEGIN
                    IF "No." <> '' THEN
                        ERROR('You cannot change the Inventory Posting Group while Item is already selected');
                END;


                EBTSalesLine.RESET;
                EBTSalesLine.SETRANGE("Document Type", "Document Type");
                EBTSalesLine.SETRANGE("Document No.", "Document No.");
                EBTSalesLine.SETRANGE(Type, EBTSalesLine.Type::Item);
                EBTSalesLine.SETFILTER("Line No.", '<>%1', "Line No.");
                IF EBTSalesLine.FINDFIRST THEN
                    IF EBTSalesLine."Inventory Posting Group" <> "Inventory Posting Group" THEN
                        ERROR('You cannot select %1 Inventory Group as you have selected %2 Inventory Group in PO %3, Line No. %4',
                              "Inventory Posting Group", EBTSalesLine."Inventory Posting Group", EBTSalesLine."Document No.", EBTSalesLine."Line No.");
                //EBT/CSO/Item filter/0001


                //EBT STIVAN ---(21062012)---
                // To restrict if Division is Industrial then he should not be able to select Inventory posting group as AUTOOILS &
                // To restrict if Division is Automotive then he should not be able to select Inventory posting group as INDOOILS &
                //--------------------------------------------------------------------------------------------------------------------START
                recSH.RESET;
                recSH.SETRANGE(recSH."No.", "Document No.");
                IF recSH.FINDFIRST THEN BEGIN
                    DivisionDim := recSH."Shortcut Dimension 1 Code";

                    IF DivisionDim = 'DIV-03' THEN BEGIN
                        IF "Inventory Posting Group" = 'AUTOOILS' THEN
                            ERROR('You can not select Inventory Posting Group AUTOOILS as Customer Division is Industrial');
                    END;

                    IF DivisionDim = 'DIV-04' THEN BEGIN
                        IF "Inventory Posting Group" = 'INDOILS' THEN
                            ERROR('You can not select Inventory Posting Group INDOILS as Customer Division is Automotive');
                    END;

                    IF DivisionDim = 'DIV-05' THEN   //RSPL-Sourav
                    BEGIN
                        IF "Inventory Posting Group" <> 'RPO' THEN
                            ERROR('You can not select Inventory Posting Group Other than RPO');
                    END;   //RSPL-Sourav
                           //>>RSPL-Sourav091215
                    IF DivisionDim = 'DIV-08' THEN BEGIN
                        IF ("Inventory Posting Group" <> 'REPSOL') AND ("Inventory Posting Group" <> 'MERCH') THEN
                            ERROR('You can not select Inventory Posting Group Other than Repsol and Merch');
                    END;
                    //<<RSPL-Sourav091215

                    //RSPLSUM 14May2020>>
                    IF DivisionDim = 'DIV-14' THEN BEGIN
                        IF "Inventory Posting Group" <> 'FUELOIL' THEN
                            ERROR('You can not select Inventory Posting Group Other than FUELOIL');
                    END;
                    //RSPLSUM 14May2020<<

                END;
                //EBT STIVAN ---(21062012)---
                // To restrict if Division is Industrial then he should not be able to select Inventory posting group as AUTOOILS &
                // To restrict if Division is Automotive then he should not be able to select Inventory posting group as INDOOILS &
                //----------------------------------------------------------------------------------------------------------------------END
            end;
        }
        field(50002; "Qty/Addl.Dis. for Line Dis."; Decimal)
        {
            Description = 'EBT/TRANSUBSIDY/0001';
        }
        field(50003; "Splited From Line"; Integer)
        {
            Description = 'EBT0001';
        }
        field(50004; "Split Line"; Boolean)
        {
        }
        field(50005; Closed; Boolean)
        {
            Description = 'EBT/SHORTCLOSE/0001';
            Editable = true;

            trigger OnValidate()
            var
                recResEntry: Record 337;
                recSalesHeader: Record 36;
            begin
                //EBT STIVAN ---(03-09-2012)--- To Check If Item tracking Lines Exist Before Closing any Line --------START
                recResEntry.RESET;
                recResEntry.SETRANGE(recResEntry."Source Type", 37);
                recResEntry.SETRANGE(recResEntry."Source ID", "Document No.");
                recResEntry.SETRANGE(recResEntry."Item No.", "No.");
                recResEntry.SETRANGE(recResEntry."Source Ref. No.", "Line No.");
                IF recResEntry.FINDFIRST THEN BEGIN
                    ERROR('Please Remove Item Tracking Lines for Line No. %1', "Line No.")
                END;
                //EBT STIVAN ---(03-09-2012)--- To Check If Item tracking Lines Exist Before Closing any Line ----------END

                //EBT STIVAN ---(03-09-2012)--- To Check If Created by User Id and User Id which is Closing the Line Is same or not
                //                                & If CSO is Approved or Pending for Approval before Closing the Line---------------START
                recSalesHeader.RESET;
                recSalesHeader.SETRANGE(recSalesHeader."No.", "Document No.");
                IF recSalesHeader.FINDFIRST THEN BEGIN

                    IF recSalesHeader."Created By" = UPPERCASE(USERID) THEN BEGIN
                        IF (recSalesHeader."Campaign No." = 'APPROVED') OR (recSalesHeader."Campaign No." = 'PENDING FOR APPROVAL') THEN BEGIN
                            ERROR('Please Reopen the CSO');
                        END;
                    END;

                    IF recSalesHeader."Created By" <> UPPERCASE(USERID) THEN BEGIN
                        IF (recSalesHeader."Campaign No." = 'APPROVED') OR (recSalesHeader."Campaign No." = 'PENDING FOR APPROVAL') THEN BEGIN
                            ERROR('Please Reopen the CSO');
                        END;
                    END;
                    IF (USERID <> 'GPUAE\FAHIM.AHMAD') AND (USERID <> 'GPUAE\RAVI.KHAMBAL') THEN
                        IF recSalesHeader."Created By" <> UPPERCASE(USERID) THEN BEGIN
                            IF NOT ((recSalesHeader."Campaign No." = 'APPROVED') OR (recSalesHeader."Campaign No." = 'PENDING FOR APPROVAL')) THEN BEGIN
                                ERROR('You do not have Permission to Close the Line');
                            END;
                        END;

                END;
                //EBT STIVAN ---(03-09-2012)--- To Check If Created by User Id and User Id which is Closing the Line Is same or not
                //                                & If CSO is Approved or Pending for Approval before Closing the Line-----------------END

                //EBT STIVAN ---(03-09-2012)--- To Check If CSO is Released Before Closing any Line --------START
                recSalesHeader.RESET;
                recSalesHeader.SETRANGE(recSalesHeader."No.", "Document No.");
                recSalesHeader.SETRANGE(recSalesHeader.Status, recSalesHeader.Status::Released);
                IF recSalesHeader.FINDFIRST THEN BEGIN
                    ERROR('Please Reopen the CSO');
                END;
                //EBT STIVAN ---(03-09-2012)--- To Check If CSO is Released Before Closing any Line ----------END

                //EBT/SHORTCLOSE/0001
                IF Closed = TRUE THEN BEGIN
                    "Closed Date" := TODAY;
                    //MODIFY;
                END
                ELSE
                    IF Closed = FALSE THEN BEGIN
                        "Closed Date" := 0D;
                        //MODIFY;
                    END
                //EBT/SHORTCLOSE/0001
            end;
        }



        field(50006; "Closed Date"; Date)
        {
            Description = 'EBT/SHORTCLOSE/0001';
            Editable = true;
        }
        field(50007; "Lot No."; Code[20])
        {
            Description = 'RG23D';
            Editable = true;

            trigger OnValidate()
            begin
                "Structure Calculated" := FALSE;   //EBT0001
            end;
        }
        field(50008; "MRP/Sales Price"; Decimal)
        {
            Description = 'EBT0001';
            Editable = false;

            trigger OnValidate()
            begin
                MRPUpdationforInd;
            end;
        }
        field(50009; "Structure Calculated"; Boolean)
        {
        }
        field(50010; "Approve User ID"; Code[20])
        {
            Description = 'EBT STIVAN (18042012) - For CSO Approval';
        }
        field(50011; "Approval Date"; Date)
        {
            Description = 'EBT STIVAN (18042012) - For CSO Approval';
        }
        field(50012; "Approval Time"; Time)
        {
            Description = 'EBT STIVAN (18042012) - For CSO Approval';
        }
        field(50013; "List Price"; Decimal)
        {
            Description = 'EBT0001';
            Editable = false;
        }
        field(50014; "Last splitted No."; Integer)
        {
            Description = 'EBT0001';
        }
        field(50015; modified; Boolean)
        {
        }
        field(50016; "Appiles to Inv.No."; Code[20])
        {
            TableRelation = "Sales Invoice Header"."No." WHERE("Sell-to Customer No." = FIELD("Sell-to Customer No."));
        }
        field(50017; "Supplimentary Invoice"; Boolean)
        {
        }
        field(50018; "Final Item No."; Code[10])
        {
        }
        field(50019; "Unit Price Per Lt"; Decimal)
        {
            Description = 'For Last Yr Sales Return';

            trigger OnValidate()
            begin
                /*
                TESTFIELD("MRP Price");
                IF ("Inventory Posting Group" = 'AUTOOILS') OR ("Inventory Posting Group" = 'REPSOL') THEN
                    VALIDATE("Unit Price Incl. of Tax", "Unit Price Per Lt" * "Qty. per Unit of Measure")
                ELSE
                    VALIDATE("Unit Price", "Unit Price Per Lt" * "Qty. per Unit of Measure");
                "List Price" := "Unit Price Per Lt";
                */
            end;
        }
        field(50020; "Base Unit Price"; Decimal)
        {
            Description = 'For Supp. Inv';

            trigger OnValidate()
            begin
                IF "Supplimentary Invoice" THEN
                    VALIDATE("Unit Price", "Base Unit Price" * "Qty. per Unit of Measure");
                //VALIDATE(MRP, TRUE);
                //VALIDATE("MRP Price", "Base Unit Price");


                //IF Type = Type::"Charge (Item)" THEN
                //  IF "Shortcut Dimension 1 Code" = 'DIV-03' THEN
                //    "Assessable Value" := "Line Amount";
            end;
        }
        field(50021; "Final Line No."; Integer)
        {
            Description = 'EBT0002';
        }
        field(50022; "Last Billing Price"; Decimal)
        {
            Description = 'EBT STIVAN (07012013)';
        }
        field(50024; "National Discount Per Ltr"; Decimal)
        {
            Description = 'CAS-04788-L3W7L3';
            Editable = false;

            trigger OnValidate()
            begin
                "National Discount Amount" := "National Discount Per Ltr" * "Qty. to Invoice (Base)" //CAS-03500-H4N0R8
            end;
        }
        field(50025; "Free of Cost"; Boolean)
        {
            Description = 'CAS-04788-L3W7L3';

            trigger OnValidate()
            var
                Itm: Record 27;
            begin
                //RSPL/Migration/Rahul
                IF "Free of Cost" THEN
                    "Tax Group Code" := '';
                //<<

                //>>26Mar2019
                TESTFIELD(Type, Type::Item);
                IF "Inventory Posting Group" <> 'MERCH' THEN
                    IF "Free of Cost" = TRUE THEN BEGIN
                        Itm.RESET;
                        IF Itm.GET("No.") THEN
                            IF NOT Itm."FOC Applicable" THEN
                                ERROR('FOC is not applicable for selected product');

                        VALIDATE("National Discount Per Ltr", 0);
                        VALIDATE("Line Discount Amount", 0);
                        VALIDATE("Line Discount Amount", "Line Amount");
                    END;
                IF "Inventory Posting Group" <> 'MERCH' THEN
                    IF "Free of Cost" = FALSE THEN BEGIN
                        VALIDATE("Line Discount Amount", 0);
                        VALIDATE(Quantity, 0);
                        VALIDATE("National Discount Per Ltr", 0);
                    END;
                //<<26Mar2019
            end;
        }
        field(50026; "Basic Price"; Decimal)
        {
            Description = 'CAS-05923-M4T6H6';

            trigger OnValidate()
            begin
                "MRP/Sales Price" := "Basic Price" + "Freight/Other Chgs. Primary" + "Freight/Other Chgs. Secondary"; //CAS-05923-M4T6H6
                VALIDATE("MRP/Sales Price");
            end;
        }
        field(50027; "Freight/Other Chgs. Primary"; Decimal)
        {
            Description = 'CAS-05923-M4T6H6';

            trigger OnValidate()
            begin
                IF "Freight/Other Chgs. Primary" <> 0 THEN
                    TESTFIELD("Basic Price");
                "MRP/Sales Price" := "Basic Price" + "Freight/Other Chgs. Primary" + "Freight/Other Chgs. Secondary"; //CAS-05923-M4T6H6
                VALIDATE("MRP/Sales Price");
            end;
        }
        field(50028; "Freight/Other Chgs. Secondary"; Decimal)
        {
            Description = 'CAS-05923-M4T6H6';

            trigger OnValidate()
            begin
                IF "Freight/Other Chgs. Secondary" <> 0 THEN
                    TESTFIELD("Basic Price");

                "MRP/Sales Price" := "Basic Price" + "Freight/Other Chgs. Primary" + "Freight/Other Chgs. Secondary"; //CAS-05923-M4T6H6
                VALIDATE("MRP/Sales Price");
            end;
        }
        field(50029; "Price Support Per Ltr"; Decimal)
        {
            Description = 'CAS-03500-H4N0R8';

            trigger OnValidate()
            begin
                "Price Support Amount" := "Price Support Per Ltr" * "Qty. to Invoice (Base)"  //CAS-03500-H4N0R8
            end;
        }
        field(50030; "National Discount Amount"; Decimal)
        {
            Description = 'CAS-03500-H4N0R8';
            Editable = false;
        }
        field(50031; "Price Support Amount"; Decimal)
        {
            Description = 'CAS-03500-H4N0R8';
            Editable = false;
        }
        field(50032; "Trading Location"; Boolean)
        {
            //           CalcFormula = Lookup(Location."Trading Location" WHERE(Code = FIELD("Location Code")));
            //FieldClass = FlowField; Azhar pending


        }
        field(50033; "IOPL Split Line No."; Integer)
        {
        }
        field(50034; "Planned Delivery End Date"; Date)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50035; "Minimum Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'RSPLSUM-BUNKER';
        }
        field(50036; Specification; Text[100])
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50037; Status; Option)
        {
            Caption = 'Status';
            Description = 'RSPLSUM-BUNKER';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(50038; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            Description = 'RSPLSUM-BUNKER';
            TableRelation = "Payment Terms";
        }
        field(50039; "Credit Checking Not Required"; Boolean)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50040; "Short Close"; Boolean)
        {
            Description = 'RSPLSUM-BUNKER';
            Editable = false;
        }
        field(50041; "Amount To Customer"; Decimal)
        {
            Caption = 'Amount To Customer';
            Editable = true;

            trigger OnValidate()
            begin
                TESTFIELD(Type);
                TESTFIELD(Quantity);
                TESTFIELD("Unit Price");
                //"Amount To Customer" := ROUND("Amount To Customer",Currency."Amount Rounding Precision");
                //Amount := ROUND("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
                InitOutstandingAmount;
            end;
        }
        field(50042; "TDS/TCS Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'TDS/TCS Amount';
            Editable = false;
        }

        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                EBTlocation: Record Location;
            begin
                EBTlocation.RESET;
                EBTlocation.SETRANGE(EBTlocation.Code, "Location Code");
                EBTlocation.SETRANGE(EBTlocation.Closed, TRUE);
                IF EBTlocation.FINDFIRST THEN BEGIN
                    ERROR('You are not allowed the select this Location as it is Closed');
                END;
            end;
        }

        modify(Type) // MY PC 04 01 2024
        {
            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
                recSIL: Record 37;
            begin
                //EBT0002
                if Type = Type::"Charge (Item)" then
                    IF SalesHeader."Supplimentary Invoice" THEN BEGIN
                        "Supplimentary Invoice" := TRUE;
                        //"Appiles to Inv.No." := SalesHeader."Applies-to Doc. No.";
                    END;

                //EBT STIVAN ---(07/01/2013)-- To Capture Last Billing Price --START
                IF ("Inventory Posting Group" = 'INDOILS') OR ("Inventory Posting Group" = 'RPO') OR ("Inventory Posting Group" = 'BOILS')
                  OR ("Inventory Posting Group" = 'TOILS') OR ("Inventory Posting Group" = 'SPECOL') OR ("Inventory Posting Group" = 'CEPSA') THEN BEGIN
                    recSIL.RESET;
                    recSIL.SETCURRENTKEY(recSIL."Sell-to Customer No.", recSIL."Posting Date");
                    recSIL.SETRANGE(recSIL."Sell-to Customer No.", "Sell-to Customer No.");
                    recSIL.SETRANGE(recSIL."No.", "No.");
                    recSIL.SETFILTER(recSIL.Quantity, '%1', 0);
                    IF recSIL.FINDLAST THEN BEGIN
                        "Last Billing Price" := recSIL."MRP/Sales Price";
                    END;
                END;
                //EBT STIVAN ---(07/01/2013)-- To Capture Last Billing Price ----END
            end;
            //EBT0002

        }

        modify(Quantity) // MY PC 04 01 2024
        {
            trigger OnAfterValidate()
            var
                ItemLedgEntry: Record 32;
                SalesHeader2: Record 36;
                ReturnRcptLine: Record 6661;
                xReservationentry: Record 337;
                recSL: Record 37;

            BEGIN
                // EBT MILAN 130214--------------------------------------------------START
                "Structure Calculated" := FALSE;
                modified := FALSE;
                // EBT MILAN 130214----------------------------------------------------END
                // EBT MILAN 110314------ DELETE RESERVATION if QTY is CHANGED--------------START
                xReservationentry.RESET;
                xReservationentry.SETRANGE(xReservationentry."Source Type", 37);
                xReservationentry.SETRANGE(xReservationentry."Source ID", "Document No.");
                xReservationentry.SETRANGE(xReservationentry."Location Code", "Location Code");
                xReservationentry.SETRANGE(xReservationentry."Item No.", "No.");
                xReservationentry.SETRANGE(xReservationentry."Source Ref. No.", "Line No.");
                xReservationentry.SETFILTER(xReservationentry."Transferred from Entry No.", '%1', 0);
                IF xReservationentry.FINDFIRST THEN
                    xReservationentry.DELETE;
                //EBT MILAN 110314------ DELETE RESERVATION if QTY is CHANGED-----------------END

                //EBT0001
                IF "Splited From Line" = 0 THEN BEGIN
                    "Split Line" := TRUE;
                    recSL.RESET;
                    recSL.SETRANGE(recSL."Document Type", "Document Type");
                    recSL.SETRANGE(recSL."Document No.", "Document No.");
                    recSL.SETRANGE(recSL."Line No.", "Splited From Line");
                    IF recSL.FINDFIRST THEN BEGIN
                        //IF recSL."Last splitted No." = "Line No." THEN
                        // ERROR('You have already splitted this line once');
                        recSL."Split Line" := TRUE;
                        recSL.VALIDATE(recSL.Quantity, (recSL.Quantity - Quantity));
                        //recSL.VALIDATE(recSL."Qty. to Ship",(recSL."Qty. to Ship"-Quantity));
                        recSL."Split Line" := FALSE;
                        recSL."Last splitted No." := "Line No.";
                        recSL.modified := FALSE;
                        recSL.MODIFY;
                        // RefreshStructure(recSL);
                    END;
                    MESSAGE('Please Calculate Structure Value');//09Aug2017
                END;
            end;
            //EBT0001
        }



        modify("TCS Nature of Collection")
        {
            trigger OnAfterValidate()
            var
                TCSNatureOfCollection: Record "TCS Nature Of Collection";
                recCustomer: Record 18;
                RecSH: Record 36;
                GLSetup: Record "General Ledger Setup";

                Text13700Y: Label 'You are not allowed to select this Nature of collection.';
                Text13701D: Label 'You cannot select this TCS nature of collection because customer turnover is greater than 10 crores.';
            begin
                //robotdsYSR_V2 --
                RecSH.GET("Document Type", "Document No.");
                GLSetup.GET;
                recCustomer.GET("Bill-to Customer No.");
                IF "TCS Nature of Collection" <> '' THEN BEGIN
                    TCSNatureOfCollection.GET("TCS Nature of Collection");
                    IF GLSetup."TDS Effective Date" <> 0D THEN
                        IF GLSetup."TDS Effective Date" <= RecSH."Posting Date" THEN BEGIN
                            IF recCustomer."Turnover Above 10 Crores" THEN
                                ERROR(Text13701D);
                            IF recCustomer."ITR filled for last 02 years" = TCSNatureOfCollection."Non ITR" THEN
                                ERROR(Text13700Y);
                        END;
                END;
                //robotdsYSR_V2 ++


            end;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    procedure MRPUpdationforInd()
    var
        recCustomer: Record 18;
    begin
        //ST32289 BEGIN
        recCustomer.GET("Bill-to Customer No.");
        IF recCustomer."National Discount Applicable" THEN
            EXIT;
        //ST32289 END

        /*
                IF NOT "Price Inclusive of Tax" THEN BEGIN
                    IF "MRP/Sales Price" <> 0 THEN BEGIN
                        VALIDATE("Unit Price", "MRP/Sales Price" * "Qty. per Unit of Measure");
                        VALIDATE("MRP Price", "MRP/Sales Price");
                    END;
                END
                */

    end;

    // MY PC 05 01 2024

    PROCEDURE CopyDimension();
    VAR
        lSalesInvLine: Record 113;
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        RecDimSetEntry: Record "Dimension Set Entry";
        cduDimMgt: Codeunit DimensionManagement;
    BEGIN
        //RSPL-TC +
        lSalesInvLine.RESET;
        lSalesInvLine.SETRANGE("Document No.", "Appiles to Inv.No.");
        lSalesInvLine.SETRANGE("Line No.", "Final Line No.");
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
            "Dimension Set ID" := cduDimMgt.GetDimensionSetID(TempDimSetEntry);
        END;
        //RSPL-TC -
    END;


    // MY PC 05 01 2024

    PROCEDURE SplitLine();
    VAR
        SalesHEBT: Record 36;
        EBTSalesLin: Record 37;
        LineNumber: Integer;
        NewSalesLine: Record 37;
    BEGIN
        SalesHEBT.RESET;
        SalesHEBT.SETRANGE(SalesHEBT."No.", "Document No.");
        IF SalesHEBT.FINDFIRST THEN BEGIN

            //IF SalesHEBT."Location Code"  'PLANT01' THEN
            IF (SalesHEBT."Location Code" <> 'PLANT01') AND (SalesHEBT."Location Code" <> 'PLANT03') THEN BEGIN
                IF "Qty. to Ship" = 0 THEN
                    ERROR('Nothing to split');
                IF "Qty. to Ship" = 1 THEN
                    ERROR('There is no need to split the quantity as Qty. to Ship is 1');
            END;

            //EBT STIVAN ---(18/12/2012)---SplitLine Functionality at Vasai Plant on the Base of Qty -------START
            IF SalesHEBT."Location Code" = 'PLANT01' THEN BEGIN
                IF Quantity = 0 THEN
                    ERROR('Nothing to split');
                IF Quantity = 1 THEN
                    ERROR('There is no need to split the quantity as Qty. to Ship is 1');
            END;
            //EBT STIVAN ---(18/12/2012)---SplitLine Functionality at Vasai Plant on the Base of Qty ---------END
        END;

        EBTSalesLin.RESET;
        EBTSalesLin.SETRANGE(EBTSalesLin."Document No.", "Document No.");
        IF EBTSalesLin.FINDLAST THEN
            LineNumber := EBTSalesLin."Line No.";

        "Split Line" := TRUE;
        MODIFY;
        NewSalesLine.INIT;
        NewSalesLine.TRANSFERFIELDS(Rec);
        NewSalesLine."Line No." := LineNumber + 10000;
        NewSalesLine.INSERT(TRUE);
        NewSalesLine.VALIDATE(NewSalesLine.Quantity, 0);
        NewSalesLine.modified := FALSE;
        //NewSalesLine."Split Line" := TRUE;
        //NewSalesLine.MODIFY;
        //NewSalesLine.VALIDATE(NewSalesLine."No.");
        NewSalesLine."Split Line" := FALSE;
        NewSalesLine."Splited From Line" := "Line No.";
        NewSalesLine."IOPL Split Line No." := "Line No."; //IOPL-TC
                                                          /// NewSalesLine.CopyStructureDetails; // MY PC 05 01 2023
        NewSalesLine.MODIFY;
        "Split Line" := FALSE;
        //SplittingLine := FALSE;
    END;
}