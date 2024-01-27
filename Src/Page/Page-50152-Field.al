page 50152 "Field"
{
    PageType = List;
    SourceTable = 2000000041;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TableNo; rec.TableNo)
                {
                    ApplicationArea = all;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field(TableName; rec.TableName)
                {
                    ApplicationArea = all;
                }
                field(FieldName; rec.FieldName)
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field(Len; rec.Len)
                {
                    ApplicationArea = all;
                }
                field(Class; rec.Class)
                {
                    ApplicationArea = all;
                }
                field(Enabled; rec.Enabled)
                {
                    ApplicationArea = all;
                }
                field("Type Name"; rec."Type Name")
                {
                    ApplicationArea = all;
                }
                field("Field Caption"; rec."Field Caption")
                {
                    ApplicationArea = all;
                }
                field(RelationTableNo; rec.RelationTableNo)
                {
                    ApplicationArea = all;
                }
                field(RelationFieldNo; rec.RelationFieldNo)
                {
                    ApplicationArea = all;
                }
                field(SQLDataType; rec.SQLDataType)
                {
                    ApplicationArea = all;
                }
                field(OptionString; rec.OptionString)
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

