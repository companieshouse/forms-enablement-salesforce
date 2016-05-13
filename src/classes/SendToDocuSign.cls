/**
 * This class is for Create the envelope for DocuSign and allowed embeded Signatures for Sole Traders
 *
 * For DocuSign Integration there is a Custom Object DocuSign Settings
 * 
 * Author: antonio.bravo@golligo.co.uk
 * ab
 **/
 public with sharing class SendToDocuSign {
    private Boolean isEmbedSignature;
    private String tokenURL; 
    private String envelopeId;
    private String nextStepURL;
    private Transaction__c tx;
    
    private DocuSignAPI.Recipient embedRecipient;
    private DocuSignAPI.APIServiceSoap dsApiSend;

    
    public String embedDocuSignOpen(Transaction__c trans) {
        isEmbedSignature = false;
        tokenURL = null;
        envelopeId = 'Not sent yet';
        embedRecipient = null;
        
        //set
        tx = trans;
        dsApiSend = new DocuSignAPI.APIServiceSoap();
        
        System.debug('EmbedDocuSign transaction: ' + tx);

        //Create and send Envelope
        SendNow();

        //If is Presenter is a Director get token to embedDocuSign
        if(embedRecipient != null)
            tokenURL = getToken();

        return tokenURL;
    }
    
    
    private void SendNow() {
        Blob pdfBlob;
        Integer count;
        List<Officer__c> officersToSignList = new List<Officer__c>();


        DocuSignSetting__c dsSetting = getDocuSignSettings();

        //Set Endpoint
        dsApiSend.endpoint_x = dsSetting.URL__c;

        //Set Authentication
        String auth = '<DocuSignCredentials><Username>'+ dsSetting.Username__c 
                + '</Username><Password>' + dsSetting.Password__c 
                + '</Password><IntegratorKey>' + dsSetting.IntegratorKey__c
                + '</IntegratorKey></DocuSignCredentials>';
        System.debug('Setting authentication to: ' + auth);
            
        dsApiSend.inputHttpHeaders_x = new Map<String, String>();
        dsApiSend.inputHttpHeaders_x.put('X-DocuSign-Authentication', auth);
 
        // To do:
        // - update subject
        // - update message
        DocuSignAPI.Envelope envelope = new DocuSignAPI.Envelope();
        envelope.Subject = 'DS01 - Striking off application for ' + tx.CompanyName__c ;
        envelope.EmailBlurb = 'This is Companies House new eSignature service,'+ 
            ' it allows to get your electronic signoff.';
        envelope.AccountId  = dsSetting.AccountId__c; 
        

        // Render the contract
        // Use PDFGeneration to render DS01
        // To do update PDFGeneration to be generic
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
        // Get Officers requested to sign and add to envelope as a recipients
        System.debug('getting the Recipients');
        
        for(Officer__c off : tx.Officers__r){
            if(off.isSignatory__c){
                officersToSignList.add(off);      
            }
        }

        envelope.Recipients = new DocuSignAPI.ArrayOfRecipient();
        envelope.Recipients.Recipient = new DocuSignAPI.Recipient[officersToSignList.size()];
        
        count=0;
        for(Officer__c off : officersToSignList){
            DocuSignAPI.Recipient recipient = getRecipient(off, count+1);
            envelope.Recipients.Recipient[count] = recipient;
            count++;    
        }


       
        // Tab
        envelope.Tabs = new DocuSignAPI.ArrayOfTab();
        envelope.Tabs.Tab = new DocuSignAPI.Tab[officersToSignList.size()*2]; //for each Officer we will create 2 tabs
        
        count=0;
        for(Integer recipientId=1; recipientId <= officersToSignList.size(); recipientId++){
            //create a tab for signing 
            DocuSignAPI.Tab tab1 = createTab('SignHere', recipientId, 1);
            envelope.Tabs.Tab[count] = tab1;
            count++;
            
            //create a tab for date
            DocuSignAPI.Tab tab2 = createTab('DateSigned', recipientId, 1);
            envelope.Tabs.Tab[count] = tab2;
            count++;
        }
        
        
        System.debug('Calling the API');
        try {
            
            DocuSignAPI.EnvelopeStatus es = dsApiSend.CreateAndSendEnvelope(envelope);
            envelopeId = es.EnvelopeID;

        } catch ( CalloutException e) {
            
            System.debug('Exception - ' + e );
            envelopeId = 'Exception - ' + e;
        
        }
    }
     

    private String getToken() { 
        String token = '';
        
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
            token = dsApiSend.RequestRecipientToken(envelopeId,embedRecipient.captiveinfo.ClientUserId,embedRecipient.UserName,embedRecipient.Email,assert,clientURLs);
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
    private DocuSignAPI.Recipient getRecipient(Officer__c off, Integer recipientId) {
        DocuSignAPI.Recipient recipient = new DocuSignAPI.Recipient();
        recipient.ID = recipientId;
        recipient.Type_x = 'Signer';
        //Change this field if signing order is different, e.g. sign2 wait for sign1 completion
        recipient.RoutingOrder = 1; 
        recipient.Email = off.Email__c;
        recipient.UserName = convertName(off.Name);
        
        // If Officer is Presenter set embedded signature
        if(off.isPresenter__c) { 
            isEmbedSignature = true;
            recipient.CaptiveInfo = new DocuSignAPI.RecipientCaptiveInfo();
            recipient.CaptiveInfo.ClientUserId = off.Email__c;

            embedRecipient = recipient;
        }
            
        // This setting seems required or you see the error:
        // "The string '' is not a valid Boolean value. 
        // at System.Xml.XmlConvert.ToBoolean(String s)" 
        recipient.RequireIDLookup = false;

        return recipient;
    }

    private DocuSignAPI.Tab createTab(String type, Integer recipientId, Integer documentId) {
        DocuSignAPI.Tab tab = new DocuSignAPI.Tab();
        tab.Type_x = type; //'SignHere'
        tab.RecipientID = recipientId;
        tab.DocumentID = documentId;
        tab.AnchorTabItem = new DocuSignAPI.AnchorTab();
        if(type == 'SignHere')
            tab.AnchorTabItem.AnchorTabString = '/s' + recipientId + '/';
        else if(type == 'DateSigned')
            tab.AnchorTabItem.AnchorTabString = '/sd' + recipientId + '/';

        return tab;
    }

    // API is returning last name + first Name
    // This function set name in the correct order
    private String convertName(String name) {
        String firstName;
        String lastName;

        firstName = name.substringAfter(',') + ' ';
        
        lastName = name.substringBefore(',');
        lastName = lastName.toLowerCase();
        lastName = lastName.capitalize();

        return firstName + lastName;
    }
}