page 60024 "Employee Leave Application"
{
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = 60032;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrEmpno; CurrEmpno)
                {
                    Caption = 'Employee No';
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF PAGE.RUNMODAL(0, Employee) = ACTION::LookupOK THEN BEGIN
                            CurrEmpno := Employee."No.";
                            Name := Employee."First Name";
                        END;

                        SelectEmployee;
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                    Caption = 'Employee Name';
                }
                field(CurrMonth; CurrMonth)
                {
                    ApplicationArea = all;
                    Caption = 'Month';
                    Visible = false;
                }
                field(CurrYear; CurrYear)
                {
                    Caption = 'Year';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrYearOnAfterValidate;
                    end;
                }
            }
            repeater(control1)
            {
                field("Leave Code"; rec."Leave Code")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin


                        IF CurrEmpno = '' THEN
                            ERROR(Text000);
                        rec.MODIFY;
                    end;
                }
                field("Employee No."; rec."Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Leave Duration"; rec."Leave Duration")
                {
                    ApplicationArea = all;
                }
                field("From Date"; rec."From Date")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        IF rec."Leave Code" = 'EL' THEN BEGIN
                            FRMDate := rec."From Date";
                            Year1 := DATE2DMY(FRMDate, 3);
                            DailyAtt.INIT;
                            DailyAtt.SETRANGE(DailyAtt."Employee No.", CurrEmpno);
                            DailyAtt.SETRANGE("Leave Code", 'EL');
                            DailyAtt.SETRANGE(Year, Year1);
                            IF DailyAtt.FIND('+') THEN
                                IF DailyAtt."No of times EL used" = 4 THEN BEGIN
                                    ERROR('EL leaves are over in this year');
                                END;
                        END;
                    end;
                }
                field("To Date"; rec."To Date")
                {
                    ApplicationArea = all;

                }
                field("No.of Days"; rec."No.of Days")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Send For Appr.Userid"; rec."Send For Appr.Userid")
                {
                    ApplicationArea = all;
                }
                field("Reason for Leave"; rec."Reason for Leave")
                {
                    ApplicationArea = all;
                }
                field("Send for Approval DateTime"; rec."Send for Approval DateTime")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
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
                action("Update &Leaves")
                {
                    Caption = 'Update &Leaves';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        rec.UpdateAbsent;
                        rec.LeaveConvertion;
                    end;
                }
                action("&Cancel Leave")
                {
                    Caption = '&Cancel Leave';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        rec.CancelLeaves(Rec);
                    end;
                }
                action("Send For Approval")
                {
                    ApplicationArea = all;
                    Caption = 'Send For Approval';
                    Ellipsis = true;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //VE-026>>
                        IF rec."Leave Code" = 'SL' THEN BEGIN
                            Employee1.SETRANGE("No.", CurrEmpno);
                            IF Employee1."ESI Applicable" THEN
                                ERROR('U R not eligible for sick leave');
                        END;

                        //EBT Paramita
                        Employee.GET(CurrEmpno);
                        LeaveSanctionIncharge.RESET;
                        LeaveSanctionIncharge.SETRANGE("Employee No.", Employee."No.");
                        IF LeaveSanctionIncharge.FINDFIRST THEN;
                        //EBT Paramita

                        Lev.RESET;
                        Lev.SETRANGE("Employee No.", CurrEmpno);
                        Lev.SETRANGE(Status, 0);
                        IF Lev.FIND('-') THEN
                            REPEAT
                                IF Lev.Status = Lev.Status::"Send For Approval" THEN
                                    MESSAGE('Document Already Sent for Approval')
                                ELSE BEGIN
                                    Lev.TESTFIELD("From Date");
                                    Lev.TESTFIELD("To Date");
                                    Lev.TESTFIELD("Reason for Leave");
                                    Lev.Status := Lev.Status::"Send For Approval";
                                    Lev."Sanctioning Incharge" := LeaveSanctionIncharge."Sanctioning Incharge";    //EBT Paramita
                                    Lev."Send for Approval DateTime" := CURRENTDATETIME;
                                    Lev."Send For Appr.Userid" := USERID;
                                    Lev.MODIFY;
                                    //EBT Paramita
                                    DateRec.RESET;
                                    DateRec.SETRANGE("Period Type", DateRec."Period Type"::Date);
                                    DateRec.SETFILTER("Period Start", '%1..%2', Lev."From Date", Lev."To Date");
                                    IF DateRec.FINDSET THEN
                                        REPEAT
                                            DetailedAppliedLeave.INIT;
                                            DetailedAppliedLeave."Employee Code" := Lev."Employee No.";
                                            DetailedAppliedLeave.Date := DateRec."Period Start";
                                            DetailedAppliedLeave."Leave Code" := Lev."Leave Code";
                                            DetailedAppliedLeave.Applied := TRUE;
                                            IF Lev."Leave Duration" = Lev."Leave Duration"::"Full Day" THEN BEGIN
                                                DetailedAppliedLeave."Leave Duration" := DetailedAppliedLeave."Leave Duration"::"Full Day";
                                                DetailedAppliedLeave.Day := 1;
                                            END
                                            ELSE
                                                IF Lev."Leave Duration" = Lev."Leave Duration"::"Half Day" THEN BEGIN
                                                    DetailedAppliedLeave."Leave Duration" := DetailedAppliedLeave."Leave Duration"::"Half Day";
                                                    DetailedAppliedLeave.Day := 0.5;
                                                END;
                                            DetailedAppliedLeave.INSERT;
                                        UNTIL DateRec.NEXT = 0;
                                    //EBT Paramita

                                END;
                            UNTIL Lev.NEXT = 0;
                        //VE-026>>
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        IF CurrEmpno = '' THEN
            ERROR(Text000);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF rec.Status = rec.Status::Reject THEN
            ERROR('Modification is not Allowed');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //EBT Paramita
        rec."Employee No." := CurrEmpno;
        //EBT Paramita
    end;

    trigger OnOpenPage()
    begin
        /*Employee2.RESET;
        Employee2.SETRANGE(Employee2."User Id",USERID);
        IF Employee2.FIND('-') THEN;
        FILTERGROUP(2);
        SETRANGE("Employee No.",Employee2."No.");
        FILTERGROUP(0); */  //EBT Paramita


        CurrEmpno := Employee2."No.";
        Name := Employee2."First Name";

        /*
        IF Hrsetup.FIND('-') THEN BEGIN
          CurrYear:=Hrsetup."Salary Processing Year";
          CurrMonth:=Hrsetup."Salary Processing month";
        END;
        */
        SelectEmployee;

    end;

    var
        Hrsetup: Record 60016;
        Employee: Record 60019;
        CurrEmpno: Code[20];
        Name: Text[50];
        CurrentMonth: Integer;
        CurrentYear: Integer;
        Text000: Label 'Employee No. should  be selected';
        CurrYear: Integer;
        CurrMonth: Integer;
        Lev: Record 60032;
        Employee1: Record 60019;
        Employee2: Record 60019;
        DailyAtt: Record 60028;
        FRMDate: Date;
        Year1: Integer;
        DateRec: Record 2000000007;
        DetailedAppliedLeave: Record 60001;
        LeaveSanctionIncharge: Record 60011;

    //   [Scope('Internal')]
    procedure SelectEmployee()
    begin
        rec.SETRANGE("Employee No.", CurrEmpno);
        CurrPage.UPDATE(FALSE);
    end;

    //   [Scope('Internal')]
    procedure SelectYear()
    begin
        /*SETRANGE(Year,CurrYear);
        CurrForm.UPDATE(FALSE);  */

    end;

    //  [Scope('Internal')]
    procedure SelectMonth()
    begin
        /*SETRANGE(Month,CurrMonth);
        CurrForm.UPDATE(FALSE);  */

    end;

    local procedure CurrYearOnAfterValidate()
    begin
        SelectYear;
    end;
}

