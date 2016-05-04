/**
 * This class is for Create the envelope for DocuSign and allowed embeded Signatures for Sole Traders
 *
 * For DocuSign Integration there is a Custom Object DocuSign Settings
 * 
 * Author: antonio.bravo@golligo.co.uk
 * ab
 **/
 public with sharing class SendToDocuSign {
    public Transaction__c tx;
    public String tokenURL;
    public String envelopeId;

    private String nextStepURL;
    

    
    public String embedDocuSignOpen(Transaction__c trans) {
        envelopeId = 'Not sent yet';
        tx = trans;
        
        System.debug('EmbedDocuSign transaction: ' + tx);

        tokenURL = SendNow();

        return tokenURL;
    }
    
    private String SendNow() {
        String token = '';
        Blob pdfBlob;

        DocuSignSetting__c dsSetting = getDocuSignSettings();

        DocuSignAPI.APIServiceSoap dsApiSend = new DocuSignAPI.APIServiceSoap();
        dsApiSend.endpoint_x = dsSetting.URL__c;

        //Set Authentication
        String auth = '<DocuSignCredentials><Username>'+ dsSetting.Username__c 
                +'</Username><Password>' + dsSetting.Password__c 
                + '</Password><IntegratorKey>' + dsSetting.IntegratorKey__c
                + '</IntegratorKey></DocuSignCredentials>';
        System.debug('Setting authentication to: ' + auth);
            
        dsApiSend.inputHttpHeaders_x = new Map<String, String>();
        dsApiSend.inputHttpHeaders_x.put('X-DocuSign-Authentication', auth);
 
        DocuSignAPI.Envelope envelope = new DocuSignAPI.Envelope();
        envelope.Subject = 'DS01 - Striking off application for ' + tx.CompanyName__c ;
        envelope.EmailBlurb = 'This is Companies House new eSignature service,'+ 
            ' it allows to get your electronic signoff.';
        envelope.AccountId  = dsSetting.AccountId__c; 
        

        // Render the contract
        // Use PDFGeneration to render DS01
        System.debug('Rendering the PDF');
        PageReference pageRef = new PageReference('/apex/PDFGeneration');
        pageRef.getParameters().put('id',tx.Id);
        if(Test.IsRunningTest())
            pdfBlob = Blob.valueOf('This is a test');
        else
            pdfBlob = pageRef.getContent();     

        // Document
        DocuSignAPI.Document document = new DocuSignAPI.Document();
        document.ID = 1;
        document.pdfBytes = EncodingUtil.base64Encode(pdfBlob);
        document.Name = tx.Form_Name__c;
        document.FileExtension = 'pdf';
        envelope.Documents = new DocuSignAPI.ArrayOfDocument();
        envelope.Documents.Document = new DocuSignAPI.Document[1];
        envelope.Documents.Document[0] = document;
        
        /**
        * Relate DocuSign Envelope with
        * - Transaction record
        * - Officer record
        *
        * To do
        * This approach only works with limited officers. DocuSign should provide a solution for Beta
        */ 
        envelope.CustomFields = new DocuSignAPI.ArrayOfCustomField();
        envelope.CustomFields.CustomField = new DocuSignAPI.CustomField[2];
        //relate with Transaction
        envelope.CustomFields.CustomField[0] = new DocuSignAPI.CustomField();
        envelope.CustomFields.CustomField[0].Name = 'DSFSSourceObjectId'; /* check this */
        envelope.CustomFields.CustomField[0].Value = tx.Id + '~Transaction__c'; 
        envelope.CustomFields.CustomField[0].CustomFieldType = 'Text';
        // relate with Officer
        envelope.CustomFields.CustomField[1] = new DocuSignAPI.CustomField();
        envelope.CustomFields.CustomField[1].Name = 'OfficerSigner1'; /* check this */
        envelope.CustomFields.CustomField[1].Value = tx.Officers__r[0].Id + '~Officer__c'; 
        envelope.CustomFields.CustomField[1].CustomFieldType = 'Text';

        // Recipient
        System.debug('getting the Recipients');
        envelope.Recipients = new DocuSignAPI.ArrayOfRecipient();
        // Set Recipient
        Officer__c off = tx.Officers__r[0];
        envelope.Recipients.Recipient = new DocuSignAPI.Recipient[1];
        DocuSignAPI.Recipient recipient = getRecipient(off, 1);
        envelope.Recipients.Recipient[0] = recipient;
        
        // Tab
        DocuSignAPI.Tab tab1 = new DocuSignAPI.Tab();
        tab1.Type_x = 'SignHere';
        tab1.RecipientID = 1;
        tab1.DocumentID = 1;
        tab1.AnchorTabItem = new DocuSignAPI.AnchorTab();
        tab1.AnchorTabItem.AnchorTabString = '/s1/';

        DocuSignAPI.Tab tab2 = new DocuSignAPI.Tab();
        tab2.Type_x = 'DateSigned';
        tab2.RecipientID = 1;
        tab2.DocumentID = 1;
        tab2.AnchorTabItem = new DocuSignAPI.AnchorTab();
        tab2.AnchorTabItem.AnchorTabString = '/sd1/';
        
        envelope.Tabs = new DocuSignAPI.ArrayOfTab();
        envelope.Tabs.Tab = new DocuSignAPI.Tab[2];
        envelope.Tabs.Tab[0] = tab1;        
        envelope.Tabs.Tab[1] = tab2;        
        
        System.debug('Calling the API');
        try {
            
            DocuSignAPI.EnvelopeStatus es = dsApiSend.CreateAndSendEnvelope(envelope);
            envelopeId = es.EnvelopeID;

        } catch ( CalloutException e) {
            
            System.debug('Exception - ' + e );
            envelopeId = 'Exception - ' + e;
        
        }
        
        /**
        * To do - set correct values
        */
        DocuSignAPI.RequestRecipientTokenAuthenticationAssertion assert = new DocuSignAPI.RequestRecipientTokenAuthenticationAssertion();
        assert.AssertionID = 'Your AssertionID Here';
        assert.AuthenticationInstant = system.now();
        assert.AuthenticationMethod = 'Password';
        assert.SecurityDomain = 'YourApp.com';
        
        
        // Set return URL
        /**
        * To do - only Completed transactions should go to ReviewPage 
        */
        DocuSignAPI.RequestRecipientTokenClientURLs clientURLs = new DocuSignAPI.RequestRecipientTokenClientURLs();
        clientURLs.OnAccessCodeFailed   = getPopURL() + '&event=OnAccessCodeFailed&envelopeid='   + envelopeID;
        clientURLs.OnCancel             = getPopURL() + '&event=OnCancel&envelopeid='             + envelopeID;
        clientURLs.OnDecline            = getPopURL() + '&event=OnDecline&envelopeid='            + envelopeID;
        clientURLs.OnException          = getPopURL() + '&event=OnException&envelopeid='          + envelopeID;
        clientURLs.OnFaxPending         = getPopURL() + '&event=OnFaxPending&envelopeid='         + envelopeID;
        clientURLs.OnIdCheckFailed      = getPopURL() + '&event=OnIdCheckFailed&envelopeid='      + envelopeID;
        clientURLs.OnSessionTimeout     = getPopURL() + '&event=OnSessionTimeout&envelopeid='     + envelopeID;
        clientURLs.OnSigningComplete    = getPopURL() + '&event=OnSigningComplete&envelopeid='    + envelopeID;
        clientURLs.OnTTLExpired         = getPopURL() + '&event=OnTTLExpired&envelopeid='         + envelopeID;
        clientURLs.OnViewingComplete    = getPopURL() + '&event=OnViewingComplete&envelopeid='    + envelopeID;

        // debug
        System.debug('DocuSign return URL: ' + getPopURL() + '&event=OnSigningComplete&envelopeid='    + envelopeID);
        
        // assumes apiService = preconfigured api proxy
        try {
            token = dsApiSend.RequestRecipientToken(envelopeId,recipient.captiveinfo.ClientUserId,recipient.UserName,recipient.Email,assert,clientURLs);
        }  catch ( CalloutException e) {
                System.debug('Exception - ' + e );
                envelopeId = 'Exception - ' + e;
        }
        
        return token;
    }

    // returns URL of POP page that redirects callbacks to correct URL
    // Strips off end of path and replaces with ndaPOP
    private String getPopURL() {
        String popURL = Site.getBaseUrl();
        String paramC = ApexPages.currentPage().getParameters().get('c');

        if (popURL == null || popURL == '') {
            //popURL = 'https://cs83.salesforce.com/'; // apex/
            popURL = 'https://abdev-companieshousedev.cs83.force.com';
            //popURL = 'https://c.cs83.visual.force.com/apex/EmbedDocuSign';
        } 
        popURL += '/EmbedDocuSign';
        popURL += '?c=' + paramC;
        return popURL;
    }

    // Look for a custom setting record with the URL, username and password for the DocuSign server.
    public static DocuSignSetting__c getDocuSignSettings() {
        List<DocuSignSetting__c> dsSettingsList = DocuSignSetting__c.getAll().values();
        
        // Return the first active one found.
        for (DocuSignSetting__c dsSett : dsSettingsList) {
            if (dsSett.Active__c) {
                return dsSett;
            }
        }
        
        // Unit tests should not rely on custom settings records.
        if (Test.isRunningTest()) {
            String dsPrefix = dsfs__DocuSign_Status__c.sobjecttype.getDescribe().getKeyPrefix();

            DocuSignSetting__c dsSettTest = new DocuSignSetting__c(Name = 'DocuSign Test Settings',
                                                    Username__c         = 'unitTestUsername', 
                                                    Password__c         = 'unitTestPassword',
                                                    AccountId__c        = 'unitTestAccountId',
                                                    IntegratorKey__c    = 'unitTestIntegratorKey',
                                                    URL__c              = 'unitTestURL',
                                                    RecordIdPrefix__c   = dsPrefix,
                                                    Active__c           = true);
            return dsSettTest;
        }
        
        System.debug(LoggingLevel.ERROR, 'No active DocuSignSetting records exist under Custom'
                     + ' Settings. Can\'t connect to DocuSign.');
        return null;
    }


    /********************* Aux *********************/
    public DocuSignAPI.Recipient getRecipient(Officer__c off, Integer order) {
        DocuSignAPI.Recipient recipient = new DocuSignAPI.Recipient();
        recipient.ID = order;
        recipient.Type_x = 'Signer';
        recipient.RoutingOrder = order;
        recipient.Email = off.Email__c;
        recipient.UserName = convertName(off.Name);
        
        // If 1 set embedded signature
        // to do compare with user authenticate 
        if(order == 1) {
            recipient.CaptiveInfo = new DocuSignAPI.RecipientCaptiveInfo();
            recipient.CaptiveInfo.ClientUserId = off.Email__c;
        }
            
        // This setting seems required or you see the error:
        // "The string '' is not a valid Boolean value. 
        // at System.Xml.XmlConvert.ToBoolean(String s)" 
        recipient.RequireIDLookup = false;

        return recipient;
    }

    // API is returning last name + first Name
    // This function set name in the correct order
    public String convertName(String name) {
        String firstName;
        String lastName;

        firstName = name.substringAfter(',') + ' ';
        
        lastName = name.substringBefore(',');
        lastName = lastName.toLowerCase();
        lastName = lastName.capitalize();

        return firstName + lastName;
    }
}