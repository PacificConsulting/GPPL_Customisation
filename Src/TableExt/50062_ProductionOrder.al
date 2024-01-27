tableextension 50062 ProductionOrderExtCstm extends "Production Order"
{
    fields
    {
        field(50000; "QC Tested"; Boolean)
        {
            Description = '//EBT/QC Func/0001';
        }
        field(50001; "Order Type"; Option)
        {
            Description = '//EBT/QC Func/0001';
            OptionCaption = 'Primary,Secondary';
            OptionMembers = Primary,Secondary;
        }
        field(50011; "Man Hours"; Decimal)
        {
            Description = 'RB-N, 28July2017';
        }
        field(50012; "Machine Hours"; Decimal)
        {
            Description = 'RB-N, 28July2017';
        }
        field(50013; "Refresh ProdOrder Qty"; Boolean)
        {
            Description = 'RB-N, 20Oct2018';
        }
        field(99998; "Created Time"; Time)
        {
            Description = 'EBT STIVAN 08012013';
        }
        field(99999; "Finished Time"; Time)
        {
            Description = 'EBT STIVAN 08012013';
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
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        //EBT STIVAN ---(08/01/2013)--- To Update the Created Date and Time, When New Prod. Order is Created-----START
        IF Status = Status::Planned THEN BEGIN
            "Creation Date" := TODAY;
            "Created Time" := TIME;
        END;
        //EBT STIVAN ---(08/01/2013)--- To Update the Created Date and Time, When New Prod. Order is Created-------END

    end;

    var
        myInt: Integer;
}