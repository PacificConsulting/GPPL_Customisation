table 60038 "Processed Salary"
{
    // 15-Dec-05

    DrillDownPageID = 60031;
    LookupPageID = 60031;

    fields
    {
        field(2; "Employee Code"; Code[20])
        {
            TableRelation = Employee_;
        }
        field(3; "Fixed/Percent"; Option)
        {
            OptionMembers = "Fixed",Percent;
        }
        field(4; "Computation Type"; Code[50])
        {
        }
        field(5; "Add/Deduct Code"; Code[30])
        {
        }
        field(6; "Loan Priority No"; Integer)
        {
        }
        field(8; "Earned Amount"; Decimal)
        {
            DecimalPlaces = 2 : 0;
        }
        field(12; "Add/Deduct"; Option)
        {
            OptionMembers = " ",Addition,Deduction;
        }
        field(13; Attendance; Decimal)
        {
        }
        field(14; Days; Integer)
        {
        }
        field(15; "Pay Slip Month"; Integer)
        {
            //ValuesAllowed = 1;2;3;4;5;6;7;8;9;10;11;12;
        }
        field(16; Year; Integer)
        {
        }
        field(17; Check; Boolean)
        {
        }
        field(18; "Co. Contributions"; Decimal)
        {
        }
        field(19; "Co. Contribution2"; Decimal)
        {
        }
        field(20; "Employee Name"; Text[30])
        {
        }
        field(21; Salary; Decimal)
        {
        }
        field(24; "Loan Id"; Code[20])
        {
        }
        field(25; "Bonus/Exgratia"; Decimal)
        {
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(42; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Payroll';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Payroll;
        }
        field(43; "Line No."; Integer)
        {
        }
        field(44; "Account No."; Code[20])
        {
        }
        field(45; "Arrear Amount"; Decimal)
        {
        }
        field(46; "Arrears Not Posted"; Boolean)
        {
        }
        field(47; Posted; Boolean)
        {
        }
        field(48; "Posting Date"; Date)
        {
        }
        field(49; "Pay Cadre"; Code[20])
        {
        }
        field(50; "PF Admin Charges"; Decimal)
        {
        }
        field(51; "EDLI Charges"; Decimal)
        {
        }
        field(52; "RIFA Charges"; Decimal)
        {
        }
        field(53; "Arrear Co. Contribution"; Decimal)
        {
        }
        field(54; "Arrear Co. Contribution2"; Decimal)
        {
        }
        field(55; "Arrear Salary"; Decimal)
        {
        }
        field(56; "Document No"; Code[50])
        {
        }
        field(57; Reversed; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "Employee Code", "Pay Slip Month", Year, "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Employee Code", "Add/Deduct Code", "Pay Slip Month", Year, "Add/Deduct", "Earned Amount")
        {
            SumIndexFields = "Earned Amount";
        }
        key(Key3; "Employee Code", Year, "Pay Slip Month", "Add/Deduct")
        {
            SumIndexFields = "Earned Amount";
        }
        key(Key4; "Add/Deduct", "Add/Deduct Code")
        {
        }
        key(Key5; "Employee Code", "Pay Slip Month", Year, Posted)
        {
        }
        key(Key6; "Employee Code")
        {
        }
    }

    fieldgroups
    {
    }
}

