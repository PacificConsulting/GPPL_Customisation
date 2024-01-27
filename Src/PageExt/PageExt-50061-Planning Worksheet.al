pageextension 50061 "Planning WorksheetExtCstm" extends "Planning Worksheet"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(CalculateRegenerativePlan)
        {
            trigger OnBeforeAction()
            var
                RequisitionLine: Record "Requisition Line";
                ItemRec: Record Item;
                OldQty: Decimal;
            begin
                //EBT/MANU/0001
                RequisitionLine.RESET;
                RequisitionLine.SETRANGE("Worksheet Template Name", rec."Worksheet Template Name");
                RequisitionLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                RequisitionLine.SETRANGE(Type, RequisitionLine.Type::Item);
                RequisitionLine.SETRANGE(RequisitionLine.Planned, FALSE);
                IF RequisitionLine.FINDSET THEN
                    REPEAT
                        ItemRec.GET(RequisitionLine."No.");
                        IF ItemRec."Base Unit of Measure" <> ItemRec."Sales Unit of Measure" THEN BEGIN
                            OldQty := RequisitionLine.Quantity;
                            RequisitionLine.VALIDATE(RequisitionLine."Unit of Measure Code", ItemRec."Sales Unit of Measure");
                            RequisitionLine.VALIDATE(RequisitionLine.Quantity, OldQty / RequisitionLine."Qty. per Unit of Measure");
                            RequisitionLine.Planned := TRUE;
                            RequisitionLine.MODIFY;
                        END;
                    UNTIL RequisitionLine.NEXT = 0;
                //EBT/MANU/0001
            end;
        }
        modify("Calculate &Net Change Plan")
        {
            trigger OnAfterAction()
            var
                RequisitionLine: Record "Requisition Line";
                ItemRec: Record Item;
                OldQty: Decimal;
            begin
                //EBT/MANU/0001
                RequisitionLine.RESET;
                RequisitionLine.SETRANGE("Worksheet Template Name", rec."Worksheet Template Name");
                RequisitionLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                RequisitionLine.SETRANGE(Type, RequisitionLine.Type::Item);
                RequisitionLine.SETRANGE(RequisitionLine.Planned, FALSE);
                IF RequisitionLine.FINDSET THEN
                    REPEAT
                        ItemRec.GET(RequisitionLine."No.");
                        IF ItemRec."Base Unit of Measure" <> ItemRec."Sales Unit of Measure" THEN BEGIN
                            OldQty := RequisitionLine.Quantity;
                            RequisitionLine.VALIDATE(RequisitionLine."Unit of Measure Code", ItemRec."Sales Unit of Measure");
                            RequisitionLine.VALIDATE(RequisitionLine.Quantity, OldQty / RequisitionLine."Qty. per Unit of Measure");
                            RequisitionLine.Planned := TRUE;
                            RequisitionLine.MODIFY;
                        END;
                    UNTIL RequisitionLine.NEXT = 0;
                //EBT/MANU/0001
            end;
        }
    }

    var
        myInt: Integer;
}