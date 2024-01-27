page 50073 "Supplementory Invoices"
{
    Caption = 'Sales List';
    CardPageID = "Sales Invoice";
    DataCaptionFields = "Document Type";
    Editable = false;
    PageType = List;
    SourceTable = 36;
    SourceTableView = WHERE("Document Type" = FILTER(Invoice),
                            "Short Close" = CONST(false));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                {
                    ApplicationArea = all;
                }
                field("Supplimentary Invoice"; rec."Supplimentary Invoice")
                {
                    ApplicationArea = all;
                }
                field("Cancelled Invoice"; rec."Cancelled Invoice")
                {
                    ApplicationArea = all;
                }
                field("Short Close"; rec."Short Close")
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                // field("Authorization Required"; rec."Authorization Required")
                // {
                //     ApplicationArea = all;
                // }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Post Code"; rec."Sell-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sell-to Contact"; rec."Sell-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Customer No."; rec."Bill-to Customer No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Name"; rec."Bill-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Post Code"; rec."Bill-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Contact"; rec."Bill-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Code"; rec."Ship-to Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Name"; rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Post Code"; rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Contact"; rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Salesperson Code"; rec."Salesperson Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Assigned User ID"; rec."Assigned User ID")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    var
                        PageManagement: Codeunit 700;
                    begin
                        PageManagement.PageRun(Rec);
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Sales Reservation Avail.")
            {
                Caption = 'Sales Reservation Avail.';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 209;
            }
        }
    }

    trigger OnOpenPage()
    begin
        CSOMapping2.RESET;
        CSOMapping2.SETRANGE(CSOMapping2."User Id", UPPERCASE(USERID));
        IF CSOMapping2.FINDFIRST THEN BEGIN
            rec.FILTERGROUP(2);
            CSO.RESET;
            CSO.SETRANGE(CSO."Document Type", rec."Document Type");
            CSO.SETFILTER(CSO."Short Close", '%1', FALSE);
            IF CSO.FINDSET THEN
                REPEAT
                    CSOMapping.RESET;
                    CSOMapping.SETRANGE(CSOMapping."User Id", UPPERCASE(USERID));
                    CSOMapping.SETRANGE(CSOMapping.Type, CSOMapping.Type::"Responsibility Center");
                    CSOMapping.SETRANGE(CSOMapping.Value, CSO."Responsibility Center");
                    IF CSOMapping.FINDFIRST THEN
                        CSO.MARK := TRUE
                    ELSE BEGIN
                        CSOMapping1.RESET;
                        CSOMapping1.SETRANGE("User Id", UPPERCASE(USERID));
                        CSOMapping1.SETRANGE(Type, CSOMapping.Type::Location);
                        CSOMapping1.SETRANGE(Value, CSO."Location Code");
                        IF CSOMapping1.FINDFIRST THEN
                            CSO.MARK := TRUE
                    END;
                UNTIL CSO.NEXT = 0;
            CSO.MARKEDONLY(TRUE);
            Rec.COPY(CSO);
            rec.FILTERGROUP(0);
        END
        ELSE BEGIN
            IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
                rec.FILTERGROUP(2);
                rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
                rec.FILTERGROUP(0);
            END;
        END;

        rec.FILTERGROUP(2);
        rec.SETRANGE("Short Close", FALSE);
        rec.FILTERGROUP(0);
    end;

    var
        CSOMapping: Record 50006;
        CSOMapping1: Record 50006;
        CSOMapping2: Record 50006;
        CSO: Record 36;
        UserMgt: Codeunit 5700;
}

