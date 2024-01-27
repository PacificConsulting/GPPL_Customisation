page 70024 "Employee Dashboard - Dept Main"
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
            group("Employee Dashboard - Departmentwise")
            {
                Caption = 'Employee Dashboard - Departmentwise';
                grid("Current Month Employee Statistics")
                {
                    Caption = 'Current Month Employee Statistics';
                    group(DEPARTMENT)
                    {
                        Caption = 'DEPARTMENT';
                        label("1")
                        {

                            CaptionClass = '3,' + DepartmentArr[1, 1];
                            Caption = '1';
                            ShowCaption = false;
                        }
                        label("2")
                        {
                            CaptionClass = '3,' + DepartmentArr[2, 1];
                            Caption = '2';
                            ShowCaption = false;
                        }
                        label("3")
                        {
                            CaptionClass = '3,' + DepartmentArr[3, 1];
                            Caption = '3';
                            ShowCaption = false;
                        }
                        label("4")
                        {
                            CaptionClass = '3,' + DepartmentArr[4, 1];
                            Caption = '4';
                            ShowCaption = false;
                        }
                        label("5")
                        {
                            CaptionClass = '3,' + DepartmentArr[5, 1];
                            Caption = '5';
                            ShowCaption = false;
                        }
                        label("6")
                        {
                            CaptionClass = '3,' + DepartmentArr[6, 1];
                            Caption = '6';
                            ShowCaption = false;
                        }
                        label("7")
                        {
                            CaptionClass = '3,' + DepartmentArr[7, 1];
                            Caption = '7';
                            ShowCaption = false;
                        }
                        label("8")
                        {
                            CaptionClass = '3,' + DepartmentArr[8, 1];
                            Caption = '8';
                            ShowCaption = false;
                        }
                        label("9")
                        {
                            CaptionClass = '3,' + DepartmentArr[9, 1];
                            Caption = '9';
                            ShowCaption = false;
                        }
                        label("10")
                        {
                            CaptionClass = '3,' + DepartmentArr[10, 1];
                            Caption = '10';
                            ShowCaption = false;
                        }
                    }
                    group("New Joinees")
                    {
                        Caption = 'New Joinees';
                        field(DepartmentArr12; DepartmentArr[1, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[1, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr22; DepartmentArr[2, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[2, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr32; DepartmentArr[3, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[3, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr42; DepartmentArr[4, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[4, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr52; DepartmentArr[5, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[5, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr62; DepartmentArr[6, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[6, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr72; DepartmentArr[7, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[7, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr82; DepartmentArr[8, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[8, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr92; DepartmentArr[9, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[9, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr102; DepartmentArr[10, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[10, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                    }
                    group(Resignations)
                    {
                        Caption = 'Resignations';
                        field(DepartmentArr13; DepartmentArr[1, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[1, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr23; DepartmentArr[2, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[2, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr33; DepartmentArr[3, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[3, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr43; DepartmentArr[4, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[4, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr53; DepartmentArr[5, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[5, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr63; DepartmentArr[6, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[6, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr73; DepartmentArr[7, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[7, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr83; DepartmentArr[8, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[8, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr93; DepartmentArr[9, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[9, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr103; DepartmentArr[10, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[10, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                    }
                    group("Terminated Employees")
                    {
                        Caption = 'Terminated Employees';
                        field(DepartmentArr14; DepartmentArr[1, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[1, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr24; DepartmentArr[2, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[2, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr34; DepartmentArr[3, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[3, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr44; DepartmentArr[4, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[4, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr54; DepartmentArr[5, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[5, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr64; DepartmentArr[6, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[6, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr74; DepartmentArr[7, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[7, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr84; DepartmentArr[8, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[8, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr94; DepartmentArr[9, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[9, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(DepartmentArr104; DepartmentArr[10, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[10, 1];
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
                        field(DepartmentArr15; DepartmentArr[1, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[1, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DepartmentArr25; DepartmentArr[2, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[2, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DepartmentArr35; DepartmentArr[3, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[3, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DepartmentArr45; DepartmentArr[4, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[4, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DepartmentArr55; DepartmentArr[5, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[5, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DepartmentArr65; DepartmentArr[6, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[6, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DepartmentArr75; DepartmentArr[7, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[7, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DepartmentArr85; DepartmentArr[8, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[8, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DepartmentArr95; DepartmentArr[9, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[9, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(DepartmentArr105; DepartmentArr[10, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[10, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                    }
                    group("No. Of Employees")
                    {
                        Caption = 'No. Of Employees';
                        field(DepartmentArr16; DepartmentArr[1, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[1, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DepartmentArr26; DepartmentArr[2, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[2, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DepartmentArr36; DepartmentArr[3, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[3, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DepartmentArr46; DepartmentArr[4, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[4, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DepartmentArr56; DepartmentArr[5, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[5, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DepartmentArr66; DepartmentArr[6, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[6, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DepartmentArr76; DepartmentArr[7, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[7, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DepartmentArr86; DepartmentArr[8, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[8, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DepartmentArr96; DepartmentArr[9, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[9, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(DepartmentArr106; DepartmentArr[10, 6])
                        {

                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[10, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                    }
                    group("No. of Inactive Employees")
                    {
                        Caption = 'No. of Inactive Employees';
                        field(DepartmentArr17; DepartmentArr[1, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[1, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DepartmentArr27; DepartmentArr[2, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[2, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DepartmentArr37; DepartmentArr[3, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[3, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DepartmentArr47; DepartmentArr[4, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[4, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DepartmentArr57; DepartmentArr[5, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[5, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DepartmentArr67; DepartmentArr[6, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[6, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DepartmentArr77; DepartmentArr[7, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[7, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DepartmentArr87; DepartmentArr[8, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[8, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DepartmentArr97; DepartmentArr[9, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[9, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(DepartmentArr107; DepartmentArr[10, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[10, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                    }
                    group("No. of Resigned Employees")
                    {
                        Caption = 'No. of Resigned Employees';
                        field(DepartmentArr18; DepartmentArr[1, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[1, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DepartmentArr28; DepartmentArr[2, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[2, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DepartmentArr38; DepartmentArr[3, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[3, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DepartmentArr48; DepartmentArr[4, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[4, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DepartmentArr58; DepartmentArr[5, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[5, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DepartmentArr68; DepartmentArr[6, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[6, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DepartmentArr78; DepartmentArr[7, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[7, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DepartmentArr88; DepartmentArr[8, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[8, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DepartmentArr98; DepartmentArr[9, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[9, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(DepartmentArr108; DepartmentArr[10, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[10, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                    }
                    group("No. of Terminated Employees")
                    {
                        Caption = 'No. of Terminated Employees';
                        field(DepartmentArr19; DepartmentArr[1, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[1, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DepartmentArr29; DepartmentArr[2, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[2, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DepartmentArr39; DepartmentArr[3, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[3, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DepartmentArr49; DepartmentArr[4, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[4, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DepartmentArr59; DepartmentArr[5, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[5, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DepartmentArr69; DepartmentArr[6, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[6, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DepartmentArr79; DepartmentArr[7, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[7, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DepartmentArr89; DepartmentArr[8, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[8, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DepartmentArr99; DepartmentArr[9, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[9, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(DepartmentArr109; DepartmentArr[10, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := DepartmentArr[10, 1];
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
        LookUp.SETRANGE(LookUp."Lookup Type", 4);
        IF LookUp.FINDFIRST THEN
            REPEAT
                JoinedCurrMnt := 0;
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
                Employee.SETRANGE(Employee."Department Code", LookUp."Lookup Name");
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
                DepartmentArr[i, 1] := FORMAT(0);
                DepartmentArr[i, 2] := FORMAT(0);
                DepartmentArr[i, 3] := FORMAT(0);
                DepartmentArr[i, 4] := FORMAT(0);
                DepartmentArr[i, 5] := FORMAT(0);
                DepartmentArr[i, 6] := FORMAT(0);
                DepartmentArr[i, 7] := FORMAT(0);
                DepartmentArr[i, 8] := FORMAT(0);
                DepartmentArr[i, 9] := FORMAT(0);


                DepartmentArr[i, 1] := LookUp.Description;
                //DepartmentArr[i,2]:=FORMAT(DeptCount);
                DepartmentArr[i, 2] := FORMAT(JoinedCurrMnt);
                DepartmentArr[i, 3] := FORMAT(ResignedCurrMnt);
                DepartmentArr[i, 4] := FORMAT(TerminatedCurrMnt);
                DepartmentArr[i, 5] := FORMAT(TotalProbation);
                DepartmentArr[i, 6] := FORMAT(TotalEmployees);
                DepartmentArr[i, 7] := FORMAT(TotalInactive);
                DepartmentArr[i, 8] := FORMAT(TotalResigned);
                DepartmentArr[i, 9] := FORMAT(TotalTerminated);
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
        DepartmentArr: array[50, 9] of Text[100];
        EmployeeForm: Page 60005;
        Text1: Text[100];

    //  [Scope('Internal')]
    procedure FunctionJoinedCurrMonth(department: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 4);
        LookUp.SETRANGE(LookUp.Description, department);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE("Employment Date", StartDate, EndDate);
            Employee.SETRANGE("Department Code", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    // [Scope('Internal')]
    procedure FunctionResignedCurrMonth(department: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 4);
        LookUp.SETRANGE(LookUp.Description, department);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE(Employee."Resignation Date", StartDate, EndDate);
            Employee.SETFILTER(Employee.Status, '<>%1', Employee.Status::Terminated);
            Employee.SETRANGE(Employee.Resigned, TRUE);
            Employee.SETRANGE("Department Code", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    // [Scope('Internal')]
    procedure FunctionTerminatedCurrMonth(department: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 4);
        LookUp.SETRANGE(LookUp.Description, department);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER(Employee.Status, '%1', Employee.Status::Terminated);
            Employee.SETRANGE(Employee."Termination Date", StartDate, EndDate);
            Employee.SETRANGE("Department Code", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    // [Scope('Internal')]
    procedure FunctionProbation(department: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 4);
        LookUp.SETRANGE(LookUp.Description, department);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE(Employee.Probation, TRUE);
            Employee.SETRANGE("Department Code", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    //[Scope('Internal')]
    procedure FunctionTotalEmployees(department: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 4);
        LookUp.SETRANGE(LookUp.Description, department);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER(Employee.Status, '%1', Employee.Status::Active);
            Employee.SETRANGE("Department Code", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    //[Scope('Internal')]
    procedure FunctionInactive(department: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 4);
        LookUp.SETRANGE(LookUp.Description, department);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE(Employee.Status, Employee.Status::Inactive);
            Employee.SETRANGE("Department Code", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    //  [Scope('Internal')]
    procedure FunctionResigned(department: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 4);
        LookUp.SETRANGE(LookUp.Description, department);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER(Employee.Status, '<>%1', Employee.Status::Terminated);
            Employee.SETRANGE(Resigned, TRUE);
            Employee.SETRANGE("Department Code", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    //    [Scope('Internal')]
    procedure FunctionTerminated(department: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 4);
        LookUp.SETRANGE(LookUp.Description, department);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE(Employee.Status, Employee.Status::Terminated);
            Employee.SETRANGE("Department Code", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;
}

