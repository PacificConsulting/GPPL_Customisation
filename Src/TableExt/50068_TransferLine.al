tableextension 50068 TransferLineExtCstm extends "Transfer Line"
{
    fields
    {
        field(50000; "Transfer Indent No."; Code[20])
        {
            Description = 'EBT/TROIndent/0001';
            TableRelation = "Transfer Indent Header";
        }
        field(50001; "Transfer Indent Line No."; Integer)
        {
            Description = 'EBT/TROIndent/0001';
        }
        field(50002; "Original Qty"; Decimal)
        {
            Description = 'EBT/TROIndent/0001';
        }
        field(50003; "GRN Number"; Code[20])
        {
            Description = 'EBT';
            TableRelation = "Purch. Rcpt. Header";
        }
        field(50004; "BCD Value"; Decimal)
        {
        }
        field(50005; "Lot No."; Code[20])
        {
            Description = 'EBT/RG23D/0001';
            Editable = false;
        }
        field(50006; "Transfer Price of Base Unit"; Decimal)
        {

            trigger OnValidate()
            begin
                //VALIDATE("Transfer Price", "Transfer Price of Base Unit" * "Qty. per Unit of Measure");//Azhar Pending
                //VALIDATE("Unit Cost","Transfer Price");
                //VALIDATE("Assessable Value","Transfer Price");
            end;
        }
        field(50007; "Split Line"; Boolean)
        {
            Description = 'EBT STIVAN (03/07/2013)-For Split Line Functionality';
        }
        field(50008; "Splited From Line"; Integer)
        {
            Description = 'EBT STIVAN (03/07/2013)-For Split Line Functionality';
        }
        field(50009; "Last Splited No."; Integer)
        {
            Description = 'EBT STIVAN (03/07/2013)-For Split Line Functionality';
        }
        modify("GST Group Code")
        {
            trigger OnAfterValidate()
            var
                RecLoc: Record Location;
            begin
                //RSPL01
                RecLoc.GET("Transfer-from Code");
                IF NOT (RecLoc."Location Type" = RecLoc."Location Type"::Bonded) THEN
                    TestStatusOpen;
                //RSPL01
                //TestStatusShip;
                "HSN/SAC Code" := '';
            end;
        }
        modify("HSN/SAC Code")
        {
            trigger OnAfterValidate()
            var
                RecLoc: Record Location;
            begin
                //RSPL01
                RecLoc.GET("Transfer-from Code");
                IF NOT (RecLoc."Location Type" = RecLoc."Location Type"::Bonded) THEN
                    TestStatusOpen;
                //RSPL01
                //TestStatusShip;
            end;
        }

        /// MY PC 09 01 2024
        /// 
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                TLrec: Record 5741;
                recTL: Record "Transfer Line";
            begin

                //EBT STIVAN---(03/07/2013)---For Split Line Functionality-----------------------------START

                IF "Splited From Line" <> 0 THEN;
                BEGIN
                    "Split Line" := TRUE;
                    recTL.RESET;
                    recTL.SETRANGE(recTL."Document No.", "Document No.");
                    recTL.SETRANGE(recTL."Line No.", "Splited From Line");
                    IF recTL.FINDFIRST THEN BEGIN
                        recTL."Split Line" := TRUE;
                        recTL.VALIDATE(recTL.Quantity, (recTL.Quantity - Quantity));
                        recTL."Split Line" := FALSE;
                        recTL."Last Splited No." := "Line No.";
                        recTL.MODIFY;
                        // RefreshStructure(recTL);
                    END;
                    MESSAGE('Please Calculate Structure Value');//09Aug2017
                END;
                //EBT STIVAN---(03/07/2013)---For Split Line Functionality-------------------------------END

                IF ("Split Line" = FALSE) AND ("Splited From Line" = 0) THEN BEGIN
                    //EBT STIVAN ---(25012013)---Qty change should not be allowed in case of Indent No is not Blank on Lines----START
                    IF xRec.Quantity <> 0 THEN BEGIN
                        TLrec.RESET;
                        TLrec.SETRANGE(TLrec."Document No.", "Document No.");
                        TLrec.SETRANGE(TLrec."Line No.", "Line No.");
                        TLrec.SETFILTER(TLrec."Transfer Indent No.", '%1', '');
                        TLrec.SETFILTER(TLrec."Transfer Indent Line No.", '%1', 0);
                        IF TLrec.FINDFIRST THEN BEGIN
                            IF TLrec.Quantity <> Quantity THEN
                                ERROR('You are not allowed to change the Qty');
                        END;
                    END;
                    //EBT STIVAN ---(25012013)---Qty change should not be allowed in case of Indent No is not Blank on Lines------END
                END;

                //EBT/TROIndent/0001
                IF "Original Qty" <> 0 THEN
                    IF Quantity > "Original Qty" THEN
                        ERROR('Quantity cannot be greater than the Indent request Quantity');
                //EBT/TROIndent/0001

            end;
        }

        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                item: Record 27;
            begin
                //EBT0001
                IF NOT (("Inventory Posting Group" = 'INDOILS') OR ("Inventory Posting Group" = 'AUTOOILS')
                OR ("Inventory Posting Group" = 'RPO') OR ("Inventory Posting Group" = 'BOILS') OR
                ("Inventory Posting Group" = 'TOILS') OR ("Inventory Posting Group" = 'REPSOL')) THEN
                    VALIDATE("Transfer Price of Base Unit", Item."Unit Cost");
                //"Assessable Value" := Item."Assessable Value";
                //EBT0001

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
    trigger OnBeforeDelete()
    var
        UserSetupT: Record "User Setup";
    begin
        //>>RB-N 21Sep2017 User TRO Deletion
        UserSetupT.RESET;
        UserSetupT.SETRANGE("User ID", USERID);
        UserSetupT.SETRANGE("TRO Deletion", TRUE);
        IF NOT UserSetupT.FINDFIRST THEN
            ERROR('You are not allowed to delete the Line');
        //<<RB-N 21Sep2017 User TRO Deletion
        IF (USERID <> 'sa') AND (USERID <> 'GPUAE\FAHIM.AHMAD') AND (USERID <> 'GPUAE\RAVI.KHAMBAL') AND (USERID <> 'ROBOSOFT.SUPPORT3') THEN BEGIN
            // EBT MILAN TO add delete functionality to GT514  (140213) ------------------------------------------------END
            IF "Transfer Indent No." <> '' THEN
                ERROR('Your are not allowed to Delete the Line');
        END;
    end;

    var
        myInt: Integer;

    procedure ResevedBatchesLinewise()
    var
        ReservationENtry: Record 337;
    begin


        ReservationENtry.RESET;
        ReservationENtry.SETRANGE(ReservationENtry."Item No.", "Item No.");
        ReservationENtry.SETRANGE(ReservationENtry."Location Code", "Transfer-from Code");
        IF ReservationENtry.FINDFIRST THEN BEGIN
            REPORT.RUN(50050, TRUE, FALSE, ReservationENtry);
        END;
    end;

    procedure SplitLine()
    var
        EBTTransHeader: Record 5740;
        NewTransLine: Record "Transfer Line";
        EBTTransLIne: Record "Transfer Line";
        LineNumber: Integer;
    begin

        EBTTransHeader.RESET;
        EBTTransHeader.SETRANGE(EBTTransHeader."No.", "Document No.");
        IF EBTTransHeader.FINDFIRST THEN BEGIN

            IF EBTTransHeader."Transfer-from Code" <> 'PLANT01' THEN BEGIN
                IF "Qty. to Ship" = 0 THEN
                    ERROR('Nothing to split');
                IF "Qty. to Ship" = 1 THEN
                    ERROR('There is no need to split the quantity as Qty. to Ship is 1');
            END;

            IF EBTTransHeader."Transfer-from Code" = 'PLANT01' THEN BEGIN
                IF Quantity = 0 THEN
                    ERROR('Nothing to split');
                IF Quantity = 1 THEN
                    ERROR('There is no need to split the quantity as Qty. to Ship is 1');
            END;

            EBTTransLIne.RESET;
            EBTTransLIne.SETRANGE(EBTTransLIne."Document No.", "Document No.");
            IF EBTTransLIne.FINDLAST THEN BEGIN
                LineNumber := EBTTransLIne."Line No.";
            END;

            EBTTransLIne.RESET;
            EBTTransLIne.SETRANGE(EBTTransLIne."Document No.", "Document No.");
            IF EBTTransLIne.FINDFIRST THEN BEGIN
                "Split Line" := TRUE;
                NewTransLine.INIT;
                NewTransLine.TRANSFERFIELDS(Rec);
                NewTransLine."Line No." := LineNumber + 10000;
                NewTransLine.INSERT(TRUE);
                NewTransLine.VALIDATE(NewTransLine.Quantity, 0);
                NewTransLine."Split Line" := FALSE;
                NewTransLine."Splited From Line" := "Line No.";
                NewTransLine."Last Splited No." := 0;
                //NewTransLine.CopyStructureDetails;
                NewTransLine.MODIFY;
            END;

        end;
    end;

    PROCEDURE UpdateMRP();
    VAR
        MRPMaster: Record 50013;
        LocationFrom: Record 14;
        LocationTo: Record 14;
        ILE: Record 32;
        PostedTransferReceipt: Record 5747;
        ListPrice: Decimal;
        ValueEntry: Record 5802;
    // SalesPrice : Record 7002;
    /// RG23DNew : Record 16537;
    BEGIN
        IF "Lot No." <> '' THEN BEGIN
            MRPMaster.RESET;
            MRPMaster.SETRANGE(MRPMaster."Item No.", "Item No.");
            MRPMaster.SETRANGE(MRPMaster."Lot No.", "Lot No.");
            //MRPMaster.SETRANGE(MRPMaster."Unit Of Measure","Unit of Measure Code");
            IF MRPMaster.FINDFIRST THEN BEGIN
                // VALIDATE(MRP,MRPMaster.MRP);
                VALIDATE("Transfer Price of Base Unit", MRPMaster."Stock Transfer Price" / "Qty. per Unit of Measure");
                //  VALIDATE("Assessable Value",MRPMaster."Assessable Value"*"Qty. per Unit of Measure");
                //  VALIDATE("MRP Price",MRPMaster."MRP Price");
                //MODIFY;
            END

        END;
    END;

    PROCEDURE UpdatePrice();
    VAR
        TransferFromLoc: Record 14;
        TransferToLoc: Record 14;
        ILE: Record 32;
        PostedTransferReceipt: Record 5747;
        ValueEntry: Record 5802;
        ListPrice: Decimal;
    //   SalesPrice: Record 7002;
    BEGIN
        //  {IF (("Inventory Posting Group" <> 'INDOILS') OR ("Inventory Posting Group" <> 'AUTOOILS')) THEN
        //  EXIT;  }
        IF "Lot No." = '' THEN BEGIN
            IF ("Inventory Posting Group" = 'INDOILS') OR ("Inventory Posting Group" = 'RPO') OR    //RSPL-Sourav
            ("Inventory Posting Group" = 'BOILS') OR ("Inventory Posting Group" = 'TOILS')
            OR ("Inventory Posting Group" = 'REPSOL') THEN BEGIN
                TransferFromLoc.GET("Transfer-from Code");
                TransferToLoc.GET("Transfer-to Code");
                IF TransferFromLoc."Trading Location" THEN BEGIN
                    ILE.RESET;
                    ILE.SETRANGE(ILE."Entry Type", ILE."Entry Type"::Transfer);
                    ILE.SETRANGE(ILE.Positive, TRUE);
                    ILE.SETRANGE("Item No.", "Item No.");
                    ILE.SETRANGE(ILE."Location Code", TransferFromLoc.Code);
                    IF ILE.FINDLAST THEN BEGIN
                        PostedTransferReceipt.RESET;
                        PostedTransferReceipt.SETRANGE(PostedTransferReceipt."Document No.", ILE."Document No.");
                        PostedTransferReceipt.SETRANGE(PostedTransferReceipt."Item No.", ILE."Item No.");
                        IF PostedTransferReceipt.FINDFIRST THEN BEGIN
                            ListPrice := PostedTransferReceipt."Unit Price";
                            VALIDATE("Transfer Price of Base Unit", ListPrice / "Qty. per Unit of Measure");
                        END;
                    END;
                END
                ELSE BEGIN
                    ValueEntry.RESET;
                    ValueEntry.SETRANGE(ValueEntry."Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
                    ValueEntry.SETRANGE(ValueEntry."Item No.", "Item No.");
                    ValueEntry.SETRANGE(ValueEntry."Location Code", "Transfer-to Code");
                    ValueEntry.SETFILTER(ValueEntry."Invoiced Quantity", '%1', 0);
                    IF ValueEntry.FINDLAST THEN BEGIN
                        ILE.GET(ValueEntry."Item Ledger Entry No.");
                        ListPrice := ABS(ValueEntry."Sales Amount (Actual)") / (ABS(ILE.Quantity));
                        VALIDATE("Transfer Price of Base Unit", ListPrice);
                    END;
                END;
            END;
            IF ListPrice = 0 THEN BEGIN
                // SalesPrice.RESET;
                // SalesPrice.SETRANGE(SalesPrice."Item No.", "Item No.");
                // SalesPrice.SETRANGE(SalesPrice."Unit of Measure Code", "Unit of Measure Code");
                // IF SalesPrice.FINDLAST THEN BEGIN
                //     ListPrice := SalesPrice."Transfer Price" / "Qty. per Unit of Measure";
                //   VALIDATE("Transfer Price of Base Unit", ListPrice);
                //  //validate("assessable value,",salesprice."assesable value"*"Qty. per Unit of Measure");  //assessable value code block
                //  VALIDATE("Assessable Value", SalesPrice."Assessable Value" * "Qty. per Unit of Measure"); // radhesh 26-10-12
                //  END;
            END;

            IF ListPrice = 0 THEN
                MESSAGE('There is no price defined for this Item');
        END;
    END;
}