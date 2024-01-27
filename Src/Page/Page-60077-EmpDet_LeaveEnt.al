page 60077 EmpDet_LeaveEnt
{
    // Date: 10-Jan-06

    Editable = false;
    PageType = ListPart;
    SourceTable = 60031;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Leave Code"; rec."Leave Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No.of Leaves"; rec."No.of Leaves")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Leaves Carried"; rec."Leaves Carried")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Total Leaves"; rec."Total Leaves")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Leaves taken during Month"; rec."Leaves taken during Month")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Leave Bal. at the Month End"; rec."Leave Bal. at the Month End")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Leaves Expired"; rec."Opening Balance")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;

    var
        RecRef: RecordRef;

    //  [Scope('Internal')]
    procedure GetEmp(Month: Integer; Year: Integer; EmpCode: Code[20])
    begin
        rec.RESET;
        rec.SETRANGE(rec."Employee No.", EmpCode);
        rec.SETRANGE(Month, Month);
        rec.SETRANGE(Year, Year);
        CurrPage.UPDATE(FALSE);
    end;
}

