page 60094 "Interviewee List"
{
    Editable = false;
    PageType = List;
    SourceTable = 60061;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("First Name"; rec."First Name")
                {
                    ApplicationArea = all;
                }
                field("Middle Name"; rec."Middle Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; rec."Last Name")
                {
                    ApplicationArea = all;
                }
                field(Initials; rec.Initials)
                {
                    ApplicationArea = all;
                }
                field("Search Name"; rec."Search Name")
                {
                    ApplicationArea = all;
                }
                field(Address; rec.Address)
                {
                    ApplicationArea = all;
                }
                field("Address 2"; rec."Address 2")
                {
                    ApplicationArea = all;
                }
                field(City; rec.City)
                {
                    ApplicationArea = all;
                }
                field("Post Code"; rec."Post Code")
                {
                    ApplicationArea = all;
                }
                field(County; rec.County)
                {
                    ApplicationArea = all;
                }
                field("Phone No."; rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Mobile Phone No."; rec."Mobile Phone No.")
                {
                    ApplicationArea = all;
                }
                field("E-Mail"; rec."E-Mail")
                {
                    ApplicationArea = all;
                }
                field("Birth Date"; rec."Birth Date")
                {
                    ApplicationArea = all;
                }
                field(Gender; rec.Gender)
                {
                    ApplicationArea = all;
                }
                field("Country/Region Code"; rec."Country/Region Code")
                {
                    ApplicationArea = all;
                }
                field(Comment; rec.Comment)
                {
                    ApplicationArea = all;
                }
                field("No. Series"; rec."No. Series")
                {
                    ApplicationArea = all;
                }
                field("Martial status"; rec."Martial status")
                {
                    ApplicationArea = all;
                }
                field("No. Of Children"; rec."No. Of Children")
                {
                    ApplicationArea = all;
                }
                field("Driving License No."; rec."Driving License No.")
                {
                    ApplicationArea = all;
                }
                field("PAN No"; rec."PAN No")
                {
                    ApplicationArea = all;
                }
                field("PF No"; rec."PF No")
                {
                    ApplicationArea = all;
                }
                field("Blood Group"; rec."Blood Group")
                {
                    ApplicationArea = all;
                }
                field(Passport; rec.Passport)
                {
                    ApplicationArea = all;
                }
                field(Experience; rec.Experience)
                {
                    ApplicationArea = all;
                }
                field("Resume DB No."; rec."Resume DB No.")
                {
                    ApplicationArea = all;
                }
                field("Pervious Employer Name"; rec."Pervious Employer Name")
                {
                    ApplicationArea = all;
                }
                field("Previous Designation"; rec."Previous Designation")
                {
                    ApplicationArea = all;
                }
                field("Previous CTC"; rec."Previous CTC")
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
            group("&Interviewee")
            {
                Caption = '&Interviewee';
                action("&Card")
                {
                    ApplicationArea = all;
                    Caption = '&Card';
                    Image = EditLines;
                    RunObject = Page 60093;
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}

