page 60084 "Posted Salary Details List"
{
    Editable = false;
    PageType = List;
    SourceTable = 60009;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document No"; rec."Document No")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Month; rec.Month)
                {
                    ApplicationArea = all;
                }
                field(Year; rec.Year)
                {
                    ApplicationArea = all;
                }
                field("Employee Code"; rec."Employee Code")
                {
                    ApplicationArea = all;
                }
                field("Total Additions"; rec."Total Additions")
                {
                    ApplicationArea = all;
                }
                field("Total Deductions"; rec."Total Deductions")
                {
                    ApplicationArea = all;
                }
                field("Net Salary"; rec."Net Salary")
                {
                    ApplicationArea = all;
                }
                field("Salary Paid"; rec."Salary Paid")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

