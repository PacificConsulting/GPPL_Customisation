// MY PC 10 01 2024
pageextension 50077 "PostedTransferShipmentsExt" extends "Posted Transfer Shipments"
{
    layout
    {
        addafter("Receipt Date")
        {
            field("WH Bill Entry No."; rec."WH Bill Entry No.")
            {
                ApplicationArea = all;
            }
            field("Debond Bill Entry No."; rec."Debond Bill Entry No.")
            {
                ApplicationArea = all;
            }

            field("BRT Cancelled"; rec."BRT Cancelled")
            {
                ApplicationArea = all;
            }
            field("Print BRT"; rec."Print BRT")
            {
                ApplicationArea = all;
            }
            field("BRT Print Time"; rec."BRT Print Time")
            {
                ApplicationArea = all;
            }

        }
    }

    actions
    {
        // Add changes to page actions here

        addafter("&Navigate")
        {
            action("Transfer Invoice GSTCopy")
            {
                ApplicationArea = all;

                trigger OnAction()
                var
                    RecTSL: Record "Transfer Shipment Line";
                    TSH: Record "Transfer Shipment Header";
                begin

                    //CAS-22565-T8N8W6 13Aug2018
                    IF rec."Road Permit No." = '' THEN
                        ERROR('E-Way Bill No. cannot be blank');
                    //

                    TSH.RESET;
                    TSH.SETRANGE("No.", rec."No.");
                    IF TSH.FINDFIRST THEN
                        REPORT.RUNMODAL(50154, TRUE, FALSE, TSH);
                end;

            }
        }
    }


    /// MY PC 10 01 2024
    trigger OnAfterGetRecord()

    var
        myInt: Integer;
        BRTStatus: Text[30];
        BRTCancelledRemarEditable: Boolean;

    begin

        IF rec."BRT Cancelled" = TRUE THEN BEGIN
            BRTStatus := 'CANCELLED';
            //CurrForm."BRT Cancelled Remarks".EDITABLE := TRUE;
            BRTCancelledRemarEditable := TRUE
        END
        ELSE BEGIN
            BRTStatus := '';
            //CurrForm."BRT Cancelled Remarks".EDITABLE := FALSE;
            BRTCancelledRemarEditable := FALSE;
        END;
    END;




    var
        myInt: Integer;



}