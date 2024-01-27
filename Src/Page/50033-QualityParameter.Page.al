page 50033 "Quality Parameter"
{
    PageType = List;
    SourceTable = 50024;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("ISI Test Method"; rec."ISI Test Method")
                {
                    ApplicationArea = all;
                }
                field("ASTM Test Method"; rec."ASTM Test Method")
                {
                    ApplicationArea = all;
                }
                field("IP Test Method"; rec."IP Test Method")
                {
                    ApplicationArea = all;
                }
                field("Other Test Method"; rec."Other Test Method")
                {
                    ApplicationArea = all;
                }
                field("Outsourced Tests"; rec."Outsourced Tests")
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

