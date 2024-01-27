page 50074 "Cancelled Invoices"
{
    Caption = 'Sales List';
    //CardPageID = "Cancelled Invoice";
    DataCaptionFields = "Document Type";
    Editable = false;
    PageType = List;
    SourceTable = 36;
    SourceTableView = WHERE("Document Type" = FILTER("Return Order"),
                            "Cancelled Invoice" = FILTER(true),
                            "Short Close" = CONST(false));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = all;
                }
                field("Supplimentary Invoice"; Rec."Supplimentary Invoice")
                {
                    ApplicationArea = all;
                }
                field("Cancelled Invoice"; Rec."Cancelled Invoice")
                {
                    ApplicationArea = all;
                }
                field("Short Close"; Rec."Short Close")
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                // field("Authorization Required"; Rec."Authorization Required")
                // {
                //     ApplicationArea = all;
                // }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; Rec."Currency Code")
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
                    ApplicationArea = all;
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
                ApplicationArea = all;
                Caption = 'Sales Reservation Avail.';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 209;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage()
    begin
        /*
        CSOMapping2.RESET;
        CSOMapping2.SETRANGE(CSOMapping2."User Id",UPPERCASE(USERID));
        IF CSOMapping2.FINDFIRST THEN
          BEGIN
          //FILTERGROUP(2);
          CSO.RESET;
          CSO.SETRANGE(CSO."Document Type","Document Type");
          CSO.SETFILTER(CSO."Short Close",'%1',FALSE);
          IF CSO.FINDSET THEN
          REPEAT
            CSOMapping.RESET;
            CSOMapping.SETRANGE(CSOMapping."User Id",UPPERCASE(USERID));
            CSOMapping.SETRANGE(CSOMapping.Type,CSOMapping.Type::"Responsibility Center");
            CSOMapping.SETRANGE(CSOMapping.Value,CSO."Responsibility Center");
            IF CSOMapping.FINDFIRST THEN
               CSO.MARK := TRUE
            ELSE
            BEGIN
              CSOMapping1.RESET;
              CSOMapping1.SETRANGE("User Id",UPPERCASE(USERID));
              CSOMapping1.SETRANGE(Type,CSOMapping.Type::Location);
              CSOMapping1.SETRANGE(Value,CSO."Location Code");
              IF CSOMapping1.FINDFIRST THEN
                 CSO.MARK := TRUE
             END;
          UNTIL CSO.NEXT = 0;
          CSO.MARKEDONLY(TRUE);
          COPY(CSO);
          FILTERGROUP(0);
        END
        ELSE
        BEGIN
          IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center",UserMgt.GetSalesFilter());
            FILTERGROUP(0);
          END;
        END;
        
        FILTERGROUP(2);
        SETRANGE("Short Close",FALSE);
        FILTERGROUP(0);
        */
        //2
        /*
        CSOMapping2.RESET;
        CSOMapping2.SETRANGE(CSOMapping2."User Id",UPPERCASE(USERID));
        IF CSOMapping2.FINDFIRST THEN
          BEGIN
          //FILTERGROUP(2);
          CI.RESET;
          CI.SETRANGE(CI."Document Type","Document Type");
          CI.SETFILTER(CI."Short Close",'%1',FALSE);
          IF CI.FINDSET THEN
          REPEAT
            CSOMapping.RESET;
            CSOMapping.SETRANGE(CSOMapping."User Id",UPPERCASE(USERID));
            CSOMapping.SETRANGE(CSOMapping.Type,CSOMapping.Type::"Responsibility Center");
            CSOMapping.SETRANGE(CSOMapping.Value,CI."Responsibility Center");
            IF CSOMapping.FINDFIRST THEN
               CI.MARK := TRUE
            ELSE
            BEGIN
              CSOMapping1.RESET;
              CSOMapping1.SETRANGE("User Id",UPPERCASE(USERID));
              CSOMapping1.SETRANGE(Type,CSOMapping.Type::Location);
              CSOMapping1.SETRANGE(Value,CI."Location Code");
              IF CSOMapping1.FINDFIRST THEN
                 CI.MARK := TRUE
             END;
          UNTIL CI.NEXT = 0;
          CI.MARKEDONLY(TRUE);
          COPY(CI);
          //FILTERGROUP(0);
        END
        
        ELSE
        BEGIN
          IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center",UserMgt.GetSalesFilter());
            FILTERGROUP(0);
          END;
        END;
        
        SETRANGE("Cancelled Invoice",TRUE);
        */
        vUserid := USERID;
        CSOMapping1.RESET;
        CSOMapping1.SETRANGE("User Id", UPPERCASE(vUserid));
        CSOMapping1.SETRANGE(Type, CSOMapping1.Type::Location);//***
        //CSOMapping1.SETFILTER(Value,'%1',"Location Code");
        IF CSOMapping1.FINDSET THEN
            REPEAT
                vloc += '|' + CSOMapping1.Value;
            UNTIL CSOMapping1.NEXT = 0;
        vloc := COPYSTR(vloc, 2, STRLEN(vloc));
        //FILTERGROUP(2);
        Rec.SETFILTER("Location Code", vloc);

    end;

    var
        CSOMapping: Record 50006;
        CSOMapping1: Record 50006;
        CSOMapping2: Record 50006;
        CSO: Record 36;
        UserMgt: Codeunit 5700;
        "--": Integer;
        CI: Record 36;
        vUserid: Text;
        vloc: Text;
}

