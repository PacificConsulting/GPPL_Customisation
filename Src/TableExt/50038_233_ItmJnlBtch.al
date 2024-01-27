tableextension 50038 ItemJnlBatchExtCstm extends 233
{
    fields
    {
        field(50000; "Insurance Adjustment"; Boolean)
        {
            Description = 'RB-N 07Mar2019';
        }
        field(50001; "Insurance / Loss G/L No."; Code[20])
        {
            Description = 'RB-N 07Mar2019';
            TableRelation = "G/L Account";
        }
        field(50002; "Purchase Account"; Code[20])
        {
            Description = 'RSPLSUM28951';
            TableRelation = "G/L Account";
        }
        field(50003; "GST Account"; Code[20])
        {
            Description = 'RSPLSUM28951';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                IF (Name <> 'GST_REV') AND ("GST Account" <> '') THEN//RSPLSUM28951
                    ERROR('You cannot enter GST Account for this batch');//RSPLSUM28951
            end;
        }
        field(50004; "GST Percentage"; Decimal)
        {
            Description = 'RSPLSUM28951';

            trigger OnValidate()
            begin
                IF (Name <> 'GST_REV') AND ("GST Percentage" <> 0) THEN//RSPLSUM28951
                    ERROR('You cannot enter GST Percentage for this batch');//RSPLSUM28951
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