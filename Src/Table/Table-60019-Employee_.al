table 60019 Employee_
{
    Caption = 'Employee_';
    DataCaptionFields = "No.", "First Name", "Middle Name", "Last Name";
    DrillDownPageID = 60005;
    LookupPageID = 60005;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(3; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
        }
        field(4; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(5; Initials; Text[30])
        {
            Caption = 'Initials';

            trigger OnValidate()
            begin
                IF ("Search Name" = UPPERCASE(xRec.Initials)) OR ("Search Name" = '') THEN
                    "Search Name" := Initials;
            end;
        }
        field(6; "Job Title"; Text[30])
        {
            Caption = 'Job Title';
        }
        field(7; "Search Name"; Code[30])
        {
            Caption = 'Search Name';
        }
        field(8; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(9; "Address 2"; Text[100])
        {
            Caption = 'Address 2';
        }
        field(10; City; Text[30])
        {
            Caption = 'City';

            trigger OnValidate()
            begin
                Postcode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                Postcode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(12; County; Text[30])
        {
            Caption = 'County';
            TableRelation = "Country/Region";
        }
        field(13; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(14; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
        }
        field(15; "E-Mail"; Text[35])
        {
            Caption = 'E-Mail';
        }
        field(16; "DA Type"; Option)
        {
            Description = 'VE-003';
            OptionCaption = 'Normal,Night Out,State Office';
            OptionMembers = Normal,"Night Out","State Office";
        }
        field(19; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(20; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
        }
        field(21; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
        }
        field(24; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(25; "Country/Region Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(26; "Manager No."; Code[20])
        {
            Caption = 'Manager No.';
            Enabled = false;
            TableRelation = Employee;
        }
        field(29; "Employment Date"; Date)
        {
            Caption = 'Employment Date';

            trigger OnValidate()
            begin
                IF "Employment Date" <> xRec."Employment Date" THEN BEGIN
                    MonthlyAttendance.RESET;
                    MonthlyAttendance.SETRANGE("Employee Code", "No.");
                    IF MonthlyAttendance.FIND('-') THEN
                        ERROR('Attendance Already Generated.\Modification Not Allowed...');
                END;
            end;
        }
        field(31; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;

            trigger OnValidate()
            begin
                //EBT Paramita
                IF Status = Status::Active THEN
                    "Inactive Date" := 0D;
            end;
        }
        field(32; "Inactive Date"; Date)
        {
            Caption = 'Inactive Date';

            trigger OnValidate()
            begin
                //EBT Paramita
                IF Status = Status::Active THEN BEGIN
                    IF "Inactive Date" <> 0D THEN
                        ERROR('Employee status is active');
                END;
            end;
        }
        field(33; "Cause of Inactivity Code"; Code[10])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('CAUSES OF INACTIVITY'));
        }
        field(34; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
        }
        field(35; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('GROUNDS OF TERMINATION'));
        }
        field(36; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(38; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            Enabled = false;
            TableRelation = Resource WHERE(Type = CONST(Person));
        }
        field(39; Comment; Boolean)
        {
            // CalcFormula = Exist("Human Resource Comment Line" WHERE(Table Name=CONST(Employee),
            //                                                          No.=FIELD(No.)));
            // Caption = 'Comment';
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(40; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(41; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(42; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(43; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(44; "Cause of Absence Filter"; Code[10])
        {
            Caption = 'Cause of Absence Filter';
            FieldClass = FlowFilter;
            TableRelation = "Cause of Absence";
        }
        field(46; Extension; Text[30])
        {
            Caption = 'Extension';
        }
        field(47; "Employee No. Filter"; Code[20])
        {
            Caption = 'Employee No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(48; Pager; Text[30])
        {
            Caption = 'Pager';
        }
        field(49; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(50; "Company E-Mail"; Text[35])
        {
            Caption = 'Company E-Mail';
        }
        field(51; Title; Text[30])
        {
            Caption = 'Title';
        }
        field(52; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(53; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(56; "Department Code"; Code[30])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));

            trigger OnValidate()
            begin
                "Old Dept Code" := xRec."Department Code";
                "Transfer Date" := WORKDATE;
            end;
        }
        field(57; Designation; Code[50])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('DESIGNATIONS'));
        }
        field(58; "Martial status"; Option)
        {
            Caption = 'Marital Status';
            OptionMembers = Married,Single;
        }
        field(59; "Spouse Name"; Code[50])
        {
        }
        field(60; "Marraige Date"; Date)
        {
            Caption = 'Wedding Date';
        }
        field(61; "No. Of Children"; Integer)
        {
        }
        field(62; "Driving License No."; Code[20])
        {
        }
        field(63; "PAN No"; Code[20])
        {
        }
        field(64; "ESI No"; Text[10])
        {
        }
        field(65; "ESI Dispensary"; Text[10])
        {
        }
        field(66; "Father/Husband"; Text[30])
        {
        }
        field(67; "PF No"; Text[20])
        {
        }
        field(68; "Blood Group"; Option)
        {
            OptionMembers = " ","A+","A-","B+","B-","AB+","AB-","O+","O-";
        }
        field(69; "Payment Method"; Option)
        {
            OptionMembers = Cash,Cheque,"Bank Transfer";
        }
        field(70; "Bank Code"; Code[10])
        {
        }
        field(72; "Bank Name"; Text[20])
        {
        }
        field(73; "Bank Branch"; Text[20])
        {
        }
        field(74; "Account Type"; Text[30])
        {
        }
        field(75; "Account No"; Code[20])
        {
        }
        field(76; "Resignation Date"; Date)
        {

            trigger OnValidate()
            begin
                IF NOT Resigned THEN BEGIN
                    IF "Resignation Date" <> 0D THEN
                        ERROR('This employee has not resigned');
                END;
            end;
        }
        field(77; "Confirmation Date"; Date)
        {
        }
        field(79; Passport; Code[20])
        {
        }
        field(80; Experience; Integer)
        {
        }
        field(81; "Release Status"; Option)
        {
            OptionMembers = Open,Released;
        }
        field(82; Blocked; Boolean)
        {

            trigger OnValidate()
            begin
                IF Blocked THEN
                    "Post to GL" := FALSE;


                "Blocked Date" := WORKDATE;
                MonthlyAttendance.RESET;
                MonthlyAttendance.SETRANGE("Employee Code", "No.");
                IF MonthlyAttendance.FIND('-') THEN
                    REPEAT
                        //VE-003 >>
                        /*
                        IF (MonthlyAttendance.Year > DATE2DMY("Blocked Date",3))OR
                           ((MonthlyAttendance.Year = DATE2DMY("Blocked Date",3)) AND
                           (MonthlyAttendance."Pay Slip Month" >= DATE2DMY("Blocked Date",2)))
                        THEN
                        */
                        //VE-003 <<
                        MonthlyAttendance."Post to GL" := FALSE;
                        MonthlyAttendance.Blocked := Blocked;
                        MonthlyAttendance.MODIFY;
                    UNTIL MonthlyAttendance.NEXT = 0;

                IF NOT Blocked THEN
                    "Blocked Date" := 0D;

            end;
        }
        field(83; Probation; Boolean)
        {
        }
        field(84; "Attendance Not Generated"; Boolean)
        {
        }
        field(85; "OT Applicable"; Boolean)
        {
        }
        field(86; "OT Calculation Rate"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            InitValue = 0;
            MinValue = 0;

            trigger OnValidate()
            begin
                IF NOT "OT Applicable" THEN BEGIN
                    IF "OT Calculation Rate" <> 0 THEN
                        ERROR('OT is not applicable');
                END;
            end;
        }
        field(87; "Leaves Not Generated"; Boolean)
        {
        }
        field(88; "ESI Applicable"; Boolean)
        {
        }
        field(89; "PF Applicable"; Boolean)
        {
        }
        field(90; "Branch Code"; Code[20])
        {
            TableRelation = "Professional Tax Header";
        }
        field(101; "Emp Posting Group"; Code[20])
        {
            TableRelation = "Employee Posting Group".Code;
        }
        field(102; "Payroll Bus. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(103; "Pay Cadre"; Code[20])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));

            trigger OnValidate()
            var
                PayCadrePayElement: Record 60026;
                PayElement: Record 60025;
                Text000: Label 'You cannot modify the pay cadre.';
            begin
                MonthlyAttendance.RESET;
                MonthlyAttendance.SETRANGE("Employee Code", "No.");
                MonthlyAttendance.SETRANGE(Posted, TRUE);
                IF MonthlyAttendance.FIND('-') THEN
                    ERROR(Text000);

                PayElement.SETRANGE("Employee Code", "No.");
                PayElement.SETRANGE("Pay Cadre", xRec."Pay Cadre");
                IF PayElement.FIND('-') THEN
                    PayElement.DELETEALL;

                Lookup.SETRANGE("LookupType Name", 'PAY CADRE');
                Lookup.SETRANGE("Lookup Name", "Pay Cadre");
                IF Lookup.FIND('-') THEN BEGIN
                    Lookup.TESTFIELD("Period Start Date");
                    Lookup.TESTFIELD("Period Start Date");
                    "Period Start Date" := Lookup."Period Start Date";
                    "Period End Date" := Lookup."Period End Date";
                    Probation := Lookup.Probation;
                    MODIFY;
                END;

                GetPayCadrePayElements(Rec);
                PayCadrePayElement.RESET;
                IF PayCadrePayElement.FIND('-') THEN
                    REPEAT
                        PayCadrePayElement.Processed := FALSE;
                        PayCadrePayElement.MODIFY;
                    UNTIL PayCadrePayElement.NEXT = 0;
            end;
        }
        field(104; "Period Start Date"; Date)
        {
        }
        field(105; "Period End Date"; Date)
        {
        }
        field(106; "Balance Amt(LCY)"; Decimal)
        {
            // CalcFormula = Sum("Monthly Attendance"."Remaining Amount" WHERE (Employee Code=FIELD(No.),
            //                                                                  Posted=CONST(Yes),
            //                                                                  Reversed=CONST(No)));
            // DecimalPlaces = 2:2;
            // FieldClass = FlowField;
        }
        field(108; "PT Applicable"; Boolean)
        {
        }
        field(109; "Blocked Date"; Date)
        {
            Editable = false;
        }
        field(110; "Resume DB No."; Code[20])
        {
        }
        field(111; "User Id"; Code[50])
        {
            TableRelation = User."User Name";
        }
        field(116; "VDA Applicable"; Boolean)
        {
        }
        field(117; "FDA Applicable"; Boolean)
        {
        }
        field(118; "Stop Payment"; Boolean)
        {
        }
        field(119; "ESI Branch"; Text[30])
        {
        }
        field(150; "Old Dept Code"; Code[20])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('DEPARTMENTS'));
        }
        field(151; "Transfer Date"; Date)
        {
        }
        field(152; "Transfer Reason"; Text[50])
        {
        }
        field(153; Resigned; Boolean)
        {

            trigger OnValidate()
            begin
                MonthlyAttendance.RESET;
                MonthlyAttendance.SETRANGE("Employee Code", "No.");
                IF MonthlyAttendance.FIND('-') THEN
                    REPEAT
                        MonthlyAttendance.Resigned := Resigned;
                        MonthlyAttendance.MODIFY;
                    UNTIL MonthlyAttendance.NEXT = 0;
            end;
        }
        field(154; Nominee; Text[50])
        {
        }
        field(155; "Emp Code Ref"; Code[20])
        {
        }
        field(200; Division; Code[10])
        {
        }
        field(201; "Post to GL"; Boolean)
        {
            Description = 'VE-003';
        }
        field(202; "Father's First Name"; Text[20])
        {
            Description = 'VE-026';
        }
        field(203; "Father's Middle Name"; Text[40])
        {
            Description = 'VE-026';
        }
        field(204; "Father's Last  Name"; Text[20])
        {
            Description = 'VE-026';
        }
        field(206; "Mother's First Name"; Text[20])
        {
            Description = 'VE-026';
        }
        field(207; "Mother's Middle Name"; Text[40])
        {
            Description = 'VE-026';
        }
        field(208; "Mother's Last  Name"; Text[20])
        {
            Description = 'VE-026';
        }
        field(209; "Place of birthVilage/town/city"; Text[20])
        {
            Description = 'VE-026';
        }
        field(210; "Place of birth District"; Text[20])
        {
            Description = 'VE-026';
        }
        field(211; "Place of birth State"; Text[20])
        {
            Description = 'VE-026';
        }
        field(212; "Place of birth Country"; Text[20])
        {
            Description = 'VE-026';
        }
        field(216; "Correspondence  Door no"; Text[20])
        {
            Description = 'VE-026';
        }
        field(217; "Corres Name of Premises/villag"; Text[20])
        {
            Description = 'VE-026';
        }
        field(218; "Corres Road/strre/Lane"; Text[20])
        {
            Description = 'VE-026';
        }
        field(219; "Corres Area/locality/taluka"; Text[20])
        {
            Description = 'VE-026';
        }
        field(220; "Corres town"; Text[20])
        {
            Description = 'VE-026';
        }
        field(221; "Corres State"; Code[20])
        {
            Description = 'VE-026';
            TableRelation = State.Code;
        }
        field(222; "Corres Country"; Code[10])
        {
            Description = 'VE-026';
            TableRelation = "Country/Region";
        }
        field(223; "Perminant  Door no"; Text[20])
        {
            Description = 'VE-026';
        }
        field(224; "perm. Name of Premises/villag"; Text[20])
        {
            Description = 'VE-026';
        }
        field(225; "Perminant Road/strre/Lane"; Text[20])
        {
            Description = 'VE-026';
        }
        field(226; "Perminant Area/locality/taluka"; Text[20])
        {
            Description = 'VE-026';
        }
        field(227; "Perminant town"; Text[20])
        {
            Description = 'VE-026';
        }
        field(228; "Perminant State"; Code[10])
        {
            Description = 'VE-026';
            //   TableRelation = State;
        }
        field(229; "Perminant Country"; Code[10])
        {
            Description = 'VE-026';
            TableRelation = "Country/Region";
        }
        field(230; "Name on SSN Card"; Text[20])
        {
            Description = 'VE-026';
        }
        field(231; "Father Name on SSn Card"; Text[20])
        {
            Description = 'VE-026';
        }
        field(232; "Pension A/c (Exempted Establis"; Text[20])
        {
            Description = 'VE-026';
        }
        field(233; "perminant pincode"; Text[6])
        {
            Description = 'VE-026';
        }
        field(234; "Corres PinCode"; Text[6])
        {
            Description = 'VE-026';
        }
        field(235; "DofB year"; Integer)
        {
            Description = 'VE-026';
        }
        field(236; Nationality; Option)
        {
            Description = 'VE-026';
            OptionCaption = 'Indian,Other';
            OptionMembers = Indian,Other;

            trigger OnValidate()
            begin
                //VE-026
                IF Nationality = Nationality::Indian THEN BEGIN
                    "Nationality country" := '';
                END;
                //VE-026
            end;
        }
        field(237; "Nationality country"; Text[30])
        {
            Description = 'VE-026';
            Enabled = false;

            trigger OnValidate()
            begin
                //VE-026
                IF Nationality = Nationality::Indian THEN BEGIN
                    "Nationality country" := '';
                END;
                //VE-026
            end;
        }
        field(238; "Nominee Add."; Text[250])
        {
            Description = 'VE-026';
        }
        field(239; "Nominee Relationship"; Text[30])
        {
            Description = 'VE-026';
        }
        field(276; "Marital Status"; Option)
        {
            OptionCaption = 'Married,Unmarried,Widow';
            OptionMembers = Married,Unmarried,Widow;
        }
        field(277; TYPE; Option)
        {
            OptionMembers = "Branch Office","Dispensary ";
        }
        field(278; Dispensary; Text[20])
        {
        }
        field(279; "Probn.Duration"; DateFormula)
        {
        }
        field(280; ProbLeavesAdded; Boolean)
        {
        }
        field(281; "Emp Status"; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Release';
            OptionMembers = Open,Release;

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(283; "Emp Location"; Code[10])
        {
            Caption = 'Location';
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = FILTER('EMP LOCATION'));
        }
        field(284; "State Code"; Code[10])
        {
            TableRelation = State;
        }
        field(285; PF; Boolean)
        {
        }
        field(60000; "Work Permit Number"; Code[10])
        {
        }
        field(60001; "Work Permit Exp. Date"; Date)
        {
        }
        field(60002; "Pay Card Number"; Code[10])
        {
        }
        field(60003; "Passport Number"; Code[2])
        {
        }
        field(60004; "Insurence Company Name"; Text[30])
        {
        }
        field(60005; "insurence No."; Code[10])
        {
        }
        field(60006; "Home Country Number"; Option)
        {
            OptionMembers = "91","92","93","971";
        }
        field(60007; "Office Type"; Code[50])
        {
            Caption = 'Office Type';
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('OFFICE TYPE'));
        }
        field(60008; "Next Leave Salary Date"; Date)
        {
        }
        field(60009; Worker; Boolean)
        {
        }
        field(60010; "Senior Citizen"; Boolean)
        {
        }
        field(60011; "Pervious Employer Name"; Text[30])
        {
        }
        field(60012; "Previous Designation"; Text[30])
        {
        }
        field(60013; "Previous CTC"; Decimal)
        {
        }
        field(60014; "Period From"; Date)
        {

            trigger OnValidate()
            begin
                IF "Period To" <> 0D THEN BEGIN
                    IF "Period From" <> 0D THEN BEGIN
                        TotalTime := FORMAT("Period To" - "Period From");
                        "Net Period" := TotalTime + 'D';
                    END;
                END;
            end;
        }
        field(60015; "Period To"; Date)
        {

            trigger OnValidate()
            begin
                IF "Period To" <> 0D THEN BEGIN
                    IF "Period From" <> 0D THEN BEGIN
                        TotalTime := FORMAT("Period To" - "Period From");
                        "Net Period" := TotalTime + 'D';
                    END;
                END;
            end;
        }
        field(60016; "Net Period"; Text[30])
        {
        }
        field(60017; Category; Code[30])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('CATEGORY'));
        }
        field(60018; Qualification; Code[30])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('QUALIFICATION'));
        }
        field(60019; "Interview No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; Status)
        {
        }
        key(Key4; "Last Name", "First Name", "Middle Name")
        {
        }
        key(Key5; "Bank Name", "No.")
        {
        }
        key(Key6; "Department Code")
        {
        }
        key(Key7; Designation)
        {
        }
        key(Key8; "PF No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        DailyAttendance: Record 60028;
        MonthlyAttendance: Record 60029;
        LeaveEntitle: Record 60031;
        EmployeeShift: Record 60023;
        PayElements: Record 60025;
    begin
        MonthlyAttendance.RESET;
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        MonthlyAttendance.SETRANGE(Posted, TRUE);
        IF MonthlyAttendance.FIND('-') THEN
            ERROR(Text000, "No.");

        ProcessedSal.RESET;
        ProcessedSal.SETRANGE(ProcessedSal."Employee Code", "No.");
        IF ProcessedSal.FIND('-') THEN
            ERROR(Text000, "No.");

        DailyAttendance.SETRANGE("Employee No.", "No.");
        IF DailyAttendance.FIND('-') THEN
            DailyAttendance.DELETEALL;

        MonthlyAttendance.RESET;
        MonthlyAttendance.SETRANGE("Employee Code", "No.");
        IF MonthlyAttendance.FIND('-') THEN
            MonthlyAttendance.DELETEALL;

        LeaveEntitle.SETRANGE("Employee No.", "No.");
        IF LeaveEntitle.FIND('-') THEN
            LeaveEntitle.DELETEALL;

        EmployeeShift.SETRANGE("Employee Code", "No.");
        IF EmployeeShift.FIND('-') THEN
            EmployeeShift.DELETEALL;

        PayElements.SETRANGE("Employee Code", "No.");
        IF PayElements.FIND('-') THEN
            PayElements.DELETEALL;
    end;

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup."Employee No.");
            //NoSeriesMgt.InitSeries(HRSetup."Employee No.",xRec."No. Series",0D,"No.","No. Series");
        END;
        "Attendance Not Generated" := TRUE;
        "Leaves Not Generated" := TRUE;
        "ESI Applicable" := TRUE;
        "PF Applicable" := TRUE;
        "PT Applicable" := TRUE;

        "Last Date Modified" := TODAY;
    end;

    trigger OnModify()
    begin
        TestStatusOpen;
        "Last Date Modified" := TODAY;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := TODAY;
    end;

    var
        Postcode: Record 225;
        HRSetup: Record 60016;
        Employee: Record 60019;
        Lookup: Record 60018;
        //DimMgt: Codeunit 408;
        //NoSeriesMgt: Codeunit 396;
        Text000: Label 'You cannot delete Employee %1 because one or more General  ledger entries exist for this employee.';
        MonthlyAttendance: Record 60029;
        Check: Boolean;
        shapeexists: Boolean;
        Day: Integer;
        CurrYear: Integer;
        MonthValue: Integer;
        LeaveEntitle: Record 60031;
        LeaveMaster: Record 60030;
        emp: Record 60019;
        Lev: Decimal;
        Prohbitdate: Date;
        //Monthlyatt: Page 60018;
        Emp1: Record 60019;
        LeaveMaster1: Record 60030;
        Lev1: Decimal;
        MonthlyAttend1: Record 60029;
        ELLeaves: Text[30];
        date1: Date;
        year1: Integer;
        mon1: Integer;
        emp2: Record 60019;
        L1: Decimal;
        LEnt: Record 60031;
        Aleaves: Decimal;
        MA: Record 60029;
        ProcessedSal: Record 60038;
        TotalTime: Text[30];

    // [Scope('Internal')]
    procedure AssistEdit(OldEmployee: Record 60019): Boolean
    begin
        //VE-026
        WITH Employee DO BEGIN
            Employee := Rec;
            HRSetup.GET;
            HRSetup.TESTFIELD("Employee No.");
            /*
            IF NoSeriesMgt.SelectSeries(HRSetup."Employee No.", OldEmployee."No. Series", "No. Series") THEN BEGIN
                HRSetup.GET;
                HRSetup.TESTFIELD("Employee No.");
                NoSeriesMgt.SetSeries("No.");
                Rec := Employee;
                EXIT(TRUE);
            END;
            */
        END;
        //VE-026
    end;

    // [Scope('Internal')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        //VE-026
        //DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        //DimMgt.SaveDefaultDim(DATABASE::Employee_, "No.", FieldNumber, ShortcutDimCode);
        MODIFY;
        //VE-026
    end;

    //  [Scope('Internal')]
    procedure FullName(): Text[100]
    begin
        //VE-026
        IF "Middle Name" = '' THEN
            EXIT("First Name" + ' ' + "Last Name")
        ELSE
            EXIT("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
        //VE-026
    end;

    // [Scope('Internal')]
    procedure Attachments()
    begin
        /*Attachment.RESET;
        Attachment.SETRANGE(TableID,DATABASE::Employee_);
        Attachment.SETRANGE(DocumentNo,"No.");
        FORM.RUNMODAL(FORM::"Lookup Types",Attachment);*/

    end;

    // [Scope('Internal')]
    procedure GetPayCadrePayElements(Employee: Record 60019)
    var
        PayCadrePayElement: Record 60026;
        PayCadrePayElement2: Record 60026;
        PayElements: Record 60025;
        HRSetup: Record 60016;
        CheckDate: Date;
    begin
        IF HRSetup.FIND('-') THEN
            CheckDate := DMY2DATE(1, HRSetup."Salary Processing month", HRSetup."Salary Processing Year");
        PayCadrePayElement.SETRANGE("Pay Cadre Code", Employee."Pay Cadre");
        PayCadrePayElement.SETRANGE(PayCadrePayElement.Processed, FALSE);
        IF PayCadrePayElement.FIND('-') THEN BEGIN
            REPEAT
                PayCadrePayElement2.SETRANGE(PayCadrePayElement2.Processed, FALSE);
                PayCadrePayElement2.SETRANGE("Pay Cadre Code", PayCadrePayElement."Pay Cadre Code");
                PayCadrePayElement2.SETRANGE("Pay Element Code", PayCadrePayElement."Pay Element Code");
                IF PayCadrePayElement2.FIND('-') THEN BEGIN
                    REPEAT
                        PayCadrePayElement2.Processed := TRUE;
                        PayCadrePayElement2.MODIFY;
                        IF PayCadrePayElement2."Effective Start Date" <= CheckDate THEN BEGIN
                            PayElements."Employee Code" := Employee."No.";
                            PayElements."Effective Start Date" := PayCadrePayElement2."Effective Start Date";
                            PayElements."Pay Element Code" := PayCadrePayElement2."Pay Element Code";
                            PayElements."Fixed/Percent" := PayCadrePayElement2."Fixed/Percent";
                            PayElements."Computation Type" := PayCadrePayElement2."Computation Type";
                            PayElements."Loan Priority No" := PayCadrePayElement2."Loan Priority No";
                            PayElements."Add/Deduct" := PayCadrePayElement2."Add/Deduct";
                            PayElements.VALIDATE("Amount / Percent", PayCadrePayElement2."Amount / Percent");
                            PayElements."Applicable for OT" := PayCadrePayElement2."Applicable for OT";
                            PayElements.Processed := FALSE;
                            PayElements.ESI := PayCadrePayElement2.ESI;
                            PayElements.PF := PayCadrePayElement2.PF;
                            PayElements."Leave Encashment" := PayCadrePayElement2."Leave Encashment";
                            PayElements."Pay Cadre" := Employee."Pay Cadre";
                        END;
                    UNTIL PayCadrePayElement2.NEXT = 0;
                    PayElements.INSERT;
                END;
            UNTIL PayCadrePayElement.NEXT = 0;
        END;
    end;

    //  [Scope('Internal')]
    procedure "----Payroll----"()
    begin
    end;

    //  [Scope('Internal')]
    procedure AttendanceUpdation()
    var
        DailyAttendance: Record 60028;
    begin
        DailyAttendance.SETRANGE("Employee No.", "No.");
        IF DailyAttendance.FIND('-') THEN
            REPEAT
                IF DailyAttendance.Date < "Employment Date" THEN BEGIN
                    IF NOT DailyAttendance."Non-Working" THEN BEGIN
                        DailyAttendance."Attendance Type" := DailyAttendance."Attendance Type"::Absent;
                        DailyAttendance.Present := 0;
                        DailyAttendance.Absent := 1;
                        DailyAttendance.Leave := 0;
                    END;
                END;
                DailyAttendance.MODIFY;
            UNTIL DailyAttendance.NEXT = 0;
    end;


    procedure "-----Leaves-----"()
    begin
    end;

    //  [Scope('Internal')]
    procedure GenerateLeavesForNewEmp(var MonthlyAtte: Record 60029)
    var
        LeaveMaster: Record 60030;
        LeaveEntitlement: Record 60031;
        LeaveEntitlement2: Record 60031;
        PayYear: Record 60020;
        LeaveEntitlement3: Record 60031;
        StartDate: Date;
        EndDate: Date;
        Text0000: Label 'Leaves created for the employee';
        Text0001: Label 'Leaves are already created';
        Num: Integer;
    begin
        SETRANGE("No.", MonthlyAtte."Employee Code");
        IF FIND('-') THEN BEGIN
            PayYear.SETRANGE("Year Type", 'LEAVE YEAR');
            PayYear.SETRANGE(Closed, FALSE);
            IF PayYear.FIND('-') THEN BEGIN
                StartDate := PayYear."Year Start Date";
                EndDate := PayYear."Year End Date";
            END;

            TESTFIELD("Pay Cadre");
            MonthValue := DATE2DMY("Employment Date", 2);
            IF NOT Blocked THEN BEGIN
                IF Probation THEN BEGIN
                    //InsertLeaveEntitle(StartDate,EndDate);
                    NewRegularEmpLeaves(StartDate, EndDate, MonthlyAtte);
                    "Leaves Not Generated" := FALSE;
                    MODIFY
                END ELSE BEGIN
                    NewRegularEmpLeaves(StartDate, EndDate, MonthlyAtte);
                    "Leaves Not Generated" := FALSE;
                    MODIFY;
                END;
            END;
        END;
    end;

    //  [Scope('Internal')]
    procedure NewRegularEmpLeaves(StartDate: Date; EndDate: Date; Monthlyattendance: Record 60029)
    var
        LeaveMaster: Record 60030;
        LeaveEntitlement2: Record 60031;
        LeaveEntitlement3: Record 60031;
        LeaveEntitlement: Record 60031;
        PayYear: Record 60020;
        CreditingDate: Date;
        CreditingLeaves: Decimal;
        CreditingMonth: Integer;
        CreditingYear: Integer;
        Num: Integer;
        Lavail: Decimal;
    begin
        LeaveMaster.RESET;
        IF LeaveMaster.FIND('-') THEN BEGIN
            REPEAT
                IF LeaveEntitlement2.FIND('+') THEN
                    Num := LeaveEntitlement2."Entry No."
                ELSE
                    Num := 0;

                LeaveEntitlement.INIT;
                LeaveEntitlement."Entry No." := Num + 1;
                LeaveEntitlement."Employee No." := "No.";
                LeaveEntitlement."Employee Name" := "First Name";
                LeaveEntitlement.Probation := Probation;
                LeaveEntitlement."Leave Code" := LeaveMaster."Leave Code";
                LeaveEntitlement.CALCFIELDS("Leaves taken during Month");
                //VE-026

                IF LeaveEntitlement."Leave Code" = 'SL' THEN BEGIN
                    LeaveEntitlement."No.of Leaves" := LeaveMaster."No. of Leaves in Year";
                    GetLeavesforSl(Monthlyattendance);
                    LeaveEntitlement."Leave Avail. at the Month" := GetLeavesforSl(Monthlyattendance);
                    Monthlyattendance.CALCFIELDS(LeavesUsedForSickLeaves);
                    LeaveEntitlement."Leaves taken during Month" := Monthlyattendance.LeavesUsedForSickLeaves;

                    LeaveEntitlement."Leave Bal. at the Month End" :=
                    (GetLeavesforSl(Monthlyattendance) - LeaveEntitlement."Leaves taken during Month");
                    IF LeaveEntitlement."Leave Bal. at the Month End" <= 0 THEN
                        LeaveEntitlement."Leave Bal. at the Month End" := 0;
                    //VE-026 end


                END;

                IF LeaveEntitlement."Leave Code" = 'CL' THEN BEGIN
                    LeaveEntitlement."No.of Leaves" := LeaveMaster."No. of Leaves in Year";
                    LeaveEntitlement."Leave Avail. at the Month" := Monthlyattendance."Leaves Available";
                    Monthlyattendance.CALCFIELDS(LeavesUsedForcasualLeaves);
                    LeaveEntitlement."Leaves taken during Month" := Monthlyattendance.LeavesUsedForcasualLeaves;
                    LeaveEntitlement."Leave Bal. at the Month End" :=
                    ((LeaveEntitlement."Leave Avail. at the Month") - (LeaveEntitlement."Leaves taken during Month"));
                    IF LeaveEntitlement."Leave Bal. at the Month End" > 0 THEN
                        LeaveEntitlement."Leave Bal. at the Month End" := LeaveEntitlement."Leave Bal. at the Month End" -
                        Monthlyattendance."Leave Cut For LateHrs";
                    IF LeaveEntitlement."Leave Bal. at the Month End" <= 0 THEN
                        LeaveEntitlement."Leave Bal. at the Month End" := 0;

                    //IF LeaveEntitlement.Probation THEN
                    //   LeaveEntitlement.CLLeavesToAddAfterProbation := Monthlyatt.AddingProbationLeaves(Monthlyattendance)
                    //ELSE
                    //  LeaveEntitlement.CLLeavesToAddAfterProbation := 0;
                END;


                // Monthlyattendance.CALCFIELDS(LeavesUsedForEarnedLeaves);
                IF LeaveEntitlement."Leave Code" = 'EL' THEN BEGIN

                    Monthlyattendance.CALCFIELDS(LeavesUsedForEarnedLeaves);
                    LeaveEntitlement."No.of Leaves" := Monthlyattendance."LeavesAvl.ForEL";
                    L1 := Monthlyattendance.LeavesUsedForEarnedLeaves;
                    IF Monthlyattendance."Pay Slip Month" <> 1 THEN BEGIN
                        LEnt.RESET;
                        LEnt.SETRANGE("Employee No.", Monthlyattendance."Employee Code");
                        LEnt.SETRANGE(Year, Monthlyattendance.Year);
                        LEnt.SETRANGE(Month, Monthlyattendance."Pay Slip Month" - 1);
                        LEnt.SETRANGE("Leave Code", 'EL');
                        IF LEnt.FIND('-') THEN BEGIN
                            //IF  LEnt."No.of Leaves" <> 0 THEN
                            Aleaves := LEnt."Leave Bal. at the Month End";
                            //ELSE
                            //Aleaves:=LeaveEntitlement."No.of Leaves";
                        END
                    END ELSE BEGIN
                        LEnt.RESET;
                        LEnt.SETRANGE("Employee No.", Monthlyattendance."Employee Code");
                        LEnt.SETRANGE(Year, Monthlyattendance.Year - 1);
                        LEnt.SETRANGE(Month, 12);
                        LEnt.SETRANGE("Leave Code", 'EL');
                        IF LEnt.FIND('-') THEN
                            Aleaves := LEnt."Leave Bal. at the Month End";
                    END;

                    // Aleaves:=LeaveEntitlement."No.of Leaves";

                    LeaveEntitlement."Leave Avail. at the Month" := Aleaves;

                    LeaveEntitlement."Leaves taken during Month" := Monthlyattendance.LeavesUsedForEarnedLeaves;
                    IF Monthlyattendance."Pay Slip Month" = 12 THEN
                        LeaveEntitlement."Leave Bal. at the Month End" := "Updating Earned leaves"(Monthlyattendance) +

                         ((LeaveEntitlement."Leave Avail. at the Month") - (LeaveEntitlement."Leaves taken during Month"))
                    ELSE
                        LeaveEntitlement."Leave Bal. at the Month End" :=
                        ((LeaveEntitlement."Leave Avail. at the Month") - (LeaveEntitlement."Leaves taken during Month"));
                    IF LeaveEntitlement."Leave Bal. at the Month End" <= 0 THEN
                        LeaveEntitlement."Leave Bal. at the Month End" := 0;

                END;
                //VE-026
                LeaveEntitlement."Leave Year Closing Period" := EndDate;

                IF HRSetup.FIND('-') THEN BEGIN
                    LeaveEntitlement.Month := Monthlyattendance."Pay Slip Month";
                    LeaveEntitlement.Year := Monthlyattendance.Year;
                END;
                /*
                //IF LeaveMaster."Crediting Type" = LeaveMaster."Crediting Type" :: "After the Period" THEN
                  LeaveEntitlement."No.of Leaves" := (LeaveEntitlement."No.of Leaves" / 12) * (12 - MonthValue+1);
                //ELSE
                  //LeaveEntitlement."No.of Leaves" := (LeaveEntitlement."No.of Leaves" / 12) * (11 - MonthValue+1);
                LeaveEntitlement."Total Leaves" := LeaveEntitlement."No.of Leaves";
                */
                LeaveEntitlement3.SETRANGE("Employee No.", LeaveEntitlement."Employee No.");
                LeaveEntitlement3.SETRANGE("Leave Code", LeaveEntitlement."Leave Code");
                LeaveEntitlement3.SETRANGE(Year, LeaveEntitlement.Year);
                LeaveEntitlement3.SETRANGE(Month, LeaveEntitlement.Month);
                IF NOT LeaveEntitlement3.FIND('-') THEN BEGIN
                    LeaveEntitlement.INSERT;
                    Check := TRUE;
                END ELSE
                    Check := FALSE;
            UNTIL LeaveMaster.NEXT = 0;
        END;

    end;

    // [Scope('Internal')]
    procedure InsertLeaveEntitle(StartDate: Date; EndDate: Date)
    var
        LeaveMaster: Record 60030;
        LeaveEntitlement2: Record 60031;
        LeaveEntitlement3: Record 60031;
        LeaveEntitlement: Record 60031;
        PayYear: Record 60020;
        CreditingDate: Date;
        CreditingLeaves: Decimal;
        CreditingMonth: Integer;
        CreditingYear: Integer;
        Num: Integer;
    begin
        LeaveMaster.SETRANGE("Applicable During Probation", TRUE);
        IF LeaveMaster.FIND('-') THEN BEGIN
            REPEAT
                IF LeaveEntitlement2.FIND('+') THEN
                    Num := LeaveEntitlement2."Entry No."
                ELSE
                    Num := 0;

                LeaveEntitlement.INIT;
                LeaveEntitlement."Entry No." := Num + 1;
                LeaveEntitlement."Employee No." := "No.";
                LeaveEntitlement."Employee Name" := "First Name";
                LeaveEntitlement.Probation := Probation;
                LeaveEntitlement."Leave Code" := LeaveMaster."Leave Code";
                CreditingLeaves := (LeaveMaster."No.of Leaves During Probation") / 12;
                CreditingDate := CALCDATE(LeaveMaster."Crediting Interval", StartDate);
                CreditingMonth := DATE2DMY(CreditingDate, 2);
                CreditingYear := DATE2DMY(CreditingDate, 3);

                LeaveEntitlement."Leave Year Closing Period" := EndDate;

                IF HRSetup.FIND('-') THEN BEGIN
                    LeaveEntitlement.Month := HRSetup."Salary Processing month";
                    LeaveEntitlement.Year := HRSetup."Salary Processing Year";
                END;
                /*
                IF LeaveMaster."Crediting Type" = LeaveMaster."Crediting Type" :: "After the Period" THEN BEGIN
                  IF (CreditingMonth =LeaveEntitlement.Month) AND (CreditingYear = LeaveEntitlement.Year) THEN
                    LeaveEntitlement."No.of Leaves" := CreditingLeaves;
                END ELSE
                  LeaveEntitlement."No.of Leaves" := CreditingLeaves;
                 */
                //LeaveEntitlement."Total Leaves" := LeaveEntitlement."No.of Leaves";
                LeaveEntitlement3.SETRANGE("Employee No.", LeaveEntitlement."Employee No.");
                LeaveEntitlement3.SETRANGE("Leave Code", LeaveEntitlement."Leave Code");
                LeaveEntitlement3.SETRANGE(Year, LeaveEntitlement.Year);
                LeaveEntitlement3.SETRANGE(Month, LeaveEntitlement.Month);
                IF NOT LeaveEntitlement3.FIND('-') THEN BEGIN
                    Check := TRUE;
                END ELSE
                    Check := FALSE;
                LeaveEntitlement.INSERT;
            UNTIL LeaveMaster.NEXT = 0;
        END;

    end;

    // [Scope('Internal')]
    procedure GetLeaves(var MonthlyAtt: Record 60029) Leaves: Decimal
    begin
        //VE-026
        LeaveEntitle.RESET;
        LeaveEntitle.SETRANGE("Employee No.", MonthlyAtt."Employee Code");
        LeaveEntitle.SETRANGE(Year, MonthlyAtt.Year);
        LeaveEntitle.SETRANGE(Month, (MonthlyAtt."Pay Slip Month" - 1));
        //LeaveEntitle.SETRANGE("Leave Code",'cl');
        IF LeaveEntitle.FIND('-') THEN BEGIN
            REPEAT
                Leaves += LeaveEntitle."Leave Bal. at the Month End";
            UNTIL LeaveEntitle.NEXT = 0;
            Emp1.GET(MonthlyAtt."Employee Code");
            IF Emp1.Probation THEN
                Leaves += NoOfLeavesAssig(MonthlyAtt."Employee Code")
            ELSE
                Leaves += NoOfLeavesAssig(MonthlyAtt."Employee Code")
                              + LeaveEntitle.CLLeavesToAddAfterProbation;
        END ELSE BEGIN
            LeaveMaster1.INIT;
            LeaveMaster1.SETRANGE("Leave Code", 'SL');
            IF LeaveMaster1.FIND('-') THEN
                Lev1 := LeaveMaster1."No. of Leaves in Year";
            Leaves := NoOfLeavesAssig(MonthlyAtt."Employee Code") + MonthlyAtt."LeavesAvl.ForEL" + Lev1;
            Emp1.GET(MonthlyAtt."Employee Code");
            IF Emp1.Probation THEN
                Leaves := LeaveEntitle."Leave Bal. at the Month End" + NoOfLeavesAssig(MonthlyAtt."Employee Code")
            ELSE
                Leaves += LeaveEntitle.CLLeavesToAddAfterProbation;
        END;
        //VE-026
    end;

    // [Scope('Internal')]
    procedure NoOfLeavesAssig(Empcode: Code[10]) LeaveAssign: Decimal
    var
        month: Record 60029;
    begin
        //VE-026
        HRSetup.GET;
        Day := DATE2DMY(TODAY, 1);
        SETRANGE("No.", Empcode);
        IF FIND('-') THEN BEGIN
            IF Probation = FALSE THEN BEGIN
                IF HRSetup."Emp Leave Applicable Days" <= Day THEN BEGIN
                    LeaveAssign := 1;
                END ELSE BEGIN
                    LeaveAssign := 0;
                END;
            END ELSE BEGIN
                LeaveAssign := 0;
            END;
        END;


        EXIT(LeaveAssign);
        //VE-026
    end;

    // [Scope('Internal')]
    procedure CheckLeavesToUse(var MonthlyAtt: Record 60029) ExtraLeaves: Decimal
    var
        AvlLeaves: Decimal;
        UsedLeaves: Decimal;
        AvlLeaForSL: Decimal;
        UsedLeaForSL: Decimal;
    begin
        //VE-026
        AvlLeaves := GetLeaves1(MonthlyAtt);
        UsedLeaves := (MonthlyAtt."Leave Cut For LateHrs" + MonthlyAtt.Leaves) - MonthlyAtt.LossOFpayCount;
        IF AvlLeaves < UsedLeaves THEN
            ExtraLeaves := (UsedLeaves - AvlLeaves)
        ELSE
            ExtraLeaves := 0;
        EXIT(ExtraLeaves);
        //VE-026
    end;

    // [Scope('Internal')]
    procedure GetLeavesforSl(var MonthlyAtt: Record 60029) Leaves1: Decimal
    begin
        //VE-026
        LeaveMaster.INIT;
        LeaveEntitle.RESET;
        LeaveEntitle.SETRANGE("Employee No.", MonthlyAtt."Employee Code");
        LeaveEntitle.SETRANGE(Year, MonthlyAtt.Year);
        LeaveEntitle.SETRANGE(Month, (MonthlyAtt."Pay Slip Month" - 1));
        LeaveEntitle.SETRANGE("Leave Code", 'SL');
        IF LeaveEntitle.FIND('-') THEN
            Leaves1 := LeaveEntitle."Leave Bal. at the Month End"
        ELSE BEGIN
            LeaveMaster.INIT;
            LeaveMaster.SETRANGE("Leave Code", 'SL');
            IF LeaveMaster.FIND('-') THEN
                Leaves1 := LeaveMaster."No. of Leaves in Year";
        END;
        EXIT(Leaves1);
        //VE-026
    end;

    //  [Scope('Internal')]
    procedure GetLeavesforEl(var MonthlyAtt: Record 60029) Leaves3: Decimal
    begin
        //VE-026
        LeaveMaster.INIT;
        LeaveEntitle.RESET;
        LeaveEntitle.SETRANGE("Employee No.", MonthlyAtt."Employee Code");
        LeaveEntitle.SETRANGE(Year, MonthlyAtt.Year);
        LeaveEntitle.SETRANGE(Month, (MonthlyAtt."Pay Slip Month" - 1));
        LeaveEntitle.SETRANGE("Leave Code", 'EL');
        IF LeaveEntitle.FIND('-') THEN
            Leaves3 := LeaveEntitle."Leave Bal. at the Month End"
        ELSE BEGIN
            LeaveMaster.INIT;
            LeaveMaster.SETRANGE("Leave Code", 'EL');
            IF LeaveMaster.FIND('-') THEN
                Leaves3 := "Updating Earned leaves"(MonthlyAtt);
        END;
        EXIT(Leaves3);
        //VE-026
    end;

    // [Scope('Internal')]
    procedure GetLeaves1(var MonthlyAtt: Record 60029) Leaves: Decimal
    begin
        //VE-026
        MA := MonthlyAtt;
        LeaveEntitle.RESET;
        LeaveEntitle.SETRANGE("Employee No.", MonthlyAtt."Employee Code");
        LeaveEntitle.SETRANGE(Year, MonthlyAtt.Year);
        LeaveEntitle.SETRANGE(Month, (MonthlyAtt."Pay Slip Month" - 1));
        LeaveEntitle.SETRANGE("Leave Code", 'CL');
        IF LeaveEntitle.FIND('-') THEN BEGIN
            Emp1.GET(MonthlyAtt."Employee Code");
            IF Emp1.Probation THEN
                Leaves := LeaveEntitle."Leave Bal. at the Month End" + NoOfLeavesAssig(MonthlyAtt."Employee Code")
            ELSE
                Leaves := LeaveEntitle."Leave Bal. at the Month End" + NoOfLeavesAssig(MonthlyAtt."Employee Code")
                         + LeaveEntitle.CLLeavesToAddAfterProbation;

        END ELSE
            Leaves := NoOfLeavesAssig(MonthlyAtt."Employee Code");

        //VE-026
    end;

    // [Scope('Internal')]
    procedure "Updating Earned leaves"(var MonthlyAttend: Record 60029) Elleave: Decimal
    var
        LeaveEntitle1: Record 60031;
        DailyAtt: Record 60028;
        Emp: Record 60019;
        Date1: Date;
        Mon1: Integer;
        year1: Integer;
    begin
        CLEAR(Elleave);
        Emp.INIT;
        Emp.SETRANGE("No.", MonthlyAttend."Employee Code");
        IF Emp.FIND('-') THEN
            Date1 := CALCDATE('1Y', Emp."Employment Date");
        year1 := DATE2DMY(Date1, 3);
        Mon1 := DATE2DMY(Date1, 2);
        IF year1 <= MonthlyAttend.Year THEN BEGIN
            IF (year1 = MonthlyAttend.Year) AND (MonthlyAttend."Pay Slip Month" <> 12) THEN BEGIN
                IF (Mon1 <= MonthlyAttend."Pay Slip Month") AND (NOT MonthlyAttend.Leavesaddedafteryear) THEN BEGIN
                    MonthlyAttend1.SETRANGE("Employee Code", MonthlyAttend."Employee Code");
                    MonthlyAttend1.SETRANGE(Year, MonthlyAttend.Year);
                    IF MonthlyAttend1.FIND('+') THEN
                        MonthlyAttend1.CALCFIELDS("Total Present Days");
                    IF MonthlyAttend1."Total Present Days" > 240 THEN BEGIN
                        Elleave := 15;
                    END ELSE BEGIN
                        IF MonthlyAttend1."Total Present Days" / 20 <> 0 THEN BEGIN
                            ELLeaves := FORMAT(MonthlyAttend1."Total Present Days" / 20);
                            IF ELLeaves <> '' THEN
                                EVALUATE(Elleave, COPYSTR(ELLeaves, 1, (STRPOS(ELLeaves, '.')) - 1))
                            ELSE
                                Elleave := 0;
                        END;
                    END;
                END;
            END ELSE
                IF MonthlyAttend."Pay Slip Month" = 12 THEN BEGIN
                    MonthlyAttend1.SETRANGE("Employee Code", MonthlyAttend."Employee Code");
                    MonthlyAttend1.SETRANGE(Year, MonthlyAttend.Year);
                    IF MonthlyAttend1.FIND('+') THEN
                        MonthlyAttend1.CALCFIELDS("Total Present Days");
                    IF MonthlyAttend1."Total Present Days" > 240 THEN BEGIN
                        Elleave := 15;
                        //MESSAGE('%1',Elleave);
                    END
                    ELSE BEGIN
                        ELLeaves := FORMAT(MonthlyAttend1."Total Present Days" / 20);
                        IF ELLeaves <> '' THEN
                            EVALUATE(Elleave, COPYSTR(ELLeaves, 1, (STRPOS(ELLeaves, '.')) - 1))
                        ELSE
                            Elleave := 0;
                    END;
                END;
        END;
        EXIT(Elleave);
    end;

    // [Scope('Internal')]
    procedure TestStatusOpen()
    begin
        TESTFIELD("Emp Status", "Emp Status"::Open);
    end;
}

