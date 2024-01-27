page 50119 "Shipped Not Received"
{
    Editable = false;
    PageType = List;
    SourceTable = 50010;
    SourceTableView = WHERE(Shipped = CONST(true),
                            Received = CONST(false));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Transfer From Location"; rec."Transfer From Location")
                {
                }
                field("Transfer To Location"; rec."Transfer To Location")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Form Code"; rec."Form Code")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Courier Name"; rec."Courier Name")
                {
                    ApplicationArea = all;
                }
                field("Courier Date"; rec."Courier Date")
                {
                    ApplicationArea = all;
                }
                field("Courier By"; rec."Courier By")
                {
                    ApplicationArea = all;
                }
                field("Form No."; rec."Form No.")
                {
                    ApplicationArea = all;
                }
                field(Shipped; rec.Shipped)
                {
                    ApplicationArea = all;
                }
                field(Received; rec.Received)
                {
                    ApplicationArea = all;
                }
                field("No. Series"; rec."No. Series")
                {
                    ApplicationArea = all;
                }
                field("Received By"; rec."Received By")
                {
                    ApplicationArea = all;
                }
                field("Receiving Date"; rec."Receiving Date")
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

