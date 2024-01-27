tableextension 50006 Cutomerextcustm extends 18
{
    fields
    {
        field(50001; "Full Name"; Text[100])
        {
            Description = 'EBT/CUST/0001';
        }
        field(50002; Type; Option)
        {
            Description = 'EBT/CUST/0001';
            OptionCaption = 'Customer,Distributor,Stockist';
            OptionMembers = Customer,Distributor,Stockist;
        }
        field(50003; "Creation Date"; Date)
        {
            Description = 'EBT/CUST/0001';
            Editable = false;
        }
        field(50004; "Customer Kms"; Decimal)
        {
            Description = 'EBT/TRANSUBSIDY/0001';
        }
        field(50005; "Customer Cr. Group"; Option)
        {
            Description = 'EBT/CrLimit/0001';
            OptionCaption = 'Parent Customer,Group Customer';
            OptionMembers = "Parent Customer","Group Customer";

            trigger OnValidate()
            begin
                //EBT/CrLimit/0001
                IF "Customer Cr. Group" = "Customer Cr. Group"::"Parent Customer" THEN
                    "Parent Customer" := "No."
                ELSE
                    "Parent Customer" := '';
                //EBT/CrLimit/0001
            end;
        }
        field(50006; "Parent Customer"; Code[20])
        {
            Description = 'EBT/CrLimit/0001';
            TableRelation = IF ("Customer Cr. Group" = CONST("Parent Customer")) "Customer"."No." WHERE("No." = FIELD("No."))
            ELSE
            IF ("Customer Cr. Group" = CONST("Group Customer")) Customer;

            trigger OnValidate()
            var
                ParentCust: Record 18;
            begin
                //EBT/CrLimit/0001
                IF "Customer Cr. Group" = "Customer Cr. Group"::"Group Customer" THEN BEGIN
                    IF "Parent Customer" <> '' THEN BEGIN
                        ParentCust.GET("Parent Customer");
                        "Consolidated Cr. Limit" := ParentCust."Consolidated Cr. Limit";
                    END;
                END;
                //EBT/CrLimit/0001
            end;
        }
        field(50007; "Consolidated Cr. Limit"; Decimal)
        {
            Description = 'EBT/CrLimit/0001';
        }
        field(50008; "Vendor No."; Code[10])
        {
            Description = 'EBT/CNF/0001';
            TableRelation = Vendor."No.";
        }
        field(50009; "Cust Show"; Boolean)
        {
            Description = 'EBT0001';
            Editable = false;
        }
        field(50010; "Created By"; Code[10])
        {
            Description = 'EBT0001';
        }
        field(50011; Marked; Boolean)
        {
            Description = 'Pratyusha -for user mapping functionality for customers';
        }
        field(50012; "LBT Reg. No."; Code[39])
        {
            Description = 'EBT STIVAN -(08/04/2013)- For Reporting Purpose';
        }
        field(50013; "Freight Type"; Option)
        {
            Description = 'EBT STIVAN 10/06/2013';
            OptionCaption = ' ,PAID,TO PAY,PAY & ADD IN BILL,SELF PICKUP';
            OptionMembers = " ",PAID,"TO PAY","PAY & ADD IN BILL","SELF PICKUP";
        }
        field(50014; "W.e.f. Date(T.I.N No.)"; Date)
        {
            Description = 'RSPL 251114';
        }
        field(50015; "W.e.f. Date(C.S.T No.)"; Date)
        {
            Description = 'RSPL 251114';
        }
        field(50016; "Approved Payment Days"; DateFormula)
        {
            Description = 'RSPL 020415';
        }
        field(50020; "Headquarter Location"; Text[50])
        {
            Description = 'RSPL';
            TableRelation = "Headquarter Location".Name;
        }
        field(50021; "Inter Company Customer"; Boolean)
        {
            Description = 'PP011';
        }
        field(50022; Legal; Boolean)
        {
            Description = 'PP011';
        }
        field(50023; "Insurance Limit"; Decimal)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50024; "Management Limit"; Decimal)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50025; "Temporary Limit"; Decimal)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50026; "Insurance Limit Exp Date"; Date)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50027; "Management Limit Exp Date"; Date)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50028; "Temporary Limit Exp Date"; Date)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50029; "Credit Limit Approval"; Boolean)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50030; "Insurance Percentage"; Decimal)
        {
            Description = 'RSPLSUM-BUNKER';

            trigger OnValidate()
            begin
                PercentageCheck("Insurance Percentage");
            end;
        }
        field(50031; "Management Percentage"; Decimal)
        {
            Description = 'RSPLSUM-BUNKER';

            trigger OnValidate()
            begin
                PercentageCheck("Management Percentage");
            end;
        }
        field(50032; "Temporary Percentage"; Decimal)
        {
            Description = 'RSPLSUM-BUNKER';

            trigger OnValidate()
            begin
                PercentageCheck("Temporary Percentage");
            end;
        }
        field(50033; "Trade License Available"; Boolean)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50034; "Licensing Authority"; Text[30])
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50035; "License Number"; Code[20])
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50036; "Date Of Issue"; Date)
        {
            Description = 'RSPLSUM-BUNKER';

            trigger OnValidate()
            begin
                IF "Date Of Expiry" <> 0D THEN
                    IF ("Date Of Issue" > "Date Of Expiry") THEN
                        ERROR('Date Of Issue should be lesser than Date Of Expiry')
            end;
        }
        field(50037; "Place Of Issue"; Text[30])
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50038; "Date Of Expiry"; Date)
        {
            Description = 'RSPLSUM-BUNKER';

            trigger OnValidate()
            begin
                IF "Date Of Issue" <> 0D THEN
                    IF ("Date Of Expiry" < "Date Of Issue") THEN
                        ERROR('Date Of Expiry should be greater than Date of issue')
            end;
        }
        field(50039; "Bank Ref. Name"; Text[30])
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50040; "Person On Behalf"; Text[30])
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50041; "Business Type"; Option)
        {
            Description = 'RSPLSUM-BUNKER';
            OptionCaption = ' ,Trading,Chartering,Ship Owner,Broking Agency';
            OptionMembers = " ",Trading,Chartering,"Ship Owner","Broking Agency";
        }
        field(50042; "Business Reg No. Available"; Boolean)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50043; "Business Reg No."; Code[20])
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50044; "Bank Branch"; Text[30])
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50045; "Bank Account No."; Code[20])
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50046; "IBAN No."; Code[20])
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50047; "Swift Code"; Code[10])
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50048; "Approval Status"; Option)
        {
            Description = 'RSPLSUM-BUNKER';
            OptionCaption = 'Open,Pending For Approval,Approved,Rejected';
            OptionMembers = Open,"Pending For Approval",Approved,Rejected;
        }
        field(50049; "Credit Limit Approval Status"; Option)
        {
            Description = 'RSPLSUM-BUNKER';
            OptionCaption = 'Open,Pending For Approval,Approved,Rejected';
            OptionMembers = Open,"Pending For Approval",Approved,Rejected;


        }
        field(50050; "Balance Credit Limit"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Description = 'RSPLSUM-BUNKER';
        }
        field(50051; "Balance Credit Limit in USD"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Description = 'RSPLSUM-BUNKER';
        }
        field(50052; BalanceCreditLimit; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Description = 'RSPLSUM-BUNKER';
        }
        field(50053; "Customer Type"; Option)
        {
            Description = 'RSPLSUM-BUNKER';
            OptionCaption = ' ,Local,Bunker';
            OptionMembers = " ","Local",Bunker;
        }
        field(50054; "Balance (FCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter")));
            Caption = 'Balance (FCY)';
            Description = 'RSPLSUM-BUNKER';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50055; "O/s Credit Orders (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Outstanding Amount (LCY)" WHERE("Document Type" = CONST(Order),
                                                                             "Bill-to Customer No." = FIELD("No."),
                                                                             "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                             "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                             "Currency Code" = FIELD("Currency Filter")//,Azhar pending
                                                                                                                       //Azhar pending "Credit Checking Not Required" = CONST(No),
                                                                                                                       //Azhar pending Status = CONST(Released)
                                                                             ));
            Caption = 'Outstanding Orders (LCY)';
            Description = 'RSPLSUM-BUNKER';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50056; "Shp Not Invoiced Credit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Shipped Not Invoiced (LCY)" WHERE("Document Type" = CONST(Order),
                                                                               "Bill-to Customer No." = FIELD("No."),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Currency Code" = FIELD("Currency Filter")//Azhar pending ,
                                                                                                                         //Azhar pending "Credit Checking Not Required"=CONST(No)
                                                                               ));
            Caption = 'Shipped Not Invoiced (LCY)';
            Description = 'RSPLSUM-BUNKER';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50057; "Parent Company"; Code[20])
        {
            Description = 'RSPLSUM-BUNKER';
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                //RSPL-CL
                IF "Parent Company" = "No." THEN
                    ERROR('You can not choose same company as parent company');
                //RSPL-CL
            end;
        }
        field(50058; "Customer Group Code"; Code[20])
        {
            Description = 'RSPLSUM 20May2020';
            TableRelation = "Group Master Table"."Group Code" WHERE(Type = CONST(Customer));
        }
        field(50059; "O/s Email Alert"; Boolean)
        {
            Description = 'SP';
        }
        field(50060; "KYC Approval Status"; Option)
        {
            Description = 'RSPLAM29597';
            //Editable = false;
            OptionCaption = ' ,Open,Pending For Approval,Approved,Rejected';
            OptionMembers = " ",Open,"Pending For Approval",Approved,Rejected;
        }
        field(50061; "Exclude From Bal Confir Mail"; Boolean)
        {
            Caption = 'Exclude From Balance Confirmation Mail';
            Description = 'AM31267';
        }
        field(50300; "Turnover Above 10 Crores"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'robotdsDJ';
        }
        field(50301; "ITR filled for last 02 years"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'robotdsysr_V2';
        }
        field(50302; "Linking of Aadhaar with PAN"; Option)
        {
            Description = 'robotdssid';
            OptionCaption = ' ,Yes,No,Not Applicable';
            OptionMembers = " ",Yes,No,"Not Applicable";
        }
        field(50303; "Commercial Rating"; Text[10])
        {
            Description = 'RSPLSID 17July2021';
        }
        field(50304; "Credit Rating"; Text[10])
        {
            Description = 'RSPLSID 17July2021';
        }
        field(50305; TANNO; Text[30])
        {
            Description = 'Fahim 07-03-2022';
        }
        field(50351; "RWR Salesperson"; Code[10])
        {
            Description = 'YSR30847';
            TableRelation = "Salesperson/Purchaser".Code WHERE("RWR Parent" = CONST(false), "Parent RWR Code" = FIELD("Salesperson Code"));

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
        field(50352; NOD; Boolean)
        {
        }
        field(50353; "National Discount Applicable"; Boolean)
        {
            Description = 'ST32289';
        }
        field(50354; "Transport Subsidy Applicable"; Boolean)
        {
            Description = 'AM32612';
        }

    }

    trigger OnInsert()
    var
        CI: Record "Company Information";
    begin
        Rec.Validate("Creation Date", Today);
        //RSPLSUM 10May2020>>
        CI.GET;
        IF CI."Customer Credit Validation" THEN BEGIN
            "Credit Limit Approval" := TRUE;
            //Blocked := Blocked::All;
        END;
        //RSPLSUM 10May2020<<
        rec.Validate("O/s Email Alert", true);
        Rec.Validate("KYC Approval Status", Rec."KYC Approval Status"::Open);

        //RSPLSUM 10May2020


        CI.GET;
        IF CI."Customer Credit Validation" THEN BEGIN
            "Credit Limit Approval" := TRUE;
            //Blocked := Blocked::All;
        END;
        //RSPLSUM 10May2020
    end;

    var

        Text016: Label 'Percentage cannot be less than 0';
        Text017: Label 'Percentage cannot be greater than 100';

    procedure PercentageCheck(dpercentage: Decimal)
    begin
        IF dpercentage < 0 THEN
            ERROR(Text016);
        IF dpercentage > 100 THEN
            ERROR(Text017);
        EXIT;
    end;
}
