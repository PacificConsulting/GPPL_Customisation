page 70099 Testing
{
    PageType = Card;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            field(StartTime; StartTime)
            {
                ApplicationArea = all;
            }
            field(EndTime; EndTime)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(action)
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Value := StartTime - EndTime;
                    MESSAGE(FORMAT(Value));
                end;
            }
        }
    }

    var
        StartTime: Time;
        EndTime: Time;
        Value: Decimal;
}

