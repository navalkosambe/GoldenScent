table 50102 "Magento Staging Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; increment_id; code[20])
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
        field(5; tax_amount; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(6; shipping_amount; text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(7; discount_amount; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(8; subtotal; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(9; grand_total; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(10; total_qty_ordered; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(11; base_tax_amount; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(12; base_shipping_amount; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(13; base_discount_amount; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(14; base_subtotal; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(15; base_grand_total; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(16; billing_address_id; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(17; billing_firstname; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(18; billing_lastname; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(19; shipping_address_id; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(20; shipping_firstname; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(21; shipping_lastname; Text[50])
        {
            DataClassification = ToBeClassified;

        }
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