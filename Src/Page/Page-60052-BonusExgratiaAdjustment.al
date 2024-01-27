page 60052 "Bonus/Exgratia Adjustment"
{
    PageType = Worksheet;
    SourceTable = 60053;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
                    //ValuesAllowed = 1;2;3;4;5;6;7;8;9;10;11;12;
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrentMonthOnAfterValidate;
                    end;
                }
            }
            repeater(control1)
            {
                field("Employee Code"; rec."Employee Code")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; rec."Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Bonus/Exgratia Amt"; rec."Bonus/Exgratia Amt")
                {
                    ApplicationArea = all;
                }
                field("Additional Bonus"; rec."Additional Bonus")
                {
                    ApplicationArea = all;
                }
                field(Adjustments; rec.Adjustments)
                {
                    ApplicationArea = all;
                }
                field("Net Payable"; rec."Net Payable")
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
        IF HRSetup.FIND('-') THEN BEGIN
            CurrentYear := HRSetup."Salary Processing Year";
            CurrentMonth := HRSetup."Salary Processing month";
        END;
        SelectYear;
        SelectMonth;
    end;

    var
        HRSetup: Record 60016;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        RecRef: RecordRef;

    // [Scope('Internal')]
    procedure SelectYear()
    begin
        rec.SETRANGE(Year, CurrentYear);
        CurrPage.UPDATE(FALSE);
    end;

    //  [Scope('Internal')]
    procedure SelectMonth()
    begin
        rec.SETRANGE(Month, CurrentMonth);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure CurrentYearOnAfterValidate()
    begin
        SelectYear;
    end;

    local procedure CurrentMonthOnAfterValidate()
    begin
        SelectMonth;
    end;
}

