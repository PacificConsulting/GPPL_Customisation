page 60073 "Emp Details"
{
    // B2B Software Technologies
    // --------------------------
    // Project : Human Resource
    // B2B
    // No. sign      Date
    // --------------------------
    // 01   B2B    13-dec-05

    Caption = 'Employee';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
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
                Editable = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("First Name"; rec."First Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; rec."Last Name")
                {
                    ApplicationArea = all;
                }
                field("Middle Name"; rec."Middle Name")
                {
                    ApplicationArea = all;
                    Caption = 'Middle Name/Initials';
                }
                field(Initials; rec.Initials)
                {
                    ApplicationArea = all;
                }
                field(Gender; rec.Gender)
                {
                    ApplicationArea = all;
                }
                field("Branch Code"; rec."Branch Code")
                {
                    ApplicationArea = all;
                }
                field(Address; rec.Address)
                {
                    ApplicationArea = all;
                }
                field("Address 2"; rec."Address 2")
                {
                    ApplicationArea = all;
                }
                field("Post Code"; rec."Post Code")
                {
                    ApplicationArea = all;
                    Caption = 'Post Code/City';
                }
                field(City; rec.City)
                {
                    ApplicationArea = all;
                }
                field("Country/Region Code"; rec."Country/Region Code")
                {
                    ApplicationArea = all;
                }
            }
            group("Processed Salary")
            {
                Caption = 'Processed Salary';
                field(Month; Month)
                {
                    Caption = 'Month';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrPage.ProcSal.PAGE.GetEmp(Month, Year, rec."No.");
                    end;
                }
                field(Year; Year)
                {
                    Caption = 'Year';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrPage.ProcSal.PAGE.GetEmp(Month, Year, rec."No.");
                    end;
                }
                part(ProcSal; 60074)
                {
                    SubPageLink = "Employee Code" = FIELD("No.");
                }
            }
            group("Monthly Attendace")
            {
                Caption = 'Monthly Attendace';
                field(MonthAtt; Month)
                {
                    Caption = 'Month';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrPage.MonAttSubForm.PAGE.GetEmp(Month, Year, rec."No.");
                    end;
                }
                field(MonthYr; Year)
                {
                    Caption = 'Year';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrPage.MonAttSubForm.PAGE.GetEmp(Month, Year, rec."No.");
                    end;
                }
                part(MonAttSubForm; 60075)
                {
                    SubPageLink = "Employee Code" = FIELD("No.");
                }
            }
            group("Leave Application")
            {
                Caption = 'Leave Application';
                field(MonthLeave; Month)
                {
                    Caption = 'Month';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrPage.LeaveApplication.PAGE.GerEmp(Month, Year, Rec."No.");
                    end;
                }
                field(monthYrL; Year)
                {
                    Caption = 'Year';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrPage.LeaveApplication.PAGE.GerEmp(Month, Year, rec."No.");
                    end;
                }
                part(LeaveApplication; 60076)
                {
                    ApplicationArea = all;
                    SubPageLink = "Employee No." = FIELD("No.");
                }
            }
            group("Leave Entitlement")
            {
                Caption = 'Leave Entitlement';
                field(LeaveEnMonth; Month)
                {
                    Caption = 'Month';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrPage.LeaveEntSubform.PAGE.GetEmp(Month, Year, rec."No.");
                    end;
                }
                field(LeaveEnYr; Year)
                {
                    ApplicationArea = all;
                    Caption = 'Year';
                }
                part(LeaveEntSubform; 60077)
                {
                    ApplicationArea = all;
                    SubPageLink = "Employee No." = FIELD("No.");
                }
            }
            group("Loan Details")
            {
                Caption = 'Loan Details';
                field(LoanId; LoanId)
                {
                    Caption = 'Loan Id';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        loan.SETRANGE("Employee Code", rec."No.");
                        IF PAGE.RUNMODAL(0, loan) = ACTION::LookupOK THEN BEGIN
                            LoanId := loan.Id;
                        END;
                        CurrPage.LoanDetSunForm.PAGE.GetEmp(LoanId);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.LoanDetSunForm.PAGE.GetEmp(LoanId);
                    end;
                }
                part(LoanDetSunForm; 60078)
                {
                    SubPageLink = "Employee No." = FIELD("No.");
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                Editable = false;
                field(Extension; rec.Extension)
                {
                    ApplicationArea = all;
                }
                field("Mobile Phone No."; rec."Mobile Phone No.")
                {
                    ApplicationArea = all;
                }
                field(Pager; rec.Pager)
                {
                    ApplicationArea = all;
                }
                field("Phone No."; rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("E-Mail"; rec."E-Mail")
                {
                    ApplicationArea = all;
                }
                field("Company E-Mail"; rec."Company E-Mail")
                {
                    ApplicationArea = all;
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                Editable = false;
                field("Employment Date"; rec."Employment Date")
                {
                    ApplicationArea = all;
                }
                field("Job Title"; rec."Job Title")
                {
                    ApplicationArea = all;
                }
                field(Designation; rec.Designation)
                {
                    ApplicationArea = all;
                }
                field("User Id"; rec."User Id")
                {
                    ApplicationArea = all;
                }
                field("Department Code"; rec."Department Code")
                {
                    ApplicationArea = all;
                }
                field("Pay Cadre"; rec."Pay Cadre")
                {
                    ApplicationArea = all;
                }
                field(Probation; rec.Probation)
                {
                    ApplicationArea = all;
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                Editable = false;
                field("Birth Date"; rec."Birth Date")
                {
                    ApplicationArea = all;

                }
                field("Social Security No."; rec."Social Security No.")
                {
                    ApplicationArea = all;
                }
                field("Blood Group"; rec."Blood Group")
                {
                    ApplicationArea = all;
                }
            }
            group("Pay Method")
            {
                Caption = 'Pay Method';
                Editable = false;
                field("Payment Method"; rec."Payment Method")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        IF (Rec."Payment Method" = Rec."Payment Method"::Cash) OR (Rec."Payment Method" = Rec."Payment Method"::Cheque) THEN BEGIN
                            rec."Bank Code" := '';
                            rec."Bank Name" := '';
                            rec."Bank Branch" := '';
                            "Bank CodeEditable" := FALSE;
                            "Bank NameEditable" := FALSE;
                            "Bank BranchEditable" := FALSE;
                            "Account TypeEditable" := FALSE;
                            "Account NoEditable" := FALSE;

                        END ELSE BEGIN
                            "Bank CodeEditable" := TRUE;
                            "Bank NameEditable" := TRUE;
                            "Bank BranchEditable" := TRUE;
                            "Account TypeEditable" := TRUE;
                            "Account NoEditable" := TRUE;
                        END;
                    end;
                }
                field("Bank Code"; rec."Bank Code")
                {
                    ApplicationArea = all;
                    Editable = "Bank CodeEditable";
                }
                field("Bank Name"; rec."Bank Name")
                {
                    ApplicationArea = all;
                    Editable = "Bank NameEditable";
                }
                field("Bank Branch"; rec."Bank Branch")
                {
                    ApplicationArea = all;
                    Editable = "Bank BranchEditable";
                }
                field("Account Type"; rec."Account Type")
                {
                    ApplicationArea = all;
                    Editable = "Account TypeEditable";
                }
                field("Account No"; rec."Account No")
                {
                    ApplicationArea = all;
                    Editable = "Account NoEditable";
                }
            }
            group(Taxation)
            {
                Caption = 'Taxation';
                Editable = false;
                field("ESI No"; rec."ESI No")
                {
                    ApplicationArea = all;
                }
                field("PF No"; rec."PF No")
                {
                    ApplicationArea = all;
                }
                field("PAN No"; rec."PAN No")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Generate Pay Slip")
            {
                Caption = 'Generate Pay Slip';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                var
                    MonthlyAttendance: Record 60029;
                begin
                    MonthlyAttendance.SETRANGE("Employee Code", rec."No.");
                    MonthlyAttendance.SETRANGE("Pay Slip Month", Month);
                    REPORT.RUN(60046, TRUE, FALSE, MonthlyAttendance);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.ProcSal.PAGE.GetEmp(Month, Year, rec."No.");
        CurrPage.MonAttSubForm.PAGE.GetEmp(Month, Year, rec."No.");
        CurrPage.LeaveApplication.PAGE.GerEmp(Month, Year, rec."No.");
        CurrPage.LoanDetSunForm.PAGE.GetEmp(LoanId);
        CurrPage.LeaveEntSubform.PAGE.GetEmp(Month, Year, rec."No.");
        CurrPage.LeaveEntSubform.PAGE.GetEmp(Month, Year, rec."No.");
    end;

    trigger OnInit()
    begin
        "Account NoEditable" := TRUE;
        "Account TypeEditable" := TRUE;
        "Bank BranchEditable" := TRUE;
        "Bank NameEditable" := TRUE;
        "Bank CodeEditable" := TRUE;
    end;

    trigger OnOpenPage()
    var
        HRSetup: Record 60016;
    begin
        Rec.SETRANGE("User Id", USERID);
        IF HRSetup.FIND('-') THEN BEGIN
            Month := HRSetup."Salary Processing month";
            Year := HRSetup."Salary Processing Year";
        END;
    end;

    var
        Text000: Label 'Attendance inserted for the employee %1.';
        Text001: Label 'Employment date should not be greater than leave year.';
        Text002: Label 'Shift must be define for the employee %1 to the date %2.';
        Month: Integer;
        Year: Integer;
        MonthlyAttendance: Record 60029;
        LoanDetails: Record 60040;
        LoanId: Code[20];
        loan: Record 60039;
        RecRef: RecordRef;
        //[InDataSet]
        "Bank CodeEditable": Boolean;
        //[InDataSet]
        "Bank NameEditable": Boolean;
        //[InDataSet]
        "Bank BranchEditable": Boolean;
        //[InDataSet]
        "Account TypeEditable": Boolean;
        //[InDataSet]
        "Account NoEditable": Boolean;

    local procedure MonthC1102152002OnActivate()
    begin
        CurrPage.ProcSal.PAGE.GetEmp(Month, Year, rec."No.");
    end;

    local procedure YearC1102152009OnActivate()
    begin
        CurrPage.ProcSal.PAGE.GetEmp(Month, Year, rec."No.");
    end;

    local procedure YearC1102152014OnActivate()
    begin
        CurrPage.MonAttSubForm.PAGE.GetEmp(Month, Year, rec."No.");
    end;

    local procedure MonthC1102152016OnActivate()
    begin
        CurrPage.MonAttSubForm.PAGE.GetEmp(Month, Year, rec."No.");
    end;

    local procedure YearC1102152036OnActivate()
    begin
        CurrPage.LeaveApplication.PAGE.GerEmp(Month, Year, rec."No.");
    end;

    local procedure MonthC1102152038OnActivate()
    begin
        CurrPage.LeaveApplication.PAGE.GerEmp(Month, Year, rec."No.");
    end;

    local procedure MonthC1102152043OnActivate()
    begin
        CurrPage.LeaveEntSubform.PAGE.GetEmp(Month, Year, rec."No.");
    end;

    local procedure LoanIdOnActivate()
    begin
        CurrPage.LoanDetSunForm.PAGE.GetEmp(LoanId);
    end;
}

