tableextension 50060 SalesLineArchiveExtcstm extends 5108
{
    fields
    {
        field(50007; "Lot No."; Code[20])
        {
            Description = 'RB-N 03Jan2019';
            Editable = false;
        }
        field(50024; "National Discount"; Decimal)
        {
            Description = 'CAS-04788-L3W7L3';
            Editable = false;
        }
        field(50025; "Free of Cost"; Boolean)
        {
            Description = 'CAS-04788-L3W7L3';
        }
        field(50026; "Basic Price"; Decimal)
        {
            Description = 'CAS-05923-M4T6H6';
        }
        field(50027; "Freight/Other Chgs. Primary"; Decimal)
        {
            Description = 'CAS-05923-M4T6H6';
        }
        field(50028; "Freight/Other Chgs. Secondary"; Decimal)
        {
            Description = 'CAS-05923-M4T6H6';
        }
        field(50029; "Price Support"; Decimal)
        {
            Description = 'CAS-03500-H4N0R8';
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