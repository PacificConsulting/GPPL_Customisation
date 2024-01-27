table 60034 "Pay Deductions"
{
    // 21-Apr-06

    DrillDownPageID = 60028;
    LookupPageID = 60028;

    fields
    {
        field(1; "Pay Element code"; Code[30])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('ADDITIONS AND DEDUCTIONS'));

            trigger OnValidate()
            begin
                IF ("Pay Element code" = 'TDS') OR ("Pay Element code" = 'PF') OR
                   ("Pay Element code" = 'PT') OR ("Pay Element code" = 'ESI') OR ("Pay Element code" = 'LOAN') OR
                   ("Pay Element code" = 'OT') OR ("Pay Element code" = 'LEAVE ENCASHMENT')
                THEN
                    ERROR(Text000);

                Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                Lookup.SETRANGE("Lookup Name", "Pay Element code");
                IF Lookup.FIND('-') THEN BEGIN
                    Description := Lookup.Description;
                    "Add/Deduct" := Lookup."Add/Deduct";
                    Priority := Lookup.Priority;
                END;
            end;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Add/Deduct"; Option)
        {
            OptionMembers = " ",Addition,Deduction;
        }
        field(4; Priority; Integer)
        {
        }
        field(5; Type; Option)
        {
            OptionCaption = ' ,Canteen,Holiday Compensation,OT,Late Coming,Others';
            OptionMembers = " ",Canteen,"Holiday Compensation",OT,"Late Coming",Others;
        }
    }

    keys
    {
        key(Key1; "Pay Element code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'System defined pay element should not be selected.';
        Lookup: Record 60018;
}

