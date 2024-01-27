tableextension 50001 ShipmentMethodCustm extends "Shipment Method"
{
    fields
    {
        field(50000; "GST Reporting Transport Mode"; Option)
        {
            OptionMembers = " ",Road,Rail,Air,Ship;
            OptionCaption = ' ,Road,Rail,Air,Ship';
        }
    }

}