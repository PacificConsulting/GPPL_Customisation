page 60005 "Employee List_Viswas"
{
    // B2B Software Technologies
    // --------------------------
    // Project : Human Resource
    // B2B
    // No. sign      Date
    // --------------------------
    // 01   B2B    13-dec-05

    Caption = 'Employee List';
    PageType = List;
    SourceTable = 60019;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(group)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = all;
                }
                field(FullName; Rec.FullName)
                {
                    ApplicationArea = all;
                    Caption = 'Full Name';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Attendance Not Generated"; Rec."Attendance Not Generated")
                {
                    ApplicationArea = all;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Resignation Date"; Rec."Resignation Date")
                {
                    ApplicationArea = all;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = all;
                }
                field("Post to GL"; Rec."Post to GL")
                {
                    ApplicationArea = all;
                }
                field("Pay Cadre"; Rec."Pay Cadre")
                {
                    ApplicationArea = all;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = all;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = all;
                }
                field("ESI No"; Rec."ESI No")
                {
                    ApplicationArea = all;
                }
                field("PF No"; Rec."PF No")
                {
                    ApplicationArea = all;
                }
                field("ESI Applicable"; Rec."ESI Applicable")
                {
                    ApplicationArea = all;
                }
                field("PF Applicable"; Rec."PF Applicable")
                {
                    ApplicationArea = all;
                }
                field("PT Applicable"; Rec."PT Applicable")
                {
                    ApplicationArea = all;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = all;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                action("&Card")
                {
                    ApplicationArea = all;
                    Caption = '&Card';
                    Image = EditLines;
                    RunObject = Page 60004;
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'Shift+F7';
                }
                action(Dimensions)
                {
                    ApplicationArea = all;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page 540;
                    RunPageLink = "Table ID" = CONST(80001),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    Visible = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //VE-026 >>
        /*RecRef.GETTABLE(Rec);
        ID := RecRef.NUMBER;
        SecurityFilterSetup.INIT;
        SecurityFilterSetup.SETRANGE("Table ID",ID);
        IF SecurityFilterSetup.FIND('-') THEN
          BEGIN
             FILTERGROUP(2);
             SETVIEW(SecurityF.GetSecurityFilters(RecRef));
             FILTERGROUP(2);
          END;  */
        //VE-026 <<
        rec.SETRANGE(Resigned, FALSE);

    end;

    var
        RecRef: RecordRef;
        ID: Integer;
}

