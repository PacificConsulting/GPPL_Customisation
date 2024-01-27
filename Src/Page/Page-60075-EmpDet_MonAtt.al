page 60075 EmpDet_MonAtt
{
    // Date: 14-Dec-05

    DelayedInsert = true;
    Editable = false;
    MultipleNewLines = true;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = 60029;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field(Days; rec.Days)
                {
                    ApplicationArea = all;
                    Caption = 'No.of Days';
                    Editable = false;
                }
                field("Weekly Off"; rec."Weekly Off")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Gross Salary"; rec."Gross Salary")
                {
                    ApplicationArea = all;
                }
                field(Deductions; rec.Deductions)
                {
                    ApplicationArea = all;
                }
                field("Net Salary"; rec."Net Salary")
                {
                    ApplicationArea = all;
                }
                field(Attendance; rec.Attendance)
                {
                    ApplicationArea = all;
                }
                field("Over Time Hrs"; rec."Over Time Hrs")
                {
                    ApplicationArea = all;
                }
                field(Holidays; rec.Holidays)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Loss Of Pay"; rec."Loss Of Pay")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        MonAttendance: Record 60029;
        SalaryProcess: Codeunit 60008;
        RecRef: RecordRef;

    // [Scope('Internal')]
    procedure GetEmp(Month: Integer; Year: Integer; EmpCode: Code[20])
    begin
        rec.RESET;
        rec.SETRANGE(rec."Employee Code", EmpCode);
        rec.SETRANGE(rec."Pay Slip Month", Month);
        rec.SETRANGE(Year, Year);
        CurrPage.UPDATE(FALSE);
    end;
}

