page 60089 "Closed Training Details"
{
    Editable = false;
    PageType = Document;
    SourceTable = 60057;
    SourceTableView = WHERE(Status = FILTER(Closed));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Course Name"; rec."Course Name")
                {
                    ApplicationArea = all;
                }
                field("Need  for Training"; rec."Need  for Training")
                {
                    ApplicationArea = all;
                }
                field("Initiating Dept"; rec."Initiating Dept")
                {
                    ApplicationArea = all;
                }
                field("Date of Creation"; rec."Date of Creation")
                {
                    ApplicationArea = all;
                }
                field("Starting Date"; rec."Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Ending Date"; rec."Ending Date")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            part(part1; 60061)
            {
                SubPageLink = "Training Header No." = FIELD("No.");
            }
            group(Details)
            {
                Caption = 'Details';
                field(Agency; rec.Agency)
                {
                    ApplicationArea = all;
                }
                field("Agency Name"; rec."Agency Name")
                {
                    ApplicationArea = all;
                }
                field("Training Subject"; rec."Training Subject")
                {
                    ApplicationArea = all;
                }
                field("Training Facility"; rec."Training Facility")
                {
                    ApplicationArea = all;
                }
                field("Training Premises"; rec."Training Premises")
                {
                    ApplicationArea = all;
                }
                field("Training Type"; rec."Training Type")
                {
                    ApplicationArea = all;
                }
                field("No. of Employees"; rec."No. of Employees")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No. Series"; rec."No. Series")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Actual Start Date"; rec."Actual Start Date")
                {
                    ApplicationArea = all;
                }
                field("Actual Closed Date"; rec."Actual Closed Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

