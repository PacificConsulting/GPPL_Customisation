codeunit 60002 Lookup
{

    trigger OnRun()
    begin
        IF LookupTypes.FIND('-') THEN BEGIN
            ERROR(Text000);
        END ELSE BEGIN

            //LOOKUPTYPE TABLE

            LookupTypes.INIT;
            LookupTypes."No." := 1;
            LookupTypes.Name := 'Skill Set';
            LookupTypes.Description := 'Skill Set';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 2;
            LookupTypes.Name := 'QUALIFICATION';
            LookupTypes.Description := 'Qualification';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 3;
            LookupTypes.Name := 'CERTIFICATION';
            LookupTypes.Description := 'Certification';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 4;
            LookupTypes.Name := 'DEPARTMENTS';
            LookupTypes.Description := 'Dept';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 5;
            LookupTypes.Name := 'DESIGNATIONS';
            LookupTypes.Description := 'Designations';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 6;
            LookupTypes.Name := 'INTERVIEW TYPES';
            LookupTypes.Description := 'Interview Types';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 7;
            LookupTypes.Name := 'INTERVIEW STATUS';
            LookupTypes.Description := 'Interview Status';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 8;
            LookupTypes.Name := 'PERFORMANCE APPRAISAL';
            LookupTypes.Description := 'Performance Appraisal';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 9;
            LookupTypes.Name := 'PERFORMANCE RATING SCALE';
            LookupTypes.Description := 'Performance Rating Scale';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 10;
            LookupTypes.Name := 'TYPE OF TRAINING';
            LookupTypes.Description := 'Type of Training';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 11;
            LookupTypes.Name := 'NEED FOR TRAINING';
            LookupTypes.Description := 'Need for Training';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 12;
            LookupTypes.Name := 'STAFF TYPES';
            LookupTypes.Description := 'Staff Types';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 13;
            LookupTypes.Name := 'STATUS';
            LookupTypes.Description := 'Status';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 14;
            LookupTypes.Name := 'CAUSES OF INACTIVITY';
            LookupTypes.Description := 'Causes of Inactivity';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 15;
            LookupTypes.Name := 'GROUNDS OF TERMINATION';
            LookupTypes.Description := 'Grounds of Termination';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 16;
            LookupTypes.Name := 'ADDITIONS AND DEDUCTIONS';
            LookupTypes.Description := 'Add & Ded';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 17;
            LookupTypes.Name := 'COMPUTATION TYPE';
            LookupTypes.Description := 'Computation';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 18;
            LookupTypes.Name := 'LOAN TYPES';
            LookupTypes.Description := 'Loan Types';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 19;
            LookupTypes.Name := 'PAYROLL YEARS';
            LookupTypes.Description := 'Payroll Years';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 20;
            LookupTypes.Name := 'PAY CADRE';
            LookupTypes.Description := 'Pay Cadre';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;
            LookupTypes."No." := 21;
            LookupTypes.Name := 'PRIORITY';
            LookupTypes.Description := 'Priority';
            LookupTypes."System Defined" := TRUE;
            LookupTypes.INSERT;

            //LOOKUP TABLE

            Lookup."Lookup Id" := 16;
            Lookup."Lookup Type" := 16;
            Lookup."LookupType Name" := 'ADDITIONS AND DEDUCTIONS';
            Lookup."Lookup Name" := 'BASIC';
            Lookup.Description := 'Basic';
            Lookup."Add/Deduct" := Lookup."Add/Deduct"::Addition;
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 16;
            Lookup."Lookup Type" := 16;
            Lookup."LookupType Name" := 'ADDITIONS AND DEDUCTIONS';
            Lookup."Lookup Name" := 'DA';
            Lookup.Description := 'Dearness Allowance';
            Lookup."Add/Deduct" := Lookup."Add/Deduct"::Addition;
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 16;
            Lookup."Lookup Type" := 16;
            Lookup."LookupType Name" := 'ADDITIONS AND DEDUCTIONS';
            Lookup."Lookup Name" := 'PF';
            Lookup.Description := 'Provident Fund';
            Lookup."Add/Deduct" := Lookup."Add/Deduct"::Deduction;
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 16;
            Lookup."Lookup Type" := 16;
            Lookup."LookupType Name" := 'ADDITIONS AND DEDUCTIONS';
            Lookup."Lookup Name" := 'ESI';
            Lookup.Description := 'Employee State Insurence';
            Lookup."Add/Deduct" := Lookup."Add/Deduct"::Deduction;
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 16;
            Lookup."Lookup Type" := 16;
            Lookup."LookupType Name" := 'ADDITIONS AND DEDUCTIONS';
            Lookup."Lookup Name" := 'PT';
            Lookup.Description := 'Professional Tax';
            Lookup."Add/Deduct" := Lookup."Add/Deduct"::Deduction;
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 16;
            Lookup."Lookup Type" := 16;
            Lookup."LookupType Name" := 'ADDITIONS AND DEDUCTIONS';
            Lookup."Lookup Name" := 'TDS';
            Lookup.Description := 'Tax Deduction at Source';
            Lookup."Add/Deduct" := Lookup."Add/Deduct"::Deduction;
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 16;
            Lookup."Lookup Type" := 16;
            Lookup."LookupType Name" := 'ADDITIONS AND DEDUCTIONS';
            Lookup."Lookup Name" := 'LOAN';
            Lookup.Description := 'Loans';
            Lookup."Add/Deduct" := Lookup."Add/Deduct"::Deduction;
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 16;
            Lookup."Lookup Type" := 16;
            Lookup."LookupType Name" := 'ADDITIONS AND DEDUCTIONS';
            Lookup."Lookup Name" := 'OT';
            Lookup.Description := 'Over Time';
            Lookup."Add/Deduct" := Lookup."Add/Deduct"::Addition;
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 16;
            Lookup."Lookup Type" := 16;
            Lookup."LookupType Name" := 'ADDITIONS AND DEDUCTIONS';
            Lookup."Lookup Name" := 'BONUS';
            Lookup.Description := 'Bonus';
            Lookup."Add/Deduct" := Lookup."Add/Deduct"::Addition;
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 16;
            Lookup."Lookup Type" := 16;
            Lookup."LookupType Name" := 'ADDITIONS AND DEDUCTIONS';
            Lookup."Lookup Name" := 'EX-GRATIA';
            Lookup.Description := 'Ex-gratia';
            Lookup."Add/Deduct" := Lookup."Add/Deduct"::Addition;
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 16;
            Lookup."Lookup Type" := 16;
            Lookup."LookupType Name" := 'ADDITIONS AND DEDUCTIONS';
            Lookup."Lookup Name" := 'GRATUITY';
            Lookup.Description := 'Gratuity';
            Lookup."Add/Deduct" := Lookup."Add/Deduct"::Addition;
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 16;
            Lookup."Lookup Type" := 16;
            Lookup."LookupType Name" := 'ADDITIONS AND DEDUCTIONS';
            Lookup."Lookup Name" := 'Add Round';
            Lookup.Description := 'Rounding Addition';
            Lookup."Add/Deduct" := Lookup."Add/Deduct"::Addition;
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 16;
            Lookup."Lookup Type" := 16;
            Lookup."LookupType Name" := 'ADDITIONS AND DEDUCTIONS';
            Lookup."Lookup Name" := 'Ded Round';
            Lookup.Description := 'Rounding Deduction';
            Lookup."Add/Deduct" := Lookup."Add/Deduct"::Deduction;
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;



            Lookup."Lookup Id" := 17;
            Lookup."Lookup Type" := 17;
            Lookup."LookupType Name" := 'COMPUTATION TYPE';
            Lookup."Lookup Name" := 'ON ATTENDANCE';
            Lookup.Description := 'On Attendance';
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 17;
            Lookup."Lookup Type" := 17;
            Lookup."LookupType Name" := 'COMPUTATION TYPE';
            Lookup."Lookup Name" := 'NON ATTENDANCE';
            Lookup.Description := 'Non Attendance';
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 17;
            Lookup."Lookup Type" := 17;
            Lookup."LookupType Name" := 'COMPUTATION TYPE';
            Lookup."Lookup Name" := 'AFTER BASIC';
            Lookup.Description := 'After Basic';
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 17;
            Lookup."Lookup Type" := 17;
            Lookup."LookupType Name" := 'COMPUTATION TYPE';
            Lookup."Lookup Name" := 'AFTER BASIC AND DA';
            Lookup.Description := 'After Basic and DA';
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;

            Lookup."Lookup Id" := 19;
            Lookup."Lookup Type" := 19;
            Lookup."LookupType Name" := 'PAYROLL YEARS';
            Lookup."Lookup Name" := 'LEAVE YEAR';
            Lookup.Description := 'Leave Year Definition';
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 19;
            Lookup."Lookup Type" := 19;
            Lookup."LookupType Name" := 'PAYROLL YEARS';
            Lookup."Lookup Name" := 'FINANCIAL YEAR';
            Lookup.Description := 'Financial Year Definition';
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 19;
            Lookup."Lookup Type" := 19;
            Lookup."LookupType Name" := 'PAYROLL YEARS';
            Lookup."Lookup Name" := 'PF YEAR';
            Lookup.Description := 'PF Year';
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;
            Lookup."Lookup Id" := 19;
            Lookup."Lookup Type" := 19;
            Lookup."LookupType Name" := 'PAYROLL YEARS';
            Lookup."Lookup Name" := 'ESI YEAR';
            Lookup.Description := 'ESI Year';
            Lookup."System Defined" := TRUE;
            Lookup.INSERT;

            MESSAGE(Text001);

        END;
    end;

    var
        HRSetup: Record "60016";
        LookupTypes: Record "60017";
        Lookup: Record "60018";
        Text000: Label 'Lookup Types are already defined';
        Text001: Label 'Lookup records are inserted.';
        Num: Integer;
}

