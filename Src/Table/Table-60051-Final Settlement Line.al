table 60051 "Final Settlement Line"
{

    fields
    {
        field(1; "Employee No."; Code[20])
        {

            trigger OnValidate()
            begin
                CreateDim(
                  DATABASE::Employee_, "Employee No.");
            end;
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Month; Integer)
        {
        }
        field(4; Year; Integer)
        {
        }
        field(5; "Pay Element Code"; Code[30])
        {
        }
        field(6; Description; Text[50])
        {
        }
        field(7; Amount; Decimal)
        {
        }
        field(8; "Addition/Deduction"; Option)
        {
            OptionMembers = " ",Addition,Deduction;
        }
        field(11; "Journal Template Name"; Code[20])
        {
        }
        field(12; "Journal Batch Name"; Code[20])
        {
        }
        field(13; "Posting Date"; Date)
        {
        }
        field(14; "Document No."; Code[20])
        {
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(17; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Payroll';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Payroll;
        }
        field(18; "Co. Contribution"; Decimal)
        {
        }
        field(19; "Co. Contribution2"; Decimal)
        {
        }
        field(20; Salary; Decimal)
        {
        }
        field(21; "Computation Type"; Code[50])
        {
        }
        field(22; Posted; Boolean)
        {
        }
        field(50; "Dimension Set ID"; Integer)
        {
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        "----Dimensions----": Integer;
    //DimMgt: Codeunit 408;

    [Scope('Internal')]
    procedure "-----Dimensions------"()
    begin
    end;

    //[Scope('Internal')]
    procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        SourceCodeSetup: Record 242;
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        SourceCodeSetup.GET;
        TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        /* //RSPL-TC
        DimMgt.GetDefaultDim(
          TableID,No,SourceCodeSetup."General Journal",
          "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        IF "Line No." <> 0 THEN
          DimMgt.UpdateDocDefaultDim(
            DATABASE::"Final Settlement Line","Document Type","Employee No.","Line No.",
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
            */

    end;

    //  [Scope('Internal')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        /*
        DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        IF "Line No." <> 0 THEN
          DimMgt.SaveDocDim(
            DATABASE::"Final Settlement Line","Document Type"::Payroll,"Employee No.",
            "Line No.",FieldNumber,ShortcutDimCode)
        ELSE
          DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);
        
        */

    end;

    [Scope('Internal')]
    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        /*
        IF "Line No." <> 0 THEN
          DimMgt.ShowDocDim(
            DATABASE::"Final Settlement Line","Document Type","Employee No.",
            "Line No.",ShortcutDimCode)
        ELSE
          DimMgt.ShowTempDim(ShortcutDimCode);
          */

    end;

    // [Scope('Internal')]
    procedure ShowDimensions()
    begin
        /*
        DocDim.SETRANGE("Table ID",DATABASE::"Final Settlement Line");
        DocDim.SETRANGE("Document Type",DocDim."Document Type"::"6");
        DocDim.SETRANGE("Document No.","Employee No.");
        DocDim.SETRANGE("Line No.","Line No.");
        DocDimensions.SETTABLEVIEW(DocDim);
        DocDimensions.RUNMODAL;
        */

    end;
}

