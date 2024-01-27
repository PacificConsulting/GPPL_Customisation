table 60007 "Monthly Attd Buffer"
{
    // B2B Software Technologies
    // -----------------------------
    // Project : Human Resource
    // B2B
    // No. sign      Date
    // -----------------------------
    // 01   B2B    14-dec-05

    DrillDownPageID = 60062;
    LookupPageID = 60019;

    fields
    {
        field(2; "Employee Code"; Code[20])
        {
            TableRelation = Employee_;
        }
        field(3; Attendance; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum("Daily Attendance".Present WHERE("Employee No." = FIELD("Employee Code"),
            //                                                     Year = FIELD(Year),
            //                                                     Month = FIELD("Pay Slip Month"),
            //                                                     Present = FILTER('<> 0')));

        }
        field(4; Days; Integer)
        {
            // FieldClass = FlowField;
            // CalcFormula = Count("Daily Attendance" WHERE("Employee No." = FIELD("Employee Code"),
            //                                               Year = FIELD(Year),
            //                                               Month = FIELD("Pay Slip Month")));

        }
        field(5; "Pay Slip Month"; Integer)
        {
            //ValuesAllowed = 1;2;3;4;5;6;7;8;9;10;11;12;
        }
        field(6; "Weekly Off"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum("Daily Attendance".WeeklyOff WHERE ("Employee No."=FIELD("Employee Code"),
            //                                                       Year=FIELD(Year),
            //                                                       Month=FIELD("Pay Slip Month"),
            //                                                       WeeklyOff=FILTER(<>0)));

        }
        field(11; "Over Time Hrs"; Decimal)
        {
            //FieldClass = FlowField;
            // CalcFormula = Sum("Daily Attendance"."OT Approved Hrs" WHERE ("Employee No."=FIELD("Employee Code"),
            //                                                               Year=FIELD(Year),
            //                                                               Month=FIELD("Pay Slip Month"),
            //                                                               OT Approved Hrs=FILTER(<>0)));

        }
        field(14; Holidays; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Daily Attendance".Holiday WHERE("Employee No." = FIELD("Employee Code"),
                                                                Year = FIELD(Year),
                                                                Month = FIELD("Pay Slip Month"),
                                                                Holiday = FILTER(<> 0)));

        }
        field(15; "Loss Of Pay"; Decimal)
        {
            FieldClass = Normal;
        }
        field(17; Year; Integer)
        {
        }
        field(18; Process; Boolean)
        {

            trigger OnValidate()
            begin
                IF Processed = TRUE THEN
                    ERROR(Text001);
            end;
        }
        field(19; Processed; Boolean)
        {
        }
        field(20; Posted; Boolean)
        {
        }
        field(21; "Posting Date"; Date)
        {
        }
        field(22; "Processing Date"; Date)
        {
        }
        field(23; "Gross Salary"; Decimal)
        {
            // CalcFormula = Sum("Processed Salary"."Earned Amount" WHERE("Employee Code" = FIELD("Employee Code"),
            //                                                             Year = FIELD(Year),
            //                                                             Pay Slip Month=FIELD("Pay Slip Month"),
            //                                                             Add/Deduct=CONST(Addition),
            //                                                             Earned Amount=FILTER(<>0)));
            // FieldClass = FlowField;
        }
        field(24; Deductions; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum("Processed Salary"."Earned Amount" WHERE (Employee Code=FIELD("Employee Code"),
            //                                                             Year=FIELD(Year),
            //                                                             Pay Slip Month=FIELD("Pay Slip Month"),
            //                                                             Add/Deduct=CONST(Deduction),
            //                                                             Add/Deduct Code=FILTER(<>EMP. ESI<>EMP. PF),
            //                                                             Earned Amount=FILTER(<>0)));

        }
        field(25; "Net Salary"; Decimal)
        {
        }
        field(26; "Employee Name"; Text[120])
        {
        }
        field(27; Leaves; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum("Daily Attendance".Leave WHERE ("Employee No."=FIELD("Employee Code"),
            //                                                   Year=FIELD(Year),
            //                                                   Month=FIELD("Pay Slip Month"),
            //                                                   Leave=FILTER(<>0),
            //                                                   Leave Code=FILTER(CL)));


            trigger OnValidate()
            begin
                //VE-026
                Attendance := Attendance - Leaves;
            end;
        }
        field(28; "Co. Contributions"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum("Temp Processed Salary"."Earned Amount" WHERE ("Employee Code"=FIELD("Employee Code"),
            //                                                                  Year=FIELD(Year),
            //                                                                  Pay Slip Month=FIELD("Pay Slip Month"),
            //                                                                  Add/Deduct=CONST(3)));

        }
        field(29; "Emp Deduction"; Decimal)
        {
            // CalcFormula = Sum("Temp Processed Salary"."Earned Amount" WHERE ("Employee Code"=FIELD(Employee Code),
            //                                                                  Year=FIELD(Year),
            //                                                                  Pay Slip Month=FIELD(Pay Slip Month),
            //                                                                  Add/Deduct=CONST(Deduction),
            //                                                                  Add/Deduct Code=FILTER(EMP. ESI EMP. PF)));
            // FieldClass = FlowField;
        }
        field(30; "Period Start Date"; Date)
        {
        }
        field(31; "Period End Date"; Date)
        {
        }
        field(32; "Journal Batch Name"; Code[20])
        {
        }
        field(33; "Document No."; Code[20])
        {
        }
        field(34; "Journal Template Name"; Code[20])
        {
        }
        field(35; PayCadre; Code[30])
        {
        }
        field(36; "Paid Amount"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum("Posted Salary Details"."Salary Paid" WHERE (Employee Code=FIELD(Employee Code),
            //                                                                Month=FIELD(Pay Slip Month),
            //                                                                Year=FIELD(Year)));

        }
        field(37; "Remaining Amount"; Decimal)
        {
        }
        field(42; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(44; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(45; "Line No."; Integer)
        {
        }
        field(46; "Cumulative Balance"; Decimal)
        {
        }
        field(47; "Cheque No."; Code[20])
        {
        }
        field(48; "Cheque Date"; Date)
        {
        }
        field(49; "Account Type"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(50; "Pay Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "Pay Amount" > "Net Salary" THEN
                    ERROR('Pay Amount cannot exceed Net Salary');
                IF "Pay Amount" < 0 THEN
                    ERROR('You cannot enter Negative Amounts');
            end;
        }
        field(51; "Account No."; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"."No."
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"."No.";
        }
        field(52; "Pay Method"; Option)
        {
            OptionMembers = Cash,Cheque,"Bank Transfer";
        }
        field(53; Blocked; Boolean)
        {
        }
        field(54; "Post to GL"; Boolean)
        {
        }
        field(55; "Late Hours"; Duration)
        {
        }
        field(56; "Leave Cut For LateHrs"; Decimal)
        {
        }
        field(58; "No.Of Payroll Days"; Decimal)
        {
        }
        field(60; "Leaves Used"; Decimal)
        {
        }
        field(61; "Leaves Remaing"; Decimal)
        {

            trigger OnValidate()
            begin
                //VE-026
                IF "Leaves Remaing" < 0 THEN
                    "Leaves Remaing" := 0;
                // MODIFY;
                //VE-026
            end;
        }
        field(62; "Leaves Availabe"; Decimal)
        {
        }
        field(63; "Leaves Added"; Decimal)
        {
        }
        field(64; "No.of Days Count"; Integer)
        {
            // FieldClass = FlowField;
            // CalcFormula = Count("Daily Attendance" WHERE ("Employee No."=FIELD("Employee Code"),
            //                                               Month=FIELD(Pay Slip Month),
            //                                               Year=FIELD(Year),
            //                                               Attendance Type=FILTER(<>' ')));

        }
        field(65; "Process Salary"; Boolean)
        {
        }
        field(67; LossOFpayCount; Decimal)
        {
            //  FieldClass = FlowField;
            // CalcFormula = Sum("Daily Attendance".Leave WHERE ("Employee No."=FIELD("Employee Code"),
            //                                                   Year=FIELD(Year),
            //                                                   Month=FIELD("Pay Slip Month"),
            //                                                   Loss Of Pay=FILTER(Yes)));

        }
        field(68; "Leaves Add aft probation"; Decimal)
        {
        }
        field(70; Reversed; Boolean)
        {
        }
        field(71; "Reversal Entries"; Boolean)
        {
        }
        field(72; LeavesUsedForcasualLeaves; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum("Daily Attendance".Leave WHERE ("Employee No."=FIELD("Employee Code"),
            //                                                   Year=FIELD(Year),
            //                                                   Month=FIELD("Pay Slip Month"),
            //                                                   Leave=FILTER(<>0),
            //                                                   Leave Code=CONST(CL),
            //                                                   Loss Of Pay=FILTER(No)));

        }
        field(75; LeavesUsedForSickLeaves; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum("Daily Attendance".Leave WHERE ("Employee No."=FIELD("Employee Code"),
            //                                                   Year=FIELD(Year),
            //                                                   Month=FIELD(Pay Slip Month),
            //                                                   Leave=FILTER(<>0),
            //                                                   Leave Code=CONST(SL),
            //                                                   Loss Of Pay=FILTER(No)));

        }
        field(76; Probationleaves; Decimal)
        {
        }
        field(77; "Total Present Days"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Sum("Daily Attendance".Present WHERE ("Employee No."=FIELD("Employee Code"),
            //                                                     Attendance Type=FILTER(<>Full Day),
            //                                                     Present=FILTER(<>0),
            //                                                     Non-Working=FILTER(No),
            //                                                     Year=FIELD(Year)));

        }
        field(78; "Employment Date"; Date)
        {
            CalcFormula = Lookup(Employee_."Employment Date" WHERE("No." = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
        field(79; "No of Times EL's  Used"; Integer)
        {
        }
        field(80; LeavesUsedForEarnedLeaves; Decimal)
        {
            //  FieldClass = FlowField;
            // CalcFormula = Sum("Daily Attendance".Leave WHERE ("Employee No."=FIELD("Employee Code"),
            //                                                   Year=FIELD(Year),
            //                                                   Month=FIELD("Pay Slip Month"),
            //                                                   Leave=FILTER(<>0),
            //                                                   Leave Code=CONST(EL),
            //                                                   Loss Of Pay=FILTER(No)));

        }
        field(81; "LeavesAvl.ForEL"; Decimal)
        {
        }
        field(82; ELLeavesCarryFrwd; Decimal)
        {
        }
        field(83; TotalLeavesAvailable; Decimal)
        {
        }
        field(84; "Total Leaves"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Daily Attendance".Leave WHERE("Employee No." = FIELD("Employee Code"),
                                                              Year = FIELD(Year),
                                                              Month = FIELD("Pay Slip Month"),
                                                              Leave = FILTER(<> 0)));

        }
        field(85; Leavesaddedafteryear; Boolean)
        {
        }
        field(86; Resigned; Boolean)
        {
        }
        field(88; "Emp Location"; Code[10])
        {
            CalcFormula = Lookup(Employee_."Emp Location" WHERE("No." = FIELD("Employee Code")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Pay Slip Month", Year, "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Net Salary";
        }
        key(Key2; "Employee Code", Posted)
        {
            SumIndexFields = "Remaining Amount";
        }
        key(Key3; "Pay Method")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*if TotalSickLeavesUsed > 8 then
          DailyAtt.init;
          dailyatt.setrange(DailyAtt."Employee No.","Employee Code" );
          if dailyatt.find('-') then
         */

    end;

    var
        Text001: Label 'This Record is Already Processed';
        //DimMgt: Codeunit 408;
        DailyAtt: Record 60028;
}

