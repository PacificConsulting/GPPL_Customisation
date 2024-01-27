table 50010 "Form Tracking"
{
    DrillDownPageID = 50016;
    LookupPageID = 50016;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Transfer From Location"; Code[10])
        {
            //TableRelation = Location WHERE("Use As In-Transit" = CONST(false), "Subcontracting Location" = CONST(false));
        }
        field(3; "Transfer To Location"; Code[10])
        {
            //TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
            //                                "Subcontracting Location" = CONST(false));
        }
        field(4; "Document Type"; Option)
        {
            OptionCaption = 'Sales Invoice,Transfer Shipment';
            OptionMembers = "Sales Invoice","Transfer Shipment";
        }
        field(7; "Form Code"; Code[10])
        {
            Editable = true;
            //TableRelation = "Form Codes";
        }
        field(8; "Posting Date"; Date)
        {
        }
        field(9; "Courier Name"; Text[30])
        {
        }
        field(10; "Courier Date"; Date)
        {
        }
        field(11; "Courier By"; Text[30])
        {
        }
        field(12; "Form No."; Text[30])
        {
            Editable = true;
        }
        field(13; Shipped; Boolean)
        {
        }
        field(14; Received; Boolean)
        {
        }
        field(15; "No. Series"; Code[10])
        {
        }
        field(16; "Received By"; Text[30])
        {
        }
        field(17; "Receiving Date"; Date)
        {

            trigger OnValidate()
            begin
                IF "Receiving Date" < "Posting Date" THEN
                    ERROR('Receiving Date cannot be earlier than Shipment Date');
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            SalesSetup.GET;
            SalesSetup.TESTFIELD(SalesSetup."C Form Track No.");
            // NoSeriesMgt.InitSeries(SalesSetup."C Form Track No.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    var
        SalesSetup: Record 311;
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesInvoice: Record 112;

    // [Scope(Internal)]
    procedure AssistEdit(): Boolean
    begin
        /*
        SalesSetup.GET;
        SalesSetup.TESTFIELD(SalesSetup."Cancelled Invoice Nos.");
        IF NoSeriesMgt.SelectSeries(SalesSetup."Cancelled Invoice Nos.", xRec."No. Series", "No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
        */
    end;
}

