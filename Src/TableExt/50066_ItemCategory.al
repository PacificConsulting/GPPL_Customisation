tableextension 50066 ItemCategoryExtCstm extends "Item Category"
{
    fields
    {
        field(50101; "Def. Excise Posting Group"; Code[10])
        {
            Description = 'EBT0001';
            //TableRelation = "Excise Prod. Posting Group".Code;Azhar Pending
        }
        field(50102; "Administration Overhead"; Decimal)
        {
            Description = 'CAS-18981-N5Q1K1';
        }
        field(50103; "Selling Distribution Overhead"; Decimal)
        {
            Description = 'CAS-18981-N5Q1K1';
        }
        field(50104; Depreciation; Decimal)
        {
            Description = 'CAS-18981-N5Q1K1';
        }
        field(50105; "Finance Cost"; Decimal)
        {
            Description = 'CAS-18981-N5Q1K1';
        }
        field(50106; "Corporate Tax"; Decimal)
        {
            Description = 'CAS-18981-N5Q1K1';
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}