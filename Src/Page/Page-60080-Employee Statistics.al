page 60080 "Employee Statistics"
{
    Editable = false;
    PageType = Card;
    SourceTable = 60019;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Balance Amt(LCY)"; rec."Balance Amt(LCY)")
                {
                    ApplicationArea = all;

                }
                field(PayElements; PayElements)
                {
                    Caption = 'Total Salary';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(FormPayElements);
                        RecPayElements.RESET;
                        RecPayElements.SETRANGE("Employee Code", "No.");
                        RecPayElements.SETRANGE("Effective Start Date", EffectiveDate);
                        FormPayElements.SETTABLEVIEW(RecPayElements);
                        FormPayElements.RUNMODAL;
                    end;
                }
                field(PayElementAmt1; PayElementAmt[1])
                {
                    CaptionClass = PayElementCode[1];
                    Visible = "PayElement1[1]Visible";
                }
                field(PayElementAmt2; PayElementAmt[2])
                {
                    CaptionClass = PayElementCode[2];
                    Visible = "PayElement1[2]Visible";
                }
                field(PayElementAmt3; PayElementAmt[3])
                {
                    CaptionClass = PayElementCode[3];
                    Visible = "PayElement1[3]Visible";
                }
                field(PayElementAmt4; PayElementAmt[4])
                {
                    CaptionClass = PayElementCode[4];
                    Visible = "PayElement1[4]Visible";
                }
                field(PayElementAmt5; PayElementAmt[5])
                {
                    CaptionClass = PayElementCode[5];
                    Visible = "PayElement1[5]Visible";
                }
                field(PayElementAmt6; PayElementAmt[6])
                {
                    CaptionClass = PayElementCode[6];
                    Visible = "PayElement1[6]Visible";
                }
                field(PayElementAmt7; PayElementAmt[7])
                {
                    CaptionClass = PayElementCode[7];
                    Visible = "PayElement1[7]Visible";
                }
                field(PayElementAmt8; PayElementAmt[8])
                {
                    CaptionClass = PayElementCode[8];
                    Visible = "PayElement1[8]Visible";
                }
                field(PayElementAmt9; PayElementAmt[9])
                {
                    CaptionClass = PayElementCode[9];
                    Visible = "PayElement1[9]Visible";
                }
                field(PayElementAmt10; PayElementAmt[10])
                {
                    CaptionClass = PayElementCode[10];
                    Visible = "PayElement1[10]Visible";
                }
            }
            group(Leave)
            {
                Caption = 'Leave';
                grid(Grid)
                {
                    /*
                      group(GeneralN)
                      {
                          label(1)
                          {
                              CaptionClass = MonthName[1];
                              ShowCaption = false;
                          }
                          label(2)
                          {
                              CaptionClass = MonthName[2];
                              ShowCaption = false;
                          }
                          label(3)
                          {
                              CaptionClass = MonthName[3];
                              ShowCaption = false;
                          }
                          label(4)
                          {
                              CaptionClass = MonthName[4];
                              ShowCaption = false;
                          }
                          label(5)
                          {
                              CaptionClass = MonthName[5];
                              ShowCaption = false;
                          }
                          label(6)
                          {
                              CaptionClass = MonthName[6];
                              ShowCaption = false;
                          }
                          label(7)
                          {
                              CaptionClass = MonthName[7];
                              ShowCaption = false;
                          }
                          label(8)
                          {
                              CaptionClass = MonthName[8];
                              ShowCaption = false;
                          }
                          label(9)
                          {
                              CaptionClass = MonthName[9];
                              ShowCaption = false;
                          }
                          label(10)
                          {
                              CaptionClass = MonthName[10];
                              ShowCaption = false;
                          }
                          label(11)
                          {
                              CaptionClass = MonthName[11];
                              ShowCaption = false;
                          }
                          label(12)
                          {
                              CaptionClass = MonthName[12];
                              ShowCaption = false;
                          }
                      }
                      */
                    group(Applied)
                    {
                        Caption = 'Applied';
                        field(AppliedLeaves1; AppliedLeaves[1])
                        {
                        }
                        field(AppliedLeaves2; AppliedLeaves[2])
                        {
                        }
                        field(AppliedLeaves3; AppliedLeaves[3])
                        {
                        }
                        field(AppliedLeaves4; AppliedLeaves[4])
                        {
                        }
                        field(AppliedLeaves5; AppliedLeaves[5])
                        {
                        }
                        field(AppliedLeaves6; AppliedLeaves[6])
                        {
                        }
                        field(AppliedLeaves7; AppliedLeaves[7])
                        {
                        }
                        field(AppliedLeaves8; AppliedLeaves[8])
                        {
                        }
                        field(AppliedLeaves9; AppliedLeaves[9])
                        {
                        }
                        field(AppliedLeaves10; AppliedLeaves[10])
                        {
                        }
                        field(AppliedLeaves11; AppliedLeaves[11])
                        {
                        }
                        field(AppliedLeaves12; AppliedLeaves[12])
                        {
                        }
                    }
                    group(Approved)
                    {
                        Caption = 'Approved';
                        field(SanctionedLeaves1; SanctionedLeaves[1])
                        {
                        }
                        field(SanctionedLeaves2; SanctionedLeaves[2])
                        {
                        }
                        field(SanctionedLeaves3; SanctionedLeaves[3])
                        {
                        }
                        field(SanctionedLeaves4; SanctionedLeaves[4])
                        {
                        }
                        field(SanctionedLeaves5; SanctionedLeaves[5])
                        {
                        }
                        field(SanctionedLeaves6; SanctionedLeaves[6])
                        {
                        }
                        field(SanctionedLeaves7; SanctionedLeaves[7])
                        {
                        }
                        field(SanctionedLeaves8; SanctionedLeaves[8])
                        {
                        }
                        field(SanctionedLeaves9; SanctionedLeaves[9])
                        {
                        }
                        field(SanctionedLeaves10; SanctionedLeaves[10])
                        {
                        }
                        field(SanctionedLeaves11; SanctionedLeaves[11])
                        {
                        }
                        field(SanctionedLeaves12; SanctionedLeaves[12])
                        {
                        }
                    }
                    group(Taken)
                    {
                        Caption = 'Taken';
                        field(TakenLeaves1; TakenLeaves[1])
                        {
                        }
                        field(TakenLeaves2; TakenLeaves[2])
                        {
                        }
                        field(TakenLeaves3; TakenLeaves[3])
                        {
                        }
                        field(TakenLeaves4; TakenLeaves[4])
                        {
                        }
                        field(TakenLeaves5; TakenLeaves[5])
                        {
                        }
                        field(TakenLeaves6; TakenLeaves[6])
                        {
                        }
                        field(TakenLeaves7; TakenLeaves[7])
                        {
                        }
                        field(TakenLeaves8; TakenLeaves[8])
                        {
                        }
                        field(TakenLeaves9; TakenLeaves[9])
                        {
                        }
                        field(TakenLeaves10; TakenLeaves[10])
                        {
                        }
                        field(TakenLeaves11; TakenLeaves[11])
                        {
                        }
                        field(TakenLeaves12; TakenLeaves[12])
                        {
                        }
                    }
                }
            }
            group(Loan)
            {
                Caption = 'Loan';
                field(LoanType; LoanType)
                {
                    Caption = 'Loan Type';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Lookup3.DELETEALL;

                        Employee.SETRANGE("No.", "No.");
                        IF Employee.FIND('-') THEN BEGIN
                            Lookup2.RESET;
                            Lookup2.SETRANGE("LookupType Name", 'LOAN TYPES');
                            IF Lookup2.FIND('-') THEN BEGIN
                                REPEAT
                                    IF (Lookup2.Grade = Employee."Pay Cadre") OR (Lookup2."All Grades" = TRUE) THEN BEGIN
                                        Lookup3.INIT;
                                        Lookup3.TRANSFERFIELDS(Lookup2);
                                        Lookup3.INSERT;
                                    END;
                                UNTIL Lookup2.NEXT = 0;
                            END;
                        END;

                        IF Lookup3.FIND('-') THEN BEGIN
                            IF PAGE.RUNMODAL(0, Lookup3) = ACTION::LookupOK THEN
                                LoanType := Lookup3."Lookup Name";
                        END ELSE
                            ERROR(Text000);

                        GetLoanAmount;
                    end;
                }
                field(LoanAmount; LoanAmount)
                {
                    Caption = 'Loan Amount';
                }
                field(LoanOutstandingAmt; LoanOutstandingAmt)
                {
                    Caption = 'Loan Outstanding Amount';
                }
                field(LoanStartDate; LoanStartDate)
                {
                    Caption = 'Loan Start Date';
                }
                field(LoanEndDate; LoanEndDate)
                {
                    Caption = 'Loan End Date';
                }
                field(MonthlyEMI; MonthlyEMI)
                {
                    Caption = 'Monthly EMI';
                }
                field(NoOfEMIRecv; NoOfEMIRecv)
                {
                    Caption = 'No. of EMI Received';
                }
                field(NoOfEMIPending; NoOfEMIPending)
                {
                    Caption = 'No. of EMI Pending';
                }
                field(LoanRateOfInterest; LoanRateOfInterest)
                {
                    Caption = 'Loan Rate of Interest';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        LoanType := 'SAL ADV';
        GetPayElements;
        GetStartEndDate;
        GetLeaveApplied;
        GetLeaveSanctioned;
        GetLeaveTaken;
        GetLoanAmount;
    end;

    trigger OnInit()
    begin

        "PayElement1[10]Visible" := TRUE;
        "PayElement1[9]Visible" := TRUE;
        "PayElement1[8]Visible" := TRUE;
        "PayElement1[7]Visible" := TRUE;
        "PayElement1[6]Visible" := TRUE;
        "PayElement1[5]Visible" := TRUE;
        "PayElement1[4]Visible" := TRUE;
        "PayElement1[3]Visible" := TRUE;
        "PayElement1[2]Visible" := TRUE;
        "PayElement1[1]Visible" := TRUE;
        "PayElement[10]Visible" := TRUE;
        "PayElement[9]Visible" := TRUE;
        "PayElement[8]Visible" := TRUE;
        "PayElement[7]Visible" := TRUE;
        "PayElement[6]Visible" := TRUE;
        "PayElement[5]Visible" := TRUE;
        "PayElement[4]Visible" := TRUE;
        "PayElement[3]Visible" := TRUE;
        "PayElement[2]Visible" := TRUE;
        "PayElement[1]Visible" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        PayElements := 0;
        CLEAR(AppliedLeaves);
        CLEAR(SanctionedLeaves);
        LoanAmount := 0;
        LoanOutstandingAmt := 0;
        LoanStartDate := 0D;
        LoanEndDate := 0D;
        MonthlyEMI := 0;
        NoOfEMIRecv := 0;
        NoOfEMIPending := 0;
        LoanRateOfInterest := 0;
        GetStartEndDate;
    end;

    var
        PayElements: Decimal;
        RecPayElements: Record 60025;
        FormPayElements: Page 60014;
        AppliedLeaves: array[12] of Decimal;
        LeaveApplicationRec: Record 60032;
        SanctionedLeaves: array[12] of Decimal;
        PayrollYearrec: Record 60020;
        LeaveAppList: Page 60025;
        PayElementCode: array[10] of Code[20];
        PayElementAmt: array[10] of Decimal;
        i: Integer;
        j: Integer;
        StartDate: array[12] of Date;
        EndDate: array[12] of Date;
        Month: array[12] of Integer;
        DetailedAppliedLeaves: Record 60001;
        MonthName: array[12] of Text[30];
        TakenLeaves: array[12] of Decimal;
        Year: array[12] of Integer;
        LoanAmount: Decimal;
        LoanOutstandingAmt: Decimal;
        LoanStartDate: Date;
        LoanEndDate: Date;
        MonthlyEMI: Decimal;
        NoOfEMIRecv: Integer;
        NoOfEMIPending: Integer;
        LoanRateOfInterest: Decimal;
        LoanType: Code[20];
        Lookup3: Record 60018 temporary;
        Employee: Record 60019;
        Lookup2: Record 60018;
        Text000: Label 'There are no  loan types for this Pay Cadre.';
        EffectiveDate: Date;
        [InDataSet]
        "PayElement[1]Visible": Boolean;
        [InDataSet]
        "PayElement[2]Visible": Boolean;
        [InDataSet]
        "PayElement[3]Visible": Boolean;
        [InDataSet]
        "PayElement[4]Visible": Boolean;
        [InDataSet]
        "PayElement[5]Visible": Boolean;
        [InDataSet]
        "PayElement[6]Visible": Boolean;
        [InDataSet]
        "PayElement[7]Visible": Boolean;
        [InDataSet]
        "PayElement[8]Visible": Boolean;
        [InDataSet]
        "PayElement[9]Visible": Boolean;
        [InDataSet]
        "PayElement[10]Visible": Boolean;
        [InDataSet]
        "PayElement1[1]Visible": Boolean;
        [InDataSet]
        "PayElement1[2]Visible": Boolean;
        [InDataSet]
        "PayElement1[3]Visible": Boolean;
        [InDataSet]
        "PayElement1[4]Visible": Boolean;
        [InDataSet]
        "PayElement1[5]Visible": Boolean;
        [InDataSet]
        "PayElement1[6]Visible": Boolean;
        [InDataSet]
        "PayElement1[7]Visible": Boolean;
        [InDataSet]
        "PayElement1[8]Visible": Boolean;
        [InDataSet]
        "PayElement1[9]Visible": Boolean;
        [InDataSet]
        "PayElement1[10]Visible": Boolean;
        Text19066963: Label 'Applied';
        Text19037864: Label 'Approved';
        Text19071779: Label 'Taken';

    //  [Scope('Internal')]
    procedure GetPayElements()
    var
        PayElementsRec: Record 60025;
    begin
        i := 0;
        PayElementsRec.RESET;
        PayElementsRec.SETRANGE("Employee Code", "No.");
        IF PayElementsRec.FINDLAST THEN
            EffectiveDate := PayElementsRec."Effective Start Date";
        PayElementsRec.RESET;
        PayElementsRec.SETRANGE("Employee Code", "No.");
        PayElementsRec.SETRANGE("Effective Start Date", EffectiveDate);
        IF PayElementsRec.FINDSET THEN
            REPEAT
                i += 1;

                PayElementCode[i] := PayElementsRec."Pay Element Code";
                PayElementAmt[i] := PayElementsRec."Actual Amount";
                PayElements += PayElementsRec."Actual Amount";
            UNTIL PayElementsRec.NEXT = 0;
        j := i + 1;
        IF PayElementCode[1] = '' THEN
            "PayElement[1]Visible" := FALSE
        ELSE
            "PayElement[1]Visible" := TRUE;
        IF PayElementCode[2] = '' THEN
            "PayElement[2]Visible" := FALSE
        ELSE
            "PayElement[2]Visible" := TRUE;
        IF PayElementCode[3] = '' THEN
            "PayElement[3]Visible" := FALSE
        ELSE
            "PayElement[3]Visible" := TRUE;
        IF PayElementCode[4] = '' THEN
            "PayElement[4]Visible" := FALSE
        ELSE
            "PayElement[4]Visible" := TRUE;
        IF PayElementCode[5] = '' THEN
            "PayElement[5]Visible" := FALSE
        ELSE
            "PayElement[5]Visible" := TRUE;
        IF PayElementCode[6] = '' THEN
            "PayElement[6]Visible" := FALSE
        ELSE
            "PayElement[6]Visible" := TRUE;
        IF PayElementCode[7] = '' THEN
            "PayElement[7]Visible" := FALSE
        ELSE
            "PayElement[7]Visible" := TRUE;
        IF PayElementCode[8] = '' THEN
            "PayElement[8]Visible" := FALSE
        ELSE
            "PayElement[8]Visible" := TRUE;
        IF PayElementCode[9] = '' THEN
            "PayElement[9]Visible" := FALSE
        ELSE
            "PayElement[9]Visible" := TRUE;
        IF PayElementCode[10] = '' THEN
            "PayElement[10]Visible" := FALSE
        ELSE
            "PayElement[10]Visible" := TRUE;

        IF PayElementCode[1] = '' THEN
            "PayElement1[1]Visible" := FALSE
        ELSE
            "PayElement1[1]Visible" := TRUE;
        IF PayElementCode[2] = '' THEN
            "PayElement1[2]Visible" := FALSE
        ELSE
            "PayElement1[2]Visible" := TRUE;
        IF PayElementCode[3] = '' THEN
            "PayElement1[3]Visible" := FALSE
        ELSE
            "PayElement1[3]Visible" := TRUE;
        IF PayElementCode[4] = '' THEN
            "PayElement1[4]Visible" := FALSE
        ELSE
            "PayElement1[4]Visible" := TRUE;
        IF PayElementCode[5] = '' THEN
            "PayElement1[5]Visible" := FALSE
        ELSE
            "PayElement1[5]Visible" := TRUE;
        IF PayElementCode[6] = '' THEN
            "PayElement1[6]Visible" := FALSE
        ELSE
            "PayElement1[6]Visible" := TRUE;
        IF PayElementCode[7] = '' THEN
            "PayElement1[7]Visible" := FALSE
        ELSE
            "PayElement1[7]Visible" := TRUE;
        IF PayElementCode[8] = '' THEN
            "PayElement1[8]Visible" := FALSE
        ELSE
            "PayElement1[8]Visible" := TRUE;
        IF PayElementCode[9] = '' THEN
            "PayElement1[9]Visible" := FALSE
        ELSE
            "PayElement1[9]Visible" := TRUE;
        IF PayElementCode[10] = '' THEN
            "PayElement1[10]Visible" := FALSE
        ELSE
            "PayElement1[10]Visible" := TRUE;
        //UNTIL j = 10;
    end;

    // [Scope('Internal')]
    procedure GetLeaveApplied()
    var
        LeaveApplication: Record 60032;
        PayrollYear: Record 60020;
    begin
        DetailedAppliedLeaves.RESET;
        DetailedAppliedLeaves.SETRANGE("Employee Code", "No.");
        DetailedAppliedLeaves.SETFILTER(Date, '%1..%2', StartDate[1], EndDate[1]);
        DetailedAppliedLeaves.SETRANGE(Applied, TRUE);
        IF DetailedAppliedLeaves.FINDSET THEN
            REPEAT
                AppliedLeaves[1] += DetailedAppliedLeaves.Day;
            UNTIL DetailedAppliedLeaves.NEXT = 0;
        DetailedAppliedLeaves.RESET;
        DetailedAppliedLeaves.SETRANGE("Employee Code", "No.");
        DetailedAppliedLeaves.SETFILTER(Date, '%1..%2', StartDate[2], EndDate[2]);
        DetailedAppliedLeaves.SETRANGE(Applied, TRUE);
        IF DetailedAppliedLeaves.FINDSET THEN
            REPEAT
                AppliedLeaves[2] += DetailedAppliedLeaves.Day;
            UNTIL DetailedAppliedLeaves.NEXT = 0;
        DetailedAppliedLeaves.RESET;
        DetailedAppliedLeaves.SETRANGE("Employee Code", "No.");
        DetailedAppliedLeaves.SETFILTER(Date, '%1..%2', StartDate[3], EndDate[3]);
        DetailedAppliedLeaves.SETRANGE(Applied, TRUE);
        IF DetailedAppliedLeaves.FINDSET THEN
            REPEAT
                AppliedLeaves[3] += DetailedAppliedLeaves.Day;
            UNTIL DetailedAppliedLeaves.NEXT = 0;
        DetailedAppliedLeaves.RESET;
        DetailedAppliedLeaves.SETRANGE("Employee Code", "No.");
        DetailedAppliedLeaves.SETFILTER(Date, '%1..%2', StartDate[4], EndDate[4]);
        DetailedAppliedLeaves.SETRANGE(Applied, TRUE);
        IF DetailedAppliedLeaves.FINDSET THEN
            REPEAT
                AppliedLeaves[4] += DetailedAppliedLeaves.Day;
            UNTIL DetailedAppliedLeaves.NEXT = 0;
        DetailedAppliedLeaves.RESET;
        DetailedAppliedLeaves.SETRANGE("Employee Code", "No.");
        DetailedAppliedLeaves.SETFILTER(Date, '%1..%2', StartDate[5], EndDate[5]);
        DetailedAppliedLeaves.SETRANGE(Applied, TRUE);
        IF DetailedAppliedLeaves.FINDSET THEN
            REPEAT
                AppliedLeaves[5] += DetailedAppliedLeaves.Day;
            UNTIL DetailedAppliedLeaves.NEXT = 0;
        DetailedAppliedLeaves.RESET;
        DetailedAppliedLeaves.SETRANGE("Employee Code", "No.");
        DetailedAppliedLeaves.SETFILTER(Date, '%1..%2', StartDate[6], EndDate[6]);
        DetailedAppliedLeaves.SETRANGE(Applied, TRUE);
        IF DetailedAppliedLeaves.FINDSET THEN
            REPEAT
                AppliedLeaves[6] += DetailedAppliedLeaves.Day;
            UNTIL DetailedAppliedLeaves.NEXT = 0;
        DetailedAppliedLeaves.RESET;
        DetailedAppliedLeaves.SETRANGE("Employee Code", "No.");
        DetailedAppliedLeaves.SETFILTER(Date, '%1..%2', StartDate[7], EndDate[7]);
        DetailedAppliedLeaves.SETRANGE(Applied, TRUE);
        IF DetailedAppliedLeaves.FINDSET THEN
            REPEAT
                AppliedLeaves[7] += DetailedAppliedLeaves.Day;
            UNTIL DetailedAppliedLeaves.NEXT = 0;
        DetailedAppliedLeaves.RESET;
        DetailedAppliedLeaves.SETRANGE("Employee Code", "No.");
        DetailedAppliedLeaves.SETFILTER(Date, '%1..%2', StartDate[8], EndDate[8]);
        DetailedAppliedLeaves.SETRANGE(Applied, TRUE);
        IF DetailedAppliedLeaves.FINDSET THEN
            REPEAT
                AppliedLeaves[8] += DetailedAppliedLeaves.Day;
            UNTIL DetailedAppliedLeaves.NEXT = 0;
        DetailedAppliedLeaves.RESET;
        DetailedAppliedLeaves.SETRANGE("Employee Code", "No.");
        DetailedAppliedLeaves.SETFILTER(Date, '%1..%2', StartDate[9], EndDate[9]);
        DetailedAppliedLeaves.SETRANGE(Applied, TRUE);
        IF DetailedAppliedLeaves.FINDSET THEN
            REPEAT
                AppliedLeaves[9] += DetailedAppliedLeaves.Day;
            UNTIL DetailedAppliedLeaves.NEXT = 0;
        DetailedAppliedLeaves.RESET;
        DetailedAppliedLeaves.SETRANGE("Employee Code", "No.");
        DetailedAppliedLeaves.SETFILTER(Date, '%1..%2', StartDate[10], EndDate[10]);
        DetailedAppliedLeaves.SETRANGE(Applied, TRUE);
        IF DetailedAppliedLeaves.FINDSET THEN
            REPEAT
                AppliedLeaves[10] += DetailedAppliedLeaves.Day;
            UNTIL DetailedAppliedLeaves.NEXT = 0;
        DetailedAppliedLeaves.RESET;
        DetailedAppliedLeaves.SETRANGE("Employee Code", "No.");
        DetailedAppliedLeaves.SETFILTER(Date, '%1..%2', StartDate[11], EndDate[11]);
        DetailedAppliedLeaves.SETRANGE(Applied, TRUE);
        IF DetailedAppliedLeaves.FINDSET THEN
            REPEAT
                AppliedLeaves[11] += DetailedAppliedLeaves.Day;
            UNTIL DetailedAppliedLeaves.NEXT = 0;
        DetailedAppliedLeaves.RESET;
        DetailedAppliedLeaves.SETRANGE("Employee Code", "No.");
        DetailedAppliedLeaves.SETFILTER(Date, '%1..%2', StartDate[12], EndDate[12]);
        DetailedAppliedLeaves.SETRANGE(Applied, TRUE);
        IF DetailedAppliedLeaves.FINDSET THEN
            REPEAT
                AppliedLeaves[12] += DetailedAppliedLeaves.Day;
            UNTIL DetailedAppliedLeaves.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure GetLeaveSanctioned()
    var
        DailyAttendance: Record 60028;
    begin
        DailyAttendance.RESET;
        DailyAttendance.SETRANGE("Employee No.", "No.");
        DailyAttendance.SETRANGE(Month, Month[1]);
        DailyAttendance.SETRANGE(Year, Year[1]);
        IF DailyAttendance.FINDSET THEN
            REPEAT
                SanctionedLeaves[1] += DailyAttendance.Leave;
            UNTIL DailyAttendance.NEXT = 0;
        DailyAttendance.RESET;
        DailyAttendance.SETRANGE("Employee No.", "No.");
        DailyAttendance.SETRANGE(Month, Month[2]);
        DailyAttendance.SETRANGE(Year, Year[2]);
        IF DailyAttendance.FINDSET THEN
            REPEAT
                SanctionedLeaves[2] += DailyAttendance.Leave;
            UNTIL DailyAttendance.NEXT = 0;
        DailyAttendance.RESET;
        DailyAttendance.SETRANGE("Employee No.", "No.");
        DailyAttendance.SETRANGE(Month, Month[3]);
        DailyAttendance.SETRANGE(Year, Year[3]);
        IF DailyAttendance.FINDSET THEN
            REPEAT
                SanctionedLeaves[3] += DailyAttendance.Leave;
            UNTIL DailyAttendance.NEXT = 0;
        DailyAttendance.RESET;
        DailyAttendance.SETRANGE("Employee No.", "No.");
        DailyAttendance.SETRANGE(Month, Month[4]);
        DailyAttendance.SETRANGE(Year, Year[4]);
        IF DailyAttendance.FINDSET THEN
            REPEAT
                SanctionedLeaves[4] += DailyAttendance.Leave;
            UNTIL DailyAttendance.NEXT = 0;
        DailyAttendance.RESET;
        DailyAttendance.SETRANGE("Employee No.", "No.");
        DailyAttendance.SETRANGE(Month, Month[5]);
        DailyAttendance.SETRANGE(Year, Year[5]);
        IF DailyAttendance.FINDSET THEN
            REPEAT
                SanctionedLeaves[5] += DailyAttendance.Leave;
            UNTIL DailyAttendance.NEXT = 0;
        DailyAttendance.RESET;
        DailyAttendance.SETRANGE("Employee No.", "No.");
        DailyAttendance.SETRANGE(Month, Month[6]);
        DailyAttendance.SETRANGE(Year, Year[6]);
        IF DailyAttendance.FINDSET THEN
            REPEAT
                SanctionedLeaves[6] += DailyAttendance.Leave;
            UNTIL DailyAttendance.NEXT = 0;
        DailyAttendance.RESET;
        DailyAttendance.SETRANGE("Employee No.", "No.");
        DailyAttendance.SETRANGE(Month, Month[7]);
        DailyAttendance.SETRANGE(Year, Year[7]);
        IF DailyAttendance.FINDSET THEN
            REPEAT
                SanctionedLeaves[7] += DailyAttendance.Leave;
            UNTIL DailyAttendance.NEXT = 0;
        DailyAttendance.RESET;
        DailyAttendance.SETRANGE("Employee No.", "No.");
        DailyAttendance.SETRANGE(Month, Month[8]);
        DailyAttendance.SETRANGE(Year, Year[8]);
        IF DailyAttendance.FINDSET THEN
            REPEAT
                SanctionedLeaves[8] += DailyAttendance.Leave;
            UNTIL DailyAttendance.NEXT = 0;
        DailyAttendance.RESET;
        DailyAttendance.SETRANGE("Employee No.", "No.");
        DailyAttendance.SETRANGE(Month, Month[9]);
        DailyAttendance.SETRANGE(Year, Year[9]);
        IF DailyAttendance.FINDSET THEN
            REPEAT
                SanctionedLeaves[9] += DailyAttendance.Leave;
            UNTIL DailyAttendance.NEXT = 0;
        DailyAttendance.RESET;
        DailyAttendance.SETRANGE("Employee No.", "No.");
        DailyAttendance.SETRANGE(Month, Month[10]);
        DailyAttendance.SETRANGE(Year, Year[10]);
        IF DailyAttendance.FINDSET THEN
            REPEAT
                SanctionedLeaves[10] += DailyAttendance.Leave;
            UNTIL DailyAttendance.NEXT = 0;
        DailyAttendance.RESET;
        DailyAttendance.SETRANGE("Employee No.", "No.");
        DailyAttendance.SETRANGE(Month, Month[11]);
        DailyAttendance.SETRANGE(Year, Year[11]);
        IF DailyAttendance.FINDSET THEN
            REPEAT
                SanctionedLeaves[11] += DailyAttendance.Leave;
            UNTIL DailyAttendance.NEXT = 0;
        DailyAttendance.RESET;
        DailyAttendance.SETRANGE("Employee No.", "No.");
        DailyAttendance.SETRANGE(Month, Month[12]);
        DailyAttendance.SETRANGE(Year, Year[12]);
        IF DailyAttendance.FINDSET THEN
            REPEAT
                SanctionedLeaves[12] += DailyAttendance.Leave;
            UNTIL DailyAttendance.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure GetStartEndDate()
    var
        PayrollYear: Record 60020;
    begin
        MonthName[1] := 'January';
        MonthName[2] := 'February';
        MonthName[3] := 'March';
        MonthName[4] := 'April';
        MonthName[5] := 'May';
        MonthName[6] := 'June';
        MonthName[7] := 'July';
        MonthName[8] := 'August';
        MonthName[9] := 'September';
        MonthName[10] := 'October';
        MonthName[11] := 'November';
        MonthName[12] := 'December';
        PayrollYear.RESET;
        PayrollYear.SETRANGE(PayrollYear."Year Type", 'LEAVE YEAR');
        PayrollYear.SETRANGE(PayrollYear.Closed, FALSE);
        IF PayrollYear.FINDFIRST THEN BEGIN
            StartDate[1] := PayrollYear."Year Start Date";
            EndDate[1] := CALCDATE('CM', StartDate[1]);
            Month[1] := DATE2DMY(StartDate[1], 2);
            Year[1] := DATE2DMY(StartDate[1], 3);
            StartDate[2] := CALCDATE('1D', EndDate[1]);
            EndDate[2] := CALCDATE('CM', StartDate[2]);
            Month[2] := DATE2DMY(StartDate[2], 2);
            Year[2] := DATE2DMY(StartDate[2], 3);
            StartDate[3] := CALCDATE('1D', EndDate[2]);
            EndDate[3] := CALCDATE('CM', StartDate[3]);
            Month[3] := DATE2DMY(StartDate[3], 2);
            Year[3] := DATE2DMY(StartDate[3], 3);
            StartDate[4] := CALCDATE('1D', EndDate[3]);
            EndDate[4] := CALCDATE('CM', StartDate[4]);
            Month[4] := DATE2DMY(StartDate[4], 2);
            Year[4] := DATE2DMY(StartDate[4], 3);
            StartDate[5] := CALCDATE('1D', EndDate[4]);
            EndDate[5] := CALCDATE('CM', StartDate[5]);
            Month[5] := DATE2DMY(StartDate[5], 2);
            Year[5] := DATE2DMY(StartDate[5], 3);
            StartDate[6] := CALCDATE('1D', EndDate[5]);
            EndDate[6] := CALCDATE('CM', StartDate[6]);
            Month[6] := DATE2DMY(StartDate[6], 2);
            Year[6] := DATE2DMY(StartDate[6], 3);
            StartDate[7] := CALCDATE('1D', EndDate[6]);
            EndDate[7] := CALCDATE('CM', StartDate[7]);
            Month[7] := DATE2DMY(StartDate[7], 2);
            Year[7] := DATE2DMY(StartDate[7], 3);
            StartDate[8] := CALCDATE('1D', EndDate[7]);
            EndDate[8] := CALCDATE('CM', StartDate[8]);
            Month[8] := DATE2DMY(StartDate[8], 2);
            Year[8] := DATE2DMY(StartDate[8], 3);
            StartDate[9] := CALCDATE('1D', EndDate[8]);
            EndDate[9] := CALCDATE('CM', StartDate[9]);
            Month[9] := DATE2DMY(StartDate[9], 2);
            Year[9] := DATE2DMY(StartDate[9], 3);
            StartDate[10] := CALCDATE('1D', EndDate[9]);
            EndDate[10] := CALCDATE('CM', StartDate[10]);
            Month[10] := DATE2DMY(StartDate[10], 2);
            Year[10] := DATE2DMY(StartDate[10], 3);
            StartDate[11] := CALCDATE('1D', EndDate[10]);
            EndDate[11] := CALCDATE('CM', StartDate[11]);
            Month[11] := DATE2DMY(StartDate[11], 2);
            Year[11] := DATE2DMY(StartDate[11], 3);
            StartDate[12] := CALCDATE('1D', EndDate[11]);
            EndDate[12] := CALCDATE('CM', StartDate[12]);
            Month[12] := DATE2DMY(StartDate[12], 2);
            Year[12] := DATE2DMY(StartDate[12], 3);
        END;
    end;

    // [Scope('Internal')]
    procedure GetLeaveTaken()
    var
        MonthlyAttendance: Record 60029;
    begin
        MonthlyAttendance.RESET;
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        MonthlyAttendance.SETRANGE(Year, Year[1]);
        MonthlyAttendance.SETRANGE("Pay Slip Month", Month[1]);
        MonthlyAttendance.SETRANGE(Processed, TRUE);
        IF MonthlyAttendance.FINDFIRST THEN BEGIN
            MonthlyAttendance.CALCFIELDS(MonthlyAttendance."Total Leaves");
            TakenLeaves[1] := MonthlyAttendance."Total Leaves";
        END;
        MonthlyAttendance.RESET;
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        MonthlyAttendance.SETRANGE(Year, Year[2]);
        MonthlyAttendance.SETRANGE("Pay Slip Month", Month[2]);
        MonthlyAttendance.SETRANGE(Processed, TRUE);
        IF MonthlyAttendance.FINDFIRST THEN BEGIN
            MonthlyAttendance.CALCFIELDS(MonthlyAttendance."Total Leaves");
            TakenLeaves[2] := MonthlyAttendance."Total Leaves";
        END;
        MonthlyAttendance.RESET;
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        MonthlyAttendance.SETRANGE(Year, Year[3]);
        MonthlyAttendance.SETRANGE("Pay Slip Month", Month[3]);
        MonthlyAttendance.SETRANGE(Processed, TRUE);
        IF MonthlyAttendance.FINDFIRST THEN BEGIN
            MonthlyAttendance.CALCFIELDS(MonthlyAttendance."Total Leaves");
            TakenLeaves[3] := MonthlyAttendance."Total Leaves";
        END;
        MonthlyAttendance.RESET;
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        MonthlyAttendance.SETRANGE(Year, Year[4]);
        MonthlyAttendance.SETRANGE("Pay Slip Month", Month[4]);
        MonthlyAttendance.SETRANGE(Processed, TRUE);
        IF MonthlyAttendance.FINDFIRST THEN BEGIN
            MonthlyAttendance.CALCFIELDS(MonthlyAttendance."Total Leaves");
            TakenLeaves[4] := MonthlyAttendance."Total Leaves";
        END;
        MonthlyAttendance.RESET;
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        MonthlyAttendance.SETRANGE(Year, Year[5]);
        MonthlyAttendance.SETRANGE("Pay Slip Month", Month[5]);
        MonthlyAttendance.SETRANGE(Processed, TRUE);
        IF MonthlyAttendance.FINDFIRST THEN BEGIN
            MonthlyAttendance.CALCFIELDS(MonthlyAttendance."Total Leaves");
            TakenLeaves[5] := MonthlyAttendance."Total Leaves";
        END;
        MonthlyAttendance.RESET;
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        MonthlyAttendance.SETRANGE(Year, Year[6]);
        MonthlyAttendance.SETRANGE("Pay Slip Month", Month[6]);
        MonthlyAttendance.SETRANGE(Processed, TRUE);
        IF MonthlyAttendance.FINDFIRST THEN BEGIN
            MonthlyAttendance.CALCFIELDS(MonthlyAttendance."Total Leaves");
            TakenLeaves[6] := MonthlyAttendance."Total Leaves";
        END;
        MonthlyAttendance.RESET;
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        MonthlyAttendance.SETRANGE(Year, Year[7]);
        MonthlyAttendance.SETRANGE("Pay Slip Month", Month[7]);
        MonthlyAttendance.SETRANGE(Processed, TRUE);
        IF MonthlyAttendance.FINDFIRST THEN BEGIN
            MonthlyAttendance.CALCFIELDS(MonthlyAttendance."Total Leaves");
            TakenLeaves[7] := MonthlyAttendance."Total Leaves";
        END;
        MonthlyAttendance.RESET;
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        MonthlyAttendance.SETRANGE(Year, Year[8]);
        MonthlyAttendance.SETRANGE("Pay Slip Month", Month[8]);
        MonthlyAttendance.SETRANGE(Processed, TRUE);
        IF MonthlyAttendance.FINDFIRST THEN BEGIN
            MonthlyAttendance.CALCFIELDS(MonthlyAttendance."Total Leaves");
            TakenLeaves[8] := MonthlyAttendance."Total Leaves";
        END;
        MonthlyAttendance.RESET;
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        MonthlyAttendance.SETRANGE(Year, Year[9]);
        MonthlyAttendance.SETRANGE("Pay Slip Month", Month[9]);
        MonthlyAttendance.SETRANGE(Processed, TRUE);
        IF MonthlyAttendance.FINDFIRST THEN BEGIN
            MonthlyAttendance.CALCFIELDS(MonthlyAttendance."Total Leaves");
            TakenLeaves[9] := MonthlyAttendance."Total Leaves";
        END;
        MonthlyAttendance.RESET;
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        MonthlyAttendance.SETRANGE(Year, Year[10]);
        MonthlyAttendance.SETRANGE("Pay Slip Month", Month[10]);
        MonthlyAttendance.SETRANGE(Processed, TRUE);
        IF MonthlyAttendance.FINDFIRST THEN BEGIN
            MonthlyAttendance.CALCFIELDS(MonthlyAttendance."Total Leaves");
            TakenLeaves[10] := MonthlyAttendance."Total Leaves";
        END;
        MonthlyAttendance.RESET;
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        MonthlyAttendance.SETRANGE(Year, Year[11]);
        MonthlyAttendance.SETRANGE("Pay Slip Month", Month[11]);
        MonthlyAttendance.SETRANGE(Processed, TRUE);
        IF MonthlyAttendance.FINDFIRST THEN BEGIN
            MonthlyAttendance.CALCFIELDS(MonthlyAttendance."Total Leaves");
            TakenLeaves[11] := MonthlyAttendance."Total Leaves";
        END;
        MonthlyAttendance.RESET;
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        MonthlyAttendance.SETRANGE(Year, Year[12]);
        MonthlyAttendance.SETRANGE("Pay Slip Month", Month[12]);
        MonthlyAttendance.SETRANGE(Processed, TRUE);
        IF MonthlyAttendance.FINDFIRST THEN BEGIN
            MonthlyAttendance.CALCFIELDS(MonthlyAttendance."Total Leaves");
            TakenLeaves[12] := MonthlyAttendance."Total Leaves";
        END;
    end;

    // [Scope('Internal')]
    procedure GetLoanAmount()
    var
        LoanRec: Record 60039;
        ProcessedSalary: Record 60038;
    begin
        LoanRec.RESET;
        LoanRec.SETRANGE("Loan Type", LoanType);
        LoanRec.SETRANGE("Employee Code", "No.");
        LoanRec.SETRANGE(Closed, FALSE);
        IF LoanRec.FINDFIRST THEN BEGIN
            LoanAmount := LoanRec."Loan Amount";
            LoanOutstandingAmt := LoanRec."Loan Balance";
            LoanStartDate := LoanRec."Loan Start Date";
            LoanEndDate := LoanRec."Loan End Date";
            MonthlyEMI := LoanRec."Effective Amount";
            LoanRateOfInterest := LoanRec."Interest Rate";
            ProcessedSalary.RESET;
            ProcessedSalary.SETRANGE("Employee Code", LoanRec."Employee Code");
            ProcessedSalary.SETRANGE("Computation Type", 'LOAN');
            ProcessedSalary.SETRANGE("Add/Deduct Code", LoanRec."Loan Type");
            IF ProcessedSalary.FINDSET THEN BEGIN
                NoOfEMIRecv := ProcessedSalary.COUNT;
                NoOfEMIPending := LoanRec."No of Installments" - NoOfEMIRecv;
            END
            ELSE BEGIN
                NoOfEMIRecv := 0;
                NoOfEMIPending := LoanRec."No of Installments" - NoOfEMIRecv;
            END;
        END
        ELSE BEGIN
            LoanAmount := 0;
            LoanOutstandingAmt := 0;
            LoanStartDate := 0D;
            LoanEndDate := 0D;
            MonthlyEMI := 0;
            NoOfEMIRecv := 0;
            NoOfEMIPending := 0;
            LoanRateOfInterest := 0;
        END;
    end;
}

