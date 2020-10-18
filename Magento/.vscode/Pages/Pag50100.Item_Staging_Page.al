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
                field(Converted; "Converted to NAV Item")
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
            action("Convert to NAV")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;

                trigger OnAction();
                var
                    lMageMgt: Codeunit "Magento Management";
                    lItemStaging: Record "Item Staging Table";
                begin
                    Clear(lMageMgt);
                    lItemStaging.Reset();
                    lItemStaging.SetRange("Converted to NAV Item", false);
                    if lItemStaging.FindSet() then begin
                        repeat
                            lMageMgt.ConvertToNAVItem(lItemStaging);
                        until lItemStaging.Next() = 0;
                    end;
                    lMageMgt.GetItemFromMagento();
                end;
            }
        }
    }
}