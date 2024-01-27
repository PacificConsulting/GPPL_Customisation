tableextension 50076 WarehouseReceiptHeaderExtCstm extends "Warehouse Receipt Header"
{
    fields
    {
        field(50000; "Receiving Date"; Date)
        {
            Description = 'EBT0001';
        }
        field(50001; "Density Factor"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50002; "Vendor Quantity"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50003; "Gross Weight"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50004; "Tare Weight"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';

            trigger OnValidate()
            begin
                "Net Weight" := "Gross Weight" - "Tare Weight";
            end;
        }
        field(50005; "Gate Entry No."; Code[20])
        {
            Description = 'EBT/PO Dens Func/0001';

            trigger OnLookup()
            begin
                // EBT MILAN 100214 --- to Show lookup of posted gate entry in case,if source type is purchase order-----------------START
                warehouseRcpt.RESET;
                warehouseRcpt.SETRANGE(warehouseRcpt."No.", "No.");
                warehouseRcpt.SETRANGE(warehouseRcpt."Source Document", warehouseRcpt."Source Document"::"Purchase Order");
                IF warehouseRcpt.FINDFIRST THEN;

                /*
                                Postedgateentry.RESET;
                                Postedgateentry.SETRANGE(Postedgateentry."Entry Type", Postedgateentry."Entry Type"::Inward);
                                Postedgateentry.SETRANGE(Postedgateentry."Source No.", warehouseRcpt."Source No.");
                                IF Postedgateentry.FINDFIRST THEN;

                                PostedgateentryHeader.RESET;
                                PostedgateentryHeader.SETRANGE(PostedgateentryHeader."Entry Type", PostedgateentryHeader."Entry Type"::Inward);
                                PostedgateentryHeader.SETRANGE(PostedgateentryHeader."No.", Postedgateentry."Gate Entry No.");
                                IF PAGE.RUNMODAL(50062, PostedgateentryHeader) = ACTION::LookupOK THEN
                                    VALIDATE("Gate Entry No.", PostedgateentryHeader."No.");

                        */
                // EBT MILAN 100214 --- to Show lookup of posted gate entry in case,if source type is purchase order-------------------END
            end;

            trigger OnValidate()
            begin
                //IF GateEntry.GET(0, "Gate Entry No.") THEN
                //   "Gross Weight" := GateEntry."Total Quantity";
            end;
        }
        field(50006; "Net Weight"; Decimal)
        {
            Description = 'EBT/PO Dens Func/0001';
        }
        field(50007; "Reference No."; Text[20])
        {
            Description = 'RSPLSUM28688 18Feb21';
        }
        field(50008; "QC Status"; Option)
        {
            Description = 'RSPLSUM28688 18Feb21';
            Editable = false;
            OptionCaption = 'Open,Pending for Approval,Approved,Rejected';
            OptionMembers = Open,"Pending for Approval",Approved,Rejected;
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
        "Receiving Date" := TODAY;   //EBT0001
        "Density Factor" := 1;   //EBT/PO Dens
    end;

    var
        myInt: Integer;
        warehouseRcpt: Record 7317;
}