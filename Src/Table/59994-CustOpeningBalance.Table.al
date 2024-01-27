table 59994 "Cust. Opening Balance"
{

    fields
    {
        field(1; "Cust No."; Code[10])
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
        field(5; "Sell To Cust"; Code[10])
        {
        }
        field(6; "SalesPerson Code"; Code[10])
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
            OptionCaption = ' ,Invoice,Payment';
            OptionMembers = " ",Invoice,Payment;
        }
        field(13; "Currency Factor"; Decimal)
        {
            DecimalPlaces = 15 : 15;
        }
    }

    keys
    {
        key(Key1; "Cust No.", "Doc. No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

