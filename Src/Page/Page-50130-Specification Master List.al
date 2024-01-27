page 50130 "Specification Master List"
{
    Caption = 'Specification Master List';
    PageType = List;
    SourceTable = 50048;
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
                field(Specification; rec.Specification)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        IF rec.Specification <> '' THEN BEGIN
                            RecSpecMaster.RESET;
                            RecSpecMaster.SETFILTER(Specification, '%1', rec.Specification);
                            IF RecSpecMaster.FINDFIRST THEN
                                ERROR('Specification already exist for Code=%1', RecSpecMaster.Code);
                        END;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        RecSpecMaster: Record 50048;
}

