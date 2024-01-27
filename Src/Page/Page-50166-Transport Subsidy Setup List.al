page 50166 "Transport Subsidy Setup List"
{
    DeleteAllowed = false;
    PageType = List;
    SourceTable = 50014;
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
                field("Starting Range (KMS)"; rec."Starting Range (KMS)")
                {
                    ApplicationArea = all;
                }
                field("Ending Range (KMS)"; rec."Ending Range (KMS)")
                {
                    ApplicationArea = all;
                }
                field("Rate (Rs.)"; rec."Rate (Rs.)")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        ERROR('please contact system administrator'); //RSPLDP
    end;
}

