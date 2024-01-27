page 60010 "Shift Card"
{
    PageType = Card;
    SourceTable = 60022;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Shift Code"; Rec."Shift Code")
                {
                    ApplicationArea = all;
                }
                field(Decription; Rec.Decription)
                {
                    ApplicationArea = all;
                    Caption = 'Description';
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = all;
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ApplicationArea = all;
                }
                field("Break Start Time"; Rec."Break Start Time")
                {
                    ApplicationArea = all;
                }
                field("Break End time"; Rec."Break End time")
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

