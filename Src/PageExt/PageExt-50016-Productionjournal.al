pageextension 50016 ProducionJnCardCstm extends "Production Journal"
{
    layout
    {
        addafter("Item No.")
        {
            field("Item By Location"; Rec."Item By Location")
            {
                ApplicationArea = all;
                Style = AttentionAccent;
                StyleExpr = TRUE;
            }
            field("Density Factor"; Rec."Density Factor")
            {
                ApplicationArea = all;
                DecimalPlaces = 4 : 4;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                recItemJnlLine: Record "Item Journal Line";
                LocationRec: Record Location;
                ProdOrder: Record "Production Order";
                recItemVersionParmeterResults: Record 50015;
                ProductionValidation: Boolean;
                IJL08: Record "Item Journal Line";
                IJL10: Record "Item Journal Line";
                ILE10: Record "Item Ledger Entry";
            begin
                //EBT0002
                recItemJnlLine.RESET;
                recItemJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                recItemJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                recItemJnlLine.SETRANGE("Entry Type", recItemJnlLine."Entry Type"::Consumption);
                IF recItemJnlLine.FINDSET THEN
                    REPEAT
                        LocationRec.GET(recItemJnlLine."Location Code");
                        IF LocationRec."Production Bin" <> '' THEN
                            IF recItemJnlLine."Bin Code" <> LocationRec."Production Bin" THEN
                                ERROR('Consumption must be from production Bin %1', LocationRec."Production Bin");
                    UNTIL recItemJnlLine.NEXT = 0;
                //EBT0002

                //EBT STIVAN---(131212)--- To Check Density Factor in case of Output Etry Type should not be Blank------START
                recItemJnlLine.RESET;
                recItemJnlLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                recItemJnlLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                recItemJnlLine.SETRANGE("Document No.", rec."Document No.");
                recItemJnlLine.SETRANGE("Entry Type", recItemJnlLine."Entry Type"::Output);
                IF recItemJnlLine.FINDFIRST THEN BEGIN
                    IF recItemJnlLine."Density Factor" = 0 THEN
                        ERROR('Please Specify Density Factor For Output Line');
                END;
                //EBT STIVAN---(131212)--- To Check Density Factor in case of Output Etry Type should not be Blank--------END

                //EBT STIVAN---(24/07/2013)---To Check if QC is not Copied-----START
                ProdOrder.RESET;
                ProdOrder.SETRANGE(ProdOrder."No.", rec."Document No.");
                ProdOrder.SETRANGE(ProdOrder."Order Type", ProdOrder."Order Type"::Secondary);
                IF ProdOrder.FINDFIRST THEN BEGIN
                    recItemVersionParmeterResults.RESET;
                    recItemVersionParmeterResults.SETRANGE(recItemVersionParmeterResults."Blend Order No", rec."Document No.");
                    IF NOT (recItemVersionParmeterResults.FINDFIRST) THEN BEGIN
                        ERROR('Please Copy the TC again');
                    END;
                END;
                //EBT STIVAN---(24/07/2013)---To Check if QC is not Copied-------END

                //>>08Aug2018
                ProductionValidation := FALSE;
                IJL10.RESET;
                IJL10.SETRANGE("Journal Template Name", rec."Journal Template Name");
                IJL10.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                IJL10.SETRANGE("Document No.", rec."Document No.");
                IJL10.SETRANGE("Entry Type", IJL10."Entry Type"::Output);
                IF IJL10.FINDFIRST THEN BEGIN
                    ILE10.RESET;
                    ILE10.SETCURRENTKEY("Document No.", "Posting Date", "Item No.");
                    ILE10.SETRANGE("Document No.", IJL10."Document No.");
                    ILE10.SETRANGE("Item No.", IJL10."Item No.");
                    ILE10.SETRANGE("Entry Type", ILE10."Entry Type"::Output);
                    IF ILE10.FINDFIRST THEN BEGIN
                        ProductionValidation := TRUE;
                    END ELSE BEGIN
                        IJL08.RESET;
                        IJL08.SETRANGE("Journal Template Name", rec."Journal Template Name");
                        IJL08.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                        IJL08.SETRANGE("Document No.", rec."Document No.");
                        IJL08.SETRANGE("Entry Type", IJL08."Entry Type"::Consumption);
                        IF NOT IJL08.FINDFIRST THEN BEGIN
                            IF (rec."Item Category Code" <> 'CAT04') AND (rec."Item Category Code" <> 'CAT07') AND (rec."Item Category Code" <> 'CAT08') THEN//RSPLSUM 03Feb21
                                ERROR('Consumption Item Not Found');
                        END;//RSPLSUM 03Feb21

                        IJL08.RESET;
                        IJL08.SETRANGE("Journal Template Name", rec."Journal Template Name");
                        IJL08.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                        IJL08.SETRANGE("Document No.", rec."Document No.");
                        IJL08.SETRANGE("Entry Type", IJL08."Entry Type"::Consumption);
                        IF IJL08.FINDFIRST THEN BEGIN
                            IJL08.CALCSUMS(Quantity);
                            IF IJL08.Quantity = 0 THEN
                                ERROR('Consumption Quantity Cannot be Zero');

                        END;
                    END;
                END;

                //<<08Aug2018

            end;


        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
                recItemJnlLine: Record "Item Journal Line";
                LocationRec: Record Location;
                ProdOrder: Record "Production Order";
                recItemVersionParmeterResults: Record 50015;
                ProductionValidation: Boolean;
                IJL08: Record "Item Journal Line";
                IJL10: Record "Item Journal Line";
                ILE10: Record "Item Ledger Entry";
            begin
                //EBT0002
                recItemJnlLine.RESET;
                recItemJnlLine.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                recItemJnlLine.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                recItemJnlLine.SETRANGE("Entry Type", recItemJnlLine."Entry Type"::Consumption);
                IF recItemJnlLine.FINDSET THEN
                    REPEAT
                        LocationRec.GET(recItemJnlLine."Location Code");
                        IF LocationRec."Production Bin" <> '' THEN
                            IF recItemJnlLine."Bin Code" <> LocationRec."Production Bin" THEN
                                ERROR('Consumption must be from production Bin %1', LocationRec."Production Bin");
                    UNTIL recItemJnlLine.NEXT = 0;
                //EBT0002

                //EBT STIVAN---(131212)--- To Check Density Factor in case of Output Etry Type should not be Blank------START
                recItemJnlLine.RESET;
                recItemJnlLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                recItemJnlLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                recItemJnlLine.SETRANGE("Document No.", rec."Document No.");
                recItemJnlLine.SETRANGE("Entry Type", recItemJnlLine."Entry Type"::Output);
                IF recItemJnlLine.FINDFIRST THEN BEGIN
                    IF recItemJnlLine."Density Factor" = 0 THEN
                        ERROR('Please Specify Density Factor For Output Line');
                END;
                //EBT STIVAN---(131212)--- To Check Density Factor in case of Output Etry Type should not be Blank--------END

                //EBT STIVAN---(24/07/2013)---To Check if QC is not Copied-----START
                ProdOrder.RESET;
                ProdOrder.SETRANGE(ProdOrder."No.", rec."Document No.");
                ProdOrder.SETRANGE(ProdOrder."Order Type", ProdOrder."Order Type"::Secondary);
                IF ProdOrder.FINDFIRST THEN BEGIN
                    recItemVersionParmeterResults.RESET;
                    recItemVersionParmeterResults.SETRANGE(recItemVersionParmeterResults."Blend Order No", rec."Document No.");
                    IF NOT (recItemVersionParmeterResults.FINDFIRST) THEN BEGIN
                        ERROR('Please Copy the TC again');
                    END;
                END;
                //EBT STIVAN---(24/07/2013)---To Check if QC is not Copied-------END

                //>>08Aug2018
                ProductionValidation := FALSE;
                IJL10.RESET;
                IJL10.SETRANGE("Journal Template Name", rec."Journal Template Name");
                IJL10.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                IJL10.SETRANGE("Document No.", rec."Document No.");
                IJL10.SETRANGE("Entry Type", IJL10."Entry Type"::Output);
                IF IJL10.FINDFIRST THEN BEGIN
                    ILE10.RESET;
                    ILE10.SETCURRENTKEY("Document No.", "Posting Date", "Item No.");
                    ILE10.SETRANGE("Document No.", IJL10."Document No.");
                    ILE10.SETRANGE("Item No.", IJL10."Item No.");
                    ILE10.SETRANGE("Entry Type", ILE10."Entry Type"::Output);
                    IF ILE10.FINDFIRST THEN BEGIN
                        ProductionValidation := TRUE;
                    END ELSE BEGIN
                        IJL08.RESET;
                        IJL08.SETRANGE("Journal Template Name", rec."Journal Template Name");
                        IJL08.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                        IJL08.SETRANGE("Document No.", rec."Document No.");
                        IJL08.SETRANGE("Entry Type", IJL08."Entry Type"::Consumption);
                        IF NOT IJL08.FINDFIRST THEN BEGIN
                            IF (rec."Item Category Code" <> 'CAT04') AND (rec."Item Category Code" <> 'CAT07') AND (rec."Item Category Code" <> 'CAT08') THEN//RSPLSUM 03Feb21
                                ERROR('Consumption Item Not Found');
                        END;//RSPLSUM 03Feb21

                        IJL08.RESET;
                        IJL08.SETRANGE("Journal Template Name", rec."Journal Template Name");
                        IJL08.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                        IJL08.SETRANGE("Document No.", rec."Document No.");
                        IJL08.SETRANGE("Entry Type", IJL08."Entry Type"::Consumption);
                        IF IJL08.FINDFIRST THEN BEGIN
                            IJL08.CALCSUMS(Quantity);
                            IF IJL08.Quantity = 0 THEN
                                ERROR('Consumption Quantity Cannot be Zero');

                        END;
                    END;
                END;

                //<<08Aug2018

            end;

        }
    }

    var
        myInt: Integer;
}