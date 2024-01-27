page 60057 "Employee Posting  Group"
{
    PageType = List;
    SourceTable = 60056;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Salary Payable Acc."; rec."Salary Payable Acc.")
                {
                    ApplicationArea = all;
                }
                field("Arrear Salary Payable Acc."; rec."Arrear Salary Payable Acc.")
                {
                    ApplicationArea = all;
                }
                field("PF Payable Acc."; rec."PF Payable Acc.")
                {
                    ApplicationArea = all;
                }
                field("TDS Payable Acc."; rec."TDS Payable Acc.")
                {
                    ApplicationArea = all;
                }
                field("ESI Payable Acc."; rec."ESI Payable Acc.")
                {
                    ApplicationArea = all;
                }
                field("EPS Payable Acc."; rec."EPS Payable Acc.")
                {
                    ApplicationArea = all;
                }
                field("EDLI Charges Acc."; rec."EDLI Charges Acc.")
                {
                    ApplicationArea = all;
                }
                field("PF Admin Charge Payable Acc."; rec."PF Admin Charge Payable Acc.")
                {
                    ApplicationArea = all;
                }
                field("RIFA Charges Acc."; rec."RIFA Charges Acc.")
                {
                    ApplicationArea = all;
                }
                field("Bonus Payable Acc."; rec."Bonus Payable Acc.")
                {
                    ApplicationArea = all;
                }
                field("PT Payable Account"; rec."PT Payable Account")
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
}

