page 50168 "Update Transport Details"
{
    PageType = List;
    Permissions = TableData 50020 = rm;
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
                    Editable = true;
                }
                field("Invoice Date"; rec."Invoice Date")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("LR No."; rec."LR No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("LR Date"; rec."LR Date")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("From Location Code"; rec."From Location Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("From Location Name"; rec."From Location Name")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Destination; rec.Destination)
                {
                    ApplicationArea = all;
                    Editable = true;
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
                    Editable = true;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Rate; rec.Rate)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Passed Amount"; rec."Passed Amount")
                {
                    ApplicationArea = all;
                }
                field("To Location Code"; rec."To Location Code")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("To Location Name"; rec."To Location Name")
                {
                    ApplicationArea = all;
                    Editable = true;
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
                }
                field("Local LR No."; rec."Local LR No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Local LR Date"; rec."Local LR Date")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Local Vehicle No."; rec."Local Vehicle No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Local Shipment Agent Code"; rec."Local Shipment Agent Code")
                {
                    ApplicationArea = all;
                    Editable = true;
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
                    Editable = true;
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
                    Editable = true;
                }
                field("Local Vehicle Capacity"; rec."Local Vehicle Capacity")
                {
                    ApplicationArea = all;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = all;
                    Editable = true;
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
                    Editable = true;
                }
                field("Quantity in Ltrs."; rec."Quantity in Ltrs.")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Quantity in KGS"; rec."Quantity in KGS")
                {
                    ApplicationArea = all;
                    Editable = true;
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
                    Editable = true;
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
                    Editable = true;
                }
                field("Expetced Unloading"; rec."Expetced Unloading")
                {
                    ApplicationArea = all;
                    Editable = true;
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
}

