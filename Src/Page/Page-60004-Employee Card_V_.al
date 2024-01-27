page 60004 "Employee Card_V_"
{
    Caption = 'Employee';
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
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        IF rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = all;
                    Caption = 'Middle Name/Initials';
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = all;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = all;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = all;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                    Caption = 'Post Code/City';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                }
                field("State Code"; Rec."State Code")
                {
                    ApplicationArea = all;
                    Caption = 'State';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = all;
                }
                field("Emp Status"; Rec."Emp Status")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Senior Citizen"; Rec."Senior Citizen")
                {
                    ApplicationArea = all;
                }
                field("Balance Amt(LCY)"; Rec."Balance Amt(LCY)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Emp Location"; Rec."Emp Location")
                {
                    ApplicationArea = all;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Post to GL"; Rec."Post to GL")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        PosttoGLOnAfterValidate;
                    end;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = all;
                }
                field("Blocked Date"; Rec."Blocked Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Stop Payment"; Rec."Stop Payment")
                {
                    ApplicationArea = all;
                }
                field(Resigned; Rec.Resigned)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Resignation Date"; Rec."Resignation Date")
                {
                    ApplicationArea = all;
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = all;
                }
                field("DA Type"; Rec."DA Type")
                {
                    ApplicationArea = all;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = all;
                }
                field(Pager; Rec.Pager)
                {
                    ApplicationArea = all;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = all;
                }
                field(Extension; Rec.Extension)
                {
                    ApplicationArea = all;
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        Rec."Next Leave Salary Date" := CALCDATE('12M', Rec."Employment Date")
                    end;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //EBT Paramita
                        IF rec.Status = rec.Status::Active THEN BEGIN
                            "Inactive DateEditable" := FALSE;
                            CauseofInactivityCodeEditable := FALSE;
                            "Grounds for Term. CodeEditable" := FALSE;
                        END
                        ELSE
                            IF rec.Status = rec.Status::Inactive THEN BEGIN
                                "Inactive DateEditable" := TRUE;
                                CauseofInactivityCodeEditable := TRUE;
                                "Grounds for Term. CodeEditable" := FALSE;
                            END
                            ELSE
                                IF rec.Status = rec.Status::Terminated THEN BEGIN
                                    "Inactive DateEditable" := FALSE;
                                    CauseofInactivityCodeEditable := FALSE;
                                    "Grounds for Term. CodeEditable" := TRUE;
                                END;
                    end;
                }
                field(Designation; Rec.Designation)
                {

                    ApplicationArea = all;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = all;
                }
                field("Inactive Date"; Rec."Inactive Date")
                {
                    ApplicationArea = all;
                    //Editable = Rec."Inactive DateEditable";
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = all;
                    Editable = CauseofInactivityCodeEditable;
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = all;
                    Editable = "Grounds for Term. CodeEditable";
                }
                field(PF; Rec.PF)
                {
                    ApplicationArea = all;
                    Caption = 'Calculate PF from Basic';
                }
                field("Period Start Date"; Rec."Period Start Date")
                {
                    ApplicationArea = all;
                }
                field("Period End Date"; Rec."Period End Date")
                {
                    ApplicationArea = all;
                }
                field("OT Applicable"; Rec."OT Applicable")
                {
                    ApplicationArea = all;
                }
                field("OT Calculation Rate"; Rec."OT Calculation Rate")
                {
                    ApplicationArea = all;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = all;
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = all;
                }
                field("Emp Posting Group"; Rec."Emp Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Payroll Bus. Posting Group"; Rec."Payroll Bus. Posting Group")
                {
                    ApplicationArea = all;
                    Caption = 'Bus. Posting Group';
                }
                field("Pay Cadre"; Rec."Pay Cadre")
                {
                    ApplicationArea = all;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = all;
                }
                field(Qualification; Rec.Qualification)
                {
                    ApplicationArea = all;
                }
                field(Probation; Rec.Probation)
                {
                    ApplicationArea = all;
                }
                field("Transfer Reason"; Rec."Transfer Reason")
                {
                    ApplicationArea = all;
                }
                field("Transfer Date"; Rec."Transfer Date")
                {
                    ApplicationArea = all;
                }
                field("Office Type"; Rec."Office Type")
                {
                    ApplicationArea = all;
                }
                field(Worker; Rec.Worker)
                {
                    ApplicationArea = all;
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = all;
                }
                field("Blood Group"; Rec."Blood Group")
                {
                    ApplicationArea = all;
                }
                field(Nominee; Rec.Nominee)
                {
                    ApplicationArea = all;
                }
                field("Emp Code Ref"; Rec."Emp Code Ref")
                {
                    ApplicationArea = all;
                }
            }
            group("Pay Method")
            {

                Caption = 'Pay Method';
                field("Payment Method"; rec."Payment Method")
                {

                    trigger OnValidate()
                    begin
                        IF (rec."Payment Method" = rec."Payment Method"::Cash) OR (rec."Payment Method" = rec."Payment Method"::Cheque) THEN BEGIN
                            //   "Bank Code" :='';
                            //   "Bank Name" :='';
                            //   "Bank Branch" :='';
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
                field("ESI Dispensary"; rec."ESI Dispensary")
                {
                    ApplicationArea = all;
                }
                field("ESI Applicable"; Rec."ESI Applicable")
                {
                    ApplicationArea = all;
                }
                field("PF Applicable"; Rec."PF Applicable")
                {
                    ApplicationArea = all;
                }
                field("PT Applicable"; Rec."PT Applicable")
                {
                    ApplicationArea = all;
                }
            }
            group("Prev Company")
            {
                Caption = 'Prev Company';
                field("Pervious Employer Name"; Rec."Pervious Employer Name")
                {
                    ApplicationArea = all;
                }
                field("Previous Designation"; Rec."Previous Designation")
                {
                    ApplicationArea = all;
                }
                field("Previous CTC"; Rec."Previous CTC")
                {
                    ApplicationArea = all;
                }
                field("Period From"; Rec."Period From")
                {
                    ApplicationArea = all;
                }
                field("Period To"; Rec."Period To")
                {
                    ApplicationArea = all;
                }
                field("Net Period"; Rec."Net Period")
                {
                    ApplicationArea = all;
                }
            }
            group(Others)
            {
                Caption = 'Others';
                field("Martial status"; Rec."Martial status")
                {
                    ApplicationArea = all;
                }
                field("Spouse Name"; Rec."Spouse Name")
                {
                    ApplicationArea = all;
                }
                field("Marraige Date"; Rec."Marraige Date")
                {
                    ApplicationArea = all;
                }
                field("No. Of Children"; Rec."No. Of Children")
                {
                    ApplicationArea = all;
                }
                field("Nominee Add."; Rec."Nominee Add.")
                {
                    ApplicationArea = all;
                }
                field("Nominee Relationship"; Rec."Nominee Relationship")
                {
                    ApplicationArea = all;
                }
                field("Father's First Name"; Rec."Father's First Name")
                {
                    ApplicationArea = all;
                }
                field("Father's Middle Name"; Rec."Father's Middle Name")
                {
                    ApplicationArea = all;
                }
                field("Father's Last  Name"; Rec."Father's Last  Name")
                {
                    ApplicationArea = all;
                }
                field("Mother's First Name"; Rec."Mother's First Name")
                {
                    ApplicationArea = all;
                }
                field("Mother's Middle Name"; Rec."Mother's Middle Name")
                {
                    ApplicationArea = all;
                }
                field("Mother's Last  Name"; Rec."Mother's Last  Name")
                {
                    ApplicationArea = all;
                }
                field("Perminant Area/locality/taluka"; Rec."Perminant Area/locality/taluka")
                {
                    ApplicationArea = all;
                    Caption = 'Area/locality/taluka';
                }
                field("Perminant town"; Rec."Perminant town")
                {
                    ApplicationArea = all;
                    Caption = 'Town';
                }
                field("Perminant State"; Rec."Perminant State")
                {
                    ApplicationArea = all;
                }
                field("Perminant Country"; Rec."Perminant Country")
                {
                    ApplicationArea = all;
                }
                field("Name on SSN Card"; Rec."Name on SSN Card")
                {
                    ApplicationArea = all;
                }
                field("Father Name on SSn Card"; Rec."Father Name on SSn Card")
                {
                    ApplicationArea = all;
                }
                field("Pension A/c (Exempted Establis"; Rec."Pension A/c (Exempted Establis")
                {
                    ApplicationArea = all;
                }
                field("perminant pincode"; Rec."perminant pincode")
                {
                    ApplicationArea = all;
                    Caption = 'Pincode';
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = all;
                }
                field("Place of birthVilage/town/city"; Rec."Place of birthVilage/town/city")
                {
                    ApplicationArea = all;
                }
                field("Place of birth District"; Rec."Place of birth District")
                {
                    ApplicationArea = all;
                }
                field("Place of birth State"; Rec."Place of birth State")
                {
                    ApplicationArea = all;
                }
                field("Place of birth Country"; Rec."Place of birth Country")
                {
                    ApplicationArea = all;
                }
                field("Correspondence  Door no"; Rec."Correspondence  Door no")
                {
                    ApplicationArea = all;
                    Caption = 'Door no';
                }
                field("Corres Name of Premises/villag"; Rec."Corres Name of Premises/villag")
                {
                    ApplicationArea = all;
                    Caption = 'Name of Premises/villag';
                }
                field("Corres Road/strre/Lane"; Rec."Corres Road/strre/Lane")
                {
                    ApplicationArea = all;
                    Caption = 'Road/strre/Lane';
                }
                field("Corres Area/locality/taluka"; Rec."Corres Area/locality/taluka")
                {
                    ApplicationArea = all;
                    Caption = 'Area/locality/taluka';
                }
                field("Corres town"; Rec."Corres town")
                {
                    ApplicationArea = all;
                    Caption = 'Town';
                }
                field("Corres State"; Rec."Corres State")
                {
                    ApplicationArea = all;
                }
                field("Corres Country"; Rec."Corres Country")
                {
                    ApplicationArea = all;
                }
                field("Perminant  Door no"; Rec."Perminant  Door no")
                {
                    ApplicationArea = all;
                    Caption = ' Door no';
                }
                field("perm. Name of Premises/villag"; Rec."perm. Name of Premises/villag")
                {
                    ApplicationArea = all;
                }
                field("Perminant Road/strre/Lane"; Rec."Perminant Road/strre/Lane")
                {
                    ApplicationArea = all;
                    Caption = ' Road/strre/Lane';
                }
                field("Corres PinCode"; Rec."Corres PinCode")
                {
                    ApplicationArea = all;
                    Caption = 'Pin Code';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                action(Dimensions)
                {
                    ApplicationArea = all;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page 540;
                    RunPageLink = "Table ID" = CONST(60019),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        rec.Attachments;
                    end;
                }
                separator("----------------------")
                {
                    Caption = '----------------------';
                }
                action("&Training")
                {
                    Caption = '&Training';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        ShowDetails;
                    end;
                }
                separator(seprator3)
                {
                }
                action("TD&S Amount")
                {
                    ApplicationArea = all;
                    Caption = 'TD&S Amount';
                    RunObject = Page 60083;
                    RunPageLink = "Employee Code" = FIELD("No.");
                }
                separator("-----------------")
                {
                    Caption = '-----------------';
                }
                action("Leave &Entitlement")
                {
                    ApplicationArea = all;
                    Caption = 'Leave &Entitlement';
                    RunObject = Page 60023;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                action("Sanctioning &Incharge")
                {
                    ApplicationArea = all;
                    Caption = 'Sanctioning &Incharge';
                    RunObject = Page 60070;
                    RunPageLink = "Employee No." = FIELD("No.");
                }
                separator(separator1)
                {
                }
                action("S&hift")
                {
                    ApplicationArea = all;
                    Caption = 'S&hift';
                    RunObject = Page 60012;
                    RunPageLink = "Employee Code" = FIELD("No.");
                }
                separator(separator2)
                {
                }
                action(Statistics)
                {
                    ApplicationArea = all;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 60080;
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                }
            }
            group("&Payroll")
            {
                Caption = '&Payroll';
                action("Pay &Elements")
                {
                    ApplicationArea = all;
                    Caption = 'Pay &Elements';
                    RunObject = Page 60014;
                    RunPageLink = "Employee Code" = FIELD("No.");
                }
                action("&Loans")
                {
                    ApplicationArea = all;
                    Caption = '&Loans';
                    RunObject = Page 60033;
                    RunPageLink = "Employee Code" = FIELD("No.");
                }
                action("TDS Schedule")
                {
                    ApplicationArea = all;
                    Caption = 'TDS Schedule';
                    RunObject = Page 60043;
                    RunPageLink = "Employee No." = FIELD("No.");
                    Visible = false;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Generate &Calender")
                {
                    Caption = 'Generate &Calender';
                    ShortCutKey = 'Ctrl+F11';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        CalenderGen.RUN(Rec);
                    end;
                }
                separator("---------------------")
                {
                    Caption = '---------------------';
                }
                action("Re&sign")
                {
                    Caption = 'Re&sign';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        rec.TESTFIELD(rec."Emp Status", rec."Emp Status"::Open);
                        rec."Emp Status" := rec."Emp Status"::Release;
                        rec.Resigned := TRUE;
                        MonthlyAttendance.RESET;
                        MonthlyAttendance.SETRANGE("Employee Code", rec."No.");
                        IF MonthlyAttendance.FIND('-') THEN
                            REPEAT
                                MonthlyAttendance.Resigned := TRUE;
                                MonthlyAttendance.MODIFY;
                            UNTIL MonthlyAttendance.NEXT = 0;

                        rec.MODIFY;
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        HRSetup.GET;
                        IF NOT HRSetup."Reopen Allow For Emp" THEN
                            ERROR('Reopen not Allowed...');
                        rec."Emp Status" := rec."Emp Status"::Open;

                        MonthlyAttendance.RESET;
                        MonthlyAttendance.SETRANGE("Employee Code", rec."No.");
                        IF MonthlyAttendance.FIND('-') THEN
                            REPEAT
                                MonthlyAttendance.Resigned := FALSE;
                                MonthlyAttendance.MODIFY;
                            UNTIL MonthlyAttendance.NEXT = 0;

                        rec.Resigned := FALSE;
                        rec.MODIFY;
                    end;
                }
                action("Generate Calender")
                {
                    Caption = 'Generate Calender';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        PAGE.RUNMODAL(60065, Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF (rec."Payment Method" = rec."Payment Method"::Cash) OR (rec."Payment Method" = rec."Payment Method"::Cheque) THEN BEGIN
            //   "Bank Code" :='';
            //   "Bank Name" :='';
            //   "Bank Branch" :='';
            "Bank CodeEditable" := FALSE;
            "Bank NameEditable" := FALSE;
            "Bank BranchEditable" := FALSE;
            "Account TypeEditable" := FALSE;
            "Account NoEditable" := FALSE;
        END
        ELSE BEGIN
            "Bank CodeEditable" := TRUE;
            "Bank NameEditable" := TRUE;
            "Bank BranchEditable" := TRUE;
            "Account TypeEditable" := TRUE;
            "Account NoEditable" := TRUE;
        END;

        //EBT Paramita
        IF rec.Status = rec.Status::Active THEN BEGIN
            "Inactive DateEditable" := FALSE;
            CauseofInactivityCodeEditable := FALSE;
            "Grounds for Term. CodeEditable" := FALSE;
        END
        ELSE
            IF rec.Status = rec.Status::Inactive THEN BEGIN
                "Inactive DateEditable" := TRUE;
                CauseofInactivityCodeEditable := TRUE;
                "Grounds for Term. CodeEditable" := FALSE;
            END
            ELSE
                IF rec.Status = rec.Status::Terminated THEN BEGIN
                    "Inactive DateEditable" := FALSE;
                    CauseofInactivityCodeEditable := FALSE;
                    "Grounds for Term. CodeEditable" := TRUE;
                END;
    end;

    trigger OnInit()
    begin
        "Grounds for Term. CodeEditable" := TRUE;
        CauseofInactivityCodeEditable := TRUE;
        "Inactive DateEditable" := TRUE;
        "Account NoEditable" := TRUE;
        "Account TypeEditable" := TRUE;
        "Bank BranchEditable" := TRUE;
        "Bank NameEditable" := TRUE;
        "Bank CodeEditable" := TRUE;
    end;

    var
        Employee: Record 60019;
        NoSeriesManagement: Codeunit 396;
        Text000: Label 'Attendance inserted for the employee %1.';
        Text001: Label 'Employment date should not be greater than leave year.';
        Text002: Label 'Shift must be define for the employee %1 to the date %2.';
        Mail: Codeunit 397;
        RecRef: RecordRef;
        ID: Integer;
        HRSetup: Record 60016;
        MonthlyAttendance: Record 60029;
        CalenderGen: Codeunit 60000;
        PictureExists: Boolean;
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
        //[InDataSet]
        "Inactive DateEditable": Boolean;
        //[InDataSet]
        CauseofInactivityCodeEditable: Boolean;
        //[InDataSet]
        "Grounds for Term. CodeEditable": Boolean;

    // [Scope('Internal')]
    procedure ShowDetails()
    begin
    end;

    local procedure PosttoGLOnAfterValidate()
    begin
        MonthlyAttendance.RESET;
        MonthlyAttendance.SETRANGE("Employee Code", rec."No.");
        IF MonthlyAttendance.FIND('-') THEN
            REPEAT
                MonthlyAttendance."Post to GL" := rec."Post to GL";
                MonthlyAttendance.MODIFY;
            UNTIL MonthlyAttendance.NEXT = 0;
    end;
}

