table 50100 "Item Staging Table"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "product_id"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "sku"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(3; item_type; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "category_id"; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "website_id"; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(6; Name; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(7; set; Text[10])
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Converted to NAV Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }

    keys
    {
        key(PK; product_id)
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
        if Rec."Converted to NAV Item" then
            Error('The item has been converted to NAV Item, It cannot be deleted.');
    end;

    trigger OnRename()
    begin

    end;

}