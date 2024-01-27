tableextension 50049 ShippingAgent extends 291
{
    fields
    {
        // field(50000; "GST Registration No."; Code[15])
        // {
        //     Caption = 'GST Registration No.';
        //     Description = 'RSPLSUM 19Mar2020';

        //     trigger OnValidate()
        //     begin
        //         IF "GST Registration No." <> '' THEN
        //             CheckGSTRegistrationNo("GST Registration No.");
        //     end;
        // }
    }


    trigger OnBeforeInsert()
    var
        myInt: Integer;
    begin
        //RSPLSUM30Apr21


        RecUserSetup.RESET;
        IF RecUserSetup.GET(USERID) THEN BEGIN
            IF NOT RecUserSetup."Shipping Agent List Editable" THEN
                ERROR('You do not have permission, please contact system administrator');
        END;
        //RSPLSUM30Apr21
    end;

    trigger OnBeforeDelete()
    var
        myInt: Integer;
    begin
        //RSPLSUM30Apr21


        RecUserSetup.RESET;
        IF RecUserSetup.GET(USERID) THEN BEGIN
            IF NOT RecUserSetup."Shipping Agent List Editable" THEN
                ERROR('You do not have permission, please contact system administrator');
        END;
        //RSPLSUM30Apr21
    end;

    trigger OnBeforeModify()
    var
        myInt: Integer;
    begin
        //RSPLSUM30Apr21


        RecUserSetup.RESET;
        IF RecUserSetup.GET(USERID) THEN BEGIN
            IF NOT RecUserSetup."Shipping Agent List Editable" THEN
                ERROR('You do not have permission, please contact system administrator');
        END;
        //RSPLSUM30Apr21
    end;

    trigger OnBeforeRename()
    var
        myInt: Integer;
    begin
        //RSPLSUM30Apr21


        RecUserSetup.RESET;
        IF RecUserSetup.GET(USERID) THEN BEGIN
            IF NOT RecUserSetup."Shipping Agent List Editable" THEN
                ERROR('You do not have permission, please contact system administrator');
        END;
        //RSPLSUM30Apr21
    end;



    var
        myInt: Integer;
        LengthErr: Label 'The Length of the GST Registration Nos. must be 15.';
        OnlyAlphabetErr: Label 'Only Alphabet is allowed in the position %1.', Comment = '%1 = Integer';
        OnlyNumericErr: Label 'Only Numeric is allowed in the position %1.', Comment = '%1 = Integer';
        OnlyAlphaNumericErr: Label 'Only AlphaNumeric is allowed in the position %1.', Comment = '%1 = Integer';
        RecUserSetup: Record 91;

    procedure CheckGSTRegistrationNo(RegistrationNo: Code[15])
    var
        Position: Integer;
    begin
        IF RegistrationNo = '' THEN
            EXIT;
        IF STRLEN(RegistrationNo) <> 15 THEN
            ERROR(LengthErr);
        FOR Position := 3 TO 15 DO
            CASE Position OF
                3 .. 7, 12:
                    CheckIsAlphabet(RegistrationNo, Position);
                8 .. 11:
                    CheckIsNumeric(RegistrationNo, Position);
                13 .. 15:
                    CheckIsAlphaNumeric(RegistrationNo, Position)
            END;
    end;

    local procedure CheckIsAlphabet(RegistrationNo: Code[15]; Position: Integer)
    begin
        IF NOT (COPYSTR(RegistrationNo, Position, 1) IN ['A' .. 'Z']) THEN
            ERROR(OnlyAlphabetErr, Position);
    end;

    local procedure CheckIsNumeric(RegistrationNo: Code[15]; Position: Integer)
    begin
        IF NOT (COPYSTR(RegistrationNo, Position, 1) IN ['0' .. '9']) THEN
            ERROR(OnlyNumericErr, Position);
    end;

    local procedure CheckIsAlphaNumeric(RegistrationNo: Code[15]; Position: Integer)
    begin
        IF NOT ((COPYSTR(RegistrationNo, Position, 1) IN ['0' .. '9']) OR (COPYSTR(RegistrationNo, Position, 1) IN ['A' .. 'Z'])) THEN
            ERROR(OnlyAlphaNumericErr, Position);
    end;
}