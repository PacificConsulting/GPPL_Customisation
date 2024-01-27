tableextension 50016 InvPstBufferExtCutm extends "Invoice Posting Buffer"
{
    fields
    {
        field(50001; "Transport Subsidy (%)"; Decimal)
        {
            Description = 'EBT';
        }
        field(50002; "Price Support"; Decimal)
        {
            Description = 'Sourav';
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
    // MY PC 05 01 2024
    // PROCEDURE PrepareSales(VAR SalesLine: Record 37);
    //  BEGIN
    ////     begin
    //Sourav
    //      "Price Support" := SalesLine."Price Support Per Ltr" * SalesLine."Qty. to Invoice (Base)";
    //Sourav
    //  end;
    // end;
    // END;


}