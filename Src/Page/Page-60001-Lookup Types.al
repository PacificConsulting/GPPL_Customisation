page 60001 "Lookup Types"
{
    // B2B Software Technologies
    // ---------------------------
    // Project : Human Resource
    // B2B
    // No. sign      Date
    // ---------------------------
    // 01   B2B    13-dec-05

    Caption = 'Lookup Types';
    DelayedInsert = true;
    PageType = List;
    SourceTable = 60017;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
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

