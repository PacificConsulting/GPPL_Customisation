page 60062 "Employee Payment Details"
{
    // 14-Dec-05

    DelayedInsert = true;
    Editable = false;
    MultipleNewLines = true;
    PageType = List;
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
                field("Employee Code"; rec."Employee Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Year; rec.Year)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Pay Slip Month"; rec."Pay Slip Month")
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
                field("Paid Amount"; rec."Paid Amount")
                {
                    ApplicationArea = all;
                }
                field("Remaining Amount"; rec."Remaining Amount")
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
}

