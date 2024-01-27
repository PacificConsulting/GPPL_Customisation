codeunit 50008 "Form Details Update"
{

    trigger OnRun()
    begin
        TempDetails.RESET;
        IF TempDetails.FINDSET THEN
            REPEAT
                SalesInvoice.GET(TempDetails."doc no");
                //SalesInvoice."Form No." := TempDetails."Form No.";
                SalesInvoice."Posting Date" := TempDetails."Posting date";
                SalesInvoice."C Form Amount" := TempDetails."C Form Amount";
                SalesInvoice."C Form Date" := TempDetails."C Form Date";
                SalesInvoice."C Form Recd.Date" := TempDetails."C Form Received Date";
                SalesInvoice."Period From" := TempDetails."Period From";
                SalesInvoice."Period To" := TempDetails."Period To";
                SalesInvoice."DN/CN No." := TempDetails."DN/CN No.";
                SalesInvoice."DN/CN Type" := TempDetails."DN/CN Type";
                SalesInvoice."Diff. Reason" := TempDetails."Diff. Reason";
                SalesInvoice."Diff.Amount" := TempDetails."Diff.Amount";
                SalesInvoice.MODIFY;
                TempDetails.Update := TRUE;
                TempDetails.MODIFY;
            UNTIL TempDetails.NEXT = 0;
        MESSAGE('Updated');
    end;

    var
        SalesInvoice: Record 112;
        TempDetails: Record 50005;
}

