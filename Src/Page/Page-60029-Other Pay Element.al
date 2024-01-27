page 60029 "Other Pay Element"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = 60035;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(SalesCodeFilterCtrl; CurrentPayElement)
                {
                    Caption = 'Pay Element Code';
                    Enabled = SalesCodeFilterCtrlEnable;
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF PAGE.RUNMODAL(0, PayDeduct) = ACTION::LookupOK THEN BEGIN
                            CurrentPayElement := PayDeduct."Pay Element code";
                            CurrentDescription := PayDeduct.Description;
                            Priority := PayDeduct.Priority;
                        END;
                        CurrPage.SAVERECORD;
                        SetRecFilters;
                    end;

                    trigger OnValidate()
                    begin
                        CurrentPayElementOnAfterValida;
                    end;
                }
                field(CurrentDescription; CurrentDescription)
                {
                    Caption = 'Description';
                    Editable = false;
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrentDescriptionOnAfterValid;
                    end;
                }
                field(CurrentMonth; CurrentMonth)
                {
                    Caption = 'Month';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrentMonthOnAfterValidate;
                    end;
                }
                field(CurrentYear; CurrentYear)
                {
                    Caption = 'Year';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrentYearOnAfterValidate;
                    end;
                }
            }
            repeater(control1)
            {
                field("Employee No."; rec."Employee No.")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        IF rec.Type = rec.Type::Canteen THEN BEGIN
                            AmountEditable := FALSE;
                            QuantityEditable := TRUE;
                        END ELSE BEGIN
                            AmountEditable := TRUE;
                            QuantityEditable := FALSE;
                        END;
                    end;
                }
                field("Employee Name"; rec."Employee Name")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                    Editable = QuantityEditable;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                    Editable = AmountEditable;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Calculate &Amount")
                {
                    ApplicationArea = all;
                    Caption = 'Calculate &Amount';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        OtherAddDed.RESET;
                        OtherAddDed.SETRANGE(Month, CurrentMonth);
                        OtherAddDed.SETRANGE(Year, CurrentYear);
                        OtherAddDed.SETRANGE("Pay Element Code", CurrentPayElement);
                        OtherAddDed.SETRANGE(Type, OtherAddDed.Type::Canteen);
                        IF OtherAddDed.FIND('-') THEN BEGIN
                            REPEAT
                                CanteenAmount(OtherAddDed);
                            UNTIL OtherAddDed.NEXT = 0;
                        END;

                        OtherAddDed.RESET;
                        OtherAddDed.SETRANGE(Month, CurrentMonth);
                        OtherAddDed.SETRANGE(Year, CurrentYear);
                        OtherAddDed.SETRANGE("Pay Element Code", CurrentPayElement);
                        OtherAddDed.SETRANGE(Type, OtherAddDed.Type::"Holiday Compensation");
                        IF OtherAddDed.FIND('-') THEN BEGIN
                            REPEAT
                                HolidayCompensation(OtherAddDed);
                            UNTIL OtherAddDed.NEXT = 0;
                        END;


                        OtherAddDed.RESET;
                        OtherAddDed.SETRANGE(Month, CurrentMonth);
                        OtherAddDed.SETRANGE(Year, CurrentYear);
                        OtherAddDed.SETRANGE("Pay Element Code", CurrentPayElement);
                        OtherAddDed.SETRANGE(Type, OtherAddDed.Type::OT);
                        IF OtherAddDed.FIND('-') THEN BEGIN
                            REPEAT
                                OTcalc(OtherAddDed);
                            UNTIL OtherAddDed.NEXT = 0;
                        END;
                    end;
                }
                action("Get &Employees")
                {
                    ApplicationArea = all;
                    Caption = 'Get &Employees';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Employee.RESET;
                        Employee.SETRANGE(Blocked, FALSE);
                        IF Employee.FIND('-') THEN
                            REPEAT
                                OtherPayElements.INIT;
                                OtherPayElements."Employee No." := Employee."No.";
                                OtherPayElements."Employee Name" := Employee."First Name" + Employee."Middle Name";
                                OtherPayElements.Month := CurrentMonth;
                                OtherPayElements.Year := CurrentYear;
                                OtherPayElements."Pay Element Code" := CurrentPayElement;
                                IF PayDeduct.GET(OtherPayElements."Pay Element Code") THEN BEGIN
                                    OtherPayElements.Description := PayDeduct.Description;
                                    OtherPayElements."Add/Deduct" := PayDeduct."Add/Deduct";
                                    OtherPayElements.Type := PayDeduct.Type;
                                END;
                                OtherPayElements.INSERT
                            UNTIL Employee.NEXT = 0;
                    end;
                }
            }
            action("P&ost")
            {
                ApplicationArea = all;
                Caption = 'P&ost';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF CONFIRM(Text001, TRUE) THEN BEGIN
                        OtherAddDed.RESET;
                        OtherAddDed.SETRANGE(Month, CurrentMonth);
                        OtherAddDed.SETRANGE(Year, CurrentYear);
                        OtherAddDed.SETRANGE("Pay Element Code", CurrentPayElement);
                        IF OtherAddDed.FIND('-') THEN BEGIN
                            REPEAT
                                //OtherAddDed.TESTFIELD(OtherAddDed.Amount);
                                UpdateProcSalary(OtherAddDed);
                            UNTIL OtherAddDed.NEXT = 0;
                            MESSAGE(Text000);
                            CurrentPayElement := '';
                            CurrentDescription := '';
                        END;
                    END;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        SalesCodeFilterCtrlEnable := TRUE;
        QuantityEditable := TRUE;
    end;

    trigger OnOpenPage()
    begin
        //CurrentPayElement := '';
        //CurrentDescription := '';
        IF HRSetup.FIND('-') THEN BEGIN
            CurrentMonth := HRSetup."Salary Processing month";
            CurrentYear := HRSetup."Salary Processing Year";
        END;
        GetRecFilters;
        SetRecFilters;
    end;

    var
        HRSetup: Record 60016;
        Employee: Record 60019;
        OtherPayElements: Record 60035;
        PayDeduct: Record 60034;
        OtherAddDed: Record 60035;
        CurrentPayElement: Code[30];
        CurrentDescription: Text[50];
        CurrentMonth: Integer;
        CurrentYear: Integer;
        Text000: Label 'Records are posted.';
        Text001: Label 'Do you want to post?';
        [InDataSet]
        AmountEditable: Boolean;
        [InDataSet]
        QuantityEditable: Boolean;
        [InDataSet]
        SalesCodeFilterCtrlEnable: Boolean;

    // [Scope('Internal')]
    procedure GetRecFilters()
    begin
        IF rec.GETFILTERS <> '' THEN
            CurrentPayElement := rec.GETFILTER("Pay Element Code");
    end;

    // [Scope('Internal')]
    procedure SetRecFilters()
    begin
        SalesCodeFilterCtrlEnable := TRUE;
        rec.SETRANGE("Pay Element Code", CurrentPayElement);
        rec.SETRANGE(rec.Month, CurrentMonth);
        rec.SETRANGE(Year, CurrentYear);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure CurrentPayElementOnAfterValida()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;

    local procedure CurrentMonthOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;

    local procedure CurrentYearOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;

    local procedure CurrentDescriptionOnAfterValid()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;
}

