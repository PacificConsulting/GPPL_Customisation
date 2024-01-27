table 60061 Interviewee
{
    // DrillDownPageID = 60094; pcpl-065
    // LookupPageID = 60094; //pcpl-065

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
                //  Postcode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);//pcpl-065 temporary
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
                // Postcode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
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
        field(20; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
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
        field(39; Comment; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Human Resource Comment Line" WHERE("Table Name" = CONST(Employee),
                                                                     "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;

        }
        field(53; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(58; "Martial status"; Option)
        {
            Caption = 'Marital Status';
            OptionMembers = Married,Single;
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
        field(67; "PF No"; Text[20])
        {
        }
        field(68; "Blood Group"; Option)
        {
            OptionMembers = " ","A+","A-","B+","B-","AB+","AB-","O+","O-";
        }
        field(79; Passport; Code[20])
        {
        }
        field(80; Experience; Integer)
        {
        }
        field(110; "Resume DB No."; Code[20])
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
        field(60050; "Converted To Employee"; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            //pcpl-065
            // HRSetup.GET;
            //  HRSetup.TESTFIELD(HRSetup."Intrewiewee No.");
            // NoSeriesMgt.InitSeries(HRSetup."Intrewiewee No.", xRec."No. Series", 0D, "No.", "No. Series");
            //pcpl-065
        END;
    end;

    var
        Postcode: Record 225;
        HRSetup: Record 60016;
        NoSeriesMgt: Codeunit NoSeriesManagement;//396; 
        Interviewee: Record 60061;

    //[Scope('Internal')]
    procedure AssistEdit(OldInterviewee: Record 60061): Boolean
    begin
        //VE-026
        WITH Interviewee DO BEGIN
            Interviewee := Rec;
            HRSetup.GET;
            HRSetup.TESTFIELD("Intrewiewee No.");
            IF NoSeriesMgt.SelectSeries(HRSetup."Intrewiewee No.", OldInterviewee."No. Series", "No. Series") THEN BEGIN
                HRSetup.GET;
                HRSetup.TESTFIELD("Intrewiewee No.");
                NoSeriesMgt.SetSeries("No.");
                Rec := Interviewee;
                EXIT(TRUE);
            END;
        END;
        //VE-026
    end;
}

