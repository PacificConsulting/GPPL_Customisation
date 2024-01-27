page 50075 "Transport Invoices"
{
    Caption = 'Purchase List';
    DataCaptionFields = "Document Type";
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = 38;
    SourceTableView = WHERE("Document Type" = FILTER(Invoice));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Blanket Order No."; rec."Blanket Order No.")
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Order Creation Date"; rec."Order Creation Date")
                {
                    ApplicationArea = all;
                }
                field("Vendor Shipment No."; rec."Vendor Shipment No.")
                {
                    ApplicationArea = all;
                }
                field("Order Date"; rec."Order Date")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor No."; rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Order Address Code"; rec."Order Address Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor Name"; rec."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Vendor Authorization No."; rec."Vendor Authorization No.")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Post Code"; rec."Buy-from Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; rec."Buy-from Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Buy-from Contact"; rec."Buy-from Contact")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Vendor No."; rec."Pay-to Vendor No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Name"; rec."Pay-to Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Pay-to Post Code"; rec."Pay-to Post Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; rec."Pay-to Country/Region Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pay-to Contact"; rec."Pay-to Contact")
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
                field("Purchaser Code"; rec."Purchaser Code")
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
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    var
                        PageManagement: Codeunit 700;
                    begin
                        IF (rec.Subcontracting) AND (rec."Document Type" = rec."Document Type"::Order) THEN
                            PAGE.RUN(PAGE::"Subcontracting Order", Rec)
                        ELSE
                            PageManagement.PageRun(Rec);
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Purchase Reservation Avail.")
            {
                Caption = 'Purchase Reservation Avail.';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 409;
            }
            action("Purchase Order - &Regular")
            {
                Image = Print;

                trigger OnAction()
                begin

                    IF rec."Payment Terms Code" = '' THEN
                        ERROR('Payment Terms Code is Blank');

                    //EBT STIVAN ---(1307012)-----------------------------------------------------START
                    IF rec."Order Address Code" <> '' THEN BEGIN
                        PurchLine.RESET;
                        PurchLine.SETRANGE(PurchLine."Document No.", rec."No.");
                        IF PurchLine.FINDSET THEN
                            IF (PurchLine."Tax Amount" <> 0) THEN BEGIN
                                IF rec."Vendor TIN No." = '' THEN BEGIN
                                    OrderAddress.GET(rec."Buy-from Vendor No.", rec."Order Address Code");
                                    IF (OrderAddress."L.S.T. No." = '') THEN
                                        ERROR('TIN No. is Blank');
                                    //MESSAGE('TIN No. is Blank');
                                END;
                            END;
                    END;

                    IF rec."Order Address Code" = '' THEN BEGIN
                        PurchLine.RESET;
                        PurchLine.SETRANGE(PurchLine."Document No.", rec."No.");
                        IF PurchLine.FINDSET THEN
                            IF (PurchLine."Tax Amount" <> 0) THEN BEGIN
                                IF rec."Vendor TIN No." = '' THEN BEGIN
                                    Vendor.GET(rec."Buy-from Vendor No.");
                                    IF (Vendor."L.S.T. No." = '') THEN
                                        ERROR('TIN No. is Blank');
                                    //MESSAGE('TIN No. is Blank');
                                END;
                            END;
                    END;
                    //EBT STIVAN ---(13072012)-------------------------------------------------------END

                    DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action("Purchase Order - &Import")
            {
                ApplicationArea = all;
                Image = Print;
                Visible = false;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUNMODAL(50054, TRUE, FALSE, Rec)
                end;
            }
            action("Purchase Order - R&egular Detailed")
            {
                ApplicationArea = all;
                Image = Print;

                trigger OnAction()
                begin
                    RecPurchheader.RESET;
                    RecPurchheader := Rec;
                    RecPurchheader.SETRECFILTER;
                    REPORT.RUNMODAL(50087, TRUE, FALSE, RecPurchheader);
                end;
            }
            action("Purchase Order - &Import1")
            {
                ApplicationArea = all;
                Image = Print;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUNMODAL(50054, TRUE, FALSE, Rec)
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    var
        "--05Apr2017": Integer;
        PurchLine: Record 39;
        OrderAddress: Record 224;
        Vendor: Record 23;
        DocPrint: Codeunit 229;
        RecPurchheader: Record 38;
}

