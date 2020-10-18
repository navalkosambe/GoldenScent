pageextension 50101 "Item Card Extension" extends "Item Card"
{
    layout
    {
        addafter(Warehouse)
        {
            group(Magento)
            {
                CaptionML = ENU = 'Magento';
                field("Magento Product ID"; "Magento Product ID")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Magento Product Name"; "Magento Product Name")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Magento SKU"; "Magento SKU")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Magento Type"; "Magento Type")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Magento Category_ID"; "Magento Category_ID")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Magento Website_ID"; "Magento Website_ID")
                {
                    ApplicationArea = All;
                    Editable = false;

                }

            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}