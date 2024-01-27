page 50083 "Posted Outward GateEntry List"
{
    // 08Aug2017 ::RB-N SameTable Filter as P#16598

    Caption = 'Posted Outward GateEntry List';
    CardPageID = "Posted Outward Gate Entry";
    Editable = false;
    PageType = List;
    SourceTable = "Posted Gate Entry Header";
    SourceTableView = SORTING("Entry Type", "No.")
                      ORDER(Ascending)
                      WHERE("Entry Type" = CONST(Outward),
                            "Vehicle Out" = FILTER(false),
                            "Location Code" = FILTER('PLANT01'));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                Editable = false;
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Caption = 'Gate Entry No.';
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Out Time"; rec."Out Time")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Vehicle Out"; rec."Vehicle Out")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Out Date"; rec."Out Date")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Document Time"; rec."Document Time")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Item Description"; rec."Item Description")
                {
                    ApplicationArea = all;
                }
                field("LR/RR No."; rec."LR/RR No.")
                {
                    ApplicationArea = all;
                }
                field("LR/RR Date"; rec."LR/RR Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Inward Vehicle Posted")
            {
                Image = Print;

                trigger OnAction()
                begin
                    PstGateEntry.RESET;
                    PstGateEntry.SETRANGE(PstGateEntry."Entry Type", rec."Entry Type");
                    PstGateEntry.SETRANGE(PstGateEntry."No.", rec."No.");
                    REPORT.RUN(50056, TRUE, FALSE, PstGateEntry);
                end;
            }
        }
    }

    var
        CSOMapping2: Record 50006;
        PSIH: Record "Posted Gate Entry Header";
        CSOMapping: Record 50006;
        CSOMapping1: Record 50006;
        "---04Apr2017": Integer;
        PstGateEntry: Record "Posted Gate Entry Header";
}

