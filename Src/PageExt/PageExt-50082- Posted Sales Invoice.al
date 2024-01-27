// MY PC 11 01 2024
pageextension 50082 "PostedSalesInvoiceExt" extends "Posted Sales Invoice"
{
    layout
    {
        addafter("GST Invoice")
        {
            field("Full Name"; rec."Full Name")
            {
                ApplicationArea = all;
            }
            field("Customer Type"; rec."Customer Type")
            {
                ApplicationArea = all;
            }
            field("Cancelled Invoice"; rec."Cancelled Invoice")
            {
                ApplicationArea = all;
            }
            field("Supplimentary Invoice"; rec."Supplimentary Invoice")
            {
                ApplicationArea = all;
            }
            field("OverDue Balance"; rec."OverDue Balance")
            {
                ApplicationArea = all;
            }
            field("Commission Agent"; rec."Commission Agent")
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
            field("Local Driver's Mobile No."; rec."Local Driver's Mobile No.")
            {
                ApplicationArea = all;
            }
            field(Remarks; rec.Remarks)
            {
                ApplicationArea = all;
            }
            field(Remarks2; rec.Remarks2)
            {
                ApplicationArea = all;
            }
            field("CT3 Order"; rec."CT3 Order")
            {
                ApplicationArea = all;
            }
            field("CT3 No."; rec."CT3 No.")
            {
                ApplicationArea = all;
            }
            field("CT3 Date"; rec."CT3 Date")
            {
                ApplicationArea = all;
            }
            field("ARE3 No."; rec."ARE3 No.")
            {
                ApplicationArea = all;
            }
            field("ARE3 Date"; rec."ARE3 Date")
            {
                ApplicationArea = all;
            }
            field("CT1 Order"; rec."CT1 Order")
            {
                ApplicationArea = all;
            }
            field("CT1 No."; rec."CT1 No.")
            {
                ApplicationArea = all;
            }

            field("CT1 Date"; rec."CT1 Date")
            {
                ApplicationArea = all;
            }
            field("ARE1 No."; rec."ARE1 No.")
            {
                ApplicationArea = all;
            }
            field("ARE1 Date"; rec."ARE1 Date")
            {
                ApplicationArea = all;
            }
            field("Ex-Factory"; rec."Ex-Factory")
            {
                ApplicationArea = all;
            }
            field("Under Rebate"; rec."Under Rebate")
            {
                ApplicationArea = all;

            }
            field("Under LUT"; rec."Under LUT")
            {
                ApplicationArea = all;
            }
            field("Export Under LUT"; rec."Export Under LUT")
            {
                ApplicationArea = all;
            }
            field("C Form Status"; rec."C Form Status")
            {
                ApplicationArea = all;
            }
            field("C Form Amount"; rec."C Form Amount")
            {
                ApplicationArea = all;
            }
            field("C Form Date"; rec."C Form Date")
            {
                ApplicationArea = all;

            }
            field("C Form Recd.Date"; rec."C Form Recd.Date")
            {
                ApplicationArea = all;
            }
            field("Period From"; rec."Period From")
            {
                ApplicationArea = all;
            }
            field("Period To"; rec."Period To")
            {
                ApplicationArea = all;
            }

            field("DN/CN No."; rec."DN/CN No.")
            {
                ApplicationArea = all;
            }
            field("DN/CN Type"; rec."DN/CN Type")
            {
                ApplicationArea = all;
            }
            field("Diff. Reason"; rec."Diff. Reason")
            {
                ApplicationArea = all;
            }
            field("Diff.Amount"; rec."Diff.Amount")
            {
                ApplicationArea = all;
            }
            field("E.1-Form No."; rec."E.1-Form No.")
            {
                ApplicationArea = all;
            }
            field("Date of Issue"; rec."Date of Issue")
            {
                ApplicationArea = all;
            }

            field("Date of Receipt"; rec."Date of Receipt")
            {
                ApplicationArea = all;
            }
            field("Handover To"; rec."Handover To")
            {
                ApplicationArea = all;
            }
            field("Handover Date"; rec."Handover Date")
            {
                ApplicationArea = all;
            }
            field("Bank Account No."; rec."Bank Account No.")
            {
                ApplicationArea = all;
            }
            field("Loading Port Name"; rec."Loading Port Name")
            {
                ApplicationArea = all;
            }
            field("Debit Memo"; rec."Debit Memo")
            {
                ApplicationArea = all;
            }
            field("Dispatch Code"; rec."Dispatch Code")
            {
                ApplicationArea = all;
            }
            field("Distance in kms"; rec."Distance in kms")
            {
                ApplicationArea = all;

                //  trigger OnValidate()
                //  var
                //    GSTLedgerEntry: Record "GST Ledger Entry";
                //  RecGSTLE: Record 16418;
                // begin
                //RSPLSUM 05Jun2020
                //  GSTLedgerEntry.RESET;
                //  GSTLedgerEntry.SETRANGE("Document No.", rec."No.");
                //  IF GSTLedgerEntry.FINDFIRST THEN BEGIN
                //   IF GSTLedgerEntry."E-Way Bill No." = '' THEN BEGIN
                //  RecGSTLE.RESET;
                //   RecGSTLE.SETRANGE("Document No.", rec."No.");
                //  IF RecGSTLE.FINDSET THEN
                //    REPEAT
                //     RecGSTLE."Distance in kms" := rec."Distance in kms";
                //    RecGSTLE.MODIFY;
                //  UNTIL RecGSTLE.NEXT = 0;
                // END ELSE
                // ERROR('E-Way Bill already generated');
                //  END;
                //RSPLSUM 05Jun2020

            }
            // field("QR Code"; rec."QR Code")
            // {
            //     ApplicationArea = all;
            //  trigger OnValidate()
            //  begin


            // end;
            // }

            field("Local Expected TPT Cost"; rec."Local Expected TPT Cost")
            {
                ApplicationArea = all;
            }
            field("Expected TPT Cost"; rec."Expected TPT Cost")
            {
                ApplicationArea = all;
            }
            field("Road Permit No."; rec."Road Permit No.") /// Hello
            {
                ApplicationArea = all;
            }
            field("Print Invoice"; rec."Print Invoice")
            {
                ApplicationArea = all;
            }
            field("Freight Type"; rec."Freight Type")
            {
                ApplicationArea = all;
            }
            field("Cash Discount Percentage"; rec."Cash Discount Percentage")
            {
                ApplicationArea = all;
            }
            field("Customer Receipt Date"; rec."Customer Receipt Date")
            {
                ApplicationArea = all;
            }
            field("Salesperson Email Sent"; rec."Salesperson Email Sent")
            {
                ApplicationArea = all;
            }
            field("EWB Transaction Type"; rec."EWB Transaction Type")
            {
                ApplicationArea = all;
            }
            field("EWB No."; rec."EWB No.")
            {
                ApplicationArea = all;

            }
            field("EWB Date"; rec."EWB Date")
            {
                ApplicationArea = all;
            }
            field("Mintifi Channel Finance"; rec."Mintifi Channel Finance")
            {
                ApplicationArea = all;
            }
            field(IRN; rec.IRN)
            {
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
        addafter(ActionGroupCRM)
        {
            action(Done)

            {
                ApplicationArea = all;
                trigger OnAction()
                var

                begin
                    CLEAR(TaxInfoEdtiable);
                    RecSalesInvHeader.RESET;
                    RecSalesInvHeader.SETRANGE("No.", rec."No.");
                    IF RecSalesInvHeader.FINDFIRST THEN BEGIN
                        RecSalesInvHeader."C Form Status" := FALSE;
                        RecSalesInvHeader.MODIFY;
                    END;
                    TaxInfoEdtiable := TRUE;

                end;
            }
            action(Edit)
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                begin
                    CLEAR(TaxInfoEdtiable);
                    RecSalesInvHeader.RESET;
                    RecSalesInvHeader.SETRANGE("No.", rec."No.");
                    IF RecSalesInvHeader.FINDFIRST THEN BEGIN
                        RecSalesInvHeader."C Form Status" := TRUE;
                        RecSalesInvHeader.MODIFY;
                    END;


                    TaxInfoEdtiable := FALSE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var


    begin
        //EBT STIVAN ---(18062012)--- To Capture Posted Sales Shipment No. ---------START
        IF rec."Sales Shipment No" = '' THEN BEGIN
            SalesShipmentHeader.RESET;
            SalesShipmentHeader.SETRANGE(SalesShipmentHeader."Order No.", rec."Order No.");
            IF SalesShipmentHeader.FIND('-') THEN
                "PostedSalesShipmentNo." := SalesShipmentHeader."No."
            //ELSE
            // "PostedSalesShipmentNo." := '';
        END
        ELSE
            "PostedSalesShipmentNo." := '';
        //EBT STIVAN ---(18062012)--- To Capture Posted Sales Shipment No. -----------END


        //EBT STIVAN ---(03/08/2012)--- To show the Status of invoice if is Cancelled or Returned ------ START
        IF rec."Cancelled Invoice" = TRUE THEN BEGIN
            InvoiceStatus := 'CANCELLED';
        END ELSE BEGIN
            InvoiceStatus := '';
        END;
        //EBT STIVAN ---(03/08/2012)--- To show the Status of invoice if is Cancelled or Returned -------- END
    end;

    var
        myInt: Integer;
        RecSalesInvHeader: Record "Sales Invoice Header";
        TaxInfoEdtiable: Boolean;
        InvoiceStatus: Text[30];
        SalesShipmentHeader: Record "Sales Shipment Header";
        "PostedSalesShipmentNo.": code[20];
}
