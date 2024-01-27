page 70020 "Employee Dashboard - Desg Wise"
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
            group("Employee Dashboard - Designationwise")
            {
                Caption = 'Employee Dashboard - Designationwise';
                grid("Current Month Employee Statistics")
                {
                    Caption = 'Current Month Employee Statistics';
                    group(DESIGNATION)
                    {
                        Caption = 'DESIGNATION';
                        label("1")
                        {
                            CaptionClass = '3,' + DesignationArr[1, 1];
                            Caption = '1';
                            ShowCaption = false;
                        }
                        label("2")
                        {
                            CaptionClass = '3,' + DesignationArr[2, 1];
                            Caption = '2';
                            ShowCaption = false;
                        }
                        label("3")
                        {
                            CaptionClass = '3,' + DesignationArr[3, 1];
                            Caption = '3';
                            ShowCaption = false;
                        }
                        label("4")
                        {
                            CaptionClass = '3,' + DesignationArr[4, 1];
                            Caption = '4';
                            ShowCaption = false;
                        }
                        label("5")
                        {
                            CaptionClass = '3,' + DesignationArr[5, 1];
                            Caption = '5';
                            ShowCaption = false;
                        }
                        label("6")
                        {
                            CaptionClass = '3,' + DesignationArr[6, 1];
                            Caption = '6';
                            ShowCaption = false;
                        }
                        label("7")
                        {
                            CaptionClass = '3,' + DesignationArr[7, 1];
                            Caption = '7';
                            ShowCaption = false;
                        }
                        label("8")
                        {
                            CaptionClass = '3,' + DesignationArr[8, 1];
                            Caption = '8';
                            ShowCaption = false;
                        }
                        label("9")
                        {
                            CaptionClass = '3,' + DesignationArr[9, 1];
                            Caption = '9';
                            ShowCaption = false;
                        }
                        label("10")
                        {
                            CaptionClass = '3,' + DesignationArr[10, 1];
                            Caption = '10';
                            ShowCaption = false;
                        }
                    }
                    group("New Joinees")
                    {
                        Caption = 'New Joinees';
                        field(DesignationArr12; DesignationArr[1, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[1, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr22; DesignationArr[2, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[2, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr32; DesignationArr[3, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[3, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr42; DesignationArr[4, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[4, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr52; DesignationArr[5, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[5, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr62; DesignationArr[6, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[6, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr72; DesignationArr[7, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[7, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr82; DesignationArr[8, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[8, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr92; DesignationArr[9, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[9, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr102; DesignationArr[10, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[10, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                    }
                    group(Resignations)
                    {
                        Caption = 'Resignations';
                        field(DesignationArr13; DesignationArr[1, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[1, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr23; DesignationArr[2, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[2, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr33; DesignationArr[3, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[3, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr43; DesignationArr[4, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[4, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr53; DesignationArr[5, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[5, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr63; DesignationArr[6, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[6, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr73; DesignationArr[7, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[7, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr83; DesignationArr[8, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[8, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr93; DesignationArr[9, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[9, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr103; DesignationArr[10, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[10, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                    }
                    group("Terminated Employees")
                    {
                        Caption = 'Terminated Employees';
                        field(DesignationArr14; DesignationArr[1, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[1, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr24; DesignationArr[2, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[2, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr34; DesignationArr[3, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[3, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr44; DesignationArr[4, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[4, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr54; DesignationArr[5, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[5, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr64; DesignationArr[6, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[6, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr74; DesignationArr[7, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[7, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr84; DesignationArr[8, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[8, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr94; DesignationArr[9, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[9, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DesignationArr104; DesignationArr[10, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[10, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                    }
                }
                grid("Overall Employee Statistics")
                {
                    Caption = 'Overall Employee Statistics';
                    group(Probation)
                    {
                        Caption = 'Probation';
                        field(DesignationArr15; DesignationArr[1, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[1, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DesignationArr25; DesignationArr[2, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[2, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DesignationArr35; DesignationArr[3, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[3, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DesignationArr45; DesignationArr[4, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[4, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DesignationArr55; DesignationArr[5, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[5, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DesignationArr65; DesignationArr[6, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[6, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DesignationArr75; DesignationArr[7, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[7, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DesignationArr85; DesignationArr[8, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[8, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DesignationArr95; DesignationArr[9, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[9, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DesignationArr105; DesignationArr[10, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[10, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                    }
                    group("No. Of Employees")
                    {
                        Caption = 'No. Of Employees';
                        field(DesignationArr16; DesignationArr[1, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[1, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DesignationArr26; DesignationArr[2, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[2, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DesignationArr36; DesignationArr[3, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[3, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DesignationArr46; DesignationArr[4, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[4, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DesignationArr56; DesignationArr[5, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[5, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DesignationArr66; DesignationArr[6, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[6, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DesignationArr76; DesignationArr[7, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[7, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DesignationArr86; DesignationArr[8, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[8, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DesignationArr96; DesignationArr[9, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[9, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DesignationArr106; DesignationArr[10, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[10, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                    }
                    group("No. of Inactive Employees")
                    {
                        Caption = 'No. of Inactive Employees';
                        field(DesignationArr17; DesignationArr[1, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[1, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DesignationArr27; DesignationArr[2, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[2, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DesignationArr37; DesignationArr[3, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[3, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DesignationArr47; DesignationArr[4, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[4, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DesignationArr57; DesignationArr[5, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[5, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DesignationArr67; DesignationArr[6, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[6, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DesignationArr77; DesignationArr[7, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[7, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DesignationArr87; DesignationArr[8, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[8, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DesignationArr97; DesignationArr[9, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[9, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DesignationArr107; DesignationArr[10, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[10, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                    }
                    group("No. of Resigned Employees")
                    {
                        Caption = 'No. of Resigned Employees';
                        field(DesignationArr18; DesignationArr[1, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[1, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DesignationArr28; DesignationArr[2, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[2, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DesignationArr38; DesignationArr[3, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[3, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DesignationArr48; DesignationArr[4, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[4, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DesignationArr58; DesignationArr[5, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[5, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DesignationArr68; DesignationArr[6, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[6, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DesignationArr78; DesignationArr[7, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[7, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DesignationArr88; DesignationArr[8, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[8, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DesignationArr98; DesignationArr[9, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[9, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DesignationArr108; DesignationArr[10, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[10, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                    }
                    group("No. of Terminated Employees")
                    {
                        Caption = 'No. of Terminated Employees';
                        field(DesignationArr19; DesignationArr[1, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[1, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DesignationArr29; DesignationArr[2, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[2, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DesignationArr39; DesignationArr[3, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[3, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DesignationArr49; DesignationArr[4, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[4, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DesignationArr59; DesignationArr[5, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[5, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DesignationArr69; DesignationArr[6, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[6, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DesignationArr79; DesignationArr[7, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[7, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DesignationArr89; DesignationArr[8, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[8, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DesignationArr99; DesignationArr[9, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[9, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DesignationArr109; DesignationArr[10, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DesignationArr[10, 1];
                                FunctionTerminated(Text1);
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

        Month := DATE2DMY(TODAY, 2);
        Year := DATE2DMY(TODAY, 3);
        StartDate := DMY2DATE(1, Month, Year);
        EndDate := CALCDATE('CM', StartDate);


        LookUp.RESET;
        i := 0;
        LookUp.SETRANGE(LookUp."Lookup Type", 5);
        IF LookUp.FINDFIRST THEN
            REPEAT
                JoinedCurrMnt := 0;
                DegCount := 0;
                ResignedCurrMnt := 0;
                TerminatedCurrMnt := 0;
                TotalInactive := 0;
                TotalProbation := 0;
                TotalEmployees := 0;
                TotalResigned := 0;
                TotalTerminated := 0;

                Employee.RESET;
                //  joinees in current month..
                Employee.SETFILTER("Employment Date", '%1..%2', StartDate, EndDate);
                Employee.SETRANGE(Employee.Designation, LookUp."Lookup Name");
                DegCount := Employee.COUNT;
                JoinedCurrMnt := Employee.COUNT;

                //  resignees in current month..
                Employee.SETRANGE(Employee."Employment Date");
                Employee.SETFILTER(Employee.Status, '<>%1', Employee.Status::Terminated);
                Employee.SETRANGE(Employee."Resignation Date", StartDate, EndDate);
                Employee.SETRANGE(Employee.Resigned, TRUE);
                ResignedCurrMnt := Employee.COUNT;

                //  terminated in current month..
                Employee.SETRANGE(Employee.Status);
                Employee.SETRANGE(Employee."Resignation Date");
                Employee.SETRANGE(Employee.Resigned);
                Employee.SETFILTER(Employee.Status, '%1', Employee.Status::Terminated);
                Employee.SETRANGE(Employee."Termination Date", StartDate, EndDate);
                TerminatedCurrMnt := Employee.COUNT;

                // probation employees..
                Employee.SETRANGE(Employee.Status);
                Employee.SETRANGE(Employee."Termination Date");
                Employee.SETRANGE(Employee.Probation, TRUE);
                TotalProbation := Employee.COUNT;

                // total employees..
                Employee.SETRANGE(Employee.Probation);
                Employee.SETFILTER(Employee.Status, '%1', Employee.Status::Active);
                TotalEmployees := Employee.COUNT;

                // inactive employees..
                Employee.SETRANGE(Employee.Status);
                Employee.SETRANGE(Employee.Status, Employee.Status::Inactive);
                TotalInactive := Employee.COUNT;
                Employee.SETRANGE(Employee.Status);

                //total resigned
                Employee.SETFILTER(Employee.Status, '<>%1', Employee.Status::Terminated);
                Employee.SETRANGE(Resigned, TRUE);
                TotalResigned := Employee.COUNT;

                //total terminated
                Employee.SETRANGE(Resigned);
                Employee.SETRANGE(Employee.Status);
                Employee.SETRANGE(Employee.Status, Employee.Status::Terminated);
                TotalTerminated := Employee.COUNT;

                i += 1;
                DesignationArr[i, 1] := FORMAT(0);
                DesignationArr[i, 2] := FORMAT(0);
                DesignationArr[i, 3] := FORMAT(0);
                DesignationArr[i, 4] := FORMAT(0);
                DesignationArr[i, 5] := FORMAT(0);
                DesignationArr[i, 6] := FORMAT(0);
                DesignationArr[i, 7] := FORMAT(0);
                DesignationArr[i, 8] := FORMAT(0);
                DesignationArr[i, 9] := FORMAT(0);


                DesignationArr[i, 1] := LookUp.Description;
                //DesignationArr[i,2]:=FORMAT(DegCount);
                DesignationArr[i, 2] := FORMAT(JoinedCurrMnt);
                DesignationArr[i, 3] := FORMAT(ResignedCurrMnt);
                DesignationArr[i, 4] := FORMAT(TerminatedCurrMnt);
                DesignationArr[i, 5] := FORMAT(TotalProbation);
                DesignationArr[i, 6] := FORMAT(TotalEmployees);
                DesignationArr[i, 7] := FORMAT(TotalInactive);
                DesignationArr[i, 8] := FORMAT(TotalResigned);
                DesignationArr[i, 9] := FORMAT(TotalTerminated);
            UNTIL LookUp.NEXT = 0;
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
        Employee: Record 60019;
        StartDate: Date;
        EndDate: Date;
        Month: Integer;
        Year: Integer;
        EffectiveDate: Date;
        YearStartDate: Date;
        JoinedCurrMnt: Integer;
        ResignedCurrMnt: Integer;
        TerminatedCurrMnt: Integer;
        TotalInactive: Integer;
        TotalProbation: Integer;
        TotalEmployees: Integer;
        TotalResigned: Integer;
        TotalTerminated: Integer;
        LookUp: Record 60018;
        i: Integer;
        EmployeeForm: Page 60005;
        Text1: Text[100];
        DesignationArr: array[50, 9] of Text[100];
        DegCount: Integer;

    // [Scope('Internal')]
    procedure FunctionJoinedCurrMonth(designation: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 5);
        LookUp.SETRANGE(LookUp.Description, designation);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE("Employment Date", StartDate, EndDate);
            Employee.SETRANGE(Employee.Designation, LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    // [Scope('Internal')]
    procedure FunctionResignedCurrMonth(designation: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 5);
        LookUp.SETRANGE(LookUp.Description, designation);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE(Employee."Resignation Date", StartDate, EndDate);
            Employee.SETFILTER(Employee.Status, '<>%1', Employee.Status::Terminated);
            Employee.SETRANGE(Employee.Resigned, TRUE);
            Employee.SETRANGE(Employee.Designation, LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    //  [Scope('Internal')]
    procedure FunctionTerminatedCurrMonth(designation: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 5);
        LookUp.SETRANGE(LookUp.Description, designation);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER(Employee.Status, '%1', Employee.Status::Terminated);
            Employee.SETRANGE(Employee."Termination Date", StartDate, EndDate);
            Employee.SETRANGE(Employee.Designation, LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    //  [Scope('Internal')]
    procedure FunctionProbation(designation: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 5);
        LookUp.SETRANGE(LookUp.Description, designation);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE(Employee.Probation, TRUE);
            Employee.SETRANGE(Employee.Designation, LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    //  [Scope('Internal')]
    procedure FunctionTotalEmployees(designation: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 5);
        LookUp.SETRANGE(LookUp.Description, designation);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER(Employee.Status, '%1', Employee.Status::Active);
            Employee.SETRANGE(Employee.Designation, LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    //  [Scope('Internal')]
    procedure FunctionInactive(designation: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 5);
        LookUp.SETRANGE(LookUp.Description, designation);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE(Employee.Status, Employee.Status::Inactive);
            Employee.SETRANGE(Employee.Designation, LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    //  [Scope('Internal')]
    procedure FunctionResigned(designation: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 5);
        LookUp.SETRANGE(LookUp.Description, designation);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER(Employee.Status, '<>%1', Employee.Status::Terminated);
            Employee.SETRANGE(Resigned, TRUE);
            Employee.SETRANGE(Employee.Designation, LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    //  [Scope('Internal')]
    procedure FunctionTerminated(designation: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 5);
        LookUp.SETRANGE(LookUp.Description, designation);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE(Employee.Status, Employee.Status::Terminated);
            Employee.SETRANGE(Employee.Designation, LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;
}

