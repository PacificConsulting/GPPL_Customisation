page 60018 "Monthly Attendance"
{
    // Date: 16-Dec-05

    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = 60029;
    SourceTableView = SORTING("Employee Code", "Pay Slip Month", Year, "Line No.")
                      ORDER(Ascending)
                      WHERE("Reversal Entries" = FILTER(false));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(CurrentYear; CurrentYear)
                {
                    ApplicationArea = all;
                    Caption = 'Year';

                    trigger OnValidate()
                    begin
                        CurrentYearOnAfterValidate;
                    end;
                }
                field(CurrentMonth; CurrentMonth)
                {
                    ApplicationArea = all;
                    Caption = 'Month';
                    //ValuesAllowed = 1;2;3;4;5;6;7;8;9;10;11;12;

                    trigger OnValidate()
                    begin
                        CurrentMonthOnAfterValidate;
                    end;
                }
                field(CurrentCadre; CurrentCadre)
                {
                    ApplicationArea = all;
                    Caption = 'Pay Cadre';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Lookup.SETRANGE("LookupType Name", 'PAY CADRE');
                        IF PAGE.RUNMODAL(0, Lookup) = ACTION::LookupOK THEN BEGIN
                            CurrentCadre := Lookup."Lookup Name";
                        END;
                        SelectPayCadre;
                    end;

                    trigger OnValidate()
                    begin
                        CurrentCadreOnAfterValidate;
                    end;
                }
                field(EmpLoc; EmpLoc)
                {
                    ApplicationArea = all;
                    Caption = 'Location';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Lookup.RESET;
                        Lookup.SETFILTER(Lookup."LookupType Name", 'LOCATION');
                        IF PAGE.RUNMODAL(0, Lookup) = ACTION::LookupOK THEN
                            EmpLoc := Lookup."Lookup Name";
                        SelectLocation;
                    end;

                    trigger OnValidate()
                    begin
                        EmpLocOnAfterValidate;
                    end;
                }
                field(ShowAll; ShowAll)
                {
                    ApplicationArea = all;
                    Caption = 'Show All';

                    trigger OnValidate()
                    begin
                        ShowAllOnAfterValidate;
                    end;
                }
                field(OperationType; OperationType)
                {
                    Caption = 'Opration Type';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Lookup.RESET;
                        Lookup.SETFILTER("Lookup Type", '4');
                        IF PAGE.RUNMODAL(0, Lookup) = ACTION::LookupOK THEN
                            OperationType := Lookup."Lookup Name";
                        SelectOperation;
                    end;

                    trigger OnValidate()
                    begin
                        OperationTypeOnAfterValidate;
                    end;
                }
            }
            group(Postings)
            {
                Caption = 'Postings';
                field(TempBatch; TempBatch)
                {
                    Caption = 'Journal Batch Name';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        HRSetup.GET;
                        JournalTemplate.RESET;
                        //JournalTemplate.SETRANGE("Form ID",33001231);
                        JournalTemplate.SETRANGE(JournalTemplate.Name, HRSetup."Payroll Journal Template");
                        IF JournalTemplate.FIND('-') THEN
                            JournalBatch.SETRANGE("Journal Template Name", JournalTemplate.Name);
                        //IF FORM.RUNMODAL(60061,JournalBatch) = ACTION::LookupOK THEN BEGIN
                        IF PAGE.RUNMODAL(251, JournalBatch) = ACTION::LookupOK THEN BEGIN
                            TempBatch := JournalBatch.Name;
                            TempJournal := JournalBatch."Journal Template Name";
                            PostDate := TODAY;
                        END;

                        JournalBatch.FILTERGROUP(0);
                        JournalBatch.RESET;
                        JournalBatch.SETRANGE(Name, TempBatch);
                        IF JournalBatch.FIND('-') THEN
                            NoSeries.SETRANGE(Code, JournalBatch."No. Series");
                        IF NoSeries.FIND('-') THEN
                            //"DocNo." :=  NoSeriesMgt.TryGetNextNo(JournalBatch."No. Series",WORKDATE);
                            "DocNo." := NoSeriesMgt.GetNextNo(JournalBatch."No. Series", WORKDATE, FALSE);
                    end;
                }
                field(PostDate; PostDate)
                {
                    ApplicationArea = all;
                    Caption = 'PostDate';
                }
                field("DocNo."; "DocNo.")
                {
                    ApplicationArea = all;
                    Caption = 'Document No.';
                }
            }
            repeater(control)
            {
                field("Employee Code"; rec."Employee Code")
                {
                    ApplicationArea = all;
                    Caption = 'Employee No';
                    Editable = false;
                }
                field("Employee Name"; rec."Employee Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field("Late Hours"; rec."Late Hours")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Days; rec.Days)
                {
                    ApplicationArea = all;
                }
                field("Over Time Hrs"; rec."Over Time Hrs")
                {
                    ApplicationArea = all;
                }
                field("Leave Cut For LateHrs"; rec."Leave Cut For LateHrs")
                {
                    ApplicationArea = all;
                }
                field("Leaves Available"; rec."Leaves Available")
                {
                    ApplicationArea = all;
                }
                field("Total Leaves"; rec."Total Leaves")
                {
                    ApplicationArea = all;
                    Caption = 'Leaves Used';
                }
                field(Attendance; rec.Attendance)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Loss Of Pay"; rec."Loss Of Pay")
                {
                    ApplicationArea = all;
                }
                field("No.Of Payroll Days"; rec."No.Of Payroll Days")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Post to GL"; rec."Post to GL")
                {
                    ApplicationArea = all;
                }
                field(Processed; rec.Processed)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Posted; rec.Posted)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Leave Salary"; rec."Leave Salary")
                {
                    ApplicationArea = all;
                }
                field("Gross Salary"; rec."Gross Salary")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                }
                field(Deductions; rec.Deductions)
                {
                    ApplicationArea = all;
                    DecimalPlaces = 2 : 0;
                    Editable = false;
                }
                field("Net Salary"; rec."Net Salary")
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
            action(Previous)
            {
                Caption = 'Previous';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Previous';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    IF CurrentMonth = 1 THEN
                        rec.Year := CurrentYear - 1
                    ELSE
                        rec.Year := CurrentYear;

                    IF CurrentMonth = 1 THEN
                        Month := 12
                    ELSE
                        Month := CurrentMonth - 1;

                    Navigate.SETRANGE(Year, rec.Year);
                    Navigate.SETRANGE("Pay Slip Month", Month);
                    IF Navigate.FIND('-') THEN BEGIN
                        CurrentYear := rec.Year;
                        CurrentMonth := Month;
                        SelectYear;
                        SelectMonth;
                    END ELSE
                        ERROR(Text002);
                end;
            }
            action(Next)
            {
                Caption = 'Next';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Next';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    IF CurrentMonth = 12 THEN
                        rec.Year := CurrentYear + 1
                    ELSE
                        rec.Year := CurrentYear;

                    IF CurrentMonth = 12 THEN
                        Month := 1
                    ELSE
                        Month := CurrentMonth + 1;

                    Navigate.SETRANGE(Year, rec.Year);
                    Navigate.SETRANGE("Pay Slip Month", Month);
                    IF Navigate.FIND('-') THEN BEGIN
                        CurrentYear := rec.Year;
                        CurrentMonth := Month;
                        SelectYear;
                        SelectMonth;
                    END ELSE
                        ERROR(Text002);
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Processed &Salary")
                {
                    ApplicationArea = all;
                    Caption = 'Processed &Salary';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 60031;
                    RunPageLink = "Employee Code" = FIELD("Employee Code"),
                                  Year = FIELD(Year),
                                  "Pay Slip Month" = FIELD("Pay Slip Month");
                }
                group("Process &Salary")
                {
                    Caption = 'Process &Salary';
                    action("&Current Employee")
                    {
                        Caption = '&Current Employee';
                        Ellipsis = true;
                        Promoted = true;
                        PromotedIsBig = true;
                        ApplicationArea = all;
                        trigger OnAction()
                        begin
                            //VE-026>>
                            MA2.INIT;
                            IF MA2.FIND('-') THEN
                                MA2.DELETEALL;

                            CLEAR(Elleave);
                            IF NOT rec.Blocked THEN
                                IF NOT rec.Processed THEN BEGIN
                                    rec.Probationleaves := AddingProbationLeaves(Rec);
                                    rec.CALCFIELDS(Days, Attendance, Leaves, "No.of Days Count", LossOFpayCount, LeavesUsedForcasualLeaves);
                                    MA2.TRANSFERFIELDS(Rec);
                                    MA2.Days := rec.Days;
                                    MA2.Attendance := rec.Attendance;
                                    MA2.Leaves := rec.Leaves;
                                    MA2."No.of Days Count" := rec."No.of Days Count";
                                    MA2.LossOFpayCount := rec.LossOFpayCount;
                                    MA2.LeavesUsedForcasualLeaves := rec.LeavesUsedForcasualLeaves;
                                    rec."Leaves Used" := (rec."Leave Cut For LateHrs" + rec.Leaves) - (rec.LossOFpayCount);
                                    MA2."Leaves Used" := rec."Leaves Used";
                                    "Updating Earned leaves"(MA2);
                                    MA2.INSERT;
                                    Rec.TRANSFERFIELDS(MA2);
                                    rec."LeavesAvl.ForEL" := MA2."LeavesAvl.ForEL";
                                    MA2.CALCFIELDS(Days, Attendance, Leaves, "No.of Days Count", LossOFpayCount, LeavesUsedForcasualLeaves);
                                    rec."LeavesAvl.ForEL" := MA2."LeavesAvl.ForEL";
                                    Rec.TRANSFERFIELDS(MA2);
                                    LateLeaves := Employee.CheckLeavesToUse(Rec);
                                    Monthly.INIT;
                                    Monthly.SETRANGE("Employee Code", rec."Employee Code");
                                    Monthly.SETRANGE("Pay Slip Month", (rec."Pay Slip Month" - 1));
                                    Monthly.SETRANGE(Year, rec.Year);
                                    IF Monthly.FIND('-') THEN
                                        PRLEaves := Monthly.Probationleaves;

                                    Emp1.RESET;
                                    Emp1.SETRANGE("No.", rec."Employee Code");
                                    IF Emp1.FIND('-') THEN BEGIN
                                        Prob := Emp1.Probation;
                                        probdate := CALCDATE(Employee1."Probn.Duration", Employee1."Employment Date");
                                        probyear1 := DATE2DMY(probdate, 3);
                                    END;
                                    IF probyear1 <= rec.Year THEN BEGIN
                                        IF (rec."Pay Slip Month" >= Mon) AND (Prob = FALSE) AND (NOT Emp1.ProbLeavesAdded) THEN BEGIN
                                            rec."Leaves Available" := emp.GetLeaves1(Rec);//+PRLEaves;
                                            rec.TotalLeavesAvailable := emp.GetLeaves(Rec);//+PRLEaves;
                                            rec.VALIDATE(rec."Leaves Remaing", rec."Leaves Available" - (rec.LeavesUsedForcasualLeaves + rec."Leave Cut For LateHrs"));
                                            rec.Probationleaves := 0;
                                            LeaveEn.CLLeavesToAddAfterProbation := 0;
                                            Emp1.ProbLeavesAdded := TRUE;
                                            Emp1.MODIFY;
                                        END ELSE BEGIN
                                            rec."Leaves Available" := emp.GetLeaves1(Rec);
                                        END;
                                    END ELSE
                                        rec."Leaves Available" := emp.GetLeaves1(Rec);

                                    rec.VALIDATE("Leaves Remaing", rec."Leaves Available" - (rec.LeavesUsedForcasualLeaves + rec."Leave Cut For LateHrs"));

                                    rec."Leaves Added" := Employee.NoOfLeavesAssig(rec."Employee Code");

                                    MA2.INIT;
                                    MA2.SETRANGE("Employee Code", rec."Employee Code");
                                    MA2.SETRANGE("Pay Slip Month", rec."Pay Slip Month");
                                    MA2.SETRANGE(Year, rec.Year);
                                    IF MA2.FIND('-') THEN BEGIN
                                        MA2."Leaves Availabe" := rec."Leaves Available";
                                        MA2.VALIDATE("Leaves Remaing", rec."Leaves Remaing");
                                        MA2."Leaves Added" := rec."Leaves Added";
                                        MA2.MODIFY;
                                    END;
                                    rec."No.Of Payroll Days" := rec.Days - (LateLeaves + rec.LossOFpayCount);
                                    NoOfDaysInMonth(CurrentMonth, CurrentYear);
                                    IF Days < DaysInMon THEN BEGIN
                                        rec."Loss Of Pay" := DaysInMon - rec."No.Of Payroll Days";
                                    END ELSE BEGIN
                                        rec."Loss Of Pay" := rec.Days - rec."No.Of Payroll Days";
                                    END;

                                    IF rec."Leaves Available" >= rec."Leaves Used" THEN
                                        DeductLeaves := rec."Leaves Used"
                                    ELSE
                                        DeductLeaves := rec."Leaves Available";
                                    MA2.INIT;
                                    MA2.SETRANGE("Employee Code", rec."Employee Code");
                                    MA2.SETRANGE("Pay Slip Month", rec."Pay Slip Month");
                                    MA2.SETRANGE(Year, rec.Year);
                                    IF MA2.FIND('-') THEN BEGIN
                                        MA2."Leaves Availabe" := rec."Leaves Available";
                                        MA2.VALIDATE("Loss Of Pay", rec."Loss Of Pay");
                                        MA2."No.Of Payroll Days" := rec."No.Of Payroll Days";
                                        MA2.MODIFY;
                                    END;

                                    rec.CALCFIELDS(Days, Attendance, Leaves, "No.of Days Count", LossOFpayCount, LeavesUsedForcasualLeaves);
                                    UpdateLeaveEntitl(Rec);
                                    Employee.GenerateLeavesForNewEmp(Rec);
                                    ProcessedSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                                    ProcessedSalary.SETRANGE("Employee Code", rec."Employee Code");
                                    ProcessedSalary.SETRANGE("Pay Slip Month", rec."Pay Slip Month");
                                    ProcessedSalary.SETRANGE(Year, rec.Year);
                                    IF ProcessedSalary.FIND('-') THEN
                                        ProcessedSalary.DELETEALL;
                                    COMMIT;
                                    rec.CALCFIELDS(Days, Attendance, Leaves, "No.of Days Count", LossOFpayCount, LeavesUsedForcasualLeaves);
                                    SalaryProcess.ProcessSalary(Rec);
                                    SalaryProcess.DeductionPriority(Rec);
                                    MA2.INIT;
                                    MA2.SETRANGE("Employee Code", rec."Employee Code");
                                    MA2.SETRANGE("Pay Slip Month", rec."Pay Slip Month");
                                    MA2.SETRANGE(Year, rec.Year);
                                    IF MA2.FIND('-') THEN BEGIN

                                        MA2.Processed := TRUE;
                                        MA2."Processing Date" := TODAY;
                                        MA2."Net Salary" := rec."Net Salary";//Additions - Deductions;
                                        MA2."Remaining Amount" := rec."Remaining Amount";//Additions - Deductions;
                                        MA2.MODIFY;
                                    END;
                                    Ma3.INIT;
                                    Ma3.SETRANGE("Employee Code", rec."Employee Code");
                                    Ma3.SETRANGE("Pay Slip Month", rec."Pay Slip Month");
                                    Ma3.SETRANGE(Year, rec.Year);
                                    IF Ma3.FIND('-') THEN BEGIN
                                        Ma3.TRANSFERFIELDS(MA2);
                                        Ma3.MODIFY;
                                    END;
                                    MESSAGE(Text001);
                                END ELSE
                                    ERROR('Record Already Processed');

                            PayElement.RESET;
                            PayElement.SETRANGE("Employee Code", rec."Employee Code");
                            IF PayElement.FIND('-') THEN
                                REPEAT
                                    PayElement.Processed := FALSE;
                                    PayElement.MODIFY;
                                UNTIL PayElement.NEXT = 0;
                            MA2.DELETEALL;
                            //VE-026>>
                        end;
                    }
                    action("&All Employees")
                    {
                        Caption = '&All Employees';
                        Ellipsis = true;
                        Promoted = true;
                        PromotedIsBig = true;
                        ApplicationArea = all;
                        trigger OnAction()
                        begin
                            MA2.INIT;
                            IF MA2.FIND('-') THEN
                                MA2.DELETEALL;

                            //VE-026>>
                            IF EmpLoc <> '' THEN BEGIN
                                rec.CALCFIELDS("Emp Location");
                                rec.SETRANGE("Emp Location", EmpLoc);
                            END;

                            IF rec.FIND('-') THEN
                                REPEAT
                                BEGIN
                                    IF NOT rec.Blocked THEN
                                        IF NOT rec.Processed THEN BEGIN
                                            rec.Probationleaves := AddingProbationLeaves(Rec);
                                            rec.CALCFIELDS(Days, Attendance, Leaves, "No.of Days Count", LossOFpayCount, LeavesUsedForcasualLeaves);
                                            MA2.TRANSFERFIELDS(Rec);
                                            MA2.Days := rec.Days;
                                            MA2.Attendance := rec.Attendance;
                                            MA2.Leaves := rec.Leaves;
                                            MA2."No.of Days Count" := rec."No.of Days Count";
                                            MA2.LossOFpayCount := rec.LossOFpayCount;
                                            MA2.LeavesUsedForcasualLeaves := rec.LeavesUsedForcasualLeaves;
                                            rec."Leaves Used" := (rec."Leave Cut For LateHrs" + rec.Leaves) - (rec.LossOFpayCount);
                                            MA2."Leaves Used" := rec."Leaves Used";
                                            COMMIT;
                                            "Updating Earned leaves"(MA2);
                                            MA2.INSERT;
                                            MA2.CALCFIELDS(Days, Attendance, Leaves, "No.of Days Count", LossOFpayCount, LeavesUsedForcasualLeaves);
                                            rec."LeavesAvl.ForEL" := MA2."LeavesAvl.ForEL";
                                            Rec.TRANSFERFIELDS(MA2);
                                            LateLeaves := Employee.CheckLeavesToUse(Rec);
                                            Monthly.INIT;
                                            Monthly.RESET;
                                            Monthly.SETRANGE("Employee Code", rec."Employee Code");
                                            Monthly.SETRANGE("Pay Slip Month", (rec."Pay Slip Month" - 1));
                                            Monthly.SETRANGE(Year, rec.Year);
                                            IF Monthly.FIND('-') THEN
                                                PRLEaves := Monthly.Probationleaves;

                                            Emp1.RESET;
                                            Emp1.SETRANGE("No.", rec."Employee Code");
                                            IF Emp1.FIND('-') THEN BEGIN
                                                Prob := Emp1.Probation;
                                                probdate := CALCDATE(Employee1."Probn.Duration", Employee1."Employment Date");
                                                probyear1 := DATE2DMY(probdate, 3);
                                            END;
                                            IF probyear1 <= rec.Year THEN BEGIN
                                                IF (rec."Pay Slip Month" >= Mon) AND (Prob = FALSE) AND (NOT Emp1.ProbLeavesAdded) THEN BEGIN
                                                    rec."Leaves Available" := emp.GetLeaves1(Rec);//+PRLEaves;
                                                    rec.TotalLeavesAvailable := emp.GetLeaves(Rec);//+PRLEaves;
                                                    rec.VALIDATE("Leaves Remaing", rec."Leaves Available" - (rec.LeavesUsedForcasualLeaves + rec."Leave Cut For LateHrs"));
                                                    rec.Probationleaves := 0;
                                                    LeaveEn.CLLeavesToAddAfterProbation := 0;
                                                    Emp1.ProbLeavesAdded := TRUE;
                                                    Emp1.MODIFY;
                                                END ELSE BEGIN
                                                    rec."Leaves Available" := emp.GetLeaves1(Rec);
                                                END;
                                            END ELSE
                                                rec."Leaves Available" := emp.GetLeaves1(Rec);
                                            rec.VALIDATE("Leaves Remaing", rec."Leaves Available" - (rec.LeavesUsedForcasualLeaves + rec."Leave Cut For LateHrs"));

                                            rec."Leaves Added" := Employee.NoOfLeavesAssig(rec."Employee Code");

                                            MA2.INIT;
                                            MA2.RESET;
                                            MA2.SETRANGE("Employee Code", rec."Employee Code");
                                            MA2.SETRANGE("Pay Slip Month", rec."Pay Slip Month");
                                            MA2.SETRANGE(Year, rec.Year);
                                            IF MA2.FIND('-') THEN BEGIN
                                                MA2."Leaves Availabe" := rec."Leaves Available";
                                                MA2.VALIDATE("Leaves Remaing", rec."Leaves Remaing");
                                                MA2."Leaves Added" := rec."Leaves Added";
                                                MA2.MODIFY;
                                            END;
                                            /*
                                            Employee.RESET;
                                            Employee.SETRANGE("No.","Employee Code");
                                            IF Employee.FIND('-') THEN
                                             BEGIN
                                               IF ( Employee."Employment Date" > DMY2DATE(1,"Pay Slip Month",Year)) THEN
                                                  "No.Of Payroll Days":="No.of Days Count" - (LateLeaves + LossOFpayCount)
                                               ELSE
                                                  "No.Of Payroll Days":= Days - (LateLeaves + LossOFpayCount);
                                             END;
                                                 "No.Of Payroll Days":= Days - (LateLeaves + LossOFpayCount);
                                                 "Loss Of Pay" := Days - "No.Of Payroll Days";
                                             */

                                            rec."No.Of Payroll Days" := rec.Days - (LateLeaves + rec.LossOFpayCount);
                                            NoOfDaysInMonth(CurrentMonth, CurrentYear);
                                            IF rec.Days < DaysInMon THEN BEGIN
                                                rec."Loss Of Pay" := DaysInMon - rec."No.Of Payroll Days";
                                            END ELSE BEGIN
                                                rec."Loss Of Pay" := rec.Days - rec."No.Of Payroll Days";
                                            END;




                                            IF rec."Leaves Available" >= rec."Leaves Used" THEN
                                                DeductLeaves := rec."Leaves Used"
                                            ELSE
                                                DeductLeaves := rec."Leaves Available";
                                            MA2.INIT;
                                            MA2.RESET;
                                            MA2.SETRANGE("Employee Code", rec."Employee Code");
                                            MA2.SETRANGE("Pay Slip Month", rec."Pay Slip Month");
                                            MA2.SETRANGE(Year, rec.Year);
                                            IF MA2.FIND('-') THEN BEGIN
                                                MA2."Leaves Availabe" := rec."Leaves Available";
                                                MA2.VALIDATE("Loss Of Pay", rec."Loss Of Pay");
                                                MA2."No.Of Payroll Days" := rec."No.Of Payroll Days";
                                                MA2.MODIFY;
                                            END;

                                            rec.CALCFIELDS(Days, Attendance, Leaves, "No.of Days Count", LossOFpayCount, LeavesUsedForcasualLeaves);
                                            // MA2.TRANSFERFIELDS(Rec);
                                        END;

                                    UpdateLeaveEntitl(Rec);

                                    Employee.GenerateLeavesForNewEmp(Rec);
                                END;
                                MA2.INIT;
                                MA2.RESET;
                                MA2.SETRANGE("Employee Code", rec."Employee Code");
                                MA2.SETRANGE("Pay Slip Month", rec."Pay Slip Month");
                                MA2.SETRANGE(Year, rec.Year);
                                IF MA2.FIND('-') THEN BEGIN

                                    Ma3.INIT;
                                    Ma3.RESET;
                                    Ma3.SETRANGE("Employee Code", rec."Employee Code");
                                    Ma3.SETRANGE("Pay Slip Month", rec."Pay Slip Month");
                                    Ma3.SETRANGE(Year, rec.Year);
                                    IF Ma3.FIND('-') THEN BEGIN
                                        Ma3.TRANSFERFIELDS(MA2);
                                        Ma3.MODIFY;
                                    END;
                                END
                                UNTIL NEXT = 0;

                            Window.OPEN(Text007);
                            MonAttendance2.SETCURRENTKEY("Employee Code", "Pay Slip Month", Year);
                            MonAttendance2.SETRANGE("Pay Slip Month", CurrentMonth);
                            MonAttendance2.SETRANGE(Year, CurrentYear);
                            MonAttendance2.SETRANGE(Blocked, FALSE);
                            MonAttendance2.SETRANGE(Processed, FALSE);
                            IF EmpLoc <> '' THEN BEGIN
                                MonAttendance2.CALCFIELDS("Emp Location");
                                MonAttendance2.SETRANGE("Emp Location", EmpLoc);
                            END;
                            IF MonAttendance2.FIND('-') THEN BEGIN
                                REPEAT
                                    ProcessedSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                                    ProcessedSalary.SETRANGE("Employee Code", MonAttendance2."Employee Code");
                                    ProcessedSalary.SETRANGE("Pay Slip Month", MonAttendance2."Pay Slip Month");
                                    ProcessedSalary.SETRANGE(Year, MonAttendance2.Year);
                                    IF ProcessedSalary.FIND('-') THEN
                                        ProcessedSalary.DELETEALL;
                                    Window.UPDATE(1, MonAttendance2."Employee Code");

                                    SalaryProcess.ProcessSalary(MonAttendance2);
                                    SalaryProcess.DeductionPriority(MonAttendance2);
                                    MA2.INIT;
                                    MA2.RESET;
                                    MA2.SETRANGE("Employee Code", MonAttendance2."Employee Code");
                                    MA2.SETRANGE("Pay Slip Month", MonAttendance2."Pay Slip Month");
                                    MA2.SETRANGE(Year, MonAttendance2.Year);
                                    IF MA2.FIND('-') THEN BEGIN
                                        Rec.TRANSFERFIELDS(MA2);
                                    END;

                                    Ma3.RESET;
                                    Ma3.SETRANGE("Employee Code", MonAttendance2."Employee Code");
                                    Ma3.SETRANGE("Pay Slip Month", MonAttendance2."Pay Slip Month");
                                    Ma3.SETRANGE(Year, MonAttendance2.Year);
                                    IF Ma3.FIND('-') THEN BEGIN
                                        Ma3.TRANSFERFIELDS(MA2);
                                        Ma3.MODIFY;
                                    END;

                                UNTIL MonAttendance2.NEXT = 0;
                                MESSAGE(Text001);
                            END;
                            MA2.DELETEALL;
                            IF PayElement.FIND('-') THEN
                                REPEAT
                                    PayElement.Processed := FALSE;
                                    PayElement.MODIFY;
                                UNTIL PayElement.NEXT = 0;
                            Window.CLOSE;


                            //VE-026>>

                        end;
                    }
                }
                group(Reprocess)
                {
                    Caption = 'Reprocess';
                    action("&Current EmployeeR")
                    {
                        Caption = '&Current Employee';
                        Ellipsis = true;
                        Promoted = true;
                        PromotedIsBig = true;
                        ApplicationArea = all;
                        trigger OnAction()
                        begin
                            MA2.INIT;
                            IF MA2.FIND('-') THEN
                                MA2.DELETEALL;

                            //VE-026>>
                            IF NOT rec.Blocked THEN
                                IF NOT rec.Posted THEN BEGIN
                                    rec.Probationleaves := AddingProbationLeaves(Rec);
                                    rec.CALCFIELDS(Days, Attendance, Leaves, "No.of Days Count", LossOFpayCount, LeavesUsedForcasualLeaves);
                                    MA2.TRANSFERFIELDS(Rec);
                                    MA2.Days := rec.Days;
                                    MA2.Attendance := rec.Attendance;
                                    MA2.Leaves := rec.Leaves;
                                    MA2."No.of Days Count" := rec."No.of Days Count";
                                    MA2.LossOFpayCount := rec.LossOFpayCount;
                                    MA2.LeavesUsedForcasualLeaves := rec.LeavesUsedForcasualLeaves;


                                    rec."Leaves Used" := (rec."Leave Cut For LateHrs" + rec.Leaves) - (rec.LossOFpayCount);
                                    MA2."Leaves Used" := rec."Leaves Used";
                                    COMMIT;
                                    //"Updating Earned leaves"(Rec);
                                    "Updating Earned leaves"(MA2);
                                    MA2.INSERT;
                                    MA2.CALCFIELDS(Days, Attendance, Leaves, "No.of Days Count", LossOFpayCount, LeavesUsedForcasualLeaves);
                                    rec."LeavesAvl.ForEL" := MA2."LeavesAvl.ForEL";
                                    Rec.TRANSFERFIELDS(MA2);


                                    LateLeaves := Employee.CheckLeavesToUse(Rec);
                                    Monthly.INIT;
                                    Monthly.SETRANGE("Employee Code", rec."Employee Code");
                                    Monthly.SETRANGE("Pay Slip Month", (rec."Pay Slip Month" - 1));
                                    Monthly.SETRANGE(Year, rec.Year);
                                    IF Monthly.FIND('-') THEN
                                        PRLEaves := Monthly.Probationleaves;
                                    Emp1.RESET;
                                    Emp1.SETRANGE("No.", rec."Employee Code");
                                    IF Emp1.FIND('-') THEN BEGIN
                                        Prob := Emp1.Probation;
                                        probdate := CALCDATE(Employee1."Probn.Duration", Employee1."Employment Date");
                                        probyear1 := DATE2DMY(probdate, 3);
                                    END;
                                    IF probyear1 <= rec.Year THEN BEGIN

                                        IF (rec."Pay Slip Month" >= Mon) AND (Prob = FALSE) AND (NOT Emp1.ProbLeavesAdded) THEN BEGIN
                                            rec."Leaves Available" := emp.GetLeaves1(Rec);//+PRLEaves;
                                            rec.TotalLeavesAvailable := emp.GetLeaves(Rec);//+PRLEaves;
                                            rec.VALIDATE("Leaves Remaing", rec."Leaves Available" - (rec.LeavesUsedForcasualLeaves + "Leave Cut For LateHrs"));
                                            rec.Probationleaves := 0;
                                            LeaveEn.CLLeavesToAddAfterProbation := 0;
                                            Emp1.ProbLeavesAdded := TRUE;
                                            Emp1.MODIFY;

                                        END ELSE BEGIN
                                            rec."Leaves Available" := emp.GetLeaves1(Rec);
                                        END;
                                    END ELSE
                                        rec."Leaves Available" := emp.GetLeaves1(Rec);

                                    rec.VALIDATE("Leaves Remaing", rec."Leaves Available" - rec.LeavesUsedForcasualLeaves);
                                    rec."Leaves Added" := Employee.NoOfLeavesAssig(rec."Employee Code");
                                    MA2.INIT;
                                    MA2.SETRANGE("Employee Code", rec."Employee Code");
                                    MA2.SETRANGE("Pay Slip Month", rec."Pay Slip Month");
                                    MA2.SETRANGE(Year, rec.Year);
                                    IF MA2.FIND('-') THEN BEGIN
                                        MA2."Leaves Availabe" := rec."Leaves Available";
                                        MA2.VALIDATE("Leaves Remaing", rec."Leaves Remaing");
                                        MA2."Leaves Added" := rec."Leaves Added";
                                        //MA2.LateLeaves:=LateLeaves;
                                        MA2.MODIFY;
                                    END;
                                    /*Employee.RESET;
                                    Employee.SETRANGE("No.","Employee Code");
                                     IF Employee.FIND('-') THEN BEGIN
                                        IF ( Employee."Employment Date" > DMY2DATE(1,"Pay Slip Month",Year)) THEN
                                          "No.Of Payroll Days":="No.of Days Count" - (LateLeaves + LossOFpayCount)
                                        ELSE
                                          "No.Of Payroll Days":= Days - (LateLeaves + LossOFpayCount);
                                    END;
                                     "No.Of Payroll Days":= Days - (LateLeaves + LossOFpayCount);
                                     "Loss Of Pay" := Days - "No.Of Payroll Days";
                                     */
                                    rec."No.Of Payroll Days" := Days - (LateLeaves + rec.LossOFpayCount);
                                    NoOfDaysInMonth(CurrentMonth, CurrentYear);
                                    IF rec.Days < DaysInMon THEN BEGIN
                                        rec."Loss Of Pay" := DaysInMon - rec."No.Of Payroll Days";
                                    END ELSE BEGIN
                                        rec."Loss Of Pay" := rec.Days - rec."No.Of Payroll Days";
                                    END;


                                    CLEAR(DeductLeaves);
                                    IF rec."Leaves Available" >= rec."Leaves Used" THEN
                                        DeductLeaves := rec."Leaves Used"
                                    ELSE
                                        DeductLeaves := rec."Leaves Available";
                                    MA2.INIT;
                                    MA2.SETRANGE("Employee Code", rec."Employee Code");
                                    MA2.SETRANGE("Pay Slip Month", rec."Pay Slip Month");
                                    MA2.SETRANGE(Year, rec.Year);
                                    IF MA2.FIND('-') THEN BEGIN
                                        MA2."Leaves Availabe" := rec."Leaves Available";
                                        MA2.VALIDATE("Loss Of Pay", rec."Loss Of Pay");
                                        MA2."No.Of Payroll Days" := rec."No.Of Payroll Days";
                                        MA2.MODIFY;
                                    END;
                                    rec.CALCFIELDS(Days, Attendance, Leaves, "No.of Days Count", LossOFpayCount, LeavesUsedForcasualLeaves);
                                    UpdateLeaveEntitl(Rec);
                                    Employee.GenerateLeavesForNewEmp(Rec);

                                END;

                            IF NOT Blocked THEN
                                IF NOT Posted THEN BEGIN
                                    ProcessedSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                                    ProcessedSalary.SETRANGE("Employee Code", "Employee Code");
                                    ProcessedSalary.SETRANGE("Pay Slip Month", "Pay Slip Month");
                                    ProcessedSalary.SETRANGE(Year, Year);
                                    IF ProcessedSalary.FIND('-') THEN
                                        ProcessedSalary.DELETEALL;
                                    COMMIT;
                                    CALCFIELDS(Days, Attendance, Leaves, "No.of Days Count", LossOFpayCount, LeavesUsedForcasualLeaves);
                                    CheckLoans(Rec);
                                    SalaryProcess.ProcessSalary(Rec);
                                    SalaryProcess.DeductionPriority(Rec);
                                    SalaryProcess.RoundtheAmount(Rec);
                                    MA2.INIT;
                                    MA2.SETRANGE("Employee Code", "Employee Code");
                                    MA2.SETRANGE("Pay Slip Month", "Pay Slip Month");
                                    MA2.SETRANGE(Year, Year);
                                    IF MA2.FIND('-') THEN BEGIN

                                        MA2.Processed := TRUE;
                                        MA2."Processing Date" := TODAY;
                                        MA2."Net Salary" := "Net Salary";//Additions - Deductions;
                                        MA2."Remaining Amount" := "Remaining Amount";//Additions - Deductions;
                                        MA2.MODIFY;
                                    END;
                                    Rec.TRANSFERFIELDS(MA2);
                                    Ma3.INIT;
                                    Ma3.SETRANGE("Employee Code", "Employee Code");
                                    Ma3.SETRANGE("Pay Slip Month", "Pay Slip Month");
                                    Ma3.SETRANGE(Year, Year);
                                    IF Ma3.FIND('-') THEN BEGIN
                                        Ma3.TRANSFERFIELDS(MA2);
                                        Ma3.MODIFY;
                                    END;
                                    MESSAGE(Text004);
                                END ELSE
                                    ERROR(Text006);

                            PayElement.RESET;
                            PayElement.SETRANGE("Employee Code", "Employee Code");

                            IF PayElement.FIND('-') THEN
                                REPEAT
                                    PayElement.Processed := FALSE;
                                    PayElement.MODIFY;
                                UNTIL PayElement.NEXT = 0;
                            MA2.DELETEALL;
                            //VE-026<<

                        end;
                    }
                    action("&All Employees2")
                    {
                        Caption = '&All Employees';
                        Ellipsis = true;
                        Promoted = true;
                        PromotedIsBig = true;
                        ApplicationArea = all;
                        trigger OnAction()
                        begin
                            MA2.INIT;
                            IF MA2.FIND('-') THEN
                                MA2.DELETEALL;

                            IF EmpLoc <> '' THEN BEGIN
                                CALCFIELDS("Emp Location");
                                SETRANGE("Emp Location", EmpLoc);
                            END;
                            //VE-026>>

                            IF FIND('-') THEN
                                REPEAT
                                BEGIN
                                    Probationleaves := AddingProbationLeaves(Rec);
                                    IF NOT Blocked THEN
                                        IF NOT Posted THEN BEGIN
                                            CALCFIELDS(Days, Attendance, Leaves, "No.of Days Count", LossOFpayCount, LeavesUsedForcasualLeaves);
                                            MA2.TRANSFERFIELDS(Rec);
                                            MA2.Days := Days;
                                            MA2.Attendance := Attendance;
                                            MA2.Leaves := Leaves;
                                            MA2."No.of Days Count" := "No.of Days Count";
                                            MA2.LossOFpayCount := LossOFpayCount;
                                            MA2.LeavesUsedForcasualLeaves := LeavesUsedForcasualLeaves;


                                            "Leaves Used" := ("Leave Cut For LateHrs" + Leaves) - (LossOFpayCount);
                                            MA2."Leaves Used" := "Leaves Used";


                                            COMMIT;
                                            //"Updating Earned leaves"(Rec);
                                            "Updating Earned leaves"(MA2);
                                            MA2.INSERT;
                                            MA2.CALCFIELDS(Days, Attendance, Leaves, "No.of Days Count", LossOFpayCount, LeavesUsedForcasualLeaves);
                                            "LeavesAvl.ForEL" := MA2."LeavesAvl.ForEL";
                                            Rec.TRANSFERFIELDS(MA2);

                                            //MA1.INSERT;

                                            LateLeaves := Employee.CheckLeavesToUse(Rec);
                                            Monthly.INIT;
                                            Monthly.SETRANGE("Employee Code", "Employee Code");
                                            Monthly.SETRANGE("Pay Slip Month", ("Pay Slip Month" - 1));
                                            Monthly.SETRANGE(Year, Year);
                                            IF Monthly.FIND('-') THEN
                                                PRLEaves := Monthly.Probationleaves;
                                            Emp1.RESET;
                                            Emp1.SETRANGE("No.", "Employee Code");
                                            IF Emp1.FIND('-') THEN BEGIN
                                                Prob := Emp1.Probation;
                                                probdate := CALCDATE(Employee1."Probn.Duration", Employee1."Employment Date");
                                                probyear1 := DATE2DMY(probdate, 3);
                                            END;
                                            IF probyear1 <= Year THEN BEGIN

                                                IF ("Pay Slip Month" >= Mon) AND (Prob = FALSE) AND (NOT Emp1.ProbLeavesAdded) THEN BEGIN
                                                    "Leaves Available" := emp.GetLeaves1(Rec);//+PRLEaves;
                                                    TotalLeavesAvailable := emp.GetLeaves(Rec);//+PRLEaves;

                                                    VALIDATE("Leaves Remaing", "Leaves Available" - (LeavesUsedForcasualLeaves + "Leave Cut For LateHrs"));
                                                    Probationleaves := 0;
                                                    LeaveEn.CLLeavesToAddAfterProbation := 0;
                                                    Emp1.ProbLeavesAdded := TRUE;
                                                    Emp1.MODIFY;

                                                END ELSE BEGIN
                                                    "Leaves Available" := emp.GetLeaves1(Rec);
                                                END;
                                            END ELSE
                                                "Leaves Available" := emp.GetLeaves1(Rec);


                                            VALIDATE("Leaves Remaing", "Leaves Available" - LeavesUsedForcasualLeaves);
                                            "Leaves Added" := Employee.NoOfLeavesAssig("Employee Code");
                                            MA2.INIT;
                                            MA2.RESET;
                                            MA2.SETRANGE("Employee Code", "Employee Code");
                                            MA2.SETRANGE("Pay Slip Month", "Pay Slip Month");
                                            MA2.SETRANGE(Year, Year);
                                            IF MA2.FIND('-') THEN BEGIN
                                                MA2."Leaves Availabe" := "Leaves Available";
                                                MA2.VALIDATE("Leaves Remaing", "Leaves Remaing");
                                                MA2."Leaves Added" := "Leaves Added";
                                                //MA2.LateLeaves:=LateLeaves;
                                                MA2.MODIFY;
                                            END;
                                            /*Employee.RESET;
                                            Employee.SETRANGE("No.","Employee Code");
                                            IF Employee.FIND('-') THEN
                                             BEGIN
                                               IF ( Employee."Employment Date" > DMY2DATE(1,"Pay Slip Month",Year)) THEN
                                                 "No.Of Payroll Days":="No.of Days Count" - ( LateLeaves + LossOFpayCount)
                                               ELSE
                                                 "No.Of Payroll Days":= Days - ( LateLeaves + LossOFpayCount);
                                             END;
                                              "No.Of Payroll Days":= Days - (LateLeaves + LossOFpayCount);
                                              "Loss Of Pay" := Days - "No.Of Payroll Days";
                                             */
                                            "No.Of Payroll Days" := Days - (LateLeaves + LossOFpayCount);
                                            NoOfDaysInMonth(CurrentMonth, CurrentYear);
                                            IF Days < DaysInMon THEN BEGIN
                                                "Loss Of Pay" := DaysInMon - "No.Of Payroll Days";
                                            END ELSE BEGIN
                                                "Loss Of Pay" := Days - "No.Of Payroll Days";
                                            END;

                                        END;

                                    CLEAR(DeductLeaves);
                                    IF "Leaves Available" >= "Leaves Used" THEN
                                        DeductLeaves := "Leaves Used"
                                    ELSE
                                        DeductLeaves := "Leaves Available";
                                    MA2.INIT;
                                    MA2.RESET;
                                    MA2.SETRANGE("Employee Code", "Employee Code");
                                    MA2.SETRANGE("Pay Slip Month", "Pay Slip Month");
                                    MA2.SETRANGE(Year, Year);
                                    IF MA2.FIND('-') THEN BEGIN
                                        MA2."Leaves Availabe" := "Leaves Available";
                                        MA2.VALIDATE("Loss Of Pay", "Loss Of Pay");
                                        MA2."No.Of Payroll Days" := "No.Of Payroll Days";
                                        MA2.MODIFY;
                                    END;

                                    CALCFIELDS(Days, Attendance, Leaves, "No.of Days Count", LossOFpayCount, LeavesUsedForcasualLeaves);
                                    // MA2.TRANSFERFIELDS(Rec);

                                    UpdateLeaveEntitl(Rec);
                                    Employee.GenerateLeavesForNewEmp(Rec);
                                END;
                                MA2.INIT;
                                MA2.RESET;
                                MA2.SETRANGE("Employee Code", "Employee Code");
                                MA2.SETRANGE("Pay Slip Month", "Pay Slip Month");
                                MA2.SETRANGE(Year, Year);
                                IF MA2.FIND('-') THEN;

                                Ma3.INIT;
                                Ma3.RESET;
                                Ma3.SETRANGE("Employee Code", "Employee Code");
                                Ma3.SETRANGE("Pay Slip Month", "Pay Slip Month");
                                Ma3.SETRANGE(Year, Year);
                                IF Ma3.FIND('-') THEN BEGIN
                                    Ma3.TRANSFERFIELDS(MA2);
                                    Ma3.MODIFY;
                                END;

                                UNTIL NEXT = 0;

                            Window.OPEN(Text007);
                            MonAttendance2.RESET;
                            MonAttendance2.SETRANGE("Pay Slip Month", CurrentMonth);
                            MonAttendance2.SETRANGE(Year, CurrentYear);
                            MonAttendance2.SETRANGE(Posted, FALSE);
                            MonAttendance2.SETRANGE(Blocked, FALSE);
                            IF EmpLoc <> '' THEN BEGIN
                                MonAttendance2.CALCFIELDS("Emp Location");
                                MonAttendance2.SETRANGE("Emp Location", EmpLoc);
                            END;

                            IF MonAttendance2.FIND('-') THEN BEGIN
                                REPEAT
                                    ProcessedSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                                    ProcessedSalary.SETRANGE("Employee Code", MonAttendance2."Employee Code");
                                    ProcessedSalary.SETRANGE("Pay Slip Month", MonAttendance2."Pay Slip Month");
                                    ProcessedSalary.SETRANGE(Year, MonAttendance2.Year);
                                    IF ProcessedSalary.FIND('-') THEN
                                        ProcessedSalary.DELETEALL;

                                    CheckLoans(MonAttendance2);
                                    Window.UPDATE(1, MonAttendance2."Employee Code");
                                    SalaryProcess.ProcessSalary(MonAttendance2);
                                    SalaryProcess.DeductionPriority(MonAttendance2);
                                    SalaryProcess.RoundtheAmount(MonAttendance2);
                                    MA2.INIT;
                                    MA2.RESET;
                                    MA2.SETRANGE("Employee Code", MonAttendance2."Employee Code");
                                    MA2.SETRANGE("Pay Slip Month", MonAttendance2."Pay Slip Month");
                                    MA2.SETRANGE(Year, MonAttendance2.Year);
                                    IF MA2.FIND('-') THEN BEGIN
                                        MA2.MODIFY;
                                        Rec.TRANSFERFIELDS(MA2);
                                    END;

                                    Ma3.INIT;
                                    Ma3.RESET;
                                    Ma3.SETRANGE("Employee Code", MonAttendance2."Employee Code");
                                    Ma3.SETRANGE("Pay Slip Month", MonAttendance2."Pay Slip Month");
                                    Ma3.SETRANGE(Year, MonAttendance2.Year);
                                    IF Ma3.FIND('-') THEN BEGIN
                                        Ma3.TRANSFERFIELDS(MA2);
                                        Ma3.MODIFY;
                                    END;
                                UNTIL MonAttendance2.NEXT = 0;
                                MESSAGE(Text004);
                            END;


                            IF PayElement.FIND('-') THEN
                                REPEAT
                                    PayElement.Processed := FALSE;
                                    PayElement.MODIFY;
                                UNTIL PayElement.NEXT = 0;
                            Window.CLOSE;
                            //VE-026<<

                            MA2.DELETEALL;

                        end;
                    }
                }
                action("Process &Attendance")
                {
                    Caption = 'Process &Attendance';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        Window: Dialog;
                        Text000: Label 'Employee #1########################\';
                    begin
                        Window.OPEN(Text000);
                        DailyAttendance.SETRANGE(Year, CurrentYear);
                        DailyAttendance.SETRANGE(Month, CurrentMonth);
                        IF DailyAttendance.FIND('-') THEN
                            REPEAT
                                Window.UPDATE(1, DailyAttendance."Employee No.");
                                AttendanceProcess.UpdateLeaves(DailyAttendance);
                                LeaveApplication.SETRANGE(Month, DailyAttendance.Month);
                                LeaveApplication.SETRANGE(Year, DailyAttendance.Year);
                                LeaveApplication.SETRANGE("Employee No.", DailyAttendance."Employee No.");
                                IF LeaveApplication.FIND('-') THEN BEGIN
                                    LeaveApplication.Processed := TRUE;
                                    LeaveApplication.MODIFY;
                                END;
                            UNTIL DailyAttendance.NEXT = 0;

                        // CLEAR(UpdateLeaves);
                        //UpdateLeaves.RUNMODAL;
                        Window.CLOSE;
                    end;
                }
                action("&Post Salary")
                {
                    Caption = '&Post Salary';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        //Update Dimension
                        MonAttendance.RESET;
                        MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
                        MonAttendance.SETRANGE(Year, CurrentYear);
                        REPORT.RUNMODAL(60016, FALSE, FALSE, MonAttendance);

                        //Salary Post
                        IF NOT Blocked THEN
                            SalaryPost;

                        //Run Payroll Journal
                        PayrollJnlForm.MonthAttVar(TRUE);
                        //FORM.RUN(60091);
                    end;
                }
                action("&Run Payroll Journal")
                {
                    ApplicationArea = all;
                    Caption = '&Run Payroll Journal';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        PayrollJnlForm.MonthAttVar(TRUE);
                        PAGE.RUN(60091);
                    end;
                }
                action("Leave Salarya")
                {
                    ApplicationArea = all;
                    Caption = 'Leave Salary';
                    Ellipsis = true;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ProcSalary: Record 60038;
                        RoundType: Text[30];
                        PayElements: Record 60025;
                        StartDate: Date;
                        EndDate: Date;
                        RevisiedPayElements: Record 60025;
                        RevisiedDate: Date;
                    begin


                        IF FIND('-') THEN
                            REPEAT
                                RevisiedPayElements.RESET;
                                RevisiedPayElements.SETCURRENTKEY("Effective Start Date");
                                RevisiedPayElements.SETRANGE("Employee Code", "Employee Code");
                                RevisiedPayElements.SETFILTER("Effective Start Date", '<=%1', "Period End Date");
                                IF RevisiedPayElements.FIND('+') THEN BEGIN
                                    RevisiedDate := RevisiedPayElements."Effective Start Date";
                                END;

                                IF Processed = TRUE THEN BEGIN
                                    PayElements.RESET;
                                    PayElements.SETCURRENTKEY("Employee Code", "Pay Element Code");
                                    PayElements.SETRANGE("Employee Code", "Employee Code");
                                    StartDate := "Period Start Date";
                                    EndDate := "Period End Date";
                                    PayElements.SETRANGE("Effective Start Date", RevisiedDate);
                                    IF PayElements.FIND('-') THEN
                                        REPEAT
                                            // IF (PayElements."Effective Start Date" > StartDate) AND (PayElements."Effective Start Date" <= EndDate) THEN  BEGIN
                                            ProcSalary.INIT;
                                            ProcSalary."Employee Code" := PayElements."Employee Code";
                                            ProcSalary."Add/Deduct Code" := PayElements."Pay Element Code";
                                            ProcSalary."Pay Slip Month" := "Pay Slip Month";
                                            ProcSalary.Year := Year;
                                            ProcSalary."Document Type" := ProcSalary."Document Type"::Payroll;

                                            ProcessedSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                                            ProcessedSalary.SETRANGE("Employee Code", ProcSalary."Employee Code");
                                            ProcessedSalary.SETRANGE("Pay Slip Month", ProcSalary."Pay Slip Month");
                                            ProcessedSalary.SETRANGE(Year, ProcSalary.Year);
                                            IF ProcessedSalary.FIND('+') THEN
                                                ProcSalary."Line No." := ProcessedSalary."Line No." + 10000
                                            ELSE
                                                ProcSalary."Line No." := 10000;

                                            HRSetup.FIND('-');
                                            IF HRSetup."Rounding Type" = HRSetup."Rounding Type"::Up THEN
                                                RoundType := '>'
                                            ELSE
                                                IF HRSetup."Rounding Type" = HRSetup."Rounding Type"::Down THEN
                                                    RoundType := '<'
                                                ELSE
                                                    RoundType := '=';

                                            ProcSalary."Fixed/Percent" := PayElements."Fixed/Percent";
                                            ProcSalary."Computation Type" := PayElements."Computation Type";
                                            ProcSalary."Loan Priority No" := PayElements."Loan Priority No";
                                            ProcSalary."Earned Amount" := ROUND(PayElements."Amount / Percent", HRSetup."Rounding Precision", RoundType);
                                            ProcSalary."Add/Deduct" := PayElements."Add/Deduct";
                                            ProcSalary.Attendance := MonAttendance.Attendance;
                                            ProcSalary.Days := MonAttendance.Days;

                                            Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                                            Lookup.SETRANGE("Lookup Name", ProcSalary."Add/Deduct Code");
                                            //IF Lookup.FIND('-') THEN
                                            //  ProcSalary.Priority := Lookup.Priority;

                                            ProcSalary.INSERT;

                                        UNTIL PayElements.NEXT = 0;
                                END ELSE BEGIN
                                    PayElements.RESET;
                                    PayElements.SETCURRENTKEY("Employee Code", "Pay Element Code");
                                    PayElements.SETRANGE("Employee Code", "Employee Code");
                                    StartDate := "Period Start Date";
                                    EndDate := "Period End Date";
                                    PayElements.SETRANGE("Effective Start Date", RevisiedDate);
                                    IF PayElements.FIND('-') THEN
                                        REPEAT
                                            // IF (PayElements."Effective Start Date" > StartDate) AND (PayElements."Effective Start Date" <= EndDate) THEN  BEGIN
                                            ProcSalary.INIT;
                                            ProcSalary."Employee Code" := PayElements."Employee Code";
                                            ProcSalary."Add/Deduct Code" := PayElements."Pay Element Code";
                                            ProcSalary."Pay Slip Month" := "Pay Slip Month";
                                            ProcSalary.Year := Year;
                                            ProcSalary."Document Type" := ProcSalary."Document Type"::Payroll;

                                            ProcessedSalary.SETRANGE("Document Type", ProcessedSalary."Document Type"::Payroll);
                                            ProcessedSalary.SETRANGE("Employee Code", ProcSalary."Employee Code");
                                            ProcessedSalary.SETRANGE("Pay Slip Month", ProcSalary."Pay Slip Month");
                                            ProcessedSalary.SETRANGE(Year, ProcSalary.Year);
                                            IF ProcessedSalary.FIND('+') THEN
                                                ProcSalary."Line No." := ProcessedSalary."Line No." + 10000
                                            ELSE
                                                ProcSalary."Line No." := 10000;

                                            HRSetup.FIND('-');
                                            IF HRSetup."Rounding Type" = HRSetup."Rounding Type"::Up THEN
                                                RoundType := '>'
                                            ELSE
                                                IF HRSetup."Rounding Type" = HRSetup."Rounding Type"::Down THEN
                                                    RoundType := '<'
                                                ELSE
                                                    RoundType := '=';

                                            ProcSalary."Fixed/Percent" := PayElements."Fixed/Percent";
                                            ProcSalary."Computation Type" := PayElements."Computation Type";
                                            ProcSalary."Loan Priority No" := PayElements."Loan Priority No";
                                            ProcSalary."Earned Amount" := ROUND(PayElements."Amount / Percent", HRSetup."Rounding Precision", RoundType);
                                            ProcSalary."Add/Deduct" := PayElements."Add/Deduct";
                                            ProcSalary.Attendance := MonAttendance.Attendance;
                                            ProcSalary.Days := MonAttendance.Days;

                                            Lookup.SETRANGE("LookupType Name", 'ADDITIONS AND DEDUCTIONS');
                                            Lookup.SETRANGE("Lookup Name", ProcSalary."Add/Deduct Code");
                                            //IF Lookup.FIND('-') THEN
                                            //  ProcSalary.Priority := Lookup.Priority;

                                            ProcSalary.INSERT;

                                        UNTIL PayElements.NEXT = 0;
                                END;
                            UNTIL NEXT = 0;

                        "Net Salary" := "Gross Salary" - Deductions;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

        IF HRSetup.FIND('-') THEN BEGIN
            CurrentYear := HRSetup."Salary Processing Year";
            CurrentMonth := HRSetup."Salary Processing month";
        END;

        SelectYear;
        SelectMonth;
        SelectPayCadre;
    end;

    var
        Lookup: Record 60018;
        HRSetup: Record 60016;
        Employee: Record 60019;
        EmpPostingGroup: Record 60056;
        Navigate: Record "60029";
        MonAttendance2: Record 60029;
        Text001: Label 'Processing is Completed.';
        DailyAttendance: Record 60028;
        Text002: Label 'There are no records with in these filters.';
        PayElement: Record 60025;
        ProcessedSalary: Record 60038;
        LeaveApplication: Record 60032;
        //UpdateLeaves: Report 60000;
        SalaryProcess: Codeunit 60008;
        AttendanceProcess: Codeunit 60005;
        CurrentCadre: Code[30];
        Month: Integer;
        Year: Integer;
        CurrentMonth: Integer;
        CurrentYear: Integer;
        Text003: Label 'Attendance Processing is Completed.';
        StartingDate: Date;
        EndingDate: Date;
        ShowAll: Boolean;
        Window: Dialog;
        "-------Postings-------": Integer;
        NoSeries: Record 308;
        JournalTemplate: Record 80;
        JournalBatch: Record 232;
        MonAttendance: Record 60029;
        NoSeriesMgt: Codeunit 396;
        PayrollProcess: Codeunit 60018;
        TempBatch: Code[20];
        TempJournal: Code[20];
        "DocNo.": Code[20];
        Text004: Label 'Re Processing is Completed.';
        PostDate: Date;
        Text005: Label 'Salary Posted.';
        Text006: Label 'Posted records shouldn''t allowed to reprocess.';
        Text007: Label 'Employee No..... #1######################\ ';
        LastNoSeriseNo: Code[20];
        Answer: Boolean;
        Text008: Label 'Do you want to Post';
        Text009: Label 'All employees are not posted, still you want to update the Processing month and year.';
        ID: Integer;
        MonthlyAtten: Record 60029;
        emp: Record 60019;
        LeaveEnti: Record 60031;
        LeavesAval: Decimal;
        LateEntryLeaves: Record 60003;
        LateLeaves: Decimal;
        DeductLeaves: Decimal;
        LeaveEntitle: Record 60031;
        LateLeaves1: Decimal;
        DeductLeaves1: Decimal;
        LeavesAval1: Decimal;
        PL: Date;
        Mon: Integer;
        yer: Integer;
        Employee1: Record 60019;
        Durationperiod: Integer;
        LeaveEn: Record 60031;
        PROBATIONLeave: Decimal;
        LeaveEn1: Record 60031;
        Monthly: Record 60029;
        PRLEaves: Decimal;
        Emp1: Record 60019;
        Prob: Boolean;
        ELLeaves: Text[30];
        Elleave: Integer;
        s: Integer;
        MonthlyAttend1: Record 60029;
        ELUsed: Decimal;
        ELDate: Date;
        DailyAtt1: Record 60028;
        ElComplete: Integer;
        Monthly1: Record 60029;
        DailyAtt2: Record 60028;
        Probyear: Integer;
        LeaveEntitle1: Record 60031;
        probyear1: Integer;
        probdate: Date;
        MonAtt3: Record 60029;
        ve026: Decimal;
        MA1: Record 60029 temporary;
        MA2: Record 60007;
        Ma3: Record 60029;
        l: Decimal;
        CompanyInfo: Record 79;
        DaysInMon: Integer;
        EmpLoc: Code[10];
        OperationType: Code[10];
        GenJnlLine: Record 81;
        //wscript: Automation;
        TmpEmp: Record 60019;
        PayrollJnlForm: Page 60113;

    //  [Scope('Internal')]
    procedure SelectYear()
    begin
        SETRANGE(Year, CurrentYear);
        SETRANGE(Blocked, FALSE);
        SETRANGE(Resigned, FALSE);
        SETRANGE("Reversal Entries", FALSE);
        CurrPage.UPDATE(FALSE);
    end;

    // [Scope('Internal')]
    procedure SelectMonth()
    begin
        SETRANGE("Pay Slip Month", CurrentMonth);
        SETRANGE(Blocked, FALSE);
        SETRANGE(Resigned, FALSE);
        SETRANGE("Reversal Entries", FALSE);
        CurrPage.UPDATE(FALSE);
    end;

    //  [Scope('Internal')]
    procedure SelectStartingDate()
    begin
    end;

    //  [Scope('Internal')]
    procedure SelectEndingDate()
    begin
    end;

    // [Scope('Internal')]
    procedure SelectPayCadre()
    begin
        SETRANGE(PayCadre, CurrentCadre);
        SETRANGE(Blocked, FALSE);
        SETRANGE("Reversal Entries", FALSE);
        CurrPage.UPDATE(FALSE);
    end;

    // [Scope('Internal')]
    procedure SelectLocation()
    begin
        SETRANGE("Emp Location", EmpLoc);
        SETRANGE(Blocked, FALSE);
        SETRANGE("Reversal Entries", FALSE);
        CurrPage.UPDATE(FALSE);
    end;

    // [Scope('Internal')]
    procedure SelectOperation()
    begin
        SETRANGE("Office Type", OperationType);
        SETRANGE(Blocked, FALSE);
        SETRANGE("Reversal Entries", FALSE);
        CurrPage.UPDATE(FALSE);
    end;

    // [Scope('Internal')]
    procedure CheckLoans(MonAttendance: Record 60029)
    var
        LoanDetails: Record 60040;
        Loan: Record 60039;
    begin
        LoanDetails.SETRANGE("Paid Month", MonAttendance."Pay Slip Month");
        LoanDetails.SETRANGE("Paid Year", MonAttendance.Year);
        LoanDetails.SETRANGE("Employee No.", MonAttendance."Employee Code");
        IF LoanDetails.FIND('-') THEN BEGIN
            REPEAT
                LoanDetails."Paid Month" := 0;
                LoanDetails."Paid Year" := 0;
                LoanDetails."EMI Deducted" := 0;
                IF LoanDetails."Loan Closed" THEN
                    LoanDetails."Loan Closed" := FALSE;
                LoanDetails.Balance := LoanDetails.Balance + LoanDetails."EMI Amount";
                LoanDetails.MODIFY;

                Loan.SETRANGE(Id, LoanDetails."Loan Id");
                Loan.SETRANGE("Employee Code", LoanDetails."Employee No.");
                Loan.SETRANGE("Loan Type", LoanDetails."Loan Code");
                IF Loan.FIND('-') THEN BEGIN
                    Loan."Loan Balance" := LoanDetails.Balance;
                    Loan."Effective Amount" := LoanDetails."EMI Amount";
                    IF Loan.Closed THEN
                        Loan.Closed := FALSE;
                    Loan.MODIFY;
                END;
            UNTIL LoanDetails.NEXT = 0;
        END;
    end;

    // [Scope('Internal')]
    procedure "----Postings----"()
    begin
    end;

    // [Scope('Internal')]
    procedure SalaryPost()
    var
        ProcessedSalary: Record 60038;
        Flag: Boolean;
        Update: Boolean;
    begin
        Answer := CONFIRM(Text008);
        IF Answer THEN BEGIN
            IF CurrentCadre = '' THEN BEGIN
                IF FIND('-') THEN
                    REPEAT
                        Employee.SETRANGE("No.", "Employee Code");
                        Employee.SETRANGE(Employee."Post to GL", TRUE); //VE-003
                        IF Employee.FIND('-') THEN BEGIN
                            Employee.TESTFIELD(Employee."Emp Posting Group");
                            Employee.TESTFIELD(Employee."Payroll Bus. Posting Group");
                        END;
                        EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
                        IF EmpPostingGroup.FIND('-') THEN BEGIN
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."Salary Payable Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."Arrear Salary Payable Acc.");
                            //EmpPostingGroup.TESTFIELD(EmpPostingGroup."Bonus Payable Acc.");


                        END;
                    UNTIL NEXT = 0;
            END ELSE BEGIN
                MonAttendance.SETRANGE(PayCadre, CurrentCadre);
                MonAttendance.SETRANGE("Post to GL", TRUE);
                IF MonAttendance.FIND('-') THEN
                    REPEAT
                        Employee.SETRANGE("No.", MonAttendance."Employee Code");
                        Employee.SETRANGE(Employee."Post to GL", TRUE); //VE-003

                        IF Employee.FIND('-') THEN BEGIN
                            Employee.TESTFIELD(Employee."Emp Posting Group");
                            Employee.TESTFIELD(Employee."Payroll Bus. Posting Group");
                        END;
                        EmpPostingGroup.SETRANGE(Code, Employee."Emp Posting Group");
                        IF EmpPostingGroup.FIND('-') THEN BEGIN
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."Salary Payable Acc.");
                            EmpPostingGroup.TESTFIELD(EmpPostingGroup."Arrear Salary Payable Acc.");
                            //EmpPostingGroup.TESTFIELD(EmpPostingGroup."Bonus Payable Acc.");

                        END;
                    UNTIL MonAttendance.NEXT = 0;
            END;

            IF CurrentCadre = '' THEN BEGIN
                Window.OPEN(Text007);
                MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
                MonAttendance.SETRANGE(Year, CurrentYear);
                MonAttendance.SETRANGE(Processed, TRUE);
                MonAttendance.SETFILTER(Posted, 'No');
                MonAttendance.SETRANGE("Post to GL", TRUE); //VE-003
                IF MonAttendance.FIND('-') THEN BEGIN
                    REPEAT
                        MonAttendance."Journal Batch Name" := TempBatch;
                        MonAttendance."Journal Template Name" := TempJournal;
                        MonAttendance."Document No." := "DocNo.";
                        MonAttendance."Posting Date" := PostDate;
                        MonAttendance.MODIFY;
                        PayrollProcess.ProcessPosting(MonAttendance);
                        Window.UPDATE(1, MonAttendance."Employee Code");
                        MonAttendance.Posted := TRUE;
                        MonAttendance.MODIFY;
                        ProcessedSalary.INIT;
                        ProcessedSalary.RESET;
                        ProcessedSalary.SETRANGE("Employee Code", MonAttendance."Employee Code");
                        ProcessedSalary.SETRANGE("Pay Slip Month", MonAttendance."Pay Slip Month");
                        ProcessedSalary.SETRANGE(ProcessedSalary.Year, MonAttendance.Year);
                        IF ProcessedSalary.FIND('-') THEN
                            REPEAT
                                ProcessedSalary.Posted := TRUE;
                                ProcessedSalary."Posting Date" := PostDate;
                                ProcessedSalary."Document No" := "DocNo."; //ve-026

                                ProcessedSalary.MODIFY;
                            UNTIL ProcessedSalary.NEXT = 0;

                    UNTIL MonAttendance.NEXT = 0;
                    "DocNo." := '';
                    //PayrollProcess.DeleteDim(MonAttendance);
                END;

                MonAttendance.RESET;
                MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
                MonAttendance.SETRANGE(Year, CurrentYear);
                MonAttendance.SETRANGE(Processed, TRUE);
                MonAttendance.SETRANGE("Post to GL", TRUE); //VE-003

                IF MonAttendance.FIND('-') THEN BEGIN
                    REPEAT
                        IF MonAttendance.Posted <> TRUE THEN
                            Flag := TRUE;
                    UNTIL MonAttendance.NEXT = 0;
                    IF NOT Flag THEN
                        MESSAGE(Text005);
                END;

                Window.CLOSE;

                SelectYear;
                SelectMonth;
            END ELSE BEGIN
                Window.OPEN(Text007);
                MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
                MonAttendance.SETRANGE(Year, CurrentYear);
                MonAttendance.SETRANGE(PayCadre, CurrentCadre);
                MonAttendance.SETRANGE(Processed, TRUE);
                MonAttendance.SETFILTER(Posted, 'No');
                MonAttendance.SETRANGE("Post to GL", TRUE); //VE-003

                IF MonAttendance.FIND('-') THEN BEGIN
                    REPEAT
                        MonAttendance."Journal Batch Name" := TempBatch;
                        MonAttendance."Journal Template Name" := TempJournal;
                        MonAttendance."Document No." := "DocNo.";
                        MonAttendance."Posting Date" := PostDate;
                        MonAttendance.MODIFY;
                        PayrollProcess.ProcessPosting(MonAttendance);
                        Window.UPDATE(1, MonAttendance."Employee Code");
                        MonAttendance.Posted := TRUE;
                        MonAttendance.MODIFY;

                        ProcessedSalary.RESET;
                        ProcessedSalary.SETRANGE("Employee Code", MonAttendance."Employee Code");
                        ProcessedSalary.SETRANGE("Pay Slip Month", MonAttendance."Pay Slip Month");
                        ProcessedSalary.SETRANGE(ProcessedSalary.Year, MonAttendance.Year);
                        IF ProcessedSalary.FIND('-') THEN
                            REPEAT
                                ProcessedSalary.Posted := TRUE;
                                ProcessedSalary."Posting Date" := PostDate;
                                ProcessedSalary."Document No" := "DocNo."; //ve-026
                                ProcessedSalary.MODIFY;
                            UNTIL ProcessedSalary.NEXT = 0;
                    UNTIL MonAttendance.NEXT = 0;
                    "DocNo." := '';
                    //PayrollProcess.DeleteDim(MonAttendance);
                END;

                MonAttendance.RESET;
                MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
                MonAttendance.SETRANGE(Year, CurrentYear);
                MonAttendance.SETRANGE(PayCadre, CurrentCadre);
                MonAttendance.SETRANGE(Processed, TRUE);
                MonAttendance.SETRANGE("Post to GL", TRUE); //VE-003

                IF MonAttendance.FIND('-') THEN BEGIN
                    REPEAT
                        IF MonAttendance.Posted <> TRUE THEN
                            Flag := TRUE;
                    UNTIL MonAttendance.NEXT = 0;
                    IF NOT Flag THEN
                        MESSAGE(Text005);
                END;

                Window.CLOSE;

                SelectYear;
                SelectMonth;
                SelectPayCadre;
            END;
            LastNoSeriseNo := NoSeriesMgt.GetNextNo(JournalBatch."No. Series", WORKDATE, FALSE);//kaps

            Update := TRUE;
            MonAttendance.RESET;
            MonAttendance.SETRANGE("Pay Slip Month", CurrentMonth);
            MonAttendance.SETRANGE(Year, CurrentYear);
            MonAttendance.SETRANGE("Post to GL", TRUE);
            IF MonAttendance.FIND('-') THEN
                REPEAT
                    IF MonAttendance.Posted = FALSE THEN
                        Update := FALSE
                UNTIL MonAttendance.NEXT = 0;
            IF NOT Update THEN BEGIN
                IF CONFIRM(Text009) THEN BEGIN
                    IF HRSetup.FIND('-') THEN
                        IF HRSetup."Salary Processing month" = 12 THEN BEGIN
                            HRSetup.VALIDATE("Salary Processing month", 1);
                            HRSetup."Salary Processing Year" := HRSetup."Salary Processing Year" + 1;
                            HRSetup.MODIFY;
                        END ELSE BEGIN
                            HRSetup."Salary Processing month" := HRSetup."Salary Processing month" + 1;
                            HRSetup.VALIDATE(HRSetup."Salary Processing month");
                            HRSetup."Salary Processing Year" := HRSetup."Salary Processing Year";
                            HRSetup.MODIFY;
                        END;
                END;
            END ELSE BEGIN
                IF HRSetup.FIND('-') THEN
                    IF HRSetup."Salary Processing month" = 12 THEN BEGIN
                        HRSetup.VALIDATE("Salary Processing month", 1);
                        HRSetup."Salary Processing Year" := HRSetup."Salary Processing Year" + 1;
                        HRSetup.MODIFY;
                    END ELSE BEGIN
                        HRSetup."Salary Processing month" := HRSetup."Salary Processing month" + 1;
                        HRSetup.VALIDATE(HRSetup."Salary Processing month");
                        HRSetup."Salary Processing Year" := HRSetup."Salary Processing Year";
                        HRSetup.MODIFY;
                    END;
            END;
        END;
    end;

    //  [Scope('Internal')]
    procedure EntryNoGen() EntryNo: Integer
    var
        LeaveEntitle1: Record 60031;
    begin
        IF LeaveEntitle1.COUNT = 0 THEN
            EntryNo := 1
        ELSE BEGIN
            IF LeaveEntitle1.FIND('+') THEN
                EntryNo := LeaveEntitle1."Entry No." + 1;
        END;
    end;

    // [Scope('Internal')]
    procedure UpdateLeaveEntitl(var MonthlyAttend: Record 60029)
    var
        LeaveEntitle1: Record 60031;
        DailyAtt: Record 60028;
    begin
        //VE-026>>
        LeaveEntitle1.INIT;
        LeaveEntitle1.SETRANGE("Employee No.", MonthlyAttend."Employee Code");
        LeaveEntitle1.SETRANGE(Year, MonthlyAttend.Year);
        LeaveEntitle1.SETRANGE(Month, MonthlyAttend."Pay Slip Month");
        IF LeaveEntitle1.FIND('-') THEN
            LeaveEntitle1.DELETEALL;
        //VE-026<<
    end;

    // [Scope('Internal')]
    procedure AddingProbationLeaves(var Monthlyatt1: Record 60029) Probleaves: Decimal
    begin
        //VE-026>>
        Employee1.INIT;
        Employee1.SETRANGE("No.", Monthlyatt1."Employee Code");
        IF Employee1.FIND('-') THEN BEGIN
            PL := CALCDATE(Employee1."Probn.Duration", Employee1."Employment Date");
            Mon := DATE2DMY(PL, 2);
        END;
        Probyear := DATE2DMY(PL, 3);
        IF (Probyear >= Monthlyatt1.Year) AND ("Pay Slip Month" < Mon) OR (Employee1.Probation) THEN BEGIN

            LeaveEn1.INIT;
            LeaveEn1.SETRANGE("Employee No.", Monthlyatt1."Employee Code");
            LeaveEn1.SETRANGE(Month, (Monthlyatt1."Pay Slip Month" - 1));
            IF LeaveEn1.FIND('-') THEN BEGIN
                PROBATIONLeave := LeaveEn1.CLLeavesToAddAfterProbation;
            END ELSE
                PROBATIONLeave := 0;

            Employee1.RESET;
            LeaveEn.INIT;
            Employee1.SETRANGE("No.", Monthlyatt1."Employee Code");
            IF Employee1.FIND('-') THEN
                IF (Employee1.Probation) THEN
                    LeaveEn.SETRANGE("Employee No.", Monthlyatt1."Employee Code");
            LeaveEn.SETRANGE(Month, Monthlyatt1."Pay Slip Month");
            IF LeaveEn.FIND('-') THEN BEGIN
                LeaveEn.CLLeavesToAddAfterProbation := PROBATIONLeave + 1;
                Probleaves := LeaveEn.CLLeavesToAddAfterProbation;
                LeaveEn.MODIFY;
            END
            ELSE BEGIN
                LeaveEn."Entry No." := EntryNoGen();
                LeaveEn.Month := Monthlyatt1."Pay Slip Month";
                LeaveEn.Year := Monthlyatt1.Year;
                LeaveEn."Leave Code" := 'CL';
                LeaveEn."Employee No." := Monthlyatt1."Employee Code";
                LeaveEn.Probation := TRUE;
                LeaveEn.CLLeavesToAddAfterProbation := PROBATIONLeave + 1;
                Probleaves := LeaveEn.CLLeavesToAddAfterProbation;
                LeaveEn.INSERT;
            END;
            EXIT(Probleaves);
        END;
        //VE-026<<
    end;

    // [Scope('Internal')]
    procedure "Updating Earned leaves"(var MonthlyAttend: Record 60007) Elleave: Decimal
    var
        LeaveEntitle1: Record 60031;
        DailyAtt: Record 60028;
        Emp: Record 60019;
        Date1: Date;
        Mon1: Integer;
        year1: Integer;
    begin
        //VE-026
        //Emp.INIT;
        Emp.RESET;
        Emp.SETRANGE("No.", MonthlyAttend."Employee Code");
        IF Emp.FIND('-') THEN
            Date1 := CALCDATE('1Y', Emp."Employment Date");
        year1 := DATE2DMY(Date1, 3);
        Mon1 := DATE2DMY(Date1, 2);
        IF year1 <= MonthlyAttend.Year THEN BEGIN
            IF year1 = MonthlyAttend.Year THEN BEGIN
                IF (Mon1 <= MonthlyAttend."Pay Slip Month") AND (NOT MonthlyAttend.Leavesaddedafteryear) THEN BEGIN
                    MonthlyAttend1.SETRANGE("Employee Code", MonthlyAttend."Employee Code");
                    MonthlyAttend1.SETRANGE(Year, MonthlyAttend.Year - 1);
                    IF MonthlyAttend1.FIND('+') THEN
                        MonthlyAttend1.CALCFIELDS("Total Present Days");
                    IF MonthlyAttend1."Total Present Days" > 240 THEN BEGIN
                        Elleave := 15;
                        AssigntheLeavesForel(MonthlyAttend, Elleave);
                    END ELSE BEGIN
                        IF MonthlyAttend1."Total Present Days" / 20 <> 0 THEN BEGIN
                            ELLeaves := FORMAT(MonthlyAttend1."Total Present Days" / 20);
                            IF MonthlyAttend1."Total Present Days" / 20 <> 0 THEN
                                IF STRPOS(ELLeaves, '.') = 0 THEN
                                    EVALUATE(Elleave, ELLeaves)
                                ELSE
                                    EVALUATE(Elleave, COPYSTR(ELLeaves, 1, (STRPOS(ELLeaves, '.')) - 1))
                            ELSE
                                Elleave := 0;
                            AssigntheLeavesForel(MonthlyAttend, Elleave);
                        END;
                    END;
                END;
            END ELSE BEGIN
                IF MonthlyAttend."Pay Slip Month" = 1 THEN BEGIN
                    MonthlyAttend1.SETRANGE("Employee Code", MonthlyAttend."Employee Code");
                    MonthlyAttend1.SETRANGE(Year, MonthlyAttend.Year - 1);
                    IF MonthlyAttend1.FIND('+') THEN
                        MonthlyAttend1.CALCFIELDS("Total Present Days");
                    IF MonthlyAttend1."Total Present Days" > 240 THEN BEGIN
                        Elleave := UpdateLeaveforEL(MonthlyAttend);
                        AssigntheLeavesForel(MonthlyAttend, Elleave);
                    END
                    ELSE BEGIN
                        ELLeaves := FORMAT(MonthlyAttend1."Total Present Days" / 20);
                        IF MonthlyAttend1."Total Present Days" / 20 <> 0 THEN
                            IF STRPOS(ELLeaves, '.') = 0 THEN
                                EVALUATE(Elleave, ELLeaves)
                            ELSE
                                EVALUATE(Elleave, COPYSTR(ELLeaves, 1, (STRPOS(ELLeaves, '.')) - 1))
                        ELSE
                            Elleave := 0;

                        Elleave += UpdateLeaveforEL(MonthlyAttend);
                        AssigntheLeavesForel(MonthlyAttend, Elleave);
                    END;
                END;
            END;
        END;
        //VE-026
    end;

    // [Scope('Internal')]
    procedure UpdateLeaveforEL(var MonthlyAttend: Record 60007) ELLeaves1: Decimal
    var
        LeaveEntitle1: Record 60031;
        DailyAtt: Record 60028;
    begin
        //VE-026>>
        LeaveEntitle1.INIT;
        LeaveEntitle1.SETRANGE("Employee No.", MonthlyAttend."Employee Code");
        LeaveEntitle1.SETRANGE(Year, MonthlyAttend.Year - 1);
        LeaveEntitle1.SETRANGE(Month, 12);
        LeaveEntitle1.SETRANGE("Leave Code", 'EL');
        IF LeaveEntitle1.FIND('-') THEN
            ELLeaves1 := LeaveEntitle1."Leave Bal. at the Month End";
        //VE-026<<
    end;

    //  [Scope('Internal')]
    procedure AssigntheLeavesForel(var MonthlyAtt: Record 60007; Leavesadd: Integer)
    begin
        //VE-026
        MonAtt3.INIT;
        MonAtt3.SETRANGE("Employee Code", MonthlyAtt."Employee Code");
        MonAtt3.SETRANGE(Year, Year);
        MonAtt3.SETFILTER("Pay Slip Month", '>=%1', MonthlyAtt."Pay Slip Month");
        IF MonAtt3.FIND('-') THEN
            REPEAT
                MonAtt3."Employee Code" := MonthlyAtt."Employee Code";
                MonAtt3.Leavesaddedafteryear := TRUE;
                MonAtt3."LeavesAvl.ForEL" := Leavesadd;
                MonAtt3.MODIFY;
            UNTIL MonAtt3.NEXT = 0;
        //MonthlyAtt:=MonAtt3;
        //MonthlyAtt.Leavesaddedafteryear:=TRUE; //VE-003
        //MonthlyAtt."LeavesAvl.ForEL":=Leavesadd; //VE-003
        //MonthlyAtt.MODIFY;
        COMMIT;//VE-003
               //VE-026
    end;

    //  [Scope('Internal')]
    procedure NoOfDaysInMonth(month: Integer; year1: Integer)
    begin
        DaysInMon := 0;
        CASE month OF
            1:
                DaysInMon := 31;
            2:
                BEGIN
                    IF ((year1 / 4) = 0) AND (((year1 / 100) <> 0) OR ((year1 / 400) = 0)) THEN
                        DaysInMon := 29
                    ELSE
                        DaysInMon := 28;
                END;
            3:
                DaysInMon := 31;
            4:
                DaysInMon := 30;
            5:
                DaysInMon := 31;
            6:
                DaysInMon := 30;
            7:
                DaysInMon := 31;
            8:
                DaysInMon := 31;
            9:
                DaysInMon := 30;
            10:
                DaysInMon := 31;
            11:
                DaysInMon := 30;
            12:
                DaysInMon := 31;

        END;
    end;

    // [Scope('Internal')]
    procedure "---HM1.01--"()
    begin
    end;

    // [Scope('Internal')]
    procedure LoanDeductions(MonAttendance: Record 60029)
    var
        Loan: Record 60039;
        LoanStartMonth: Integer;
        LoanStartYear: Integer;
    begin
        Loan.SETRANGE("Employee Code", MonAttendance."Employee Code");
        Loan.SETRANGE("No Deduction Request", FALSE);
        Loan.SETFILTER("Loan Balance", '<>0');
        IF Loan.FIND('-') THEN
            REPEAT
                LoanStartMonth := DATE2DMY(Loan."Loan Start Date", 2);
                LoanStartYear := DATE2DMY(Loan."Loan Start Date", 3);
                //UD dec 8th
                //    IF (MonAttendance."Pay Slip Month" >= LoanStartMonth) AND (MonAttendance.Year >= LoanStartYear) THEN
                IF ((MonAttendance."Pay Slip Month" >= LoanStartMonth) AND (MonAttendance.Year = LoanStartYear)) OR
                    (MonAttendance.Year > LoanStartYear) THEN  //UD dec 8th
                    LoanRecords(MonAttendance, Loan);
            UNTIL Loan.NEXT = 0;
    end;

    // [Scope('Internal')]
    procedure LoanRecords(MonAttendance: Record 60029; Loan: Record 60039)
    var
        TempProcsalary: Record 60038;
        TempProcessedSalary: Record 60038;
    begin
        IF Loan."Effective Amount" <> 0 THEN BEGIN
            TempProcsalary.INIT;
            TempProcsalary."Employee Code" := Loan."Employee Code";
            TempProcsalary."Add/Deduct Code" := Loan."Loan Type";
            TempProcsalary."Pay Slip Month" := MonAttendance."Pay Slip Month";
            TempProcsalary.Year := MonAttendance.Year;
            TempProcsalary."Document Type" := TempProcsalary."Document Type"::Payroll;

            TempProcessedSalary.SETRANGE("Document Type", TempProcessedSalary."Document Type"::Payroll);
            TempProcessedSalary.SETRANGE("Employee Code", TempProcsalary."Employee Code");
            TempProcessedSalary.SETRANGE("Pay Slip Month", TempProcsalary."Pay Slip Month");
            TempProcessedSalary.SETRANGE(Year, TempProcsalary.Year);
            IF TempProcessedSalary.FIND('+') THEN
                TempProcsalary."Line No." := TempProcessedSalary."Line No." + 10000
            ELSE
                TempProcsalary."Line No." := 10000;

            TempProcsalary."Computation Type" := 'LOAN';
            TempProcsalary."Loan Priority No" := Loan."Loan Priority No";
            TempProcsalary."Earned Amount" := Loan."Effective Amount";
            TempProcessedSalary."Loan Id" := Loan.Id;
            //TempProcsalary."Partial Deduction" := Loan."Partial Deduction";
            TempProcsalary."Add/Deduct" := TempProcsalary."Add/Deduct"::Deduction;
            TempProcsalary.Attendance := MonAttendance.Attendance;
            TempProcsalary.Days := MonAttendance.Days;

            //Lookup.SETRANGE("LookupType Name",'ADDITIONS AND DEDUCTIONS');
            //Lookup.SETRANGE("Lookup Name",'LOAN');
            //IF Lookup.FIND('-') THEN
            //  TempProcsalary.Priority := Lookup.Priority;

            TempProcsalary."Loan Id" := Loan.Id;
            TempProcsalary.INSERT;
        END;
    end;

    local procedure CurrentYearOnAfterValidate()
    begin
        SelectYear;
    end;

    local procedure CurrentMonthOnAfterValidate()
    begin
        SelectMonth;
    end;

    local procedure CurrentCadreOnAfterValidate()
    begin
        SelectPayCadre;
    end;

    local procedure ShowAllOnAfterValidate()
    begin
        IF ShowAll THEN BEGIN
            Rec.RESET;
            SelectYear;
            SelectMonth;
        END ELSE BEGIN
            SelectYear;
            SelectMonth;
            SelectPayCadre;
        END;
    end;

    local procedure EmpLocOnAfterValidate()
    begin
        SelectLocation;
    end;

    local procedure OperationTypeOnAfterValidate()
    begin
        SelectOperation;
    end;
}

