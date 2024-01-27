table 50014 "Transport Subsidy Setup New"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Starting Range (KMS)"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "Starting Range (KMS)" <> 0 THEN BEGIN
                    recTransportSubsidyRateSetup.RESET;
                    recTransportSubsidyRateSetup.SETCURRENTKEY("Starting Range (KMS)");
                    recTransportSubsidyRateSetup.SETFILTER(Code, '<>%1', Code);
                    recTransportSubsidyRateSetup.SETFILTER("Ending Range (KMS)", '>=%1', "Starting Range (KMS)");
                    IF recTransportSubsidyRateSetup.FINDSET THEN
                        REPEAT
                            IF recTransportSubsidyRateSetup."Starting Range (KMS)" <= "Starting Range (KMS)" THEN
                                ERROR('Starting Range (KMS) Alredy Defined');
                        UNTIL recTransportSubsidyRateSetup.NEXT = 0;
                END
            end;
        }
        field(3; "Ending Range (KMS)"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "Ending Range (KMS)" <> 0 THEN BEGIN
                    recTransportSubsidyRateSetup.RESET;
                    recTransportSubsidyRateSetup.SETCURRENTKEY("Starting Range (KMS)");
                    recTransportSubsidyRateSetup.SETFILTER(Code, '<>%1', Code);
                    recTransportSubsidyRateSetup.SETFILTER("Starting Range (KMS)", '<=%1', "Ending Range (KMS)");
                    IF recTransportSubsidyRateSetup.FINDSET THEN
                        REPEAT
                            IF recTransportSubsidyRateSetup."Ending Range (KMS)" >= "Ending Range (KMS)" THEN
                                ERROR('Ending Range (KMS) Already Defined');
                        UNTIL recTransportSubsidyRateSetup.NEXT = 0;
                END
            end;
        }
        field(4; "Rate (Rs.)"; Decimal)
        {
        }
        field(5; "Line No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Starting Range (KMS)")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR(Text001);//RSPLDP
    end;

    var
        recTransportSubsidyRateSetup: Record 50014;
        Text001: Label 'Please contact system adminstrator';
}

