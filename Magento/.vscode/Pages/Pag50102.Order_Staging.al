page 50102 "Magento Order Staging"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Magento Staging Header";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(increment_id; increment_id)
                {
                    ApplicationArea = All;

                }
                field(store_id; store_id)
                {
                    ApplicationArea = All;

                }
                field(created_at; created_at)
                {
                    ApplicationArea = All;

                }
                field(updated_at; updated_at)
                {
                    ApplicationArea = All;

                }
                field(customer_id; customer_id)
                {
                    ApplicationArea = All;

                }
                field(tax_amount; tax_amount)
                {
                    ApplicationArea = All;

                }
                field(shipping_amount; shipping_amount)
                {
                    ApplicationArea = All;

                }
                field(discount_amount; discount_amount)
                {
                    ApplicationArea = All;

                }
                field(subtotal; subtotal)
                {
                    ApplicationArea = All;

                }
                field(grand_total; grand_total)
                {
                    ApplicationArea = All;

                }
                field(total_qty_ordered; total_qty_ordered)
                {
                    ApplicationArea = All;

                }
                field(total_canceled; total_canceled)
                {
                    ApplicationArea = All;

                }
                field(base_tax_amount; base_tax_amount)
                {
                    ApplicationArea = All;

                }
                field(base_shipping_amount; base_shipping_amount)
                {
                    ApplicationArea = All;

                }
                field(base_discount_amount; base_discount_amount)
                {
                    ApplicationArea = All;

                }
                field(base_subtotal; base_subtotal)
                {
                    ApplicationArea = All;

                }
                field(base_grand_total; base_grand_total)
                {
                    ApplicationArea = All;

                }
                field(base_total_canceled; base_total_canceled)
                {
                    ApplicationArea = All;

                }
                field(billing_address_id; billing_address_id)
                {
                    ApplicationArea = All;

                }
                field(billing_firstname; billing_firstname)
                {
                    ApplicationArea = All;

                }
                field(billing_lastname; billing_lastname)
                {
                    ApplicationArea = All;

                }
                field(shipping_address_id; shipping_address_id)
                {
                    ApplicationArea = All;

                }
                field(shipping_firstname; shipping_firstname)
                {
                    ApplicationArea = All;

                }
                field(shipping_lastname; shipping_lastname)
                {
                    ApplicationArea = All;

                }
                field(billing_name; billing_name)
                {
                    ApplicationArea = All;

                }
                field(shipping_name; shipping_name)
                {
                    ApplicationArea = All;

                }
                field(store_to_base_rate; store_to_base_rate)
                {
                    ApplicationArea = All;

                }
                field(store_to_order_rate; store_to_order_rate)
                {
                    ApplicationArea = All;

                }
                field(base_to_global_rate; base_to_global_rate)
                {
                    ApplicationArea = All;

                }
                field(base_to_order_rate; base_to_order_rate)
                {
                    ApplicationArea = All;

                }
                field(weight; weight)
                {
                    ApplicationArea = All;

                }
                field(store_name; store_name)
                {
                    ApplicationArea = All;

                }
                field(status; status)
                {
                    ApplicationArea = All;

                }
                field(state; state)
                {
                    ApplicationArea = All;

                }
                field(applied_rule_ids; applied_rule_ids)
                {
                    ApplicationArea = All;

                }
                field(global_currency_code; global_currency_code)
                {
                    ApplicationArea = All;

                }
                field(base_currency_code; base_currency_code)
                {
                    ApplicationArea = All;

                }
                field(store_currency_code; store_currency_code)
                {
                    ApplicationArea = All;

                }
                field(order_currency_code; order_currency_code)
                {
                    ApplicationArea = All;

                }
                field(shipping_method; shipping_method)
                {
                    ApplicationArea = All;

                }
                field(shipping_description; shipping_description)
                {
                    ApplicationArea = All;

                }
                field(customer_email; customer_email)
                {
                    ApplicationArea = All;

                }
                field(customer_firstname; customer_firstname)
                {
                    ApplicationArea = All;

                }
                field(customer_lastname; customer_lastname)
                {
                    ApplicationArea = All;

                }
                field(quote_id; quote_id)
                {
                    ApplicationArea = All;

                }
                field(is_virtual; is_virtual)
                {
                    ApplicationArea = All;

                }
                field(customer_group_id; customer_group_id)
                {
                    ApplicationArea = All;

                }
                field(customer_note_notify; customer_note_notify)
                {
                    ApplicationArea = All;

                }
                field(customer_is_guest; customer_is_guest)
                {
                    ApplicationArea = All;

                }
                field(email_sent; email_sent)
                {
                    ApplicationArea = All;

                }
                field(order_id; order_id)
                {
                    ApplicationArea = All;

                }
                field(protect_code; protect_code)
                {
                    ApplicationArea = All;

                }
                field(base_discount_canceled; base_discount_canceled)
                {
                    ApplicationArea = All;

                }
                field(base_shipping_canceled; base_shipping_canceled)
                {
                    ApplicationArea = All;

                }
                field(base_subtotal_canceled; base_subtotal_canceled)
                {
                    ApplicationArea = All;

                }
                field(base_tax_canceled; base_tax_canceled)
                {
                    ApplicationArea = All;

                }
                field(discount_canceled; discount_canceled)
                {
                    ApplicationArea = All;

                }
                field(shipping_canceled; shipping_canceled)
                {
                    ApplicationArea = All;

                }
                field(shipping_tax_amount; shipping_tax_amount)
                {
                    ApplicationArea = All;

                }
                field(subtotal_canceled; subtotal_canceled)
                {
                    ApplicationArea = All;

                }
                field(tax_canceled; tax_canceled)
                {
                    ApplicationArea = All;

                }
                field(edit_increment; edit_increment)
                {
                    ApplicationArea = All;

                }
                field(paypal_ipn_customer_notified; paypal_ipn_customer_notified)
                {
                    ApplicationArea = All;

                }
                field(base_shipping_discount_amount; base_shipping_discount_amount)
                {
                    ApplicationArea = All;

                }
                field(base_subtotal_incl_tax; base_subtotal_incl_tax)
                {
                    ApplicationArea = All;

                }
                field(base_total_due; base_total_due)
                {
                    ApplicationArea = All;

                }
                field(shipping_discount_amount; shipping_discount_amount)
                {
                    ApplicationArea = All;

                }
                field(subtotal_incl_tax; subtotal_incl_tax)
                {
                    ApplicationArea = All;

                }
                field(total_due; total_due)
                {
                    ApplicationArea = All;

                }
                field(original_increment_id; original_increment_id)
                {
                    ApplicationArea = All;

                }
                field(relation_parent_id; relation_parent_id)
                {
                    ApplicationArea = All;

                }
                field(relation_parent_real_id; relation_parent_real_id)
                {
                    ApplicationArea = All;

                }
                field(total_item_count; total_item_count)
                {
                    ApplicationArea = All;

                }
                field(hidden_tax_amount; hidden_tax_amount)
                {
                    ApplicationArea = All;

                }
                field(base_hidden_tax_amount; base_hidden_tax_amount)
                {
                    ApplicationArea = All;

                }
                field(shipping_hidden_tax_amount; shipping_hidden_tax_amount)
                {
                    ApplicationArea = All;

                }
                field(base_shipping_hidden_tax_amount; base_ship_hidden_tax_amount)
                {
                    ApplicationArea = All;

                }
                field(shipping_incl_tax; shipping_incl_tax)
                {
                    ApplicationArea = All;

                }
                field(base_shipping_incl_tax; base_shipping_incl_tax)
                {
                    ApplicationArea = All;

                }
                field(firstname; firstname)
                {
                    ApplicationArea = All;

                }
                field(lastname; lastname)
                {
                    ApplicationArea = All;

                }
                field(telephone; telephone)
                {
                    ApplicationArea = All;

                }
                field(postcode; postcode)
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
            action("Get Orders from Magento")
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
                    lMageMgt.GetMagentoOrders();
                end;
            }
        }
    }
}