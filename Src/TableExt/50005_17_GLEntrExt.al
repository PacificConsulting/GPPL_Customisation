tableextension 50005 MyExtension extends "G/L Entry"
{
    fields
    {
        field(50000; "Check Print Name"; Text[100])
        {
            Description = 'EBT STIVAN - 09042012 - Added Field For Check Printing';
        }
        field(50017; "Exp/Purchase Invoice Doc. No."; Code[20])
        {
            Description = 'EBT STIVAN 140412 --> To get Posted Purchase or expense Invoice No.';
        }
        field(50018; "Creation Date"; DateTime)
        {
            Description = 'RSPLDJ 22NOV19';
        }
        field(50219; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            Description = '#Mintifi,Mintifi_SUM';
            TableRelation = "Payment Method";
        }
        field(50220; "Currency Code"; Code[10])
        {
            Description = '#Mintifi,Mintifi_SUM';
            TableRelation = Currency;
        }
    }

}