codeunit 50003 "Update Dimension"
{

    trigger OnRun()
    var
        TempDimSetEntry: Record 480 temporary;
        cduDimMgt: Codeunit DimensionManagement;
        RecDimSetEntry: Record 480;
    begin
        genJnlLine.RESET;
        genJnlLine.SETRANGE(genJnlLine."Journal Batch Name", 'DEFAULT');
        genJnlLine.SETRANGE(genJnlLine."Journal Template Name", 'GENERAL');
        IF genJnlLine.FINDSET THEN
            REPEAT
                //RSPL-TC +
                TempDimSetEntry.RESET;
                TempDimSetEntry.DELETEALL;

                RecDimSetEntry.RESET;
                RecDimSetEntry.SETRANGE("Dimension Set ID", genJnlLine."Dimension Set ID");
                IF RecDimSetEntry.FINDSET THEN
                    REPEAT
                        TempDimSetEntry.INIT;
                        TempDimSetEntry.VALIDATE("Dimension Code", RecDimSetEntry."Dimension Code");
                        TempDimSetEntry.VALIDATE("Dimension Value Code", RecDimSetEntry."Dimension Value Code");
                        TempDimSetEntry.INSERT;
                    UNTIL RecDimSetEntry.NEXT = 0;
                //RSPL-TC -

                recDefaultDim.RESET;
                recDefaultDim.SETRANGE(recDefaultDim."Table ID", 15);
                recDefaultDim.SETRANGE(recDefaultDim."No.", genJnlLine."Account No.");
                IF recDefaultDim.FINDFIRST THEN BEGIN
                    REPEAT
                        /* //RSPL-TC
                        JnlLineDim.RESET;
                        JnlLineDim.SETRANGE(JnlLineDim."Table ID",81);
                        JnlLineDim.SETRANGE(JnlLineDim."Journal Template Name",genJnlLine."Journal Template Name");
                        JnlLineDim.SETRANGE(JnlLineDim."Journal Batch Name",genJnlLine."Journal Batch Name");
                        JnlLineDim.SETRANGE(JnlLineDim."Journal Line No.",genJnlLine."Line No.");
                        JnlLineDim.SETRANGE(JnlLineDim."Dimension Code",recDefaultDim."Dimension Code");
                        IF NOT JnlLineDim.FINDFIRST THEN BEGIN
                          insertLineDin.INIT;
                          insertLineDin."Table ID":=81;
                          insertLineDin."Journal Template Name":=genJnlLine."Journal Template Name";
                          insertLineDin."Journal Batch Name":=genJnlLine."Journal Batch Name";
                          insertLineDin."Journal Line No.":=genJnlLine."Line No.";
                          insertLineDin."Dimension Code":=recDefaultDim."Dimension Code";
                          recGLEntry.RESET;
                          recGLEntry.SETRANGE(recGLEntry."G/L Account No.",genJnlLine."Account No.");
                          IF recGLEntry.FINDLAST THEN
                          BEGIN
                            LedgerEntryDim.RESET;
                            LedgerEntryDim.SETRANGE(LedgerEntryDim."Table ID",17);
                            LedgerEntryDim.SETRANGE(LedgerEntryDim."Entry No.",recGLEntry."Entry No.");
                            LedgerEntryDim.SETRANGE(LedgerEntryDim."Dimension Code",recDefaultDim."Dimension Code");
                            IF LedgerEntryDim.FINDFIRST THEN
                              insertLineDin."Dimension Value Code":=LedgerEntryDim."Dimension Value Code";
                            END;
                          insertLineDin.INSERT;
                        END;
                        */
                        //RSPL-TC +
                        recGLEntry.RESET;
                        recGLEntry.SETRANGE(recGLEntry."G/L Account No.", genJnlLine."Account No.");
                        IF recGLEntry.FINDLAST THEN BEGIN
                            RecDimSetEntry.RESET;
                            RecDimSetEntry.SETRANGE("Dimension Set ID", recGLEntry."Dimension Set ID");
                            RecDimSetEntry.SETRANGE("Dimension Code", recDefaultDim."Dimension Code");
                            IF RecDimSetEntry.FINDSET THEN
                                REPEAT
                                    TempDimSetEntry.INIT;
                                    TempDimSetEntry.VALIDATE("Dimension Code", RecDimSetEntry."Dimension Code");
                                    TempDimSetEntry.VALIDATE("Dimension Value Code", RecDimSetEntry."Dimension Value Code");
                                    TempDimSetEntry.INSERT;
                                UNTIL RecDimSetEntry.NEXT = 0;
                        END;
                    UNTIL recDefaultDim.NEXT = 0;
                    genJnlLine."Dimension Set ID" := cduDimMgt.GetDimensionSetID(TempDimSetEntry);
                    genJnlLine.MODIFY;
                    //RSPL-TC -
                END;
            UNTIL genJnlLine.NEXT = 0;
        MESSAGE('done');

    end;

    var
        genJnlLine: Record 81;
        recDefaultDim: Record 352;
        recGLEntry: Record 17;
}

