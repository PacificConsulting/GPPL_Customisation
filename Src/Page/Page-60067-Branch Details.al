page 60067 "Branch Details"
{
    PageType = Card;
    SourceTable = 60012;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Branch Code"; rec."Branch Code")
                {
                    ApplicationArea = all;
                }
                field("Branch Name"; rec."Branch Name")
                {
                    ApplicationArea = all;
                }
                field(Address; rec.Address)
                {
                    ApplicationArea = all;
                }
                field(Address2; rec.Address2)
                {
                    ApplicationArea = all;
                }
                field("Post Code/City"; rec."Post Code/City")
                {
                    ApplicationArea = all;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No."; rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Fax No."; rec."Fax No.")
                {
                    ApplicationArea = all;
                }
                field("Email Id"; rec."Email Id")
                {
                    ApplicationArea = all;
                }
            }
            group(Details)
            {
                Caption = 'Details';
                field("ESI No."; rec."ESI No.")
                {
                    ApplicationArea = all;
                }
                field("PF No."; rec."PF No.")
                {
                    ApplicationArea = all;
                }
                field("PAN No."; rec."PAN No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        RecRef: RecordRef;
}

