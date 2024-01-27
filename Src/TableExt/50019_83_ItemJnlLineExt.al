tableextension 50019 ItemJnlLineExtCutm extends 83
{
    fields
    {
        field(50010; "Item By Location"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Location Code" = FIELD("Location Code")));
            Description = 'EBT/MAN/0001';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Density Factor"; Decimal)
        {

            trigger OnValidate()
            begin
                IF NOT ("Entry Type" = "Entry Type"::Output) THEN
                    ERROR('Please put the density factor in Output Line');
            end;
        }
        field(50600; "Expire Date"; Date)
        {
            Description = 'RSPLAM30180';
            Editable = false;
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                EBTlocation: Record Location;
            begin
                EBTlocation.RESET;
                EBTlocation.SETRANGE(EBTlocation.Code, "Location Code");
                EBTlocation.SETRANGE(EBTlocation.Closed, TRUE);
                IF EBTlocation.FINDFIRST THEN BEGIN
                    ERROR('You are not allowed the select this Location as it is Closed');
                END;
            end;
        }
        modify("New Location Code")
        {
            trigger OnAfterValidate()
            var
                EBTlocation: Record Location;
            begin
                EBTlocation.RESET;
                EBTlocation.SETRANGE(EBTlocation.Code, "New Location Code");
                EBTlocation.SETRANGE(EBTlocation.Closed, TRUE);
                IF EBTlocation.FINDFIRST THEN BEGIN
                    ERROR('You are not allowed the select this Location as it is Closed');
                END;
            end;
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