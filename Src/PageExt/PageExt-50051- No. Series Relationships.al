pageextension 50051 "NoSeries RelationshipsExtcstm" extends "No. Series Relationships"
{
    layout
    {
        addafter("Series Code")
        {
            field("Resp.Ctr.Filter"; Rec."Resp.Ctr.Filter")
            {
                ApplicationArea = all;
            }
            field("Document Type"; Rec."Document Type")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}