page 60007 "Create Year"
{
    PageType = Card;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(StartDate; StartDate)
                {
                    ApplicationArea = all;
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = all;
                    Caption = 'End Date';
                }
                field(YearType2; YearType2)
                {
                    ApplicationArea = all;
                    Caption = 'Year Type';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OK)
            {
                Caption = 'OK';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    CheckValidations;
                    //HrSetupInsert;
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnClosePage()
    begin
        CLEAR(StartDate);
        CLEAR(EndDate);
        CLEAR(YearType2);
    end;

    trigger OnInit()
    begin
        CLEAR(StartDate);
        CLEAR(EndDate);
        CLEAR(YearType2);
    end;

    trigger OnOpenPage()
    begin
        Dateinit;
        StartDate := StartDate2;
    end;

    var
        YearType2: Code[50];
        StartDate: Date;
        EndDate: Date;
        Text000: Label 'Start Date can''t be blank';
        Text001: Label 'End Date can''t be blank';
        Text002: Label 'Start date can''t be greater than the End date';
        StartDate2: Date;

    // [Scope('Internal')]
    procedure YearTypeInsert(YearType: Code[50])
    var
        Type: Code[50];
    begin
        YearType2 := YearType;
    end;

    //  [Scope('Internal')]
    procedure PayYearInsert()
    var
        PayYear: Record 60020;
    begin
        PayYear.RESET;
        PayYear.INIT;
        PayYear."Year Type" := YearType2;
        PayYear."Year Start Date" := StartDate;
        PayYear."Year End Date" := EndDate;
        PayYear.INSERT;
    end;

    // [Scope('Internal')]
    procedure CheckValidations()
    begin
        IF StartDate = 0D THEN
            ERROR(Text000);

        IF EndDate = 0D THEN
            ERROR(Text001);

        IF StartDate > EndDate THEN
            ERROR(Text002);

        PayYearInsert;
    end;

    //  [Scope('Internal')]
    procedure Dateinit()
    var
        PayYear: Record 60020;
        MaxDate: Date;
    begin
        PayYear.SETRANGE("Year Type", YearType2);
        IF PayYear.FIND('-') THEN BEGIN
            REPEAT
                IF PayYear."Year End Date" > MaxDate THEN
                    MaxDate := PayYear."Year End Date";
            UNTIL PayYear.NEXT = 0;
            StartDate2 := MaxDate + 1;
        END ELSE
            StartDate2 := 0D;
    end;

    //  [Scope('Internal')]
    procedure HRSetupInsert()
    var
        HRsetup: Record 60016;
        PayYear: Record 60020;
    begin
        PayYear.SETRANGE("Year Type", 'FINANCIAL YEAR');
        IF PayYear.FIND('-') THEN BEGIN
            IF PayYear.COUNT = 1 THEN BEGIN
                IF HRsetup.FIND('-') THEN BEGIN
                    HRsetup."Salary Processing month" := DATE2DMY(StartDate, 2);
                    HRsetup."Salary Processing Year" := DATE2DMY(StartDate, 3);
                    HRsetup.MODIFY;
                END ELSE BEGIN
                    HRsetup.INIT;
                    HRsetup."Salary Processing month" := DATE2DMY(StartDate, 2);
                    HRsetup."Salary Processing Year" := DATE2DMY(StartDate, 3);
                    HRsetup.INSERT;
                END;
            END;
        END;
    end;
}

