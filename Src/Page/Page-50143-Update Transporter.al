page 50143 "Update Transporter"
{
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(group1)
            {
                field("E-Way Bill No."; EwbNo)
                {
                    Editable = false;
                }
                field("Transporter ID"; Transporterid)
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF PAGE.RUNMODAL(428, ShipAgent) = ACTION::LookupOK THEN BEGIN
                            Transporterid := ShipAgent."GST Registration No.";
                            CurrPage.UPDATE;
                            //CLEAR(pgLoc);
                        END;
                    end;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(General)
            {
                Image = Worksheets;
                action("Send Request")
                {
                    Image = SendTo;
                    InFooterBar = true;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    RunPageMode = Edit;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        //cuEwayBill: Codeunit 50012;
                        DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
                        LocRec: Record 14;
                        GSTRegNo: Text;
                        transUpdateDate: Text;
                        AccessKey: Text;
                        DetailedEWayBill: Record 50044;
                        DetailEwayBill: Record 50044;
                        ShippingAgent: Record 291;
                        recTransportDetails: Record 50020;
                        recVendor: Record 23;
                        LRDate: Date;
                    begin

                        IF EwbNo = '' THEN
                            ERROR('Fill EwbNo');
                        IF Transporterid = '' THEN
                            ERROR('Fill Transporter ID');

                        DetailedGSTLedgerEntry1.RESET;
                        DetailedGSTLedgerEntry1.SETRANGE("Document No.", TransDocNo);
                        IF DetailedGSTLedgerEntry1.FINDFIRST THEN BEGIN
                            GSTRegNo := DetailedGSTLedgerEntry1."Location  Reg. No.";
                        END;
                        LocRec.GET(DetailedGSTLedgerEntry1."Location Code");

                        // cuEwayBill.UpdateTransporter(EwbNo, Transporterid, transUpdateDate, GSTRegNo, AccessKey
                        //                           , LocRec."EWB UserName", LocRec."EWB Password");

                        DetailEwayBill.RESET;
                        DetailEwayBill.SETRANGE("Document No.", TransDocNo);
                        DetailEwayBill.SETRANGE("EWB No.", EwbNo);
                        IF DetailEwayBill.FINDLAST THEN BEGIN
                            DetailedEWayBill.INIT;
                            DetailedEWayBill."Document No." := DetailEwayBill."Document No.";
                            DetailedEWayBill."EWB No." := DetailEwayBill."EWB No.";
                            DetailedEWayBill."EWB Valid Upto" := DetailEwayBill."EWB Valid Upto";
                            DetailedEWayBill."EWB Updated Date" := DetailEwayBill."EWB Updated Date";
                            DetailedEWayBill."EWB Creation date" := DetailEwayBill."EWB Creation date";
                            DetailedEWayBill."Created By User" := USERID;
                            DetailedEWayBill."GST Ledg. Entry No." := DetailEwayBill."GST Ledg. Entry No.";
                            DetailedEWayBill."Vehicle No." := DetailEwayBill."Vehicle No.";
                            DetailedEWayBill."VH Valid Upto" := DetailEwayBill."VH Valid Upto";
                            DetailedEWayBill."VH Updated Date" := DetailEwayBill."VH Updated Date";
                            DetailedEWayBill."Transporter Code" := Transporterid;
                            ShippingAgent.SETRANGE("GST Registration No.", Transporterid);
                            IF ShippingAgent.FINDFIRST THEN
                                DetailedEWayBill."Transporter Name" := ShippingAgent.Name;
                            DetailedEWayBill."Trans. Doc. No." := DetailEwayBill."Trans. Doc. No.";//RSPLSUM
                            DetailedEWayBill."Trans. Doc. Date" := DetailEwayBill."Trans. Doc. Date";//RSPLSUM
                            DetailedEWayBill."From Place" := DetailEwayBill."From Place";//RSPLSUM
                            DetailedEWayBill.INSERT;

                            //RSPLSUM07Apr21>>
                            recTransportDetails.RESET;
                            recTransportDetails.SETRANGE(recTransportDetails."Invoice No.", TransDocNo);
                            IF recTransportDetails.FINDFIRST THEN BEGIN
                                ShippingAgent.RESET;
                                ShippingAgent.SETRANGE("GST Registration No.", Transporterid);
                                IF ShippingAgent.FINDFIRST THEN BEGIN
                                    recTransportDetails."Shipping Agent Code" := ShippingAgent.Code;
                                    recTransportDetails."Shipping Agent Name" := ShippingAgent.Name;
                                    recVendor.RESET;
                                    recVendor.SETRANGE(recVendor."Shipping Agent", TRUE);
                                    recVendor.SETRANGE(recVendor."Shipping Agent Code", ShippingAgent.Code);
                                    IF recVendor.FINDFIRST THEN BEGIN
                                        recTransportDetails."Vendor Code" := recVendor."No.";
                                        recTransportDetails."Vendor Name" := recVendor."Full Name";
                                    END;
                                END;
                                recTransportDetails."LR No." := DetailEwayBill."Trans. Doc. No.";
                                CLEAR(LRDate);
                                EVALUATE(LRDate, DetailEwayBill."Trans. Doc. Date");
                                recTransportDetails."LR Date" := LRDate;
                                recTransportDetails."Vehicle No." := DetailEwayBill."Vehicle No.";

                                recTransportDetails.MODIFY;
                            END;
                            //RSPLSUM07Apr21<<

                        END;

                        CurrPage.CLOSE;
                    end;
                }
            }
        }
    }

    var
        EwbNo: Text;
        Transporterid: Text;
        TransDocNo: Text;
        ShipAgent: Record 291;

    // [Scope('Internal')]
    procedure SetData(prEwbNo: Text; DocNo: Text)
    begin
        EwbNo := prEwbNo;
        TransDocNo := DocNo;
    end;
}

