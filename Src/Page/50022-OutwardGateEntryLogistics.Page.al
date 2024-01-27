page 50022 "Outward Gate Entry-Logistics"
{
    // //06Apr2017 RB-N
    // Date        Version      Remarks
    // .....................................................................................
    // 19Dec2017   RB-N         New Field (Check Post)

    Caption = 'Outward Gate Entry-Logistics';
    PageType = Document;
    SourceTable = "Gate Entry Header";
    SourceTableView = SORTING("Entry Type", "No.")
                      ORDER(Ascending)
                      WHERE("Entry Type" = CONST(Outward),
                            Status = CONST(Released),
                            "Short Closed" = FILTER(false),
                            Rejected = CONST(false));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Enabled = false;

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                        /*
                            GateEntryLocSetup.GET("Entry Type","Location Code");
                          GateEntryLocSetup.TESTFIELD("Posting No. Series");
                          IF NoSeriesMgt.SelectSeries(GateEntryLocSetup."Posting No. Series","No.","No. Series") THEN
                             NoSeriesMgt.SetSeries("No.");
                        */

                    end;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Station From/To"; rec."Station From/To")
                {
                    ApplicationArea = all;
                    Caption = 'Station To';
                    Editable = false;
                }
                field(Location; rec.Location)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Customer Code"; rec."Customer Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item Description"; rec."Item Description")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Check Post"; rec."Check Post")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Remarks 1"; rec."Remarks 1")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Document Time"; rec."Document Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Posting Time"; rec."Posting Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Releasing Date"; rec."Releasing Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Releasing Time"; rec."Releasing Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vehicle Taken Time"; rec."Vehicle Taken Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vehicle Taken Date"; rec."Vehicle Taken Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Short Closed"; rec."Short Closed")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Remarks 2"; rec."Remarks 2")
                {
                    ApplicationArea = all;
                }
                field(Rejected; rec.Rejected)
                {
                    ApplicationArea = all;
                    Caption = 'Vehicle Rejected';
                    Editable = false;
                }
            }
            part(part1; "Outward Gate Entry SubForm")
            {
                SubPageLink = "Entry Type" = FIELD("Entry Type"),
                              "Gate Entry No." = FIELD("No.");
                SubPageView = SORTING("Entry Type", "Gate Entry No.", "Line No.");
            }
            group("Vehicle Details")
            {
                Caption = 'Vehicle Details';
                Editable = false;
                field(Transporter; rec.Transporter)
                {
                    ApplicationArea = all;
                }
                field(VehicleNo1; rec."Vehicle No.")
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Vehicle Capacity"; rec."Vehicle Capacity")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Capacity New"; rec."Vehicle Capacity New")
                {
                    ApplicationArea = all;
                }
                field("Vehicle For Location"; rec."Vehicle For Location")
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
                field("Vehicle Insurance Date"; rec."Vehicle Insurance Date")
                {
                    ApplicationArea = all;
                }
                field("PUC Date"; rec."PUC Date")
                {
                    ApplicationArea = all;
                }
                field("Transporter Name"; rec."Transporter Name")
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Vehicle Body Height/Length"; rec."Vehicle Body Height/Length")
                {
                    ApplicationArea = all;
                }
                field("Driver's Name"; rec."Driver's Name")
                {
                    ApplicationArea = all;
                }
                field("Driver's License No."; rec."Driver's License No.")
                {
                    ApplicationArea = all;
                }
                field("Driver's Mobile No."; rec."Driver's Mobile No.")
                {
                    ApplicationArea = all;
                }
                field("Gross Weight"; rec."Gross Weight")
                {
                    ApplicationArea = all;
                }
                field("Tare Weight"; rec."Tare Weight")
                {
                    ApplicationArea = all;
                }
                field("Net Weight"; rec."Net Weight")
                {
                    ApplicationArea = all;
                }
            }
            group("Vehicle Type")
            {
                Caption = 'Vehicle Type';
                Editable = false;

                field("Type of Vehicle"; rec."Type of Vehicle")
                {
                }
                field(Category1; rec."Category of Tanker 1")
                {
                }
                field(Category2; rec."Category of Tanker 2")
                {
                }
                field(Category3; rec."Category of Tanker 3")
                {
                }
                field(Category4; rec."Category of Tanker 4")
                {
                }
                field(TypeofTruck; rec."Type of Truck")
                {
                    Caption = 'Type of Truck';
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
                action(List)
                {
                    Caption = 'List';
                    RunObject = Page "Gate Entry List";
                    RunPageLink = "Entry Type" = CONST(Outward);
                    ShortCutKey = 'Shift+Ctrl+L';
                }
                action("Order Entry Details")
                {
                    Caption = 'Order Entry Details';

                    trigger OnAction()
                    begin
                        GateENtry.RESET;
                        GateENtry.SETRANGE(GateENtry."Entry Type", rec."Entry Type");
                        GateENtry.SETRANGE(GateENtry."No.", rec."No.");
                        REPORT.RUN(50043, TRUE, FALSE, GateENtry);
                    end;
                }
                action("Loaded Vehicle Unposted")
                {
                    Caption = 'Loaded Vehicle Unposted';

                    trigger OnAction()
                    begin
                        GateEntryHead.RESET;
                        GateEntryHead.SETRANGE(GateEntryHead."Entry Type", rec."Entry Type");
                        GateEntryHead.SETRANGE(GateEntryHead."No.", rec."No.");
                        REPORT.RUN(50056, TRUE, FALSE, GateEntryHead);
                    end;
                }
            }
        }
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Po&st")
                {
                    ApplicationArea = all;
                    Caption = 'Po&st';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Gate Entry- Post (Yes/No)";
                    ShortCutKey = 'F9';
                }
            }
        }
        area(reporting)
        {
            action("&Print")
            {
                ApplicationArea = all;
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    GateENtry.RESET;
                    GateENtry := Rec;
                    GateENtry.SETRECFILTER;
                    REPORT.RUN(50149, TRUE, FALSE, GateENtry);
                end;
            }
            action(Reject)
            {
                ApplicationArea = all;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //DJ 29319
                    rec.Rejected := TRUE;
                    //MODIFY;
                    //DJ 29319
                end;
            }
            action("Vehicle Packing List")
            {
                ApplicationArea = all;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    GateEntryHead.RESET;
                    GateEntryHead.SETRANGE(GateEntryHead."Entry Type", rec."Entry Type");
                    GateEntryHead.SETRANGE(GateEntryHead."No.", rec."No.");
                    REPORT.RUN(50249, TRUE, FALSE, GateEntryHead);
                end;
            }
        }
    }

    var
        //GateEntryLocSetup: Record 16554;
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        GateENtry: Record "Gate Entry Header";
        GateEntryHead: Record "Gate Entry Header";
        Text19040280: Label 'Categories of Tanker';
}

