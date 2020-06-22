/*
Name:  ExternalEmbedDocuSignController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the Visualforce Page: ExternalEmbedDocuSign

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Sylvain Picory&    2016-07-05  Initial development.
*/
public class ExternalEmbedDocuSignController extends TransactionStepControllerBase {

    public String externalURL {get; set;}
    public String officerTerm {get; set;}
    public String compName {get; set;}
    public Integer numberOfDirectorsSigning {get; set;}
    public Boolean displayBlueScreenDocusign {get; set;}

    public ExternalEmbedDocuSignController() {
        super();
        initialiseStep();
    }

    public void initialiseStep() {
        officerTerm = submissionMgr.submission.officerTerminology__c == null ? 'Director(s)' : submissionMgr.submission.officerTerminology__c;
        officerTerm = officerTerm.replace('s', '');
        compName = submissionMgr.submission.CompanyName__c == null ? 'Default Name' : submissionMgr.submission.CompanyName__c;
    }


    public PageReference initSiging() {

        PageReference res = initialiseAction();

        if(res != null)
            return res;
        displayBlueScreenDocusign = false;
        numberOfDirectorsSigning = 0;
        if(submissionMgr.submission.isPresenterMultipleDirectors__c)
        {
            for(Officer__c off :submissionMgr.submission.Officers__r)
            {
                if(off.isSignatory__c)
                    numberOfDirectorsSigning++;
            }
            //Display the correct div
            displayBlueScreenDocusign = true;

            return null;
        }
        else{
            externalURL = docusignSignature(submissionMgr, transactionMgr);
            //externalURL = 'https://demo.docusign.net/Signing/MTRedeem/v1/cc14a092-ed72-4f39-b6cd-e92087a0fe40?slt=eyJ0eXAiOiJNVCIsImFsZyI6IlJTMjU2Iiwia2lkIjoiNjgxODVmZjEtNGU1MS00Y2U5LWFmMWMtNjg5ODEyMjAzMzE3In0.AQUAAAABAAMABwCAa4bupm3XSAgAgMlWoadt10gYAAEAAAAAAAAAIQB5AwAAeyJUb2tlbklkIjoiYzMyZjkwZDAtOGYyMy00MzZhLWFlNTctN2Q1MDgxZGRkZjAxIiwiU3ViamVjdCI6bnVsbCwiU3ViamVjdFR5cGUiOm51bGwsIkV4cGlyYXRpb24iOiIyMDE5LTExLTIwVDEwOjUxOjQzKzAwOjAwIiwiSXNzdWVkQXQiOiIyMDE5LTExLTIwVDEwOjQ2OjQzLjUzMzY5NjgrMDA6MDAiLCJSZXNvdXJjZUlkIjoiMTFmZDdmNDktNGI3Zi00MGZhLWI3OGMtNWVlNTJiMDFiYjk1IiwiTGFiZWwiOm51bGwsIlNpdGVJZCI6bnVsbCwiUmVzb3VyY2VzIjoie1wiRW52ZWxvcGVJZFwiOlwiMTFmZDdmNDktNGI3Zi00MGZhLWI3OGMtNWVlNTJiMDFiYjk1XCIsXCJBY3RvclVzZXJJZFwiOlwiMThhMzFiYWYtYWVkOC00NTRhLTkzNWEtYTc0ODM4ODg3ZDcwXCIsXCJSZWNpcGllbnRJZFwiOlwiODA1MTczMzYtMTYyZi00M2ZlLTkxYTgtODMzOWNiMzQzNjgzXCIsXCJGYWtlUXVlcnlTdHJpbmdcIjpcInQ9NzAzOTIzOTgtYmFjNC00MjY0LTkwYjAtMzgyOThlMjNiZGNhXCJ9IiwiT0F1dGhTdGF0ZSI6bnVsbCwiVG9rZW5UeXBlIjoxLCJBbGxvd1JlY2lwaWVudFVzZXJzIjpmYWxzZSwiQXVkaWVuY2UiOiIyNWUwOTM5OC0wMzQ0LTQ5MGMtOGU1My0zYWIyY2E1NjI3YmYiLCJTY29wZXMiOm51bGwsIlJlZGlyZWN0VXJpIjoiaHR0cHM6Ly9kZW1vLmRvY3VzaWduLm5ldC9TaWduaW5nL1N0YXJ0SW5TZXNzaW9uLmFzcHgiLCJIYXNoQWxnb3JpdGhtIjowLCJIYXNoU2FsdCI6bnVsbCwiSGFzaFJvdW5kcyI6MCwiVG9rZW5TZWNyZXRIYXNoIjpudWxsLCJUb2tlblN0YXR1cyI6MCwiRXh0ZXJuYWxDbGFpbXNSZXF1ZXN0ZWQiOm51bGwsIlRyYW5zYWN0aW9uSWQiOm51bGwsIlRyYW5zYWN0aW9uRXZlbnRDYWxsYmFja1VybCI6bnVsbCwiSXNTaW5nbGVVc2UiOmZhbHNlfQ.UUeyEQ-CRm0XuBGG5jBKfatVob3hptlLzpOU5VHfeEnJYo5kIAnxViCNvA7qPp7pXGAqV8ziw_LIv4-1KMwKzc1cAeU_7W1avSfYL7a_sXsHbU1BE9hKOSRlqKNE8fZPGkYDMCQXXbs34nAeNNXwxhUTduS9kIUFh8WlJfSbQ2OHLDMAUhtGQtfKySZ90508YdOusFyqzyxKfbY424tntqmbUYrgrRtgy9qeYBJJW_LvKhLS5kckT1-8SwZ2OfSGVY8rGimKeKxILb5smmJ-aGiptcE7dPKKAjlsMOLU9egPF7VNiM6pn9GHvusAU1vSs5SNaXXvG2NJZzmdWQINFQ';
            //system.debug('E' + externalURL);
        }

        if(externalURL.equals('Error'))
        {
            PageReference pg = new PageReference('/IntegrationErrorDocusign');

            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            externalURL = pg.getUrl();
        }

        return null;
    }

    public void reRenderDocusign()
    {
        displayBlueScreenDocusign = false;
        externalURL = docusignSignature(submissionMgr, transactionMgr);

        if(externalURL.equals('Error'))
        {
            PageReference pg = new PageReference('/IntegrationErrorDocusign');

            pg.getParameters().put('c', SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())));
            pg.setRedirect(true);
            externalURL = pg.getUrl();
        }
    }

    public static String docusignSignature(SubmissionManager submissionMgrParam, TransactionManager transactionMgrParam) {
        
        System.debug(LoggingLevel.INFO, 'DocuSign Logging: entered docusignSignature');
        
        SubmissionManager submissionMgr = submissionMgrParam;
        TransactionManager transactionMgr = transactionMgrParam;
        DocuSignSetting__c dsSetting = getDocuSignSettings();

        //Build the unique document for the envelope
        Blob pdfBlob;

        //Logic to generate the right PDF for DS01
        String page = 'DS01';
        String emailBlurb = '<tr><td width="100%" style="font-family: Helvetica, Arial, sans-serif;"><h1 class="email" style="font-weight: 700; font-size: 48px; line-height: 1.041666667; margin: 30px 0;">Request to close '+submissionMgr.submission.CompanyName__c+'</h1></td></tr><tr><td width="100%" style="font-family: Helvetica, Arial, sans-serif;"><p style="font-size: 19px; line-height: 1.315789474; margin: 0 0 30px 0;">A request to close '+submissionMgr.submission.CompanyName__c + ' ('+submissionMgr.submission.CompanyNumber__c+') whose registered office address is '+submissionMgr.submission.CompanyAddress1__c+' '+  submissionMgr.submission.CompanyPostCode__c+' <b>needs your approval</b> before it can be submitted to Companies House for processing. </br> </br>The request will be deleted if it\'s not approved and completed by '+getDate(30)+'. Your reference number for any future enquiries is FE'+submissionMgr.submission.Id+'. </p><h2 style="font-size: 19px; line-height: 1.315789474; margin: 0 0 30px 0;">What happens next</h2><p style="font-size: 19px; line-height: 1.315789474; margin: 0 0 30px 0;">Once the request has been approved by all individuals required, we will send an email to the person filing with instructions to review, complete and submit the request.</a> </p><p style="font-size: 19px; line-height: 1.315789474; margin: 0 0 30px 0;">It is the responsibility of directors to ensure that copies of the request have been sent to all interested parties. This can include members (usually shareholders), creditors and employees, who must be notified within 7 days of submitting the completed request. The full list of who to tell can be found in the <a class="govuk-link" href=\'https://www.gov.uk/government/publications/company-strike-off-dissolution-and-restoration\'>online guide.</a> </p></td></tr>';

        if(transactionMgr.transactionType.contains('LL'))
        {
            page =  'LL' + page;
            emailBlurb = '<tr><td width="100%" style="font-family: Helvetica, Arial, sans-serif;"><h1 class="email" style="font-weight: 700; font-size: 48px; line-height: 1.041666667; margin: 30px 0;">Request to close '+submissionMgr.submission.CompanyName__c+'</h1></td></tr><tr><td width="100%" style="font-family: Helvetica, Arial, sans-serif;"><p style="font-size: 19px; line-height: 1.315789474; margin: 0 0 30px 0;">A request to close '+submissionMgr.submission.CompanyName__c + ' ('+submissionMgr.submission.CompanyNumber__c+') whose registered office address is '+submissionMgr.submission.CompanyAddress1__c+' '+  submissionMgr.submission.CompanyPostCode__c+' <b>needs your approval</b> before it can be submitted to Companies House for processing. </br> </br>The request will be deleted if it\'s not approved and completed by '+getDate(30)+'. Your reference number for any future enquiries is FE'+submissionMgr.submission.Id+'. </p><h2 style="font-size: 19px; line-height: 1.315789474; margin: 0 0 30px 0;">What happens next</h2><p style="font-size: 19px; line-height: 1.315789474; margin: 0 0 30px 0;">Once the request has been approved by all individuals required, we will send an email to the person filing with instructions to review, complete and submit the request.</a> </p><p style="font-size: 19px; line-height: 1.315789474; margin: 0 0 30px 0;">It is the responsibility of members to ensure that copies of the request have been sent to all interested parties. This can include members (usually shareholders), creditors and employees, who must be notified within 7 days of submitting the completed request. The full list of who to tell can be found in the <a class="govuk-link" href=\'https://www.gov.uk/government/publications/limited-liability-partnership-strike-off-dissolution-and-restoration\'>online guide.</a> </p></td></tr>';
         }   


        System.debug(LoggingLevel.INFO, 'DocuSign Logging: after emailBlurb');
        
        PageReference pageRef = new PageReference('/apex/' + page);
        pageRef.getParameters().put('id', submissionMgr.submission.Id);
        
        System.debug(LoggingLevel.INFO, 'DocuSign Logging: got pageref');
        
        if (Test.IsRunningTest())
            pdfBlob = Blob.valueOf('This is a test');
        else
            pdfBlob = pageRef.getContent();

        System.debug(LoggingLevel.INFO, 'DocuSign Logging: got blob');

        DocusignResponsiveRestAPI.Document doc;
        DocusignResponsiveRestAPI.HtmlDefinition htmlDef;
        DocusignRESTLibrary.EmbeddedEnvelopeSignerDetails signerDetails = new DocusignRESTLibrary.EmbeddedEnvelopeSignerDetails();

        if(!transactionMgr.transactionType.contains('LL'))
        {
            
            String dsString = getDS01(submissionMgr.submission, false);
        
            system.debug('DISPLAY HTML');
            system.debug(dsString);

            //pdfBlob = Blob.valueOf(dsString);
            //doc = DocusignLibrary.getDocumentResponsive(1,  dsString.escapeHtml4(), submissionMgr.submission.Form_Name__c + '_' + submissionMgr.submission.CompanyName__c + '_' + getDate(0), 1, 'html');
            htmlDef = DocusignRESTLibrary.getHtmlDefinition(null, dsString);
            doc = DocusignRESTLibrary.getDocument('1', submissionMgr.submission.Form_Name__c + '_' + submissionMgr.submission.CompanyName__c + '_' + getDate(0), htmlDef);
        }
        else {
            //TODO: this will change to LLDS01
            String dsString = getDS01(submissionMgr.submission, true);

            htmlDef = DocusignRESTLibrary.getHtmlDefinition(null, dsString);
            
            doc = DocusignRESTLibrary.getDocument('1', submissionMgr.submission.Form_Name__c + 'LL_' + submissionMgr.submission.CompanyName__c + '_' + getDate(0), htmlDef);
        }
            

        System.debug(LoggingLevel.INFO, 'DocuSign Logging: got pdfBlob');

        

        System.debug(LoggingLevel.INFO, 'DocuSign Logging: got doc');
        
        DocusignResponsiveRestAPI.TextCustomField custF1 = DocusignRESTLibrary.getTextCustomField(submissionMgr.submission.Id + '~Transaction__c', 'DSFSSourceObjectId');
        DocusignResponsiveRestAPI.TextCustomFields parentCustF1 = DocusignRESTLibrary.initTextCustomfields(new DocusignResponsiveRestAPI.TextCustomFields(), 1);
        parentCustF1 = DocusignRESTLibrary.addTextCustomField(parentCustF1, custF1);
        DocusignResponsiveRestAPI.Notification notif = DocusignRESTLibrary.getNotification('true');

        DocusignResponsiveRestAPI.Envelope env = DocusignRESTLibrary.getEnvelope('Approve application to close your company', 'sent', dsSetting.BrandId__c, emailBlurb, notif, parentCustF1);
        //DocusignResponsiveAPI.Envelope env = DocusignLibrary.getEnvelope(dsSetting.AccountId__c, 'Approve application to close your company',  emailBlurb, dsSetting.BrandId__c);

        System.debug(LoggingLevel.INFO, 'DocuSign Logging: got initial env');
        
        //Init size of each collection of the envelope
        env = DocusignRESTLibrary.initDocuments(env, 1);
        env = DocusignRESTLibrary.addDocument(env, doc);

        Integer signersNumber = 0;

        for (Integer i = 0; i < submissionMgr.submission.Contacts__r.size(); i++) {
            Contact off = submissionMgr.submission.Contacts__r[i];


            if (off.isSignatory__c ) {
                signersNumber++;
            }
        }

        DocusignResponsiveRestAPI.Recipient rec = DocusignRESTLibrary.initSigners(new DocusignResponsiveRestAPI.Recipient(), signersNumber);

        List<Officer__c> offToUpdate = new List<Officer__c>();
        
        
        Boolean presenter = false;

        Integer routingOrder = 2;

        for (Integer i = 0; i < submissionMgr.submission.Contacts__r.size(); i++) {
            Contact off = submissionMgr.submission.Contacts__r[i];


            if (off.isSignatory__c) {
                //Get the corresponding officer
                Officer__c offRec = new Officer__c();

                for (Officer__c offRecord : submissionMgr.submission.Officers__r) {
                    if (String.valueOf(off.RecipientId__c) == offRecord.RecipientId__c) {
                        offRec.Id = offRecord.Id;
                    }
                }

                String offName = (off.Title != null ? off.Title + ' ': '' ) + (off.FirstName != null ? off.FirstName.capitalize() + ' ' : '')  +  off.LastName.toLowerCase().capitalize();
                String recName = (off.isCorporateDirector__c == true ? off.AuthorizedSigner__c + ' pp ' + offName  : (off.isPowerOfAttorney__c == true ? off.AuthorizedSigner__c + ' pp ' + offName : offName));

                //Update off with the sent name to Docusign
                offRec.DocusignName__c = recName;
                if (offRec.Id != null) {
                    offToUpdate.add(offRec);
                }

                DocusignResponsiveRestAPI.Signer signer;

                signer = DocusignRESTLibrary.getSigner('' + Integer.valueOf(off.RecipientId__c), null, off.Email, recName, '' + ( off.IsPresenter__c ? 1 : routingOrder), new String[]{'##SFContact:' + off.Id + ':' + off.Name + ''});

                if (off.IsPresenter__c) {
                    presenter = true;
                    signerDetails.AuthenticationMethod = 'Password';
                    signerDetails.clientUserId = '' + Integer.valueOf(off.RecipientId__c);
                    signerDetails.email = off.Email;
                    signerDetails.userName = recName;
                    signer.clientUserId = '' + Integer.valueOf(off.RecipientId__c);
                }

                rec = DocusignRESTLibrary.addSigner(rec, signer);
                routingOrder++;
            }
        }

        //Set the recipient
        env.recipients = rec;

        System.debug(LoggingLevel.INFO, 'DocuSign Logging: got final env');

        String baseURL = Site.getBaseUrl() + '/DigitalSignature';
        
        //Here page URL contains Apex/Payment
        baseURL = baseURL + '?c=' + SecurityManager.encryptText(submissionMgr.submission.Id + AppConstants.ID_DELIM_CHAR + transactionMgr.currentStep.Id + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())) ;
        
        signerDetails.returnUrl = baseURL;
        
        System.debug(LoggingLevel.INFO, 'DocuSign Logging: got baseURL=' + baseURL);

        String result = 'SENT';

        if(!Test.isRunningTest())
        {
            HttpResponse responseEnvelope = DocusignRESTLibrary.createAndSendEnvelope(env);
            system.debug('RESPONSEA:' + responseEnvelope.getBody());
            if(responseEnvelope.getStatusCode() == 201)
            {
                //We need to extract the envelope ID
                DocusignRESTLibrary.EnvelopeResponse b = (DocusignRESTLibrary.EnvelopeResponse)JSON.deserialize(responseEnvelope.getBody(), DocusignRESTLibrary.EnvelopeResponse.class);

                if(presenter)
                {
                    //Get the url
                    HttpResponse responseURL = DocusignRESTLibrary.getEmbeddedURL(signerDetails, b.envelopeId);
                    system.debug('RESPONSEB:' + responseURL.getBody());
                    if(responseURL.getStatusCode() == 201)
                    {
                        DocusignRESTLibrary.URLResponse c = (DocusignRESTLibrary.URLResponse)JSON.deserialize(responseURL.getBody(), DocusignRESTLibrary.URLResponse.class);
                        result = c.url;
                    }
                    else {
                        result = 'Error';
                    }
                }
            }
            else {
                result = 'Error';
            }
        }        
        system.debug('RESULT:' + result);
        System.debug(LoggingLevel.INFO, 'DocuSign Logging: sent envelope');

        //Update the sending name of each off
        update offToUpdate;
        
        return result;
    }


    public static String getDate(Integer addDays) {
        Date d = date.today();
        if(addDays != 0)
        {
            d = d.addDays(addDays);
        }
        String day   = d.day()   > 9 ? string.valueOf(d.day())   : '0' + string.valueOf(d.day());
        String month = d.month() > 9 ? string.valueOf(d.month()) : '0' + string.valueOf(d.month());

        return day +'-' + month + '-' + d.year();
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
                    Active__c           = true);
            return dsSettTest;
        }

        System.debug(LoggingLevel.ERROR, 'No active DocuSignSetting records exist under Custom'
                     + ' Settings. Can\'t connect to DocuSign.');
        return null;
    }
    
    public static String getDS01(Transaction__c submission, Boolean isLL)
    {
        system.debug('Entering getDS01..');
        
        Boolean moreThanOneDirectorSigning = false;
        Integer nbOfD = 0;
        for(Officer__c off : submission.Officers__r)
        {
            if(off.isSignatory__c)
            {
                nbOfD++;
            }
        }
        if(nbOfD > 1)
            moreThanOneDirectorSigning = true;

        
        String dsString = '<div style="padding: 20px; max-width: 960px; font-size: 19px; margin: 0 auto;">'
            +'<img src="https://coredbeta-coredev.cs83.force.com/resource/1543573587000/SVGLogo" title="Companies House" style="margin-bottom: 20px; width: 260px;" />'
            +'<h1 style="font-family: Arial, sans-serif; font-size: 48px; margin: 20px 0 50px 0;">Application to strike off</h1>'
            +'<dl style="display: table; margin-bottom: 30px; width: 100%; font-size: 19px;">'
            +'<div style="display: table-row;">'
            +'<dt style="font-family: Arial, sans-serif; font-size: 19px; line-height: 1.31579; font-weight: bold; display: table-cell; width: 30%; padding: 10px 20px 10px 0; border-bottom: 1px solid #b1b4b6; word-wrap: break-word;">Document code</dt>' 
            +'<dd style="font-family: Arial, sans-serif; font-size: 19px; line-height: 1.31579; display: table-cell; width: 70%; padding: 10px 20px 10px 0; border-bottom: 1px solid #b1b4b6; word-wrap: break-word;">' + (isLL ? 'LLDS-01-EF' : 'DS-01-EF') + '</dd>'
            +'</div>'
            +'<div style="display: table-row;">'
            +'<dt style="font-family: Arial, sans-serif; font-size: 19px; line-height: 1.31579; font-weight: bold; display: table-cell; width: 30%; padding: 10px 20px 10px 0; border-bottom: 1px solid #b1b4b6; word-wrap: break-word;">' + (isLL ? 'LLP name: ' : 'Company name: ') + '</dt>' 
            +'<dd style="font-family: Arial, sans-serif; font-size: 19px; line-height: 1.31579; display: table-cell; width: 70%; padding: 10px 20px 10px 0; border-bottom: 1px solid #b1b4b6; word-wrap: break-word;">' + submission.CompanyName__c + '</dd>'
            +'</div>'
            +'<div style="display: table-row;">'
            +'<dt style="font-family: Arial, sans-serif; font-size: 19px; line-height: 1.31579; font-weight: bold; display: table-cell; width: 30%; padding: 10px 20px 10px 0; border-bottom: 1px solid #b1b4b6; word-wrap: break-word;">' + (isLL ? 'LLP number: ' : 'Company number: ') + '</dt>'
            +'<dd style="font-family: Arial, sans-serif; font-size: 19px; line-height: 1.31579; display: table-cell; width: 70%; padding: 10px 20px 10px 0; border-bottom: 1px solid #b1b4b6; word-wrap: break-word;">' + submission.CompanyNumber__c + '</dd>'
            +'</div>'
            +'</dl>'
            +'<h2 style="font-family: Arial, sans-serif; font-size: 36px; margin: 0 0 30px 0;">Important notice for all interested parties</h2>'
            +'<p style="font-family: Arial, sans-serif; font-size: 19px; line-height: 1.31579; margin-bottom: 30px; max-width: 38em;">This company has applied to be struck off and dissolved. The registrar will proceed unless there is reasonable cause not to, and on dissolution any assets remaining in the company will be passed to the Crown. Guidance is available on grounds for'
            +' objection. If in doubt seek professional advice.</p>'
            +'<h2 style="font-family: Arial, sans-serif; font-size: 36px; margin: 0 0 30px 0;">' + (moreThanOneDirectorSigning ? 'Declaration of '+ (isLL ? 'members' : 'directors') : 'Declaration of '+ (isLL ? 'members' : 'director')) + '</h2>'
            +'<p style="font-family: Arial, sans-serif; font-size: 19px; line-height: 1.31579; margin-bottom: 30px; max-width: 38em;">' + (moreThanOneDirectorSigning ? 'We as the majority of '+ (isLL ? 'members' : 'directors') +' apply for this company to be struck off the Register, and declare that none of the circumstances described in section 1004 and 1005 of the Companies Act 2006, (being circumstances in which the '+ (isLL ? 'members' : 'directors') +' would ': 'I as the '+ (isLL ? 'member' : 'director') +' apply for this company to be struck off the Register, and declare that none of the circumstances described in section 1004 and 1005 of the Companies Act 2006, (being circumstances in which the '+ (isLL ? 'member' : 'director') +' would')
            +' otherwise be prohibited under those sections from making an application), exists in relation to the company.</p>'
            +'<h3 style="font-family: Arial, sans-serif; font-size: 27px; margin: 0 0 20px 0;">' + (moreThanOneDirectorSigning ? 'Authorising company '+ (isLL ? 'members' : 'directors') : 'Authorising company '+ (isLL ? 'member' : 'director')) + '</h3>';
        
        for(Officer__c off : submission.Officers__r)
        {
            if(off.isSignatory__c)
            {
                dsString +='<div style="display: flex; flex-direction: row; flex-wrap: wrap; align-items: stretch; font-family: Arial, sans-serif; font-size: 19px; line-height: 1.31579; padding: 10px 20px 10px 0; border-bottom: 1px solid #b1b4b6">'
                    +'<div style="flex-grow: 1; width: 30%;">'
                    +'<p style="font-family: Arial, sans-serif; font-size: 19px; line-height: 1.31579;">' + (String.isBlank(off.Title__c) ? '' : off.Title__c +' ') + (String.isBlank(off.Forename__c) ? '' : off.Forename__c +' ') + ' ' + (String.isBlank(off.Surname__c) ? '' : off.Surname__c +' ') + '</p>'
                    +'</div>'
                    +'<div style="flex-grow: 1; width: 60%;">'
                    +'<div style="font-family: Arial, sans-serif; font-size: 19px; line-height: 1.31579; margin-bottom: 10px; border-bottom: 2px solid #000; padding-bottom: 5px; min-height: 70px;">'
                    +'<ds-signature  data-ds-recipient-id="' + off.RecipientId__c + '" />'
                    +'</div>'
                    +'<div style="font-family: Arial, sans-serif; font-size: 19px; line-height: 1.31579;">Signature date: '
                    +'<ds-date-signed  data-ds-recipient-id="' + off.RecipientId__c + '" style="font-size: 19px;" />'
                    +'</div>'
                    +'</div>'
                    +'</div>';
            }
        }
        
        dsString +='</div>';

        return dsString;
    }
}