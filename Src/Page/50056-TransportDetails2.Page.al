page 50056 "Transport Details - 2"
{
    PageType = List;
    SourceTable = 50020;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Invoice No."; rec."Invoice No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Invoice Date"; rec."Invoice Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("LR No."; rec."LR No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = all;
                }
                field("TPT Invoice Receipt Date"; rec."TPT Invoice Receipt Date")
                {
                    ApplicationArea = all;
                    Editable = TPTInvoiceReceiptDateEditable;
                }
                field("LR Date"; rec."LR Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("From Location Code"; rec."From Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Type of Vehicle"; rec."Type of Vehicle")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("From Location Name"; rec."From Location Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("To Location Code"; rec."To Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("To Location Name"; rec."To Location Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vendor Code"; rec."Vendor Code")
                {
                    ApplicationArea = all;
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Name"; rec."Shipping Agent Name")
                {
                    ApplicationArea = all;
                }
                field("TPT Invoice No."; rec."TPT Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("TPT Invoice Date"; rec."TPT Invoice Date")
                {
                    ApplicationArea = all;
                }
                field("Local TPT Invoice No."; rec."Local TPT Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("Local TPT Invoice Date"; rec."Local TPT Invoice Date")
                {
                    ApplicationArea = all;
                }
                field("Expected TPT Cost"; rec."Expected TPT Cost")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Passed Amount"; rec."Passed Amount")
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Bill Amount"; rec."Bill Amount")
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Other Charges"; rec."Other Charges")
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Total Amount"; rec."Total Amount")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Local LR No."; rec."Local LR No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Local LR Date"; rec."Local LR Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Local Vehicle No."; rec."Local Vehicle No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Local Shipment Agent Code"; rec."Local Shipment Agent Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Local Shipment Agent Name"; rec."Local Shipment Agent Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Local TPT Bill Amount"; rec."Local TPT Bill Amount")
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Local TPT Passed Amount"; rec."Local TPT Passed Amount")
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Other Charges-Local"; rec."Other Charges-Local")
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Local Expected TPT Cost"; rec."Local Expected TPT Cost")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Total Amount-Local"; rec."Total Amount-Local")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Freight Type"; rec."Freight Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Entry Date"; rec."Entry Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Reason; rec.Reason)
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
        /*  //RSPL-TC
        Memberof.RESET;
        Memberof.SETRANGE(Memberof."User ID",USERID);
        Memberof.SETRANGE(Memberof."Role ID",'TRANSPORTDETAILS');
        IF NOT(Memberof.FINDFIRST) THEN
        BEGIN
        // ERROR('You do not have permission to View');
        END;
        */
        //RSPL-TC +
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETRANGE("Role ID", 'TRANSPORTDETAILS');
        IF NOT AccessControl.FINDFIRST THEN //RSPL-TC -
        BEGIN
            // ERROR('You do not have permission to View');
        END;

        CSOMapping2.RESET;
        CSOMapping2.SETRANGE(CSOMapping2."User Id", UPPERCASE(USERID));
        IF CSOMapping2.FINDFIRST THEN BEGIN
            rec.FILTERGROUP(2);
            recTransportdetails.RESET;
            recTransportdetails.SETFILTER(recTransportdetails.Open, '%1', TRUE);
            recTransportdetails.SETRANGE(recTransportdetails."Cancelled Invoice", FALSE);
            IF recTransportdetails.FINDSET THEN
                REPEAT
                    CSOMapping1.RESET;
                    CSOMapping1.SETRANGE("User Id", UPPERCASE(USERID));
                    CSOMapping1.SETRANGE(Type, CSOMapping1.Type::Location);
                    CSOMapping1.SETRANGE(Value, recTransportdetails."From Location Code");
                    IF CSOMapping1.FINDFIRST THEN
                        recTransportdetails.MARK := TRUE
                UNTIL recTransportdetails.NEXT = 0;
            recTransportdetails.MARKEDONLY(TRUE);
            rec.COPY(recTransportdetails);
            rec.FILTERGROUP(0);
        END;

        /*  //RSPL-TC
        //RSPL008 CAS-06245-R5W6T5
        recUserMemberOf.RESET;
        recUserMemberOf.SETRANGE(recUserMemberOf."User ID",USERID);
        recUserMemberOf.SETRANGE(recUserMemberOf."Role ID",'TPTINV');
        IF recUserMemberOf.FINDFIRST THEN
        */
        //RSPL-TC +
        AccessControl.RESET;
        AccessControl.SETRANGE("User Name", USERID);
        AccessControl.SETRANGE("Role ID", 'TPTINV');
        IF AccessControl.FINDFIRST THEN //RSPL-TC -
            TPTInvoiceReceiptDateEditable := TRUE
        ELSE
            TPTInvoiceReceiptDateEditable := FALSE

    end;

    var
        CSOMapping1: Record 50006;
        CSOMapping2: Record 50006;
        recTransportdetails: Record 50020;
        // [InDataSet]
        TPTInvoiceReceiptDateEditable: Boolean;
        AccessControl: Record 2000000053;
}

