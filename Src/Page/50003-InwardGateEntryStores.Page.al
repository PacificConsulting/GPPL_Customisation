page 50003 "Inward Gate Entry - Stores"
{
    Caption = 'Inward Gate Entry -Logistics';
    PageType = Document;
    SourceTable = 18603;
    SourceTableView = SORTING("Entry Type", "No.")
                      ORDER(Ascending)
                      WHERE("Entry Type" = CONST(Inward),
                            Status = FILTER(Released),
                            "Short Closed" = FILTER(false));
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = all;

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
                }
                field("Vendor Code"; rec."Vendor Code")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    Caption = 'Party/ Location Name';
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Item Code"; rec."Item Code")
                {
                    ApplicationArea = all;
                }
                field("Station From/To"; rec."Station From/To")
                {
                    Caption = 'Station From / To';
                    ApplicationArea = all;
                }
                field("Item Description"; rec."Item Description")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field(Location; rec.Location)
                {
                    Caption = 'From Location';
                    ApplicationArea = all;
                }
                field("Vendor Invoice/Document No."; rec."Vendor Invoice/Document No.")
                {
                    Caption = 'Vendor Inv./Doc. No.';
                    ApplicationArea = all;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Document Time"; rec."Document Time")
                {
                    ApplicationArea = all;
                }
                field("Releasing Date"; rec."Releasing Date")
                {
                    ApplicationArea = all;
                }
                field("Releasing Time"; rec."Releasing Time")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Taken Date"; rec."Vehicle Taken Date")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Taken Time"; rec."Vehicle Taken Time")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Short Closed"; rec."Short Closed")
                {
                    ApplicationArea = all;
                }
            }
            part("Inward Gate Entry SubForm"; 18607)
            {
                SubPageLink = "Entry Type" = FIELD("Entry Type"),
                              "Gate Entry No." = FIELD("No.");
            }
            group("Vehicle Details")
            {
                Caption = 'Vehicle Details';
                Editable = false;
                field(Transporter; rec.Transporter)
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
                field(PUC; rec.PUC)
                {
                    ApplicationArea = all;
                }
                field("Transporter Name"; rec."Transporter Name")
                {
                    Style = StrongAccent;
                    StyleExpr = TRUE;
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
                field("Vehicle For Location"; rec."Vehicle For Location")
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
            }
            group("Weighment Details")
            {
                Caption = 'Weighment Details';
                Editable = false;
                label(new1)
                {
                    ApplicationArea = all;
                    CaptionClass = Text19010349;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Vendor Location Gross Weight"; rec."Vendor Location Gross Weight")
                {
                    ApplicationArea = all;
                }
                field("Vendor Location Tare Weight"; rec."Vendor Location Tare Weight")
                {
                    ApplicationArea = all;
                }
                field("Vendor Location Net Weight"; rec."Vendor Location Net Weight")
                {
                    ApplicationArea = all;
                }
                field("Inhouse Gross Weight"; rec."Inhouse Gross Weight")
                {
                    ApplicationArea = all;
                }
                field("Inhouse Tare Weight"; rec."Inhouse Tare Weight")
                {
                    ApplicationArea = all;
                }
                field("Inhouse Net Weight"; rec."Inhouse Net Weight")
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
                action("Unloaded Vehicle Unposted")
                {
                    Caption = 'Unloaded Vehicle Unposted';
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        GateEntryHead.RESET;
                        GateEntryHead.SETRANGE(GateEntryHead."Entry Type", rec."Entry Type");
                        GateEntryHead.SETRANGE(GateEntryHead."No.", rec."No.");
                        //REPORT.RUN(50056,TRUE,FALSE,GateEntryHead);
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
                    Caption = 'Po&st';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //RunObject = Codeunit 16506;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                }
            }
        }
    }

    var
        //GateEntryLocSetup: Record 16554;
        // NoSeriesMgt: Codeunit 396; //PCPL-64 11dec2023
        GateEntryHead: Record "Gate Entry Header";
        Text19010349: Label 'Vendor / Location Weighment';
}

