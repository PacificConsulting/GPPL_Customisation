tableextension 50051 NoSeriesRelationshipExt extends 310
{
    fields
    {
        field(50000; "Resp.Ctr.Filter"; Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(50001; "Document Type"; Option)
        {
            Description = 'EBT STIVAN 30072012 - For Filteration Purpose for getting the Posting No Series';
            OptionMembers = " ","Suppl Inovice","Sale Return Order","Sale Credit Note","Sale Debit Memo";
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