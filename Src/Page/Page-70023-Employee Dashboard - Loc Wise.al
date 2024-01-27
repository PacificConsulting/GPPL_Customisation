page 70023 "Employee Dashboard - Loc Wise"
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
            group("Employee Dashboard - Locationwise")
            {
                Caption = 'Employee Dashboard - Locationwise';
                grid("Current Month Employee Statistics")
                {
                    Caption = 'Current Month Employee Statistics';
                    group(LOCATION)
                    {
                        Caption = 'LOCATION';
                        label("1")
                        {
                            CaptionClass = '3,' + LocationArr[1, 1];
                            Caption = '1';
                            ShowCaption = false;
                        }
                        label("2")
                        {
                            CaptionClass = '3,' + LocationArr[2, 1];
                            Caption = '2';
                            ShowCaption = false;
                        }
                        label("3")
                        {
                            CaptionClass = '3,' + LocationArr[3, 1];
                            Caption = '3';
                            ShowCaption = false;
                        }
                        label("4")
                        {
                            CaptionClass = '3,' + LocationArr[4, 1];
                            Caption = '4';
                            ShowCaption = false;
                        }
                        label("5")
                        {
                            CaptionClass = '3,' + LocationArr[5, 1];
                            Caption = '5';
                            ShowCaption = false;
                        }
                        label("6")
                        {
                            CaptionClass = '3,' + LocationArr[6, 1];
                            Caption = '6';
                            ShowCaption = false;
                        }
                        label("7")
                        {
                            CaptionClass = '3,' + LocationArr[7, 1];
                            Caption = '7';
                            ShowCaption = false;
                        }
                        label("8")
                        {
                            CaptionClass = '3,' + LocationArr[8, 1];
                            Caption = '8';
                            ShowCaption = false;
                        }
                        label("9")
                        {
                            CaptionClass = '3,' + LocationArr[9, 1];
                            Caption = '9';
                            ShowCaption = false;
                        }
                        label("10")
                        {
                            CaptionClass = '3,' + LocationArr[10, 1];
                            Caption = '10';
                            ShowCaption = false;
                        }
                        label("11")
                        {
                            CaptionClass = '3,' + LocationArr[11, 1];
                            Caption = '11';
                            ShowCaption = false;
                        }
                        label("12")
                        {
                            CaptionClass = '3,' + LocationArr[12, 1];
                            Caption = '12';
                            ShowCaption = false;
                        }
                        label("13")
                        {
                            CaptionClass = '3,' + LocationArr[13, 1];
                            Caption = '13';
                            ShowCaption = false;
                        }
                        label("14")
                        {
                            CaptionClass = '3,' + LocationArr[14, 1];
                            Caption = '14';
                            ShowCaption = false;
                        }
                        label("15")
                        {
                            CaptionClass = '3,' + LocationArr[15, 1];
                            Caption = '15';
                            ShowCaption = false;
                        }
                        label("16")
                        {
                            CaptionClass = '3,' + LocationArr[16, 1];
                            Caption = '16';
                            ShowCaption = false;
                        }
                        label("17")
                        {
                            CaptionClass = '3,' + LocationArr[17, 1];
                            Caption = '17';
                            ShowCaption = false;
                        }
                        label("18")
                        {
                            CaptionClass = '3,' + LocationArr[18, 1];
                            Caption = '18';
                            ShowCaption = false;
                        }
                        label("19")
                        {
                            CaptionClass = '3,' + LocationArr[19, 1];
                            Caption = '19';
                            ShowCaption = false;
                        }
                        label("20")
                        {
                            CaptionClass = '3,' + LocationArr[20, 1];
                            Caption = '20';
                            ShowCaption = false;
                        }
                    }
                    group("New Joinees")
                    {
                        Caption = 'New Joinees';
                        field(LocationArr12; LocationArr[1, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[1, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr22; LocationArr[2, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[2, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr32; LocationArr[3, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[3, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr42; LocationArr[4, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[4, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr52; LocationArr[5, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[5, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr62; LocationArr[6, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[6, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr72; LocationArr[7, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[7, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr82; LocationArr[8, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[8, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr92; LocationArr[9, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[9, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr102; LocationArr[10, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[10, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr112; LocationArr[11, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[11, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr122; LocationArr[12, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[12, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr132; LocationArr[13, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[13, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr142; LocationArr[14, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[14, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr152; LocationArr[15, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[15, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr162; LocationArr[16, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[16, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr172; LocationArr[17, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[17, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr182; LocationArr[18, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[18, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr192; LocationArr[19, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[19, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr202; LocationArr[20, 2])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[20, 1];
                                FunctionJoinedCurrMonth(Text1);
                            end;
                        }
                    }
                    group(Resignations)
                    {
                        Caption = 'Resignations';
                        field(LocationArr13; LocationArr[1, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[1, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr23; LocationArr[2, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[2, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr33; LocationArr[3, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[3, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr43; LocationArr[4, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[4, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr53; LocationArr[5, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[5, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr63; LocationArr[6, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[6, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr73; LocationArr[7, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[7, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr83; LocationArr[8, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[8, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr93; LocationArr[9, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[9, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr103; LocationArr[10, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[10, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr113; LocationArr[11, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[11, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr123; LocationArr[12, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[12, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr133; LocationArr[13, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[13, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr143; LocationArr[14, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[14, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr153; LocationArr[15, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[15, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr163; LocationArr[16, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[16, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr173; LocationArr[17, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[17, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr183; LocationArr[18, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[18, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr193; LocationArr[19, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[19, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr203; LocationArr[20, 3])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[20, 1];
                                FunctionResignedCurrMonth(Text1);
                            end;
                        }
                    }
                    group("Terminated Employees")
                    {
                        Caption = 'Terminated Employees';
                        field(LocationArr14; LocationArr[1, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[1, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr24; LocationArr[2, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[2, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr34; LocationArr[3, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[3, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr44; LocationArr[4, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[4, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr54; LocationArr[5, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[5, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr64; LocationArr[6, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[6, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr74; LocationArr[7, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[7, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr84; LocationArr[8, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[8, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr94; LocationArr[9, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[9, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr104; LocationArr[10, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[10, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr114; LocationArr[11, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[11, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr124; LocationArr[12, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[12, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr134; LocationArr[13, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[13, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr144; LocationArr[14, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[14, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr154; LocationArr[15, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[15, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr164; LocationArr[16, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[16, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr174; LocationArr[17, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[17, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr184; LocationArr[18, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[18, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr194; LocationArr[19, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[19, 1];
                                FunctionTerminatedCurrMonth(Text1);
                            end;
                        }
                        field(LocationArr204; LocationArr[20, 4])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[20, 1];
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
                        field(LocationArr15; LocationArr[1, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[1, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr25; LocationArr[2, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[2, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr35; LocationArr[3, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[3, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr45; LocationArr[4, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[4, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr55; LocationArr[5, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[5, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr65; LocationArr[6, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[6, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr75; LocationArr[7, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[7, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr85; LocationArr[8, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[8, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr95; LocationArr[9, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[9, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr105; LocationArr[10, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[10, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr115; LocationArr[11, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[11, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr125; LocationArr[12, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[12, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr135; LocationArr[13, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[13, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr145; LocationArr[14, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[14, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr155; LocationArr[15, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[15, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr165; LocationArr[16, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[16, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr175; LocationArr[17, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[17, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr185; LocationArr[18, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[18, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr195; LocationArr[19, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[19, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                        field(LocationArr205; LocationArr[20, 5])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[20, 1];
                                FunctionProbation(Text1);
                            end;
                        }
                    }
                    group("No. Of Employees")
                    {
                        Caption = 'No. Of Employees';
                        field(LocationArr16; LocationArr[1, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[1, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr26; LocationArr[2, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[2, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr36; LocationArr[3, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[3, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr46; LocationArr[4, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[4, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr56; LocationArr[5, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[5, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr66; LocationArr[6, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[6, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr76; LocationArr[7, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[7, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr86; LocationArr[8, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[8, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr96; LocationArr[9, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[9, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr106; LocationArr[10, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[10, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr116; LocationArr[11, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[11, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr126; LocationArr[12, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[12, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr136; LocationArr[13, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[13, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr146; LocationArr[14, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[14, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr156; LocationArr[15, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[15, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr166; LocationArr[16, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[16, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr176; LocationArr[17, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[17, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr186; LocationArr[18, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[18, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr196; LocationArr[19, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[19, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                        field(LocationArr206; LocationArr[20, 6])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[20, 1];
                                FunctionTotalEmployees(Text1);
                            end;
                        }
                    }
                    group("No. of Inactive Employees")
                    {
                        Caption = 'No. of Inactive Employees';
                        field(LocationArr17; LocationArr[1, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[1, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr27; LocationArr[2, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[2, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr37; LocationArr[3, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[3, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr47; LocationArr[4, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[4, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr57; LocationArr[5, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[5, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr67; LocationArr[6, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[6, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr77; LocationArr[7, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[7, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr87; LocationArr[8, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[8, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr97; LocationArr[9, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[9, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr107; LocationArr[10, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[10, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr117; LocationArr[11, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[11, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr127; LocationArr[12, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[12, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr137; LocationArr[13, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[13, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr147; LocationArr[14, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[14, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr157; LocationArr[15, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[15, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr167; LocationArr[16, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[16, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr177; LocationArr[17, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[17, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr187; LocationArr[18, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[18, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr197; LocationArr[19, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[19, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                        field(LocationArr207; LocationArr[20, 7])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[20, 1];
                                FunctionInactive(Text1);
                            end;
                        }
                    }
                    group("No. of Resigned Employees")
                    {
                        Caption = 'No. of Resigned Employees';
                        field(LocationArr18; LocationArr[1, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[1, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr28; LocationArr[2, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[2, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr38; LocationArr[3, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[3, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr48; LocationArr[4, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[4, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr58; LocationArr[5, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[5, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr68; LocationArr[6, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[6, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr78; LocationArr[7, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[7, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr88; LocationArr[8, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[8, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr98; LocationArr[9, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[9, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr108; LocationArr[10, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[10, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr118; LocationArr[11, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[11, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr128; LocationArr[12, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[12, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr138; LocationArr[13, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[13, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr148; LocationArr[14, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[14, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr158; LocationArr[15, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[15, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr168; LocationArr[16, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[16, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr178; LocationArr[17, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[17, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr188; LocationArr[18, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[18, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr198; LocationArr[19, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[19, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                        field(LocationArr208; LocationArr[20, 8])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[20, 1];
                                FunctionResigned(Text1);
                            end;
                        }
                    }
                    group("No. of Terminated Employees")
                    {
                        Caption = 'No. of Terminated Employees';
                        field(LocationArr19; LocationArr[1, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[1, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr29; LocationArr[2, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[2, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr39; LocationArr[3, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[3, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr49; LocationArr[4, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[4, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr59; LocationArr[5, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[5, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr69; LocationArr[6, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[6, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr79; LocationArr[7, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[7, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr89; LocationArr[8, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[8, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr99; LocationArr[9, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[9, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr109; LocationArr[10, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[10, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr119; LocationArr[11, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[11, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr129; LocationArr[12, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[12, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr139; LocationArr[13, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[13, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr149; LocationArr[14, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[14, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr159; LocationArr[15, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[15, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr169; LocationArr[16, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[16, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr179; LocationArr[17, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[17, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr189; LocationArr[18, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[18, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr199; LocationArr[19, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[19, 1];
                                FunctionTerminated(Text1);
                            end;
                        }
                        field(LocationArr209; LocationArr[20, 9])
                        {
                            ApplicationArea = all;
                            trigger OnDrillDown()
                            begin

                                Text1 := '';
                                Text1 := LocationArr[20, 1];
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
        LookUp: Record "60018";
        i: Integer;
        EmployeeForm: Page 60005;
        Text1: Text[100];
        LocationArr: array[100, 9] of Text[100];

    //  [Scope('Internal')]
    procedure FunctionJoinedCurrMonth(Location: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 23);
        LookUp.SETRANGE(LookUp.Description, Location);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE("Employment Date", StartDate, EndDate);
            Employee.SETRANGE(Employee."Emp Location", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    //   [Scope('Internal')]
    procedure FunctionResignedCurrMonth(Location: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 23);
        LookUp.SETRANGE(LookUp.Description, Location);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE(Employee."Resignation Date", StartDate, EndDate);
            Employee.SETFILTER(Employee.Status, '<>%1', Employee.Status::Terminated);
            Employee.SETRANGE(Employee.Resigned, TRUE);
            Employee.SETRANGE(Employee."Emp Location", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    //  [Scope('Internal')]
    procedure FunctionTerminatedCurrMonth(Location: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 23);
        LookUp.SETRANGE(LookUp.Description, Location);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER(Employee.Status, '%1', Employee.Status::Terminated);
            Employee.SETRANGE(Employee."Termination Date", StartDate, EndDate);
            Employee.SETRANGE(Employee."Emp Location", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    // [Scope('Internal')]
    procedure FunctionProbation(Location: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 23);
        LookUp.SETRANGE(LookUp.Description, Location);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE(Employee.Probation, TRUE);
            Employee.SETRANGE(Employee."Emp Location", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    //   [Scope('Internal')]
    procedure FunctionTotalEmployees(Location: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 23);
        LookUp.SETRANGE(LookUp.Description, Location);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER(Employee.Status, '%1', Employee.Status::Active);
            Employee.SETRANGE(Employee."Emp Location", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    //  [Scope('Internal')]
    procedure FunctionInactive(Location: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 23);
        LookUp.SETRANGE(LookUp.Description, Location);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE(Employee.Status, Employee.Status::Inactive);
            Employee.SETRANGE(Employee."Emp Location", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    // [Scope('Internal')]
    procedure FunctionResigned(Location: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 23);
        LookUp.SETRANGE(LookUp.Description, Location);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER(Employee.Status, '<>%1', Employee.Status::Terminated);
            Employee.SETRANGE(Resigned, TRUE);
            Employee.SETRANGE(Employee."Emp Location", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;

    //  [Scope('Internal')]
    procedure FunctionTerminated(Location: Text[100])
    begin
        CLEAR(EmployeeForm);
        LookUp.RESET;
        LookUp.SETRANGE(LookUp."Lookup Type", 23);
        LookUp.SETRANGE(LookUp.Description, Location);
        IF LookUp.FINDFIRST THEN BEGIN
            Employee.RESET;
            Employee.SETRANGE(Employee.Status, Employee.Status::Terminated);
            Employee.SETRANGE(Employee."Emp Location", LookUp."Lookup Name");
            EmployeeForm.SETTABLEVIEW(Employee);
            EmployeeForm.RUNMODAL;
        END;
    end;
}

