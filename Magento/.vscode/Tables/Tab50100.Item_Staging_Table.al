table 50100 "Item Staging Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "product_id"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "sku"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(4; item_type; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "category_id"; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "website_id"; Text[250])
        {
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(PK; "Entry No.")
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