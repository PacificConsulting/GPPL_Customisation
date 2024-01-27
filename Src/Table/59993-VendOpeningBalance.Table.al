table 59993 "Vend. Opening Balance"
{

    fields
    {
        field(1; "Vend. No."; Code[10])
        {
        }
        field(2; "Posting Date"; Date)
        {
        }
        field(3; "Doc. No."; Code[20])
        {
        }
        field(4; "Currency Code"; Code[10])
        {
        }
        field(5; "Pay to Vendor"; Code[10])
        {
        }
        field(7; "Due Date"; Date)
        {
        }
        field(8; "Payment Disc Date"; Date)
        {
        }
        field(9; "Document Date"; Date)
        {
        }
        field(10; "Ext Doc No."; Code[30])
        {
        }
        field(11; Amount; Decimal)
        {
        }
        field(12; "Doc Type"; Option)
        {
            OptionCaption = ' ,Invoice,Payment,Credit Memo';
            OptionMembers = " ",Invoice,Payment,"Credit Memo";
        }
        field(13; "Currency Factor"; Decimal)
        {
            DecimalPlaces = 15 : 15;
        }
    }

    keys
    {
        key(Key1; "Vend. No.", "Doc. No.", "Doc Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

