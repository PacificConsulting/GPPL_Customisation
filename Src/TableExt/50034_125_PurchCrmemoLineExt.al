tableextension 50034 PurchCrMemoLineExtCutm extends 125
{
    fields
    {
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