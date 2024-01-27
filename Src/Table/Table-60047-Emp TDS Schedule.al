table 60047 "Emp TDS Schedule"
{
    // 14-Feb-06


    fields
    {
        field(1; "Employee No."; Code[20])
        {
        }
        field(2; "Year Starting Date"; Date)
        {
        }
        field(3; "Year Ending Date"; Date)
        {
        }
        field(4; Month; Integer)
        {
        }
        field(5; "TDS Amount"; Decimal)
        {
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                IF Processes = TRUE THEN
                    ERROR(Text000);
                IF Month = 0 THEN
                    ERROR(Text002);
            end;
        }
        field(6; "TDS Amount Deducted"; Decimal)
        {
            //FieldClass = FlowField;
            // CalcFormula = Lookup("Processed Salary"."Earned Amount" WHERE("Employee Code" = FIELD("Employee No."),
            //                                                                "Add/Deduct Code" = CONST('TDS DED'),
            //                                                                "Pay Slip Month" = FIELD(Month),
            //                                                                Year = FIELD(Year)));

        }
        field(7; Year; Integer)
        {
        }
        field(8; Processes; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", Year, Month, "Year Starting Date", "Year Ending Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'TDS Amount is already processed , so you can''t modify ';
        Text001: Label 'Total TDS Amount must be equal to %1 for the employee %2';
        Text002: Label 'You are not allowed to define the TDS Amount ';

    // [Scope('Internal')]
    procedure TDSTotalCheck()
    var
        TDSSchedule: Record 60047;
        TDSDeduction: Record 60046;
        TotalAmount: Decimal;
    begin
        IF TDSDeduction.FIND('-') THEN
            REPEAT
                TDSSchedule.SETRANGE("Employee No.", TDSDeduction."Employee No.");
                TDSSchedule.SETRANGE("Year Starting Date", TDSDeduction."Year Starting Date");
                TDSSchedule.SETRANGE("Year Ending Date", TDSDeduction."Year Ending Date");
                IF TDSSchedule.FIND('-') THEN
                    REPEAT
                        TotalAmount := TotalAmount + TDSSchedule."TDS Amount";
                    UNTIL TDSSchedule.NEXT = 0;
                IF TotalAmount <> TDSDeduction."Tax Liability after savings" THEN
                    ERROR(Text001, TDSDeduction."Tax Liability after savings", TDSDeduction."Employee No.");
            UNTIL TDSDeduction.NEXT = 0;
    end;
}

