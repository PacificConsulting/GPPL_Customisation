table 60002 "Tax Salaris Basic"
{

    fields
    {
        field(1; "Year Start Date"; Date)
        {
        }
        field(2; "Year End Date"; Date)
        {
        }
        field(3; "Employee No."; Code[20])
        {
            TableRelation = Employee_;
        }
        field(4; "Pay Element"; Code[20])
        {
            TableRelation = "LookUp"."Lookup Name" WHERE("LookupType Name" = CONST('ADDITIONS AND DEDUCTIONS'));

        }
        field(5; April; Decimal)
        {
            Caption = 'April';
        }
        field(6; May; Decimal)
        {
            Caption = 'May';
        }
        field(7; June; Decimal)
        {
            Caption = 'June';
        }
        field(8; July; Decimal)
        {
            Caption = 'July';
        }
        field(9; August; Decimal)
        {
            Caption = 'August';
        }
        field(10; September; Decimal)
        {
            Caption = 'September';
        }
        field(11; October; Decimal)
        {
            Caption = 'October';
        }
        field(12; November; Decimal)
        {
            Caption = 'November';
        }
        field(13; December; Decimal)
        {
            Caption = 'December';
        }
        field(14; January; Decimal)
        {
            Caption = 'January';
        }
        field(15; February; Decimal)
        {
            Caption = 'February';
        }
        field(16; March; Decimal)
        {
            Caption = 'March';
        }
        field(17; Total; Decimal)
        {
        }
        field(18; "Add/Deduct"; Option)
        {
            OptionCaption = ' ,Addition,Deduction';
            OptionMembers = " ",Addition,Deduction;
        }
    }

    keys
    {
        key(Key1; "Year Start Date", "Employee No.", "Pay Element")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

