table 50008 "Sales Approval"
{
    // RSPLSUM28688 - Document Type 'QC' added in option


    fields
    {
        field(1; "Document Type"; Option)
        {
            Description = 'RSPLAM29597 Added Customer KYC Option';
            OptionCaption = 'Sales Order,Blanket PO,Sales Invoice,Sales CrMemo,Purch Invoice,Purch CrMemo,Journal Voucher,GatePass,SalesReturnOrder,Customer,Customer OCL,QC,Customer KYC';
            OptionMembers = "Sales Order","Blanket PO","Sales Invoice","Sales CrMemo","Purch Invoice","Purch CrMemo","Journal Voucher",GatePass,SalesReturnOrder,Customer,"Customer OCL",QC,"Customer KYC";
        }
        field(2; "User ID"; Code[50])
        {
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //EBT STIVAN ---(14/04/2012)--- To Update Name Field when User Id is Selected -------START
                User1.GET("User ID");
                Name := User1.Name;
                //EBT STIVAN ---(14/04/2012)--- To Update Name Field when User Id is Selected ---------END
            end;
        }
        field(3; "Approvar ID"; Code[50])
        {
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //EBT STIVAN ---(14/04/2012)--- To Update Name Field when User Id is Selected -------START
                User1.GET("Approvar ID");
                "Approvar Name" := User1.Name;
                //EBT STIVAN ---(14/04/2012)--- To Update Name Field when User Id is Selected ---------END
            end;
        }
        field(4; "Approvar Level"; Integer)
        {

            trigger OnValidate()
            begin
                "Sales&RecvSetup".GET;
                IF "Sales&RecvSetup"."Sales Approval Max Level" < "Approvar Level" THEN
                    ERROR('You can define the maximum level %1', "Sales&RecvSetup"."Sales Approval Max Level");
            end;
        }
        field(5; Mandatory; Boolean)
        {

            trigger OnValidate()
            begin
                "Sales&RecvSetup".GET;
                IF "Sales&RecvSetup"."Sales Approval Max Level" <> "Approvar Level" THEN
                    ERROR('This level is not the Highest Level');
            end;
        }
        field(6; MD; Boolean)
        {

            trigger OnValidate()
            begin
                IF MD THEN BEGIN
                    IF "User ID" <> '' THEN
                        ERROR('You cannot define User ID');
                    SalesApproval.RESET;
                    SalesApproval.SETRANGE(SalesApproval."User ID", '');
                    SalesApproval.SETRANGE(SalesApproval.MD, TRUE);
                    IF SalesApproval.FINDFIRST THEN
                        IF SalesApproval."Approvar ID" <> "Approvar ID" THEN
                            ERROR('You can not define more than one Uder Id to this profile');
                END;
            end;
        }
        field(50002; "Approvar Name"; Text[30])
        {
            Description = 'EBT STIVAN 14/04/2012';
        }
        field(50026; Name; Text[30])
        {
            Description = 'EBT STIVAN 14/04/2012';
        }
        field(50027; "Purchase Approval Limit"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            Description = 'RB-N 14Mar2018';
        }
        field(50028; "Level2 Approvar ID"; Code[50])
        {
            Description = 'RB-N 14Mar2018';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                IF "Document Type" <> "Document Type"::"Sales CrMemo" THEN
                    IF ("Level2 Approvar ID" <> 'GPUAE\UNNIKRISHNAN.VS') AND ("Level2 Approvar ID" <> 'GPUAE\KAUSTUBH.PARAB') THEN
                        IF "Level2 Approvar ID" <> '' THEN BEGIN
                            IF "Level2 Approvar ID" = "User ID" THEN
                                ERROR('UserID and Level2 ApprovarID cannot be Same');

                            IF "Level2 Approvar ID" = "Approvar ID" THEN
                                ERROR('ApprovarID and Level2 ApprovarID cannot be Same');
                        END;

                //>>
                User1.RESET;
                IF User1.GET("Level2 Approvar ID") THEN
                    "Level2 Approvar Name" := User1.Name;
                //<<
            end;
        }
        field(50029; "Level2 Approvar Name"; Text[50])
        {
            Description = 'RB-N 14Mar2018';
        }
        field(50030; "Credit Approvar ID"; Code[50])
        {
            Description = 'RB-N 15May2018';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin

                //>>Credit ApproverName
                User1.RESET;
                User1.SETRANGE("User ID", "Credit Approvar ID");
                IF User1.FINDFIRST THEN
                    "Credit Approvar Name" := User1.Name
                ELSE
                    "Credit Approvar Name" := "Credit Approvar ID";
                //<<Credit ApproverName
            end;
        }
        field(50031; "Credit Approvar Name"; Text[50])
        {
            Description = 'RB-N 15May2018';
            Editable = false;
        }
        field(50032; "Division Code"; Code[20])
        {
            Description = 'RB-N 17May2018';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DIVISION'));
        }
        field(50033; "Division Code 2"; Code[20])
        {
            Description = 'RB-N 17May2018';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DIVISION'));

            trigger OnValidate()
            begin
                IF "Division Code 2" <> '' THEN BEGIN
                    IF "Division Code" = "Division Code 2" THEN
                        ERROR('Dimension is Already Used in Division 1');
                END;
            end;
        }
        field(50034; "Division Code 3"; Code[20])
        {
            Description = 'RB-N 17May2018';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DIVISION'));

            trigger OnValidate()
            begin
                IF "Division Code 3" <> '' THEN BEGIN
                    IF "Division Code" = "Division Code 3" THEN
                        ERROR('Dimension is Already Used in Division 1');

                    IF "Division Code 2" = "Division Code 3" THEN
                        ERROR('Dimension is Already Used in Division 2');
                END;
            end;
        }
        field(50035; "Division Code 4"; Code[20])
        {
            Description = 'RB-N 17May2018';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DIVISION'));

            trigger OnValidate()
            begin
                IF "Division Code 4" <> '' THEN BEGIN
                    IF "Division Code" = "Division Code 4" THEN
                        ERROR('Dimension is Already Used in Division 1');

                    IF "Division Code 2" = "Division Code 4" THEN
                        ERROR('Dimension is Already Used in Division 2');

                    IF "Division Code 3" = "Division Code 4" THEN
                        ERROR('Dimension is Already Used in Division 3');
                END;
            end;
        }
        field(50036; "Division Code 5"; Code[20])
        {
            Description = 'RB-N 17May2018';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DIVISION'));

            trigger OnValidate()
            begin
                IF "Division Code 5" <> '' THEN BEGIN
                    IF "Division Code" = "Division Code 5" THEN
                        ERROR('Dimension is Already Used in Division 1');

                    IF "Division Code 2" = "Division Code 5" THEN
                        ERROR('Dimension is Already Used in Division 2');

                    IF "Division Code 3" = "Division Code 5" THEN
                        ERROR('Dimension is Already Used in Division 3');

                    IF "Division Code 4" = "Division Code 5" THEN
                        ERROR('Dimension is Already Used in Division 4');

                END;
            end;
        }
    }

    keys
    {
        key(Key1; "User ID", "Approvar ID", "Document Type", "Credit Approvar ID", "Level2 Approvar ID")
        {
            Clustered = true;
        }
        key(Key2; "Approvar Level")
        {
        }
        key(Key3; "Document Type")
        {
        }
        key(Key4; "Credit Approvar ID")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "Sales&RecvSetup": Record 311;
        SalesApproval: Record 50008;
        User1: Record 91;
}

