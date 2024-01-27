tableextension 50091 TranRcptLineExtCstm extends "Transfer Receipt Line"
{
    fields
    {
        field(50000; "Transfer Indent No."; Code[20])
        {
            Description = 'EBT STIVAN (29/05/2012)';
            Editable = false;
            TableRelation = "Transfer Indent Header";
        }
        field(50001; "Transfer Indent Line No."; Integer)
        {
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