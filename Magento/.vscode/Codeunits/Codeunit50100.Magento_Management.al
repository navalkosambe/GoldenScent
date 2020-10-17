codeunit 50100 "Magento Management"
{
    trigger OnRun()
    begin

    end;

    procedure GetItemFromMagento();
    var
        lRecXMLBuffer: record "XML Buffer" temporary;
        lTempBlob: Codeunit "Temp Blob";

        lOutstream: OutStream;
        lFile: File;
        lFileContent: Text;
        lInstream: InStream;
        lLoginResult: Text;

        lXmlDocument: XmlDocument;
        lEnvolopeXmlNode: XmlNode;
        lHeaderXmlNode: XmlNode;
        lBodyXmlNode: XmlNode;
        lTempXmlNode: XmlNode;
        lXMLText: Text;

        SoapNS11: Label 'http://www.w3.org/2001/XMLSchema-instance', Locked = true;
        SoapNS12: Label 'http://www.w3.org/2001/XMLSchema', Locked = true;
        XsiNS: Label 'http://schemas.xmlsoap.org/soap/envelope/', Locked = true;
        XsdNS: Label 'urn:Magento', Locked = true;
    begin
        /*
        clear(lRecXMLBuffer);
        lRecXMLBuffer.AddGroupElement('soapenv:Envelope');
        lRecXMLBuffer.AddNamespace('xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        lRecXMLBuffer.AddNamespace('xsd', 'http://www.w3.org/2001/XMLSchema');
        lRecXMLBuffer.AddNamespace('soapenv', 'http://schemas.xmlsoap.org/soap/envelope/');
        lRecXMLBuffer.AddNamespace('urn', 'urn:Magento');
        lRecXMLBuffer.AddElement('soapenv:Header', '');
        lRecXMLBuffer.AddGroupElement('soapenv:Body');
        lRecXMLBuffer.AddGroupElement('urn:login');
        //lRecXMLBuffer.AddNamespace('encodingStyle', 'http://schemas.xmlsoap.org/soap/encoding/');
        lRecXMLBuffer.AddElement('username', 'erp_test');
        lRecXMLBuffer.AddElement('apiKey', 'cbDtek9Kg8y2N7u2Ytxu');
        lRecXMLBuffer.GetParent();
        //lRecXMLBuffer.Save('\\MITLPUN72-L\Integration\login.txt');
        lRecXMLBuffer.*/

        gSOAPMgt.CreateSoapDocument(lXmlDocument, 2, lEnvolopeXmlNode, lHeaderXmlNode, lBodyXmlNode);
        //Add Additional Nodes to the Soap Headers if Needed- Below is the Sample
        //gXMLDomMgt.AddElement(lHeaderXmlNode, 'SampleHeaders', 'Test', SoapNS12, lTempXmlNode);

        //You can add/append an existing Node to the Soap Body using XmlNode.AsXmlElement.InnerXml - Below is the Sample
        lXmlDocument.WriteTo(lXMLText);
        Message(lXMLText);

        /*lFile.Open('D:\Integration\login.xml');
        lFile.CreateInStream(lInstream);
        lInstream.ReadText(lFileContent);
        lFile.Close();
        Message(lFileContent);
        Clear(gHTTPWebRequest);
        gHTTPWebRequest.Initialize('http://54.247.2.198/api/v2_soap');
        gHTTPWebRequest.AddBodyAsText(lFileContent);
        gHTTPWebRequest.SetMethod('POST');
        gHTTPWebRequest.SetContentType('text/xml');
        gHTTPWebRequest.SetReturnType('text/xml');
        if gHTTPWebRequest.GetResponseStream(lInstream) then begin
            lInstream.ReadText(lLoginResult);
            Message(lLoginResult);
        end;
*/


    end;

    var
        myInt: Integer;
        gHTTPWebRequest: Codeunit "Http Web Request Mgt.";
        gSOAPMgt: Codeunit 50102;
        gXMLDomMgt: Codeunit "XML DOM Mgt.";
    //gText50000 : TextConst ""
}