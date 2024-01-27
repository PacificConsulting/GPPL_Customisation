table 60054 "Grade Transfer"
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {
        }
        field(2; "Employee Name"; Text[50])
        {
        }
        field(3; Grade; Code[30])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
        }
        field(4; "New Grade"; Code[30])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
        }
        field(5; "Document No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", Grade, "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    // [Scope('Internal')]
    procedure InsertGradePayElements(GradeTransfer: Record 60054)
    var
        PayRevisionHeader: Record 60048;
    begin
        PayRevisionHeader.SETRANGE("Id.", "Document No.");
        PayRevisionHeader.SETRANGE(Type, PayRevisionHeader.Type::Employee);
        PayRevisionHeader.SETRANGE("No.", "Employee No.");
        IF PayRevisionHeader.FIND('-') THEN
            GetPayCadrePayElements(PayRevisionHeader, "New Grade");
    end;

    //[Scope('Internal')]
    procedure GetPayCadrePayElements(PayRevisionHeader: Record 60048; NewGrade: Code[30])
    var
        PayCadrePayElement: Record 60026;
        PayCadrePayElement2: Record 60026;
        TempPayRevisionline: Record 60049;
        PayRevisionLine: Record 60049;
        HRSetup: Record 60016;
        CheckDate: Date;
        Flag: Boolean;
    begin
        IF HRSetup.FIND('-') THEN
            CheckDate := DMY2DATE(1, HRSetup."Salary Processing month", HRSetup."Salary Processing Year");
        IF PayRevisionHeader.Type = PayRevisionHeader.Type::Employee THEN BEGIN
            PayCadrePayElement.SETRANGE("Pay Cadre Code", NewGrade);
            PayCadrePayElement.SETRANGE(PayCadrePayElement.Processed, FALSE);
            IF PayCadrePayElement.FIND('-') THEN BEGIN
                REPEAT
                    Flag := FALSE;
                    PayCadrePayElement2.SETRANGE(PayCadrePayElement2.Processed, FALSE);
                    PayCadrePayElement2.SETRANGE("Pay Cadre Code", PayCadrePayElement."Pay Cadre Code");
                    PayCadrePayElement2.SETRANGE("Pay Element Code", PayCadrePayElement."Pay Element Code");
                    IF PayCadrePayElement2.FIND('-') THEN BEGIN
                        REPEAT
                            PayCadrePayElement2.Processed := TRUE;
                            PayCadrePayElement2.MODIFY;
                            IF PayCadrePayElement2."Effective Start Date" <= CheckDate THEN BEGIN
                                PayRevisionLine."No." := PayRevisionHeader."No.";
                                PayRevisionLine.Type := PayRevisionHeader.Type;
                                PayRevisionLine."Header No." := PayRevisionHeader."Id.";
                                PayRevisionLine.Grade := NewGrade;
                                PayRevisionLine."Line No." := PayRevisionLine."Line No." + 10000;
                                PayRevisionLine."Pay Element" := PayCadrePayElement2."Pay Element Code";
                                PayRevisionLine."Fixed / Percent" := PayCadrePayElement2."Fixed/Percent";
                                PayRevisionLine."Amount / Percent" := PayCadrePayElement2."Amount / Percent";
                                PayRevisionLine."Computation Type" := PayCadrePayElement2."Computation Type";
                                PayRevisionLine."Starting Date" := PayCadrePayElement2."Effective Start Date";
                                PayRevisionLine."Revised Date" := PayRevisionHeader."Revisied Date";
                                PayRevisionLine."Effective Date" := PayRevisionHeader."Effective Date";
                                PayRevisionLine."Revised Amount / Percent" := PayCadrePayElement2."Amount / Percent";
                                PayRevisionLine."Revised Fixed / Percent" := PayCadrePayElement2."Fixed/Percent";
                                PayRevisionLine."Revised Computation Type" := PayCadrePayElement2."Computation Type";
                                PayRevisionLine."Add/Deduct" := PayCadrePayElement2."Add/Deduct";
                                PayRevisionLine."Document Type" := PayRevisionLine."Document Type"::Payroll;
                            END;
                        UNTIL PayCadrePayElement2.NEXT = 0;
                        TempPayRevisionline.RESET;
                        TempPayRevisionline.SETRANGE("Header No.", PayRevisionLine."Header No.");
                        TempPayRevisionline.SETRANGE(Type, PayRevisionLine.Type);
                        TempPayRevisionline.SETRANGE("No.", PayRevisionLine."No.");
                        TempPayRevisionline.SETRANGE("Pay Element", PayRevisionLine."Pay Element");
                        IF TempPayRevisionline.FIND('-') THEN BEGIN
                            TempPayRevisionline."Revised Amount / Percent" := PayCadrePayElement2."Amount / Percent";
                            TempPayRevisionline."Revised Fixed / Percent" := PayCadrePayElement2."Fixed/Percent";
                            TempPayRevisionline."Revised Computation Type" := PayCadrePayElement2."Computation Type";
                            TempPayRevisionline."Add/Deduct" := PayCadrePayElement2."Add/Deduct";
                            TempPayRevisionline."Modified PayElement" := TRUE;
                            TempPayRevisionline.MODIFY;
                        END ELSE BEGIN
                            TempPayRevisionline."Pay Element" := PayRevisionLine."Pay Element";
                            TempPayRevisionline."Amount / Percent" := 0;
                            TempPayRevisionline."Revised Amount / Percent" := PayCadrePayElement2."Amount / Percent";
                            TempPayRevisionline."Revised Fixed / Percent" := PayCadrePayElement2."Fixed/Percent";
                            TempPayRevisionline."Revised Computation Type" := PayCadrePayElement2."Computation Type";
                            TempPayRevisionline."Add/Deduct" := PayCadrePayElement2."Add/Deduct";
                            TempPayRevisionline."Modified PayElement" := TRUE;
                            TempPayRevisionline.INSERT;
                            InsertDimensions(TempPayRevisionline);
                        END;
                    END;
                UNTIL PayCadrePayElement.NEXT = 0;
            END;
            TempPayRevisionline.RESET;
            TempPayRevisionline.SETRANGE("Header No.", PayRevisionLine."Header No.");
            TempPayRevisionline.SETRANGE(Type, PayRevisionLine.Type);
            TempPayRevisionline.SETRANGE("No.", PayRevisionLine."No.");
            TempPayRevisionline.SETRANGE("Modified PayElement", FALSE);
            IF TempPayRevisionline.FIND('-') THEN
                REPEAT
                    TempPayRevisionline."Revised Amount / Percent" := 0;
                    TempPayRevisionline.MODIFY;
                UNTIL TempPayRevisionline.NEXT = 0;
            PayRevisionHeader."New Grade" := NewGrade;
            PayRevisionHeader.MODIFY;
        END;
    end;

    // [Scope('Internal')]
    procedure "----Dimensions------"()
    begin
    end;

    //  [Scope('Internal')]
    procedure InsertDimensions(PayRevisionLine: Record 60049)
    begin
        PayRevisionLine.VALIDATE("No.");
    end;
}

