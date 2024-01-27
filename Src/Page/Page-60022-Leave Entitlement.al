page 60022 "Leave Entitlement"
{
    // Date: 10-Jan-06

    PageType = Worksheet;
    SourceTable = 60031;
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
                        IF PAGE.RUNMODAL(0, EmployeeRec) = ACTION::LookupOK THEN BEGIN
                            CurrentEmpNo := EmployeeRec."No.";
                            Name := EmployeeRec."First Name";
                        END;
                        SelectEmployee;
                    end;

                    trigger OnValidate()
                    begin
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
                field("Leave Code"; rec."Leave Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Total Leaves"; rec."Total Leaves")
                {
                    ApplicationArea = all;
                    Caption = 'Carry forward Leaves';
                }
                field("Leave Encashed"; rec."Leave Encashed")
                {
                    ApplicationArea = all;
                }
                field(Probation; rec.Probation)
                {
                    ApplicationArea = all;
                }
                field("Leave Year Closing Period"; rec."Leave Year Closing Period")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Leaves Carried"; rec."Leaves Carried")
                {
                    ApplicationArea = all;
                }
                field("Leaves taken during Month"; rec."Leaves taken during Month")
                {
                    ApplicationArea = all;
                }
                field("Leave Bal. at the Month End"; rec."Leave Bal. at the Month End")
                {
                    ApplicationArea = all;
                }
                field("Leaves Expired"; rec."Leaves Expired")
                {
                    ApplicationArea = all;
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
        FILTERGROUP(2);
        SETVIEW(SecurityF.GetSecurityFilters(RecRef));
        FILTERGROUP(0);*/
        //VE-026 <<
        CurrentEmpNo := '';
        Name := '';
        IF HRSetup.FIND('-') THEN BEGIN
            CurrentMonth := HRSetup."Salary Processing month";
            CurrentYear := HRSetup."Salary Processing Year";
        END;
        SelectEmployee;
        SelectYear;
        SelectMonth;

    end;

    var
        CurrentEmpNo: Code[20];
        CurrentMonth: Integer;
        CurrentYear: Integer;
        EmployeeRec: Record 60019;
        HRSetup: Record 60016;
        Name: Text[50];
        RecRef: RecordRef;

    // [Scope('Internal')]
    procedure SelectYear()
    begin
        rec.SETRANGE(rec.Year, CurrentYear);
        CurrPage.UPDATE(FALSE);
    end;

    // [Scope('Internal')]
    procedure SelectMonth()
    begin
        rec.SETRANGE(rec.Month, CurrentMonth);
        CurrPage.UPDATE(FALSE);
    end;

    //  [Scope('Internal')]
    procedure SelectEmployee()
    begin
        rec.SETRANGE(rec."Employee No.", CurrentEmpNo);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure CurrentYearOnAfterValidate()
    begin
        SelectYear
    end;

    local procedure CurrentMonthOnAfterValidate()
    begin
        SelectMonth;
    end;

    local procedure CurrentEmpNoOnAfterValidate()
    begin
        SelectEmployee;
    end;
}

