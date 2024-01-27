page 60000 "HR Setup"
{
    // B2B Software Technologies
    // -----------------------------
    // Project : Human Resource
    // B2B
    // No. sign      Date
    // ------------------------------
    // 01   B2B    13-dec-05

    PageType = Card;
    SourceTable = 60016;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Processing Month"; Rec."Processing Month")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Processing Month';
                    Editable = "Processing MonthEditable";
                }
                field("Salary Processing Year"; Rec."Salary Processing Year")
                {
                    ApplicationArea = all;
                    Editable = "Salary Processing YearEditable";
                }
                field("Default Attendance Type"; Rec."Default Attendance Type")
                {
                    ApplicationArea = all;
                }
                field("Rounding Type"; Rec."Rounding Type")
                {
                    ApplicationArea = all;
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ApplicationArea = all;
                }
                field("Emp Leave Applicable Days"; Rec."Emp Leave Applicable Days")
                {
                    ApplicationArea = all;
                    Caption = 'New Emp Leave Applicable Days';
                }
                field("Late Entry Ded. Allowed"; Rec."Late Entry Ded. Allowed")
                {
                    ApplicationArea = all;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = all;
                }
                field("Start Time with Grace Period"; Rec."Start Time with Grace Period")
                {
                    ApplicationArea = all;
                }
                field("Reopen Allow For Emp"; Rec."Reopen Allow For Emp")
                {
                    ApplicationArea = all;
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Cash Account"; Rec."Cash Account")
                {
                    ApplicationArea = all;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = all;
                }
                field("TA Account"; Rec."TA Account")
                {
                    ApplicationArea = all;
                }
                field("Payroll Journal Template"; Rec."Payroll Journal Template")
                {
                    ApplicationArea = all;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = all;
                }
                field(Loan; Rec.Loan)
                {
                    ApplicationArea = all;
                }
                field("Final Settlement Code"; Rec."Final Settlement Code")
                {
                    ApplicationArea = all;
                }
                field(Training; Rec.Training)
                {
                    ApplicationArea = all;
                }
                field("Interview No."; Rec."Interview No.")
                {
                    ApplicationArea = all;
                }
                field("Intrewiewee No."; Rec."Intrewiewee No.")
                {
                    ApplicationArea = all;
                }
            }
            group(Gratuity)
            {
                Caption = 'Gratuity';
                field("No. of days less than 6 years"; Rec."No. of days less than 6 years")
                {
                    ApplicationArea = all;
                }
                field("No. of days Grea. than 6 years"; Rec."No. of days Grea. than 6 years")
                {
                    ApplicationArea = all;
                }
            }
            group(Tax)
            {
                Caption = 'Tax';
                field("Men Tax Rebate"; Rec."Men Tax Rebate")
                {
                    ApplicationArea = all;
                }
                field("Women Tax Rebate"; Rec."Women Tax Rebate")
                {
                    ApplicationArea = all;
                }
                field("Senior Citizen Tax Rebate"; Rec."Senior Citizen Tax Rebate")
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
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Lock Processing Period")
                {
                    ApplicationArea = all;
                    Caption = '&Lock Processing Period';

                    trigger OnAction()
                    begin
                        rec.TESTFIELD(Rec."Salary Processing Year");
                        Rec.Locked := TRUE;
                        Rec.MODIFY;
                        "Processing MonthEditable" := FALSE;
                        "Salary Processing YearEditable" := FALSE;
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        "Salary Processing YearEditable" := TRUE;
        "Processing MonthEditable" := TRUE;
    end;

    var
        RecRef: RecordRef;
        // [InDataSet]
        "Processing MonthEditable": Boolean;
        // [InDataSet]
        "Salary Processing YearEditable": Boolean;
}

