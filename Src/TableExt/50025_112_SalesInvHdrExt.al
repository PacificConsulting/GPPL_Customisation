tableextension 50025 SaalesInvHdrExtCutm extends 112

{
    fields
    {
        field(50001; "Full Name"; Text[100])
        {
            Description = 'RSPLSUM 28Jun2020 length changed from 60 to 100';
        }
        field(50002; "Customer Type"; Option)
        {
            Description = 'EBT 0001';
            OptionCaption = 'Customer,Distributor';
            OptionMembers = Customer,Distributor;
        }
        field(50005; "Cancelled Invoice"; Boolean)
        {
            Description = 'EBT/CANINV/0001';
            Editable = true;
        }
        field(50006; "Supplimentary Invoice"; Boolean)
        {
            Description = 'EBT/SUPPINV/0001';
        }
        field(50011; "OverDue Balance"; Boolean)
        {
            Description = 'EBT/CINV/0002';
        }
        field(50012; "Commission Agent"; Code[10])
        {
            Description = 'EBT - PRATYUSHA - CUST-COMM';
        }
        field(50025; "Driver's Name"; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha, RSPLSUM 02dec2020 field added';
        }
        field(50027; "Driver's Mobile No."; Text[30])
        {
            Description = 'EBT STIVAN (17/09/2012)- ToFlow Drivers Mobile No. From CSO';
        }
        field(50028; "Vehicle Capacity"; Text[30])
        {
            Description = 'EBT MILAN (201213)';

            trigger OnValidate()
            begin
                //"Vehicle Capacity" := UPPERCASE("Vehicle Capacity");
            end;
        }
        field(50030; "Transport Type"; Option)
        {
            Description = 'EBT STIVAN';
            OptionCaption = ' ,Intercity,Local+Intercity,Cust.Transport';
            OptionMembers = " ",Intercity,"Local+Intercity","Cust.Transport";
        }
        field(50033; "Local Driver's Mobile No."; Text[30])
        {
            Description = 'EBT STIVAN (17/09/2012)- ToFlow Drivers Mobile No. From CSO';
        }
        field(50034; "Local Vehicle Capacity"; Text[30])
        {
            Description = 'EBT MILAN (201213)';
        }
        field(50051; Remarks; Text[100])
        {
            Description = 'EBT STIVAN (28/04/2012)';
        }
        field(50052; Remarks2; Text[100])
        {
            Description = 'RSPL Sourav 010415';
        }
        field(50114; "CT3 Order"; Boolean)
        {

            trigger OnValidate()
            begin
                //EBT Paramita
                IF "CT3 Order" THEN BEGIN
                    IF "CT1 Order" THEN
                        ERROR('U cannot select CT3 And CT1 both');
                END;
                //EBT Paramita
            end;
        }
        field(50115; "CT3 No."; Code[20])
        {
        }
        field(50116; "CT3 Date"; Date)
        {
        }
        field(50117; "ARE3 No."; Code[20])
        {
        }
        field(50118; "ARE3 Date"; Date)
        {
        }
        field(50120; "CT1 Order"; Boolean)
        {

            trigger OnValidate()
            begin
                //EBT Paramita
                IF "CT1 Order" THEN BEGIN
                    IF "CT3 Order" THEN
                        ERROR('U cannot select CT1 And CT3 both');
                END;
                //EBT Paramita
            end;
        }
        field(50121; "CT1 No."; Code[20])
        {
        }
        field(50122; "CT1 Date"; Date)
        {
        }
        field(50123; "ARE1 No."; Code[20])
        {
        }
        field(50124; "ARE1 Date"; Date)
        {
        }
        field(50131; "Ex-Factory"; Text[20])
        {
        }
        field(50150; "Under Rebate"; Boolean)
        {
        }
        field(50151; "Under LUT"; Boolean)
        {
            Editable = true;
        }
        field(50152; "Export Under Rebate"; Text[30])
        {
        }
        field(50153; "Export Under LUT"; Text[30])
        {
        }
        field(50154; "C Form Status"; Boolean)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50155; "C Form Amount"; Decimal)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50156; "C Form Date"; Date)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50157; "C Form Recd.Date"; Date)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50158; "Period From"; Date)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50159; "Period To"; Date)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50160; "DN/CN No."; Code[30])
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50161; "DN/CN Type"; Text[50])
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50162; "Diff. Reason"; Text[90])
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form RSPLAM30595 Size reduce 100 To 90';
        }
        field(50163; "Diff.Amount"; Decimal)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50164; "E.1-Form No."; Code[10])
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50165; "Date of Issue"; Date)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50166; "Date of Receipt"; Date)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50167; "Handover To"; Text[10])
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form,RSPLSUM28902 length changed from 30 to 10';
        }
        field(50168; "Handover Date"; Date)
        {
            Description = 'EBT STIVAN (10/07/2012) - For F Form';
        }
        field(50170; "Credit Limit Approval"; Option)
        {
            Description = 'RSPL022 - Credit Limit Approval';
            Editable = false;
            OptionCaption = 'Open,Pending for Credit Approval,Approved';
            OptionMembers = Open,"Pending for Credit Approval",Approved;
        }
        field(50174; "Bank Account No."; Code[20])
        {
            Description = '17July2017 RB-N - RSPLSUM 28May2020 data type changed from text to code';
            Editable = false;
            TableRelation = "Bank Account"."No.";
        }
        field(50175; "Loading Port Name"; Option)
        {
            Description = '21Sep2017 RB-N';
            Editable = false;
            OptionCaption = ' ,NHAVA SHEVA SEA (INNSA1),BY ROAD';
            OptionMembers = " ","NHAVA SHEVA SEA (INNSA1)","BY ROAD";
        }
        field(50180; "Debit Memo"; Boolean)
        {
            Description = 'RSPLSUM 04Apr2020';
            Editable = false;
        }
        field(50181; "Get Entry Outward"; Code[20])
        {
            Description = 'NB28902';
        }
        field(50182; "Dispatch Code"; Code[10])
        {
            Description = 'RSPLAM30595';
            TableRelation = "Dispatch From Location"."Location Code" WHERE("Dispatch Location Code" = FIELD("Location Code"));

            trigger OnValidate()
            var
                text00012: Label 'Please select EWB Transaction type as Combination of 2 & 3 or Bill from - Dispatch from current value is %1';
            begin
                //RSPLAM30595
                IF ("EWB Transaction Type" <> "EWB Transaction Type"::"Combination of 2 and 3") AND ("EWB Transaction Type" <> "EWB Transaction Type"::"Bill From - Dispatch From") THEN
                    ERROR(text00012, "EWB Transaction Type");
                //RSPLAM30595
            end;
        }
        field(50200; "Authorization Required"; Boolean)
        {
            Caption = 'Authorization Required';
            Description = 'EBT HOTFIX';
        }
        field(50201; "Credit Card No. 1"; Code[20])
        {
            Caption = 'Credit Card No.';
            Description = 'EBT HOTFIX';
            //Azhar Pending TableRelation = "DO Payment Credit Card" WHERE ("Customer No."=FIELD("Bill-to Customer No."));

            trigger OnValidate()
            var

            begin
            end;
        }
        field(50203; "Distance in kms"; Decimal)
        {
            Description = 'AKT_EWB';
            Editable = false;
        }
        field(50215; "Transporter Code"; Code[10])
        {
            Description = 'RSPL-AR-EWB';
            TableRelation = Transporter;
        }
        // field(50217; "QR code"; BLOB)
        // {
        //     Description = 'RSPL-AD-EWB';
        // }
        field(50218; "IRN Ack. Date"; Text[20])
        {
            //     CalcFormula = Lookup("GST Ledger Entry"."IRN Ack. Date" WHERE ("Transaction Type"=CONST('Sales'),
            //                                                                    "Document No."=FIELD("No."),
            //                                                                    "Document Type"=CONST('Invoice')));Azhar pending
            Description = 'DJ_EINV';
            //FieldClass = FlowField;
        }
        field(59993; "Local Expected TPT Cost"; Decimal)
        {
            Description = 'EBT STIVAN 31072013';
        }
        field(59994; "Expected TPT Cost"; Decimal)
        {
            Description = 'EBT STIVAN 22042013';
        }
        field(59995; "Road Permit No."; Code[20])
        {
            Description = 'EBT STIVAN (11-12-2012)';
        }
        field(59997; "QC Test Report Generated"; Boolean)
        {
            Description = 'EBT STIVAN (17/04/2013)-To Block Invoice Printing, IF QC report is not printed first';
        }
        field(59998; "Invoice Print Time"; Time)
        {
            Description = 'EBT STIVAN (29112012) - Invoice Printing for First Time';
        }
        field(59999; "Print Invoice"; Boolean)
        {
            Description = 'EBT STIVAN (29112012) - Invoice Printing for First Time';
        }
        field(60299; "Freight Type"; Option)
        {
            Description = 'EBT STIVAN (12-06-2013)';
            OptionCaption = ' ,PAID,TO PAY,PAY & ADD IN BILL,SELF PICKUP,Delivered';
            OptionMembers = " ",PAID,"TO PAY","PAY & ADD IN BILL","SELF PICKUP",Delivered;
        }
        field(60300; "Freight Charges"; Code[20])
        {
        }
        field(70002; "Sales Shipment No"; Code[20])
        {
            Description = 'EBT MILAN (30-07-2013)';
            TableRelation = "Sales Shipment Header"."No.";
        }
        field(70050; "Cash Discount Percentage"; Decimal)
        {
            Description = 'EBT';
        }
        field(70052; "Customer Receipt Date"; Date)
        {
            Description = 'CAS-13700-H0B6G1';
        }
        field(70057; "Salesperson Email Sent"; Boolean)
        {
            Description = 'RSPLSUM 04Feb2020';
            Editable = false;
        }
        field(70058; "EWB Transaction Type"; Option)
        {
            Description = 'RSPLSUM 19Mar2020';
            Editable = false;
            OptionCaption = ' ,Regular,Bill To - Ship To,Bill From - Dispatch From,Combination of 2 and 3';
            OptionMembers = " ",Regular,"Bill To - Ship To","Bill From - Dispatch From","Combination of 2 and 3";
        }
        field(70059; "Sales Order No"; Code[20])
        {
            Description = 'RSPLSUM-BUNKER';
            Editable = false;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER('Order'));
        }
        field(70061; "EWB No."; Code[20])
        {
            //     CalcFormula = Lookup("GST Ledger Entry"."E-Way Bill No." WHERE ("Transaction Type"=CONST('Sales'),
            //                                                                     "Document No."=FIELD("No."),
            //                                                                     "Document Type"=CONST('Invoice')));Azhar Pending
            Description = 'RSPLSUM 30Jul2020';
            Editable = false;
            //FieldClass = FlowField;
        }
        field(70062; "EWB Date"; Date)
        {
            CalcFormula = Lookup("Detailed E-Way Bill"."EWB Creation date" WHERE("Document No." = FIELD("No."),
                                                                                  Cancelled = CONST(false)));
            Description = 'RSPLSUM 30Jul2020';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70063; "Mintifi Channel Finance"; Option)
        {
            Description = 'RSPLSUM 11Aug2020';
            Editable = false;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(70064; IRN; Text[250])
        {
            //     CalcFormula = Lookup("GST Ledger Entry"."E-Inv Irn" WHERE("Transaction Type" = CONST('Sales'),
            //                                                                "Document No." = FIELD("No."),
            //                                                                "Document Type" = CONST(Invoice)));Azhar Pending
            Description = 'RSPLSID 01Sept2020';
            Editable = false;
            // FieldClass = FlowField;
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