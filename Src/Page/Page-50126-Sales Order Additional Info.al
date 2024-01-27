page 50126 "Sales Order Additional Info"
{
    InsertAllowed = false;
    PageType = Card;
    SourceTable = 50053;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group("Bunker Details")
            {
                field("Vessel Code"; rec."Vessel Code")
                {
                    ApplicationArea = all;
                }
                field("Vessel Name"; rec."Vessel Name")
                {
                    ApplicationArea = all;
                }
                field("Port Code"; rec."Port Code")
                {
                    ApplicationArea = all;
                }
                field("Port Description"; rec."Port Description")
                {
                    ApplicationArea = all;
                }
                field("Location (of Port)"; rec."Location (of Port)")
                {
                    ApplicationArea = all;
                }
                field("Trade Terms"; rec."Trade Terms")
                {
                    ApplicationArea = all;

                }
                field("Agent Code"; rec."Agent Code")
                {
                    ApplicationArea = all;
                }
                field("Load Port"; rec."Load Port")
                {
                    ApplicationArea = all;
                }
                field("Discharge Port"; rec."Discharge Port")
                {
                    ApplicationArea = all;
                }
                field("Nature of Sale"; rec."Nature of Sale")
                {
                    ApplicationArea = all;
                }
                field("Shipping Bill No"; rec."Shipping Bill No")
                {
                    ApplicationArea = all;
                }
                field("Shipping Bill  Date"; rec."Shipping Bill  Date")
                {
                    ApplicationArea = all;
                }
                field("B/L No."; rec."B/L No.")
                {
                    ApplicationArea = all;
                }
                field("B/L Date"; rec."B/L Date")
                {
                    ApplicationArea = all;
                }
                field("BDN No."; rec."BDN No.")
                {
                    ApplicationArea = all;
                }
                // field("BDN Date"; rec."BDN Drec.ate")
                // {
                //     ApplicationArea = all;
                // }
                field("Advance Receipt No"; rec."Advance Receipt No")
                {
                    ApplicationArea = all;
                }
                field("Buyer's Order No"; rec."Buyer's Order No")
                {
                    ApplicationArea = all;
                }
                field("Buyer's Order Date"; rec."Buyer's Order Date")
                {
                    ApplicationArea = all;
                }
                field("Terms Of Delivery"; rec."Terms Of Delivery")
                {
                    ApplicationArea = all;
                }
                field("BOE No."; rec."BOE No.")
                {
                    ApplicationArea = all;
                }
                field("Port Location Name"; rec."Port Location Name")
                {
                    ApplicationArea = all;
                }
                field("Pricing Type"; rec."Pricing Type")
                {
                    ApplicationArea = all;
                }
                field("ID Card Number"; rec."ID Card Number")
                {
                    ApplicationArea = all;
                }
                field("Seal Number"; rec."Seal Number")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(sys1; Notes)
            {
            }
            systempart(sys2; Links)
            {
            }
        }
    }

    actions
    {
    }
}

