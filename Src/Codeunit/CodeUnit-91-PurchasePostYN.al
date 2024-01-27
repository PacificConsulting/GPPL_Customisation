codeunit 50018 PurchaseYNExtCstm
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeOnRun', '', false, false)]
    local procedure ValidationOnBeforerun(var PurchaseHeader: Record "Purchase Header")
    var
        Selection: Integer;
        Text000: Label '&Receive,&Invoice';
        Text001: Label 'Do you want to post the %1?';
        Text002: Label '&Ship,&Invoice,Ship &and Invoice';
        Text003: Label 'Ship &and Invoice';
        Ship: Boolean;
        Invoice: Boolean;
        Receive: Boolean;
    begin

        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then BEGIN
            //Selection := STRMENU(Text000,3);  //Commented By EBT STIVAN (30072012) - To remove the Receive&Invoice Option
            Selection := STRMENU(Text000, 1);    //EBT STIVAN (30072012) - To remove the Receive&Invoice Option
            IF Selection = 0 THEN
                EXIT;
            //Receive := Selection IN [1,3];     //Commented By EBT STIVAN (30072012) - To remove the Receive&Invoice Option
            Receive := Selection IN [1, 2];     //EBT STIVAN (30072012) - To remove the Receive&Invoice Option
            //Invoice := Selection IN [2,3];     //Commented By EBT STIVAN (30072012) - To remove the Receive&Invoice Option
            Invoice := Selection IN [2, 2];     //EBT STIVAN (30072012) - To remove the Receive&Invoice Option
        END;
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Return Order" then BEGIN
        end;
        IF NOT PurchaseHeader."Gate Pass" THEN BEGIN
            Selection := STRMENU(Text002, 2);    //EBT STIVAN (30072012) - To remove the Receive&Invoice Option
            IF Selection = 0 THEN
                EXIT;
            //Ship := Selection IN [1,3];         //Commented By EBT STIVAN (30072012) - To remove the Receive&Invoice Option
            Ship := Selection IN [1, 2];         //EBT STIVAN (30072012) - To remove the Receive&Invoice Option
            //Invoice := Selection IN [2,3];      //Commented By EBT STIVAN (30072012) - To remove the Receive&Invoice Option
            Invoice := Selection IN [2, 2];      //EBT STIVAN (30072012) - To remove the Receive&Invoice Option
        END ELSE BEGIN
            //>>17Mar2019
            Selection := STRMENU(Text003, 1);
            Ship := TRUE;
            Invoice := TRUE;
            //<<17Mar2019
        end;
    end;

    var
        myInt: Integer;
}