page 60047 "Pay Revision Header List"
{
    Editable = false;
    PageType = List;
    SourceTable = 60048;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Id."; rec."Id.")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; rec."Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; rec."Employee Name")
                {
                    ApplicationArea = all;
                }
                field(Grade; rec.Grade)
                {
                    ApplicationArea = all;
                }
                field("Effective Date"; rec."Effective Date")
                {
                    ApplicationArea = all;
                }
                field("New Grade"; rec."New Grade")
                {
                    ApplicationArea = all;
                }
                field("Revisied Date"; rec."Revisied Date")
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

