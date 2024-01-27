page 60037 "PF List"
{
    Editable = false;
    PageType = List;
    SourceTable = 60042;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field(Id; rec.Id)
                {
                    ApplicationArea = all;
                }
                field("Effective Date"; rec."Effective Date")
                {
                    ApplicationArea = all;
                }
                field("Employer Contribution"; rec."Employer Contribution")
                {
                    ApplicationArea = all;
                }
                field("Employee Contribution"; rec."Employee Contribution")
                {
                    ApplicationArea = all;
                }
                field("Rounding Amount"; rec."Rounding Amount")
                {
                    ApplicationArea = all;
                }
                field("Rounding Method"; rec."Rounding Method")
                {
                    ApplicationArea = all;
                }
                field("EPS %"; rec."EPS %")
                {
                    ApplicationArea = all;
                }
                field("Admin Charges %"; rec."Admin Charges %")
                {
                    ApplicationArea = all;
                }
                field("EDLI %"; rec."EDLI %")
                {
                    ApplicationArea = all;
                }
                field("RIFA %"; rec."RIFA %")
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

