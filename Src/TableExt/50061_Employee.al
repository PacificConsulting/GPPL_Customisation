tableextension 50061 EmployeeExtCstm extends 5200
{
    fields
    {
        // field(50000; "Bank Account No."; Code[15])
        // {
        // }
        field(50001; "Bank Name"; Text[50])
        {
            Description = 'RSPLSUM 15Nov2019';
        }
        field(50002; "IFSC Code"; Code[20])
        {
            Description = 'RSPLSUM 15Nov2019';
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