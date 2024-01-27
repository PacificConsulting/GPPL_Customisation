table 60037 "Temp Processed Salary"
{
    // Date: 15-Dec-05

    DrillDownPageID = 60031;
    LookupPageID = 60031;

    fields
    {
        field(2; "Employee Code"; Code[20])
        {
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
        field(22; Priority; Integer)
        {
        }
        field(23; Deducted; Boolean)
        {
        }
        field(24; "Loan Id"; Code[20])
        {
        }
        field(25; "Bonus/Exgratia"; Decimal)
        {
        }
        field(26; "Partial Deduction"; Boolean)
        {
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
        field(50; "PF Admin Charges"; Decimal)
        {
        }
        field(51; "EDLI Charges"; Decimal)
        {
        }
        field(52; "RIFA Charges"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "Employee Code", "Pay Slip Month", Year, "Line No.", "Add/Deduct Code")
        {
            Clustered = true;
        }
        key(Key2; "Employee Code", "Add/Deduct Code", "Pay Slip Month", Year, "Add/Deduct")
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
        key(Key5; "Employee Code", "Pay Slip Month", Year, Priority)
        {
        }
        key(Key6; "Employee Code", "Pay Slip Month", Year, Priority, "Loan Priority No")
        {
        }
    }

    fieldgroups
    {
    }
}

