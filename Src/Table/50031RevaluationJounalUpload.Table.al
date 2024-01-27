table 50031 "Revaluation Jounal Upload"
{

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Item Journal Template";
        }
        field(2; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(3; "Line No"; Integer)
        {
        }
        field(4; "Shortcut Dimension 1 Code"; Code[10])
        {
        }
        field(5; "Shortcut Dimension 2 Code"; Code[10])
        {
        }
        field(6; "Unit Cost (Revalued)"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Journal Template Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

