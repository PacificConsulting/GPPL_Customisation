page 60093 "Interviewee Card"
{
    PageType = Card;
    SourceTable = 60061;
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("First Name"; rec."First Name")
                {
                    ApplicationArea = all;
                }
                field("Middle Name"; rec."Middle Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; rec."Last Name")
                {
                    ApplicationArea = all;
                }
                field(Initials; rec.Initials)
                {
                    ApplicationArea = all;
                }
                field("Search Name"; rec."Search Name")
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
                field(City; rec.City)
                {
                    ApplicationArea = all;
                }
                field("Post Code"; rec."Post Code")
                {
                    ApplicationArea = all;
                }
                field(County; rec.County)
                {
                    ApplicationArea = all;
                    Caption = 'Country';
                }
                field("Phone No."; rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Mobile Phone No."; rec."Mobile Phone No.")
                {
                    ApplicationArea = all;
                }
                field("E-Mail"; rec."E-Mail")
                {
                    ApplicationArea = all;
                }
                field("Birth Date"; rec."Birth Date")
                {
                    ApplicationArea = all;
                }
                field(Gender; rec.Gender)
                {
                    ApplicationArea = all;
                }
                field("No. Series"; rec."No. Series")
                {
                    ApplicationArea = all;
                }
                field("Martial status"; rec."Martial status")
                {
                    ApplicationArea = all;
                }
                field("No. Of Children"; rec."No. Of Children")
                {
                    ApplicationArea = all;
                }
                field("Driving License No."; rec."Driving License No.")
                {
                    ApplicationArea = all;
                }
                field("PAN No"; rec."PAN No")
                {
                    ApplicationArea = all;
                }
                field("PF No"; rec."PF No")
                {
                    ApplicationArea = all;
                }
                field("Blood Group"; rec."Blood Group")
                {
                    ApplicationArea = all;
                }
                field(Passport; rec.Passport)
                {
                    ApplicationArea = all;
                }
                field(Experience; rec.Experience)
                {
                    ApplicationArea = all;
                }
                field("Pervious Employer Name"; rec."Pervious Employer Name")
                {
                    ApplicationArea = all;
                }
                field("Previous Designation"; rec."Previous Designation")
                {
                    ApplicationArea = all;
                }
                field("Previous CTC"; rec."Previous CTC")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Interviewee")
            {
                Caption = '&Interviewee';
                action("Convert Employee")
                {
                    Caption = 'Convert Employee';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        IF rec."Converted To Employee" THEN
                            ERROR('This Interviewee already has been converted to Employee');
                        Employee.RESET;
                        Employee.SETRANGE(Employee."Interview No.", rec."No.");
                        IF NOT Employee.FINDFIRST THEN BEGIN
                            EmployeeNew.RESET;
                            EmployeeNew.INIT;
                            EmployeeNew.TRANSFERFIELDS(Rec);
                            EmployeeNew."No." := '';
                            EmployeeNew.INSERT(TRUE);
                            MESSAGE('Candidate No. %1 has been converted to Employee No. %2', rec."No.", EmployeeNew."No.");
                            Employee1.GET(EmployeeNew."No.");
                            Employee1."Interview No." := rec."No.";
                            Employee1.MODIFY;
                            rec."Converted To Employee" := TRUE;
                            rec.MODIFY;
                        END
                        ELSE
                            ERROR('This Interviewee has already been converted into Employee %1', Employee."No.");
                    end;
                }
            }
        }
    }

    var
        Employee: Record 60019;
        EmployeeNew: Record 60019;
        EMployeeNo: Code[20];
        Employee1: Record 60019;
        NOSeriesManagement: Codeunit NoSeriesManagement;
        HRSetup: Record 60016;
}

