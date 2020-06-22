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
    public static String sendEnvelope(String endPoint, Map<String, String> httpHeaders, DocusignResponsiveAPI.Envelope envelope, String baseURL)
    {
        DocusignResponsiveAPI.APIServiceSoap soapService = new DocusignResponsiveAPI.APIServiceSoap();

        soapService.endpoint_x = endPoint;
        soapService.inputHttpHeaders_x = httpHeaders;

        DocusignResponsiveAPI.EnvelopeStatus resultEnv;

        system.debug(LoggingLevel.ERROR, 'This is the envelope:' + envelope);

        try {
            resultEnv = soapService.CreateAndSendEnvelope(envelope);
        }
        catch ( CalloutException e) {
            System.debug(LoggingLevel.ERROR, 'Error during the Callout to Docusign' + e.getMessage());
            return null;
        }

        DocusignResponsiveAPI.Recipient embedRecipient;
        for(DocusignResponsiveAPI.Recipient rec : envelope.Recipients.Recipient)
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

    public static DocusignResponsiveAPI.Notification getNotification(Boolean useAccountDefault)
    {
        DocusignResponsiveAPI.Notification notif = new DocusignResponsiveAPI.Notification();
        notif.UseAccountDefaults = useAccountDefault;

        return notif;
    }

    public static DocusignResponsiveAPI.Envelope addNotification(DocusignResponsiveAPI.Envelope env, DocusignResponsiveAPI.Notification notif)
    {
        env.Notification = notif;

        return env;
    }

	public static DocusignResponsiveAPI.CustomField getCustomField(String name, String value, String type)
	{
		DocusignResponsiveAPI.CustomField custF = new DocusignResponsiveAPI.CustomField();
		custF.Name = name;
        custF.Value = value; 
        custF.CustomFieldType = type;

        return custF;
	}	

    public static DocusignResponsiveAPI.EnvelopeInformation getEnvelopeInfo(String accountId, String subject, String emailBlurb, String brandId)
    {
        DocusignResponsiveAPI.EnvelopeInformation envelopeInfo = new DocusignResponsiveAPI.EnvelopeInformation();

        envelopeInfo.AccountId = accountId;
        envelopeInfo.Subject = subject;
        envelopeInfo.EmailBlurb = emailBlurb;
        envelopeInfo.BrandId = brandId;

        return envelopeInfo;
    }

	public static DocusignResponsiveAPI.Envelope getEnvelope(String accountId, String subject, String emailBlurb, String brandId)
	{
        DocusignResponsiveAPI.Envelope envelope = new DocusignResponsiveAPI.Envelope();

        envelope.Subject = subject;
        envelope.EmailBlurb = emailBlurb;
        envelope.AccountId = accountId;
        envelope.EnvelopeIdStamping = false;
        envelope.BrandId =  brandId;  //'3212b688-d206-4f05-b8bb-67609ac42349';

        return envelope;
	}

    //back in the year where list to do not exist and we need to put a fixed value against this..
    public static DocusignResponsiveAPI.Envelope initCustomFields(DocusignResponsiveAPI.Envelope envelope, Integer size){
        if(envelope.CustomFields == null)
            envelope.CustomFields = new DocusignResponsiveAPI.ArrayOfCustomField();
        if(envelope.CustomFields.CustomField == null)
            envelope.CustomFields.CustomField = new DocusignResponsiveAPI.CustomField[size];

        customFieldPos = 0;

        return envelope;
    }

    public static DocusignResponsiveAPI.Envelope addCustomFields(DocusignResponsiveAPI.Envelope envelope, DocusignResponsiveAPI.CustomField custF)
    {
        //Default size of 10...
        if(envelope.CustomFields == null)
            initCustomFields(envelope, 10);

        envelope.CustomFields.CustomField[customFieldPos] = custF;
        customFieldPos++;

        return envelope;
    }

    //back in the year where list to do not exist and we need to put a fixed value against this..
    public static DocusignResponsiveAPI.Envelope initTabs(DocusignResponsiveAPI.Envelope envelope, Integer size){
        if(envelope.Tabs == null)
            envelope.Tabs = new DocusignResponsiveAPI.ArrayOfTab();
        if(envelope.Tabs.Tab == null)
            envelope.Tabs.Tab = new DocusignResponsiveAPI.Tab[size];

        tabPos = 0;

        return envelope;
    }

    public static DocusignResponsiveAPI.Envelope addTabs(DocusignResponsiveAPI.Envelope envelope, DocusignResponsiveAPI.Tab custTab)
    {
        //Default size of 1000...
        if(envelope.Tabs == null)
            initTabs(envelope, 1000);

        envelope.Tabs.Tab[tabPos] = custTab;
        tabPos++;

        return envelope;
    }

    //back in the year where list to do not exist and we need to put a fixed value against this..
    public static DocusignResponsiveAPI.Envelope initDocs(DocusignResponsiveAPI.Envelope envelope, Integer size){
        if(envelope.Documents == null)
            envelope.Documents = new DocusignResponsiveAPI.ArrayOfDocument();
        if(envelope.Documents.Document == null)
            envelope.Documents.Document = new DocusignResponsiveAPI.Document[size];

        docPos = 0;

        return envelope;
    }

    public static DocusignResponsiveAPI.Envelope addDocs(DocusignResponsiveAPI.Envelope envelope, DocusignResponsiveAPI.Document custDoc)
    {
        //Default size of 10...
        if(envelope.Documents == null)
            initDocs(envelope, 10);

        envelope.Documents.Document[docPos] = custDoc;
        docPos++;

        return envelope;
    }

    //back in the year where list to do not exist and we need to put a fixed value against this..
    public static DocusignResponsiveAPI.Envelope initRecipients(DocusignResponsiveAPI.Envelope envelope, Integer size){
        if(envelope.Recipients == null)
            envelope.Recipients = new DocusignResponsiveAPI.ArrayOfRecipient();
        if(envelope.Recipients.Recipient == null)
            envelope.Recipients.Recipient = new DocusignResponsiveAPI.Recipient[size];

        recPos = 0;

        return envelope;
    }

    public static DocusignResponsiveAPI.Envelope addRecipients(DocusignResponsiveAPI.Envelope envelope, DocusignResponsiveAPI.Recipient custRec)
    {
        //Default size of 500...
        if(envelope.Recipients == null)
            initRecipients(envelope, 500);

        envelope.Recipients.Recipient[recPos] = custRec;
        recPos++;

        return envelope;
    }

	public static DocusignResponsiveAPI.Document getDocument(Integer id, String byteDocument, String name, String fileExtension ){
		DocusignResponsiveAPI.Document document = new DocusignResponsiveAPI.Document();
        document.ID = id;
        document.pdfBytes = byteDocument;
        document.Name = name;
        document.FileExtension = fileExtension;

        return document;
	}

    public static DocusignResponsiveAPI.Document getDocumentResponsive(Integer id, String htmlEncoded, String name, Integer maxScreenWidth, String fileExtension){
		DocusignResponsiveAPI.Document document = new DocusignResponsiveAPI.Document();
        document.ID = id;
        document.Name = name;
        document.FileExtension = fileExtension;
        DocusignResponsiveAPI.HtmlDefinition htmlDef = new DocusignResponsiveAPI.HtmlDefinition();
        htmlDef.MaxScreenWidth = maxScreenWidth;
        htmlDef.Source = htmlEncoded;

        document.HtmlDefinition = htmlDef;

        return document;
	}

    public static DocusignResponsiveAPI.Recipient getRecipient(Integer id, String type, Integer routingOrder, String email, String userName, DocusignResponsiveAPI.RecipientCaptiveInfo repCapInfo, Boolean requireIDLookup,DocusignResponsiveAPI.ArrayOfString1 arrayOfString) {
        
        DocusignResponsiveAPI.Recipient recipient = new DocusignResponsiveAPI.Recipient();
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

    public static DocusignResponsiveAPI.RecipientCaptiveInfo getCaptiveInfo(String clientUserId){
        DocusignResponsiveAPI.RecipientCaptiveInfo capInfo = new DocusignResponsiveAPI.RecipientCaptiveInfo();
        capInfo.ClientUserId = clientUserId;

        return capInfo;
    }

    public static DocusignResponsiveAPI.Tab getTab(String type, Integer recipientId, Integer documentId, DocusignResponsiveAPI.AnchorTab anchor) {
        
        DocusignResponsiveAPI.Tab tab = new DocusignResponsiveAPI.Tab();
        tab.Type_x = type; 
        tab.RecipientID = recipientId;
        tab.DocumentID = documentId;
        tab.AnchorTabItem = anchor;

        return tab;
    }

    public static DocusignResponsiveAPI.AnchorTab getAnchorTab(String anchorTabString)
    {
        DocusignResponsiveAPI.AnchorTab anch = new DocusignResponsiveAPI.AnchorTab();

        anch.AnchorTabString = anchorTabString;

        return anch;
    }


    /***********************
    *
    *SECTION TO BUILD URL FOR DOCUSIGN CALL FOR EMBED SIGNATURE 
    *
    *
    ***********************/

    public static String getEmbedSignatureURL(DocusignResponsiveAPI.APIServiceSoap soapService, String baseURL, String envelopeId, DocusignResponsiveAPI.Recipient embedRecipient)
    {
        DocusignResponsiveAPI.RequestRecipientTokenAuthenticationAssertion assert = new DocusignResponsiveAPI.RequestRecipientTokenAuthenticationAssertion();
        assert.AssertionID = 'Your AssertionID Here';
        assert.AuthenticationInstant = system.now();
        assert.AuthenticationMethod = 'Password';
        assert.SecurityDomain = 'YourApp.com';

        DocusignResponsiveAPI.RequestRecipientTokenClientURLs clientURLs = new DocusignResponsiveAPI.RequestRecipientTokenClientURLs();
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