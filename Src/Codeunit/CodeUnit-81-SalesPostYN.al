codeunit 50017 SalesYNExtCstm
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeOnRun', '', false, false)]
    local procedure ValidationOnBeforerun(var SalesHeader: Record "Sales Header")
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        recCustomer: Record Customer;
        LocRec: Record Location;
        InvoicedSaleLine: Record "Sales Line";
        InvoicedErr: Label 'This Document is already Posted.';
    begin
        ;
        //EBT STIVAN ---(08102012)--- POP Up of ERROR Message if CT3 is True and Information is Blank -------START
        IF SalesHeader."Location Code" <> 'BOND0001' THEN BEGIN
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN BEGIN
                IF SalesHeader."CT3 Order" = TRUE THEN BEGIN
                    IF (SalesHeader."CT3 No." = '') AND (SalesHeader."CT3 Date" = 0D)
                        AND (SalesHeader."ARE3 No." = '') AND (SalesHeader."ARE3 Date" = 0D) THEN
                        ERROR('Plz Update the CT3 Information');
                END;
            END;
        END;
        //EBT STIVAN ---(08102012)--- POP Up of ERROR Message if CT3 is True and Information is Blank ---------END

        //YSR30847  --
        IF SalespersonPurchaser.GET(SalesHeader."Salesperson Code") THEN
            //IF  SalespersonPurchaser."RWR Parent" THEN
            IF recCustomer.GET(SalesHeader."Sell-to Customer No.") THEN BEGIN
                IF (recCustomer."RWR Salesperson" <> '') AND (SalesHeader."RWR Salesperson" = '') THEN
                    SalesHeader.TESTFIELD(SalesHeader."RWR Salesperson");
            END;
        //YSR30847  ++

        //EBT STIVAN ---(08102012)--- POP Up of ERROR Message if CT1 is True and Information is Blank -------START
        IF SalesHeader."Location Code" <> 'BOND0001' THEN BEGIN
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN BEGIN
                IF SalesHeader."CT1 Order" = TRUE THEN BEGIN
                    IF (SalesHeader."CT1 No." = '') AND (SalesHeader."CT1 Date" = 0D)
                        AND (SalesHeader."ARE1 No." = '') AND (SalesHeader."ARE1 Date" = 0D) THEN
                        ERROR('Plz Update the CT1 Information');
                END;
            END;
        END;
        //EBT STIVAN ---(08102012)--- POP Up of ERROR Message if CT3 is True and Information is Blank ---------END

        //EBT STIVAN ---(08102012)--- POP Up of ERROR Message if Export Under Rebate is True and Information is Blank -------START
        IF SalesHeader."Location Code" <> 'BOND0001' THEN BEGIN
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN BEGIN
                IF SalesHeader."Under Rebate" = TRUE THEN BEGIN
                    IF SalesHeader."Export Under Rebate" = '' THEN
                        ERROR('Please update Export Under Rebate');
                END;
            END;

        END;
        //EBT STIVAN ---(08102012)--- POP Up of ERROR Message if Export Under Rebate is True and Information is Blank ---------END

        //EBT STIVAN ---(08102012)--- POP Up of ERROR Message if Export Under LUT is True and Information is Blank -------START
        IF SalesHeader."Location Code" <> 'BOND0001' THEN BEGIN
            IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN BEGIN
                IF SalesHeader."Under LUT" = TRUE THEN BEGIN
                    IF SalesHeader."Export Under LUT" = '' THEN
                        ERROR('Please update Export Under LUT');
                END;
            END;
        END;
        //EBT STIVAN ---(08102012)--- POP Up of ERROR Message if Export Under LUT is True and Information is Blank ---------END

        //Start DJ 13/03/20 Calculate Distance in KM for Eway Bill
        IF SalesHeader."Distance in kms" = 0 THEN BEGIN
            IF (SalesHeader."Location Code" <> '') AND (SalesHeader."Ship-to Post Code" <> '') THEN BEGIN
                LocRec.GET(SalesHeader."Location Code");
                IF LocRec."Post Code" <> '' THEN BEGIN
                    //SalesHeader."Distance in kms" := CUEwayAPI.DistanceMatrix(LocRec."Post Code", "Ship-to Post Code"); Pending
                    //"Distance in kms" := CUEwayAPI.GetDistanceInKM(LocRec."Post Code","Ship-to Post Code",DistanceAPIKey);
                    //SalesHeader.MODIFY;
                END;
            END;
        END;
        // DJ 13/03/20 END Calculate Distance in KM for Eway Bill

        //DJ 22012021
        CASE SalesHeader."Document Type" OF
            SalesHeader."Document Type"::"Return Order":
                BEGIN
                    InvoicedSaleLine.RESET;
                    InvoicedSaleLine.SETRANGE("Document No.", SalesHeader."No.");
                    InvoicedSaleLine.SETRANGE("Document Type", SalesHeader."Document Type");
                    InvoicedSaleLine.SETFILTER("Quantity Invoiced", '<>%1', 0);
                    IF InvoicedSaleLine.FINDFIRST THEN
                        ERROR(InvoicedErr);
                END;
            SalesHeader."Document Type"::"Credit Memo":
                BEGIN
                    InvoicedSaleLine.RESET;
                    InvoicedSaleLine.SETRANGE("Document No.", SalesHeader."No.");
                    InvoicedSaleLine.SETRANGE("Document Type", SalesHeader."Document Type");
                    InvoicedSaleLine.SETFILTER("Quantity Invoiced", '<>%1', 0);
                    IF InvoicedSaleLine.FINDFIRST THEN
                        ERROR(InvoicedErr);
                END;
        END;
        //DJ 22012021
    end;

    var
        myInt: Integer;
}