tableextension 50092 CustomerPostingGroupCstm extends "Customer Posting Group"
{
    fields
    {
        field(50000; "PIT Difference Acc."; Code[20])
        {
            TableRelation = "G/L Entry";
        }

    }

}