page 50159 "QC Test"
{
    PageType = List;
    Permissions = TableData 50002 = rimd;
    SourceTable = 50002;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Order No."; rec."Order No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Parameter; rec.Parameter)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Min Range"; rec."Min Range")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Max Range"; rec."Max Range")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Result; rec.Result)
                {
                    ApplicationArea = all;
                }
                field(Approved; rec.Approved)
                {
                    ApplicationArea = all;
                }
                field("Qty to Approve"; rec."Qty to Approve")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Typical Value"; rec."Typical Value")
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

