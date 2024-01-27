tableextension 50067 TransferHeaderExtCstm extends "Transfer Header"
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
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50002; "Driver's License No."; Code[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50003; "Driver's Mobile No."; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50004; "Vehicle Capacity"; Code[20])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
            TableRelation = "Vehicle Capacity".Code;

            trigger OnValidate()
            begin
                "Vehicle Capacity" := UPPERCASE("Vehicle Capacity");
            end;
        }
        field(50005; "Vehicle For Location"; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
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
            TableRelation = State;
        }
        field(50013; "Transfer To User Zone"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = "Vehicle Capacity";
        }
        field(50014; "Transport Type"; Option)
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
            OptionCaption = ' ,Intercity,Local+Intercity,Own Vehicle';
            OptionMembers = " ",Intercity,"Local+Intercity","Cust.Transport";
        }
        field(50020; "Transfer Indent No"; Code[20])
        {
            Description = 'EBT/TROIndent/0001';
            Editable = false;
            TableRelation = "Transfer Indent Header";
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
        field(50024; "Local Vehicle Capacity"; Code[20])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
            TableRelation = "Vehicle Capacity".Code;

            trigger OnValidate()
            begin
                "Local Vehicle Capacity" := UPPERCASE("Local Vehicle Capacity");
            end;
        }
        field(50025; "Local Vehicle for Location"; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50026; "Local Vehicle No."; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';

            trigger OnValidate()
            begin
                "Local Vehicle No." := UPPERCASE("Local Vehicle No.");//EBT STIVAN---(24/07/2013)
            end;
        }
        field(50027; "Local LR No."; Code[20])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50028; "Local LR Date"; Date)
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50029; "Shipping No. Series"; Code[10])
        {
            Description = 'EBT0001';
            TableRelation = "No. Series";

            trigger OnLookup()
            begin
                //EBT0001
                InvtSetup.GET;
                InvtSetup.TESTFIELD(InvtSetup."Posted Transfer Shpt. Nos.");
                /*ResCentr.RESET;
                //ResCentr.SETRANGE(ResCentr."Location Code","Transfer-from Code");
                ResCentr.SETRANGE(ResCentr.Code,"Shortcut Dimension 2 Code");
                IF ResCentr.FINDFIRST THEN;   */
                NoseriesRelation.RESET;
                NoseriesRelation.SETRANGE(NoseriesRelation.Code, InvtSetup."Posted Transfer Shpt. Nos.");
                NoseriesRelation.SETRANGE(NoseriesRelation."Resp.Ctr.Filter", "Shortcut Dimension 2 Code");
                //IF NoseriesRelation.FINDSET THEN
                //IF NoSeriesMgt.LookupSeries(InvtSetup."Posted Transfer Shpt. Nos.", "Shipping No. Series") THEN
                //"Shipping No. Series" :=
                //EBT0001

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
        field(50203; "Distance in kms"; Decimal)
        {
            Description = 'DJ_EWB';

            trigger OnValidate()
            begin
            end;
        }
        field(59995; "Road Permit No."; Code[20])
        {
            Description = 'EBT STIVAN (11-12-2012)';
        }
        field(60001; "Created Date"; Date)
        {
            Description = 'EBT STIVAN (13/06/2013)';
        }
        field(60005; "Transporter Name"; Code[50])
        {
            Description = 'EBT STIVAN (04/05/2012)';

            trigger OnLookup()
            begin
                IF PAGE.RUNMODAL(0, shippingagent) = ACTION::LookupOK THEN BEGIN
                    "Transporter Name" := shippingagent.Name;
                    "Shipping Agent Code" := shippingagent.Code;//EBT STIVAN ---(10/06/2013)---Code to Update Shipment Agent Code
                END;
            end;
        }
        field(60006; "Expected TPT Cost"; Decimal)
        {
            Description = 'EBT STIVAN 21062013';
        }
        field(60007; "Local Expected TPT Cost"; Decimal)
        {
            Description = 'EBT STIVAN 31072013';
        }
        field(60008; "Expected Loading"; Decimal)
        {
            Description = 'RSPLSUM';
        }
        field(60009; "Expected Unloading"; Decimal)
        {
            Description = 'RSPLSUM';
        }
        field(60010; "EWB Transaction Type"; Option)
        {
            Description = 'RSPLSUM 09Jun2020';
            OptionCaption = ' ,Regular,Bill To - Ship To,Bill From - Dispatch From,Combination of 2 and 3';
            OptionMembers = " ",Regular,"Bill To - Ship To","Bill From - Dispatch From","Combination of 2 and 3";
        }
        modify("Transfer-from Code")
        {
            trigger OnAfterValidate()
            var
                EBTlocation: Record Location;
            begin
                EBTlocation.RESET;
                EBTlocation.SETRANGE(EBTlocation.Code, "Transfer-from Code");
                EBTlocation.SETRANGE(EBTlocation.Closed, TRUE);
                IF EBTlocation.FINDFIRST THEN BEGIN
                    ERROR('You are not allowed the select this Location as it is Closed');
                END;
            end;

        }
        modify("Transfer-to Code")
        {
            trigger OnAfterValidate()
            var
                EBTlocation: Record Location;
            begin
                EBTlocation.RESET;
                EBTlocation.SETRANGE(EBTlocation.Code, "Transfer-to Code");
                EBTlocation.SETRANGE(EBTlocation.Closed, TRUE);
                IF EBTlocation.FINDFIRST THEN BEGIN
                    ERROR('You are not allowed the select this Location as it is Closed');
                END;
            end;
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
        InvtSetup: Record 313;
        NoseriesRelation: Record 310;
        shippingagent: Record 291;
}