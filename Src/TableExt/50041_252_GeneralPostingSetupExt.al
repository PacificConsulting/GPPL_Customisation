tableextension 50041 GeneralPostingSetupExtCutm extends 252
{
    fields
    {
        field(50000; "Salary G/L Account"; Code[20])
        {
            Description = 'Payroll';
            TableRelation = "G/L Account"."No.";
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