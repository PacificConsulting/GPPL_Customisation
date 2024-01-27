table 60026 "Pay Cadre Pay Element"
{
    // B2B Software Technologies
    // -------------------------------
    // Project : Human Resource
    // B2B
    // No. sign      Date
    // -------------------------------
    // 01   B2B    18-Mar-06


    fields
    {
        field(2; "Pay Cadre Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
        }
        field(3; "Fixed/Percent"; Option)
        {
            OptionMembers = "Fixed",Percent;

            trigger OnValidate()
            begin
                IF "Pay Element Code" = 'BASIC' THEN
                    IF "Fixed/Percent" = "Fixed/Percent"::Percent THEN
                        ERROR(Text001);
            end;
        }
        field(4; "Computation Type"; Code[50])
        {
            NotBlank = true;
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('COMPUTATION TYPE'));

            trigger OnValidate()
            begin
                IF "Fixed/Percent" = "Fixed/Percent"::Percent THEN
                    IF ("Computation Type" = 'NON ATTENDANCE') OR ("Computation Type" = 'ON ATTENDANCE') THEN
                        ERROR(Text002);
                IF "Pay Element Code" = 'DA' THEN
                    IF "Computation Type" = 'AFTER BASIC AND DA' THEN
                        ERROR(Text003);
                IF "Pay Element Code" = 'BASIC' THEN
                    IF ("Computation Type" = 'AFTER BASIC') OR ("Computation Type" = 'AFTER BASIC AND DA') OR
                       ("Computation Type" = 'NON ATTENDANCE')
                    THEN
                        ERROR(Text005);
            end;
        }
        field(5; "Pay Element Code"; Code[30])
        {
            NotBlank = true;
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('ADDITIONS AND DEDUCTIONS'));

            trigger OnValidate()
            begin
                IF ("Pay Element Code" = 'TDS') OR ("Pay Element Code" = 'PF') OR
                   ("Pay Element Code" = 'PT') OR ("Pay Element Code" = 'ESI') OR ("Pay Element Code" = 'LOAN') OR
                   ("Pay Element Code" = 'OT') OR ("Pay Element Code" = 'LEAVE ENCASHMENT')
                THEN
                    ERROR(Text006);

                Lookup.SETRANGE("Lookup Name", "Pay Element Code");
                IF Lookup.FIND('-') THEN BEGIN
                    "Add/Deduct" := Lookup."Add/Deduct";
                    "Applicable for OT" := Lookup."Applicable for OT";
                    ESI := Lookup.ESI;
                    PF := Lookup.PF;
                    "Leave Encashment" := Lookup."Leave Encashment";
                    IF "Pay Element Code" = 'BASIC' THEN
                        "Computation Type" := 'ON ATTENDANCE';
                END;
            end;
        }
        field(6; "Loan Priority No"; Integer)
        {
        }
        field(11; "Amount / Percent"; Decimal)
        {
        }
        field(12; "Add/Deduct"; Option)
        {
            OptionMembers = " ",Addition,Deduction;
        }
        field(13; "Effective Start Date"; Date)
        {
        }
        field(14; "Applicable for OT"; Boolean)
        {
        }
        field(15; Processed; Boolean)
        {
        }
        field(16; ESI; Option)
        {
            OptionMembers = " ","Regular Element","Irregular Element";

            trigger OnValidate()
            var
                PayElement: Record 60025;
            begin
                Lookup.RESET;
                Lookup.SETRANGE("Lookup Name", "Pay Element Code");
                IF Lookup.FIND('-') THEN
                    REPEAT
                        ESI := Lookup.ESI;
                        PayElement.MODIFY;
                    UNTIL Lookup.NEXT = 0;
            end;
        }
        field(17; PF; Boolean)
        {
        }
        field(18; "Leave Encashment"; Boolean)
        {
        }
        field(19; "Bonus/Exgratia"; Option)
        {
            OptionMembers = " ",Bonus,"Ex-gratia",Both;
        }
        field(20; Gratuity; Boolean)
        {
        }
        field(21; PT; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Pay Cadre Code", "Effective Start Date", "Pay Element Code")
        {
            Clustered = true;
        }
        key(Key2; "Computation Type")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Lookup: Record 60018;
        Text001: Label 'Basic Should be  Fixed Amount';
        Text002: Label 'Computation Type must be After Basic OR After Basic and DA';
        Text003: Label 'Computation Type must not be After Basic and DA';
        Text005: Label 'Computation Type must be ON Attendance';
        Text006: Label 'System defined pay element should not be selected.';
}

