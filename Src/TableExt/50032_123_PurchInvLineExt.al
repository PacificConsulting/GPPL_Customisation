tableextension 50123 PurchInvLineExtCustm extends 123
{
    fields
    {
        field(50003; "Density Factor"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50004; "Vendor Unit of Measure"; Code[20])
        {
            Description = 'EBT/PO Dens Func/0001';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
        }
        field(50005; "Vendor Quantity"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50006; "Vendor Rate"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50007; "Vendor Amount"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
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
            Editable = true;
        }
        field(50052; "Sub Expense Code"; Integer)
        {
            BlankZero = true;
            Description = 'RB-N 06Jul2018';
            Editable = false;
            TableRelation = "Sub Expenditure".Code;
        }
        field(50053; "Sub Expense Name"; Text[50])
        {
            Description = 'RB-N 06Jul2018';
            Editable = false;
        }
        field(50054; "Import Invoice No."; Code[20])
        {
            Description = 'RB-N 06Jul2018';
            Editable = false;
            TableRelation = "Purch. Inv. Header"."No." WHERE("Gen. Bus. Posting Group" = FILTER('FOREIGN'));
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
        field(50304; "Amount To Vendor"; Decimal)
        {
            Caption = 'Amount To Vendor';
            Editable = false;
            trigger OnValidate()
            begin

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
}