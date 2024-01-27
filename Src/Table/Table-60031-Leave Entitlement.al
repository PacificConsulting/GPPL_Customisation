table 60031 "Leave Entitlement"
{
    DrillDownPageID = 60023;
    LookupPageID = 60023;

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee_;
        }
        field(3; "Leave Code"; Code[20])
        {
            TableRelation = "Leave Master";
        }
        field(4; "No.of Leaves"; Decimal)
        {
        }
        field(5; "Leave Year Closing Period"; Date)
        {
        }
        field(6; "Leaves Carried"; Decimal)
        {
        }
        field(7; "Total Leaves"; Decimal)
        {
        }
        field(8; "Leaves taken during Month"; Decimal)
        {
            //FieldClass = FlowField;
            // CalcFormula = Sum("Daily Attendance".Leave WHERE("Employee No." = FIELD("Employee No."),
            //                                                   "Leave Code" = FIELD("Leave Code"),
            //                                                   Year = FIELD(Year),
            //                                                   Month = FIELD(Month),
            //                                                   "Loss Of Pay" = FILTER(false)));

        }
        field(9; "Leave Bal. at the Month End"; Decimal)
        {
        }
        field(10; "Leaves Carried next Month"; Decimal)
        {
        }
        field(11; Month; Integer)
        {
        }
        field(12; Year; Integer)
        {
        }
        field(13; "Leaves Expired"; Decimal)
        {
        }
        field(14; Probation; Boolean)
        {
        }
        field(15; "Leave Encashed"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Leave Encashed"."Leaves to Encash" WHERE("Employee Code" = FIELD("Employee No."),
                                                                         "Leave Code" = FIELD("Leave Code")));

        }
        field(16; "Leave to Encash"; Decimal)
        {

            trigger OnValidate()
            begin
                /*Bhavani
                LeaveMaster.setrange("Leave Code","Leave Code");
                if leavemaster.find('-') then begin
                  if  >= LeaveMaster."Encashment in excess of." then
                end;
                Bhavani*/

            end;
        }
        field(17; "Encashed Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Leave Encashed"."Encash Amount" WHERE("Employee Code" = FIELD("Employee No."),
                                                                      Year = FIELD(Year),
                                                                      Month = FIELD(Month),
                                                                      "Leave Code" = FIELD("Leave Code")));

        }
        field(18; "Employee Name"; Code[50])
        {
        }
        field(19; "Opening Balance"; Decimal)
        {

            trigger OnValidate()
            begin
                MonAttendance.SETRANGE("Employee Code", "Employee No.");
                //MonAttendance.SETRANGE(Processed, TRUE);
                IF MonAttendance.FIND('-') THEN
                    ERROR(Text000);

                "Total Leaves" := "Total Leaves" + "Opening Balance";
            end;
        }
        field(22; Status; Option)
        {
            OptionMembers = Application,Leave,Cancelled,LeaveCutFromLateHrs;
        }
        field(72; LeavesUsedForSickLeaves; Decimal)
        {
        }
        field(73; LeavesUsedForCasualLeaves; Decimal)
        {
        }
        field(74; "Leave Avail. at the Month"; Decimal)
        {
        }
        field(75; CLLeavesToAddAfterProbation; Decimal)
        {
        }
        field(76; ELLeavesToAddAfterYear; Decimal)
        {
        }
        field(77; "Late Hours Deduction Days"; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Lookup("Monthly Attendance"."Leave Cut For LateHrs" WHERE("Employee Code" = FIELD("Employee No."),
            //                                                                          "Pay Slip Month" = FIELD(Month),
            //                                                                          Year = FIELD(Year)));
            Editable = false;

        }
    }

    keys
    {
        key(Key1; "Entry No.", Month)
        {
            Clustered = true;
        }
        key(Key2; "Employee No.", "Leave Code", Year, Month)
        {
            SumIndexFields = "Leave Bal. at the Month End";
        }
    }

    fieldgroups
    {
    }

    var
        MonAttendance: Record 60029;
        Text000: Label 'You can''t modify the opening balance.';
        LeaveMaster: Record 60030;
}

