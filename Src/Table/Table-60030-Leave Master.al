table 60030 "Leave Master"
{
    // Date: 09-Jan-06

    DrillDownPageID = 60021;
    LookupPageID = 60021;

    fields
    {
        field(1; "Leave Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "No. of Leaves in Year"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "No. of Leaves in Year" <= 0 THEN
                    ERROR(Text000);
            end;
        }
        field(4; "Crediting Interval"; DateFormula)
        {
        }
        field(5; "Crediting Type"; Option)
        {
            OptionMembers = "Before the Period","After the Period";
        }
        field(6; "Minimum Allowed"; Decimal)
        {
        }
        field(7; "Maximum Allowed"; Decimal)
        {
        }
        field(8; "Carry Forward"; Boolean)
        {
        }
        field(9; "Applicable Date"; Date)
        {
        }
        field(10; "Max.Leaves to Carry Forward"; Decimal)
        {

            trigger OnValidate()
            begin
                IF NOT "Carry Forward" THEN BEGIN
                    IF "Max.Leaves to Carry Forward" <> 0 THEN
                        ERROR('Carry Forward is not allowed for this leave type');
                END
                ELSE BEGIN
                    IF "Max.Leaves to Carry Forward" > "No. of Leaves in Year" THEN
                        ERROR('You can not enter a value greater than %1', "No. of Leaves in Year");
                END;
            end;
        }
        field(11; "Applicable During Probation"; Boolean)
        {
        }
        field(12; "No.of Leaves During Probation"; Decimal)
        {

            trigger OnValidate()
            begin
                IF NOT "Applicable During Probation" THEN BEGIN
                    IF "No.of Leaves During Probation" <> 0 THEN
                        ERROR('This Leave is not applicable during probition');
                END
                ELSE BEGIN
                    IF "No.of Leaves During Probation" > "No. of Leaves in Year" THEN
                        ERROR('You can not enter a value greater than %1', "No. of Leaves in Year");
                END;
            end;
        }
        field(13; Encashable; Boolean)
        {
        }
        field(14; "Max. Encashable"; Decimal)
        {

            trigger OnValidate()
            begin
                IF NOT Encashable THEN BEGIN
                    IF "Max. Encashable" <> 0 THEN
                        ERROR('Encashable is not allowed for this leave type');
                END
                ELSE BEGIN
                    IF "Max. Encashable" > "No. of Leaves in Year" THEN
                        ERROR('You can not enter a value greater than %1', "No. of Leaves in Year");
                END;
            end;
        }
        field(15; "Min. Encashable"; Decimal)
        {
        }
        field(16; "Encashment in excess of."; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Leave Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'Number of leaves should be greaterthan zero';
}

