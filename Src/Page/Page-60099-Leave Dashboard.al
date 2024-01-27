page 60099 "Leave Dashboard"
{
    Editable = false;
    PageType = Card;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group("LEAVE DASHBOARD")
            {
                Caption = 'LEAVE DASHBOARD';
                grid("-Total Leave Details-")
                {
                    Caption = '-Total Leave Details-';
                    group(group1)
                    {
                        label(Leaves)
                        {
                            ApplicationArea = all;
                            Caption = 'Leaves';
                            ShowCaption = false;
                        }
                        label("Employees - Leave Availed")
                        {
                            ApplicationArea = all;
                            Caption = 'Employees - Leave Availed';
                            ShowCaption = false;
                        }
                    }
                    group(group2)
                    {
                        field(NoOfLeaves; NoOfLeaves)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                DailyAttdnRec.RESET;
                                DailyAttdnRec.SETRANGE(Month, CurrMnt);
                                DailyAttdnRec.SETRANGE(Year, CurrYear);
                                DailyAttdnRec.SETFILTER(DailyAttdnRec."Leave Code", '<>%1', '');
                                IF DailyAttdnRec.FINDSET THEN;

                                PAGE.RUNMODAL(60017, DailyAttdnRec);
                            end;
                        }
                        field(NoOfEmps; NoOfEmps)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                DailyAttdnRec.RESET;
                                DailyAttdnRec.SETRANGE(Month, CurrMnt);
                                DailyAttdnRec.SETRANGE(Year, CurrYear);
                                DailyAttdnRec.SETFILTER(DailyAttdnRec."Leave Code", '<>%1', '');
                                IF DailyAttdnRec.FINDSET THEN;

                                PAGE.RUNMODAL(60017, DailyAttdnRec);
                            end;
                        }
                    }
                }
                grid("-Applied Leave Details-")
                {
                    Caption = '-Applied Leave Details-';
                    group(group3)
                    {
                        label("Leaves Applied")
                        {
                            ApplicationArea = all;
                            Caption = 'Leaves Applied';
                            ShowCaption = false;
                        }
                        label("Leaves Applied - Pending")
                        {
                            ApplicationArea = all;
                            Caption = 'Leaves Applied - Pending';
                            ShowCaption = false;
                        }
                        label("Leaves Sanctioned")
                        {
                            ApplicationArea = all;
                            Caption = 'Leaves Sanctioned';
                            ShowCaption = false;
                        }
                    }
                    group(group4)
                    {
                        field(LeavesApplied; LeavesApplied)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                DetAppList.RESET;
                                DetAppList.SETRANGE(Date, StartDate, TODAY);
                                DetAppList.SETRANGE(Applied, TRUE);
                                DetAppList.SETFILTER("Leave Code", '<>%1', '');
                                IF DetAppList.FINDSET THEN;

                                PAGE.RUNMODAL(70000, DetAppList);
                            end;
                        }
                        field(LeavesPending; LeavesPending)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                DetAppList.RESET;
                                DetAppList.SETRANGE(Date, StartDate, TODAY);
                                DetAppList.SETFILTER("Leave Code", '<>%1', '');
                                DetAppList.SETRANGE(Applied, TRUE);
                                DetAppList.SETRANGE(Approved, FALSE);
                                IF DetAppList.FINDSET THEN;

                                PAGE.RUNMODAL(70000, DetAppList);
                            end;
                        }
                        field(LeavesSanctnd; LeavesSanctnd)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                DetAppList.RESET;
                                DetAppList.SETRANGE(Date, StartDate, TODAY);
                                DetAppList.SETFILTER("Leave Code", '<>%1', '');
                                DetAppList.SETRANGE(Applied, TRUE);
                                DetAppList.SETRANGE(Approved, TRUE);
                                IF DetAppList.FINDSET THEN;

                                PAGE.RUNMODAL(70000, DetAppList);
                            end;
                        }
                    }
                }
                grid("-Leaves Encashed Details-")
                {
                    Caption = '-Leaves Encashed Details-';
                    group(group5)
                    {
                        label("Leave Encashed - Number")
                        {
                            ApplicationArea = all;
                            Caption = 'Leave Encashed - Number';
                            ShowCaption = false;
                        }
                        label("Leave Encashed - No. of Employees")
                        {
                            ApplicationArea = all;
                            Caption = 'Leave Encashed - No. of Employees';
                            ShowCaption = false;
                        }
                        label("Leave Encashed - Amount")
                        {
                            ApplicationArea = all;
                            Caption = 'Leave Encashed - Amount';
                            ShowCaption = false;
                        }
                        label("Leave Encashment - Pending")
                        {
                            ApplicationArea = all;
                            Caption = 'Leave Encashment - Pending';
                            ShowCaption = false;
                        }
                    }
                    group(group6)
                    {
                        field(LeavesEncashd; LeavesEncashd)
                        {
                            ApplicationArea = all;

                            trigger OnDrillDown()
                            begin

                                LeaveEncashRec.RESET;
                                LeaveEncashRec.SETRANGE(Year, CurrYear);
                                LeaveEncashRec.SETRANGE(Month, CurrMnt);
                                IF LeaveEncashRec.FINDSET THEN;

                                PAGE.RUNMODAL(60026, LeaveEncashRec);
                            end;
                        }
                        field(NoOfEmpsEncsh; NoOfEmpsEncsh)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                LeaveEncashRec.RESET;
                                LeaveEncashRec.SETRANGE(Year, CurrYear);
                                LeaveEncashRec.SETRANGE(Month, CurrMnt);
                                IF LeaveEncashRec.FINDSET THEN;

                                PAGE.RUNMODAL(60026, LeaveEncashRec);
                            end;
                        }
                        field(LeaveEnchdAmt; LeaveEnchdAmt)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin
                                LeaveEncashRec.RESET;
                                LeaveEncashRec.SETRANGE(Year, CurrYear);
                                LeaveEncashRec.SETRANGE(Month, CurrMnt);
                                IF LeaveEncashRec.FINDSET THEN;

                                PAGE.RUNMODAL(60026, LeaveEncashRec);
                            end;
                        }
                        field(EncashPending; EncashPending)
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                LeaveEncashRec.RESET;
                                LeaveEncashRec.SETRANGE(Year, CurrYear);
                                LeaveEncashRec.SETRANGE(Month, CurrMnt);
                                IF LeaveEncashRec.FINDSET THEN;

                                PAGE.RUNMODAL(60026, LeaveEncashRec);
                            end;
                        }
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        StartDate := CALCDATE('-CM', TODAY);
        CurrMnt := DATE2DMY(TODAY, 2);
        CurrYear := DATE2DMY(TODAY, 3);
        //MESSAGE('%1',CurrMnt);

        EmpNo := '';


        NoOfLeaves := 0;
        DailyAttdnRec.RESET;
        DailyAttdnRec.SETRANGE(Month, CurrMnt);
        DailyAttdnRec.SETRANGE(Year, CurrYear);
        DailyAttdnRec.SETFILTER(DailyAttdnRec."Leave Code", '<>%1', '');
        IF DailyAttdnRec.FINDSET THEN
            REPEAT
                NoOfLeaves += DailyAttdnRec.Leave;
            UNTIL DailyAttdnRec.NEXT = 0;


        NoOfEmps := 0;
        DailyAttdnRec.RESET;
        DailyAttdnRec.SETRANGE(Month, CurrMnt);
        DailyAttdnRec.SETRANGE(Year, CurrYear);
        DailyAttdnRec.SETFILTER(DailyAttdnRec."Leave Code", '<>%1', '');
        IF DailyAttdnRec.FINDSET THEN
            REPEAT
                IF EmpNo <> DailyAttdnRec."Employee No." THEN
                    NoOfEmps += 1;
                EmpNo := DailyAttdnRec."Employee No.";
            UNTIL DailyAttdnRec.NEXT = 0;


        LeavesApplied := 0;
        DetAppList.RESET;
        DetAppList.SETRANGE(Date, StartDate, TODAY);
        DetAppList.SETRANGE(Applied, TRUE);
        DetAppList.SETFILTER("Leave Code", '<>%1', '');
        IF DetAppList.FINDSET THEN
            REPEAT
                LeavesApplied += DetAppList.Day;
            UNTIL DetAppList.NEXT = 0;

        LeavesPending := 0;
        DetAppList.RESET;
        DetAppList.SETRANGE(Date, StartDate, TODAY);
        DetAppList.SETFILTER("Leave Code", '<>%1', '');
        DetAppList.SETRANGE(Applied, TRUE);
        DetAppList.SETRANGE(Approved, FALSE);
        IF DetAppList.FINDSET THEN
            REPEAT
                LeavesPending += DetAppList.Day;
            UNTIL DetAppList.NEXT = 0;


        LeavesSanctnd := 0;
        DetAppList.RESET;
        DetAppList.SETRANGE(Date, StartDate, TODAY);
        DetAppList.SETFILTER("Leave Code", '<>%1', '');
        DetAppList.SETRANGE(Applied, TRUE);
        DetAppList.SETRANGE(Approved, TRUE);
        IF DetAppList.FINDSET THEN
            REPEAT
                LeavesSanctnd += DetAppList.Day;
            UNTIL DetAppList.NEXT = 0;

        NoOfEmpsEncsh := 0;
        LeavesEncashd := 0;
        LeaveEnchdAmt := 0;
        EncashPending := 0;

        LeaveEncashRec.RESET;
        LeaveEncashRec.SETRANGE(Year, CurrYear);
        LeaveEncashRec.SETRANGE(Month, CurrMnt);
        IF LeaveEncashRec.FINDSET THEN BEGIN
            NoOfEmpsEncsh := LeaveEncashRec.COUNT;
            REPEAT
                LeavesEncashd += LeaveEncashRec."Leaves Encashed";
                LeaveEnchdAmt += LeaveEncashRec."Encash Amount";
                EncashPending += LeaveEncashRec."Leaves to Encash";
            UNTIL LeaveEncashRec.NEXT = 0;
        END;
    end;

    var
        Text19040493: Label 'Employee Dashboard - Designationwise';
        Text19067950: Label 'DESIGNATION';
        Text19010561: Label 'Resignations';
        Text19076330: Label 'New Joinees';
        Text19001219: Label 'Terminated Employees';
        Text19011194: Label 'Overall Employee Statistics';
        Text19003536: Label 'No. Of Employees';
        Text19067053: Label 'Probation';
        Text19057152: Label 'No. of Inactive Employees';
        Text19065850: Label 'No. of Resigned Employees';
        Text19003771: Label 'No. of Terminated Employees';
        NoOfLeaves: Decimal;
        CurrMnt: Integer;
        CurrYear: Integer;
        StartDate: Date;
        NoOfEmps: Integer;
        NoOfEmpsEncsh: Integer;
        EmpNo: Code[10];
        LeavesApplied: Decimal;
        LeavesPending: Decimal;
        LeavesSanctnd: Decimal;
        LeavesEncashd: Decimal;
        LeaveEnchdAmt: Decimal;
        EncashPending: Decimal;
        DailyAttdn: Page 60017;
        DailyAttdnRec: Record 60028;
        DetLeaveAppList: Page 70000;
        DetAppList: Record "Detailed Applied Leave";//60001;
        LeaveEncashRec: Record 60033;
        LeaveEncashdForm: Page "Leave Encashed";//60026;
}

