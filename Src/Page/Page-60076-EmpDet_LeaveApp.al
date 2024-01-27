page 60076 EmpDet_LeaveApp
{
    // Date: 11-Jan-06

    DelayedInsert = true;
    Editable = false;
    PageType = ListPart;
    SourceTable = 60032;
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
                }
                field("Leave Duration"; rec."Leave Duration")
                {
                    ApplicationArea = all;
                }
                field("From Date"; rec."From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; rec."To Date")
                {
                    ApplicationArea = all;
                }
                field("No.of Days"; rec."No.of Days")
                {
                    ApplicationArea = all;
                }
                field("Reason for Leave"; rec."Reason for Leave")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        StatusOnAfterValidate;
                    end;
                }
                field(Sanctioned; rec.Sanctioned)
                {
                    ApplicationArea = all;
                    Editable = SanctionedEditable;
                }
                field("Leaves avail.curr.Month"; rec."Leaves avail.curr.Month")
                {
                    ApplicationArea = all;
                }
                field("Sanctioning Incharge"; rec."Sanctioning Incharge")
                {
                    ApplicationArea = all;
                    Editable = "Sanctioning InchargeEditable";
                }
                field("Date of Sanction"; rec."Date of Sanction")
                {
                    ApplicationArea = all;
                    Editable = "Date of SanctionEditable";
                }
                field("Date of Cancellation"; rec."Date of Cancellation")
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
        "Date of SanctionEditable" := TRUE;
        "Sanctioning InchargeEditable" := TRUE;
        SanctionedEditable := TRUE;
    end;

    var
        RecRef: RecordRef;
        [InDataSet]
        SanctionedEditable: Boolean;
        [InDataSet]
        "Sanctioning InchargeEditable": Boolean;
        [InDataSet]
        "Date of SanctionEditable": Boolean;

    //  [Scope('Internal')]
    procedure GerEmp(Month: Integer; Year: Integer; EmpCode: Code[20])
    begin
        rec.RESET;
        rec.SETRANGE(rec."Employee No.", EmpCode);
        rec.SETRANGE(Month, Month);
        rec.SETRANGE(Year, Year);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure StatusOnAfterValidate()
    begin
        IF rec.Status = rec.Status::Reject THEN BEGIN
            SanctionedEditable := FALSE;
            "Sanctioning InchargeEditable" := FALSE;
            "Date of SanctionEditable" := FALSE;
        END ELSE BEGIN
            SanctionedEditable := TRUE;
            "Sanctioning InchargeEditable" := TRUE;
            "Date of SanctionEditable" := TRUE;
        END;
    end;
}

