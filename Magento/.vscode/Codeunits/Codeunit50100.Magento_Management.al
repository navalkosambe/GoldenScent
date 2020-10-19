codeunit 50100 "Magento Management"
{
    EventSubscriberInstance = StaticAutomatic;
    trigger OnRun()
    begin

    end;

    procedure GetItemFromMagento();
    var
        lRecXMLBuffer: record "XML Buffer" temporary;
        lRecXMLBuffer2: record "XML Buffer" temporary;
        lItemStaging: Record "Item Staging Table";
        lTempBlob: Codeunit "Temp Blob";
        lXMLDomMgt: Codeunit "XML DOM Mgt.";
        lHttpClient: HttpClient;
        lhttpContent: HttpContent;
        lHttpHeaders: HttpHeaders;
        lHttpResponse: HttpResponseMessage;
        lRespContent: HttpContent;
        lXMLDoc: XmlDocument;
        lXMLRootNode: XmlNode;

        lHttpClient2: HttpClient;
        lhttpContent2: HttpContent;
        lHttpHeaders2: HttpHeaders;
        lHttpResponse2: HttpResponseMessage;
        lRespContent2: HttpContent;

        lOutstream: OutStream;
        lFile: File;
        lFileContent: Text;
        lContent: Text;
        lInstream: InStream;
        lLoginResult: Text;

        lSessionId: Text;
        lFileContent2: Text;
        lContent2: Text;

        lItemResult: Text;
        lUrl: text;
        lProdID: code[20];
        lFlag: Boolean;
    begin
        //Routine to get Items from Magento<<
        lUrl := 'http://54.247.2.198/api/v2_soap';
        clear(lRecXMLBuffer);
        lRecXMLBuffer.AddGroupElement('soapenv:Envelope');
        lRecXMLBuffer.AddAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        lRecXMLBuffer.AddAttribute('xmlns:xsd', 'http://www.w3.org/2001/XMLSchema');
        lRecXMLBuffer.AddAttribute('xmlns:soapenv', 'http://schemas.xmlsoap.org/soap/envelope/');
        lRecXMLBuffer.AddAttribute('xmlns:urn', 'urn:Magento');

        lRecXMLBuffer.AddElement('soapenv:Header', '');
        lRecXMLBuffer.AddGroupElement('soapenv:Body');
        lRecXMLBuffer.AddGroupElement('urn:login');
        lRecXMLBuffer.AddAttribute('encodingStyle', 'http://schemas.xmlsoap.org/soap/encoding/');
        lRecXMLBuffer.AddElement('username', 'erp_test');
        lRecXMLBuffer.AddElement('apiKey', 'cbDtek9Kg8y2N7u2Ytxu');
        lRecXMLBuffer.GetParent();
        if lRecXMLBuffer.FindSet() then
            lRecXMLBuffer.Save('\\MITLPUN72-L\Integration\login.xml');

        lFile.TextMode(true);
        lFile.Open('\\MITLPUN72-L\Integration\login.xml', TextEncoding::UTF8);
        lFile.CreateInStream(lInstream);
        while not lInstream.EOS do begin
            lInstream.ReadText(lContent);
            lFileContent += lContent;
        end;
        lFile.Close();
        File.Erase('\\MITLPUN72-L\Integration\login.xml');

        lFileContent := DelStr(lFileContent, 1, 38);

        lHttpContent.WriteFrom(lFileContent);
        lHttpContent.GetHeaders(lHttpHeaders);
        lHttpHeaders.Remove('Content-Type');
        lHttpHeaders.Add('Content-Type', 'application/xml;charset=utf-8');
        lHttpHeaders.Add('SOAPAction', 'SoapAction');
        lHttpClient.SetBaseAddress(lUrl);
        if lHttpClient.Post(lUrl, lhttpContent, lHttpResponse) then begin
            lHttpResponse.Content.ReadAs(lLoginResult);
        end;
        if lLoginResult <> '' then begin
            lXMLDomMgt.LoadXMLDocumentFromText(lLoginResult, lXMLDoc);
            lXMLDoc.SelectSingleNode('//*/loginReturn', lXMLRootNode);
            lSessionId := lXMLRootNode.AsXmlElement().InnerText;
            Clear(lRecXMLBuffer2);
            lRecXMLBuffer2.AddGroupElement('soapenv:Envelope');
            lRecXMLBuffer2.AddAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
            lRecXMLBuffer2.AddAttribute('xmlns:xsd', 'http://www.w3.org/2001/XMLSchema');
            lRecXMLBuffer2.AddAttribute('xmlns:soapenv', 'http://schemas.xmlsoap.org/soap/envelope/');
            lRecXMLBuffer2.AddAttribute('xmlns:urn', 'urn:Magento');
            lRecXMLBuffer2.AddAttribute('xmlns:soapenc', 'http://schemas.xmlsoap.org/soap/encoding/');

            lRecXMLBuffer2.AddElement('soapenv:Header', '');
            lRecXMLBuffer2.AddGroupElement('soapenv:Body');
            lRecXMLBuffer2.AddGroupElement('urn:catalogProductList');
            lRecXMLBuffer2.AddAttribute('soapenv:encodingStyle', 'http://schemas.xmlsoap.org/soap/encoding/');
            lRecXMLBuffer2.AddElement('sessionId', lSessionId);
            lRecXMLBuffer2.AddGroupElement('filters');
            lRecXMLBuffer2.AddAttribute('xsi:type', 'urn:filters');
            lRecXMLBuffer2.AddElement('filter', '');
            lRecXMLBuffer2.AddAttribute('xsi:type', 'urn:associativeArray');
            lRecXMLBuffer2.AddAttribute('soapenc:arrayType', 'urn:associativeEntity[]');
            lRecXMLBuffer2.AddElement('complex_filter', '');
            lRecXMLBuffer2.AddAttribute('xsi:type', 'urn:complexFilterArray');
            lRecXMLBuffer2.AddAttribute('soapenc:arrayType', 'urn:complexFilter[]');
            lRecXMLBuffer2.AddElement('storeView', '');
            lRecXMLBuffer2.GetParent();
            if lRecXMLBuffer2.FindSet() then
                lRecXMLBuffer2.Save('\\MITLPUN72-L\Integration\itemRequest.xml');
            lFile.TextMode(true);
            lFile.Open('\\MITLPUN72-L\Integration\itemRequest.xml', TextEncoding::UTF8);
            lFile.CreateInStream(lInstream);
            while not lInstream.EOS do begin
                lInstream.ReadText(lContent2);
                lFileContent2 += lContent2;
            end;
            lFile.Close();
            File.Erase('\\MITLPUN72-L\Integration\itemRequest.xml');

            lFileContent2 := DelStr(lFileContent2, 1, 38);
            lhttpContent2.WriteFrom(lFileContent2);
            lhttpContent2.GetHeaders(lHttpHeaders2);
            lHttpHeaders2.Remove('Content-Type');
            lHttpHeaders2.Add('Content-Type', 'application/xml;charset=utf-8');
            lHttpHeaders2.Add('SOAPAction', 'SoapAction');
            if lHttpClient2.Post(lUrl, lhttpContent2, lHttpResponse2) then begin
                lHttpResponse2.Content.ReadAs(lItemResult);
                if (lItemResult <> '') then begin
                    clear(lRecXMLBuffer);
                    lRecXMLBuffer.LoadFromText(lItemResult);

                    lRecXMLBuffer.SetRange(Type, lRecXMLBuffer.Type::Element);
                    lRecXMLBuffer.SetFilter(Path, '<>%1', '/SOAP-ENV:Envelope/SOAP-ENV:Body/ns1:catalogProductListResponse/storeView/item');
                    lRecXMLBuffer.SetFilter(Value, '<>%1', '');
                    if lRecXMLBuffer.FindSet() then begin
                        repeat
                            case lRecXMLBuffer.Path of
                                '/SOAP-ENV:Envelope/SOAP-ENV:Body/ns1:catalogProductListResponse/storeView/item/product_id':
                                    begin
                                        if lItemStaging.Get(lRecXMLBuffer.Value) then
                                            lFlag := true
                                        else begin
                                            lFlag := false;
                                            lItemStaging.init;
                                            lItemStaging.product_id := lRecXMLBuffer.value;
                                        end;
                                    end;
                                '/SOAP-ENV:Envelope/SOAP-ENV:Body/ns1:catalogProductListResponse/storeView/item/sku':
                                    lItemStaging.sku := lRecXMLBuffer.Value;
                                '/SOAP-ENV:Envelope/SOAP-ENV:Body/ns1:catalogProductListResponse/storeView/item/name':
                                    lItemStaging.Name := lRecXMLBuffer.Value;
                                '/SOAP-ENV:Envelope/SOAP-ENV:Body/ns1:catalogProductListResponse/storeView/item/set':
                                    lItemStaging.set := lRecXMLBuffer.Value;
                                '/SOAP-ENV:Envelope/SOAP-ENV:Body/ns1:catalogProductListResponse/storeView/item/type':
                                    lItemStaging.item_type := lRecXMLBuffer.Value;
                                '/SOAP-ENV:Envelope/SOAP-ENV:Body/ns1:catalogProductListResponse/storeView/item/category_ids/item':
                                    lItemStaging.category_id := lRecXMLBuffer.Value;
                                '/SOAP-ENV:Envelope/SOAP-ENV:Body/ns1:catalogProductListResponse/storeView/item/website_ids/item':
                                    lItemStaging.website_id := lRecXMLBuffer.Value;
                            end;
                            if lFlag then
                                lItemStaging.Modify()
                            else begin
                                lItemStaging.Insert();
                                lFlag := true
                            end;
                        until lRecXMLBuffer.Next() = 0;
                    end;
                end;

            end;
        end;
    end;

    procedure ConvertToNAVItem(var pItemStaging: Record "Item Staging Table");
    var
        lItem: Record Item;
    begin
        with pItemStaging do begin
            lItem.reset;
            lItem.SetRange("Magento Product ID", product_id);
            if not litem.FindFirst() then begin
                lItem.init;
                lItem."No." := product_id;
                lItem.Description := Name;
                lItem."Magento Type" := item_type;
                lItem."Magento SKU" := sku;
                lItem."Magento Category_ID" := category_id;
                lItem."Magento Website_ID" := website_id;
                if lItem.Insert() then
                    "Converted to NAV Item" := true;
                Modify();
            end;
        end;
    end;


    procedure GetMagentoOrders();
    var
        lRecXMLBuffer: record "XML Buffer" temporary;
        lRecXMLBuffer2: record "XML Buffer" temporary;
        lOrderStaging: Record "Magento Staging Header";
        lTempBlob: Codeunit "Temp Blob";
        lXMLDomMgt: Codeunit "XML DOM Mgt.";
        lHttpClient: HttpClient;
        lhttpContent: HttpContent;
        lHttpHeaders: HttpHeaders;
        lHttpResponse: HttpResponseMessage;
        lRespContent: HttpContent;
        lXMLDoc: XmlDocument;
        lXMLRootNode: XmlNode;

        lHttpClient2: HttpClient;
        lhttpContent2: HttpContent;
        lHttpHeaders2: HttpHeaders;
        lHttpResponse2: HttpResponseMessage;
        lRespContent2: HttpContent;

        lOutstream: OutStream;
        lFile: File;
        lFileContent: Text;
        lContent: Text;
        lInstream: InStream;
        lLoginResult: Text;

        lSessionId: Text;
        lFileContent2: Text;
        lContent2: Text;

        lOrderResult: Text;
        lUrl: text;
        lProdID: code[20];
        lFlag: Boolean;
    begin
        //Routine to get Orders from Magento<<
        lUrl := 'http://54.247.2.198/api/v2_soap';
        clear(lRecXMLBuffer);
        lRecXMLBuffer.AddGroupElement('soapenv:Envelope');
        lRecXMLBuffer.AddAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        lRecXMLBuffer.AddAttribute('xmlns:xsd', 'http://www.w3.org/2001/XMLSchema');
        lRecXMLBuffer.AddAttribute('xmlns:soapenv', 'http://schemas.xmlsoap.org/soap/envelope/');
        lRecXMLBuffer.AddAttribute('xmlns:urn', 'urn:Magento');

        lRecXMLBuffer.AddElement('soapenv:Header', '');
        lRecXMLBuffer.AddGroupElement('soapenv:Body');
        lRecXMLBuffer.AddGroupElement('urn:login');
        lRecXMLBuffer.AddAttribute('encodingStyle', 'http://schemas.xmlsoap.org/soap/encoding/');
        lRecXMLBuffer.AddElement('username', 'erp_test');
        lRecXMLBuffer.AddElement('apiKey', 'cbDtek9Kg8y2N7u2Ytxu');
        lRecXMLBuffer.GetParent();
        if lRecXMLBuffer.FindSet() then
            lRecXMLBuffer.Save('\\MITLPUN72-L\Integration\login.xml');

        lFile.TextMode(true);
        lFile.Open('\\MITLPUN72-L\Integration\login.xml', TextEncoding::UTF8);
        lFile.CreateInStream(lInstream);
        while not lInstream.EOS do begin
            lInstream.ReadText(lContent);
            lFileContent += lContent;
        end;
        lFile.Close();
        File.Erase('\\MITLPUN72-L\Integration\login.xml');

        lFileContent := DelStr(lFileContent, 1, 38);

        lHttpContent.WriteFrom(lFileContent);
        lHttpContent.GetHeaders(lHttpHeaders);
        lHttpHeaders.Remove('Content-Type');
        lHttpHeaders.Add('Content-Type', 'application/xml;charset=utf-8');
        lHttpHeaders.Add('SOAPAction', 'SoapAction');
        lHttpClient.SetBaseAddress(lUrl);
        if lHttpClient.Post(lUrl, lhttpContent, lHttpResponse) then begin
            lHttpResponse.Content.ReadAs(lLoginResult);
        end;
        if lLoginResult <> '' then begin
            lXMLDomMgt.LoadXMLDocumentFromText(lLoginResult, lXMLDoc);
            lXMLDoc.SelectSingleNode('//*/loginReturn', lXMLRootNode);
            lSessionId := lXMLRootNode.AsXmlElement().InnerText;
            Clear(lRecXMLBuffer2);
            lRecXMLBuffer2.AddGroupElement('soapenv:Envelope');
            lRecXMLBuffer2.AddAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');
            lRecXMLBuffer2.AddAttribute('xmlns:xsd', 'http://www.w3.org/2001/XMLSchema');
            lRecXMLBuffer2.AddAttribute('xmlns:soapenv', 'http://schemas.xmlsoap.org/soap/envelope/');
            lRecXMLBuffer2.AddAttribute('xmlns:urn', 'urn:Magento');
            lRecXMLBuffer2.AddAttribute('xmlns:soapenc', 'http://schemas.xmlsoap.org/soap/encoding/');
            lRecXMLBuffer2.AddElement('soapenv:Header', '');
            lRecXMLBuffer2.AddGroupElement('soapenv:Body');
            lRecXMLBuffer2.AddGroupElement('urn:salesOrderList');
            lRecXMLBuffer2.AddAttribute('soapenv:encodingStyle', 'http://schemas.xmlsoap.org/soap/encoding/');
            lRecXMLBuffer2.AddElement('sessionId', lSessionId);
            lRecXMLBuffer2.AddGroupElement('filters');
            lRecXMLBuffer2.AddAttribute('xsi:type', 'urn:filters');
            lRecXMLBuffer2.AddElement('filter', '');
            lRecXMLBuffer2.AddAttribute('xsi:type', 'urn:associativeArray');
            lRecXMLBuffer2.AddAttribute('soapenc:arrayType', 'urn:associativeEntity[]');
            lRecXMLBuffer2.AddElement('complex_filter', '');
            lRecXMLBuffer2.AddAttribute('xsi:type', 'urn:complexFilterArray');
            lRecXMLBuffer2.AddAttribute('soapenc:arrayType', 'urn:complexFilter[]');
            if lRecXMLBuffer2.FindSet() then
                lRecXMLBuffer2.Save('\\MITLPUN72-L\Integration\ordersRequest.xml');

            lFile.TextMode(true);
            lFile.Open('\\MITLPUN72-L\Integration\ordersRequest.xml', TextEncoding::UTF8);
            lFile.CreateInStream(lInstream);
            while not lInstream.EOS do begin
                lInstream.ReadText(lContent2);
                lFileContent2 += lContent2;
            end;
            lFile.Close();
            File.Erase('\\MITLPUN72-L\Integration\ordersRequest.xml');
            lFileContent2 := DelStr(lFileContent2, 1, 38);
            lhttpContent2.WriteFrom(lFileContent2);
            lhttpContent2.GetHeaders(lHttpHeaders2);
            lHttpHeaders2.Remove('Content-Type');
            lHttpHeaders2.Add('Content-Type', 'application/xml;charset=utf-8');
            lHttpHeaders2.Add('SOAPAction', 'SoapAction');
            if lHttpClient2.Post(lUrl, lhttpContent2, lHttpResponse2) then begin
                lHttpResponse2.Content.ReadAs(lOrderResult);

                //Error(lOrderResult);
                if (lOrderResult <> '') then begin
                    clear(lRecXMLBuffer);
                    lRecXMLBuffer.LoadFromText(lOrderResult);
                    //Page.RunModal(50110, lRecXMLBuffer);
                    lRecXMLBuffer.SetRange(Type, lRecXMLBuffer.Type::Element);
                    lRecXMLBuffer.SetFilter(Path, '<>%1', '/SOAP-ENV:Envelope/SOAP-ENV:Body/ns1:salesOrderListResponse/result/item');
                    lRecXMLBuffer.SetFilter(Value, '<>%1', '');
                    if lRecXMLBuffer.FindSet() then begin
                        repeat
                            case lRecXMLBuffer.Name of
                                'increment_id':
                                    begin
                                        if lOrderStaging.Get(lRecXMLBuffer.Value) then
                                            lFlag := true
                                        else begin
                                            lFlag := false;
                                            lOrderStaging.init;
                                            lOrderStaging.increment_id := lRecXMLBuffer.value;
                                        end;
                                    end;
                                'store_id':
                                    lOrderStaging.store_id := lRecXMLBuffer.Value;
                                'created_at':
                                    lOrderStaging.created_at := lRecXMLBuffer.Value;
                                'updated_at':
                                    lOrderStaging.updated_at := lRecXMLBuffer.Value;
                                'tax_amount':
                                    lOrderStaging.tax_amount := lRecXMLBuffer.Value;
                                'shipping_amount':
                                    lOrderStaging.shipping_amount := lRecXMLBuffer.Value;
                                'discount_amount':
                                    lOrderStaging.discount_amount := lRecXMLBuffer.Value;
                                'subtotal':
                                    lOrderStaging.subtotal := lRecXMLBuffer.Value;
                                'grand_total':
                                    lOrderStaging.grand_total := lRecXMLBuffer.Value;
                                'total_qty_ordered':
                                    lOrderStaging.total_qty_ordered := lRecXMLBuffer.Value;
                                'base_tax_amount':
                                    lOrderStaging.base_tax_amount := lRecXMLBuffer.Value;
                                'base_shipping_amount':
                                    lOrderStaging.base_shipping_amount := lRecXMLBuffer.Value;
                                'base_discount_amount':
                                    lOrderStaging.base_discount_amount := lRecXMLBuffer.Value;
                                'base_subtotal':
                                    lOrderStaging.base_subtotal := lRecXMLBuffer.Value;
                                'base_grand_total':
                                    lOrderStaging.base_grand_total := lRecXMLBuffer.Value;
                                'billing_address_id':
                                    lOrderStaging.billing_address_id := lRecXMLBuffer.Value;
                                'billing_firstname':
                                    lOrderStaging.billing_firstname := lRecXMLBuffer.Value;
                                'billing_lastname':
                                    lOrderStaging.billing_lastname := lRecXMLBuffer.Value;
                                'shipping_address_id':
                                    lOrderStaging.shipping_address_id := lRecXMLBuffer.Value;
                                'shipping_firstname':
                                    lOrderStaging.shipping_firstname := lRecXMLBuffer.Value;
                                'shipping_lastname':
                                    lOrderStaging.shipping_lastname := lRecXMLBuffer.Value;
                                'billing_name':
                                    lOrderStaging.billing_name := lRecXMLBuffer.Value;
                                'shipping_name':
                                    lOrderStaging.shipping_name := lRecXMLBuffer.Value;
                                'store_to_base_rate':
                                    lOrderStaging.store_to_base_rate := lRecXMLBuffer.Value;
                                'store_to_order_rate':
                                    lOrderStaging.store_to_order_rate := lRecXMLBuffer.Value;
                                'base_to_global_rate':
                                    lOrderStaging.base_to_global_rate := lRecXMLBuffer.Value;
                                'base_to_order_rate':
                                    lOrderStaging.base_to_order_rate := lRecXMLBuffer.Value;
                                'weight':
                                    lOrderStaging.weight := lRecXMLBuffer.Value;
                                'store_name':
                                    lOrderStaging.store_name := lRecXMLBuffer.Value;
                                'remote_ip':
                                    lOrderStaging.remote_ip := lRecXMLBuffer.Value;
                                'status':
                                    lOrderStaging.status := lRecXMLBuffer.Value;
                                'state':
                                    lOrderStaging.state := lRecXMLBuffer.Value;
                                'global_currency_code':
                                    lOrderStaging.global_currency_code := lRecXMLBuffer.Value;
                                'base_currency_code':
                                    lOrderStaging.base_currency_code := lRecXMLBuffer.Value;
                                'store_currency_code':
                                    lOrderStaging.store_currency_code := lRecXMLBuffer.Value;
                                'order_currency_code':
                                    lOrderStaging.order_currency_code := lRecXMLBuffer.Value;
                                'shipping_method':
                                    lOrderStaging.shipping_method := lRecXMLBuffer.Value;
                                'shipping_description':
                                    lOrderStaging.shipping_description := lRecXMLBuffer.Value;
                                'customer_email':
                                    lOrderStaging.customer_email := lRecXMLBuffer.Value;
                                'customer_firstname':
                                    lOrderStaging.customer_firstname := lRecXMLBuffer.Value;
                                'customer_lastname':
                                    lOrderStaging.customer_lastname := lRecXMLBuffer.Value;
                                'quote_id':
                                    lOrderStaging.quote_id := lRecXMLBuffer.Value;
                                'is_virtual':
                                    lOrderStaging.is_virtual := lRecXMLBuffer.Value;
                                'customer_group_id':
                                    lOrderStaging.customer_group_id := lRecXMLBuffer.Value;
                                'customer_note_notify':
                                    lOrderStaging.customer_note_notify := lRecXMLBuffer.Value;
                                'customer_is_guest':
                                    lOrderStaging.customer_is_guest := lRecXMLBuffer.Value;
                                'email_sent':
                                    lOrderStaging.email_sent := lRecXMLBuffer.Value;
                                'order_id':
                                    lOrderStaging.order_id := lRecXMLBuffer.Value;

                                'protect_code':
                                    lOrderStaging.protect_code := lRecXMLBuffer.Value;
                                'base_shipping_tax_amount':
                                    lOrderStaging.base_shipping_tax_amount := lRecXMLBuffer.Value;
                                'shipping_tax_amount':
                                    lOrderStaging.shipping_tax_amount := lRecXMLBuffer.Value;
                                'paypal_ipn_customer_notified':
                                    lOrderStaging.paypal_ipn_customer_notified := lRecXMLBuffer.Value;
                                'base_shipping_discount_amount':
                                    lOrderStaging.base_shipping_discount_amount := lRecXMLBuffer.Value;
                                'base_subtotal_incl_tax':
                                    lOrderStaging.base_subtotal_incl_tax := lRecXMLBuffer.Value;

                                'shipping_discount_amount':
                                    lOrderStaging.shipping_discount_amount := lRecXMLBuffer.Value;

                                'subtotal_incl_tax':
                                    lOrderStaging.subtotal_incl_tax := lRecXMLBuffer.Value;
                                'total_item_count':
                                    lOrderStaging.total_item_count := lRecXMLBuffer.Value;
                                'hidden_tax_amount':
                                    lOrderStaging.hidden_tax_amount := lRecXMLBuffer.Value;
                                'base_hidden_tax_amount':
                                    lOrderStaging.base_hidden_tax_amount := lRecXMLBuffer.Value;
                                'shipping_hidden_tax_amount':
                                    lOrderStaging.shipping_hidden_tax_amount := lRecXMLBuffer.Value;
                                'base_shipping_hidden_tax_amount':
                                    lOrderStaging.base_ship_hidden_tax_amount := lRecXMLBuffer.Value;
                                'shipping_incl_tax':
                                    lOrderStaging.shipping_incl_tax := lRecXMLBuffer.Value;
                                'base_shipping_incl_tax':
                                    lOrderStaging.base_shipping_incl_tax := lRecXMLBuffer.Value;
                                'base_customer_balance_amount':
                                    lOrderStaging.base_customer_balance_amount := lRecXMLBuffer.Value;
                                'customer_balance_amount':
                                    lOrderStaging.customer_balance_amount := lRecXMLBuffer.Value;
                                'gift_cards':
                                    lOrderStaging.gift_cards := lRecXMLBuffer.Value;
                                'base_gift_cards_amount':
                                    lOrderStaging.base_gift_cards_amount := lRecXMLBuffer.Value;
                                'gift_cards_amount':
                                    lOrderStaging.gift_cards_amount := lRecXMLBuffer.Value;
                                'reward_points_balance':
                                    lOrderStaging.reward_points_balance := lRecXMLBuffer.Value;
                                'base_reward_currency_amount':
                                    lOrderStaging.base_reward_currency_amount := lRecXMLBuffer.Value;
                                'reward_currency_amount':
                                    lOrderStaging.reward_currency_amount := lRecXMLBuffer.Value;
                                'base_discount_canceled':
                                    lOrderStaging.base_discount_canceled := lRecXMLBuffer.Value;
                                'base_shipping_canceled':
                                    lOrderStaging.base_shipping_canceled := lRecXMLBuffer.Value;

                                'base_subtotal_canceled':
                                    lOrderStaging.base_subtotal_canceled := lRecXMLBuffer.Value;
                                'base_tax_canceled':
                                    lOrderStaging.base_tax_canceled := lRecXMLBuffer.Value;
                                'discount_canceled':
                                    lOrderStaging.discount_canceled := lRecXMLBuffer.Value;
                                'shipping_canceled':
                                    lOrderStaging.shipping_canceled := lRecXMLBuffer.Value;

                                'subtotal_canceled':
                                    lOrderStaging.subtotal_canceled := lRecXMLBuffer.Value;
                                'tax_canceled':
                                    lOrderStaging.tax_canceled := lRecXMLBuffer.Value;
                                'edit_increment':
                                    lOrderStaging.edit_increment := lRecXMLBuffer.Value;
                                'base_total_due':
                                    lOrderStaging.base_total_due := lRecXMLBuffer.Value;
                                'total_due':
                                    lOrderStaging.total_due := lRecXMLBuffer.Value;
                                'original_increment_id':
                                    lOrderStaging.original_increment_id := lRecXMLBuffer.Value;
                                'relation_parent_id':
                                    lOrderStaging.relation_parent_id := lRecXMLBuffer.Value;
                                'relation_parent_real_id':
                                    lOrderStaging.relation_parent_real_id := lRecXMLBuffer.Value;
                                'firstname':
                                    lOrderStaging.firstname := lRecXMLBuffer.Value;
                                'lastname':
                                    lOrderStaging.lastname := lRecXMLBuffer.Value;
                                'telephone':
                                    lOrderStaging.telephone := lRecXMLBuffer.Value;
                                'postcode':
                                    lOrderStaging.postcode := lRecXMLBuffer.Value;

                            end;
                            if lFlag then
                                lOrderStaging.Modify()
                            else begin
                                lOrderStaging.Insert();
                                lFlag := true
                            end;
                        until lRecXMLBuffer.Next() = 0;
                    end;
                end;
            end;
        end;
    end;

    var
        myInt: Integer;
        gHTTPWebRequest: Codeunit "Http Web Request Mgt.";
        gSOAPMgt: Codeunit 50102;
        gXMLDomMgt: Codeunit "XML DOM Mgt.";
}