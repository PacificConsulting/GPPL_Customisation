table 60016 "HR Setup"
{
    // B2B Software Technologies
    // ----------------------------
    // Project : Human Resource
    // B2B
    // No. sign      Date
    // ----------------------------
    // 01   B2B    13-dec-05
    // 
    // 
    // Date : 13/12/2005 by B2B HR4.0.01


    fields
    {
        field(1; "Primary Key"; Code[20])
        {
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(5; "Resume DB"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(6; Recruitment; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(8; Loan; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(9; Training; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(10; "Salary Processing month"; Integer)
        {
            InitValue = 1;

            trigger OnValidate()
            begin
                IF "Salary Processing month" = 1 THEN
                    "Processing Month" := "Processing Month"::January;
                IF "Salary Processing month" = 2 THEN
                    "Processing Month" := "Processing Month"::February;
                IF "Salary Processing month" = 3 THEN
                    "Processing Month" := "Processing Month"::March;
                IF "Salary Processing month" = 4 THEN
                    "Processing Month" := "Processing Month"::April;
                IF "Salary Processing month" = 5 THEN
                    "Processing Month" := "Processing Month"::May;
                IF "Salary Processing month" = 6 THEN
                    "Processing Month" := "Processing Month"::June;
                IF "Salary Processing month" = 7 THEN
                    "Processing Month" := "Processing Month"::July;
                IF "Salary Processing month" = 8 THEN
                    "Processing Month" := "Processing Month"::August;
                IF "Salary Processing month" = 9 THEN
                    "Processing Month" := "Processing Month"::September;
                IF "Salary Processing month" = 10 THEN
                    "Processing Month" := "Processing Month"::October;
                IF "Salary Processing month" = 11 THEN
                    "Processing Month" := "Processing Month"::November;
                IF "Salary Processing month" = 12 THEN
                    "Processing Month" := "Processing Month"::December;
            end;
        }
        field(11; "Salary Processing Year"; Integer)
        {
        }
        field(14; "Default Attendance Type"; Option)
        {
            OptionMembers = ,Present,Absent;
        }
        field(17; "Employer PF"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(18; "Employer EPS"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(19; "PF Admin. Charges"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(20; "EDLI Charges"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(21; "Employer ESI"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(22; "Posted Payroll No."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(23; "Processing Month"; Option)
        {
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = January,February,March,April,May,June,July,August,September,October,November,December;

            trigger OnValidate()
            begin
                IF "Processing Month" = "Processing Month"::January THEN
                    "Salary Processing month" := 1;
                IF "Processing Month" = "Processing Month"::February THEN
                    "Salary Processing month" := 2;
                IF "Processing Month" = "Processing Month"::March THEN
                    "Salary Processing month" := 3;
                IF "Processing Month" = "Processing Month"::April THEN
                    "Salary Processing month" := 4;
                IF "Processing Month" = "Processing Month"::May THEN
                    "Salary Processing month" := 5;
                IF "Processing Month" = "Processing Month"::June THEN
                    "Salary Processing month" := 6;
                IF "Processing Month" = "Processing Month"::July THEN
                    "Salary Processing month" := 7;
                IF "Processing Month" = "Processing Month"::August THEN
                    "Salary Processing month" := 8;
                IF "Processing Month" = "Processing Month"::September THEN
                    "Salary Processing month" := 9;
                IF "Processing Month" = "Processing Month"::October THEN
                    "Salary Processing month" := 10;
                IF "Processing Month" = "Processing Month"::November THEN
                    "Salary Processing month" := 11;
                IF "Processing Month" = "Processing Month"::December THEN
                    "Salary Processing month" := 12;
            end;
        }
        field(24; Locked; Boolean)
        {
        }
        field(30; "Rounding Precision"; Decimal)
        {
            InitValue = 1;
            MaxValue = 100;
            MinValue = 0.0001;
        }
        field(31; "Rounding Type"; Option)
        {
            OptionMembers = "To the nearest value",Up,Down;
        }
        field(32; "RIFA Charges"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(37; "Min. No.of Years"; Decimal)
        {
        }
        field(38; "No.of Days Salary"; Integer)
        {
        }
        field(39; "No.of Days in Month"; Integer)
        {
        }
        field(42; "Cash Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(43; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(44; "Attmt. Storage Location"; Text[250])
        {
        }
        field(45; "Insurance ID"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(46; "TA Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(47; "TA No."; Code[20])
        {
            Enabled = false;
            TableRelation = "No. Series";
        }
        field(48; "Start Time with Grace Period"; Time)
        {
        }
        field(49; "Emp Leave Applicable Days"; Integer)
        {
        }
        field(50; "Payroll Journal Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(51; "Late Entry Ded. Allowed"; Boolean)
        {

            trigger OnValidate()
            begin
                IF NOT "Late Entry Ded. Allowed" THEN
                    "Start Time with Grace Period" := 0T;
            end;
        }
        field(52; Probation; Text[30])
        {
        }
        field(53; "Reporting Period"; Text[30])
        {
        }
        field(54; "OfferLetter Code"; Code[20])
        {
            Enabled = false;
            TableRelation = "No. Series".Code;
        }
        field(55; "Final Settlement Code"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(56; "Reopen Allow For Emp"; Boolean)
        {
        }
        field(57; "TDS calculation Based On"; Option)
        {
            OptionCaption = ' ,Gross Salary,Net Salary';
            OptionMembers = " ","Gross Salary","Net Salary";
        }
        field(58; "Head Hr Name"; Text[30])
        {
        }
        field(59; "TDS Employee Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(60; "TDS Employee Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("TDS Employee Template"));
        }
        field(61; "TDS Nature of Deduction"; Code[10])
        {
            Caption = 'TDS Nature of Deduction';
            //TableRelation = "TDS Nature of Deduction";
        }
        field(62; "TDS Assessee Code"; Code[10])
        {
            Caption = 'TDS Assessee Code';
            //TableRelation = "Assessee Code";
        }
        field(60000; "Visa Expences"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(60001; "Air Ticket Exp."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(60002; "No. of days less than 6 years"; Integer)
        {
        }
        field(60003; "No. of days Grea. than 6 years"; Integer)
        {
        }
        field(60004; "Start Time"; Time)
        {
        }
        field(60005; "Men Tax Rebate"; Decimal)
        {
        }
        field(60006; "Women Tax Rebate"; Decimal)
        {
        }
        field(60007; "Senior Citizen Tax Rebate"; Decimal)
        {
        }
        field(60008; "Interview No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(60009; "Intrewiewee No."; Code[10])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'Period start date should be less than or equal to %1';
        Text001: Label 'Month and Year in the ending date %1, should be equal to salary processing month %2 and year %3';
}

