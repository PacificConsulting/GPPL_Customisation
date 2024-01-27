// MY PC 08 01 2024
pageextension 50074 "BlanketPurchaseOrderSubFormExt" extends "Blanket Purchase Order Subform"
{
    layout
    {
        modify(Type)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                RecPH: Record "Purchase Header";
                FieldEditable13: Boolean;
                RecNoSeries: Record 308;
                PH03: Record 38;

            BEGIN

                IF rec.Type = rec.Type::" " THEN
                    FieldEditable13 := FALSE;

                IF rec.Type = rec.Type::Item THEN
                    FieldEditable13 := FALSE;

                IF rec.Type = rec.Type::Item THEN
                    FieldEditable13 := TRUE;

                RecPH.RESET;
                RecPH.SETRANGE("Document Type", rec."Document Type");
                RecPH.SETRANGE("No.", rec."Document No.");
                RecPH.SETRANGE("Work Order", TRUE);
                IF RecPH.FINDFIRST THEN BEGIN
                    RecNoSeries.RESET;
                    IF RecNoSeries.GET(RecPH."No. Series") THEN BEGIN
                        IF RecNoSeries."Work Order" THEN BEGIN//RSPLSUM 14Apr2020                                 

                            PH03.RESET;
                            PH03.SETRANGE("Document Type", rec."Document Type");
                            PH03.SETRANGE("No.", rec."Document No.");
                            PH03.SETRANGE("Work Order", TRUE);
                            IF PH03.FINDFIRST THEN BEGIN
                                IF rec.Type = rec.Type::"G/L Account" THEN
                                    ERROR('G/L Account is only allowed in Work Order');
                            END;

                        END;//RSPLSUM 14Apr2020
                    END;//RSPLSUM 14Apr2020
                END;//RSPLSUM 14Apr2020
                    //RSPLSUM 14Apr2020
            END;

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}