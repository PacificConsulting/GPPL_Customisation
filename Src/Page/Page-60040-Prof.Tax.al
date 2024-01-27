page 60040 "Prof.Tax"
{
    DelayedInsert = true;
    PageType = Document;
    SourceTable = 60044;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Branch Code"; rec."Branch Code")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Effective Date"; rec."Effective Date")
                {
                    ApplicationArea = all;
                }
            }
            part(part1; 60041)
            {
                SubPageLink = "Branch Code" = FIELD("Branch Code"),
                              "Effective Date" = FIELD("Effective Date");
            }
        }
    }

    actions
    {
    }

    var
        RecRef: RecordRef;
}

