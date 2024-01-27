tableextension 50014 PurchHdrExtCutm extends 38
{
    fields
    {
        field(50000; "Receiving Date"; Date)
        {
            Description = 'EBT 10/01/12';
        }
        field(50001; "Full Name"; Text[60])
        {
        }
        field(50003; Closed; Boolean)
        {
            Description = 'EBT/ORDERCLOSE/0001';
            Editable = true;

            trigger OnValidate()
            begin
                //EBT/ORDERCLOSE/0001
                IF Closed = TRUE THEN BEGIN
                    "Closing Date" := TODAY;
                    MODIFY;
                END
                ELSE
                    IF Closed = FALSE THEN BEGIN
                        "Closing Date" := 0D;
                        MODIFY;
                    END
                //EBT/ORDERCLOSE/0001
            end;
        }
        field(50004; "Closing Date"; Date)
        {
            Description = 'EBT/ORDERCLOSE/0001';
            Editable = false;
        }
        field(50005; "Shipping Agent Code1"; Code[10])
        {
            Description = 'Pratyusha';
            TableRelation = "Shipping Agent";
            Caption = 'Shipping Agent Code';

            trigger OnValidate()
            begin
                //EBT 0002 in existing
                TESTFIELD(Status, Status::Open);
                IF xRec."Shipping Agent Code" = "Shipping Agent Code" THEN
                    EXIT;
                //EBT 0002
                //"Shipping Agent Service Code" := ''; //EBT 0002
            end;
        }
        field(50006; "Advance Amount"; Decimal)
        {
            Description = 'Pratyusha';
        }
        field(50007; "Cheque No."; Code[50])
        {
            Description = 'Pratyusha';
        }
        field(50008; "User City"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = "Form Update sales Invoice";
        }
        field(50009; "User State"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = State; //Azhar Pending
        }
        field(50010; "User Zone"; Code[10])
        {
            Description = 'EBT/APV/0001';
            Editable = false;
            TableRelation = "Vehicle Capacity";
        }
        field(50011; "Cheque Date"; Date)
        {
            Description = 'Pratyusha';
        }
        field(50012; "Gross Weight"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50013; "Tare Weight"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';

            trigger OnValidate()
            begin
                "Net Weight" := "Gross Weight" - "Tare Weight";
            end;
        }
        field(50014; "Net Weight"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50015; "Density Factor"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50016; "Vendor Quantity"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50030; "Blanket Order No."; Code[20])
        {
            Description = 'EBT 0003';
        }
        field(50049; "Freight Charges"; Text[50])
        {
            Description = 'EBT STIVAN (24/09/2012)';
        }
        field(50050; "Vendor TIN No."; Code[11])
        {
            Description = 'EBT STIVAN (13072012) - To Update the TIN No. of vendor on PO';
        }
        field(50051; "Paid Amount"; Decimal)
        {
            Description = 'EBT STIVAN (30102012) - For Advance PaymentDetails';
        }
        field(50052; "Paid Cheque No."; Code[10])
        {
            Description = 'EBT STIVAN (30102012) - For Advance PaymentDetails';
        }
        field(50053; "Paid Cheque Date"; Date)
        {
            Description = 'EBT STIVAN (30102012) - For Advance PaymentDetails';
        }
        field(50054; "Order Creation Date"; Date)
        {
            Description = 'EBT MILAN (280114) - Flowed from Blenket Order Todays Date';
        }
        field(50055; "Freight Type"; Option)
        {
            Description = 'EBT MILAN 280114 Should flow from Blnket to order';
            OptionCaption = ' ,PAID,TO PAY,PAY & ADD IN BILL,SELF PICKUP';
            OptionMembers = " ",PAID,"TO PAY","PAY & ADD IN BILL","SELF PICKUP";
        }
        field(50056; "Exp. TPT Cost"; Decimal)
        {
            Description = 'EBT MILAN (280114) - Flowed from Blenket Order Todays Date';
        }
        field(50200; "LR Details Required"; Boolean)
        {
            Description = 'EBT/LR/0001';
            Editable = false;
        }
        field(50201; "LR Invoice No."; Code[20])
        {
            Description = 'EBT/LR/0001';
            TableRelation = "Transport Subsidy Setup New";
        }
        field(50290; "Scan QrCode E-Invoice"; Text[180])
        {
            Description = 'ysr_EINV';

            trigger OnValidate()
            var
                //EInvoiceAPI: Codeunit 50011;
                GeneralLedgerSetup: Record 98;
                AuthToken: Text;
                Sek: Text;
                TokenExpiry: Text;
                ClientId: Text;
                decryptedSek: Text;
                recLocation: Record 14;
                Irn: Text;
            begin
                //ysr_EINV  Begin
                IF "Scan QrCode E-Invoice" = '' THEN
                    EXIT;
                GeneralLedgerSetup.GET;
                /*
                                EInvoiceAPI.GetToken_Govt(GeneralLedgerSetup."E-Inv UserName", GeneralLedgerSetup."E-Inv Password", GeneralLedgerSetup."E-Inv ForceRefreshAccessToken"
                                      , ClientId, AuthToken, Sek, TokenExpiry, decryptedSek
                                      , GeneralLedgerSetup."E-Inv ClientId", GeneralLedgerSetup."E-Inv Client_Secret");

                                IF recLocation.GET("Location Code") THEN;

                                Irn := SELECTSTR(8, "Scan QrCode E-Invoice");
                */
                /*
                                EInvoiceAPI.VerifyVendorIRNDetails(AuthToken, Sek, Irn, GeneralLedgerSetup."E-Inv ClientId", GeneralLedgerSetup."E-Inv Client_Secret",
                                        recLocation."GST Registration No.", GeneralLedgerSetup."E-Inv UserName");
                                        */
                //ysr_EINV  End
            end;
        }
        field(60001; Remarks; Text[40])
        {
            Description = 'Pratyusha-flowed to Shipping Documents.,RSPLSUM 15Apr2020 length changed from 120 to 40';
        }
        field(60002; "Send For Approval"; Boolean)
        {
            Description = '14Mar2018 PurchaseApprovalProcess';
        }
        field(60003; "Level1 Approval"; Boolean)
        {
            Description = '14Mar2018 PurchaseApprovalProcess';
        }
        field(60004; "Level2 Approval"; Boolean)
        {
            Description = '14Mar2018 PurchaseApprovalProcess';
        }
        field(60005; "Approval Status"; Option)
        {
            Description = '14Mar2018 PurchaseApprovalProcess';
            OptionCaption = 'Open,Pending for L1 Approval,Pending for L2 Approval,Approved';
            OptionMembers = Open,"Pending for L1 Approval","Pending for L2 Approval",Approved;
        }
        field(60006; "Work Order"; Boolean)
        {
            Description = '10Apr2018 WorkOrderProcess';
            Editable = false;
        }
        field(60007; "Invoice Received By Finance"; Date)
        {
            Description = '14May2018';
        }
        field(60008; "Gate Pass"; Boolean)
        {
            Description = '17Mar2019  OGP';
        }
        field(60009; "Gate Pass Status"; Option)
        {
            Description = '17Mar2019  OGP';
            OptionCaption = ' ,Returnable,Non-Returnable';
            OptionMembers = " ",Returnable,"Non-Returnable";
        }
        field(60010; "Mode of Transport"; Option)
        {
            Description = '17Mar2019  OGP';
            OptionCaption = ' ,By Air,By Cargo,By Courier,By H.O Mail,By Hand Carry';
            OptionMembers = " ","By Air","By Cargo","By Courier","By H.O Mail","By Hand Carry";
        }
        field(60011; "Requestor's Dept"; Text[30])
        {
            Description = '17Mar2019  OGP';
        }
        field(60012; "Return Material Date"; Date)
        {
            Description = '17Mar2019  OGP';
        }
        field(60013; "Purpose of GatePass"; Text[30])
        {
            Description = '17Mar2019  OGP, RSPLSUM 29Jul2020 length changed from 80 to 30';
        }
        field(60014; "Approved by Finance"; Boolean)
        {
            Description = '06May2019';
        }
        field(60015; "Finance Approver ID"; Code[50])
        {
            Description = '06May2019';
        }
        field(60016; "Finance Approver Date"; DateTime)
        {
            Description = '06May2019';
        }
        field(60017; "Finance Rejection Remarks"; Text[50])
        {
            Description = '06May2019';
        }
        field(60018; "Finance Rejection ID"; Code[50])
        {
            Description = '06May2019';
        }
        field(60019; "Finance Rejection Date"; DateTime)
        {
            Description = '06May2019';
        }
        field(60020; "Finance Rejected"; Boolean)
        {
            Description = '06May2019';
        }
        field(60021; Quantity; Decimal)
        {
            CalcFormula = Sum("Purchase Line".Quantity WHERE("Document No." = FIELD("No.")));
            DecimalPlaces = 0 : 5;
            Description = 'RSPLSUM 17Jul2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60022; "Quantity Received"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Quantity Received" WHERE("Document No." = FIELD("No.")));
            Caption = 'Quantity Received';
            DecimalPlaces = 0 : 5;
            Description = 'RSPLSUM 17Jul2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60023; "Quantity Invoiced"; Decimal)
        {
            CalcFormula = Sum("Purchase Line"."Quantity Invoiced" WHERE("Document No." = FIELD("No.")));
            DecimalPlaces = 0 : 5;
            Description = 'RSPLSUM 17Jul2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60024; "Department Code"; Option)
        {
            Description = 'RSPLSUM 14Apr2020';
            OptionCaption = ' ,Material,Administration,Travel Desk,HR,IT,Company Secretory,Accounts,Marketing,Plant - Maintenance,Plant - Admin,R&D and QC,SCM';
            OptionMembers = " ",Material,Administration,"Travel Desk",HR,IT,"Company Secretory",Accounts,Marketing,"Plant - Maintenance","Plant - Admin","R&D and QC",SCM;
        }
        field(60025; "Deal Sheet No."; Text[20])
        {
            Description = 'RSPLSUM 15Apr2020';
        }
        field(60026; "Blanket Order Creation Date"; Date)
        {
            Description = 'RSPLSUM 16Apr2020';
            Editable = false;
        }
        field(60027; "Created By"; Code[50])
        {
            Description = 'RSPLSUM 16Apr2020';
            Editable = false;
        }
        field(60028; "Deal Sheet Date"; Date)
        {
            Description = 'RSPLSUM 15Jul2020';
        }
        field(60029; "Vessel Code"; Code[10])
        {
            Description = 'RSPLSUM 29Jul2020';
            TableRelation = "Vessel Master"."Vessel Code";
        }
        field(60030; "Vessel Name"; Text[50])
        {
            CalcFormula = Lookup("Vessel Master"."Vessel Name" WHERE("Vessel Code" = FIELD("Vessel Code")));
            Description = 'RSPLSUM 29Jul2020';
            Editable = false;
            FieldClass = FlowField;
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                EBTlocation: Record Location;
            begin
                EBTlocation.RESET;
                EBTlocation.SETRANGE(EBTlocation.Code, "Location Code");
                EBTlocation.SETRANGE(EBTlocation.Closed, TRUE);
                IF EBTlocation.FINDFIRST THEN BEGIN
                    ERROR('You are not allowed the select this Location as it is Closed');
                END;
            end;
        }
        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            var
                Vend: Record Vendor;
            begin
                if Vend.Get(Rec."Buy-from Vendor No.") then begin
                    IF Vend."TDS not Applicable" = TRUE THEN
                        MESSAGE('TDS Not Applicable for this Vendor');

                    IF Vend."Shipping Agent" THEN BEGIN
                        IF Vend."Shipment Method Code" = '' THEN
                            ERROR('You have defined Vendor No. %1 as Shipping Agent but didnot linked to any Shipping Agent. Fisrt link the Shipping agent',
                                   "Buy-from Vendor No.");
                    end;
                    Rec.Validate("Full Name", Vend."Full Name");
                end;
            end;
        }

        // MY PC 08 01 2024
        modify("Order Address Code")
        {
            trigger OnAfterValidate()
            var
                OrderAddr: Record "Order Address";
            begin
                //EBT STIVAN ---(13072012)--- To Update the Vendor TIN No. at PO Level ----------START
                "Vendor TIN No." := OrderAddr."T.I.N. No.";
                //EBT STIVAN ---(13072012)--- To Update the Vendor TIN No. at PO Level ------------END
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

    /// MY PC 12 01 2024
    PROCEDURE TDSValidation_LimitExceed();
    VAR
        recGLSetup: Record 98;
        // TDSGroup: Record 13731;
        ThresholdHC: Decimal;
        decTDSPurchAmount: Decimal;
        recPurchaseLine: Record 39;
        recPurchaseHeader: Record 38;
        recPurchInvoiceLine: Record 123;
        //  ErrorLimitExceed: TextConst 'ENU=Please Select TDS NOC-Goods and Calculate TDS Amount';
        recCurrentPurchLine: Record 39;
        recAccPeriod: Record 50;
        dtAccStartDate: Date;
        dtAccEndDate: Date;
        RecVendor: Record 23;
        recPurchCrMemoLine: Record 125;
    BEGIN
        //robotdsDJ
        recGLSetup.GET;
        IF recGLSetup."TDS Effective Date" <> 0D THEN
            IF PurchHeader."Posting Date" < recGLSetup."TDS Effective Date" then
                EXIT;
        decTDSPurchAmount := 0;

        recAccPeriod.RESET;
        recAccPeriod.SETCURRENTKEY("Starting Date");
        recAccPeriod.SETRANGE("New Fiscal Year", TRUE);
        recAccPeriod.SETFILTER("Starting Date", '<=%1', "Posting Date");
        recAccPeriod.ASCENDING(FALSE);
        IF recAccPeriod.FINDFIRST THEN BEGIN
            dtAccStartDate := recAccPeriod."Starting Date";
            dtAccEndDate := CALCDATE('', dtAccStartDate);
        END;

        recCurrentPurchLine.RESET;
        recCurrentPurchLine.SETCURRENTKEY("Document Type", "Pay-to Vendor No.", "Currency Code");
        recCurrentPurchLine.SETRANGE("Document Type", "Document Type");
        recCurrentPurchLine.SETRANGE("Document No.", "No.");
        recCurrentPurchLine.SETRANGE("Posting Date", dtAccStartDate, dtAccEndDate);
        recCurrentPurchLine.SETRANGE("TDS Applicable", TRUE);
        //  recCurrentPurchLine.SETFILTER("TDS Nature of Deduction", '%1', '');
        recCurrentPurchLine.SETFILTER("HSN/SAC Code", '%1', '');
        // recCurrentPurchLine.SETFILTER(rec."TDS Amount", '%1', 0);
        IF recCurrentPurchLine.FINDFIRST THEN
            EXIT;

        recCurrentPurchLine.RESET;
        recCurrentPurchLine.SETCURRENTKEY("Document Type", "Pay-to Vendor No.", "Currency Code");
        recCurrentPurchLine.SETRANGE("Document Type", "Document Type");
        recCurrentPurchLine.SETRANGE("Document No.", "No.");
        recCurrentPurchLine.SETRANGE("TDS Applicable", TRUE);
        recCurrentPurchLine.SETRANGE("Posting Date", dtAccStartDate, dtAccEndDate);
        recCurrentPurchLine.SETFILTER("HSN/SAC Code", '%1', '');
        recCurrentPurchLine.CALCSUMS("Line Amount");

        IF recCurrentPurchLine.FINDSET THEN
            REPEAT
                //recCurrentPurchLine.TESTFIELD("TDS Group");
                IF (recCurrentPurchLine."Qty. to Invoice" <> 0) THEN
                    decTDSPurchAmount += (recCurrentPurchLine."Line Amount" / recCurrentPurchLine.Quantity * recCurrentPurchLine."Qty. to Invoice")
                //robotdsDJ Comment +(recCurrentPurchLine."Total GST Amount"/recCurrentPurchLine.Quantity * recCurrentPurchLine."Qty. to Invoice")
                ELSE
                    decTDSPurchAmount := 0;
            UNTIL recCurrentPurchLine.NEXT = 0;

        //  TDSGroup.RESET;
        // TDSGroup.SETRANGE("TDS Threshold Limit", TRUE);
        //  TDSGroup.SETRANGE("TDS Group", recCurrentPurchLine."TDS Group");
        // IF TDSGroup.FINDFIRST THEN BEGIN
        //  ThresholdHC := TDSGroup."TDS Threshold Amount";

        recPurchInvoiceLine.RESET;
        recPurchInvoiceLine.SETCURRENTKEY("Pay-to Vendor No.");
        recPurchInvoiceLine.SETRANGE("TDS Applicable", TRUE);
        //recPurchInvoiceLine.SETRANGE("Pay-to Vendor No.",  "Pay-to Vendor No.");//robotdsDJ Comment
        recPurchInvoiceLine.SETFILTER("Pay-to Vendor No.", GetVendorFilters("Pay-to Vendor No."));
        // recPurchInvoiceLine.CALCSUMS("Line Amount", rec."Total GST Amount");
        decTDSPurchAmount += recPurchInvoiceLine."Line Amount";//robotdsDJ Comment  + recPurchInvoiceLine."Total GST Amount";

        recPurchCrMemoLine.RESET;
        recPurchCrMemoLine.SETCURRENTKEY("Pay-to Vendor No.");
        recPurchCrMemoLine.SETRANGE("TDS Applicable", TRUE);
        //recPurchCrMemoLine.SETRANGE("Pay-to Vendor No.",  "Pay-to Vendor No.");//robotdsDJ Comment
        recPurchCrMemoLine.SETFILTER("Pay-to Vendor No.", GetVendorFilters("Pay-to Vendor No."));
        recPurchCrMemoLine.SETRANGE("Posting Date", dtAccStartDate, dtAccEndDate);
        recPurchCrMemoLine.CALCSUMS("Line Amount");
        decTDSPurchAmount -= recPurchCrMemoLine."Line Amount"; //robotdsDJ Comment  + recPurchInvoiceLine."Total GST Amount";

        RecVendor.RESET;
        RecVendor.GET("Pay-to Vendor No.");

        IF "Document Type" IN ["Document Type"::Order, "Document Type"::Invoice] THEN
            recCurrentPurchLine.RESET;
        recCurrentPurchLine.SETCURRENTKEY("Document Type", "Pay-to Vendor No.", "Currency Code");
        recCurrentPurchLine.SETRANGE("Document Type", "Document Type");
        recCurrentPurchLine.SETRANGE("Document No.", "No.");
        recCurrentPurchLine.SETRANGE("Posting Date", dtAccStartDate, dtAccEndDate);
        recCurrentPurchLine.SETRANGE("TDS Applicable", TRUE);
        // recCurrentPurchLine.SETFILTER(rec."TDS Nature of Deduction", '%1', '');
        recCurrentPurchLine.SETFILTER("HSN/SAC Code", '%1', '');
        //recCurrentPurchLine.SETFILTER("TDS Amount", '%1', 0);
        IF recCurrentPurchLine.FINDFIRST THEN
            ERROR('Select TDS Nature of Deduction');

    END;
    /// MY PC 12 01 2024

    //robotdsDJ 
    PROCEDURE GetVendorFilters(VendorNo: Code[20]): Text;
    VAR
        RecVendor: Record 23;
        PANNo: Code[20];
        VendorFilters: Text;
    BEGIN
        //robotdsDJ
        VendorFilters := '';
        RecVendor.GET(VendorNo);
        IF RecVendor."P.A.N. No." <> '' THEN
            PANNo := RecVendor."P.A.N. No."
        ELSE BEGIN
            VendorFilters := VendorNo;
            EXIT(VendorFilters);//robotds
        END;
        RecVendor.RESET;
        RecVendor.SETRANGE("P.A.N. No.", PANNo);
        IF RecVendor.FINDSET THEN
            REPEAT
                IF VendorFilters = '' THEN
                    VendorFilters := RecVendor."No."
                ELSE
                    VendorFilters := VendorFilters + '|' + RecVendor."No.";
            UNTIL RecVendor.NEXT = 0;
        EXIT(VendorFilters)
        //robotdsDJ
    END;


}