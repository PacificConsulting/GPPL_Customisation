page 60020 "Leave Master"
{
    // Date: 10-Jan-06

    DelayedInsert = true;
    PageType = Card;
    SourceTable = 60030;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("No. of Leaves in Year"; Rec."No. of Leaves in Year")
                {
                    ApplicationArea = all;
                }
                field("Crediting Interval"; Rec."Crediting Interval")
                {
                    ApplicationArea = all;
                }
                field("Crediting Type"; Rec."Crediting Type")
                {
                    ApplicationArea = all;
                }
                field("Carry Forward"; Rec."Carry Forward")
                {
                    ApplicationArea = all;
                }
                field("Applicable Date"; Rec."Applicable Date")
                {
                    ApplicationArea = all;
                }
                field("Max.Leaves to Carry Forward"; Rec."Max.Leaves to Carry Forward")
                {
                    ApplicationArea = all;
                }
                field("Applicable During Probation"; Rec."Applicable During Probation")
                {
                    ApplicationArea = all;
                }
                field("No.of Leaves During Probation"; Rec."No.of Leaves During Probation")
                {
                    ApplicationArea = all;
                }
                field(Encashable; Rec.Encashable)
                {
                    ApplicationArea = all;
                }
                field("Max. Encashable"; Rec."Max. Encashable")
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
            action("Create &Leaves")
            {
                Caption = 'Create &Leaves';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    //CLEAR(GenerateLeave);
                    IF LeaveMaster.FIND('-') THEN
                        REPEAT
                            LeaveMaster.TESTFIELD("No. of Leaves in Year");
                            LeaveMaster.TESTFIELD("Crediting Interval");
                            LeaveMaster.TESTFIELD("Applicable Date");
                            IF LeaveMaster."Carry Forward" THEN
                                LeaveMaster.TESTFIELD(LeaveMaster."Max.Leaves to Carry Forward");
                            IF LeaveMaster."Applicable During Probation" THEN
                                LeaveMaster.TESTFIELD(LeaveMaster."No.of Leaves During Probation");
                        UNTIL LeaveMaster.NEXT = 0;
                    //GenerateLeave.RUNMODAL;
                end;
            }
        }
    }

    var
        LeaveMaster: Record 60030;
        //GenerateLeave: Report 60001;
        RecRef: RecordRef;
}

