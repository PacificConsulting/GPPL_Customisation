table 50049 "Mintifi Log"
{

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Document Type"; Option)
        {
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(3; "Document No."; Code[100])
        {
        }
        field(4; "Source Type"; Option)
        {
            OptionCaption = ' ,Customer,Vendor';
            OptionMembers = " ",Customer,Vendor;
        }
        field(5; "Source No."; Code[50])
        {
        }
        field(6; "Source Name"; Text[100])
        {
        }
        field(7; Amount; Decimal)
        {
        }
        field(8; Status; Option)
        {
            OptionCaption = ' ,Success,Error';
            OptionMembers = " ",Success,Error;
        }
        field(9; "Status Message"; Text[250])
        {
        }
        field(10; "Entry Date"; Date)
        {
        }
        field(11; "Created By"; Code[100])
        {
        }
        field(12; "Entry Type"; Option)
        {
            OptionCaption = ' ,Order Process,Journal,Payment';
            OptionMembers = " ","Order Process",Journal,Payment;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

