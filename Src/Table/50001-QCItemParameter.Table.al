table 50001 "QC Item Parameter"
{
    Caption = 'QC Item Parameter - RM';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            TableRelation = Item."No.";

            trigger OnValidate()
            begin

                Item.RESET;
                Item.SETRANGE(Item."No.", "Item No.");
                IF Item.FINDFIRST THEN
                    "Inventory Posting Group" := Item."Inventory Posting Group";
            end;
        }
        field(2; "Parameter Code"; Code[30])
        {
            TableRelation = "QC Master"."Parameter Code" WHERE("Inventory Posting Group" = FIELD("Inventory Posting Group"));
        }
        field(3; "Inventory Posting Group"; Code[10])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(4; Description; Text[50])
        {
        }
        field(5; "Typical value"; Text[30])
        {
        }
        field(6; "Min Value"; Text[30])
        {
        }
        field(7; "Max Value"; Text[30])
        {
        }
        field(8; "Test Method"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Item No.", "Parameter Code", "Test Method")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        QCParameter.RESET;
        QCParameter.SETRANGE(QCParameter."Inventory Posting Group", "Inventory Posting Group");
        QCParameter.SETRANGE(QCParameter."Parameter Code", "Parameter Code");
        QCParameter.SETRANGE(QCParameter."Test Methods", "Test Method");
        IF QCParameter.FINDFIRST THEN
            Description := QCParameter.Description;
    end;

    var
        InventPostnGrp: Record 94;
        Item: Record 27;
        QCParameter: Record 50000;
}

