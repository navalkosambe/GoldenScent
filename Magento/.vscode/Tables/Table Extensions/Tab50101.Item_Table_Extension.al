tableextension 50101 "Item Extension" extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Magento Product ID"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Magento Product Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Magento SKU"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Magento Type"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Magento Category_ID"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Magento Website_ID"; code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}