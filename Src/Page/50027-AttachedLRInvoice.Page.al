page 50027 "Attached LR Invoice"
{
    Editable = false;
    PageType = List;
    SourceTable = 50014;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(group)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field("Starting Range (KMS)"; rec."Starting Range (KMS)")
                {
                    ApplicationArea = all;
                }
                field("Ending Range (KMS)"; rec."Ending Range (KMS)")
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

