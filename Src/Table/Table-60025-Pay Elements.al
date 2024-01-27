table 60025 "Pay Elements"
{
    // B2B Software Technologies
    // ------------------------------
    // Project : Human Resource
    // B2B
    // No. sign      Date
    // ------------------------------
    // 01   B2B    14-dec-05


    fields
    {
        field(2; "Employee Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Employee_;
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
                        ERROR(Text004);

                //EBT
                IF "Amount / Percent" <> 0 THEN
                    VALIDATE("Amount / Percent");
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
                    ERROR(Text005);

                Lookup.SETRANGE("Lookup Name", "Pay Element Code");
                IF Lookup.FIND('-') THEN BEGIN
                    "Add/Deduct" := Lookup."Add/Deduct";
                    "Applicable for OT" := Lookup."Applicable for OT";
                    ESI := Lookup.ESI;
                    PF := Lookup.PF;
                    PT := Lookup.PT;
                    "Leave Encashment" := Lookup."Leave Encashment";
                    IF "Pay Element Code" = 'BASIC' THEN
                        "Computation Type" := 'ON ATTENDANCE';
                END;
                IF Employee.GET("Employee Code") THEN
                    "Pay Cadre" := Employee."Pay Cadre";
            end;
        }
        field(6; "Loan Priority No"; Integer)
        {
        }
        field(11; "Amount / Percent"; Decimal)
        {

            trigger OnValidate()
            begin
                //EBT Paramita
                IF "Fixed/Percent" = "Fixed/Percent"::Fixed THEN BEGIN
                    IF "Add/Deduct" = "Add/Deduct"::Addition THEN
                        "Actual Amount" := "Amount / Percent"
                    ELSE
                        IF "Add/Deduct" = "Add/Deduct"::Deduction THEN
                            "Actual Amount" := -"Amount / Percent";
                END
                ELSE
                    IF "Fixed/Percent" = "Fixed/Percent"::Percent THEN BEGIN
                        IF "Computation Type" = 'AFTER BASIC' THEN BEGIN
                            PayelementsRec.RESET;
                            PayelementsRec.SETRANGE("Employee Code", "Employee Code");
                            PayelementsRec.SETFILTER("Effective Start Date", '<=%1', TODAY);
                            PayelementsRec.SETRANGE("Pay Element Code", 'BASIC');
                            IF PayelementsRec.FINDFIRST THEN BEGIN
                                AmountAct := (PayelementsRec."Amount / Percent" * "Amount / Percent") / 100;
                                IF "Add/Deduct" = "Add/Deduct"::Addition THEN
                                    "Actual Amount" := AmountAct
                                ELSE
                                    IF "Add/Deduct" = "Add/Deduct"::Deduction THEN
                                        "Actual Amount" := -AmountAct;
                            END;
                        END
                        ELSE
                            IF "Computation Type" = 'AFTER BASIC AND DA' THEN BEGIN
                                PayelementsRec.RESET;
                                PayelementsRec.SETRANGE("Employee Code", "Employee Code");
                                PayelementsRec.SETFILTER("Effective Start Date", '<=%1', TODAY);
                                PayelementsRec.SETRANGE("Pay Element Code", 'BASIC');
                                IF PayelementsRec.FINDFIRST THEN
                                    BasicAmnt := PayelementsRec."Actual Amount";
                                PayelementsRec.RESET;
                                PayelementsRec.SETRANGE("Employee Code", "Employee Code");
                                PayelementsRec.SETFILTER("Effective Start Date", '<=%1', TODAY);
                                PayelementsRec.SETRANGE("Pay Element Code", 'DA');
                                IF PayelementsRec.FINDFIRST THEN
                                    DAAmt := PayelementsRec."Actual Amount";
                                AmountAct := ((BasicAmnt + DAAmt) * "Amount / Percent") / 100;
                                IF "Add/Deduct" = "Add/Deduct"::Addition THEN
                                    "Actual Amount" := AmountAct
                                ELSE
                                    IF "Add/Deduct" = "Add/Deduct"::Deduction THEN
                                        "Actual Amount" := -AmountAct;
                            END;

                    END;
                //EBT Paramita
            end;
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
            end;
        }
        field(17; PF; Boolean)
        {
        }
        field(18; "Leave Encashment"; Boolean)
        {
        }
        field(19; "Pay Cadre"; Code[30])
        {
        }
        field(20; "Date Filter"; Date)
        {
        }
        field(21; "Bonus/Exgratia"; Option)
        {
            OptionMembers = " ",Bonus,"Ex-gratia",Both;
        }
        field(22; Gratuity; Boolean)
        {
        }
        field(23; PT; Boolean)
        {
        }
        field(24; "Actual Amount"; Decimal)
        {
        }
        field(25; Show; Boolean)
        {
            Description = 'For Payroll Dashboard';
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Effective Start Date", "Pay Element Code")
        {
            Clustered = true;
        }
        key(Key2; "Computation Type")
        {
        }
        key(Key3; "Employee Code", "Pay Element Code")
        {
        }
        key(Key4; "Effective Start Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record 60019;
        Lookup: Record 60018;
        Text001: Label 'Basic Should be  Fixed Amount';
        Text002: Label 'Computation Type must be After Basic OR After Basic and DA';
        Text003: Label 'Computation Type must not be After Basic and DA';
        Text004: Label 'Computation Type must be ON Attendance';
        Text005: Label 'system defined pay element should not be selected.';
        AmountAct: Decimal;
        PayelementsRec: Record 60025;
        BasicAmnt: Decimal;
        DAAmt: Decimal;
}

