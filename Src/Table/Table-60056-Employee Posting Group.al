table 60056 "Employee Posting GroupCstm"
{
    LookupPageID = 60057;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Salary Payable Acc."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(4; "PF Payable Acc."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(5; "TDS Payable Acc."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(6; "ESI Payable Acc."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(7; "EPS Payable Acc."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(8; "EDLI Charges Acc."; Code[20])
        {
            Caption = 'EDLI Charges Acc.';
            TableRelation = "G/L Account";
        }
        field(9; "PF Admin Charge Payable Acc."; Code[20])
        {
            Caption = 'PF Admin Charge Payable Acc.';
            TableRelation = "G/L Account";
        }
        field(11; "PT Payable Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(12; "RIFA Charges Acc."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(13; "Arrear Salary Payable Acc."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(14; "Bonus Payable Acc."; Code[20])
        {
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

