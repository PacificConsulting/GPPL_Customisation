page 50070 "Transporter Details"
{
    // Date        Version      Remarks
    // .....................................................................................
    // 14Nov2017   RB-N         Transport Details Update

    CardPageID = "Transport Detail Entry Form";
    PageType = List;
    SourceTable = 50020;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Invoice No."; rec."Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("Invoice Date"; rec."Invoice Date")
                {
                    ApplicationArea = all;
                }
                field("LR No."; rec."LR No.")
                {
                    ApplicationArea = all;
                }
                field("LR Date"; rec."LR Date")
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("From Location Code"; rec."From Location Code")
                {
                    ApplicationArea = all;
                }
                field("From Location Name"; rec."From Location Name")
                {
                    ApplicationArea = all;
                }
                field(Destination; rec.Destination)
                {
                    ApplicationArea = all;
                }
                field("Vendor Code"; rec."Vendor Code")
                {
                    ApplicationArea = all;
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Code"; rec."Shipping Agent Code")
                {
                    ApplicationArea = all;
                }
                field("Shipping Agent Name"; rec."Shipping Agent Name")
                {
                    ApplicationArea = all;
                }
                field("TPT Invoice No."; rec."TPT Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("TPT Invoice Date"; rec."TPT Invoice Date")
                {
                    ApplicationArea = all;
                }
                field("TPT Type"; rec."TPT Type")
                {
                    ApplicationArea = all;
                }
                field("Expected TPT Cost"; rec."Expected TPT Cost")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field(Rate; rec.Rate)
                {
                    ApplicationArea = all;
                }
                field("Passed Amount"; rec."Passed Amount")
                {
                    ApplicationArea = all;
                }
                field("To Location Code"; rec."To Location Code")
                {
                    ApplicationArea = all;
                }
                field("To Location Name"; rec."To Location Name")
                {
                    ApplicationArea = all;
                }
                field("Freight Type"; rec."Freight Type")
                {
                    ApplicationArea = all;
                }
                field("Bill Amount"; rec."Bill Amount")
                {
                    ApplicationArea = all;
                }
                field(Open; rec.Open)
                {
                    ApplicationArea = all;
                }
                field(Applied; rec.Applied)
                {
                    ApplicationArea = all;
                }
                field("Applied Document No."; rec."Applied Document No.")
                {
                    ApplicationArea = all;
                }
                field("Applied Date"; rec."Applied Date")
                {
                    ApplicationArea = all;
                }
                field(Posted; rec.Posted)
                {
                    ApplicationArea = all;
                }
                field("Cancelled Invoice"; rec."Cancelled Invoice")
                {
                    ApplicationArea = all;
                    Editable = CancelInvEdtiable;
                }
                field("Local LR No."; rec."Local LR No.")
                {
                    ApplicationArea = all;
                }
                field("Local LR Date"; rec."Local LR Date")
                {
                    ApplicationArea = all;
                }
                field("Local Vehicle No."; rec."Local Vehicle No.")
                {
                    ApplicationArea = all;
                }
                field("Local Shipment Agent Code"; rec."Local Shipment Agent Code")
                {
                    ApplicationArea = all;
                }
                field("Local Shipment Agent Name"; rec."Local Shipment Agent Name")
                {
                    ApplicationArea = all;
                }
                field("Local Expected TPT Cost"; rec."Local Expected TPT Cost")
                {
                    ApplicationArea = all;
                }
                field("Local TPT Bill Amount"; rec."Local TPT Bill Amount")
                {
                    ApplicationArea = all;
                }
                field("Local TPT Passed Amount"; rec."Local TPT Passed Amount")
                {
                    ApplicationArea = all;
                }
                field("Local TPT Invoice No."; rec."Local TPT Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("Local TPT Invoice Date"; rec."Local TPT Invoice Date")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field(UOM; rec.UOM)
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field("Vehicle Capacity"; rec."Vehicle Capacity")
                {
                    ApplicationArea = all;
                }
                field("Local Vehicle Capacity"; rec."Local Vehicle Capacity")
                {
                    ApplicationArea = all;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = all;
                }
                field("Blanket Order/ Shipment No."; rec."Blanket Order/ Shipment No.")
                {
                    ApplicationArea = all;
                }
                field("Other Charges"; rec."Other Charges")
                {
                    ApplicationArea = all;
                }
                field("Other Charges-Local"; rec."Other Charges-Local")
                {
                    ApplicationArea = all;
                }
                field("Total Amount"; rec."Total Amount")
                {
                    ApplicationArea = all;
                }
                field("Total Amount-Local"; rec."Total Amount-Local")
                {
                    ApplicationArea = all;
                }
                field("Type of Vehicle"; rec."Type of Vehicle")
                {
                    ApplicationArea = all;
                }
                field("Category of Tanker 1"; rec."Category of Tanker 1")
                {
                    ApplicationArea = all;
                }
                field("Category of Tanker 2"; rec."Category of Tanker 2")
                {
                    ApplicationArea = all;
                }
                field("Category of Tanker 3"; rec."Category of Tanker 3")
                {
                    ApplicationArea = all;
                }
                field("Category of Tanker 4"; rec."Category of Tanker 4")
                {
                    ApplicationArea = all;
                }
                field("Type of Truck"; rec."Type of Truck")
                {
                    ApplicationArea = all;
                }
                field("Entry Date"; rec."Entry Date")
                {
                    ApplicationArea = all;
                }
                field(Reason; rec.Reason)
                {
                    ApplicationArea = all;
                }
                field("TPT Invoice Receipt Date"; rec."TPT Invoice Receipt Date")
                {
                    ApplicationArea = all;
                }
                field(Deductions; rec.Deductions)
                {
                    ApplicationArea = all;
                }
                field("Total Quantity in(Kg)"; rec."Total Quantity in(Kg)")
                {
                    ApplicationArea = all;
                }
                field("Quantity in Ltrs."; rec."Quantity in Ltrs.")
                {
                    ApplicationArea = all;
                }
                field("Quantity in KGS"; rec."Quantity in KGS")
                {
                    ApplicationArea = all;
                }
                field("Total Packing Material Weight"; rec."Total Packing Material Weight")
                {
                    ApplicationArea = all;
                }
                field("Grand Total"; rec."Grand Total")
                {
                    ApplicationArea = all;
                }
                field("Additional Weight"; rec."Additional Weight")
                {
                    ApplicationArea = all;
                }
                field("No. of Packs"; rec."No. of Packs")
                {
                    ApplicationArea = all;
                }
                field("Vehicle Capacity Gate Entry"; rec."Vehicle Capacity Gate Entry")
                {
                    ApplicationArea = all;
                }
                field("Gate Entry No."; rec."Gate Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Expected Loading"; rec."Expected Loading")
                {
                    ApplicationArea = all;
                }
                field("Expetced Unloading"; rec."Expetced Unloading")
                {
                    ApplicationArea = all;
                }
                field("Actual Loading"; rec."Actual Loading")
                {
                    ApplicationArea = all;
                }
                field("Actual Unloading"; rec."Actual Unloading")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        CancelInvEdtiable: Boolean;
}

