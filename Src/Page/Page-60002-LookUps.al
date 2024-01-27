page 60002 LookUps
{
    DelayedInsert = true;
    MultipleNewLines = false;
    PageType = Card;
    SourceTable = 60018;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            field(TemplateNameGlobal; TemplateNameGlobal)
            {
                Editable = false;
                ApplicationArea = all;
                trigger OnLookup(var Text: Text): Boolean
                begin
                    IF PAGE.RUNMODAL(0, LookUpType) = ACTION::LookupOK THEN BEGIN
                        TemplateNumber := LookUpType."No.";
                        TemplateNameGlobal := LookUpType.Name;
                    END;

                    //Displays the Add/Deduct column when selecting Lookuptype Name as Additions and Deductions
                    /*
                    
                    IF TemplateNameGlobal = 'EMP LOCATION' THEN
                      BEGIN
                        CurrForm."Add/Deduct".VISIBLE := FALSE;
                        CurrForm."Applicable for OT".VISIBLE := FALSE;
                        CurrForm.ESI.VISIBLE := FALSE;
                        CurrForm.PF.VISIBLE := FALSE;
                        CurrForm.Priority.VISIBLE := FALSE;
                        CurrForm."Leave Encashment".VISIBLE := FALSE;
                        CurrForm.Date.VISIBLE := FALSE;
                        CurrForm."Payroll Prod. Posting Group".VISIBLE := FALSE;
                        CurrForm."Bonus/Exgratia".VISIBLE := FALSE;
                        CurrForm.Gratuity.VISIBLE := FALSE;
                        CurrForm."Holiday Compensation".VISIBLE := FALSE;
                        CurrForm.PT.VISIBLE := FALSE;
                        CurrForm."Order in Pay Register".VISIBLE := FALSE;
                        CurrForm."Print in Pay Register".VISIBLE := FALSE;
                        CurrForm.Type.VISIBLE := FALSE;
                        CurrForm."Loan Priority No.".VISIBLE := FALSE;
                        CurrForm.Grade.VISIBLE := FALSE;
                        CurrForm."Max.Amt".VISIBLE := FALSE;
                        CurrForm."Max.No. of instalments".VISIBLE := FALSE;
                        CurrForm."All Grades".VISIBLE := FALSE;
                        CurrForm."Max.Amt.Type".VISIBLE := FALSE;
                        CurrForm.Payyear.VISIBLE := FALSE;
                        CurrForm."Lookup Name".VISIBLE := TRUE;
                        CurrForm.Description.EDITABLE := TRUE;
                        CurrForm.Remarks.EDITABLE  := FALSE;
                        CurrForm.Functions.VISIBLE := FALSE;
                        CurrForm."Period Start Date".VISIBLE := FALSE;
                        CurrForm."Period End Date".VISIBLE := FALSE;
                        CurrForm."Min Salary".VISIBLE := FALSE;
                        CurrForm.Probation.VISIBLE := FALSE;
                        CurrForm."Per Meal Rate".VISIBLE := FALSE;
                        CurrForm."Incentive Applicable".VISIBLE := FALSE;
                        CurrForm.Lodging.VISIBLE := FALSE;
                        CurrForm."Lodging Maj.Town".VISIBLE := FALSE;
                        CurrForm.Bike.VISIBLE := FALSE;
                        CurrForm.Car.VISIBLE := FALSE;
                        CurrForm.Date.VISIBLE := TRUE;
                        CurrForm."DA Normal".VISIBLE := FALSE;
                        CurrForm."DA NightOut".VISIBLE := FALSE;
                        CurrForm."DA StateOffice".VISIBLE := FALSE;
                        CurrForm."DM's DA Normal".VISIBLE := FALSE;
                        CurrForm."DM's DA NightOut".VISIBLE := FALSE;
                        CurrForm."DM's DA StateOffice".VISIBLE := FALSE;
                        CurrForm."DM's Car".VISIBLE := FALSE;
                        CurrForm."DM's Bike".VISIBLE := FALSE;
                      END ELSE
                      BEGIN
                        CurrForm."Add/Deduct".VISIBLE := TRUE;
                        CurrForm."Applicable for OT".VISIBLE := TRUE;
                        CurrForm.ESI.VISIBLE := TRUE;
                        CurrForm.PF.VISIBLE := TRUE;
                        CurrForm.Priority.VISIBLE := TRUE;
                        CurrForm."Leave Encashment".VISIBLE := TRUE;
                        CurrForm."Payroll Prod. Posting Group".VISIBLE := TRUE;
                        CurrForm."Bonus/Exgratia".VISIBLE := TRUE;
                        CurrForm.Gratuity.VISIBLE := TRUE;
                        CurrForm."Holiday Compensation".VISIBLE := TRUE;
                        CurrForm.PT.VISIBLE := TRUE;
                        CurrForm."Order in Pay Register".VISIBLE := TRUE;
                        CurrForm."Print in Pay Register".VISIBLE := TRUE;
                        CurrForm.Type.VISIBLE := TRUE;
                        CurrForm."Loan Priority No.".VISIBLE := TRUE;
                        CurrForm.Grade.VISIBLE := TRUE;
                        CurrForm."Max.Amt".VISIBLE := TRUE;
                        CurrForm."Max.No. of instalments".VISIBLE := TRUE;
                        CurrForm."All Grades".VISIBLE := TRUE;
                        CurrForm."Max.Amt.Type".VISIBLE := TRUE;
                        CurrForm.Payyear.VISIBLE := TRUE;
                        CurrForm.Description.EDITABLE := TRUE;
                        CurrForm.Remarks.EDITABLE  := TRUE;
                        CurrForm.Functions.VISIBLE := TRUE;
                        CurrForm."Period Start Date".VISIBLE := TRUE;
                        CurrForm."Period End Date".VISIBLE := TRUE;
                        CurrForm."Min Salary".VISIBLE := TRUE;
                        CurrForm.Probation.VISIBLE := TRUE;
                        CurrForm."Per Meal Rate".VISIBLE := TRUE;
                        CurrForm."Incentive Applicable".VISIBLE := TRUE;
                        CurrForm.Lodging.VISIBLE := TRUE;
                        CurrForm."Lodging Maj.Town".VISIBLE := TRUE;
                        CurrForm.Bike.VISIBLE := TRUE;
                        CurrForm.Car.VISIBLE := TRUE;
                      END;
                    
                    
                    IF TemplateNameGlobal = 'TA OFF DAYS' THEN
                      BEGIN
                        CurrForm."Add/Deduct".VISIBLE := FALSE;
                        CurrForm."Applicable for OT".VISIBLE := FALSE;
                        CurrForm.ESI.VISIBLE := FALSE;
                        CurrForm.PF.VISIBLE := FALSE;
                        CurrForm.Priority.VISIBLE := FALSE;
                        CurrForm."Leave Encashment".VISIBLE := FALSE;
                        CurrForm."Payroll Prod. Posting Group".VISIBLE := FALSE;
                        CurrForm."Bonus/Exgratia".VISIBLE := FALSE;
                        CurrForm.Gratuity.VISIBLE := FALSE;
                        CurrForm."Holiday Compensation".VISIBLE := FALSE;
                        CurrForm.PT.VISIBLE := FALSE;
                        CurrForm."Order in Pay Register".VISIBLE := FALSE;
                        CurrForm."Print in Pay Register".VISIBLE := FALSE;
                        CurrForm.Type.VISIBLE := FALSE;
                        CurrForm."Loan Priority No.".VISIBLE := FALSE;
                        CurrForm.Grade.VISIBLE := FALSE;
                        CurrForm."Max.Amt".VISIBLE := FALSE;
                        CurrForm."Max.No. of instalments".VISIBLE := FALSE;
                        CurrForm."All Grades".VISIBLE := FALSE;
                        CurrForm."Max.Amt.Type".VISIBLE := FALSE;
                        CurrForm.Payyear.VISIBLE := FALSE;
                        CurrForm."Lookup Name".VISIBLE := FALSE;
                        CurrForm.Description.EDITABLE := FALSE;
                        CurrForm.Remarks.EDITABLE  := FALSE;
                        CurrForm.Functions.VISIBLE := FALSE;
                        CurrForm."Period Start Date".VISIBLE := FALSE;
                        CurrForm."Period End Date".VISIBLE := FALSE;
                        CurrForm."Min Salary".VISIBLE := FALSE;
                        CurrForm.Probation.VISIBLE := FALSE;
                        CurrForm."Per Meal Rate".VISIBLE := FALSE;
                        CurrForm."Incentive Applicable".VISIBLE := FALSE;
                        CurrForm.Lodging.VISIBLE := FALSE;
                        CurrForm."Lodging Maj.Town".VISIBLE := FALSE;
                        CurrForm.Bike.VISIBLE := FALSE;
                        CurrForm.Car.VISIBLE := FALSE;
                        CurrForm.Date.VISIBLE := TRUE;
                        CurrForm."DA Normal".VISIBLE := FALSE;
                        CurrForm."DA NightOut".VISIBLE := FALSE;
                        CurrForm."DA StateOffice".VISIBLE := FALSE;
                        CurrForm."DM's DA Normal".VISIBLE := FALSE;
                        CurrForm."DM's DA NightOut".VISIBLE := FALSE;
                        CurrForm."DM's DA StateOffice".VISIBLE := FALSE;
                        CurrForm."DM's Car".VISIBLE := FALSE;
                        CurrForm."DM's Bike".VISIBLE := FALSE;
                      END ELSE
                      BEGIN
                        CurrForm."Add/Deduct".VISIBLE := TRUE;
                        CurrForm."Applicable for OT".VISIBLE := TRUE;
                        CurrForm.ESI.VISIBLE := TRUE;
                        CurrForm.PF.VISIBLE := TRUE;
                        CurrForm.Priority.VISIBLE := TRUE;
                        CurrForm."Leave Encashment".VISIBLE := TRUE;
                        CurrForm."Payroll Prod. Posting Group".VISIBLE := TRUE;
                        CurrForm."Bonus/Exgratia".VISIBLE := TRUE;
                        CurrForm.Gratuity.VISIBLE := TRUE;
                        CurrForm."Holiday Compensation".VISIBLE := TRUE;
                        CurrForm.PT.VISIBLE := TRUE;
                        CurrForm."Order in Pay Register".VISIBLE := TRUE;
                        CurrForm."Print in Pay Register".VISIBLE := TRUE;
                        CurrForm.Type.VISIBLE := TRUE;
                        CurrForm."Loan Priority No.".VISIBLE := TRUE;
                        CurrForm.Grade.VISIBLE := TRUE;
                        CurrForm."Max.Amt".VISIBLE := TRUE;
                        CurrForm."Max.No. of instalments".VISIBLE := TRUE;
                        CurrForm."All Grades".VISIBLE := TRUE;
                        CurrForm."Max.Amt.Type".VISIBLE := TRUE;
                        CurrForm.Payyear.VISIBLE := TRUE;
                        CurrForm.Description.EDITABLE := TRUE;
                        CurrForm.Remarks.EDITABLE  := TRUE;
                        CurrForm.Functions.VISIBLE := TRUE;
                        CurrForm."Period Start Date".VISIBLE := TRUE;
                        CurrForm."Period End Date".VISIBLE := TRUE;
                        CurrForm."Min Salary".VISIBLE := TRUE;
                        CurrForm.Probation.VISIBLE := TRUE;
                        CurrForm."Per Meal Rate".VISIBLE := TRUE;
                        CurrForm."Incentive Applicable".VISIBLE := TRUE;
                        CurrForm.Lodging.VISIBLE := TRUE;
                        CurrForm."Lodging Maj.Town".VISIBLE := TRUE;
                        CurrForm.Bike.VISIBLE := TRUE;
                        CurrForm.Car.VISIBLE := TRUE;
                      END;
                    
                    //VE-003 <<
                    
                    
                    
                    IF ((TemplateNameGlobal = 'ADDITIONS AND DEDUCTIONS') OR (TemplateNameGlobal = 'FINALSETTLEMENT')) THEN BEGIN
                      CurrForm."Add/Deduct".VISIBLE := TRUE;
                      CurrForm."Applicable for OT".VISIBLE := TRUE;
                      CurrForm.ESI.VISIBLE := TRUE;
                      CurrForm.PF.VISIBLE := TRUE;
                      CurrForm.Priority.VISIBLE := TRUE;
                      CurrForm."Leave Encashment".VISIBLE := TRUE;
                      CurrForm."Payroll Prod. Posting Group".VISIBLE := TRUE;
                      CurrForm."Bonus/Exgratia".VISIBLE := TRUE;
                      CurrForm.Gratuity.VISIBLE := TRUE;
                      CurrForm."Holiday Compensation".VISIBLE := TRUE;
                      CurrForm.PT.VISIBLE := TRUE;
                      CurrForm."Order in Pay Register".VISIBLE := TRUE;
                      CurrForm."Print in Pay Register".VISIBLE := TRUE;
                      CurrForm.Date.VISIBLE := FALSE;
                    END ELSE BEGIN
                      CurrForm."Add/Deduct".VISIBLE := FALSE;
                      CurrForm."Applicable for OT".VISIBLE := FALSE;
                      CurrForm.ESI.VISIBLE := FALSE;
                      CurrForm.PF.VISIBLE := FALSE;
                      CurrForm.Priority.VISIBLE := FALSE;
                      CurrForm."Leave Encashment".VISIBLE := FALSE;
                      CurrForm."Payroll Prod. Posting Group".VISIBLE := FALSE;
                      CurrForm."Bonus/Exgratia".VISIBLE := FALSE;
                      CurrForm.Gratuity.VISIBLE := FALSE;
                      CurrForm."Holiday Compensation".VISIBLE := FALSE;
                      CurrForm.PT.VISIBLE := FALSE;
                      CurrForm."Order in Pay Register".VISIBLE := FALSE;
                      CurrForm."Print in Pay Register".VISIBLE := FALSE;
                      CurrForm."DA Normal".VISIBLE := FALSE;
                      CurrForm."DA NightOut".VISIBLE := FALSE;
                      CurrForm."DA StateOffice".VISIBLE := FALSE;
                      CurrForm."DM's DA Normal".VISIBLE := FALSE;
                      CurrForm."DM's DA NightOut".VISIBLE := FALSE;
                      CurrForm."DM's DA StateOffice".VISIBLE := FALSE;
                      CurrForm."DM's Car".VISIBLE := FALSE;
                      CurrForm."DM's Bike".VISIBLE := FALSE;
                      END;
                    
                    
                    //Displays the Type Option when selecting the Loan as LookupType Name
                    
                    IF TemplateNameGlobal = 'LOAN TYPES' THEN BEGIN
                      CurrForm.Type.VISIBLE := TRUE;
                      CurrForm."Loan Priority No.".VISIBLE := TRUE;
                      CurrForm.Grade.VISIBLE := TRUE;
                      CurrForm."Max.Amt".VISIBLE := TRUE;
                      CurrForm."Max.No. of instalments".VISIBLE := TRUE;
                      CurrForm."All Grades".VISIBLE := TRUE;
                      CurrForm."Max.Amt.Type".VISIBLE := TRUE;
                      CurrForm.Date.VISIBLE := FALSE;
                    END ELSE BEGIN
                      CurrForm.Type.VISIBLE := FALSE;
                      CurrForm."Loan Priority No.".VISIBLE := FALSE;
                      CurrForm.Grade.VISIBLE := FALSE;
                      CurrForm."Max.Amt".VISIBLE := FALSE;
                      CurrForm."Max.No. of instalments".VISIBLE := FALSE;
                      CurrForm."All Grades".VISIBLE := FALSE;
                      CurrForm."Max.Amt.Type".VISIBLE := FALSE;
                      CurrForm."DA Normal".VISIBLE := FALSE;
                      CurrForm."DA NightOut".VISIBLE := FALSE;
                      CurrForm."DA StateOffice".VISIBLE := FALSE;
                      CurrForm."DM's DA Normal".VISIBLE := FALSE;
                      CurrForm."DM's DA NightOut".VISIBLE := FALSE;
                      CurrForm."DM's DA StateOffice".VISIBLE := FALSE;
                      CurrForm."DM's Car".VISIBLE := FALSE;
                      CurrForm."DM's Bike".VISIBLE := FALSE;
                    
                    END;
                    
                    
                    IF TemplateNameGlobal = 'PAYROLL YEARS' THEN BEGIN
                      CurrForm.Payyear.VISIBLE := TRUE;
                      CurrForm.Date.VISIBLE := FALSE;
                    
                    END ELSE BEGIN
                      CurrForm.Payyear.VISIBLE := FALSE;
                      CurrForm."DA Normal".VISIBLE := FALSE;
                      CurrForm."DA NightOut".VISIBLE := FALSE;
                      CurrForm."DA StateOffice".VISIBLE := FALSE;
                      CurrForm."DM's DA Normal".VISIBLE := FALSE;
                      CurrForm."DM's DA NightOut".VISIBLE := FALSE;
                      CurrForm."DM's DA StateOffice".VISIBLE := FALSE;
                      CurrForm."DM's Car".VISIBLE := FALSE;
                      CurrForm."DM's Bike".VISIBLE := FALSE;
                      CurrForm.Date.VISIBLE := FALSE;
                    
                    END;
                    
                    IF (TemplateNameGlobal = 'COMPUTATION TYPE') OR (TemplateNameGlobal = 'PAYROLL YEARS') THEN BEGIN
                      CurrForm."Lookup Name".EDITABLE := FALSE;
                      CurrForm.Description.EDITABLE := FALSE;
                      CurrForm.Remarks.EDITABLE  := FALSE;
                      CurrForm.Date.VISIBLE := FALSE;
                      CurrForm."DA Normal".VISIBLE := FALSE;
                      CurrForm."DA NightOut".VISIBLE := FALSE;
                      CurrForm."DA StateOffice".VISIBLE := FALSE;
                      CurrForm."DM's DA Normal".VISIBLE := FALSE;
                      CurrForm."DM's DA NightOut".VISIBLE := FALSE;
                      CurrForm."DM's DA StateOffice".VISIBLE := FALSE;
                      CurrForm."DM's Car".VISIBLE := FALSE;
                      CurrForm."DM's Bike".VISIBLE := FALSE;
                    END ELSE BEGIN
                      CurrForm."Lookup Name".EDITABLE := TRUE;
                      CurrForm.Description.EDITABLE := TRUE;
                      CurrForm.Remarks.EDITABLE  := TRUE;
                      CurrForm.Date.VISIBLE := FALSE;
                    
                    END;
                    
                    IF TemplateNameGlobal = 'PAY CADRE' THEN BEGIN
                      CurrForm."Period Start Date".VISIBLE := TRUE;
                      CurrForm."Period End Date".VISIBLE := TRUE;
                      CurrForm.Functions.VISIBLE := TRUE;
                      CurrForm."Min Salary".VISIBLE := TRUE;
                      CurrForm.Probation.VISIBLE := TRUE;
                      CurrForm."Per Meal Rate".VISIBLE := TRUE;
                      CurrForm."Incentive Applicable".VISIBLE := TRUE;
                      CurrForm.Date.VISIBLE := FALSE;
                      CurrForm."DM's DA Normal".VISIBLE := FALSE;
                      CurrForm."DM's DA NightOut".VISIBLE := FALSE;
                      CurrForm."DM's DA StateOffice".VISIBLE := FALSE;
                      CurrForm."DM's Car".VISIBLE := FALSE;
                      CurrForm."DM's Bike".VISIBLE := FALSE;
                    END ELSE BEGIN
                      CurrForm.Functions.VISIBLE := FALSE;
                      CurrForm."Period Start Date".VISIBLE := FALSE;
                      CurrForm."Period End Date".VISIBLE := FALSE;
                      CurrForm."Min Salary".VISIBLE := FALSE;
                      CurrForm.Probation.VISIBLE := FALSE;
                      CurrForm."Per Meal Rate".VISIBLE := FALSE;
                      CurrForm."Incentive Applicable".VISIBLE := FALSE;
                      CurrForm."DA Normal".VISIBLE := FALSE;
                      CurrForm."DA NightOut".VISIBLE := FALSE;
                      CurrForm."DA StateOffice".VISIBLE := FALSE;
                    
                    END;
                    
                    IF TemplateNameGlobal = 'DESIGNATIONS' THEN BEGIN
                      CurrForm.Lodging.VISIBLE := TRUE;
                      CurrForm."Lodging Maj.Town".VISIBLE := TRUE;
                      CurrForm.Bike.VISIBLE := TRUE;
                      CurrForm.Car.VISIBLE := TRUE;
                      CurrForm.Date.VISIBLE := FALSE;
                      CurrForm."DA Normal".VISIBLE := TRUE;
                      CurrForm."DA NightOut".VISIBLE := TRUE;
                      CurrForm."DA StateOffice".VISIBLE := TRUE;
                      CurrForm."DM's DA Normal".VISIBLE := TRUE;
                      CurrForm."DM's DA NightOut".VISIBLE := TRUE;
                      CurrForm."DM's DA StateOffice".VISIBLE := TRUE;
                      CurrForm."DM's Car".VISIBLE := TRUE;
                      CurrForm."DM's Bike".VISIBLE := TRUE;
                    END ELSE BEGIN
                      CurrForm.Lodging.VISIBLE := FALSE;
                      CurrForm."Lodging Maj.Town".VISIBLE := FALSE;
                      CurrForm.Bike.VISIBLE := FALSE;
                      CurrForm.Car.VISIBLE := FALSE;
                      CurrForm."DA Normal".VISIBLE := FALSE;
                      CurrForm."DA NightOut".VISIBLE := FALSE;
                      CurrForm."DA StateOffice".VISIBLE := FALSE;
                      CurrForm."DM's DA Normal".VISIBLE := FALSE;
                      CurrForm."DM's DA NightOut".VISIBLE := FALSE;
                      CurrForm."DM's DA StateOffice".VISIBLE := FALSE;
                      CurrForm."DM's Car".VISIBLE := FALSE;
                      CurrForm."DM's Bike".VISIBLE := FALSE;
                    END;
                    */

                    //FILTERGROUP(2);
                    rec.SETRANGE(Rec."Lookup Type", TemplateNumber);
                    CurrPage.UPDATE(FALSE);

                end;
            }
            repeater(Group)
            {
                Editable = true;
                Enabled = true;
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        Lookup.RESET;
                        Lookup.SETFILTER("Lookup Type", '22');
                        Lookup.SETRANGE(Date, Rec.Date);
                        IF Lookup.FIND('-') THEN
                            ERROR(Text001, Rec.Date);
                        DateOnAfterValidate;
                    end;
                }
                field("Lookup Name"; Rec."Lookup Name")
                {
                    ApplicationArea = all;
                    Caption = 'Lookup Name';

                    trigger OnValidate()
                    begin
                        Rec."Lookup Type" := TemplateNumber;
                        Rec."LookupType Name" := TemplateNameGlobal;

                        Lookup.SETRANGE("LookupType Name", TemplateNameGlobal);
                        IF Lookup.FIND('-') THEN BEGIN
                            REPEAT
                                IF Rec."Lookup Name" = Lookup."Lookup Name" THEN BEGIN
                                    ERROR('%1 is already exists', Rec."Lookup Name");
                                END;
                            UNTIL Lookup.NEXT = 0;
                        END;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = all;
                }
                field("DA Normal"; Rec."DA Normal")
                {
                    ApplicationArea = all;
                }
                field("DA NightOut"; Rec."DA NightOut")
                {
                    ApplicationArea = all;
                }
                field("DA StateOffice"; Rec."DA StateOffice")
                {
                    ApplicationArea = all;
                }
                field("DM's DA Normal"; Rec."DM's DA Normal")
                {
                    ApplicationArea = all;
                }
                field("DM's DA NightOut"; Rec."DM's DA NightOut")
                {
                    ApplicationArea = all;
                }
                field("DM's DA StateOffice"; Rec."DM's DA StateOffice")
                {
                    ApplicationArea = all;
                }
                field("DM's Car"; Rec."DM's Car")
                {
                    ApplicationArea = all;
                }
                field("DM's Bike"; Rec."DM's Bike")
                {
                    ApplicationArea = all;
                }
                field("All Grades"; Rec."All Grades")
                {
                    ApplicationArea = all;
                }
                field(Lodging; Rec.Lodging)
                {
                    ApplicationArea = all;
                }
                field("Lodging Maj.Town"; Rec."Lodging Maj.Town")
                {
                    ApplicationArea = all;
                }
                field(Bike; Rec.Bike)
                {
                    ApplicationArea = all;
                }
                field(Car; Rec.Car)
                {
                    ApplicationArea = all;
                }
                field("Max.Amt.Type"; Rec."Max.Amt.Type")
                {
                    ApplicationArea = all;
                }
                field("Max.Amt"; Rec."Max.Amt")
                {
                    ApplicationArea = all;
                }
                field("Max.No. of instalments"; Rec."Max.No. of instalments")
                {
                    ApplicationArea = all;
                }
                field(Probation; Rec.Probation)
                {
                    ApplicationArea = all;
                }
                field("Period Start Date"; Rec."Period Start Date")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Processing Start Date';
                }
                field("Period End Date"; Rec."Period End Date")
                {
                    ApplicationArea = all;
                    Caption = 'Salary Processing End Date';
                    Editable = false;
                }
                field("Min Salary"; Rec."Min Salary")
                {
                    ApplicationArea = all;
                }
                field("Per Meal Rate"; Rec."Per Meal Rate")
                {
                    ApplicationArea = all;
                }
                field("Incentive Applicable"; Rec."Incentive Applicable")
                {
                    ApplicationArea = all;
                }
                field("Loan Priority No."; Rec."Loan Priority No.")
                {
                    ApplicationArea = all;
                }
                field("Add/Deduct"; Rec."Add/Deduct")
                {
                    ApplicationArea = all;
                }
                field("Applicable for OT"; Rec."Applicable for OT")
                {
                    ApplicationArea = all;
                    Caption = 'OT';
                }
                field(ESI; Rec.ESI)
                {
                    ApplicationArea = all;
                }
                field(PF; Rec.PF)
                {
                    ApplicationArea = all;
                }
                field("Leave Encashment"; Rec."Leave Encashment")
                {
                    ApplicationArea = all;
                }
                field(Gratuity; Rec.Gratuity)
                {
                    ApplicationArea = all;
                }
                field("Holiday Compensation"; Rec."Holiday Compensation")
                {
                    ApplicationArea = all;
                }
                field(PT; Rec.PT)
                {
                    ApplicationArea = all;
                }
                field("Bonus/Exgratia"; Rec."Bonus/Exgratia")
                {
                    ApplicationArea = all;
                }
                field("Bonus Adjust"; Rec."Bonus Adjust")
                {
                    ApplicationArea = all;
                }
                field("Payroll Prod. Posting Group"; Rec."Payroll Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = all;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = all;
                }
                field("Order in Pay Register"; Rec."Order in Pay Register")
                {
                    ApplicationArea = all;
                }
                field("Print in Pay Register"; Rec."Print in Pay Register")
                {
                    ApplicationArea = all;
                }
            }
            label(label1)
            {
                CaptionClass = Text19014089;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Payyear)
            {
                Caption = 'Payroll &Years';
                action(List)
                {
                    ApplicationArea = all;
                    Caption = 'List';
                    RunObject = Page 60006;
                    RunPageLink = "Year Type" = FIELD("Lookup Name");
                    ShortCutKey = 'Shift+Ctrl+L';
                }
            }
        }
        area(processing)
        {
            group(Functions)
            {
                Caption = 'F&unctions';
                action("Define &Pay Elements")
                {
                    ApplicationArea = all;
                    Caption = 'Define &Pay Elements';
                    RunObject = Page 60015;
                    RunPageLink = "Pay Cadre Code" = FIELD("Lookup Name");
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Lookup Type" := TemplateNumber;
    end;

    trigger OnOpenPage()
    begin
        //----Setting the Initial Values when the Form is loaded to LookupTypes.
        TemplateNumber := 1;
        TemplateNameGlobal := 'Skill Set';
        //FILTERGROUP(2);
        rec.SETRANGE(Rec."Lookup Type", 1);
        /*
        CurrForm."Add/Deduct".VISIBLE := FALSE;
        CurrForm."Applicable for OT".VISIBLE := FALSE;
        CurrForm.ESI.VISIBLE := FALSE;
        CurrForm.PF.VISIBLE := FALSE;
        CurrForm.Type.VISIBLE := FALSE;
        CurrForm."Leave Encashment".VISIBLE := FALSE;
        CurrForm."Period Start Date".VISIBLE := FALSE;
        CurrForm."Period End Date".VISIBLE := FALSE;
        CurrForm."Payroll Prod. Posting Group".VISIBLE := FALSE;
        CurrForm.Priority.VISIBLE := FALSE;
        CurrForm."Min Salary".VISIBLE := FALSE;
        CurrForm."Loan Priority No.".VISIBLE := FALSE;
        CurrForm.Probation.VISIBLE := FALSE;
        CurrForm."Per Meal Rate".VISIBLE := FALSE;
        CurrForm.Grade.VISIBLE := FALSE;
        CurrForm."Max.Amt".VISIBLE := FALSE;
        CurrForm."Max.No. of instalments".VISIBLE := FALSE;
        CurrForm."Bonus/Exgratia".VISIBLE := FALSE;
        CurrForm."Incentive Applicable".VISIBLE := FALSE;
        CurrForm.Gratuity.VISIBLE := FALSE;
        CurrForm."Holiday Compensation".VISIBLE := FALSE;
        CurrForm.PT.VISIBLE := FALSE;
        CurrForm."Bonus Adjust".VISIBLE := FALSE;
        CurrForm."All Grades".VISIBLE := FALSE;
        CurrForm."Max.Amt.Type".VISIBLE := FALSE;
        CurrForm."Order in Pay Register".VISIBLE := FALSE;
        CurrForm."Print in Pay Register".VISIBLE := FALSE;
        CurrForm.Date.VISIBLE := FALSE;
        CurrForm."DA Normal".VISIBLE := FALSE;
        CurrForm."DA NightOut".VISIBLE := FALSE;
        CurrForm."DA StateOffice".VISIBLE := FALSE;
        CurrForm."DM's DA Normal".VISIBLE := FALSE;
        CurrForm."DM's DA NightOut".VISIBLE := FALSE;
        CurrForm."DM's DA StateOffice".VISIBLE := FALSE;
        CurrForm."DM's Car".VISIBLE := FALSE;
        CurrForm."DM's Bike".VISIBLE := FALSE;
        
        
        //
        CurrForm.Lodging.VISIBLE := FALSE;
        CurrForm."Lodging Maj.Town".VISIBLE := FALSE;
        CurrForm.Bike.VISIBLE := FALSE;
        CurrForm.Car.VISIBLE := FALSE;
        //
        //Pay year
        CurrForm.Payyear.VISIBLE := FALSE;
        CurrForm.Functions.VISIBLE := FALSE;
        
        CurrForm."Lookup Name".EDITABLE := TRUE;
        CurrForm.Description.EDITABLE := TRUE;
        CurrForm.Remarks.EDITABLE  := TRUE;
        */

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Lookup.SETRANGE("LookupType Name", 'PAY CADRE');
        IF Lookup.FIND('-') THEN
            REPEAT
                Lookup.TESTFIELD("Period Start Date");
                Lookup.TESTFIELD(Lookup."Period End Date");
            UNTIL Lookup.NEXT = 0;
    end;

    var
        LookUpType: Record 60017;
        Lookup: Record 60018;
        Employee: Record 60019;
        TemplateNameGlobal: Code[50];
        TemplateNumber: Integer;
        RecRef: RecordRef;
        Text001: Label 'Date: %1 is Already Defined.';
        Text19014089: Label 'LookUp Type';

    local procedure DateOnAfterValidate()
    begin
        Rec."Lookup Name" := FORMAT(Rec.Date);
    end;
}

