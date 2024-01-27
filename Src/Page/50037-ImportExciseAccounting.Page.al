page 50037 "Import Excise Accounting"
{
    PageType = List;
    SourceTable = 50018;
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
                }
                field("Inv. Posting Group"; rec."Inv. Posting Group")
                {
                    applicationarea = all;
                }
                field("Ecess Account"; rec."Ecess Account")
                {
                    applicationarea = all;
                }
                field("She Cess"; rec."She Cess")
                {
                    applicationarea = all;
                }
                field("Custom Ecess Account"; rec."Custom Ecess Account")
                {
                    applicationarea = all;
                }
                field("Custom Ecess Upload Inv"; rec."Custom Ecess Upload Inv")
                {
                    applicationarea = all;
                }
                field("Cust She Cess Upload Inv"; rec."Cust She Cess Upload Inv")
                {
                    applicationarea = all;
                }
                field("Custom She Cess Acc"; rec."Custom She Cess Acc")
                {
                    applicationarea = all;
                }
                field("ADE Account"; rec."ADE Account")
                {
                    applicationarea = all;
                }
                field("CVD Account"; rec."CVD Account")
                {
                    applicationarea = all;
                }
                field("BCD Upload Inv"; rec."BCD Upload Inv")
                {
                    applicationarea = all;
                }
                field("BCD Account"; rec."BCD Account")
                {
                    applicationarea = all;
                }
                field("BED Account"; rec."BED Account")
                {
                    applicationarea = all;
                }
                field("Excise Payable Account"; rec."Excise Payable Account")
                {
                    applicationarea = all;
                }
                field("Excise Control Acc"; rec."Excise Control Acc")
                {
                    applicationarea = all;
                }
            }
        }
    }

    actions
    {
    }
}

