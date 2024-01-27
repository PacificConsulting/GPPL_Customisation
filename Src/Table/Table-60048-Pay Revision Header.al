table 60048 "Pay Revision Header"
{
    DrillDownPageID = 60047;
    LookupPageID = 60047;

    fields
    {
        field(1; "Id."; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                TestStatus;
            end;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee_;
        }
        field(3; "Employee Name"; Text[50])
        {
        }
        field(4; Grade; Code[30])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
        }
        field(5; "Effective Date"; Date)
        {

            trigger OnValidate()
            var
                PayRevisionLine: Record 60049;
            begin
                PayRevisionLine.SETRANGE(Type, Type);
                PayRevisionLine.SETRANGE("Header No.", "Id.");
                PayRevisionLine.SETRANGE("No.", "No.");
                IF PayRevisionLine.FIND('-') THEN
                    REPEAT
                        PayRevisionLine."Effective Date" := "Effective Date";
                        PayRevisionLine.MODIFY;
                    UNTIL PayRevisionLine.NEXT = 0;
            end;
        }
        field(6; "New Grade"; Code[30])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
        }
        field(7; "Revisied Date"; Date)
        {
        }
        field(8; Type; Option)
        {
            OptionMembers = Employee,Grade;

            trigger OnValidate()
            var
                PayRevisionLine: Record 60049;
            begin
                TestStatus;
                Confirmed := CONFIRM(Text000, FALSE, FIELDCAPTION(Type));
                IF Confirmed THEN BEGIN
                    PayRevisionLine.SETRANGE(Type, xRec.Type);
                    PayRevisionLine.SETRANGE("Header No.", "Id.");
                    PayRevisionLine.SETRANGE("No.", xRec."No.");
                    IF PayRevisionLine.FIND('-') THEN
                        PayRevisionLine.DELETEALL;
                    "No." := ''
                END ELSE
                    Type := xRec.Type;
            end;
        }
        field(9; "No."; Code[30])
        {
            TableRelation = IF (Type = CONST(Grade)) "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE')) ELSE
            IF (Type = CONST(Employee)) Employee_;

            trigger OnValidate()
            var
                PayRevisionLine: Record 60049;
            begin
                TestStatus;
                IF Type = Type::Grade THEN BEGIN
                    PayRevisionLine.SETRANGE("Header No.", "Id.");
                    PayRevisionLine.SETRANGE(Type, xRec.Type);
                    PayRevisionLine.SETRANGE("No.", xRec."No.");
                    IF PayRevisionLine.FIND('-') THEN
                        PayRevisionLine.DELETEALL;

                    GetPayCadrePayElements(Rec);

                    PayCadrePayElement.RESET;
                    IF PayCadrePayElement.FIND('-') THEN
                        REPEAT
                            PayCadrePayElement.Processed := FALSE;
                            PayCadrePayElement.MODIFY;
                        UNTIL PayCadrePayElement.NEXT = 0;

                END ELSE BEGIN
                    IF Employee.GET("No.") THEN BEGIN
                        "Employee Name" := Employee."First Name";
                        Grade := Employee."Pay Cadre";
                    END;

                    PayRevisionLine.SETRANGE("Header No.", "Id.");
                    PayRevisionLine.SETRANGE(Type, xRec.Type);
                    PayRevisionLine.SETRANGE("No.", xRec."No.");
                    IF PayRevisionLine.FIND('-') THEN
                        PayRevisionLine.DELETEALL;

                    GetEmpPayElements(Rec);

                    PayElement.RESET;
                    IF PayElement.FIND('-') THEN
                        REPEAT
                            PayElement.Processed := FALSE;
                            PayElement.MODIFY;
                        UNTIL PayElement.NEXT = 0;
                END;
            end;
        }
        field(10; Status; Option)
        {
            OptionMembers = Open,Released;
        }
        field(11; "Journal Template Name"; Code[20])
        {
        }
        field(12; "Journal Batch Name"; Code[20])
        {
        }
        field(13; "Posting Date"; Date)
        {
        }
        field(14; "Document No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Id.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        PayRevisionLine: Record 60049;
    begin
        TestStatus;
        PayRevisionLine.SETRANGE("Header No.", "Id.");
        PayRevisionLine.SETRANGE(Type, Type);
        PayRevisionLine.SETRANGE("No.", "No.");
        IF PayRevisionLine.FIND('-') THEN
            PayRevisionLine.DELETEALL;
    end;

    trigger OnInsert()
    begin
        TestStatus;
        "Revisied Date" := WORKDATE;
    end;

    trigger OnRename()
    begin
        TestStatus;
    end;

    var
        Text000: Label 'Do you want change the %1';
        Employee: Record 60019;
        PayElement: Record 60025;
        PayElement2: Record 60025;
        Text001: Label 'Posted';
        Text002: Label 'Please check Records';
        PayCadrePayElement: Record 60026;
        Confirmed: Boolean;

    // [Scope('Internal')]
    procedure GetEmpPayElements(PayRevisionHeader: Record 60048)
    var
        PayElement: Record 60025;
        PayElement2: Record 60025;
        PayRevisionLine: Record 60049;
        HRSetup: Record 60016;
        CheckDate: Date;
    begin
        IF HRSetup.FIND('-') THEN
            CheckDate := DMY2DATE(1, HRSetup."Salary Processing month", HRSetup."Salary Processing Year");
        IF PayRevisionHeader.Type = PayRevisionHeader.Type::Employee THEN BEGIN
            PayElement.SETFILTER("Effective Start Date", '<=%1', CheckDate);
            PayElement.SETRANGE("Employee Code", PayRevisionHeader."No.");
            PayElement.SETRANGE(PayElement.Processed, FALSE);
            IF PayElement.FIND('-') THEN BEGIN
                REPEAT
                    PayElement2.SETRANGE(PayElement2.Processed, FALSE);
                    PayElement2.SETRANGE("Employee Code", PayElement."Employee Code");
                    PayElement2.SETRANGE("Pay Element Code", PayElement."Pay Element Code");
                    IF PayElement2.FIND('-') THEN BEGIN
                        REPEAT
                            PayElement2.Processed := TRUE;
                            PayElement2.MODIFY;
                            IF PayElement2."Effective Start Date" <= CheckDate THEN BEGIN
                                PayRevisionLine."Header No." := PayRevisionHeader."Id.";
                                PayRevisionLine."No." := PayRevisionHeader."No.";
                                PayRevisionLine.Type := PayRevisionHeader.Type;
                                PayRevisionLine."Line No." := PayRevisionLine."Line No." + 10000;
                                PayRevisionLine."Pay Element" := PayElement2."Pay Element Code";
                                PayRevisionLine."Fixed / Percent" := PayElement2."Fixed/Percent";
                                PayRevisionLine."Amount / Percent" := PayElement2."Amount / Percent";
                                PayRevisionLine."Computation Type" := PayElement2."Computation Type";
                                PayRevisionLine."Starting Date" := PayElement2."Effective Start Date";
                                PayRevisionLine.Grade := PayElement."Pay Cadre";
                                PayRevisionLine."Employee Name" := PayRevisionHeader."Employee Name";
                                PayRevisionLine."Revised Date" := PayRevisionHeader."Revisied Date";
                                PayRevisionLine."Effective Date" := PayRevisionHeader."Effective Date";
                                PayRevisionLine."Revised Amount / Percent" := PayElement2."Amount / Percent";
                                PayRevisionLine."Revised Fixed / Percent" := PayElement2."Fixed/Percent";
                                PayRevisionLine."Revised Computation Type" := PayElement2."Computation Type";
                                PayRevisionLine."Add/Deduct" := PayElement2."Add/Deduct";
                                PayRevisionLine."Document Type" := PayRevisionLine."Document Type"::Payroll;
                            END;
                        UNTIL PayElement2.NEXT = 0;
                        IF PayRevisionLine."Amount / Percent" <> 0 THEN BEGIN
                            PayRevisionLine.INSERT;
                            //InsertDimensions(PayRevisionLine);
                        END;

                    END;
                UNTIL PayElement.NEXT = 0;
            END;
        END;
    end;

    // [Scope('Internal')]
    procedure GetPayCadrePayElements(PayRevisionHeader: Record 60048)
    var
        PayCadrePayElement: Record 60026;
        PayCadrePayElement2: Record 60026;
        PayRevisionLine: Record 60049;
        HRSetup: Record 60016;
        CheckDate: Date;
    begin
        IF HRSetup.FIND('-') THEN
            CheckDate := DMY2DATE(1, HRSetup."Salary Processing month", HRSetup."Salary Processing Year");
        IF PayRevisionHeader.Type = PayRevisionHeader.Type::Grade THEN BEGIN
            PayCadrePayElement.SETRANGE("Pay Cadre Code", PayRevisionHeader."No.");
            PayCadrePayElement.SETRANGE(PayCadrePayElement.Processed, FALSE);
            IF PayCadrePayElement.FIND('-') THEN BEGIN
                REPEAT
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
                                PayRevisionLine.Grade := PayCadrePayElement2."Pay Cadre Code";
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
                        IF PayRevisionLine."Amount / Percent" <> 0 THEN BEGIN
                            PayRevisionLine.INSERT;
                            //InsertDimensions(PayRevisionLine);
                        END;
                    END;
                UNTIL PayCadrePayElement.NEXT = 0;
            END;
        END;
    end;

    // [Scope('Internal')]
    procedure PostPayRevision(PayRevisionHeader: Record 60048)
    var
        MonAttendance: Record 60029;
        PayRevisionLine: Record 60049;
        PayElement: Record 60025;
        PayCadrePayElement: Record 60026;
        GradeTransMonth: Integer;
        GradeTransYear: Integer;
    begin
        TestStatus;
        PayRevisionHeader.TESTFIELD(PayRevisionHeader."Effective Date");
        IF PayRevisionHeader.Type = PayRevisionHeader.Type::Employee THEN BEGIN
            PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
            PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
            PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
            IF PayRevisionLine.FIND('-') THEN
                REPEAT
                    PayRevisionLine.TESTFIELD(PayRevisionLine."Effective Date");
                    PayElement.INIT;
                    PayElement."Employee Code" := PayRevisionLine."No.";
                    PayElement."Effective Start Date" := PayRevisionLine."Effective Date";
                    PayElement."Pay Element Code" := PayRevisionLine."Pay Element";
                    PayElement."Fixed/Percent" := PayRevisionLine."Revised Fixed / Percent";
                    PayElement."Computation Type" := PayRevisionLine."Revised Computation Type";
                    PayElement."Amount / Percent" := PayRevisionLine."Revised Amount / Percent";
                    PayElement."Add/Deduct" := PayRevisionLine."Add/Deduct";
                    IF PayRevisionHeader."New Grade" <> '' THEN
                        PayElement."Pay Cadre" := PayRevisionHeader."New Grade"
                    ELSE
                        PayElement."Pay Cadre" := PayRevisionLine.Grade;
                    PayElement.INSERT;
                UNTIL PayRevisionLine.NEXT = 0;

            IF PayRevisionHeader."New Grade" <> '' THEN BEGIN
                Employee.SETRANGE("No.", PayRevisionHeader."No.");
                IF Employee.FIND('-') THEN BEGIN
                    Employee."Pay Cadre" := PayRevisionHeader."New Grade";
                    Employee.MODIFY;
                END;

                GradeTransMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
                GradeTransYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);

                MonAttendance.SETRANGE("Employee Code", PayRevisionHeader."No.");
                MonAttendance.SETFILTER("Pay Slip Month", '>=%1', GradeTransMonth);
                MonAttendance.SETFILTER(Year, '>=%1', GradeTransYear);
                IF MonAttendance.FIND('-') THEN
                    REPEAT
                        MonAttendance.PayCadre := PayRevisionHeader."New Grade";
                        MonAttendance.MODIFY;
                    UNTIL MonAttendance.NEXT = 0;
            END;
        END;

        IF PayRevisionHeader.Type = PayRevisionHeader.Type::Grade THEN BEGIN
            PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
            PayRevisionLine.SETRANGE(Type, PayRevisionHeader.Type);
            PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
            IF PayRevisionLine.FIND('-') THEN
                REPEAT
                    PayRevisionLine.TESTFIELD(PayRevisionLine."Effective Date");
                    PayCadrePayElement.INIT;
                    PayCadrePayElement."Pay Cadre Code" := PayRevisionLine."No.";
                    PayCadrePayElement."Effective Start Date" := PayRevisionLine."Effective Date";
                    PayCadrePayElement."Pay Element Code" := PayRevisionLine."Pay Element";
                    PayCadrePayElement."Fixed/Percent" := PayRevisionLine."Revised Fixed / Percent";
                    PayCadrePayElement."Computation Type" := PayRevisionLine."Revised Computation Type";
                    PayCadrePayElement."Amount / Percent" := PayRevisionLine."Revised Amount / Percent";
                    PayCadrePayElement."Add/Deduct" := PayRevisionLine."Add/Deduct";
                    PayCadrePayElement.INSERT;

                    Employee.RESET;
                    Employee.SETRANGE("No.", PayRevisionHeader."No."); //VE-003
                    IF Employee.FIND('-') THEN
                        REPEAT
                            PayElement2.INIT;
                            PayElement2."Employee Code" := Employee."No.";
                            PayElement2."Effective Start Date" := PayRevisionLine."Effective Date";
                            PayElement2."Pay Element Code" := PayRevisionLine."Pay Element";
                            PayElement2."Fixed/Percent" := PayRevisionLine."Revised Fixed / Percent";
                            PayElement2."Computation Type" := PayRevisionLine."Revised Computation Type";
                            PayElement2."Amount / Percent" := PayRevisionLine."Revised Amount / Percent";
                            PayElement2."Pay Cadre" := PayRevisionLine.Grade;
                            PayElement2."Add/Deduct" := PayRevisionLine."Add/Deduct";
                            PayElement2.INSERT;
                        UNTIL Employee.NEXT = 0;
                UNTIL PayRevisionLine.NEXT = 0;
        END;
    end;

    // [Scope('Internal')]
    procedure TestStatus()
    begin
        TESTFIELD(Status, Status::Open);
    end;

    // [Scope('Internal')]
    procedure CalculateArrearAmount(PayRevisionHeader: Record 60048)
    var
        ProcessedSalary: Record 60038;
        PayRevisionLine: Record 60049;
        TempProcessedSalary: Record 60038;
        Total: Decimal;
        Basic: Decimal;
        DA: Decimal;
        NoofDays: Decimal;
        MonthDays: Decimal;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        CheckMonth: Integer;
        CheckYear: Integer;
        EndMonth: Integer;
        EndYear: Integer;
        NextNo: Integer;
    begin
        CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
        CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);
        ProcessedSalary.SETRANGE("Employee Code", PayRevisionHeader."No.");
        ProcessedSalary.SETRANGE(ProcessedSalary."Pay Slip Month", CurrentMonth);
        ProcessedSalary.SETRANGE(ProcessedSalary.Year, CurrentYear);
        IF ProcessedSalary.FIND('-') THEN BEGIN
            NoofDays := ProcessedSalary.Attendance;
            MonthDays := ProcessedSalary.Days;
        END ELSE
            ERROR(Text002);

        PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
        PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::Employee);
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        IF PayRevisionLine.FIND('-') THEN
            REPEAT
                IF PayRevisionLine."Pay Element" = 'BASIC' THEN BEGIN
                    IF (PayRevisionLine."Revised Computation Type" = 'ON ATTENDANCE') THEN BEGIN
                        Total := (NoofDays / MonthDays) * PayRevisionLine."Revised Amount / Percent";
                        Basic := Total;
                    END ELSE
                        IF (PayRevisionLine."Revised Computation Type" = 'NON ATTENDANCE') THEN BEGIN
                            Total := PayRevisionLine."Revised Amount / Percent";
                            Basic := Total;
                        END;
                END ELSE BEGIN
                    IF (PayRevisionLine."Revised Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent"::Fixed) THEN BEGIN
                        IF (PayRevisionLine."Revised Computation Type" = 'ON ATTENDANCE') THEN
                            Total := (NoofDays / MonthDays) * PayRevisionLine."Revised Amount / Percent"
                        ELSE
                            Total := PayRevisionLine."Revised Amount / Percent";
                    END ELSE
                        IF (PayRevisionLine."Revised Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent"::Percent) AND
                           (PayRevisionLine."Revised Computation Type" = 'AFTER BASIC')
               THEN
                            Total := (PayRevisionLine."Revised Amount / Percent" * Basic) / 100
                        ELSE
                            IF (PayRevisionLine."Revised Fixed / Percent" = PayRevisionLine."Revised Fixed / Percent"::Percent) AND
                               (PayRevisionLine."Revised Computation Type" = 'AFTER BASIC AND DA')
                       THEN
                                Total := (PayRevisionLine."Revised Amount / Percent" * (Basic + DA)) / 100;
                END;
                IF PayRevisionLine."Pay Element" = 'DA' THEN
                    DA := Total;
                ProcessedSalary.RESET;
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                ProcessedSalary.SETRANGE(Posted, TRUE);
                ProcessedSalary.SETRANGE("Add/Deduct Code", PayRevisionLine."Pay Element");
                IF ProcessedSalary.FIND('-') THEN BEGIN
                    REPEAT
                        ProcessedSalary."Arrear Amount" := (Total - ProcessedSalary."Earned Amount");
                        ProcessedSalary."Arrears Not Posted" := TRUE;
                        ProcessedSalary.MODIFY;
                        PayRevisionLine."Arrear Inserted" := TRUE;
                        PayRevisionLine.MODIFY;
                    UNTIL ProcessedSalary.NEXT = 0;
                END;

                ProcessedSalary.RESET;
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                ProcessedSalary.SETRANGE(Posted, TRUE);
                ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
                IF ProcessedSalary.FIND('+') THEN BEGIN
                    EndMonth := ProcessedSalary."Pay Slip Month";
                    EndYear := ProcessedSalary.Year;
                END;

                CheckMonth := CurrentMonth;
                CheckYear := CurrentYear;
                REPEAT
                    IF PayRevisionLine."Arrear Inserted" = FALSE THEN BEGIN
                        ProcessedSalary.INIT;
                        ProcessedSalary."Document Type" := ProcessedSalary."Document Type"::Payroll;
                        ProcessedSalary."Employee Code" := PayRevisionLine."No.";
                        ProcessedSalary."Pay Slip Month" := CheckMonth;
                        ProcessedSalary.Year := CheckYear;
                        ProcessedSalary."Line No." := ProcessedSalary."Line No." + 10000;
                        ProcessedSalary."Arrear Amount" := Total;
                        ProcessedSalary."Add/Deduct Code" := PayRevisionLine."Pay Element";
                        ProcessedSalary."Fixed/Percent" := PayRevisionLine."Revised Fixed / Percent";
                        ProcessedSalary."Computation Type" := PayRevisionLine."Revised Computation Type";
                        ProcessedSalary."Add/Deduct" := PayRevisionLine."Add/Deduct";
                        ProcessedSalary."Arrears Not Posted" := TRUE;
                        ProcessedSalary.INSERT;
                    END;
                    CalculateESIArrearAmount(ProcessedSalary, PayRevisionLine, CheckMonth, CheckYear);
                    CalculatePFArrearAmount(ProcessedSalary, PayRevisionLine, CheckMonth, CheckYear);
                    CheckMonth := CheckMonth + 1;
                    IF CheckMonth = 12 THEN BEGIN
                        CheckMonth := 1;
                        CheckYear := CheckYear + 1;
                    END;
                UNTIL (CheckMonth > EndMonth) AND (CheckYear = EndYear);
            UNTIL PayRevisionLine.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure CalculateESIArrearAmount(ProcessedSalary: Record 60038; PayRevisionLine: Record 60049; CheckMonth: Integer; CheckYear: Integer)
    var
        Lookup: Record 60018;
        ESI: Record 60043;
        TotalESIArrearAmount: Decimal;
        EmployerContribution: Decimal;
        EmployeeContribution: Decimal;
        CheckDate: Date;
    begin
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
        ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
        ProcessedSalary.SETFILTER(Year, '=%1', CheckYear);
        ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
        ProcessedSalary.SETRANGE(Posted, TRUE);
        ProcessedSalary.SETRANGE("Arrears Not Posted", TRUE);
        ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
        IF ProcessedSalary.FIND('-') THEN
            REPEAT
                Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                Lookup.SETFILTER(ESI, '<>%1', Lookup.ESI::" ");
                Lookup.SETRANGE("Lookup Name", ProcessedSalary."Add/Deduct Code");
                IF Lookup.FIND('-') THEN
                    TotalESIArrearAmount := TotalESIArrearAmount + ProcessedSalary."Arrear Amount";
            UNTIL ProcessedSalary.NEXT = 0;

        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
        ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
        ProcessedSalary.SETFILTER(Year, '=%1', CheckYear);
        ProcessedSalary.SETRANGE(Posted, TRUE);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'ESI');
        ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
        IF ProcessedSalary.FIND('-') THEN BEGIN
            ProcessedSalary."Arrear Salary" := TotalESIArrearAmount;
            ProcessedSalary."Arrears Not Posted" := TRUE;
            ProcessedSalary.MODIFY;
            CheckDate := DMY2DATE(1, CheckMonth, CheckYear);
            IF ESI.FIND('-') THEN BEGIN
                REPEAT
                    IF ESI."Effective Date" <= CheckDate THEN
                        IF ESI."Rounding Method" = ESI."Rounding Method"::Nearest THEN BEGIN
                            EmployerContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employer %") / 100, ESI."Rounding Amount", '=');
                            EmployeeContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employee %") / 100, ESI."Rounding Amount", '=');
                        END ELSE
                            IF ESI."Rounding Method" = ESI."Rounding Method"::Up THEN BEGIN
                                EmployerContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employer %") / 100, ESI."Rounding Amount", '>');
                                EmployeeContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employee %") / 100, ESI."Rounding Amount", '>');
                            END ELSE BEGIN
                                EmployerContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employer %") / 100, ESI."Rounding Amount", '<');
                                EmployeeContribution := ROUND((ProcessedSalary."Arrear Salary" * ESI."Employee %") / 100, ESI."Rounding Amount", '<');
                            END;
                UNTIL ESI.NEXT = 0;
            END;
            ProcessedSalary."Arrear Co. Contribution" := EmployerContribution;
            ProcessedSalary."Arrear Amount" := EmployeeContribution;
            ProcessedSalary.MODIFY;
        END;
    end;

    // [Scope('Internal')]
    procedure CalculatePFArrearAmount(ProcessedSalary: Record 60038; PayRevisionLine: Record 60049; CheckMonth: Integer; CheckYear: Integer)
    var
        Lookup: Record 60018;
        PF: Record 60042;
        TotalPFArrearAmount: Decimal;
        EmployerContribution: Decimal;
        EmployeeContribution: Decimal;
        EPSAmount: Decimal;
        CheckDate: Date;
        "----PF--": Integer;
        Grossamt: Decimal;
        GrossSalary: Decimal;
    begin
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
        ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
        ProcessedSalary.SETFILTER(Year, '=%1', CheckYear);
        ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
        ProcessedSalary.SETRANGE(Posted, TRUE);
        ProcessedSalary.SETRANGE("Arrears Not Posted", TRUE);
        ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
        IF ProcessedSalary.FIND('-') THEN
            REPEAT
                Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                Lookup.SETRANGE(PF, TRUE);
                Lookup.SETRANGE("Lookup Name", ProcessedSalary."Add/Deduct Code");
                IF Lookup.FIND('-') THEN
                    TotalPFArrearAmount := TotalPFArrearAmount + ProcessedSalary."Arrear Amount";
                Grossamt := Grossamt + ProcessedSalary.Salary;
            UNTIL ProcessedSalary.NEXT = 0;
        GrossSalary := Grossamt + TotalPFArrearAmount;


        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
        ProcessedSalary.SETFILTER("Pay Slip Month", '=%1', CheckMonth);
        ProcessedSalary.SETFILTER(Year, '=%1', CheckYear);
        ProcessedSalary.SETRANGE(Posted, TRUE);
        ProcessedSalary.SETRANGE("Add/Deduct Code", 'PF');
        ProcessedSalary.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year, Posted);
        IF ProcessedSalary.FIND('-') THEN BEGIN
            ProcessedSalary."Arrear Salary" := TotalPFArrearAmount;
            ProcessedSalary."Arrears Not Posted" := TRUE;
            CheckDate := DMY2DATE(1, CheckMonth, CheckYear);
            IF PF.FIND('-') THEN BEGIN
                REPEAT
                    IF PF."Effective Date" <= CheckDate THEN
                        IF GrossSalary > PF."PF Amount" THEN BEGIN
                            IF PF."Rounding Method" = PF."Rounding Method"::Nearest THEN BEGIN
                                EmployerContribution := ROUND(((PF."PF Amount" - ProcessedSalary.Salary) * PF."EPS %") / 100, PF."Rounding Amount", '=');
                                EmployeeContribution := ROUND((TotalPFArrearAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '=');
                                EPSAmount := ROUND((((ProcessedSalary."Arrear Salary" * (PF."Employer Contribution" + PF."EPS %")) / 100)
                                                  - ProcessedSalary."Arrear Co. Contribution2"), PF."Rounding Amount", '=');
                            END ELSE
                                IF PF."Rounding Method" = PF."Rounding Method"::Up THEN BEGIN
                                    EmployerContribution := ROUND(((PF."PF Amount" - ProcessedSalary.Salary) * PF."EPS %") / 100, PF."Rounding Amount", '>');
                                    EmployeeContribution := ROUND((TotalPFArrearAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '>');
                                    EPSAmount := ROUND((((ProcessedSalary."Arrear Salary" * (PF."Employer Contribution" + PF."EPS %")) / 100)
                                                     - ProcessedSalary."Arrear Co. Contribution2"), PF."Rounding Amount", '>');
                                END ELSE BEGIN
                                    EmployerContribution := ROUND(((PF."PF Amount" - ProcessedSalary.Salary) * PF."EPS %") / 100, PF."Rounding Amount", '<');
                                    EmployeeContribution := ROUND((TotalPFArrearAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '<');
                                    EPSAmount := ROUND((((ProcessedSalary."Arrear Salary" * (PF."Employer Contribution" + PF."EPS %")) / 100)
                                                      - ProcessedSalary."Arrear Co. Contribution2"), PF."Rounding Amount", '<');
                                END;
                        END ELSE BEGIN
                            IF PF."Rounding Method" = PF."Rounding Method"::Nearest THEN BEGIN
                                EmployerContribution := ROUND((TotalPFArrearAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '=');
                                EmployeeContribution := ROUND((TotalPFArrearAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '=');
                                EPSAmount := ROUND((TotalPFArrearAmount * PF."EPS %") / 100, PF."Rounding Amount", '=');
                            END ELSE
                                IF PF."Rounding Method" = PF."Rounding Method"::Up THEN BEGIN
                                    EmployerContribution := ROUND((TotalPFArrearAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '>');
                                    EmployeeContribution := ROUND((TotalPFArrearAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '>');
                                    EPSAmount := ROUND((TotalPFArrearAmount * PF."EPS %") / 100, PF."Rounding Amount", '>');
                                END ELSE BEGIN
                                    EmployerContribution := ROUND((TotalPFArrearAmount * PF."Employer Contribution") / 100, PF."Rounding Amount", '<');
                                    EmployeeContribution := ROUND((TotalPFArrearAmount * PF."Employee Contribution") / 100, PF."Rounding Amount", '<');
                                    EPSAmount := ROUND((TotalPFArrearAmount * PF."EPS %") / 100, PF."Rounding Amount", '<');
                                END;
                        END;
                UNTIL PF.NEXT = 0;
            END;
            ProcessedSalary."Arrear Co. Contribution" := EmployerContribution;
            ProcessedSalary."Arrear Co. Contribution2" := EPSAmount;
            ProcessedSalary."Arrear Amount" := EmployeeContribution;
            ProcessedSalary.MODIFY;
        END;
    end;

    // [Scope('Internal')]
    procedure UpdateArrearAmount(PayRevisionHeader: Record 60048)
    var
        PayRevisionLine: Record 60049;
        ProcessedSalary: Record 60038;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        Total: Decimal;
    begin
        CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
        CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);

        PayRevisionLine.RESET;
        PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
        PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::Employee);
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        IF PayRevisionLine.FIND('-') THEN
            REPEAT
                Total := 0;
                ProcessedSalary.RESET;
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                ProcessedSalary.SETRANGE(Posted, TRUE);
                ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
                ProcessedSalary.SETRANGE("Arrears Not Posted", TRUE);
                ProcessedSalary.SETRANGE("Add/Deduct Code", PayRevisionLine."Pay Element");
                IF ProcessedSalary.FIND('-') THEN
                    REPEAT
                        Total := Total + ProcessedSalary."Arrear Amount";
                    UNTIL ProcessedSalary.NEXT = 0;
                PayRevisionLine."Arrear Amount" := Total;
                PayRevisionLine.MODIFY;
            UNTIL PayRevisionLine.NEXT = 0;
    end;

    //  [Scope('Internal')]
    procedure UpdateESIArrearAmount(PayRevisionHeader: Record 60048)
    var
        PayRevisionLine: Record 60049;
        ProcessedSalary: Record 60038;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        ESITotal: Decimal;
        ESICoAmt: Decimal;
    begin
        CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
        CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);

        PayRevisionLine.RESET;
        PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
        PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::Employee);
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        IF PayRevisionLine.FIND('-') THEN
            REPEAT
                ESITotal := 0;
                ESICoAmt := 0;
                ProcessedSalary.RESET;
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                ProcessedSalary.SETRANGE(Posted, TRUE);
                ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
                ProcessedSalary.SETRANGE("Arrears Not Posted", TRUE);
                ProcessedSalary.SETRANGE("Add/Deduct Code", 'ESI');
                IF ProcessedSalary.FIND('-') THEN
                    REPEAT
                        ESITotal := ESITotal + ProcessedSalary."Arrear Amount";
                        ESICoAmt := ESICoAmt + ProcessedSalary."Arrear Co. Contribution";
                    UNTIL ProcessedSalary.NEXT = 0;
            UNTIL PayRevisionLine.NEXT = 0;

        PayRevisionLine.INIT;
        PayRevisionLine."Header No." := PayRevisionHeader."Id.";
        PayRevisionLine."No." := PayRevisionHeader."No.";
        PayRevisionLine.Type := PayRevisionHeader.Type;
        PayRevisionLine."Line No." := PayRevisionLine."Line No." + 10000;
        PayRevisionLine."Pay Element" := 'ESI';
        PayRevisionLine.Grade := PayElement."Pay Cadre";
        PayRevisionLine."Employee Name" := PayRevisionHeader."Employee Name";
        PayRevisionLine."Revised Date" := PayRevisionHeader."Revisied Date";
        PayRevisionLine."Effective Date" := PayRevisionHeader."Effective Date";
        PayRevisionLine."Add/Deduct" := PayElement2."Add/Deduct"::Deduction;
        PayRevisionLine."Document Type" := PayRevisionLine."Document Type"::Payroll;
        PayRevisionLine."Arrear Amount" := ESITotal;
        PayRevisionLine."Arrear Co. Contribution" := ESICoAmt;
        PayRevisionLine."Arrear Inserted" := TRUE;
        PayRevisionLine.INSERT;
        //InsertDimensions(PayRevisionLine);
    end;

    // [Scope('Internal')]
    procedure UpdatePFArrearAmount(PayRevisionHeader: Record 60048)
    var
        PayRevisionLine: Record 60049;
        ProcessedSalary: Record 60038;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        PFTotal: Decimal;
        PFCoAmt: Decimal;
        PFCoAmt2: Decimal;
    begin
        CurrentMonth := DATE2DMY(PayRevisionHeader."Effective Date", 2);
        CurrentYear := DATE2DMY(PayRevisionHeader."Effective Date", 3);

        PayRevisionLine.RESET;
        PayRevisionLine.SETCURRENTKEY("No.", "Pay Element");
        PayRevisionLine.SETRANGE(Type, PayRevisionLine.Type::Employee);
        PayRevisionLine.SETRANGE("Header No.", PayRevisionHeader."Id.");
        PayRevisionLine.SETRANGE("No.", PayRevisionHeader."No.");
        IF PayRevisionLine.FIND('-') THEN
            REPEAT
                PFTotal := 0;
                PFCoAmt := 0;
                PFCoAmt2 := 0;
                ProcessedSalary.RESET;
                ProcessedSalary.SETRANGE("Employee Code", PayRevisionLine."No.");
                ProcessedSalary.SETFILTER("Pay Slip Month", '>=%1', CurrentMonth);
                ProcessedSalary.SETFILTER(Year, '>=%1', CurrentYear);
                ProcessedSalary.SETRANGE(Posted, TRUE);
                ProcessedSalary.SETFILTER("Arrear Amount", '<>0');
                ProcessedSalary.SETRANGE("Arrears Not Posted", TRUE);
                ProcessedSalary.SETRANGE("Add/Deduct Code", 'PF');
                IF ProcessedSalary.FIND('-') THEN
                    REPEAT
                        PFTotal := PFTotal + ProcessedSalary."Arrear Amount";
                        PFCoAmt := PFCoAmt + ProcessedSalary."Arrear Co. Contribution";
                        PFCoAmt2 := PFCoAmt2 + ProcessedSalary."Arrear Co. Contribution2";
                    UNTIL ProcessedSalary.NEXT = 0;
            UNTIL PayRevisionLine.NEXT = 0;

        PayRevisionLine.INIT;
        PayRevisionLine."Header No." := PayRevisionHeader."Id.";
        PayRevisionLine."No." := PayRevisionHeader."No.";
        PayRevisionLine.Type := PayRevisionHeader.Type;
        PayRevisionLine."Line No." := PayRevisionLine."Line No." + 10000;
        PayRevisionLine."Pay Element" := 'PF';
        PayRevisionLine.Grade := PayElement."Pay Cadre";
        PayRevisionLine."Employee Name" := PayRevisionHeader."Employee Name";
        PayRevisionLine."Revised Date" := PayRevisionHeader."Revisied Date";
        PayRevisionLine."Effective Date" := PayRevisionHeader."Effective Date";
        PayRevisionLine."Add/Deduct" := PayElement2."Add/Deduct"::Deduction;
        PayRevisionLine."Document Type" := PayRevisionLine."Document Type"::Payroll;
        PayRevisionLine."Arrear Amount" := PFTotal;
        PayRevisionLine."Arrear Co. Contribution" := PFCoAmt;
        PayRevisionLine."Arrear Co. Contribution2" := PFCoAmt2;
        PayRevisionLine."Arrear Inserted" := TRUE;
        PayRevisionLine.INSERT;
        //InsertDimensions(PayRevisionLine);
    end;
}

