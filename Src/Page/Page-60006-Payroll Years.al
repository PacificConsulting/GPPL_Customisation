page 60006 "Payroll Years"
{
    // Date: 05-Jan-06

    PageType = List;
    SourceTable = 60020;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("Year Type"; Rec."Year Type")
                {
                    ApplicationArea = all;
                }
                field("Year Start Date"; Rec."Year Start Date")
                {
                    ApplicationArea = all;
                }
                field("Year End Date"; Rec."Year End Date")
                {
                    ApplicationArea = all;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("C&reate Year")
                {
                    Caption = 'C&reate Year';
                    Image = CreateYear;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        CLEAR(CreateYear);
                        CreateYear.YearTypeInsert(rec."Year Type");
                        CreateYear.RUNMODAL;
                    end;
                }
                action("Cl&ose Year")
                {
                    Caption = 'Cl&ose Year';
                    Image = CloseYear;
                    ApplicationArea = all;
                    trigger OnAction()
                    begin
                        rec.Closed := TRUE;
                        rec.MODIFY;
                    end;
                }
            }
        }
    }

    var
        RecRef: RecordRef;
        CreateYear: Page 60007;
}

