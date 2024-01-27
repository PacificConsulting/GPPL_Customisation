pageextension 60005 Item_List_Ext extends "Item List"
{
    layout
    {
        addafter("No.")
        {
            field("GST Group Code"; Rec."GST Group Code")
            {
                ApplicationArea = all;
            }
            field("HSN/SAC Code"; rec."HSN/SAC Code")
            {
                ApplicationArea = all;
            }
            field("Description 3"; Rec."Description 3")
            {
                ApplicationArea = all;
            }
            field("FOC Applicable"; rec."FOC Applicable")
            {
                ApplicationArea = all;
            }
            field("Packing Material Weight in KG"; rec."Packing Material Weight in KG")
            {
                ApplicationArea = all;
            }

            field("Created Date"; rec."Created Date")
            {
                ApplicationArea = all;
            }
            field(Inventory; Rec.Inventory)
            {
                ApplicationArea = all;
            }
            /* field("Base Unit of Measure"; Rec."Base Unit of Measure")
            {
                ApplicationArea = all;
            }
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = all;
            }
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = all;
            }
            field("Item Tracking Code"; Rec."Item Tracking Code")
            {
                ApplicationArea = all;
            } */
            field("Tax Group Code"; Rec."Tax Group Code")
            {
                ApplicationArea = all;
            }
            field("Lot Nos."; Rec."Lot Nos.")
            {
                ApplicationArea = all;
            }
            field("Production Order Type"; rec."Production Order Type")
            {
                ApplicationArea = all;
            }
            // field("Excise Prod. Posting Group"; rec."Excise Prod. Posting Group")
            // {
            //     ApplicationArea = all;
            // }
            field("QC Applicable"; rec."QC Applicable")
            {
                ApplicationArea = all;
            }
        }
        addafter("Cost is Adjusted")
        {
            // field("MRP Value"; rec."MRP Value")
            // {
            //     ApplicationArea = all;
            // }
        }
        addafter("Lead Time Calculation")
        {
            // field("Price Inclusive of Tax"; rec."Price Inclusive of Tax")
            // {
            //     ApplicationArea = all;
            // }
        }
        addafter("Default Deferral Template Code")
        {
            field("Standard Yield"; rec."Standard Yield")
            {
                ApplicationArea = all;
            }
            field("Reorder Quantity"; rec."Reorder Quantity")
            {
                ApplicationArea = all;
            }
            field("Maximum Inventory"; rec."Maximum Inventory")
            {
                ApplicationArea = all;
            }
            field("Safety Stock Quantity"; rec."Safety Stock Quantity")
            {
                ApplicationArea = all;
            }
            field("No of Packages"; rec."No of Packages")
            {
                ApplicationArea = all;
            }
        }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        rec.SETCURRENTKEY(Description);

        //RSPLSUM 29Dec2020>>
        UserSetup.GET(USERID);
        IF UserSetup."Description 3 Visible" THEN
            Desc3Visible := TRUE
        ELSE
            Desc3Visible := FALSE;
        //RSPLSUM 29Dec2020<<
    END;


    var
        myInt: Integer;
        UserSetup: Record 91;
        Desc3Visible: Boolean;
}