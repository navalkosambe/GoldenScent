table 50103 "Magento Staging Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; increment_id; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; store_id; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(3; created_at; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(4; updated_at; Text[20])
        {
            DataClassification = ToBeClassified;

        }

        field(5; customer_id; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(6; tax_amount; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(7; shipping_amount; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(8; discount_amount; Text[20])
        {
            DataClassification = ToBeClassified;

        }

        field(9; subtotal; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(10; grand_total; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(11; total_qty_ordered; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(12; base_tax_amount; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(13; base_shipping_amount; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(14; base_discount_amount; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(15; base_subtotal; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(16; base_grand_total; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(17; billing_address_id; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(18; shipping_address_id; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(19; store_to_base_rate; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(20; store_to_order_rate; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(21; base_to_global_rate; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(22; base_to_order_rate; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(23; weight; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(24; store_name; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(25; status; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(26; state; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(27; global_currency_code; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(28; base_currency_code; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(29; store_currency_code; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(30; order_currency_code; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(31; shipping_method; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(32; shipping_description; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        /*
        field(33;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }
        field(34;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }
        field(35;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }
        field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }
        field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }
        field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }
        field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }field(1;increment_id; Text[20])
        {
            DataClassification = ToBeClassified;
            
        }*/
    }

    keys
    {
        key(PK; increment_id)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}