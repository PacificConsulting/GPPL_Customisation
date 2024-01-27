page 50015 "E-WAY BILL PAGE"
{
    ApplicationArea = all;
    UsageCategory = Lists;
    // {
    // CLEARALL;
    // CurrPage.SETSELECTIONFILTER(Rec);
    // Rec .INIT;
    // IF Rec  .FINDSET THEN REPEAT
    // 
    //    SalesLine.RESET;
    //    SalesLine.SETRANGE("Document No.",Rec."No.");
    //    SalesLine.SETRANGE("Document Type",Rec."Document Type"::Order);
    //    IF SalesLine.FINDSET THEN BEGIN
    //      REPEAT
    //       QTY := SalesLine.Quantity;
    //       QTYShipped := SalesLine."Quantity Shipped";
    //       IF QTY <> QTYShipped THEN BEGIN
    //           DocNo += '|'  + Rec."No."; //YSR_MRM
    //           DocNo :=  COPYSTR(DocNo , 2 ,STRLEN(DocNo));//YSR_MRM
    //           SH.GET(SalesLine."Document Type",SalesLine."Document No.");
    //           SH.MARK := TRUE;
    //       END;
    //        UNTIL SalesLine.NEXT =0;
    //   END;
    // UNTIL Rec.NEXT=0;
    // IF DocNo <> '' THEN BEGIN
    //   Jscode := cuOrderDetails.SendXMLSOAPRequestMultiple(DocNo);//YSR_MRM
    //    //Rec.SETRANGE("No.",DocNo);
    //    //IF Rec.FINDSET THEN
    //     //  REPEAT
    //       //  "MRM Order No." :=Jscode;
    //         //MODIFY;
    //      // UNTIL Rec.NEXT = 0;
    // SH.MARKEDONLY(TRUE);
    // IF SH.FINDSET THEN
    //   REPEAT
    //     SH."MRM Order No." :=Jscode;
    //     SH.MODIFY;
    //     UNTIL SH.NEXT =0;
    // 
    // // SalesHeader2.RESET;
    // // SalesHeader2.SETFILTER("No.",DocNo);
    // // SalesHeader2.SETFILTER("Document Type",'%1',Rec."Document Type"::Order);
    // // IF SalesHeader2.FINDSET THEN
    // //    REPEAT
    // //    SalesHeader2."MRM Order No." :=Jscode;
    // //    SalesHeader2.MODIFY;
    // // UNTIL SalesHeader2.NEXT = 0;
    // 
    // END ELSE
    //   EXIT;
    // 
    // 
    // 
    // }

    DeleteAllowed = false;
    PageType = List;
    SourceTable = 50044;

    layout
    {
        area(content)
        {
            repeater(Group1)
            {
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("EWB No."; rec."EWB No.")
                {
                    ApplicationArea = all;
                }
                field("EWB Valid Upto"; rec."EWB Valid Upto")
                {
                    ApplicationArea = all;
                }
                field("EWB Updated Date"; rec."EWB Updated Date")
                {
                    ApplicationArea = all;
                }
                field("Cons. EWB No."; rec."Cons. EWB No.")
                {
                    ApplicationArea = all;
                }
                field("Cons. EWB Updated Date"; rec."Cons. EWB Updated Date")
                {
                    ApplicationArea = all;
                }
                field("Cons. EWB Valid Upto"; rec."Cons. EWB Valid Upto")
                {
                    ApplicationArea = all;
                }
                field(Cancelled; rec.Cancelled)
                {
                    ApplicationArea = all;
                }
                field("Cancel Date"; rec."Cancel Date")
                {
                    ApplicationArea = all;
                }
                field("EWB Creation date"; rec."EWB Creation date")
                {
                    ApplicationArea = all;
                }
                field("Created By User"; rec."Created By User")
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("VH Valid Upto"; rec."VH Valid Upto")
                {
                    ApplicationArea = all;
                }
                field("VH Updated Date"; rec."VH Updated Date")
                {
                    ApplicationArea = all;
                }
                field("GST Ledg. Entry No."; rec."GST Ledg. Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Trans. Doc. No."; rec."Trans. Doc. No.")
                {
                    ApplicationArea = all;
                }
                field("Trans. Doc. Date"; rec."Trans. Doc. Date")
                {
                    ApplicationArea = all;
                }
                field("Transporter Code"; rec."Transporter Code")
                {
                    ApplicationArea = all;
                }
                field("Transporter Name"; rec."Transporter Name")
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
            group(ReportName)
            {
                Caption = 'Reports';
                action("E-WAY BILL REPORT C")
                {
                    Image = "Report";
                    Visible = ShowReport;

                    trigger OnAction()
                    var
                        //ReportEwayBillC: Report 50235;
                        RecSIH: Record 112;
                    begin
                        /*
                        RecSIH.RESET;
                        RecSIH.SETRANGE("No.", "Document No.");
                        IF RecSIH.FINDFIRST THEN BEGIN
                            CLEAR(ReportEwayBillC);
                            ReportEwayBillC.SetParams("EWB No.", Cancelled);
                            ReportEwayBillC.SETTABLEVIEW(RecSIH);
                            ReportEwayBillC.USEREQUESTPAGE(TRUE);
                            ReportEwayBillC.RUNMODAL;
                        END ELSE
                            ERROR('Invalid Document to run the report');
                            */
                    end;
                }
                action("E-WAY BILL REPORT TRANSFER C")
                {
                    Image = "Report";
                    Visible = ShowReport;

                    trigger OnAction()
                    var
                        //ReportEwayBillTransferC: Report 50236;
                        RecTSH: Record 5744;
                    begin
                        /*
                        RecTSH.RESET;
                        RecTSH.SETRANGE("No.", "Document No.");
                        IF RecTSH.FINDFIRST THEN BEGIN
                            CLEAR(ReportEwayBillTransferC);
                            ReportEwayBillTransferC.SetParams("EWB No.", Cancelled);
                            ReportEwayBillTransferC.SETTABLEVIEW(RecTSH);
                            ReportEwayBillTransferC.USEREQUESTPAGE(TRUE);
                            ReportEwayBillTransferC.RUNMODAL;
                        END ELSE
                            ERROR('Invalid Document to run the report');
                            */
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF USERID = 'ROBOSOFT.SUPPORT1' THEN
            ShowReport := TRUE
        ELSE
            ShowReport := FALSE;
    end;

    var
        //cuEwayBill: Codeunit 50012;
        DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
        GSTRegNo: Code[20];
        GeneralLedgerSetup: Record 98;
        AccessKey: Label 'sadacvasdfcdsa';
        fromPlace: Text;
        fromState: Text;
        vehicleNo: Text;
        transMode: Text;
        TransDocNo: Text;
        TransDocDate: Text;
        tripSheetEwbBills: Text;
        Detailed_Eway_Bill: Record 50044;
        DocNo: Text[1000];
        DetailedEwayBill2: Record 50044;
        ShowReport: Boolean;

    // [Scope('Internal')]
    procedure GetCurrentlySelectedLines(var DetailedEwayBill: Record 50044): Boolean
    var
        i: Integer;
    begin
        i := 0;
        CurrPage.SETSELECTIONFILTER(DetailedEwayBill);
        IF DetailedEwayBill.FINDSET THEN BEGIN
            REPEAT
                i += 1;
                IF i = 1 THEN
                    DocNo := DetailedEwayBill."Document No."
                ELSE
                    DocNo := DocNo + '|' + DetailedEwayBill."Document No.";
            UNTIL DetailedEwayBill.NEXT = 0;
        END;
        EXIT(DetailedEwayBill.FINDSET);
    end;

    // [Scope('Internal')]
    procedure UpdateConsolidateEwayBillOfCurrentlySelectedLines(var RecDetailedEwayBill: Record 50044)
    begin
    end;
}

