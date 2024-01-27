page 60074 EmpDetails_ProcSal
{
    Editable = false;
    PageType = ListPart;
    SourceTable = 60038;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Add/Deduct Code"; rec."Add/Deduct Code")
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
        }
    }

    actions
    {
    }

    var
        RecRef: RecordRef;

    // [Scope('Internal')]
    procedure GetEmp(month: Integer; year: Integer; "code": Code[10])
    begin
        rec.RESET;
        rec.SETRANGE(rec."Employee Code", code);
        rec.SETRANGE(rec."Pay Slip Month", month);
        rec.SETRANGE(Year, year);

        CurrPage.UPDATE(FALSE);
    end;
}

