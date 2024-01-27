page 50029 "Qc Approval"
{
    PageType = List;
    SourceTable = 50015;
    SourceTableView = WHERE("Tested By" = FILTER(<> ''),
                            "Test Result Approved" = CONST(false));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control01)
            {
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Version Code"; rec."Version Code")
                {
                    ApplicationArea = all;
                }
                field(Parameter; rec.Parameter)
                {
                    ApplicationArea = all;
                }
                field("Typical Value"; rec."Typical Value")
                {
                    ApplicationArea = all;
                }
                field("Min Value"; rec."Min Value")
                {
                    ApplicationArea = all;
                }
                field("Max Value"; rec."Max Value")
                {
                    ApplicationArea = all;
                }
                field(Mandatory; rec.Mandatory)
                {
                    ApplicationArea = all;
                }
                field(Result; rec.Result)
                {
                    ApplicationArea = all;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Batch No./DC No"; rec."Batch No./DC No")
                {
                    ApplicationArea = all;
                }
                field("Testing Method"; rec."Testing Method")
                {
                    ApplicationArea = all;
                }
                field("Blend Order No"; rec."Blend Order No")
                {
                    ApplicationArea = all;
                }
                field("Tested By"; rec."Tested By")
                {
                    ApplicationArea = all;
                }
                field("QC Test Report Generated"; rec."QC Test Report Generated")
                {
                    ApplicationArea = all;
                }
                field("Approved By"; rec."Approved By")
                {
                    ApplicationArea = all;
                }
                field("Test Result Approved"; rec."Test Result Approved")
                {
                    ApplicationArea = all;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = all;
                }
                field("Remarks 1"; rec."Remarks 1")
                {
                    ApplicationArea = all;
                }
                field("Certificate No."; rec."Certificate No.")
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
            action("&Approved")
            {
                Caption = '&Approved';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ManufacturingSetup.GET;
                    ManufacturingSetup.TESTFIELD(ManufacturingSetup."Certificate Nos.");
                    CertificatedNo := NoSeriesMangment.GetNextNo(ManufacturingSetup."Certificate Nos.", TODAY, TRUE);

                    User.GET(USERID);

                    ItemParameterResutl.RESET;
                    ItemParameterResutl.SETRANGE(ItemParameterResutl."Item No.", rec."Item No.");
                    ItemParameterResutl.SETRANGE(ItemParameterResutl."Blend Order No", rec."Blend Order No");
                    ItemParameterResutl.SETRANGE(ItemParameterResutl."Tested By", rec."Tested By");
                    IF ItemParameterResutl.FINDSET THEN
                        REPEAT
                            ItemParameterResutl."Certificate No." := CertificatedNo;
                            ItemParameterResutl."Approved By" := User.Name;
                            ItemParameterResutl."Test Result Approved" := TRUE;
                            ItemParameterResutl.MODIFY;
                        UNTIL ItemParameterResutl.NEXT = 0;

                    // EBT MILAN (30102013)....To Update Qc Tested Field in Production Order..........................................START
                    ProductionOrder.RESET;
                    ProductionOrder.SETRANGE(ProductionOrder.Status, ProductionOrder.Status::Released);
                    ProductionOrder.SETRANGE(ProductionOrder."No.", rec."Blend Order No");
                    IF ProductionOrder.FINDFIRST THEN BEGIN
                        ProductionOrder."QC Tested" := TRUE;
                        ProductionOrder.MODIFY;
                    END;
                    // EBT MILAN (30102013)....To Update Qc Tested Field in Production Order............................................END
                    MESSAGE('Approved');
                end;
            }
        }
    }

    var
        ManufacturingSetup: Record 99000765;
        CertificatedNo: Code[20];
        NoSeriesMangment: Codeunit 396;
        ItemParameterResutl: Record 50015;
        ItemvarParamresult: Record 50015;
        ProductionOrder: Record 5405;
        User: Record 91;
}

