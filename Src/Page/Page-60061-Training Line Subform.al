page 60061 "Training Line Subform"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = 60058;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Employee No."; rec."Employee No.")
                {
                    ApplicationArea = all;
                }
                field("First Name"; rec."First Name")
                {
                    ApplicationArea = all;
                }
                field("Employee Remarks"; rec."Employee Remarks")
                {
                    ApplicationArea = all;
                }
                field("Middle Name"; rec."Middle Name")
                {
                    ApplicationArea = all;
                }
                field(Surname; rec.Surname)
                {
                    ApplicationArea = all;
                }
                field("Department Code"; rec."Department Code")
                {
                    ApplicationArea = all;
                }
                field(Designation; rec.Designation)
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

