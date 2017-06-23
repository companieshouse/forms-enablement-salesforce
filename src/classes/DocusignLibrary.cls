/*
Name:  DocusignLibrary.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Library to use Docusign. (Inspired from useless ANTONIO BRAVO)

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Sylvain Picory&    2016-07-04  Initial development.
*/
public with sharing class DocusignLibrary {

    public static Integer customFieldPos {get; set;}
    public static Integer tabPos {get; set;}
    public static Integer docPos {get; set;}
    public static Integer recPos {get; set;}

    public static String buildAuthString(String username, String password, String integratorKey)
    {
        return '<DocuSignCredentials><Username>'+ username 
                + '</Username><Password>' + password 
                + '</Password><IntegratorKey>' + integratorKey
                + '</IntegratorKey></DocuSignCredentials>';
    }

    public static Map<String, String> buildHTTPHeaders(String auth)
    {
        Map<String, String> httpHeaders = new Map<String, String>();
        httpHeaders.put('X-DocuSign-Authentication', auth);

        return httpHeaders;
    }

    //Return the token for embed signatury if captive is detected
    public static String sendEnvelope(String endPoint, Map<String, String> httpHeaders, DocuSignAPI.Envelope envelope, String baseURL)
    {
        DocuSignAPI.APIServiceSoap soapService = new DocuSignAPI.APIServiceSoap();

        soapService.endpoint_x = endPoint;
        soapService.inputHttpHeaders_x = httpHeaders;

        DocuSignAPI.EnvelopeStatus resultEnv;

        try {
            resultEnv = soapService.CreateAndSendEnvelope(envelope);
        }
        catch ( CalloutException e) {
            System.debug(LoggingLevel.ERROR, 'Error during the Callout to Docusign' + e.getMessage());
            return null;
        }

        DocuSignAPI.Recipient embedRecipient;
        for(DocuSignAPI.Recipient rec : envelope.Recipients.Recipient)
        {
            if(rec != null)
            {
                //We got him, he is the 'presenter'
                if(rec.CaptiveInfo != null)
                {  
                    embedRecipient = rec;
                }
            }
                
        }

        String result = 'SENT';

        if(embedRecipient != null)
        {
            
            result = getEmbedSignatureURL(soapService ,baseURL, resultEnv.EnvelopeID, embedRecipient);
        }

        return result;
    }

    public static DocuSignAPI.Notification getNotification(Boolean useAccountDefault)
    {
        DocuSignAPI.Notification notif = new DocuSignAPI.Notification();
        notif.UseAccountDefaults = useAccountDefault;

        return notif;
    }

    public static DocuSignAPI.Envelope addNotification(DocuSignAPI.Envelope env, DocuSignAPI.Notification notif)
    {
        env.Notification = notif;

        return env;
    }

	public static DocuSignAPI.CustomField getCustomField(String name, String value, String type)
	{
		DocuSignAPI.CustomField custF = new DocuSignAPI.CustomField();
		custF.Name = name;
        custF.Value = value; 
        custF.CustomFieldType = type;

        return custF;
	}	

	public static DocuSignAPI.Envelope getEnvelope(String accountId, String subject, String emailBlurb, String brandId)
	{
        DocuSignAPI.Envelope envelope = new DocuSignAPI.Envelope();

        envelope.Subject = subject;
        envelope.EmailBlurb = emailBlurb;
        envelope.AccountId = accountId;
        envelope.EnvelopeIdStamping = false;
        envelope.BrandId =  brandId;  //'3212b688-d206-4f05-b8bb-67609ac42349';

        return envelope;
	}

    //back in the year where list to do not exist and we need to put a fixed value against this..
    public static DocuSignAPI.Envelope initCustomFields(DocuSignAPI.Envelope envelope, Integer size){
        if(envelope.CustomFields == null)
            envelope.CustomFields = new DocuSignAPI.ArrayOfCustomField();
        if(envelope.CustomFields.CustomField == null)
            envelope.CustomFields.CustomField = new DocuSignAPI.CustomField[size];

        customFieldPos = 0;

        return envelope;
    }

    public static DocuSignAPI.Envelope addCustomFields(DocuSignAPI.Envelope envelope, DocuSignAPI.CustomField custF)
    {
        //Default size of 10...
        if(envelope.CustomFields == null)
            initCustomFields(envelope, 10);

        envelope.CustomFields.CustomField[customFieldPos] = custF;
        customFieldPos++;

        return envelope;
    }

    //back in the year where list to do not exist and we need to put a fixed value against this..
    public static DocuSignAPI.Envelope initTabs(DocuSignAPI.Envelope envelope, Integer size){
        if(envelope.Tabs == null)
            envelope.Tabs = new DocuSignAPI.ArrayOfTab();
        if(envelope.Tabs.Tab == null)
            envelope.Tabs.Tab = new DocuSignAPI.Tab[size];

        tabPos = 0;

        return envelope;
    }

    public static DocuSignAPI.Envelope addTabs(DocuSignAPI.Envelope envelope, DocuSignAPI.Tab custTab)
    {
        //Default size of 1000...
        if(envelope.Tabs == null)
            initTabs(envelope, 1000);

        envelope.Tabs.Tab[tabPos] = custTab;
        tabPos++;

        return envelope;
    }

    //back in the year where list to do not exist and we need to put a fixed value against this..
    public static DocuSignAPI.Envelope initDocs(DocuSignAPI.Envelope envelope, Integer size){
        if(envelope.Documents == null)
            envelope.Documents = new DocuSignAPI.ArrayOfDocument();
        if(envelope.Documents.Document == null)
            envelope.Documents.Document = new DocuSignAPI.Document[size];

        docPos = 0;

        return envelope;
    }

    public static DocuSignAPI.Envelope addDocs(DocuSignAPI.Envelope envelope, DocuSignAPI.Document custDoc)
    {
        //Default size of 10...
        if(envelope.Documents == null)
            initDocs(envelope, 10);

        envelope.Documents.Document[docPos] = custDoc;
        docPos++;

        return envelope;
    }

    //back in the year where list to do not exist and we need to put a fixed value against this..
    public static DocuSignAPI.Envelope initRecipients(DocuSignAPI.Envelope envelope, Integer size){
        if(envelope.Recipients == null)
            envelope.Recipients = new DocuSignAPI.ArrayOfRecipient();
        if(envelope.Recipients.Recipient == null)
            envelope.Recipients.Recipient = new DocuSignAPI.Recipient[size];

        recPos = 0;

        return envelope;
    }

    public static DocuSignAPI.Envelope addRecipients(DocuSignAPI.Envelope envelope, DocuSignAPI.Recipient custRec)
    {
        //Default size of 500...
        if(envelope.Recipients == null)
            initRecipients(envelope, 500);

        envelope.Recipients.Recipient[recPos] = custRec;
        recPos++;

        return envelope;
    }

	public static DocuSignAPI.Document getDocument(Integer id, String byteDocument, String name, String fileExtension ){
		DocuSignAPI.Document document = new DocuSignAPI.Document();
        document.ID = id;
        document.pdfBytes = byteDocument;
        document.Name = name;
        document.FileExtension = fileExtension;

        return document;
	}

    public static DocuSignAPI.Recipient getRecipient(Integer id, String type, Integer routingOrder, String email, String userName, DocuSignAPI.RecipientCaptiveInfo repCapInfo, Boolean requireIDLookup,DocuSignAPI.ArrayOfString1 arrayOfString) {
        
        DocuSignAPI.Recipient recipient = new DocuSignAPI.Recipient();
        recipient.Id = id;
        recipient.Type_x = type;
        recipient.RoutingOrder = routingOrder;
        recipient.Email = email;
        recipient.UserName = username;
        recipient.CaptiveInfo = repCapInfo;
        recipient.RequireIDLookup = requireIDLookup;
        recipient.CustomFields = arrayOfString;
        return recipient;
    }

    public static DocuSignAPI.RecipientCaptiveInfo getCaptiveInfo(String clientUserId){
        DocuSignAPI.RecipientCaptiveInfo capInfo = new DocuSignAPI.RecipientCaptiveInfo();
        capInfo.ClientUserId = clientUserId;

        return capInfo;
    }

    public static DocuSignAPI.Tab getTab(String type, Integer recipientId, Integer documentId, DocuSignAPI.AnchorTab anchor) {
        
        DocuSignAPI.Tab tab = new DocuSignAPI.Tab();
        tab.Type_x = type; 
        tab.RecipientID = recipientId;
        tab.DocumentID = documentId;
        tab.AnchorTabItem = anchor;

        return tab;
    }

    public static DocuSignAPI.AnchorTab getAnchorTab(String anchorTabString)
    {
        DocuSignAPI.AnchorTab anch = new DocuSignAPI.AnchorTab();

        anch.AnchorTabString = anchorTabString;

        return anch;
    }


    /***********************
    *
    *SECTION TO BUILD URL FOR DOCUSIGN CALL FOR EMBED SIGNATURE 
    *
    *
    ***********************/

    public static String getEmbedSignatureURL(DocuSignAPI.APIServiceSoap soapService, String baseURL, String envelopeId, DocuSignAPI.Recipient embedRecipient)
    {
        DocuSignAPI.RequestRecipientTokenAuthenticationAssertion assert = new DocuSignAPI.RequestRecipientTokenAuthenticationAssertion();
        assert.AssertionID = 'Your AssertionID Here';
        assert.AuthenticationInstant = system.now();
        assert.AuthenticationMethod = 'Password';
        assert.SecurityDomain = 'YourApp.com';

        DocuSignAPI.RequestRecipientTokenClientURLs clientURLs = new DocuSignAPI.RequestRecipientTokenClientURLs();
        clientURLs.OnAccessCodeFailed   = baseURL + '&event=OnAccessCodeFailed&envelopeid='   + envelopeId;
        clientURLs.OnCancel             = baseURL + '&event=OnCancel&envelopeid='             + envelopeId;
        clientURLs.OnDecline            = baseURL + '&event=OnDecline&envelopeid='            + envelopeId;
        clientURLs.OnException          = baseURL + '&event=OnException&envelopeid='          + envelopeId;
        clientURLs.OnFaxPending         = baseURL + '&event=OnFaxPending&envelopeid='         + envelopeId;
        clientURLs.OnIdCheckFailed      = baseURL + '&event=OnIdCheckFailed&envelopeid='      + envelopeId;
        clientURLs.OnSessionTimeout     = baseURL + '&event=OnSessionTimeout&envelopeid='     + envelopeId;
        clientURLs.OnSigningComplete    = baseURL + '&event=OnSigningComplete&envelopeid='    + envelopeId;
        clientURLs.OnTTLExpired         = baseURL + '&event=OnTTLExpired&envelopeid='         + envelopeId;
        clientURLs.OnViewingComplete    = baseURL + '&event=OnViewingComplete&envelopeid='    + envelopeId;

        String result = '';
        try {
            result = soapService.RequestRecipientToken(envelopeId, embedRecipient.captiveinfo.ClientUserId, embedRecipient.UserName, embedRecipient.Email, assert, clientURLs);
        }  catch ( CalloutException e) {
            System.debug(LoggingLevel.ERROR, 'Error during the Callout to Docusign to build the embed signature' + e.getMessage());
        }
        
        return result;
    }
}