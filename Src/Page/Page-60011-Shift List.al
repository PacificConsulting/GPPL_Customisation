page 60011 "Shift List"
{
    Editable = false;
    PageType = List;
    SourceTable = 60022;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Shift Code"; Rec."Shift Code")
                {
                    ApplicationArea = all;
                }
                field(Decription; Rec.Decription)
                {
                    ApplicationArea = all;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = all;
                }
                field("Ending Time"; Rec."Ending Time")
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

