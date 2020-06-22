public with sharing class DocusignRESTLibrary {
    public static DocusignResponsiveRestAPI.Notification getNotification(String useAccountdefault)
    {
        DocusignResponsiveRestAPI.Notification notif = new DocusignResponsiveRestAPI.Notification();
        notif.useAccountDefaults = useAccountdefault;

        return notif;
    }

    public static DocusignResponsiveRestAPI.TextCustomField getTextCustomField(String value, String name)
    {
        DocusignResponsiveRestAPI.TextCustomField textCustomField = new DocusignResponsiveRestAPI.TextCustomField();
        textCustomField.value = value;
        textCustomField.name = name;

        return textCustomField;
    }

    public static DocusignResponsiveRestAPI.Signer getSigner(String recipientId, String clientUserId, String email, String name, String routingOrder, String[] customfields)
    {
        DocusignResponsiveRestAPI.Signer signer = new DocusignResponsiveRestAPI.Signer();
        signer.recipientId = recipientId;
        signer.clientUserId = clientUserId;
        signer.email = email;
        signer.name = name;
        signer.routingOrder = routingOrder;
        signer.customFields = customfields;

        return signer;
    }


    public static DocusignResponsiveRestAPI.Envelope getEnvelope(String emailSubject, String status, String brandId, String emailBlurb, DocusignResponsiveRestAPI.Notification notification, DocusignResponsiveRestAPI.TextCustomFields customFields)
    {
        DocusignResponsiveRestAPI.Envelope env = new DocusignResponsiveRestAPI.Envelope();
        env.emailSubject = emailSubject;
        env.status = status;
        env.brandId = brandId;
        env.emailBlurb = emailBlurb;
        env.notification = notification;
        env.customFields = customFields;

        return env;
    }

    public static DocusignResponsiveRestAPI.HtmlDefinition getHtmlDefinition(String maxScreenWidth, String source)
    {
        DocusignResponsiveRestAPI.HtmlDefinition htmlDef = new DocusignResponsiveRestAPI.HtmlDefinition();
        htmlDef.maxScreenWidth = maxScreenWidth;
        htmlDef.source = source;

        return htmlDef;
    }

    public static DocusignResponsiveRestAPI.Document getDocument(String documentId, String name, DocusignResponsiveRestAPI.HtmlDefinition htmlDefinition)
    {
        DocusignResponsiveRestAPI.Document doc = new DocusignResponsiveRestAPI.Document();
        doc.documentId = documentId;
        doc.name = name;
        doc.htmlDefinition = htmlDefinition;

        return doc;
    }

    public static Integer documentPos {get; set;}
    public static Integer signerHerePos {get; set;}
    public static Integer dateSignedPos {get; set;}
    public static Integer customFieldPos {get; set;}
    public static Integer signerPos {get; set;}
    public static Integer textCustomFieldPos {get; set;}

    public static DocusignResponsiveRestAPI.Envelope initDocuments(DocusignResponsiveRestAPI.Envelope env, Integer size)
    {
        if(env.documents == null)
            env.documents = new DocusignResponsiveRestAPI.Document[size];
        
        documentPos = 0;

        return env;
    }

    public static DocusignResponsiveRestAPI.Envelope addDocument(DocusignResponsiveRestAPI.Envelope env, DocusignResponsiveRestAPI.Document doc)
    {
        if(env.documents == null)
            initDocuments(env, 10);

        env.documents[documentPos] = doc;
        documentPos++;

        return env;
    }

    public static DocusignResponsiveRestAPI.Recipient addSigner(DocusignResponsiveRestAPI.Recipient rec, DocusignResponsiveRestAPI.Signer signer)
    {
        if(rec.signers == null)
            initSigners(rec, 10);
        
        rec.signers[signerPos] = signer;

        signerPos++;

        return rec;
    }

    public static DocusignResponsiveRestAPI.Recipient initSigners(DocusignResponsiveRestAPI.Recipient rec, Integer size)
    {
        if(rec.signers == null)
            rec.signers = new DocusignResponsiveRestAPI.Signer[size];

        signerPos = 0;

        return rec;
    }

    public static DocusignResponsiveRestAPI.TextCustomFields addTextCustomField(DocusignResponsiveRestAPI.TextCustomFields textCustomFields, DocusignResponsiveRestAPI.TextCustomField textCustomField)
    {
        if(textCustomFields.textCustomFields == null)
            initTextCustomFields(textCustomFields, 10);

        textCustomFields.textCustomFields[textCustomFieldPos] = textCustomField;

        textCustomFieldPos++;

        return textCustomFields;
    }

    public static DocusignResponsiveRestAPI.TextCustomFields initTextCustomfields(DocusignResponsiveRestAPI.TextCustomFields textCustomFields, Integer size)
    {
        if(textCustomFields.textCustomFields == null)
            textCustomFields.textCustomFields = new DocusignResponsiveRestAPI.TextCustomField[size];

        textCustomFieldPos = 0;

        return textCustomFields;
    }

    public static HttpResponse createAndSendEnvelope(DocusignResponsiveRestAPI.Envelope envelope)
    {        
        //Get the docusign Settings
        DocuSignSetting__c dsSetting = ExternalEmbedDocuSignController.getDocuSignSettings();

        String envelopeEndPoint = '/envelopes';

        // Create Http request
        HttpRequest request = new HttpRequest();

        request.setEndpoint(dsSetting.URL__c + dsSetting.AccountId__c + envelopeEndPoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', '*/*');
        request.setHeader('X-DocuSign-Authentication', '{"Username":"'+ dsSetting.Username__c +'","Password":"' + dsSetting.Password__c + '","IntegratorKey": "' + dsSetting.IntegratorKey__c + '"}');

        String requestBody = JSON.serialize(envelope, true);
        
        if(requestBody.length() > 10000)
        {
            system.debug('BodyRequest:' + requestBody.substring(0, 9999));
            system.debug('BodyRequest:' + requestBody.substring(10000));
        }
        

        request.setTimeout(120000);
        request.setBody(requestBody);

        // Send the request
        Http http = new Http();
        HTTPResponse response = http.send(request);

        return response;
    }

    public static HttpResponse getEmbeddedURL(EmbeddedEnvelopeSignerDetails signerDetails, String envelopeId)
    {        
        //Get the docusign Settings
        DocuSignSetting__c dsSetting = ExternalEmbedDocuSignController.getDocuSignSettings();

        String urlEndPoint = '/envelopes/' + envelopeId + '/views/recipient';

        // Create Http request
        HttpRequest request = new HttpRequest();

        request.setEndpoint(dsSetting.URL__c + dsSetting.AccountId__c + urlEndPoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', '*/*');
        request.setHeader('X-DocuSign-Authentication', '{"Username":"'+ dsSetting.Username__c +'","Password":"' + dsSetting.Password__c + '","IntegratorKey": "' + dsSetting.IntegratorKey__c + '"}');

        String requestBody = JSON.serialize(signerDetails, true);

        request.setTimeout(120000);
        request.setBody(requestBody);

        // Send the request
        Http http = new Http();
        HTTPResponse response = http.send(request);

        return response;
    }

    public class EmbeddedEnvelopeSignerDetails
    {
        public String clientUserId {get; set;}
        public String email {get; set;}
        public String userName {get; set;}
        public String returnUrl {get; set;}
        public String AuthenticationMethod {get; set;}
    }

    public abstract class ErrorResponse
    {
        public String errorCode {get; set;}
        public String message {get; set;}
    }

    public class EnvelopeResponse extends ErrorResponse
    {
        
        public String envelopeId {get; set;}
        public String uri {get; set;}
        public String statusDateTime {get; set;}
        public String status {get; set;}
    }

    public class URLResponse extends ErrorResponse
    {
        public String url {get; set;}
    }
}