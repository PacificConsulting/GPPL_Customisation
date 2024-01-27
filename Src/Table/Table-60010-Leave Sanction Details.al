table 60010 "Leave Sanction Details"
{

    fields
    {
        field(1; "Employee Code"; Code[20])
        {
        }
        field(2; "Leave Code"; Code[20])
        {
        }
        field(3; "From Date"; Date)
        {
        }
        field(4; "To Date"; Date)
        {
        }
        field(5; "Sanctioned By"; Code[20])
        {
            //TableRelation = 60067.Field2 WHERE (Field1 = FIELD("Employee Code"));

            trigger OnValidate()
            begin
                LeaveApp.SETRANGE("Employee No.", "Employee Code");
                LeaveApp.SETRANGE("From Date", "From Date");
                LeaveApp.SETRANGE("To Date", "To Date");
                IF LeaveApp.FIND('-') THEN BEGIN
                    IF "Sanctioned By" <> '' THEN
                        LeaveApp.Sanctioned := TRUE;
                    LeaveApp.MODIFY;
                END;
            end;
        }
        field(6; "Date of Sanction"; Date)
        {
        }
        field(7; Remarks; Text[100])
        {
        }
        field(8; "No.of Days"; Decimal)
        {
        }
        field(9; "Reasons For Leave"; Text[150])
        {
        }
        field(10; "Leave Duration"; Option)
        {
            OptionMembers = " ","Half day",Leave;
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Leave Code", "From Date", "To Date", "Sanctioned By")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LeaveApp: Record 60032;
}

