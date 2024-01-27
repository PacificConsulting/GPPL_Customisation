codeunit 55555 "Update Dim"
{

    trigger OnRun()
    begin
        recDefaultDim.RESET;
        recDefaultDim.SETRANGE(recDefaultDim."Table ID", 18);
        recDefaultDim.SETRANGE(recDefaultDim."Dimension Code", 'EMPHIERPO');
        IF recDefaultDim.FINDSET THEN
            REPEAT
                recCustLedgerEntry.RESET;
                recCustLedgerEntry.SETRANGE(recCustLedgerEntry."Customer No.", recDefaultDim."No.");
                recCustLedgerEntry.SETRANGE(recCustLedgerEntry."Document Type", recCustLedgerEntry."Document Type"::Payment);
                recCustLedgerEntry.SETRANGE(recCustLedgerEntry.Open, TRUE);
                IF recCustLedgerEntry.FINDSET THEN
                    REPEAT
                        //RSPL-TC +
                        TempDimSetEntry.RESET;
                        TempDimSetEntry.DELETEALL;

                        RecDimSetEntry.RESET;
                        RecDimSetEntry.SETRANGE("Dimension Set ID", recCustLedgerEntry."Dimension Set ID");
                        IF RecDimSetEntry.FINDSET THEN
                            REPEAT
                                TempDimSetEntry.INIT;
                                TempDimSetEntry.VALIDATE("Dimension Code", RecDimSetEntry."Dimension Code");
                                TempDimSetEntry.VALIDATE("Dimension Value Code", RecDimSetEntry."Dimension Value Code");
                                TempDimSetEntry.INSERT;
                            UNTIL RecDimSetEntry.NEXT = 0;

                        TempDimSetEntry.INIT;
                        TempDimSetEntry.VALIDATE("Dimension Code", 'EMPHIERPO');
                        TempDimSetEntry.VALIDATE("Dimension Value Code", recDefaultDim."Dimension Value Code");
                        TempDimSetEntry.INSERT;
                        recCustLedgerEntry."Dimension Set ID" := cduDimMgt.GetDimensionSetID(TempDimSetEntry);
                        recCustLedgerEntry.MODIFY;
                        //RSPL-TC -

                        /*//RSPL-TC
                        recLedgerEntryDim.RESET;
                        recLedgerEntryDim.SETRANGE(recLedgerEntryDim."Table ID",21);
                        recLedgerEntryDim.SETRANGE(recLedgerEntryDim."Entry No.",recCustLedgerEntry."Entry No.");
                        recLedgerEntryDim.SETRANGE(recLedgerEntryDim."Dimension Code",'EMPHIERPO');
                        IF NOT recLedgerEntryDim.FINDFIRST THEN
                        BEGIN
                          insertLedgerDim.INIT;
                          insertLedgerDim."Table ID":=21;
                          insertLedgerDim."Entry No.":=recCustLedgerEntry."Entry No.";
                          insertLedgerDim."Dimension Code":='EMPHIERPO';
                          insertLedgerDim."Dimension Value Code":=recDefaultDim."Dimension Value Code";
                          insertLedgerDim.INSERT;
                        END;
                        */
                        recGLEntry.RESET;
                        recGLEntry.SETRANGE(recGLEntry."Document No.", recCustLedgerEntry."Document No.");
                        IF recGLEntry.FINDSET THEN
                            REPEAT
                                /*//RSPL-TC
                                recLedgerEntryDim.RESET;
                                recLedgerEntryDim.SETRANGE(recLedgerEntryDim."Table ID",17);
                                recLedgerEntryDim.SETRANGE(recLedgerEntryDim."Entry No.",recGLEntry."Entry No.");
                                recLedgerEntryDim.SETRANGE(recLedgerEntryDim."Dimension Code",'EMPHIERPO');
                                IF NOT recLedgerEntryDim.FINDFIRST THEN BEGIN
                                  insertLedgerDim.INIT;
                                  insertLedgerDim."Table ID":=17;
                                  insertLedgerDim."Entry No.":=recGLEntry."Entry No.";
                                  insertLedgerDim."Dimension Code":='EMPHIERPO';
                                  insertLedgerDim."Dimension Value Code":=recDefaultDim."Dimension Value Code";
                                  insertLedgerDim.INSERT;
                                END;
                                */
                                //RSPL-TC +
                                TempDimSetEntry.RESET;
                                TempDimSetEntry.DELETEALL;

                                RecDimSetEntry.RESET;
                                RecDimSetEntry.SETRANGE("Dimension Set ID", recGLEntry."Dimension Set ID");
                                IF RecDimSetEntry.FINDSET THEN
                                    REPEAT
                                        TempDimSetEntry.INIT;
                                        TempDimSetEntry.VALIDATE("Dimension Code", RecDimSetEntry."Dimension Code");
                                        TempDimSetEntry.VALIDATE("Dimension Value Code", RecDimSetEntry."Dimension Value Code");
                                        TempDimSetEntry.INSERT;
                                    UNTIL RecDimSetEntry.NEXT = 0;

                                TempDimSetEntry.INIT;
                                TempDimSetEntry.VALIDATE("Dimension Code", 'EMPHIERPO');
                                TempDimSetEntry.VALIDATE("Dimension Value Code", recDefaultDim."Dimension Value Code");
                                TempDimSetEntry.INSERT;
                                recGLEntry."Dimension Set ID" := cduDimMgt.GetDimensionSetID(TempDimSetEntry);
                                recGLEntry.MODIFY;
                            //RSPL-TC -
                            UNTIL recGLEntry.NEXT = 0;
                    UNTIL recCustLedgerEntry.NEXT = 0;
            UNTIL recDefaultDim.NEXT = 0;
        MESSAGE('Done');

    end;

    var
        recDefaultDim: Record 352;
        recCustLedgerEntry: Record 21;
        recGLEntry: Record 17;
        TempDimSetEntry: Record 480 temporary;
        cduDimMgt: Codeunit DimensionManagement;
        RecDimSetEntry: Record 480;
}

