tableextension 50015 PurchaseLineExtCustm extends 39
{
    fields
    {
        field(50000; "QC Applicable"; Boolean)
        {
            Description = 'EBT/QC Func/0001';
            Editable = true;
        }
        field(50001; "QC Approved"; Boolean)
        {
            Description = 'EBT/QC Func/0001';
            Editable = true;
        }
        field(50002; "Balance Qty To Receive"; Decimal)
        {
            Description = 'EBT MILAN 101013';
        }
        field(50003; "Density Factor"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'EBT/PO Dens Func/0001';
            Editable = true;

            trigger OnValidate()
            begin
                TESTFIELD("Vendor Rate");
                IF NOT (Type = Type::Item) THEN
                    ERROR('Density Factor is appicable for only Type Item');
                VALIDATE(Quantity, "Vendor Quantity" * "Density Factor");
                VALIDATE("Direct Unit Cost", "Vendor Amount" / Quantity);
                //VALIDATE("Assessable Value", "Direct Unit Cost");
            end;
        }
        field(50004; "Vendor Unit of Measure"; Code[40])
        {
            Description = 'EBT/PO Dens Func/0001';
            TableRelation = "Unit of Measure";

            trigger OnValidate()
            begin
                IF NOT (Type = Type::Item) THEN
                    ERROR('Density Factor is appicable for only Type Item');
            end;
        }
        field(50005; "Vendor Quantity"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';

            trigger OnValidate()
            begin
                TESTFIELD("Vendor Unit of Measure");
                IF NOT (Type = Type::Item) THEN
                    ERROR('Density Factor is appicable for only Type Item');

                IF "Vendor Rate" <> 0 THEN
                    "Vendor Amount" := "Vendor Quantity" * "Vendor Rate";
                IF "Vendor Rate" <> 0 THEN
                    VALIDATE("Density Factor");
            end;
        }
        field(50006; "Vendor Rate"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';

            trigger OnValidate()
            begin
                TESTFIELD("Vendor Quantity");
                IF NOT (Type = Type::Item) THEN
                    ERROR('Density Factor is appicable for only Type Item');

                IF "Density Factor" = 1 THEN BEGIN
                    VALIDATE("Vendor Quantity");
                    VALIDATE("Direct Unit Cost", "Vendor Rate");
                    "Vendor Amount" := "Vendor Quantity" * "Vendor Rate";
                END
                ELSE BEGIN
                    VALIDATE("Density Factor");
                END;
            end;
        }
        field(50007; "Vendor Amount"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
            Editable = false;
        }
        field(50008; "Density Factor Applicable"; Boolean)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50009; "Modify Through WH"; Boolean)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50010; "Unit Cost Update"; Boolean)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50011; "Bulk Packing"; Boolean)
        {
            Description = 'EBT STIVAN (29/01/2013) - For Reporting Purpose';
        }
        field(50012; "Bonded Rate"; Decimal)
        {
            DecimalPlaces = 4 : 3;
            Description = 'EBT MILAN 25122013';
        }
        field(50013; "Exbond Rate"; Decimal)
        {
            DecimalPlaces = 4 : 3;
            Description = 'EBT MILAN 25122013';
        }
        field(50050; "Landed Cost"; Decimal)
        {
            Description = 'RSPL-Sourav';
        }
        field(50051; "MR No"; Code[30])
        {
            Description = 'RB-N 22Sep2017';
        }
        field(50052; "Sub Expense Code"; Integer)
        {
            BlankZero = true;
            Description = 'RB-N 06Jul2018';
            TableRelation = "Sub Expenditure".Code;

            trigger OnValidate()
            var
                SubExp06: Record 50041;
            begin

                //>>06Jul2018
                TESTFIELD("Document Type", "Document Type"::Invoice);
                IF "Sub Expense Code" <> 0 THEN BEGIN
                    SubExp06.RESET;
                    IF SubExp06.GET("Sub Expense Code") THEN
                        "Sub Expense Name" := SubExp06.Description;
                    "Import Invoice No." := '';
                END ELSE BEGIN
                    "Sub Expense Name" := '';
                    "Import Invoice No." := '';
                END;
                //<<06Jul2018
            end;
        }
        field(50053; "Sub Expense Name"; Text[50])
        {
            Description = 'RB-N 06Jul2018';
            Editable = false;
        }
        field(50054; "Import Invoice No."; Code[20])
        {
            Caption = 'Import / Export Invoice No.';
            Description = 'RB-N 06Jul2018';
            TableRelation = IF (Type = CONST("G/L Account"),
                                "No." = CONST('71060020')) "Purch. Inv. Header"."No." WHERE("Gen. Bus. Posting Group" = FILTER('FOREIGN | DOMESTIC'), "Posting Date" = FILTER('01-04-18..')) ELSE
            IF (Type = CONST("G/L Account"),
            "No." = CONST('75001150')) "Sales Invoice Header"."No." WHERE("Gen. Bus. Posting Group" = FILTER('FOREIGN'),
            "Posting Date" = FILTER('>31-03-18'),
            "Document Date" = FILTER('>31-03-18'),
            "Order No." = FILTER('<> '''));

            trigger OnValidate()
            begin
                TESTFIELD("Document Type", "Document Type"::Invoice);
            end;
        }
        field(50055; "MR Date"; Date)
        {
            Description = 'RSPLSUM 15Jul2020';
        }
        field(50056; "MR Quantity"; Decimal)
        {
            Description = 'RSPLSUM 15Jul2020';
        }
        field(50057; "Cost Avoidance"; Decimal)
        {
            Description = 'RSPLSUM 15Jul2020';
        }
        field(50300; "TDS Applicable"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'robotdsDJ';
            Editable = false;
        }
        field(50301; "TDS Calc Skip"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'robotdsYSR';
            Editable = false;
        }
        field(50303; "Tax Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50304; "Amount To Vendor"; Decimal)
        {
            Caption = 'Amount To Vendor';

            trigger OnValidate()
            begin
                TESTFIELD(Type);
                TESTFIELD(Quantity);
                TESTFIELD("Direct Unit Cost");

                // "Amount To Vendor" := ROUND("Amount To Vendor",Currency."Amount Rounding Precision");
                // Amount := ROUND("Line Amount" - "Inv. Discount Amount",Currency."Amount Rounding Precision");
                // "Tax Base Amount" := Amount;
                // "Amount Including Tax" := Amount;
                InitOutstandingAmount;
                UpdateUnitCost;
            end;
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
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Recitem: Record Item;
            begin
                Rec.Validate("QC Applicable", Recitem."QC Applicable"); //EBT--001
                Rec.validate("Density Factor Applicable", Recitem."Density Factor Applicable");   //EBT/PO Dens Func/0001
            end;
        }
        // MY PC 09 01 2024

        modify("Return Qty. to Ship")
        {
            trigger OnAfterValidate()
            var
                PH: Record "Purchase Header";
            begin
                //17Mar2019
                IF PH.GET("Document Type", rec."Document No.") THEN
                    IF NOT PH."Gate Pass" THEN;
                //17Mar2019            
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
    procedure ApplicationofEntries()
    var
        TransportDetailsForm: Page "Transport Details - 1";
    begin
        CLEAR(TransportDetailsForm);
        //TransportDetailsForm.GetDocNo(Rec."Document No.");
        TransportDetailsForm.GetDocNo(Rec."Document No.", Rec."No.");//02Jan2019
        TransportDetailsForm.RUNMODAL;
    end;

    var
        myInt: Integer;
}