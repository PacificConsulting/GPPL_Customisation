page 60091 "Interview Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = 60060;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field("Interview Type"; rec."Interview Type")
                {
                    ApplicationArea = all;
                }
                field("Candidate No."; rec."Candidate No.")
                {
                    ApplicationArea = all;
                }
                field("Candidate Name"; rec."Candidate Name")
                {
                    ApplicationArea = all;
                }
                field("Interview Date"; rec."Interview Date")
                {
                    ApplicationArea = all;
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = all;
                }
                field(Finish; rec.Finish)
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

