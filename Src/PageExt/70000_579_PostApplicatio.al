pageextension 70000 "PostAppExtCstm" extends "Post Application"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        DocNo: Code[20];
        PostingDate: Date;

    //[Scope('Internal')]
    procedure SetValues(NewDocNo: Code[20]; NewPostingDate: Date)
    begin
        DocNo := NewDocNo;
        PostingDate := NewPostingDate;
    end;

    //[Scope('Internal')]
    procedure GetValues(var NewDocNo: Code[20]; var NewPostingDate: Date)
    begin
        NewDocNo := DocNo;
        NewPostingDate := PostingDate;
    end;
}