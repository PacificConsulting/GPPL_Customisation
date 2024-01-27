tableextension 50012 SalesHDRExtCutm extends 36
{
    fields
    {
        field(50001; "Full Name"; Text[100])
        {
            Description = 'EBT/CUST/0001, RSPLSUM 28Jun2020 length changed from 60 to 100';
        }
        field(50002; "Customer Type"; Option)
        {
            Description = 'EBT/CUST/0001';
            OptionCaption = 'Customer,Distributor';
            OptionMembers = Customer,Distributor;
        }
        field(50003; "Short Close"; Boolean)
        {
            Description = 'EBT/SHORTCLOSE/0001';
            Editable = true;

            trigger OnValidate()
            var
                SL02: Record 37;
                PostingNoBlankErr: Label 'You cannot short close order as Posting No is already assigned. Please contact with administrator.';
                ReservEntr: Record 337;
            //recDetailRG23D: Record 16533;
            begin
                //DJ 28885
                IF ("Posting No." <> '') AND ("Document Type" = "Document Type"::Order) THEN
                    ERROR(PostingNoBlankErr);
                //DJ 28885

                //EBT/SHORTCLOSE/0001
                IF "Short Close" = TRUE THEN BEGIN
                    "Short Close Date" := TODAY;
                    MODIFY;
                END
                ELSE
                    IF "Short Close" = FALSE THEN BEGIN
                        "Short Close Date" := 0D;
                        MODIFY;
                    END;
                //EBT/SHORTCLOSE/0001

                //RSPLSUM 11May2020>>
                SL02.RESET;
                SL02.SETRANGE("Document Type", "Document Type");
                SL02.SETRANGE("Document No.", "No.");
                //SL02.SETRANGE(Type,SL02.Type::Item);
                IF SL02.FINDFIRST THEN
                    SL02.MODIFYALL("Short Close", "Short Close");
                //RSPLSUM 11May2020<<

                //EBT STIVAN---(04/12/2012)---To Delete the Reservation Entry for Manual Short Closed CSO -----START
                ReservEntr.RESET;
                ReservEntr.SETRANGE(ReservEntr."Source ID", "No.");
                IF ReservEntr.FINDSET THEN
                    ReservEntr.DELETEALL;
                //EBT STIVAN---(04/12/2012)---To Delete the Reservation Entry for Manual Short Closed CSO -------END


                //EBT STIVAN---(20032012)--- To Delete Detail RG 23 D Table for Manual Short Closed CSO------------------START
                /*
                recDetailRG23D.RESET;
                recDetailRG23D.SETRANGE(recDetailRG23D."Document Type", recDetailRG23D."Document Type"::Order);
                recDetailRG23D.SETRANGE(recDetailRG23D."Order No.", "No.");
                recDetailRG23D.SETFILTER(recDetailRG23D."Document No.", '%1', '');
                IF recDetailRG23D.FINDSET THEN
                    recDetailRG23D.DELETEALL;
                    */
                //EBT STIVAN---(20032012)--- To Delete Detail RG 23 D Table for Manual Short Closed CSO--------------------END
            end;
        }
        field(50004; "Short Close Date"; Date)
        {
            Description = 'EBT/SHORTCLOSE/0001';
            Editable = false;
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
        field(50011; "Cust. Overdue Balance"; Boolean)
        {
            Description = 'EBT/OVERDUE/APV/0001';
        }
        field(50013; "Cr. Approved"; Boolean)
        {
            Description = 'EBT/OVERDUE/APV/0001';
            Editable = true;
        }
        field(50014; "Sent For Approval"; Boolean)
        {
            Description = 'EBT/OVERDUE/APV/0001';
        }
        field(50015; "Required MD Approval"; Boolean)
        {
            Description = 'EBT/OVERDUE/APV/0001';
        }
        field(50025; "Driver's Name"; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50026; "Driver's License No."; Code[20])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50027; "Driver's Mobile No."; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50028; "Vehicle Capacity"; Code[10])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
            TableRelation = "Vehicle Capacity".Code;

            trigger OnValidate()
            begin
                "Vehicle Capacity" := UPPERCASE("Vehicle Capacity");
            end;
        }
        field(50029; "Vehicle For Location"; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha, RSPLSUM 28Jun2020 field disabled and incorporated in Full Name';
            Enabled = false;
        }
        field(50030; "Transport Type"; Option)
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
            OptionCaption = ' ,Intercity,Local+Intercity,Cust.Transport';
            OptionMembers = " ",Intercity,"Local+Intercity","Cust.Transport";
        }
        field(50031; "Local Driver's Name"; Text[10])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha,RSPLSUM28902 length changed from 30 to 10';
        }
        field(50032; "Local Driver's License No."; Code[20])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50033; "Local Driver's Mobile No."; Text[30])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50034; "Local Vehicle Capacity"; Code[20])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
            TableRelation = "Vehicle Capacity".Code;

            trigger OnValidate()
            begin
                "Local Vehicle Capacity" := UPPERCASE("Local Vehicle Capacity");
            end;
        }
        field(50035; "Local Vehicle for Location"; Text[10])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha,RSPLSUM 11May2020 length changed from 30 to 10, RSPLSUM 28Jun2020 field disabled and incorporated in Full Name';
            Enabled = false;
        }
        field(50036; "Local Vehicle No."; Text[15])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';

            trigger OnValidate()
            begin
                "Local Vehicle No." := UPPERCASE("Local Vehicle No.");//EBT STIVAN---(24/07/2013)
            end;
        }
        field(50037; "Local LR No."; Code[20])
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50038; "Local LR Date"; Date)
        {
            Description = 'EBT/LOCALINTERCITY/0001 -Pratyusha';
        }
        field(50050; "Created By"; Code[50])
        {
            Description = '//EBT/APV/0001';
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


                IF "CT3 Order" THEN BEGIN
                    SalesSetup.GET;
                    SalesSetup.TESTFIELD(SalesSetup."CT3 Excise Bus. Posting Group");
                    //IF "Excise Bus. Posting Group" <> SalesSetup."CT3 Excise Bus. Posting Group" THEN
                    //VALIDATE("Excise Bus. Posting Group", SalesSetup."CT3 Excise Bus. Posting Group");
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
        field(50125; "Ship-to State Code"; Code[10])
        {
            Description = 'EBT STIVAN 18102012';
        }
        field(50130; FOC; Boolean)
        {
            Description = 'RSPL/CUST/FOC/RET001';

            trigger OnValidate()
            begin
                TESTFIELD("Document Type", "Document Type"::"Return Order");//RSPL/CUST/FOC/RET001
            end;
        }
        field(50131; "Ex-Factory"; Text[20])
        {
            Description = 'RSPL/Rahul';
        }
        field(50150; "Under Rebate"; Boolean)
        {
        }
        field(50151; "Under LUT"; Boolean)
        {
            Editable = true;
        }
        field(50152; "Export Under Rebate"; Text[20])
        {
        }
        field(50153; "Export Under LUT"; Text[20])
        {
        }
        field(50170; "Credit Limit Approval"; Option)
        {
            Description = 'RSPL022 - Credit Limit Approval';
            Editable = true;
            OptionCaption = 'Open,Pending for C Form Approval,Approved C Form,Pending For Over Due Approval,Approved Over Due,Pending for Credit Approval,Approved Credit Limit,Approved,Credit Rejected,Over Due Rejected';
            OptionMembers = Open,"Pending for C Form Approval","Approved C Form","Pending For Over Due Approval","Approved Over Due","Pending for Credit Approval","Approved Credit Limit",Approved,"Credit Rejected","Over Due Rejected";
        }
        field(50171; "Credit Approval"; Boolean)
        {
            Description = 'IPOL/OVERDUE/01';
        }
        field(50172; "Over Due Approval"; Boolean)
        {
            Description = 'IPOL/OVERDUE/01';
        }
        field(50173; "C Form Approval"; Boolean)
        {
            Description = 'IPOL/OVERDUE/01';
            Enabled = false;
        }
        field(50174; "Bank Account No."; Code[20])
        {
            Description = '17July2017 RB-N - RSPLSUM-BUNKER 28May2020 Data type changed from text to code';
            TableRelation = "Bank Account"."No.";
        }
        field(50175; "Loading Port Name"; Option)
        {
            Description = '20Sep2017 RB-N';
            OptionCaption = ' ,NHAVA SHEVA SEA (INNSA1),BY ROAD';
            OptionMembers = " ","NHAVA SHEVA SEA (INNSA1)","BY ROAD";
        }
        field(50176; "Credit Approval Rejection"; Boolean)
        {
            Description = '03Jul2018 RB-N';
        }
        field(50177; "OverDue Approval Rejection"; Boolean)
        {
            Description = '03Jul2018 RB-N';
        }
        field(50178; "Date GP"; Date)
        {
            Description = '05Jul2018 RB-N';
            Editable = false;
        }
        field(50179; "Credit / OverDue Remarks"; Text[30])
        {
            Description = '09Jul2018 RB-N';
        }
        field(50180; "Debit Memo"; Boolean)
        {
            Description = '11Apr2019 RB-N';
        }
        field(50181; "Get Entry Outward"; Code[20])
        {
            Description = 'NB28902';
            //TableRelation = "Gate Entry Header"."No.";Azhar Pending

            trigger OnValidate()
            begin
                /*//NB28902 Start
                GateEntryHeader.RESET;
                GateEntryHeader.SETRANGE(GateEntryHeader."No.","Get Entry Outward");
                IF GateEntryHeader.FINDFIRST THEN BEGIN
                  "Driver's Name":= GateEntryHeader."Driver's Name";
                  "Driver's License No.":= GateEntryHeader."Driver's License No.";
                  "Vehicle No.":= GateEntryHeader."Vehicle No.";
                  "Vehicle Capacity":= GateEntryHeader."Vehicle Capacity";
                END;
                //NB28902 end*/

                //RSPLSUM28902>>
                IF "Get Entry Outward" = '' THEN BEGIN
                    VALIDATE("Driver's Name", '');
                    VALIDATE("Driver's License No.", '');
                    //VALIDATE("Vehicle No.", '');
                    VALIDATE("Vehicle Capacity", '');
                END;
                //RSPLSUM28902<<

            end;
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
                IF (("EWB Transaction Type" <> "EWB Transaction Type"::"Combination of 2 and 3") AND ("EWB Transaction Type" <> "EWB Transaction Type"::"Bill From - Dispatch From")) THEN
                    ERROR(text00012, "EWB Transaction Type");
                //RSPLAM30595
            end;
        }
        field(50183; "Customer Kms"; Integer)
        {
            Description = 'AM32612';
        }
        field(50203; "Distance in kms"; Decimal)
        {
            Description = 'AKT_EWB';
        }
        field(50215; "Transporter Code"; Code[10])
        {
            Description = 'RSPL-AR-EWB';
            TableRelation = Transporter;
        }
        field(50351; "RWR Salesperson"; Code[10])
        {
            Description = 'YSR30847';
            Editable = true;
            TableRelation = "Salesperson/Purchaser".Code WHERE("RWR Parent" = CONST(false),
            "Parent RWR Code" = FIELD("Salesperson Code"));


            trigger OnValidate()
            var
                SalespersonPurchaser: Record 13;
            begin
                IF SalespersonPurchaser.GET("Salesperson Code") THEN BEGIN
                    IF NOT SalespersonPurchaser."RWR Parent" THEN
                        ERROR('');
                END;
            end;
        }
        field(59993; "Local Expected TPT Cost"; Decimal)
        {
            Description = 'EBT STIVAN 31072013';
        }
        field(59994; "Expected TPT Cost"; Decimal)
        {
            Description = 'EBT STIVAN 21062013';
        }
        field(59995; "Road Permit No."; Code[20])
        {
            Description = 'EBT STIVAN (11-12-2012)';
        }
        field(60000; "Last Year Sales Return"; Boolean)
        {
            Description = 'EBT0002';
        }
        field(60299; "Freight Type"; Option)
        {
            Description = 'EBT STIVAN (12-06-2013)';
            OptionCaption = ' ,PAID,TO PAY,PAY & ADD IN BILL,SELF PICKUP,DELIVERED';
            OptionMembers = " ",PAID,"TO PAY","PAY & ADD IN BILL","SELF PICKUP",DELIVERED;

            trigger OnLookup()
            var
                recCustomer: Record Customer;
            //recStructureOrderDetails: Record 13794;
            begin
                //RSPLAM32612 ++
                IF recCustomer.GET("Sell-to Customer No.") THEN;
                IF recCustomer."Transport Subsidy Applicable" THEN BEGIN
                    IF (xRec."Freight Type" = xRec."Freight Type"::"TO PAY") OR (xRec."Freight Type" = xRec."Freight Type"::"SELF PICKUP") THEN BEGIN
                        /*
                           recStructureOrderDetails.RESET;
                           recStructureOrderDetails.SETRANGE(Type, recStructureOrderDetails.Type::Sale);
                           recStructureOrderDetails.SETRANGE("Document Type", "Document Type");
                           recStructureOrderDetails.SETRANGE("Document No.", "No.");
                           recStructureOrderDetails.SETRANGE("Document Line No.", 0);
                           recStructureOrderDetails.SETRANGE("Structure Code", Structure);
                           recStructureOrderDetails.SETRANGE("Tax/Charge Type", recStructureOrderDetails."Tax/Charge Type"::Charges);
                           recStructureOrderDetails.SETRANGE("Tax/Charge Group", 'TRANSSUBS');
                           recStructureOrderDetails.SETFILTER("Calculation Value", '<>%1', 0);
                           IF recStructureOrderDetails.FINDSET THEN
                               ERROR('The Structure Transfer Subsidy Calculation Value must be zero current value is %1', recStructureOrderDetails."Calculation Value");
                      */
                    END;
                END;
                //RSPLAM32612 --
            end;

            trigger OnValidate()
            var
                recCustomer: Record Customer;
            begin
                //RSPLAM32612 ++
                IF recCustomer.GET("Sell-to Customer No.") THEN;
                IF recCustomer."Transport Subsidy Applicable" THEN BEGIN
                    IF (xRec."Freight Type" = xRec."Freight Type"::"TO PAY") OR (xRec."Freight Type" = xRec."Freight Type"::"SELF PICKUP") THEN BEGIN
                        /*
                        recStructureOrderDetails.RESET;
                        recStructureOrderDetails.SETRANGE(Type, recStructureOrderDetails.Type::Sale);
                        recStructureOrderDetails.SETRANGE("Document Type", "Document Type");
                        recStructureOrderDetails.SETRANGE("Document No.", "No.");
                        recStructureOrderDetails.SETRANGE("Document Line No.", 0);
                        recStructureOrderDetails.SETRANGE("Structure Code", Structure);
                        recStructureOrderDetails.SETRANGE("Tax/Charge Type", recStructureOrderDetails."Tax/Charge Type"::Charges);
                        recStructureOrderDetails.SETRANGE("Tax/Charge Group", 'TRANSSUBS');
                        recStructureOrderDetails.SETFILTER("Calculation Value", '<>%1', 0);
                        IF recStructureOrderDetails.FINDSET THEN
                            ERROR('The Structure Transfer Subsidy Calculation Value must be zero current value is %1', recStructureOrderDetails."Calculation Value");
                    */
                    END;
                END;
                //RSPLAM32612 --
            end;
        }
        field(60300; "Freight Charges"; Code[20])
        {
        }
        field(60301; "Sales Order Type"; Option)
        {
            OptionCaption = 'Actual,Dummy';
            OptionMembers = Actual,Dummy;
        }
        field(60302; "Created Date"; Date)
        {
            Description = 'EBT STIVAN (22/07/2013)';
        }
        field(70000; "Approval Description"; Text[50])
        {
        }
        field(70001; "Supply Location Name"; Text[50])
        {
            Description = 'EBT STIVAN';
        }
        field(70050; "Cash Discount Percentage"; Decimal)
        {
            Description = 'EBT';
        }
        field(70051; "Dicounts/Incentive"; Boolean)
        {
        }
        field(70053; Quantity; Decimal)
        {
            CalcFormula = Sum("Sales Line".Quantity WHERE("Document No." = FIELD("No.")));
            DecimalPlaces = 0 : 5;
            Description = 'RSPLSUM 17Jul2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70054; "Quantity Shipped"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Quantity Shipped" WHERE("Document No." = FIELD("No.")));
            DecimalPlaces = 0 : 5;
            Description = 'RSPLSUM 17Jul2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70055; "Quantity Invoiced"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Quantity Invoiced" WHERE("Document No." = FIELD("No.")));
            DecimalPlaces = 0 : 5;
            Description = 'RSPLSUM 17Jul2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70056; "Expected Loading"; Decimal)
        {
            Description = 'RSPLSUM';
        }
        field(70058; "EWB Transaction Type"; Option)
        {
            Description = 'RSPLSUM 19Mar2020';
            OptionCaption = ' ,Regular,Bill To - Ship To,Bill From - Dispatch From,Combination of 2 and 3';
            OptionMembers = " ",Regular,"Bill To - Ship To","Bill From - Dispatch From","Combination of 2 and 3";
        }
        field(70059; "Sales Order No"; Code[20])
        {
            Description = 'RSPLSUM-BUNKER';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order));
        }
        field(70060; "Credit Checking Not Required"; Boolean)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(70063; "Mintifi Channel Finance"; Option)
        {
            Description = 'RSPLSUM 11Aug2020';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(70064; "Amount to Customer"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Amount To Customer" WHERE("Document Type" = FIELD("Document Type"),
                                                                       "Document No." = FIELD("No.")));
            Caption = 'Amount to Customer';
            Editable = false;
            FieldClass = FlowField;
        }
        modify("Requested Delivery Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //EBT STIVAN---(28/02/2013)---Error Message Pop UP, Requested Delivery Date < Sales Order Date(Doc Date)------START
                IF "Requested Delivery Date" <> 0D THEN
                    IF "Requested Delivery Date" < "Document Date" THEN BEGIN
                        ERROR('Requested Delivery Date should not be Lesser then Sales Order Date');
                    END;
                //EBT STIVAN---(28/02/2013)---Error Message Pop UP, Requested Delivery Date < Sales Order Date(Doc Date)--------END
            end;
        }
        modify("Responsibility Center")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //EBT STIVAN ---(30072012)--- To capture the Posting No Series as per Resp. Center For Sales Credit Memo------START
                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN

                    recNoSeriesRelationship.RESET;
                    recNoSeriesRelationship.SETRANGE(recNoSeriesRelationship.Code, 'PCR MEMO');
                    recNoSeriesRelationship.SETRANGE(recNoSeriesRelationship."Document Type",
                                                     recNoSeriesRelationship."Document Type"::"Sale Credit Note");
                    recNoSeriesRelationship.SETFILTER(recNoSeriesRelationship."Resp.Ctr.Filter", "Responsibility Center");
                    IF recNoSeriesRelationship.FINDFIRST THEN
                        seriesCode := recNoSeriesRelationship."Series Code";

                    "Posting No. Series" := seriesCode;

                    IF "Responsibility Center" = '' THEN BEGIN
                        "Posting No. Series" := ''
                    END;
                END;
                //EBT STIVAN ---(30072012)--- To capture the Posting No Series as per Resp. Center For Sales Credit Memo--------END
            end;
        }
        modify(Status)
        {
            trigger OnAfterValidate()
            var
                PaymentMethod: Record "Payment Method";
                SaleslineTable: Record "Sales Line";
            begin
                //RSPLSUM 11May2020>>
                "Credit Checking Not Required" := FALSE;
                IF PaymentMethod.GET("Payment Method Code") THEN
                    IF PaymentMethod."Credit Checking Not Required" THEN
                        "Credit Checking Not Required" := TRUE
                    ELSE
                        "Credit Checking Not Required" := FALSE;

                SaleslineTable.RESET;
                SaleslineTable.SETRANGE("Document Type", "Document Type");
                SaleslineTable.SETRANGE("Document No.", "No.");
                IF SaleslineTable.FINDFIRST THEN
                    REPEAT
                        SaleslineTable.Status := Rec.Status;
                        IF PaymentMethod.GET("Payment Method Code") THEN BEGIN
                            IF PaymentMethod."Credit Checking Not Required" THEN BEGIN
                                SaleslineTable."Credit Checking Not Required" := TRUE;
                                "Credit Checking Not Required" := TRUE;
                            END ELSE BEGIN
                                SaleslineTable."Credit Checking Not Required" := FALSE;
                                "Credit Checking Not Required" := FALSE;
                            END;
                        END;
                        SaleslineTable.MODIFY
                    UNTIL SaleslineTable.NEXT = 0;

                /*IF Status=Status::Open THEN
                BEGIN
                   OCL:=FALSE;
                   "Credit Limit Approval Status":= "Credit Limit Approval Status"::Open;
                END;*/
                //RSPLSUM 11May2020<<
            end;
        }

        modify("Applies-to Doc. No.")
        {
            trigger OnAfterValidate()
            var
                recSIH: Record "Sales Invoice Header";
                AppliedDocDate: Date;
                SROMonthName: Text[30];
                InvMonthName: Text[30];
                Confirmed: Boolean;
            begin
                //EBT STIVAN ---(19072012)--- To Capture the Applies to Invoice Details of Shipping TAB ----START
                IF ("Document Type" = "Document Type"::"Return Order") THEN BEGIN
                    recSIH.RESET;
                    recSIH.SETRANGE(recSIH."No.", "Applies-to Doc. No.");
                    IF recSIH.FINDFIRST THEN BEGIN
                        VALIDATE("Location Code", recSIH."Location Code");
                        "Ship-to Code" := recSIH."Ship-to Code";
                        "Ship-to Name" := recSIH."Ship-to Name";
                        "Ship-to Name 2" := recSIH."Ship-to Name 2";
                        "Ship-to Address" := recSIH."Ship-to Address";
                        "Ship-to Address 2" := recSIH."Ship-to Address 2";
                        "Ship-to City" := recSIH."Ship-to City";
                        "Ship-to Contact" := recSIH."Ship-to Contact";
                        "Ship-to County" := recSIH."Ship-to County";
                        "Ship-to Post Code" := recSIH."Ship-to Post Code";

                        Rec.MODIFY;
                    END;
                END;
                //EBT STIVAN ---(19072012)--- To Capture the Applies to Invoice Details of Shipping TAB ------END
                //EBT STIIVAN---(28032013)---Dialog Box Pop UP on SRO whether the Invoice is Cancelled---START
                recSIH.RESET;
                recSIH.SETRANGE(recSIH."No.", "Applies-to Doc. No.");
                IF recSIH.FINDFIRST THEN BEGIN
                    AppliedDocDate := recSIH."Posting Date";
                END;

                SROMonthName := FORMAT("Posting Date", 0, '<Month Text> <Year4>');
                InvMonthName := FORMAT(AppliedDocDate, 0, '<Month Text> <Year4>');


                IF TODAY <> AppliedDocDate THEN BEGIN
                    IF HideValidationDialog OR NOT GUIALLOWED THEN
                        Confirmed := TRUE
                    ELSE
                        Confirmed := CONFIRM('Is it Cancel Invoice ?', FALSE);


                    IF (Confirmed) AND (SROMonthName = InvMonthName) THEN BEGIN
                        "Cancelled Invoice" := TRUE;
                        "Posting No. Series" := 'CINV SALE';
                        MODIFY;
                    END;

                    IF (Confirmed) AND NOT (SROMonthName = InvMonthName) THEN BEGIN
                        "Cancelled Invoice" := FALSE;
                        MESSAGE('You can not Cancel the Invoice which is not of the same month');
                    END;

                    IF NOT Confirmed THEN BEGIN
                        "Cancelled Invoice" := FALSE;
                    END;

                END;
                //EBT STIIVAN---(28032013)---Dialog Box Pop UP on SRO whether the Invoice is Cancelled-----END
            end;
        }
        modify("Ship-to Code")
        {
            trigger OnAfterValidate()
            var
                Cust03: Record Customer;
                TempCode18: Code[10];
                SHAdd: Record 222;
            begin
                //>>07July2017 ShiptoAdd GSTRegistrationNO Validation
                IF "Document Type" = "Document Type"::Order THEN BEGIN

                    Cust03.RESET;
                    IF Cust03.GET("Sell-to Customer No.") THEN
                        IF Cust03."Customer Posting Group" <> 'FOREIGN' THEN //10July2017
                        BEGIN
                            IF "Ship-to Code" <> '' THEN
                                TempCode18 := "Ship-to Code";

                            IF TempCode18 <> '' THEN BEGIN

                                IF "Sell-to Customer No." <> 'C15574' THEN BEGIN
                                    SHAdd.RESET;
                                    SHAdd.SETRANGE("Customer No.", "Sell-to Customer No.");
                                    SHAdd.SETRANGE(Code, TempCode18);
                                    IF SHAdd.FINDFIRST THEN BEGIN
                                        IF SHAdd."GST Customer Type" <> SHAdd."GST Customer Type"::Unregistered THEN //20Oct2019
                                            IF SHAdd."GST Registration No." = '' THEN
                                                ERROR('Please update GST Regisration Shipping Address');
                                    END;
                                END;
                            END;
                        END;
                END;
                //<<07July2017 ShiptoAdd GSTRegistrationNO Validation
                //EBT STIVAN ---(18102012)--- To Update Ship To state Code--------------START
                "Ship-to State Code" := SHAdd.State;
                //EBT STIVAN ---(18102012)--- To Update Ship To state Code----------------END
                "GST Customer Type" := SHAdd."GST Customer Type";//20Oct2019
            end;
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                EBTlocation: Record Location;
                LocToCheckLUT: Record Location;
                LocRec: Record Location;
            begin
                EBTlocation.RESET;
                EBTlocation.SETRANGE(EBTlocation.Code, "Location Code");
                EBTlocation.SETRANGE(EBTlocation.Closed, TRUE);
                IF EBTlocation.FINDFIRST THEN BEGIN
                    ERROR('You are not allowed the select this Location as it is Closed');
                END;

                //RSPLSUM28742


                IF Rec."Location Code" <> '' THEN BEGIN
                    IF ("GST Customer Type" = "GST Customer Type"::Export) OR ("GST Customer Type" = "GST Customer Type"::"Deemed Export") THEN BEGIN
                        LocToCheckLUT.RESET;
                        IF LocToCheckLUT.GET("Location Code") THEN
                            LocToCheckLUT.TESTFIELD("LUT Registration No.");
                    END;
                END;
                //RSPLSUM28742

                //Start DJ_EWB 13/03/20 Calculate Distance in KM for Eway Bill
                // IF ("Location Code" <> '') AND ("Ship-to Post Code" <> '') THEN BEGIN
                //     LocRec.GET("Location Code");
                //     IF LocRec."Post Code" <> '' THEN BEGIN
                //         "Distance in kms" := CUEwayAPI.DistanceMatrix(LocRec."Post Code", "Ship-to Post Code");
                //         //"Distance in kms" := CUEwayAPI.GetDistanceInKM(LocRec."Post Code","Ship-to Post Code",DistanceAPIKey);
                //     END;
                // END;
                // DJ_EWB 13/03/20 END Calculate Distance in KM for Eway Bill
            end;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                EBTlocation: Record Location;
                RecCust: Record Customer;
                Cust03: Record Customer;
                CustRec: Record Customer;
                LocRec: Record Location;
            begin
                EBTlocation.RESET;
                EBTlocation.SETRANGE(EBTlocation.Code, "Location Code");
                EBTlocation.SETRANGE(EBTlocation.Closed, TRUE);
                IF EBTlocation.FINDFIRST THEN BEGIN
                    Rec.Validate("Location Code", '');
                END;

                RecCust.Reset();
                RecCust.SetRange("No.", Rec."Sell-to Customer No.");
                if RecCust.FindFirst() then begin
                    if RecCust."KYC Approval Status" <> RecCust."KYC Approval Status"::Approved then begin

                        Error('Customer KYC Not Approved %1');
                    end;
                    Rec.Validate("Full Name", RecCust."Full Name");
                    rec.Validate("Customer Type", RecCust.Type);
                    Rec.Validate("Customer Kms", RecCust."Customer Kms");
                    Rec.Validate("Freight Type", RecCust."Freight Type");
                end else begin
                    Rec.Validate("Full Name", '');
                    Rec.Validate("Customer Kms", 0);
                end;

                //>>03July2017 CAS-17171-M7F1W8
                IF "Document Type" = "Document Type"::Order THEN //06July2017
                BEGIN
                    Cust03.RESET;
                    IF Cust03.GET("Sell-to Customer No.") THEN
                        IF Cust03."Customer Posting Group" <> 'FOREIGN' THEN //10July2017
                        BEGIN
                            IF Cust03."GST Customer Type" = Cust03."GST Customer Type"::" " THEN
                                ERROR('Please update the Customer master with GST Customer Type');

                        END;
                END;
                //<<03July2017 CAS-17171-M7F1W8

                //EBT STIVAN ---(09072012)--- To make Payment Terms Code Mandatory -------START
                CustRec.RESET;
                CustRec.SETRANGE(CustRec."No.", "Sell-to Customer No.");
                IF CustRec.FINDFIRST THEN
                    IF "Payment Terms Code" = '' THEN
                        ERROR('Payment Terms code for This Customer %1 is not defined.', "Sell-to Customer No.");
                //EBT STIVAN ---(09072012)--- To make Payment Terms Code Mandatory ---------END


                //EBT STIVAN ---(30072012)--- To capture the Posting No Series as per Customer Resp. Center For Sales Credit Memo------START
                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN

                    "Responsibility Center" := CustRec."Responsibility Center";

                    recNoSeriesRelationship.RESET;
                    recNoSeriesRelationship.SETRANGE(recNoSeriesRelationship.Code, 'PCR MEMO');
                    recNoSeriesRelationship.SETRANGE(recNoSeriesRelationship."Document Type",
                                                     recNoSeriesRelationship."Document Type"::"Sale Credit Note");
                    recNoSeriesRelationship.SETFILTER(recNoSeriesRelationship."Resp.Ctr.Filter", "Responsibility Center");
                    IF recNoSeriesRelationship.FINDFIRST THEN
                        seriesCode := recNoSeriesRelationship."Series Code";

                    "Posting No. Series" := seriesCode;

                END;
                //EBT STIVAN ---(30072012)--- To capture the Posting No Series as per Customer Resp. Center For Sales Credit Memo--------END

                //EBT STIVAN ---(03092012)--- To capture the Posting No Series as per Customer Resp. Center For Sales Debit Memo--------START
                IF ("Document Type" = "Document Type"::Invoice) AND ("Supplimentary Invoice" = FALSE) THEN BEGIN

                    "Responsibility Center" := CustRec."Responsibility Center";

                    recNoSeriesRelationship.RESET;
                    recNoSeriesRelationship.SETRANGE(recNoSeriesRelationship.Code, 'SALEINV');
                    recNoSeriesRelationship.SETRANGE(recNoSeriesRelationship."Document Type",
                                                     recNoSeriesRelationship."Document Type"::"Sale Debit Memo");
                    recNoSeriesRelationship.SETFILTER(recNoSeriesRelationship."Resp.Ctr.Filter", "Responsibility Center");
                    IF recNoSeriesRelationship.FINDFIRST THEN
                        seriesCode := recNoSeriesRelationship."Series Code";

                    "Posting No. Series" := seriesCode;

                END;

                //EBT STIVAN ---(03092012)--- To capture the Posting No Series as per Customer Resp. Center For Sales Debit Memo----------END

                //EBT STIVAN ---(30072012)--- To Insert Dimension Code for Industrial without Dimension Value Code-------START
                /*
                IF "Shortcut Dimension 1 Code" = 'DIV-03' THEN
                BEGIN
                InsertDimensionValue;
                END;
                *///As per UNI SIR 21July2017
                  //EBT STIVAN ---(30072012)--- To Insert Dimension Code for Industrial without Dimension Value Code---------END
                if RecLocation.Get("Location Code") then
                    IF RecLocation.Closed THEN BEGIN
                        "Location Code" := '';
                        //MODIFY;
                    END;

                //EBT STIVAN ---(06082012)--- To put a check mark on Last Year Sales Return Field in case of Credit Memo------START
                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    "Last Year Sales Return" := TRUE;
                    //MODIFY;
                END;
                //EBT STIVAN ---(06082012)--- To put a check mark on Last Year Sales Return Field in case of Credit Memo--------END


                //Start DJ_EWB 13/03/20 Calculate Distance in KM for Eway Bill
                // IF ("Location Code" <> '') AND ("Ship-to Post Code" <> '') THEN BEGIN
                //     LocRec.GET("Location Code");
                //     IF LocRec."Post Code" <> '' THEN BEGIN
                //         "Distance in kms" := CUEwayAPI.DistanceMatrix(LocRec."Post Code", "Ship-to Post Code");
                //         //"Distance in kms" := CUEwayAPI.GetDistanceInKM(LocRec."Post Code","Ship-to Post Code",DistanceAPIKey);
                //     END;
                // END;
                // DJ_EWB 13/03/20 END Calculate Distance in KM for Eway Bill
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
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Created By" := USERID;   //EBT/APV/0001
        "Created Date" := TODAY;
    end;

    trigger OnDelete()
    var
        AccessControl: Record "Access Control";
    begin
        //EBT STIVAN ---(21032013)--- CSO Deletion Restriction to the User------------------START
        IF (UPPERCASE(USERID) <> 'SA') AND (USERID <> 'GPUAE\UNNIKRISHNAN.VS') AND (USERID <> 'GPUAE\FAHIM.AHMAD') AND (USERID <> 'GPUAE\RAVI.KHAMBAL') THEN
            IF "Document Type" <> "Document Type"::"Credit Memo" THEN BEGIN
                ERROR('You do not permission to delete sales order');
            END;
        //EBT STIVAN ---(21032013)--- CSO Deletion Restriction to the User--------------------END

        //>>30May2019
        IF (USERID <> 'GPUAE\UNNIKRISHNAN.VS') AND (USERID <> 'GPUAE\FAHIM.AHMAD') AND (USERID <> 'GPUAE\RAVI.KHAMBAL') THEN
            IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                AccessControl.RESET;
                AccessControl.SETRANGE("User Name", USERID);
                AccessControl.SETRANGE("Role ID", 'CMDEL');
                IF NOT AccessControl.FINDFIRST THEN
                    ERROR('You do not permission to delete Sales Credit Memo')
            END;

        //<<30May2019
    end;

    trigger OnBeforeInsert()
    var
        UserSetup: Record "User Setup";
    begin
        //EBT0001
        //IF NOT(( "Document Type" = "Document Type" :: "Credit Memo") OR
        //      (("Document Type" = "Document Type" :: Invoice) AND ("Supplimentary Invoice" = FALSE)))THEN
        IF ("Document Type" = "Document Type"::Order) THEN BEGIN
            IF (UPPERCASE(USERID) <> 'SA') THEN BEGIN
                UserSetup.GET(USERID);
                IF UserSetup."Sales Resp. Ctr. Filter" = '' THEN
                    ERROR('You cannot create any Sales Order');
            END;
        END;
        //EBT0001

        IF "No." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", "Posting Date", "No.", "No. Series");
        END;
        //EBT/SOTYPE/0001
    end;

    var
        myInt: Integer;
        recNoSeriesRelationship: Record 310;
        RecLocation: Record Location;
        seriesCode: Code[10];

    PROCEDURE TesfieldRWRSalesPerson();
    VAR
        SalespersonPurchaser: Record 13;
        recCustomer: Record 18;
    BEGIN
        //YSR30847  --
        IF SalespersonPurchaser.GET("Salesperson Code") THEN
            //IF  SalespersonPurchaser."RWR Parent" THEN
            IF recCustomer.GET("Sell-to Customer No.") THEN BEGIN
                IF (recCustomer."RWR Salesperson" <> '') AND ("RWR Salesperson" = '') THEN
                    TESTFIELD("RWR Salesperson");
            END;
        //YSR30847  ++
    END;

    PROCEDURE MRPUpdationforInd();
    VAR
        recCustomer: Record 18;
    BEGIN
        //ST32289 BEGIN
        recCustomer.GET("Bill-to Customer No.");
        IF recCustomer."National Discount Applicable" THEN
            EXIT;
        //ST32289 END
    end;
}