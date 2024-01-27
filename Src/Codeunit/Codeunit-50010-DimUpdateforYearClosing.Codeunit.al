codeunit 50010 "Dim Update for Year Closing"
{

    trigger OnRun()
    begin
        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", 'GENERAL');
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", 'DEFAULT');
        IF GenJnlLine.FINDSET THEN
            REPEAT
                /* //RSPL-TC
                dimJournal.INIT;
                dimJournal."Table ID":=81;
                dimJournal."Journal Template Name":=GenJnlLine."Journal Template Name";
                dimJournal."Journal Batch Name":=GenJnlLine."Journal Batch Name";
                dimJournal."Journal Line No.":=GenJnlLine."Line No.";
                dimJournal."Dimension Code":='DISCOUNT';
                dimJournal."Dimension Value Code":='CD';
                dimJournal.INSERT;
                */
                TempDimSetEntry.RESET;
                TempDimSetEntry.DELETEALL;

                RecDimSetEntry.RESET;
                RecDimSetEntry.SETRANGE("Dimension Set ID", GenJnlLine."Dimension Set ID");
                IF RecDimSetEntry.FINDSET THEN
                    REPEAT
                        TempDimSetEntry.INIT;
                        TempDimSetEntry.VALIDATE("Dimension Code", RecDimSetEntry."Dimension Code");
                        TempDimSetEntry.VALIDATE("Dimension Value Code", RecDimSetEntry."Dimension Value Code");
                        TempDimSetEntry.INSERT;
                    UNTIL RecDimSetEntry.NEXT = 0;

                TempDimSetEntry.INIT;
                TempDimSetEntry.VALIDATE("Dimension Code", 'DISCOUNT');
                TempDimSetEntry.VALIDATE("Dimension Value Code", 'CD');
                TempDimSetEntry.INSERT;
                GenJnlLine."Dimension Set ID" := cduDimMgt.GetDimensionSetID(TempDimSetEntry);
                GenJnlLine.MODIFY;
            UNTIL GenJnlLine.NEXT = 0;
        MESSAGE('Done');

    end;

    var
        GenJnlLine: Record 81;
        TempDimSetEntry: Record 480 temporary;
        cduDimMgt: Codeunit DimensionManagement;
        RecDimSetEntry: Record 480;
}

