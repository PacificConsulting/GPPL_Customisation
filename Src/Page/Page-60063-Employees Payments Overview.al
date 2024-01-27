page 60063 "Employees Payments Overview"
{
    PageType = Card;
    SourceTable = 60018;
    SourceTableView = WHERE("LookupType Name" = CONST('ADDITIONS AND DEDUCTIONS'));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
    }

    actions
    {
    }

    var
        //PeriodFormMgt: Codeunit "PeriodFormManagement";
        Employee: Record 60019;
        Lookup: Record 60018;
        PayElements: Record 60025;
        ProcessedSalary: Record 60038;
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        QtyType: Option "Net Change","Balance at Date";
        PayableAmount: Decimal;
        PayCadre: Code[20];
        EmployeeNo: Code[20];
        RecRef: RecordRef;
}

