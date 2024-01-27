tableextension 50026 SalesInvLineExtCustm extends 113
{
    fields
    {
        field(50000; "Inventory Posting Group"; Code[20])
        {
            Description = 'EBT/CSO/Item filter/0001';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group";
        }
        field(50007; "Lot No."; Code[20])
        {
            Description = 'RG23D';
            Editable = true;
        }
        field(50008; "MRP/Sales Price"; Decimal)
        {
            Description = 'EBT0001';
        }
        field(50010; "Approve User ID"; Code[20])
        {
            Description = 'CAS-04093-B1C3X9';
        }
        field(50011; "Approval Date"; Date)
        {
            Description = 'CAS-04093-B1C3X9';
        }
        field(50012; "Approval Time"; Time)
        {
            Description = 'CAS-04093-B1C3X9';
        }
        field(50013; "List Price"; Decimal)
        {
            Description = 'EBT0001';
            Editable = false;
        }
        field(50016; "Appiles to Inv.No."; Code[20])
        {
            TableRelation = "Sales Invoice Header";
        }
        field(50017; "Supplimentary Invoice"; Boolean)
        {
        }
        field(50018; "Final Item No."; Code[10])
        {
        }
        field(50021; "Final Line No."; Integer)
        {
            Description = 'EBT0002';
        }
        field(50022; "Last Billing Price"; Decimal)
        {
            Description = 'EBT STIVAN (07012013)';
        }
        field(50023; "Commission Amount"; Decimal)
        {
            Description = 'EBT - PRATYUSHA - CUST-COMM';
        }
        field(50024; "National Discount Per Ltr"; Decimal)
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
        field(50029; "Price Support Per Ltr"; Decimal)
        {
            Description = 'CAS-03500-H4N0R8';
        }
        field(50030; "National Discount Amount"; Decimal)
        {
            Description = 'CAS-03500-H4N0R8';
        }
        field(50031; "Price Support Amount"; Decimal)
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