table 50042 "Dispatch From Location"
{
    DrillDownPageID = 50134;
    LookupPageID = 50134;

    fields
    {
        field(1; "Location Code"; Code[10])
        {
        }
        field(2; Name; Text[50])
        {
        }
        field(3; "Address 1"; Text[50])
        {
        }
        field(4; "Address 2"; Text[50])
        {
        }
        field(5; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country" = CONST()) "Post Code".City
            ELSE
            IF (Country = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD(Country));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //Postcode.ValidateCity(City,"Post Code",County,County,(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(6; "Post Code"; Code[10])
        {
            TableRelation = IF (Country = CONST()) "Post Code"
            ELSE
            IF (Country = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD(Country));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Postcode.ValidatePostCode(City, "Post Code", Country, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(7; "State Code"; Code[10])
        {
            Caption = 'State Code';
            TableRelation = State;
        }
        field(8; Country; Text[30])
        {
            Caption = 'County';
        }
        field(9; "Dispatch Location Code"; Code[10])
        {
        }
        field(10; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
    }

    keys
    {
        key(Key1; "Location Code", "Dispatch Location Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Postcode: Record 225;
}

