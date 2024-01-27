page 50060 "Transport Detail Entry Form"
{
    // //RSPL008 CAS-06245-R5W6T5     NOOR  new field created in Transport Details level condition wise editable
    // 
    // Date        Version      Remarks
    // .....................................................................................
    // 14Nov2017   RB-N         Transport Details Update

    PageType = Card;
    SourceTable = 50020;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group("Transport Details")
            {
                Caption = 'Transport Details';
                field("Invoice No."; rec."Invoice No.")
                {
                    ApplicationArea = all;
                    Caption = 'No.';
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = all;
                }
                field("From Location Code"; rec."From Location Code")
                {
                    ApplicationArea = all;
                }
                field("From Location Name"; rec."From Location Name")
                {
                    ApplicationArea = all;
                }
                field(Destination; rec.Destination)
                {
                    ApplicationArea = all;
                }
                field("Quantity in Ltrs."; rec."Quantity in Ltrs.")
                {
                    ApplicationArea = all;
                }
                field("Quantity in KGS"; rec."Quantity in KGS")
                {
                    ApplicationArea = all;
                }
                field("Total Quantity in(Kg)"; rec."Total Quantity in(Kg)")
                {
                    ApplicationArea = all;
                }
                field(Rate; rec.Rate)
                {
                    ApplicationArea = all;
                }
                field("LR No."; rec."LR No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("LR Date"; rec."LR Date")
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Shipping Agent Name"; rec."Shipping Agent Name")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Vendor Code"; rec."Vendor Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Expected TPT Cost"; rec."Expected TPT Cost")
                {
                    ApplicationArea = all;
                }
                field("Bill Amount"; rec."Bill Amount")
                {
                    ApplicationArea = all;
                }
                field("Passed Amount"; rec."Passed Amount")
                {
                    ApplicationArea = all;
                }
                field("Other Charges"; rec."Other Charges")
                {
                    ApplicationArea = all;
                }
                field(Deductions; rec.Deductions)
                {
                    ApplicationArea = all;
                    Caption = 'Deductions';
                }
                field("Total Amount"; rec."Total Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("TPT Invoice No."; rec."TPT Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("TPT Invoice Date"; rec."TPT Invoice Date")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Capacity"; rec."Vehicle Capacity")
                {
                    ApplicationArea = all;
                }
                field(Reason; rec.Reason)
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("TPT Invoice Receipt Date"; rec."TPT Invoice Receipt Date")
                {
                    ApplicationArea = all;
                    Editable = TPTInvoiceReceiptDateEditable;
                }
                field("Invoice Date"; rec."Invoice Date")
                {
                    ApplicationArea = all;
                    Caption = 'Date';
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("To Location Code"; rec."To Location Code")
                {
                    ApplicationArea = all;
                }
                field("To Location Name"; rec."To Location Name")
                {
                    ApplicationArea = all;
                }
                field("Cancelled Invoice"; rec."Cancelled Invoice")
                {
                    ApplicationArea = all;
                    Editable = CancelledEdtbleInvoice;
                }
                field("Freight Type"; rec."Freight Type")
                {
                    ApplicationArea = all;
                }
                field("Local LR No."; rec."Local LR No.")
                {
                    ApplicationArea = all;
                }
                field("Local LR Date"; rec."Local LR Date")
                {
                    ApplicationArea = all;
                }
                field("Local Vehicle No."; rec."Local Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("Local Shipment Agent Code"; rec."Local Shipment Agent Code")
                {
                    ApplicationArea = all;
                }
                field("Local Shipment Agent Name"; rec."Local Shipment Agent Name")
                {
                    ApplicationArea = all;
                }
                field("Local Expected TPT Cost"; rec."Local Expected TPT Cost")
                {
                    ApplicationArea = all;
                }
                field("Local TPT Bill Amount"; rec."Local TPT Bill Amount")
                {
                    ApplicationArea = all;
                }
                field("Local TPT Passed Amount"; rec."Local TPT Passed Amount")
                {
                    ApplicationArea = all;
                }
                field("Other Charges-Local"; rec."Other Charges-Local")
                {
                    ApplicationArea = all;
                }
                field("Total Amount-Local"; rec."Total Amount-Local")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Local TPT Invoice No."; rec."Local TPT Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("Local TPT Invoice Date"; rec."Local TPT Invoice Date")
                {
                    ApplicationArea = all;
                }
                field("Local Vehicle Capacity"; rec."Local Vehicle Capacity")
                {
                    ApplicationArea = all;
                }
                field("Type of Vehicle"; rec."Type of Vehicle")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Category of Tanker 1"; rec."Category of Tanker 1")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Category of Tanker 2"; rec."Category of Tanker 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Category of Tanker 3"; rec."Category of Tanker 3")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Category of Tanker 4"; rec."Category of Tanker 4")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Open; rec.Open)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Type of Truck"; rec."Type of Truck")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No. of Packs"; rec."No. of Packs")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Capacity Gate Entry"; rec."Vehicle Capacity Gate Entry")
                {
                    ApplicationArea = all;
                }
                field("Gate Entry No."; rec."Gate Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Expected Loading"; rec."Expected Loading")
                {
                    ApplicationArea = all;
                }
                field("Expetced Unloading"; rec."Expetced Unloading")
                {
                    ApplicationArea = all;
                }
                field("Actual Loading"; rec."Actual Loading")
                {
                    ApplicationArea = all;
                }
                field("Actual Unloading"; rec."Actual Unloading")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        TPTInvoiceReceiptDateEditable := TRUE;
    end;

    trigger OnOpenPage()
    begin
        /*
        //RSPL-Tc
        Memberof.RESET;
        Memberof.SETRANGE(Memberof."User ID",USERID);
        //Memberof.SETRANGE(Memberof."Role ID",'TRANSPORTDETAILS');
        Memberof.SETFILTER(Memberof."Role ID",'%1|%2','TRANSPORTDETAILS','TPTVIEW');
        IF NOT(Memberof.FINDFIRST) THEN */
        //RSPL-TC +
        //>>Robosoft/Migration/Rahul
        /*
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name",USERID);
        AccessControl.SETFILTER("Role ID",'%1|%2','TRANSPORTDETAILS','TPTVIEW');
        IF NOT AccessControl.FINDFIRST THEN //RSPL-TC -
        BEGIN
         ERROR('You do not have permission to View');
        END;
        
        CSOMapping2.RESET;
        CSOMapping2.SETRANGE(CSOMapping2."User Id",UPPERCASE(USERID));
        IF CSOMapping2.FINDFIRST THEN
        BEGIN
         FILTERGROUP(2);
         recTransportdetails.RESET;
         recTransportdetails.SETFILTER(recTransportdetails.Open,'%1',TRUE);
         recTransportdetails.SETRANGE(recTransportdetails."Cancelled Invoice",FALSE);
         IF recTransportdetails.FINDSET THEN
         REPEAT
           CSOMapping1.RESET;
           CSOMapping1.SETRANGE("User Id",UPPERCASE(USERID));
           CSOMapping1.SETRANGE(Type,CSOMapping1.Type::Location);
           CSOMapping1.SETRANGE(Value,recTransportdetails."From Location Code");
           IF CSOMapping1.FINDFIRST THEN
              recTransportdetails.MARK := TRUE
         UNTIL recTransportdetails.NEXT = 0;
         recTransportdetails.MARKEDONLY(TRUE);
         COPY(recTransportdetails);
         FILTERGROUP(0);
        END;
        */
        /*//RSPL-TC
        //RSPL008 CAS-06245-R5W6T5
        recUserMemberOf.RESET;
        recUserMemberOf.SETRANGE(recUserMemberOf."User ID",USERID);
        recUserMemberOf.SETRANGE(recUserMemberOf."Role ID",'TPTINV');
        IF recUserMemberOf.FINDFIRST THEN
           TPTInvoiceReceiptDateEditable := TRUE
          ELSE
           TPTInvoiceReceiptDateEditable := FALSE
        */


        //Fahim ---(10-02-2022)--- To make Cancell Invoice Field EDITABLE as per ROLE Assigned -----START

        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETRANGE("Role ID", 'CANCELL-TRSPRTDETAIL');
        IF AccessControl.FINDFIRST THEN BEGIN
            //CurrForm."Print Invoice".EDITABLE := TRUE;
            CancelledEdtbleInvoice := TRUE; //RSPL-TC
        END ELSE
            //CurrForm."Print Invoice".EDITABLE := FALSE;
            CancelledEdtbleInvoice := FALSE; //RSPL-TC
        //Fahim ---(10-02-2022)--- To make Cancell Invoice Field EDITABLE as per ROLE Assigned -----END

    end;

    var
        CSOMapping2: Record 50006;
        recTransportdetails: Record 50020;
        CSOMapping1: Record 50006;
        recTrsnfrshipmnt: Record 5744;
        // [InDataSet]
        TPTInvoiceReceiptDateEditable: Boolean;
        AccessControl: Record 2000000053;
        CancelledEdtbleInvoice: Boolean;
}

