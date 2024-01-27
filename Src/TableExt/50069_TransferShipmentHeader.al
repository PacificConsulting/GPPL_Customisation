tableextension 50069 TransferShipmentHeaderExtCstm extends "Transfer Shipment Header"
{
    fields
    {
        field(50000; "Frieght Type"; Option)
        {
            Description = 'EBT STIVAN 23/07/2013';
            OptionCaption = ' ,PAID,TO PAY,PAY & ADD IN BILL,SELF PICKUP';
            OptionMembers = " ",PAID,"TO PAY","PAY & ADD IN BILL","SELF PICKUP";
        }
        field(50001; "Driver's Name"; Text[30])
        {
            Description = 'EBT/Gate Entry/0001';
        }
        field(50002; "Driver's License No."; Code[20])
        {
            Description = 'EBT/Gate Entry/0001';
        }
        field(50003; "Driver's Mobile No."; Text[30])
        {
            Description = 'EBT/Gate Entry/0001';
        }
        field(50004; "Vehicle Capacity"; Text[30])
        {
            Description = 'EBT/Gate Entry/0001';
        }
        field(50005; "Vehicle For Location"; Text[30])
        {
            Description = 'EBT/Gate Entry/0001';
        }
        field(50008; "Transfer From User City"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = "Form Update sales Invoice";
        }
        field(50009; "Transfer From User State"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = State;
        }
        field(50010; "Transfer From User Zone"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = "Vehicle Capacity";
        }
        field(50011; "Transfer To User City"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = "Form Update sales Invoice";
        }
        field(50012; "Transfer To User State"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            // TableRelation = State;
        }
        field(50013; "Transfer To User Zone"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = "Vehicle Capacity";
        }
        field(50014; "Transport Type"; Option)
        {
            Description = 'EBT/LOCALINTERCITY/0001 - Pratyusha';
            OptionCaption = ' ,Intercity,Local+Intercity,Cust.Transport';
            OptionMembers = " ",Intercity,"Local+Intercity","Cust.Transport";
        }
        field(50021; "Local Driver's Name"; Text[50])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50022; "Local Driver's License No."; Code[20])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50023; "Local Driver's Mobile No."; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50024; "Local Vehicle Capacity"; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50025; "Local Vehicle for Location"; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50026; "Local Vehicle No."; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';

            trigger OnValidate()
            var
                recTransportDetails: Record 50020;
            begin
                //EBT STIVAN ---(10/06/2013)---Code to Update the Transport Details Table------------------------START
                recTransportDetails.RESET;
                recTransportDetails.SETRANGE(recTransportDetails."Invoice No.", "No.");
                IF recTransportDetails.FINDFIRST THEN BEGIN
                    //recTransportDetails."Vehicle No." := "Vehicle No.";
                    //recTransportDetails.MODIFY;
                END;
                //EBT STIVAN ---(10/06/2013)---Code to Update the Transport Details Table--------------------------END
            end;
        }
        field(50027; "Local LR No."; Code[20])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';

            trigger OnValidate()
            var
                recTransportDetails: Record 50020;
            begin
                //EBT STIVAN ---(10/06/2013)---Code to Update the Transport Details Table------------------------START
                recTransportDetails.RESET;
                recTransportDetails.SETRANGE(recTransportDetails."Invoice No.", "No.");
                IF recTransportDetails.FINDFIRST THEN BEGIN
                    //recTransportDetails."LR No." := "LR/RR No.";
                    //recTransportDetails.MODIFY;
                END;
                //EBT STIVAN ---(10/06/2013)---Code to Update the Transport Details Table--------------------------END
            end;
        }
        field(50028; "Local LR Date"; Date)
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';

            trigger OnValidate()
            var
                recTransportDetails: Record 50020;
            begin
                //EBT STIVAN ---(10/06/2013)---Code to Update the Transport Details Table------------------------START
                recTransportDetails.RESET;
                recTransportDetails.SETRANGE(recTransportDetails."Invoice No.", "No.");
                IF recTransportDetails.FINDFIRST THEN BEGIN
                    //recTransportDetails."LR Date" := "LR/RR Date";
                    //recTransportDetails.MODIFY;
                END;
                //EBT STIVAN ---(10/06/2013)---Code to Update the Transport Details Table--------------------------END
            end;
        }
        field(50030; "Empty Vehicle Weight"; Decimal)
        {
        }
        field(50031; "Vehicle Weight After loading"; Decimal)
        {
        }
        field(50032; "Net Weight of the Truck"; Decimal)
        {
        }
        field(50033; "WH Bill Entry No."; Code[20])
        {
        }
        field(50034; "Time In/Out"; Time)
        {
        }
        field(50035; "Debond Bill Entry No."; Code[20])
        {
        }
        field(50036; "Transfer Indent No."; Code[20])
        {
            Description = 'EBT STIVAN (29/05/2012)';
            Editable = false;
        }
        field(50037; "F Form Date"; Date)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50038; "F Form Amount"; Decimal)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50039; "F Form Issue Date"; Date)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50040; "F Form Rec. Date"; Date)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50041; "F Form Remarks"; Text[100])
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50042; "F Form Period"; Text[30])
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50043; "Diff. Amount If any"; Decimal)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50044; "F Form Status"; Boolean)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50045; "BRT Cancelled"; Boolean)
        {
            Description = 'EBT STIVAN (12/10/2012) - For Reporting Purpose';

            trigger OnValidate()
            var

                recTransportDetails: Record 50020;
            begin
                IF recTransportDetails.GET("No.") THEN BEGIN
                    recTransportDetails."Cancelled Invoice" := "BRT Cancelled";
                    recTransportDetails.MODIFY;
                END;
            end;
        }
        field(50046; "BRT Cancelled Remarks"; Text[50])
        {
            Description = 'EBT STIVAN (12/10/2012) - For Reporting Purpose';
        }
        field(50203; "Distance in kms"; Decimal)
        {
            Description = 'DJ_EWB';

            trigger OnValidate()
            begin
            end;
        }
        field(50204; IRN; Text[250])
        {
            //CalcFormula = Lookup("GST Ledger Entry"."E-Inv Irn" WHERE("Document No."=FIELD("No.")));
            Description = 'DJ_EWB';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(59995; "Road Permit No."; Code[20])
        {
            Description = 'EBT STIVAN (11-12-2012)';
        }
        field(59999; "Print BRT"; Boolean)
        {
            Description = 'EBT STIVAN (29112012) - BRT Printing for First Time';
        }
        field(60000; "BRT Print Time"; Time)
        {
            Description = 'EBT STIVAN (29112012) - BRT Printing for First Time';
        }
        field(60005; "Transporter Name"; Text[50])
        {
            Description = 'EBT STIVAN (04/05/2012)';

            trigger OnLookup()
            var
                recShippingAgent: Record 291;
                recvendor: Record 23;
                ShippingAgent: Record 291;
                recTransportDetails: Record 50020;
            begin
                IF PAGE.RUNMODAL(0, ShippingAgent) = ACTION::LookupOK THEN BEGIN
                    "Transporter Name" := ShippingAgent.Name;
                END;

                //EBT STIVAN ---(10/06/2013)---Code to Update Shipment Agent Code, if Transporter Name is Changed------------------------START
                IF "Transporter Name" <> '' THEN BEGIN
                    ShippingAgent.RESET;
                    ShippingAgent.SETRANGE(ShippingAgent.Name, "Transporter Name");
                    IF ShippingAgent.FINDFIRST THEN BEGIN
                        "Shipping Agent Code" := ShippingAgent.Code;
                    END;
                END;
                //EBT STIVAN ---(10/06/2013)---Code to Update Shipment Agent Code, if Transporter Name is Changed--------------------------END

                //EBT STIVAN ---(10/06/2013)---Code to Update the Transport Details Table------------------------START
                recTransportDetails.RESET;
                recTransportDetails.SETRANGE(recTransportDetails."Invoice No.", "No.");
                IF recTransportDetails.FINDFIRST THEN BEGIN
                    recTransportDetails."Shipping Agent Name" := "Transporter Name";

                    recShippingAgent.RESET;
                    recShippingAgent.SETRANGE(recShippingAgent.Name, "Transporter Name");
                    IF recShippingAgent.FINDFIRST THEN BEGIN
                        recTransportDetails."Shipping Agent Code" := recShippingAgent.Code;
                    END;

                    recvendor.RESET;
                    recvendor.SETRANGE(recvendor."Shipping Agent Code", "Shipping Agent Code");
                    IF recvendor.FINDFIRST THEN BEGIN
                        recTransportDetails."Vendor Code" := recvendor."No.";
                        recTransportDetails."Vendor Name" := recvendor."Full Name";
                    END;

                    recTransportDetails.MODIFY;
                END;
                //EBT STIVAN ---(10/06/2013)---Code to Update the Transport Details Table--------------------------END
            end;
        }
        field(60006; "Expected TPT Cost"; Decimal)
        {
            Description = 'EBT STIVAN 10/06/2013';
        }
        field(60007; "Local Expected TPT Cost"; Decimal)
        {
            Description = 'EBT STIVAN 31072013';
        }
        field(60010; "EWB Transaction Type"; Option)
        {
            Description = 'RSPLSUM 09Jun2020';
            Editable = false;
            OptionCaption = ' ,Regular,Bill To - Ship To,Bill From - Dispatch From,Combination of 2 and 3';
            OptionMembers = " ",Regular,"Bill To - Ship To","Bill From - Dispatch From","Combination of 2 and 3";
        }
        field(60011; "EWB No."; Code[20])
        {
            //CalcFormula = Lookup("GST Ledger Entry"."E-Way Bill No." WHERE("Transaction Type"=CONST('Sales'),
            //"Document No."=FIELD("No."),
            //"Document Type"=CONST('Invoice')));
            Description = 'RSPLSUM 30Jul2020';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(60012; "EWB Date"; Date)
        {
            CalcFormula = Lookup("Detailed E-Way Bill"."EWB Creation date" WHERE("Document No." = FIELD("No."),
                                                                                  Cancelled = CONST(false)));
            Description = 'RSPLSUM 30Jul2020';
            Editable = false;
            FieldClass = FlowField;
        }

    }

    keys
    {
        // Add changes to keys here

    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

}