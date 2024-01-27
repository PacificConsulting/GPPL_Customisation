page 50091 Transporter
{
    PageType = List;
    SourceTable = 50046;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                }
                field("GSTIN No."; rec."GSTIN No.")
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

