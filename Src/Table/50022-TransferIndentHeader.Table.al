table 50022 "Transfer Indent Header"
{
    LookupPageID = 50043;

    fields
    {
        field(1; "No."; Code[30])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                /*
                IF "No." <> xRec."No." THEN BEGIN
                    GetInventorySetup;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    //NoSeriesMgt.GetNextNo(GetNoSeriesCode,WORKDATE,TRUE);
                    "No. Series" := '';
                END;
                */
            end;
        }
        field(2; "Transfer-from Code"; Code[10])
        {
            Caption = 'Transfer-from Code';
            // TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
            //                                 "Subcontracting Location" = CONST(false),
            //                                 Closed = CONST(No));

            trigger OnValidate()
            var
                Location: Record 14;
                Confirmed: Boolean;
            begin
                TESTFIELD(Status, Status::Open);

                //EBT STIVAN---(07/08/2013)---To Check For Role Before Changing Transfer From Code of Approved Indent---START
                IF (Approve) AND ("Transfer-from Code" <> '') AND ("Transfer-to Code" <> '') THEN BEGIN
                    /*  //RSPL-TC
                  Memberof.RESET;
                  Memberof.SETRANGE(Memberof."User ID",USERID);
                  Memberof.SETRANGE(Memberof."Role ID",'TROCREATION');
                  IF NOT(Memberof.FINDFIRST) THEN */
                    //RSPL-TC +
                    AccessControl.RESET;
                    AccessControl.SETRANGE("User Name", USERID);
                    AccessControl.SETRANGE("Role ID", 'TROCREATION');
                    IF NOT (AccessControl.FINDFIRST) THEN //RSPL-TC -
                   BEGIN
                        ERROR('You are not Authorised to Change');
                    END;

                END;
                //EBT STIVAN---(07/08/2013)---To Check For Role Before Changing Transfer From Code of Approved Indent-----END

                IF ("Transfer-from Code" = "Transfer-to Code") AND
                   ("Transfer-from Code" <> '')
                THEN
                    ERROR(
                      Text001,
                      FIELDCAPTION("Transfer-from Code"), FIELDCAPTION("Transfer-to Code"),
                      TABLECAPTION, "No.");
                IF (xRec."Transfer-from Code" <> "Transfer-from Code") THEN BEGIN
                    IF HideValidationDialog OR
                      (xRec."Transfer-from Code" = '')
                    THEN
                        Confirmed := TRUE
                    ELSE
                        Confirmed := CONFIRM(Text002, FALSE, FIELDCAPTION("Transfer-from Code"));
                    IF Confirmed THEN BEGIN
                        IF Location.GET("Transfer-from Code") THEN BEGIN
                            "Transfer-from Name" := Location.Name;
                            "Transfer-from Name 2" := Location."Name 2";
                            "Transfer-from Address" := Location.Address;
                            "Transfer-from Address 2" := Location."Address 2";
                            "Transfer-from Post Code" := Location."Post Code";
                            "Transfer-from City" := Location.City;
                            "Transfer-from County" := Location.County;
                            "Trsf.-from Country/Region Code" := Location."Country/Region Code";
                            "Transfer-from Contact" := Location.Contact;
                            //"Excise Bus. Posting Group" := Location."Excise Bus. Posting Group";

                            MODIFY;
                        END;
                        UpdateTransLines(FIELDNO("Transfer-from Code"));
                    END ELSE BEGIN
                        "Transfer-from Code" := xRec."Transfer-from Code";
                        EXIT;
                    END;
                END;

                //ebt
                /*IF Location.GET("Transfer-from Code") THEN BEGIN
                   VALIDATE("Shortcut Dimension 2 Code",Location."Responsibility Center");
                END; */

            end;
        }
        field(3; "Transfer-from Name"; Text[50])
        {
            Caption = 'Transfer-from Name';
        }
        field(4; "Transfer-from Name 2"; Text[50])
        {
            Caption = 'Transfer-from Name 2';
        }
        field(5; "Transfer-from Address"; Text[50])
        {
            Caption = 'Transfer-from Address';
        }
        field(6; "Transfer-from Address 2"; Text[50])
        {
            Caption = 'Transfer-from Address 2';
        }
        field(7; "Transfer-from Post Code"; Code[20])
        {
            Caption = 'Transfer-from Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.ValidateCity(
                  "Transfer-from City", "Transfer-from Post Code",
                  "Transfer-from County", "Trsf.-from Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(
                  "Transfer-from City", "Transfer-from Post Code",
                  "Transfer-from County", "Trsf.-from Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(8; "Transfer-from City"; Text[30])
        {
            Caption = 'Transfer-from City';

            trigger OnValidate()
            begin
                PostCode.ValidateCity(
                  "Transfer-from City", "Transfer-from Post Code",
                  "Transfer-from County", "Trsf.-from Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(9; "Transfer-from County"; Text[30])
        {
            Caption = 'Transfer-from County';
        }
        field(10; "Trsf.-from Country/Region Code"; Code[10])
        {
            Caption = 'Trsf.-from Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(11; "Transfer-to Code"; Code[10])
        {
            Caption = 'Transfer-to Code';
            //  TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
            //                                 "Subcontracting Location" = CONST(false));

            trigger OnValidate()
            var
                Location: Record 14;
                Confirmed: Boolean;
            begin
                //pratyusha
                //recUserSetup.GET(USERID);
                //RecResponsibility.GET(recUserSetup."Sales Resp. Ctr. Filter");
                //IF RecResponsibility."Location Code" <> "Transfer-to Code" THEN
                //  ERROR('You are not authorised to select this location.');
                //pratyusha


                TESTFIELD(Status, Status::Open);

                //for approval
                /*
                IF Approve THEN
                 ERROR('you cannot modify, its already Approved');
                
                
                */



                IF ("Transfer-from Code" = "Transfer-to Code") AND
                   ("Transfer-to Code" <> '')
                THEN
                    ERROR(
                      Text001,
                      FIELDCAPTION("Transfer-from Code"), FIELDCAPTION("Transfer-to Code"),
                      TABLECAPTION, "No.");
                IF (xRec."Transfer-to Code" <> "Transfer-to Code") THEN BEGIN
                    IF HideValidationDialog OR
                      (xRec."Transfer-to Code" = '')
                    THEN
                        Confirmed := TRUE
                    ELSE
                        Confirmed := CONFIRM(Text002, FALSE, FIELDCAPTION("Transfer-to Code"));
                    IF Confirmed THEN BEGIN
                        IF Location.GET("Transfer-to Code") THEN BEGIN
                            "Transfer-to Name" := Location.Name;
                            "Transfer-to Name 2" := Location."Name 2";
                            "Transfer-to Address" := Location.Address;
                            "Transfer-to Address 2" := Location."Address 2";
                            "Transfer-to Post Code" := Location."Post Code";
                            "Transfer-to City" := Location.City;
                            "Transfer-to County" := Location.County;
                            "Trsf.-to Country/Region Code" := Location."Country/Region Code";
                            "Transfer-to Contact" := Location.Contact;
                            MODIFY;
                        END;
                        UpdateTransLines(FIELDNO("Transfer-to Code"));
                    END ELSE BEGIN
                        "Transfer-to Code" := xRec."Transfer-to Code";
                        EXIT;
                    END;
                END;

            end;
        }
        field(12; "Transfer-to Name"; Text[50])
        {
            Caption = 'Transfer-to Name';
        }
        field(13; "Transfer-to Name 2"; Text[50])
        {
            Caption = 'Transfer-to Name 2';
        }
        field(14; "Transfer-to Address"; Text[50])
        {
            Caption = 'Transfer-to Address';
        }
        field(15; "Transfer-to Address 2"; Text[50])
        {
            Caption = 'Transfer-to Address 2';
        }
        field(16; "Transfer-to Post Code"; Code[20])
        {
            Caption = 'Transfer-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(
                  "Transfer-to City", "Transfer-to Post Code", "Transfer-to County",
                  "Trsf.-to Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(17; "Transfer-to City"; Text[30])
        {
            Caption = 'Transfer-to City';

            trigger OnValidate()
            begin
                PostCode.ValidateCity(
                  "Transfer-to City", "Transfer-to Post Code", "Transfer-to County",
                  "Trsf.-to Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(18; "Transfer-to County"; Text[30])
        {
            Caption = 'Transfer-to County';
        }
        field(19; "Trsf.-to Country/Region Code"; Code[10])
        {
            Caption = 'Transfer-to Country Code';
            TableRelation = "Country/Region";
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Editable = true;
        }
        field(21; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
        }
        field(22; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';
        }
        field(23; Status; Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;

            trigger OnValidate()
            begin
                UpdateTransLines(FIELDNO(Status));
            end;
        }
        field(24; Comment; Boolean)
        {
            CalcFormula = Exist("Inventory Comment Line" WHERE("Document Type" = CONST("Transfer Order"),
                                                                "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                UpdateTransLines(FIELDNO("Shortcut Dimension 1 Code"));
            end;
        }
        field(26; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                UpdateTransLines(FIELDNO("Shortcut Dimension 2 Code"));
            end;
        }
        field(27; "In-Transit Code"; Code[10])
        {
            Caption = 'In-Transit Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(true));

            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);
                UpdateTransLines(FIELDNO("In-Transit Code"));
            end;
        }
        field(28; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(29; "Last Shipment No."; Code[20])
        {
            Caption = 'Last Shipment No.';
            Editable = false;
            TableRelation = "Transfer Shipment Header";
        }
        field(30; "Last Receipt No."; Code[20])
        {
            Caption = 'Last Receipt No.';
            Editable = false;
            TableRelation = "Transfer Receipt Header";
        }
        field(31; "Transfer-from Contact"; Text[30])
        {
            Caption = 'Transfer-from Contact';
        }
        field(32; "Transfer-to Contact"; Text[30])
        {
            Caption = 'Transfer-to Contact';
        }
        field(33; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(34; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(35; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(36; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time';
        }
        field(37; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(47; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(48; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(59; "Entry/Exit Point"; Code[10])
        {
            Caption = 'Entry/Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(63; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(64; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(5750; "Shipping Advice"; Option)
        {
            Caption = 'Shipping Advice';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
        }
        field(5751; "Posting from Whse. Ref."; Integer)
        {
            Caption = 'Posting from Whse. Ref.';
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            CalcFormula = Min("Transfer Line"."Completely Shipped" WHERE("Document No." = FIELD("No."),
                                                                          "Shipment Date" = FIELD("Date Filter"),
                                                                          "Transfer-from Code" = FIELD("Location Filter")));
            Caption = 'Completely Shipped';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5753; "Completely Received"; Boolean)
        {
            CalcFormula = Min("Transfer Line"."Completely Received" WHERE("Document No." = FIELD("No."),
                                                                           "Receipt Date" = FIELD("Date Filter"),
                                                                           "Transfer-to Code" = FIELD("Location Filter")));
            Caption = 'Completely Received';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5754; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(13707; "Excise Bus. Posting Group"; Code[10])
        {
            Caption = 'Excise Bus. Posting Group';
            //TableRelation = "Excise Bus. Posting Group";
        }
        field(13723; "Form Code"; Code[10])
        {
            Caption = 'Form Code';
            //TableRelation = "Form Codes";
        }
        field(13724; "Form No."; Code[10])
        {
            Caption = 'Form No.';
            //TableRelation = "Tax Forms Details"."Form No." WHERE(Form Code=FIELD(Form Code));
        }
        field(13750; Structure; Code[20])
        {
            Caption = 'Structure';
            Description = 'changed from10';
            //TableRelation = "Structure Header".Code;

            trigger OnValidate()
            var
                Text13700: Label 'Structure code cannot be changed.';
                //StrDetails: Record "13793";
                //StrOrderDetails: Record "13794";
                //StrOrderLines: Record "13795";
                TransLines: Record 5741;
            begin
                TESTFIELD(Status, Status::Open);

                //for approval
                /*
                IF Approve THEN
                 ERROR('you cannot modify, its already Approved');
                */

                IF GoodsShipped THEN
                    ERROR(Text13700);

            end;
        }
        field(16503; "Captive Consumption"; Boolean)
        {
            Caption = 'Captive Consumption';
            Editable = false;
        }
        field(16504; "Vendor Invoice No."; Code[20])
        {
            Caption = 'Vendor Invoice No.';
        }
        field(16505; "Time of Removal"; Time)
        {
            Caption = 'Time of Removal';
        }
        field(16506; "LR/RR No."; Code[20])
        {
            Caption = 'LR/RR No.';
        }
        field(16507; "LR/RR Date"; Date)
        {
            Caption = 'LR/RR Date';
        }
        field(16508; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
        }
        field(16509; "Mode of Transport"; Text[15])
        {
            Caption = 'Mode of Transport';
        }
        field(50009; "Ship-To Code"; Code[20])
        {

            trigger OnLookup()
            begin
                /*ShiptoCodeLoc.RESET;
                ShiptoCodeLoc.SETRANGE(ShiptoCodeLoc."Document Type","Transfer-to Code");
                IF FORM.RUNMODAL(0,ShiptoCodeLoc) = ACTION::LookupOK THEN
                  BEGIN
                   "Ship-To Code":=ShiptoCodeLoc."User ID";
                  END; *///ebt

            end;
        }
        field(50010; "Shown to User"; Boolean)
        {
        }
        field(50013; Approve; Boolean)
        {

            trigger OnValidate()
            begin
                // Commented by EBT STIVAN ---(110112)---------------------START
                //IF Approve =FALSE THEN EXIT;
                // Commented by EBT STIVAN ---(110112)-----------------------END
                /*
                "Approve User ID":= USERID;
                "Approval Date":=TODAY;
                "Approval Time":=TIME;
                */
                //EBT STIVAN ---(30102012)--- Validation, If Item No. is Blank in Lines -------START
                TransLineAppr.RESET;
                TransLineAppr.SETRANGE(TransLineAppr."Document No.", "No.");
                TransLineAppr.SETRANGE(TransLineAppr.Approve, FALSE);
                TransLineAppr.SETFILTER(TransLineAppr."Item No.", '=%1', '');
                IF TransLineAppr.FINDFIRST THEN BEGIN
                    ERROR('Item No. is Blank in Line No. %1', TransLineAppr."Line No.");
                END;
                //EBT STIVAN ---(30102012)--- Validation, If Item No. is Blank in Lines ---------END

                //EBT STIVAN ---(03/08/2012)--- Approval Process----------------------------------------START
                //Memberof.RESET;  //RSPL-TC
                //Memberof.SETRANGE(Memberof."User ID",USERID);
                //Memberof.SETRANGE(Memberof."Role ID",'INDENT APPROVAL');
                //IF Memberof.FINDFIRST THEN
                BEGIN
                    IF USERID <> 'sa' THEN BEGIN
                        // Commented by Milan (09102013) for below code......................................................START
                        /*
                         recCSOMAPPING.RESET;
                         recCSOMAPPING.SETRANGE(recCSOMAPPING.Type,recCSOMAPPING.Type::"Responsibility Center");
                         recCSOMAPPING.SETRANGE(recCSOMAPPING."User Id",USERID);
                         recCSOMAPPING.SETRANGE(recCSOMAPPING.Value,"Responsibility Center");
                         IF recCSOMAPPING.FINDFIRST THEN
                         */
                        // Commented by Milan (09102013) for below code.....................................................END
                        RecSaleApproval.RESET;
                        RecSaleApproval.SETRANGE(RecSaleApproval."Approvar ID", USERID);
                        IF RecSaleApproval.FINDFIRST THEN BEGIN
                            "Approve User ID" := USERID;
                            "Approval Date" := TODAY;
                            "Approval Time" := TIME;
                        END ELSE
                            ERROR('You Dont have Permission for Transfer Indent Approval');
                    END
                    ELSE BEGIN
                        "Approve User ID" := USERID;
                        "Approval Date" := TODAY;
                        "Approval Time" := TIME;
                    END;

                    TransLineAppr.RESET;
                    TransLineAppr.SETRANGE(TransLineAppr."Document No.", "No.");
                    TransLineAppr.SETRANGE(TransLineAppr.Approve, FALSE);
                    IF TransLineAppr.FINDFIRST THEN BEGIN
                        REPEAT
                            TransLineAppr.Approve := Approve;
                            TransLineAppr."Approve User ID" := USERID;
                            TransLineAppr."Approval Date" := TODAY;
                            TransLineAppr."Approval Time" := TIME;
                            TransLineAppr.MODIFY;
                        UNTIL TransLineAppr.NEXT = 0;
                    END;
                END;
                //EBT STIVAN ---(03/08/2012)--- Approval Process------------------------------------------END

            end;
        }
        field(50021; "Transfer indent Date"; Date)
        {
            Editable = true;
        }
        field(50154; "Approve User ID"; Code[50])
        {
        }
        field(50155; "Approval Date"; Date)
        {
        }
        field(50156; "Approval Time"; Time)
        {
        }
        field(50157; "USER ID"; Code[50])
        {
        }
        field(60001; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(60002; "Shipping No.Series"; Code[20])
        {
            TableRelation = "No. Series";

            trigger OnLookup()
            begin

                WITH TransHeader DO BEGIN
                    TransHeader := Rec;
                    InvtSetup.GET;
                    InvtSetup.TESTFIELD(InvtSetup."Posted Transfer Shpt. Nos.");
                    IF NoSeriesMgt.LookupSeries(InvtSetup."Posted Transfer Shpt. Nos.", "Shipping No.Series") THEN
                        VALIDATE("Shipping No.Series");
                    Rec := TransHeader;
                END;
            end;
        }
        field(60003; RespCtrName; Code[20])
        {
        }
        field(60004; Remarks; Text[200])
        {
        }
        field(60005; "Transporter Name"; Code[50])
        {

            trigger OnLookup()
            begin

                IF PAGE.RUNMODAL(0, shippingagent) = ACTION::LookupOK THEN
                    "Transporter Name" := shippingagent.Name;
            end;
        }
        field(60009; "Captive Consumption(Internal)"; Boolean)
        {
        }
        field(60010; "Short Closed"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Posting Date")
        {
        }
        key(Key3; "Transfer indent Date")
        {
        }
        key(Key4; "Transfer-from Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TESTFIELD(Status, Status::Open);

        TransLine.SETRANGE("Document No.", "No.");
        IF TransLine.FIND('-') THEN
            TransLine.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin
        GetInventorySetup;
        IF "No." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", "Posting Date", "No.", "No. Series");
            //pratyusha
            /* UserSetup.GET(USERID);
             IF UserSetup."Sales Resp. Ctr. Filter" <> '' THEN
             BEGIN
               NoSeriesRelation.RESET;
               NoSeriesRelation.SETRANGE(NoSeriesRelation.Code,InvntrySetup."Transfer Indent No Series");
               NoSeriesRelation.SETRANGE(NoSeriesRelation."Resp.Ctr.Filter",UserSetup."Sales Resp. Ctr. Filter");
               IF NoSeriesRelation.FINDFIRST THEN
                  NoSeriesMgt.InitSeries(NoSeriesRelation."Series Code",xRec."No. Series","Posting Date","No.","No. Series");
             END; */
            //pratyusha
        END;
        //InitRecord;

    end;

    var
        TransHeader: Record 50022;
        TransLine: Record 50023;
        PostCode: Record 225;
        InvtSetup: Record 313;
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HideValidationDialog: Boolean;
        HasInventorySetup: Boolean;
        "<EBT>": Integer;
        UserSetup: Record 91;
        shippingagent: Record 291;
        RecResponsibility: Record 5714;
        Location: Record 14;
        Text000: Label 'You cannot rename a %1.';
        Text001: Label '%1 and %2 cannot be the same in %3 %4.';
        Text002: Label 'Do you want to change %1?';
        Text003: Label 'The transfer order %1 has been deleted.';
        NoSeriesRelation: Record 310;
        InvntrySetup: Record 313;
        recUserSetup: Record 91;
        recCSOMAPPING: Record 50006;
        TransLineAppr: Record 50023;
        RecSaleApproval: Record 50008;
        "-----Merch Dimension-----": Integer;
        AccessControl: Record 2000000053;

    [Scope('Internal')]
    procedure InitRecord()
    var
        UserMgt: Codeunit "User Setup Management";
    begin

        IF ("Posting Date" = 0D) THEN
            VALIDATE("Posting Date", WORKDATE);

        IF ("Transfer indent Date" = 0D) THEN
            "Transfer indent Date" := WORKDATE;

        "Time of Removal" := TIME;

        UserSetup.GET(USERID);
        //ebt
        "Responsibility Center" := UserSetup."Sales Resp. Ctr. Filter";
        RecResponsibility.RESET;
        RecResponsibility.SETRANGE(RecResponsibility.Code, UserMgt.GetRespCenter(0, "Responsibility Center"));
        IF RecResponsibility.FIND('-') THEN
            RespCtrName := RecResponsibility."Location Code";

        VALIDATE("Transfer indent Date", WORKDATE);

        "USER ID" := USERID;
    end;

    //[Scope('Internal')]
    procedure AssistEdit(OldTransHeader: Record "50022"): Boolean
    begin

        WITH TransHeader DO BEGIN
            TransHeader := Rec;
            GetInventorySetup;
            TestNoSeries;
            IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldTransHeader."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := TransHeader;
                EXIT(TRUE);
            END;
        END;
    end;

    local procedure TestNoSeries(): Boolean
    begin
        InvtSetup.TESTFIELD("Transfer Indent No Series");
    end;

    local procedure GetNoSeriesCode(): Code[10]
    var
        RespCenter: Record "5714";
        RespCenter1: Code[10];
        UserMgt: Codeunit "User Setup Management";
        Window: Dialog;
        RespC: Code[10];
    begin
        InvntrySetup.GET;
        UserSetup.GET(USERID);
        IF UserSetup."Sales Resp. Ctr. Filter" <> '' THEN BEGIN
            NoSeriesRelation.RESET;
            NoSeriesRelation.SETRANGE(NoSeriesRelation.Code, InvntrySetup."Transfer Indent No Series");
            NoSeriesRelation.SETRANGE(NoSeriesRelation."Resp.Ctr.Filter", UserSetup."Sales Resp. Ctr. Filter");
            IF NoSeriesRelation.FINDFIRST THEN
                //NoSeriesMgt.InitSeries(NoSeriesRelation."Series Code",xRec."No. Series","Posting Date","No.","No. Series");
                EXIT(NoSeriesRelation."Series Code");
            // EXIT(InvtSetup."Transfer Indent No Series")
        END;
    end;

    //[Scope('Internal')]
    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    local procedure GetInventorySetup()
    begin
        IF NOT HasInventorySetup THEN BEGIN
            InvtSetup.GET;
            HasInventorySetup := TRUE;
        END;
    end;

    local procedure UpdateTransLines(FieldRef: Integer)
    var
        TransLine: Record "50023";
    begin

        TransLine.LOCKTABLE;
        TransLine.SETRANGE("Document No.", "No.");
        IF TransLine.FIND('-') THEN BEGIN
            REPEAT
                CASE FieldRef OF
                    FIELDNO("In-Transit Code"):
                        TransLine.VALIDATE("In-Transit Code", "In-Transit Code");
                    FIELDNO("Transfer-from Code"):
                        BEGIN
                            TransLine.VALIDATE("Transfer-from Code", "Transfer-from Code");
                        END;
                    FIELDNO("Transfer-to Code"):
                        BEGIN
                            TransLine.VALIDATE("Transfer-to Code", "Transfer-to Code");
                        END;
                    FIELDNO(Status):
                        TransLine.VALIDATE(Status, Status);

                    FIELDNO("Shortcut Dimension 1 Code"):
                        TransLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");

                    FIELDNO("Shortcut Dimension 2 Code"):
                        TransLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");

                END;
                TransLine.MODIFY(TRUE);
            UNTIL TransLine.NEXT = 0;
        END;

    end;

    //  [Scope('Internal')]
    procedure GoodsShipped(): Boolean
    var
        TransLines: Record "50023";
    begin
        TransLines.RESET;
        TransLines.SETRANGE("Document No.", "No.");
        TransLines.SETFILTER("Qty Shipped", '>0');
        IF TransLines.FIND('-') THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;

    //[Scope('Internal')]
    procedure CreateTransferOrder(TransferIndentheader: Record 50022)
    var
        RecTransferHeader: Record 5740;
        RecTransferLine: Record 5741;
        RECINVENTORYSETUP: Record 313;
        cdDocNo: Code[20];
        reclocation: Record 14;
        rectransferIndentLine: Record 50023;
        i: Integer;
        TempDimSetEntry: Record 480 temporary;
        cduDimMgt: Codeunit "DimensionManagement";
        RecDimSetEntry: Record 480;
    begin

        TransferIndentheader.TESTFIELD("Transfer-from Code");
        TransferIndentheader.TESTFIELD("Transfer-to Code");
        TransferIndentheader.TESTFIELD("In-Transit Code");

        rectransferIndentLine.RESET;
        rectransferIndentLine.SETRANGE("Document No.", TransferIndentheader."No.");
        rectransferIndentLine.SETFILTER("Qty. to Ship", '>0');
        IF NOT rectransferIndentLine.FIND('-') THEN
            EXIT;


        //-------create transfer header---------------
        RecTransferHeader.LOCKTABLE;
        RecTransferHeader.INIT;
        RECINVENTORYSETUP.GET;
        cdDocNo := NoSeriesMgt.GetNextNo(RECINVENTORYSETUP."Transfer Order Nos.", TODAY, TRUE);
        RecTransferHeader."No." := cdDocNo;

        RecTransferHeader."Transfer-from Code" := TransferIndentheader."Transfer-from Code";
        //RecTransferHeader.VALIDATE("Transfer-from Code",TransferIndentheader."Transfer-from Code");// DJ 21/03/20

        RecTransferHeader."Transfer-from Name" := TransferIndentheader."Transfer-from Name";
        RecTransferHeader."Transfer-from Name 2" := TransferIndentheader."Transfer-from Name 2";
        RecTransferHeader."Transfer-from Address" := TransferIndentheader."Transfer-from Address";
        RecTransferHeader."Transfer-from Address 2" := TransferIndentheader."Transfer-from Address 2";
        RecTransferHeader."Transfer-from Post Code" := TransferIndentheader."Transfer-from Post Code";
        RecTransferHeader."Transfer-from City" := TransferIndentheader."Transfer-from City";
        RecTransferHeader."Transfer-from County" := TransferIndentheader."Transfer-from County";
        RecTransferHeader."Trsf.-from Country/Region Code" := TransferIndentheader."Trsf.-from Country/Region Code";
        RecTransferHeader."Transfer-from Contact" := TransferIndentheader."Transfer-from Contact";

        RecTransferHeader."Transfer-to Code" := TransferIndentheader."Transfer-to Code";
        //RecTransferHeader.VALIDATE("Transfer-to Code",TransferIndentheader."Transfer-to Code");// DJ 21/03/20

        RecTransferHeader."Transfer-to Name" := TransferIndentheader."Transfer-to Name";
        RecTransferHeader."Transfer-to Name 2" := TransferIndentheader."Transfer-to Name 2";
        RecTransferHeader."Transfer-to Address" := TransferIndentheader."Transfer-to Address";
        RecTransferHeader."Transfer-to Address 2" := TransferIndentheader."Transfer-to Address 2";
        RecTransferHeader."Transfer-to Post Code" := TransferIndentheader."Transfer-to Post Code";
        RecTransferHeader."Transfer-to City" := TransferIndentheader."Transfer-to City";
        RecTransferHeader."Transfer-to County" := TransferIndentheader."Transfer-to County";
        RecTransferHeader."Trsf.-to Country/Region Code" := TransferIndentheader."Trsf.-to Country/Region Code";
        RecTransferHeader."Transfer-to Contact" := TransferIndentheader."Transfer-to Contact";
        RecTransferHeader."Posting Date" := TODAY;
        RecTransferHeader."Shipment Date" := TransferIndentheader."Shipment Date";
        RecTransferHeader."Receipt Date" := TransferIndentheader."Receipt Date";
        RecTransferHeader."Shortcut Dimension 1 Code" := TransferIndentheader."Shortcut Dimension 1 Code";

        reclocation.GET(TransferIndentheader."Transfer-from Code");
        // RecTransferHeader."Shortcut Dimension 2 Code" :=reclocation."Responsibility Center" ;   //EBT
        //RecTransferHeader."Excise Bus. Posting Group" := reclocation."Excise Bus. Posting Group";

        RecTransferHeader."External Document No." := TransferIndentheader."External Document No.";
        RecTransferHeader."In-Transit Code" := TransferIndentheader."In-Transit Code";
        RecTransferHeader."Shipping Agent Code" := TransferIndentheader."Shipping Agent Code";
        RecTransferHeader."Shipping Agent Service Code" := TransferIndentheader."Shipping Agent Service Code";
        RecTransferHeader."Shipment Method Code" := TransferIndentheader."Shipment Method Code";
        RecTransferHeader."Transaction Type" := TransferIndentheader."Transaction Type";
        RecTransferHeader."Transport Method" := TransferIndentheader."Transport Method";
        RecTransferHeader."Entry/Exit Point" := TransferIndentheader."Entry/Exit Point";
        RecTransferHeader.Area := TransferIndentheader.Area;
        RecTransferHeader."Transaction Specification" := TransferIndentheader."Transaction Specification";
        //RecTransferHeader."Captive Consumption" := TransferIndentheader."Captive Consumption";
        //RecTransferHeader."Time of Removal" := TransferIndentheader."Time of Removal";
        //RecTransferHeader."Vehicle No." := TransferIndentheader."Vehicle No.";
        //RecTransferHeader."LR/RR No." := TransferIndentheader."LR/RR No.";
        //RecTransferHeader."LR/RR Date" := TransferIndentheader."LR/RR Date";
        //RecTransferHeader."Mode of Transport" := TransferIndentheader."Mode of Transport";
        // RecTransferHeader."Transporter Name":=TransferIndentheader."Transporter Name";//ebt
        // RecTransferHeader.Remarks:=TransferIndentheader.Remarks;//ebt
        RecTransferHeader.Status := RecTransferHeader.Status::Open;
        // RecTransferHeader."Captive Consumption(Internal)":=TransferIndentheader."Captive Consumption(Internal)";//ebt
        //RecTransferHeader.VALIDATE(Structure ,TransferIndentheader.Structure);
        //RecTransferHeader."Form Code":=TransferIndentheader."Form Code";
        // RecTransferHeader."Transfer Indent No":=TransferIndentheader."No.";
        RecTransferHeader.INSERT(TRUE);


        RecTransferHeader.RESET;
        RecTransferHeader.SETRANGE("No.", cdDocNo);
        IF RecTransferHeader.FIND('-') THEN BEGIN
            RecTransferHeader."Transfer Indent No" := TransferIndentheader."No.";
            RecTransferHeader.VALIDATE("Shortcut Dimension 1 Code");
            RecTransferHeader.VALIDATE("Shortcut Dimension 2 Code");
            RecTransferHeader.VALIDATE("Transfer-from Code");
            RecTransferHeader.VALIDATE("Transfer-to Code");
            RecTransferHeader.MODIFY(TRUE);
        END;


        // -----create Transfer Line-----------------
        i := 10000;
        rectransferIndentLine.RESET;
        rectransferIndentLine.SETRANGE("Document No.", TransferIndentheader."No.");
        rectransferIndentLine.SETFILTER("Qty. to Ship", '>0');
        rectransferIndentLine.SETRANGE(rectransferIndentLine.Closed, FALSE); //EBT STIVAN (13022012)
        IF rectransferIndentLine.FIND('-') THEN
            REPEAT
                RecTransferLine.LOCKTABLE;
                RecTransferLine.INIT;
                RecTransferLine.VALIDATE("Document No.", cdDocNo);
                RecTransferLine."Line No." := i;
                RecTransferLine.VALIDATE("Transfer-from Code", rectransferIndentLine."Transfer-from Code");
                RecTransferLine.VALIDATE("Transfer-to Code", rectransferIndentLine."Transfer-to Code");
                RecTransferLine.VALIDATE("In-Transit Code", rectransferIndentLine."In-Transit Code");
                RecTransferLine."Inventory Posting Group" := rectransferIndentLine."Inventory Posting Group";
                RecTransferLine.VALIDATE("Item No.", rectransferIndentLine."Item No.");
                RecTransferLine.VALIDATE(Quantity, rectransferIndentLine."Qty. to Ship");
                // RecTransferLine.VALIDATE("Transfer Price",rectransferIndentLine."Transfer Price");
                RecTransferLine."Transfer Indent No." := TransferIndentheader."No.";              //EBT Paramita 07/03/2012
                RecTransferLine."Transfer Indent Line No." := rectransferIndentLine."Line No.";   //EBT Paramita 07/03/2012
                RecTransferLine."Original Qty" := rectransferIndentLine."Qty. to Ship";            //EBT Paramita 07/03/2012
                RecTransferLine.INSERT;
                //Merch Dimension  >>>>>
                IF rectransferIndentLine.MERCH <> '' THEN BEGIN
                    /*  //RSPL-TC
                       recDocDim.RESET;
                       recDocDim.INIT;
                       recDocDim."Table ID" := 5741;
                       recDocDim."Document Type":= recDocDim."Document Type"::"6" ;
                       recDocDim."Document No." := RecTransferLine."Document No.";
                       recDocDim."Line No." := RecTransferLine."Line No.";
                       recDocDim."Dimension Code" :=  'MERCH';
                       recDocDim."Dimension Value Code" :=  rectransferIndentLine.MERCH;
                       recDocDim.INSERT;
                       */
                    TempDimSetEntry.RESET;
                    TempDimSetEntry.DELETEALL;

                    RecDimSetEntry.RESET;
                    RecDimSetEntry.SETRANGE("Dimension Set ID", RecTransferLine."Dimension Set ID");
                    IF RecDimSetEntry.FINDSET THEN
                        REPEAT
                            TempDimSetEntry.INIT;
                            TempDimSetEntry.VALIDATE("Dimension Code", RecDimSetEntry."Dimension Code");
                            TempDimSetEntry.VALIDATE("Dimension Value Code", RecDimSetEntry."Dimension Value Code");
                            TempDimSetEntry.INSERT;
                        UNTIL RecDimSetEntry.NEXT = 0;

                    TempDimSetEntry.INIT;
                    TempDimSetEntry.VALIDATE("Dimension Code", 'MERCH');
                    TempDimSetEntry.VALIDATE("Dimension Value Code", rectransferIndentLine.MERCH);
                    TempDimSetEntry.INSERT;
                    RecTransferLine."Dimension Set ID" := cduDimMgt.GetDimensionSetID(TempDimSetEntry);
                    RecTransferLine.MODIFY;
                END;
                //Merch Dimension  <<<<<
                i := i + 10000;
            UNTIL rectransferIndentLine.NEXT = 0;
        //-----update dimensions--------------------------
        RecTransferLine.RESET;
        RecTransferLine.SETRANGE("Document No.", cdDocNo);
        IF RecTransferLine.FIND('-') THEN
            REPEAT
                RecTransferLine."Shortcut Dimension 1 Code" := TransferIndentheader."Shortcut Dimension 1 Code";
                RecTransferLine.VALIDATE("Shortcut Dimension 1 Code");
                reclocation.GET(TransferIndentheader."Transfer-from Code");
                //   RecTransferLine."Shortcut Dimension 2 Code" :=reclocation."Responsibility Center" ;//ebt
                RecTransferLine.VALIDATE("Shortcut Dimension 2 Code");
                RecTransferLine.MODIFY(TRUE);
            UNTIL RecTransferLine.NEXT = 0;

        //----------update indent remaining quantity----
        UpdateIndent(TransferIndentheader);

        MESSAGE('Transfer order created ' + cdDocNo);

    end;

    //    [Scope('Internal')]
    procedure UpdateIndent(TransferIndentheader1: Record "50022")
    var
        rectransferIndentLine1: Record "50023";
        rectransferindentheader1: Record "50022";
    begin

        rectransferIndentLine1.RESET;
        rectransferIndentLine1.SETRANGE("Document No.", TransferIndentheader1."No.");
        rectransferIndentLine1.SETFILTER("Qty. to Ship", '>0');
        IF rectransferIndentLine1.FIND('-') THEN
            REPEAT
                rectransferIndentLine1."Qty Shipped" := rectransferIndentLine1."Qty Shipped" + rectransferIndentLine1."Qty. to Ship";
                rectransferIndentLine1."Outstanding Quantity" := rectransferIndentLine1."Outstanding Quantity" -
                                       rectransferIndentLine1."Qty. to Ship";
                rectransferIndentLine1."Qty. to Ship" := 0;
                rectransferIndentLine1.Status := rectransferIndentLine1.Status::Released;
                rectransferIndentLine1.MODIFY;

            UNTIL rectransferIndentLine1.NEXT = 0;

        rectransferindentheader1.RESET;
        rectransferindentheader1.SETRANGE("No.", TransferIndentheader1."No.");
        IF rectransferindentheader1.FIND('-') THEN BEGIN
            rectransferindentheader1.Status := rectransferindentheader1.Status::Released;
            rectransferindentheader1.MODIFY;
        END;
    end;
}

