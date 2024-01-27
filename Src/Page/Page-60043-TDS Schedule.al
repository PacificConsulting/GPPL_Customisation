page 60043 "TDS Schedule"
{
    // 14-Feb-06

    DelayedInsert = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = 60047;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Employee No."; rec."Employee No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Year Starting Date"; rec."Year Starting Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Year Ending Date"; rec."Year Ending Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Month; rec.Month)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("TDS Amount"; rec."TDS Amount")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        TDSAmountOnAfterValidate;
                    end;
                }
                field("TDS Amount Deducted"; rec."TDS Amount Deducted")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            group(group1)
            {
                field(TDSCheckAmount; TDSCheckAmount)
                {
                    ApplicationArea = all;
                    Caption = 'TDS Schedule Amoount';
                    Editable = false;
                }
                field(TaxLiabiltyAmt; TaxLiabiltyAmt)
                {
                    ApplicationArea = all;
                    Caption = 'Tax Liability After Savings';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        TDSDeduction.SETRANGE("Employee No.", rec."Employee No.");
        TDSDeduction.SETRANGE("Year Starting Date", rec."Year Starting Date");
        TDSDeduction.SETRANGE("Year Ending Date", rec."Year Ending Date");
        IF TDSDeduction.FIND('-') THEN
            REPEAT
                TDSSchedule.SETRANGE("Employee No.", TDSDeduction."Employee No.");
                TDSSchedule.SETRANGE("Year Starting Date", TDSDeduction."Year Starting Date");
                TDSSchedule.SETRANGE("Year Ending Date", TDSDeduction."Year Ending Date");
                IF TDSSchedule.FIND('-') THEN
                    REPEAT
                        TDSCheckAmount := TDSCheckAmount + TDSSchedule."TDS Amount";
                    UNTIL TDSSchedule.NEXT = 0;
                TDSCheckAmount := ROUND(TDSCheckAmount, 0.01);
                TaxLiabiltyAmt := ROUND(TDSDeduction."Tax Liability after savings", 0.01);
            UNTIL TDSDeduction.NEXT = 0;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        TDSDeduction.SETRANGE("Employee No.", rec."Employee No.");
        TDSDeduction.SETRANGE("Year Starting Date", rec."Year Starting Date");
        TDSDeduction.SETRANGE("Year Ending Date", rec."Year Ending Date");
        IF TDSDeduction.FIND('-') THEN
            REPEAT
                IF TDSCheckAmount <> TDSDeduction."Tax Liability after savings" THEN
                    ERROR(Text001, TDSDeduction."Tax Liability after savings", TDSDeduction."Employee No.");
            UNTIL TDSDeduction.NEXT = 0;
    end;

    var
        TDSDeduction: Record 60046;
        TDSSchedule: Record 60047;
        TotalAmount: Decimal;
        Text001: Label 'Total TDS Amount must be equal to %1 for the employee %2';
        TDSCheckAmount: Decimal;
        TaxLiabiltyAmt: Decimal;
        RecRef: RecordRef;
        Text19026124: Label 'TDS Schedule Amoount';
        Text19034749: Label 'Tax Liability After Savings';

    local procedure TDSAmountOnAfterValidate()
    begin
        /*IF "TDS Amount" = 0 THEN
          TDSCheckAmount := TDSCheckAmount - xRec."TDS Amount"
        ELSE
          TDSCheckAmount := TDSCheckAmount + "TDS Amount";
        */
        TDSCheckAmount := TDSCheckAmount - xRec."TDS Amount" + rec."TDS Amount";
        TDSCheckAmount := ROUND(TDSCheckAmount, 0.01);

    end;
}

