page 60078 EmpDet_LoanDet
{
    Editable = false;
    PageType = ListPart;
    SourceTable = 60040;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Loan Code"; rec."Loan Code")
                {
                    ApplicationArea = all;
                }
                field("Pay Date"; rec."Pay Date")
                {
                    ApplicationArea = all;
                }
                field("Loan Amount"; rec."Loan Amount")
                {
                    ApplicationArea = all;
                }
                field("EMI Deducted"; rec."EMI Deducted")
                {
                    ApplicationArea = all;
                }
                field("EMI Amount"; rec."EMI Amount")
                {
                    ApplicationArea = all;
                }
                field("Lump Sum Payment"; rec."Lump Sum Payment")
                {
                    ApplicationArea = all;
                }
                field(Principal; rec.Principal)
                {
                    ApplicationArea = all;
                }
                field(Balance; rec.Balance)
                {
                    ApplicationArea = all;
                }
                field("Paid Month"; rec."Paid Month")
                {
                    ApplicationArea = all;
                }
                field("Paid Year"; rec."Paid Year")
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
    procedure GetEmp(LoanId: Code[20])
    begin
        rec.SETRANGE(rec."Loan Id", LoanId);
        CurrPage.UPDATE(FALSE);
    end;
}

