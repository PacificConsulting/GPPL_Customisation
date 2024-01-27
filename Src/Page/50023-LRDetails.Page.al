page 50023 "LR Details"
{
    PageType = List;
    SourceTable = "Posted Gate Entry Header";
    SourceTableView = WHERE(Transporter = FILTER(<> ''),
                            Invoiced = CONST(false));

    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Entry Type"; rec."Entry Type")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("No."; rec."No.")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Document Date"; rec."Document Date")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Document Time"; rec."Document Time")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("LR/RR No."; rec."LR/RR No.")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("LR/RR Date"; rec."LR/RR Date")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Gate Entry No."; rec."Gate Entry No.")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field(Transporter; rec.Transporter)
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Transporter Name"; rec."Transporter Name")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field("Invoice No."; rec."Invoice No.")
                {
                    applicationarea = all;
                    Editable = false;
                }
                field(Invoice; rec.Invoice)
                {
                    applicationarea = all;

                    trigger OnValidate()
                    begin
                        IF rec.Invoice THEN
                            rec."Invoice No." := InvDocNo
                        ELSE
                            rec."Invoice No." := '';
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        InvDocNo: Code[20];

    // [Scope('Internal')]
    procedure SetDocNo(InvNo: Code[20])
    begin
        InvDocNo := InvNo;
    end;
}

