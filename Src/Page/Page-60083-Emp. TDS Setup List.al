page 60083 "Emp. TDS Setup List"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = 60008;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field(Month; rec.Month)
                {
                    ApplicationArea = all;
                }
                field(Year; rec.Year)
                {
                    ApplicationArea = all;
                }
                field("TDS Amount"; rec."TDS Amount")
                {
                    ApplicationArea = all;
                }
                field("Surcharge Amount"; rec."Surcharge Amount")
                {
                    ApplicationArea = all;
                }
                field("e-Cess Amount"; rec."e-Cess Amount")
                {
                    ApplicationArea = all;
                }
                field("SHE Cess Amount"; rec."SHE Cess Amount")
                {
                    ApplicationArea = all;
                }
                field(Processed; rec.Processed)
                {
                    ApplicationArea = all;
                }
                field(Posted; rec.Posted)
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

