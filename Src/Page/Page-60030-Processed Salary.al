page 60030 "Processed Salary"
{
    // Date: 15-Dec-05

    AutoSplitKey = true;
    PageType = Worksheet;
    SourceTable = 60038;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrentEmpNo; CurrentEmpNo)
                {
                    Caption = 'Employee No.';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK THEN BEGIN
                            CurrentEmpNo := Employee."No.";
                            Name := Employee."First Name";
                        END;
                        SelectEmployee;
                        GetSalary;
                    end;

                    trigger OnValidate()
                    begin
                        IF Employee.GET(CurrentEmpNo) THEN
                            Name := Employee."First Name";
                        IF CurrentEmpNo = '' THEN
                            Name := '';
                        CurrentEmpNoOnAfterValidate;
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                    Caption = 'Employee Name';
                    Editable = false;
                }
                field(CurrentYear; CurrentYear)
                {
                    Caption = 'Year';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrentYearOnAfterValidate;
                    end;
                }
                field(CurrentMonth; CurrentMonth)
                {
                    Caption = 'Month';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrentMonthOnAfterValidate;
                    end;
                }
            }
            repeater(control1)
            {
                Editable = false;
                field("Add/Deduct Code"; rec."Add/Deduct Code")
                {
                    ApplicationArea = all;
                }
                field(Year; rec.Year)
                {
                    ApplicationArea = all;
                }
                field("Pay Slip Month"; rec."Pay Slip Month")
                {
                    ApplicationArea = all;
                    Caption = 'Month';
                }
                field(Days; rec.Days)
                {
                    ApplicationArea = all;
                }
                field(Attendance; rec.Attendance)
                {
                    ApplicationArea = all;
                }
                field("Add/Deduct"; rec."Add/Deduct")
                {
                    ApplicationArea = all;
                }
                field("Computation Type"; rec."Computation Type")
                {
                    ApplicationArea = all;
                }
                field("Earned Amount"; rec."Earned Amount")
                {
                    ApplicationArea = all;
                }
            }
            group(Group1)
            {
                field(GrossSalary; GrossSalary)
                {
                    ApplicationArea = all;
                    Caption = 'Gross Salary';
                    Editable = false;
                }
                field(NetSalary; NetSalary)
                {
                    ApplicationArea = all;
                    Caption = 'Net Salary';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //VE-026 >>
        /*RecRef.GETTABLE(Rec);
        ID := RecRef.NUMBER;
        SecurityFilterSetup.INIT;
        SecurityFilterSetup.SETRANGE("Table ID",ID);
        IF SecurityFilterSetup.FIND('-') THEN
          BEGIN
             FILTERGROUP(2);
             SETVIEW(SecurityF.GetSecurityFilters(RecRef));
             FILTERGROUP(2);
          END;*/
        //VE-026 <<

        rec.SETCURRENTKEY(rec."Add/Deduct", rec."Add/Deduct Code");
        CurrentEmpNo := '';
        Name := '';
        IF HRSetup.FIND('-') THEN BEGIN
            CurrentMonth := HRSetup."Salary Processing month";
            CurrentYear := HRSetup."Salary Processing Year";
        END;
        SelectEmployee;
        SelectYear;
        SelectMonth;
        GetSalary;

    end;

    var
        HRSetup: Record 60016;
        Employee: Record 60019;
        ProcessedSalary: Record 60038;
        GrossSalary: Decimal;
        NetSalary: Decimal;
        CurrentEmpNo: Code[20];
        Name: Text[50];
        CurrentMonth: Integer;
        CurrentYear: Integer;
        RecRef: RecordRef;
        ID: Integer;
        Text19009097: Label 'Gross Salary';
        Text19043353: Label 'Net Salary';

    //  [Scope('Internal')]
    procedure SelectYear()
    begin
        rec.SETRANGE(Year, CurrentYear);
        CurrPage.UPDATE(FALSE);
    end;

    // [Scope('Internal')]
    procedure SelectMonth()
    begin
        rec.SETRANGE(rec."Pay Slip Month", CurrentMonth);
        CurrPage.UPDATE(FALSE);
    end;

    // [Scope('Internal')]
    procedure SelectEmployee()
    begin
        rec.SETRANGE(rec."Employee Code", CurrentEmpNo);
        rec.SETFILTER(rec."Add/Deduct Code", '<>%1 & <>%2', 'EDLI CHARGES', 'PF CHARGES');
        rec.SETFILTER(Check, 'No');
        CurrPage.UPDATE(FALSE);
    end;

    // [Scope('Internal')]
    procedure GetSalary()
    begin
        GrossSalary := 0;
        NetSalary := 0;
        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", CurrentEmpNo);
        ProcessedSalary.SETRANGE("Pay Slip Month", CurrentMonth);
        ProcessedSalary.SETRANGE(Year, CurrentYear);
        ProcessedSalary.SETRANGE("Add/Deduct", ProcessedSalary."Add/Deduct"::Addition);
        IF ProcessedSalary.FIND('-') THEN
            REPEAT
                GrossSalary := GrossSalary + ProcessedSalary."Earned Amount";
            UNTIL ProcessedSalary.NEXT = 0;

        ProcessedSalary.RESET;
        ProcessedSalary.SETRANGE("Employee Code", CurrentEmpNo);
        ProcessedSalary.SETRANGE("Pay Slip Month", CurrentMonth);
        ProcessedSalary.SETRANGE(Year, CurrentYear);
        IF ProcessedSalary.FIND('-') THEN
            REPEAT
                IF ProcessedSalary."Add/Deduct" = ProcessedSalary."Add/Deduct"::Addition THEN
                    NetSalary := NetSalary + ProcessedSalary."Earned Amount"
                ELSE
                    IF ProcessedSalary."Add/Deduct" = ProcessedSalary."Add/Deduct"::Deduction THEN
                        NetSalary := NetSalary - ProcessedSalary."Earned Amount";
            UNTIL ProcessedSalary.NEXT = 0;
    end;

    local procedure CurrentEmpNoOnAfterValidate()
    begin
        SelectEmployee;
        GetSalary;
    end;

    local procedure CurrentYearOnAfterValidate()
    begin
        SelectYear;
        GetSalary;
    end;

    local procedure CurrentMonthOnAfterValidate()
    begin
        SelectMonth;
        GetSalary;
    end;
}

