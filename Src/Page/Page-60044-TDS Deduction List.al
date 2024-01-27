page 60044 "TDS Deduction List"
{
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = 60046;
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
                    Editable = true;
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
                field("Gross Salary"; rec."Gross Salary")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Professional Tax"; rec."Professional Tax")
                {
                    ApplicationArea = all;
                }
                field("Gross Total Income"; rec."Gross Total Income")
                {
                    ApplicationArea = all;
                }
                field("Tax Liability"; rec."Tax Liability")
                {
                    ApplicationArea = all;
                }
                field("Planned Savings"; rec."Planned Savings")
                {
                    ApplicationArea = all;
                }
                field("Tax Liability after savings"; rec."Tax Liability after savings")
                {
                    ApplicationArea = all;
                }
                field("Tax Already Deducted"; rec."Tax Already Deducted")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Remaining Months"; rec."Remaining Months")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Tax Per Month"; rec."Tax Per Month")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action("TDS &Schedule")
                {
                    Caption = 'TDS &Schedule';
                    ApplicationArea = ALL;
                    trigger OnAction()
                    begin
                        TDSSchedule.SETRANGE("Employee No.", rec."Employee No.");
                        TDSSchedule.SETRANGE("Year Starting Date", rec."Year Starting Date");
                        TDSSchedule.SETRANGE("Year Ending Date", rec."Year Ending Date");
                        IF TDSSchedule.FIND('-') THEN
                            PAGE.RUN(60043, TDSSchedule)
                        ELSE
                            MESSAGE(Text000);
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Update &Gross Salary")
                {
                    Caption = 'Update &Gross Salary';
                    ApplicationArea = ALL;
                    trigger OnAction()
                    var
                        Payyear: Record 60020;
                        StartingDate: Date;
                        EndingDate: Date;
                        Days: Decimal;
                    begin
                        TDSCalculations.RUN;
                    end;
                }
                group("Compute &TDS Schedule")
                {
                    Caption = 'Compute &TDS Schedule';
                    action("Current &Employee")
                    {
                        Caption = 'Current &Employee';
                        ApplicationArea = all;
                        trigger OnAction()
                        begin
                            Rec.TESTFIELD("Tax Liability after savings");
                            TDSCalculations.TDSScheduleCalc(Rec);
                        end;
                    }
                    action("&All Employees")
                    {
                        Caption = '&All Employees';
                        ApplicationArea = all;
                        trigger OnAction()
                        begin
                            IF TDSDeduction.FIND('-') THEN
                                REPEAT
                                    TDSDeduction.TESTFIELD("Tax Liability after savings");
                                    TDSCalculations.TDSScheduleCalc(TDSDeduction);
                                UNTIL TDSDeduction.NEXT = 0;
                        end;
                    }
                }
                action("TDS &Re-schedule")
                {
                    Caption = 'TDS &Re-schedule';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        TDSCalculations.TDSReSchedule;
                    end;
                }
            }
        }
    }

    var
        TDSDeduction: Record 60046;
        TDSCalculations: Codeunit 60007;
        TDSSchedule: Record 60047;
        Text000: Label 'Compute TDS Schedule';
        RecRef: RecordRef;
}

