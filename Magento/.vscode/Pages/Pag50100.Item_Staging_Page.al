page 50100 "Item Staging Page"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Staging Table";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(product_id; product_id)
                {
                    ApplicationArea = All;

                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(sku; sku)
                {
                    ApplicationArea = All;

                }
                field(item_type; item_type)
                {
                    ApplicationArea = All;

                }
                field(category_id; category_id)
                {
                    ApplicationArea = All;

                }
                field(website_id; website_id)
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Get Items from Magento")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = GetEntries;

                trigger OnAction();
                var
                    lMageMgt: Codeunit 50100;
                begin
                    Clear(lMageMgt);
                    lMageMgt.GetItemFromMagento();
                end;
            }
        }
    }
}