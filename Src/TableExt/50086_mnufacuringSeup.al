tableextension 50086 ManufactingSetupExtCstm extends "Manufacturing Setup"
{
    fields
    {
        field(50000; "Certificate Nos."; Code[20])
        {
            Description = '//EBT/QC Func/0001';
            TableRelation = "No. Series";
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