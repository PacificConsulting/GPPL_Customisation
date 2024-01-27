tableextension 50052 SalesRecSetupExtcutm extends 311
{
    fields
    {
        field(50000; "Stock Transfer_C&F Agent"; Decimal)
        {
        }
        field(50002; "No. of Forms For billing"; Integer)
        {
        }
        field(50003; "Value of Billing"; Decimal)
        {
        }
        field(50006; "OverDue Cr. Period Tolarance"; DateFormula)
        {
            Description = 'EBT/OVERDUE/APV/0001';
        }
        field(50007; "OverDue Cr. Limit Tolarance"; Decimal)
        {
            Description = 'EBT/OVERDUE/APV/0001';
        }
        field(50008; "Sales Approval Max Level"; Integer)
        {
            Description = 'EBT/OVERDUE/APV/0001';
            MinValue = 1;

            trigger OnValidate()
            var
                ApprovalLevel: Record 50008;
            begin
                //EBT/OVERDUE/APV/0001
                ApprovalLevel.RESET;
                ApprovalLevel.SETCURRENTKEY(ApprovalLevel."Approvar Level");
                IF ApprovalLevel.FINDLAST THEN BEGIN
                    IF ApprovalLevel."Approvar Level" > "Sales Approval Max Level" THEN
                        ERROR('You cannot change the Level as higher level Approval already exists in Sales Approval Setup');
                END;
                //EBT/OVERDUE/APV/0001
            end;
        }
        field(50009; "Cancelled Invoice Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50010; "Posted Cancelled Invoice Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50011; "Posted Cancelled.Shipment Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50012; "C Form Track No."; Code[10])
        {
            Description = 'EBT/CFORM/0001';
            TableRelation = "No. Series";
        }
        field(50013; "Fixed Exp Rem"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50014; "Variable Exp Rem"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50015; "Handling Charge"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50016; Account; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50017; "Dummy Sales Order Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50018; "Dummy Order"; Boolean)
        {
        }
        field(50019; "AVP Discount Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50020; "Spot Discount Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50021; "Special Mgm Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50022; "Price Difference Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(50023; "CT3 Excise Bus. Posting Group"; Code[10])
        {
            Description = 'EBT/06-05-2013/CT3';
            //TableRelation = "Excise Bus. Posting Group";
        }
        field(50024; "Email Notification On SO"; Boolean)
        {
            Description = 'RB-N 15May2018';
        }
        field(50025; "Email Notification On SalesCr"; Boolean)
        {
            Description = 'RB-N 14Sep2018';
        }
        field(50026; "Email Alert On SalesReturn"; Boolean)
        {
            Description = 'RB-N 28Jun2019';
        }
        field(50027; "Email Alert on Sales Inv Post"; Boolean)
        {
            Description = 'RSPLSUM 13Nov2019';
        }
        field(50028; "Email Alert On Customer App"; Boolean)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50029; "Email Alert On Customer Credit"; Boolean)
        {
            Description = 'RSPLSUM-BUNKER';
        }
        field(50030; "Email PDF of SO to SalesPeople"; Boolean)
        {
            Description = 'RSPLSUM 20Jan21';
        }
        field(50031; "Email Alert On Customer KYC"; Boolean)
        {
            Description = 'RSPLAM29597';
        }

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}