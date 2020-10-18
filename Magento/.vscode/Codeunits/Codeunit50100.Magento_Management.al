codeunit 50100 "Magento Management"
{
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
                                            lProdID := lItemStaging.product_id;
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

    var
        myInt: Integer;
        gHTTPWebRequest: Codeunit "Http Web Request Mgt.";
        gSOAPMgt: Codeunit 50102;
        gXMLDomMgt: Codeunit "XML DOM Mgt.";
}