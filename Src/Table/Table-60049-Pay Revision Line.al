table 60049 "Pay Revision Line"
{

    fields
    {
        field(2; "Employee Name"; Text[50])
        {
        }
        field(3; "Pay Element"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('ADDITIONS AND DEDUCTIONS'));

            trigger OnValidate()
            begin
                TestHeaderStatus;
                Lookup.SETRANGE("Lookup Name", "Pay Element");
                IF Lookup.FIND('-') THEN BEGIN
                    "Add/Deduct" := Lookup."Add/Deduct";
                    Description := Lookup.Description;
                    IF "Pay Element" = 'BASIC' THEN
                        "Computation Type" := 'ON ATTENDANCE';
                END;
            end;
        }
        field(4; Description; Text[50])
        {
        }
        field(5; "Fixed / Percent"; Option)
        {
            OptionMembers = "Fixed",Percent;
        }
        field(6; "Amount / Percent"; Decimal)
        {
        }
        field(7; "Revised Amount / Percent"; Decimal)
        {
        }
        field(8; "Computation Type"; Code[30])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('COMPUTATION TYPE'));
        }
        field(9; "Starting Date"; Date)
        {
        }
        field(10; "Revised Date"; Date)
        {
        }
        field(11; "Arrear Amount"; Decimal)
        {
        }
        field(12; Grade; Code[30])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('PAY CADRE'));
        }
        field(13; "Header No."; Code[20])
        {
        }
        field(14; "Revised Fixed / Percent"; Option)
        {
            OptionMembers = "Fixed",Percent;
        }
        field(15; "Revised Computation Type"; Code[30])
        {
            TableRelation = "Lookup"."Lookup Name" WHERE("LookupType Name" = CONST('COMPUTATION TYPE'));
        }
        field(16; "Effective Date"; Date)
        {
        }
        field(17; "No."; Code[30])
        {
        }
        field(18; Type; Option)
        {
            OptionMembers = Employee,Grade;
        }
        field(19; "Add/Deduct"; Option)
        {
            OptionMembers = " ",Addition,Deduction;
        }
        field(20; "Modified PayElement"; Boolean)
        {
        }
        field(21; "Arrear Inserted"; Boolean)
        {
        }
        field(22; "Journal Template Name"; Code[20])
        {
        }
        field(23; "Journal Batch Name"; Code[20])
        {
        }
        field(24; "Posting Date"; Date)
        {
        }
        field(25; "Document No."; Code[20])
        {
        }
        field(30; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(31; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(32; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Payroll';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Payroll;
        }
        field(33; "Line No."; Integer)
        {
        }
        field(53; "Arrear Co. Contribution"; Decimal)
        {
        }
        field(54; "Arrear Co. Contribution2"; Decimal)
        {
        }
        field(55; Month; Integer)
        {
        }
        field(56; Year; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Header No.", Type, "No.", Grade, "Pay Element", "Revised Date", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "No.", "Pay Element")
        {
        }
        key(Key3; "Add/Deduct", "Pay Element")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestHeaderStatus;
    end;

    trigger OnInsert()
    begin
        TestHeaderStatus;
    end;

    trigger OnModify()
    begin
        TestHeaderStatus;
    end;

    trigger OnRename()
    begin
        TestHeaderStatus;
    end;

    var
        Lookup: Record 60018;

    // [Scope('Internal')]
    procedure TestHeaderStatus()
    var
        PayRevisionHeader: Record 60048;
    begin
        PayRevisionHeader.SETRANGE("Id.", "Header No.");
        PayRevisionHeader.SETRANGE(Type, Type);
        PayRevisionHeader.SETRANGE("No.", "No.");
        IF PayRevisionHeader.FIND('-') THEN
            PayRevisionHeader.TESTFIELD(Status, PayRevisionHeader.Status::Open);
    end;
}

