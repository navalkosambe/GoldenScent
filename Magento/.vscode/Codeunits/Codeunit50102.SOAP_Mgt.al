codeunit 50102 "SOAP Document"
{
    var
        XMLDomMgt: Codeunit "XML DOM Mgt.";
        SoapNS11: Label 'http://www.w3.org/2001/XMLSchema-instance', Locked = true;
        SoapNS12: Label 'http://www.w3.org/2001/XMLSchema', Locked = true;
        XsiNS: Label 'http://schemas.xmlsoap.org/soap/envelope/', Locked = true;
        XsdNS: Label 'urn:Magento', Locked = true;
        soapenv: Label 'soapenv:Magento', Locked = true;

    //Use this function to Create a Soap Document with Soap Version 1.1 & 1.2. This function will return the XML Document along with the reference of the created nodes like Envelope, Header & Body.
    procedure CreateSoapDocument(var pXmlDocument: XmlDocument; pVersion: Option "1.1","1.2"; var pEnvelopeXmlNode: XmlNode; var pHeaderXmlNode: XmlNode; var pBodyXmlNode: XmlNode);
    begin
        CreateEnvelope(pXmlDocument, pEnvelopeXmlNode, pVersion);
        CreateHeader(pEnvelopeXmlNode, pHeaderXmlNode, pVersion);
        CreateBody(pEnvelopeXmlNode, pBodyXmlNode, pVersion);
    end;

    //Use this function to Create a Soap Document with Soap Version 1.1 & 1.2. This function will return the XML Document along with the reference of the created Body node.
    procedure CreateSoapDocumentBody(var pXmlDocument: XmlDocument; pVersion: Option "1.1","1.2"; var pBodyXmlNode: XmlNode);
    var
        lEnvelopeXmlNode: XmlNode;
        lHeaderXmlNode: XmlNode;
    begin
        CreateSoapDocument(pXmlDocument, pVersion, lEnvelopeXmlNode, lHeaderXmlNode, pBodyXmlNode);
    end;

    //This function will create a Soap Envelope
    procedure CreateEnvelope(var pXmlDocument: XmlDocument; var pEnvelopeXmlNode: XmlNode; pVersion: Option "1.1","1.2");
    begin
        pXmlDocument := XmlDocument.Create;
        With XMLDomMgt do begin
            AddDeclaration(pXmlDocument, '1.0', 'UTF-8', 'no');
            if pVersion = pVersion::"1.1" then
                AddRootElementWithPrefix(pXmlDocument, 'Envelope', 'soapenv', 'SoapNS11', pEnvelopeXmlNode)

            else
                AddRootElementWithPrefix(pXmlDocument, 'Envelope', 'soapenv', 'SoapNS11', pEnvelopeXmlNode);
            AddPrefix(pEnvelopeXmlNode, 'xsi', 'http://www.w3.org/2001/XMLSchema-instance');
            AddPrefix(pEnvelopeXmlNode, 'xsd', 'http://www.w3.org/2001/XMLSchema');
            //AddPrefix(pEnvelopeXmlNode, 'soapenv', 'http://schemas.xmlsoap.org/soap/envelope/');
            AddPrefix(pEnvelopeXmlNode, 'urn', 'urn:Magento');


        end;
    end;

    //This function will create a Soap Header
    procedure CreateHeader(var pEnvelopeXmlNode: XmlNode; var pHeaderXmlNode: XmlNode; pVersion: Option "1.1","1.2");
    begin
        if pVersion = pVersion::"1.1" then
            XMLDOMMgt.AddElement(pEnvelopeXmlNode, 'Header', '', SoapNS11, pHeaderXmlNode)
        else
            XMLDOMMgt.AddElement(pEnvelopeXmlNode, 'Header', '', XsiNS, pHeaderXmlNode);
    end;

    //This function will create a Soap Body
    procedure CreateBody(var pSoapEnvelope: XmlNode; var pSoapBody: XmlNode; pVersion: Option "1.1","1.2");
    begin
        if pVersion = pVersion::"1.1" then begin
            XMLDOMMgt.AddGroupNode(pSoapEnvelope, 'Body');
            XMLDomMgt.AddPrefix(pSoapEnvelope, '', 'soapenv');
            XMLDOMMgt.AddGroupNode(pSoapEnvelope, 'login');
            XMLDOMMgt.AddElement(pSoapEnvelope, 'username', 'erp_test', '', pSoapBody);
            XMLDOMMgt.AddElement(pSoapEnvelope, 'apiKey', 'cbDtek9Kg8y2N7u2Ytxu', '', pSoapBody);
        end else begin
            XMLDOMMgt.AddGroupNode(pSoapEnvelope, 'Body');
            //XMLDomMgt.AddPrefix(pSoapEnvelope, '', 'soapenv');
            XMLDOMMgt.AddGroupNode(pSoapEnvelope, 'login');
            XMLDOMMgt.AddElement(pSoapEnvelope, 'username', 'erp_test', '', pSoapBody);
            XMLDOMMgt.AddElement(pSoapEnvelope, 'apiKey', 'cbDtek9Kg8y2N7u2Ytxu', '', pSoapBody);
        end;
    end;

}