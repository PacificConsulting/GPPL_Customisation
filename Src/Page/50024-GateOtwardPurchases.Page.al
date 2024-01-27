page 50024 "Gate Otward - Purchases"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Posted Gate Entry Header";
    SourceTableView = WHERE("Entry Type" = CONST(Inward),
                            "Vehicle Out" = FILTER(false));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Posting Time"; rec."Posting Time")
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Gate Entry No."; rec."Gate Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Driver's Name"; rec."Driver's Name")
                {
                    ApplicationArea = all;
                }
                field("Driver's Mobile No."; rec."Driver's Mobile No.")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Out"; rec."Vehicle Out")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Gate Entry")
            {
                Caption = '&Gate Entry';

                action(Card)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Posted Inward Gate Entry";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}

