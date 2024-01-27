tableextension 50020 UserSetupExtCustm extends "User Setup"
{
    fields
    {
        field(50021; "Location Filter"; Code[240])
        {
            Description = 'Added for HotFix---10.05.2012';
            TableRelation = Location;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50026; Name; Text[50])
        {
            Description = 'EBT STIVAN 14/04/2012 - RSPL-TC changed length 30 to 50';
        }
        field(50027; "Credit Limit Approval"; Boolean)
        {
            Description = 'RSPL022 - Credit Limit Functionality';
        }
        field(50028; "TRO Deletion"; Boolean)
        {
            Description = 'RB-N 21Sep2017';
        }
        field(50029; "PO Creation"; Boolean)
        {
            Description = 'RB-N 16Nov2017';
        }
        field(50030; "JV Posting"; Boolean)
        {
            Description = 'RB-N 02Jul2018';
        }
        field(50031; "Insurance Adjustment"; Boolean)
        {
            Description = 'RB-N 07Mar2019';
        }
        field(50032; "Finance Approver"; Boolean)
        {
            Description = 'RB-N 06May2019';
        }
        field(50033; "Blanket PO Creation"; Boolean)
        {
            Description = 'RSPLSUM 10Feb2020';
        }
        field(50034; "Production BOM Edit"; Boolean)
        {
            Description = 'RSPLSUM 23Oct2020';
        }
        field(50035; "Packaging Prod. BOM Edit"; Boolean)
        {
            Description = 'RSPLSUM 29Oct2020';

            trigger OnValidate()
            begin
                TESTFIELD("Production BOM Edit", FALSE);//RSPLSUM 29Oct2020
            end;
        }
        field(50036; "Production BOM View"; Boolean)
        {
            Description = 'RSPLSUM 31Oct2020';

            trigger OnValidate()
            begin
                TESTFIELD("Production BOM Edit", FALSE);//RSPLSUM 31Oct2020
                TESTFIELD("Packaging Prod. BOM Edit", FALSE);//RSPLSUM 31Oct2020
            end;
        }
        field(50037; "Credit Limit Update"; Boolean)
        {
            Description = 'RSPLSUM 28Dec2020';
        }
        field(50038; "Description 3 Visible"; Boolean)
        {
            Description = 'RSPLSUM 29Dec2020';
        }
        field(50039; "Shipping Agent List Editable"; Boolean)
        {
            Description = 'RSPLSUM 30Apr2021';
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