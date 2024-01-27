pageextension 50001 CurrenciesExt extends Currencies
{


    layout
    {
        // Add changes to page layout here
        modify("Amount Rounding Precision")
        {
            Editable = false;
        }
        modify("Invoice Rounding Precision")
        {
            Editable = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}