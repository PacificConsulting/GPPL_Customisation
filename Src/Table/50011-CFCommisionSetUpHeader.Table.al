table 50011 "C&F Commision SetUp Header"
{

    fields
    {
        field(1; "Customer Type"; Option)
        {
            OptionMembers = Customer,Distributor;
        }
        field(2; "Fixed Exp. Rem. Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(3; "Variable Exp. Rem. Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(4; "Handling Charge Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(5; "Account (Form Expense)"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(6; "Value of Billing"; Decimal)
        {
        }
        field(7; "Commission Code"; Code[10])
        {
        }
        field(8; "Minimum Sales Volume Qty."; Decimal)
        {
        }
        field(9; "Location Code"; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(10; "Calculation Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Commission Code", "Location Code", "Customer Type", "Calculation Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

