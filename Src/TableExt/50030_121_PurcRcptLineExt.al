tableextension 50030 PurchRcpLineExtCutm extends 121
{
    fields
    {
        field(50003; "Density Factor"; Decimal)
        {
            DecimalPlaces = 3 : 3;
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
        field(50050; "Landed Cost"; Decimal)
        {
            Description = 'RSPL-Sourav';
        }
        field(50051; "MR No"; Code[30])
        {
            Description = 'RB-N 22Sep2017';
        }
        field(50058; "Closed GRN"; Boolean)
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."Closed GRN" WHERE("No." = FIELD("Document No.")));
            Description = 'RSPLSUM 01Sept2020';
            FieldClass = FlowField;
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
        field(50600; "Expire Date"; Date)
        {
            Description = 'RSPLAM30180';
            Editable = false;
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