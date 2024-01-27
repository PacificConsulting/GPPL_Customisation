page 50048 "Gate Otward - Sales/TransferOu"
{
    Editable = false;
    PageType = List;
    SourceTable = "Posted Gate Entry Header";
    SourceTableView = WHERE("Entry Type" = CONST(Outward),
                            "Vehicle Out" = CONST(false));
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
                    applicationarea = all;

                }
                field("Posting Date"; rec."Posting Date")
                {
                    applicationarea = all;
                }
                field("Posting Time"; rec."Posting Time")
                {
                    applicationarea = all;
                }
                field("No."; rec."No.")
                {
                    applicationarea = all;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    applicationarea = all;
                }
                field("Gate Entry No."; rec."Gate Entry No.")
                {
                    applicationarea = all;
                }
                field("Driver's Name"; rec."Driver's Name")
                {
                    applicationarea = all;
                }
                field("Driver's Mobile No."; rec."Driver's Mobile No.")
                {
                    applicationarea = all;
                }
                field("Vehicle Out"; rec."Vehicle Out")
                {
                    applicationarea = all;
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
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Posted Outward Gate Entry";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CSOMaping.RESET;
        CSOMaping.SETRANGE(CSOMaping."User Id", USERID);
        CSOMaping.SETRANGE(CSOMaping.Type, CSOMaping.Type::Location);
        IF CSOMaping.FINDFIRST THEN BEGIN
            rec.SETRANGE("Location Code", CSOMaping.Value);
            rec.SETCURRENTKEY("Posting Date");
            rec.ASCENDING(TRUE);
        END;
    end;

    var
        CSOMaping: Record 50006;
}

