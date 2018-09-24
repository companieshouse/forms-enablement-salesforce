/*
Name:  Review.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Transaction Review Page
======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-05-19  Initial development.
*/
public with sharing class ReviewController extends TransactionStepControllerBase {
    private static final String QUERY_STRING_PARAM_AUTH_CODE = 'code';
    private static final String QUERY_STRING_PARAM_NONCE = 'state';
    public String authCode {get; set;}

    public String title {
        get;
        private set;
    }
    public String size {
        get;
        private set;
    }
    public String todayThreeMonths {
        get; 
        set;
    }
    public Id attachmentId {
        get;
        private set;
    }
    public Boolean showDoc {
            get;
            private set;
        }
    
    @TestVisible private AccountsAPIHelper.Token accessTokenApiResponse;
    @TestVisible private AccountsAPIHelper.UserProfile userProfileApiResponse;

    @TestVisible private AccountsAPIHelper h {
        get;
        set;
    }

    @testvisible
    private Company_Authorisation__c companyAuth;

    public String transactionType {
        get;
        set;
    }
    @testvisible
    private String nonce;

    public Boolean hasPageErrors {
        get;
        set;
    }
    public String currentErrorMessage {
        get;
        set;
    }
    public String displayText1 {
        get;
        set;
    }
    public String displayText2 {
        get;
        set;
    }
    public String displayText3 {
        get;
        set;
    }
    public String headerText1 {
        get;
        set;
    }
    public String companyName {
        get;
        set;
    }
    public String companyNumber {
        get;
        set;
    }
    public String presenterEmail {
        get;
        set;
    }
    public String presenterName {
        get;
        set;
    }
    public String presenterPhone {
        get;
        set;
    }
    public List < Officer__c > companyDirectors {
        get;
        set;
    }

    public String companyAddress {
        get;
        set;
    }
    public String companyAddress1 {
        get;
        set;
    }
    public String companyAddress2 {
        get;
        set;
    }
    public String companyregion {
        get;
        set;
    }
    public String companypostcode {
        get;
        set;
    }
    public String companyCountry {
        get;
        set;
    }
    public String companyLocality {
        get;
        set;
    }
    public Boolean showprevious {
        get;
        set;
    }
    public String continueButtonText {
        get;
        set;
    }
    public Boolean custompanelView {
        get;
        set;
    }
    public Boolean standardPanelView {
        get;
        set;
    }
     
    public Date dateField {
        get;
        set;
    }

    public String previousButtonText {
        get;
        set;
    }
    public String showError {
        get;
        set;
    }
    public String headerText2 {
        get;
        set;
    }
 
    public String officerTerm {
        get;
        set;
    }
    
    public ReviewController() {
        super();
        h = new AccountsAPIHelper();
        if (isPageInitialised) initialiseStep();
    }

    public void initialiseStep() {
        if (submissionMgr.submission.Form_Name__c.contains('DS01')) {
            SecurityManager.createSessionValidityCookie(submissionMgr.submission.ContactEmail__c);
        }

        displayText1 = transactionMgr.currentStep.Display_Text_1__c == null ? '' : transactionMgr.currentStep.Display_Text_1__c;
        displayText2 = transactionMgr.currentStep.Display_Text_2__c == null ? '' : transactionMgr.currentStep.Display_Text_2__c;
        displayText3 = transactionMgr.currentStep.Display_Text_3__c == null ? '' : transactionMgr.currentStep.Display_Text_3__c;
        headerText1 = transactionMgr.currentStep.Header_Text_1__c == null ? '' : transactionMgr.currentStep.Header_Text_1__c;
        headerText2 = transactionMgr.currentStep.Header_Text_2__c == null ? '' : transactionMgr.currentStep.Header_Text_2__c;
        standardPanelView = transactionMgr.currentstep.StandardView__c;
        custompanelView = transactionMgr.currentstep.CustomView__c;
        companyName = submissionMgr.submission.CompanyName__c;
        headerText1 = headerText1.replace('COMPANYNAME', companyName);
        companyNumber = submissionMgr.submission.CompanyNumber__c;
        presenterEmail = submissionMgr.submission.Presenter__r.PersonEmail;
        presenterName = submissionMgr.submission.PresenterName__c;
        presenterPhone = submissionMgr.submission.PresenterPhoneNumber__c;
        continueButtonText = transactionMgr.currentStep.ContinueButtonText__c;
        previousButtonText = transactionMgr.currentStep.PreviousButtonText__c;
        companyDirectors = new List<Officer__c>();
        for (Officer__c off : submissionMgr.submission.Officers__r) {
            if (off.isSignatory__c) {
                companyDirectors.add(off);
            }
        }
        officerTerm = (submissionMgr.submission.officerTerminology__c == null ? '' : submissionMgr.submission.officerTerminology__c);
        companyAddress1 = submissionMgr.submission.CompanyAddress1__c;
        companyAddress2 = submissionMgr.submission.CompanyAddress2__c;
        companyregion = submissionMgr.submission.CompanyRegion__c;
        companypostcode = submissionMgr.submission.CompanyPostCode__c;
        companyCountry = submissionMgr.submission.CompanyCountry__c;
        companyLocality = submissionMgr.submission.CompanyLocality__c;
        companyAddress = (companyAddress1 == null ? '' : companyAddress1 + '<br/>') + (companyAddress2 == null ? '' : companyAddress2 + '<br/>') + (companyregion == null ? '' : companyregion + '<br/>') + (companyLocality == null ? '' : companyLocality + '<br/>') + (companypostcode == null ? '' : companypostcode + '<br/>') + (companyCountry == null ? '' : companyCountry);
        showprevious = true;
        dateField = submissionMgr.submission.ApplicationDate__c;
        
        if (submissionMgr.submission.Officers__r.size() > 1) {
            showprevious = true;
        }

        if (submissionMgr.submission.attachments != null) {
            if (submissionMgr.submission.attachments.size() > 0) {
                showDoc = true;
                attachmentId = submissionMgr.submission.attachments[0].Id;
                title = 'View the application';
                Integer sizeInt = submissionMgr.submission.attachments[0].BodyLength;
                String tempSize = String.valueOf(sizeInt);
                size = tempSize.left(3);
                //MB
                if (tempSize.length() >= 9) {
                    size += 'M';
                }
                //KB
                else if (tempSize.length() >= 6 && tempSize.length() < 9) {
                    size += 'K';
                }
            }
        } else {
            title = 'NA';
            size = 'NA';
            attachmentId = null;
        }
        todayThreeMonths = system.today().day() + '-' + system.today().addMonths(3).month() + '-' + system.today().year();
        return;
    }

    @testvisible
    private void parseQueryString() {
        // Expect a nonce on the query string under the param "state".
        nonce = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_NONCE);
        if (String.isBlank(nonce)) {

            // not authenticated so call authentication



        }
        authCode = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_AUTH_CODE);

    }

    @testvisible
    private void findCompanyAuthByNonce() {

            List < Company_Authorisation__c > companyAuthorisations = [select Id from Company_Authorisation__c where Nonce__c = : nonce];
            if (companyAuthorisations.size() == 1) {
                companyAuth = companyAuthorisations[0];
                return;
            }
        
    }

    public PageReference startReviewProcesses() {
        //Abuse of C param for User Auth 
        String cParamGeneral = '';
        if (Test.isRunningTest()) {
            system.debug('test is running now');
            nonce = 'testNonce';

        } else {

            parseQueryString();

            findCompanyAuthByNonce();
        }
        if(!ApexPages.currentPage().getCookies().containsKey('auth'))
        {
            if(submissionMgr != null)
            {
                if(submissionMgr.submission.SentreviewURL__c)
                {
                    securityMgr = new SecurityManager();

                    if(authCode == null)
                    {
                        //We need to get the parameter and inject it as a cookies
                        String cParam = ApexPages.currentPage().getParameters().get('c');
                        
                        Cookie cParamCookie = new Cookie('c', cParam, '', 480, true);

                        ApexPages.currentPage().setCookies(new Cookie[]{cParamCookie});

                        String hostname = ApexPages.currentPage().getHeaders().get('Host');
                        String redirectUrl = 'https://' + hostname + ApexPages.currentPage().getUrl().substringBefore('?');
                        System.debug(redirectUrl);
                        return securityMgr.getUserAuthRedirect(redirectUrl);
                    }

                    
                }
            }

            if(authCode != null)
            {
                if(!Test.isRunningTest())
                    accessTokenApiResponse = h.getAccessToken(authCode);

                if(!Test.isRunningTest())
                    userProfileApiResponse = h.getUserProfile(accessTokenApiResponse.access_token); //System.debug('profile is -- ' + userProfileApiResponse);        

                if (userProfileApiResponse != null) {

                    // TODO (User Auth)
                    // 1. Find the existing Presenter PersonAccount record by the user ID from the profile, if it exists.
                    // 2. Create one if not.
                    // 3. Put the forename, surname, email address on it.
                    // 4. Upsert it, possibly in a @Future, only after we're done calling out.
                    // 5. Update the user authorisation record, possibly in a @Future, only after we're done calling out.
                    // 6. Drop a cookie (user_auth) - value equal to the encrypted value of the User Auth record Id.
                    // 6. Redirect to the Company page (passing transaction type as 't' querystring parameter).
                    String userProfileName = userProfileApiResponse.email;
                    Map<String, String> PrivateBeta_Accesslist = new Map<String, String>();
                    //PrivateBeta_Accesslist.put('clarejady@hulljady.co.uk', 'Clare Jady');
                    //PrivateBeta_Accesslist.put('sophie@taxexpert.co.uk', 'Sophie Dickinson');
                    //PrivateBeta_Accesslist.put('catherine@mcmillanaccountants.com', 'Cathy Wolff');
                    //PrivateBeta_Accesslist.put('barneyq@cueandco.eu', 'Bernard Cue');
                    //PrivateBeta_Accesslist.put('esoussi@jordanstrustcompany.com', 'Evia Soussi');
                    //PrivateBeta_Accesslist.put('brenda.bardwell@morrisowen.com', 'Brenda Bardwell');
                    //PrivateBeta_Accesslist.put('fiona.sweeting@osborneclarke.com', 'Fiona Sweeting');
                    //PrivateBeta_Accesslist.put('karen.vickery@osborneclarke.com', 'Karen Vickery');
                    //PrivateBeta_Accesslist.put('ton.shaw@radius.com', 'Tom Shaw');
                    //PrivateBeta_Accesslist.put('ann.williams@carillionplc.com', 'Ann Williams');
                    //PrivateBeta_Accesslist.put('pevans@liffordhall.co.uk', 'Paul Evans');
                    //PrivateBeta_Accesslist.put('marks@luckmans.com', 'Mark Spafford');
                    //PrivateBeta_Accesslist.put('claireselman@ormerodrutter.co.uk', 'Claire Selman');
                    //PrivateBeta_Accesslist.put('wendy.wilkes@squirepb.com', 'Wendy Wilkes');
                    //PrivateBeta_Accesslist.put('lynette.bridgens@squirepb.com', 'Lynette Bridgens');
                    //PrivateBeta_Accesslist.put('sandram@amterson.com', 'Sandra Murphy');
                    //PrivateBeta_Accesslist.put('stewart.halton@argentsaccountants.co.uk', 'Stewart Halton');
                    //PrivateBeta_Accesslist.put('chris.stubbins@mapartners.co.uk', 'Chris Stubbins');
                    //PrivateBeta_Accesslist.put('fiona.bradford@mills-reeve.com', 'Fiona Bradford');
                    //PrivateBeta_Accesslist.put('rachel.collins@mills-reeve.com', 'Rachel Collins');
                    //PrivateBeta_Accesslist.put('julie.marquiss@externalservices.com', 'Julie Marquiss');
                    //PrivateBeta_Accesslist.put('sylvain.picory@methodsdigital.co.uk', 'Sylvain Picory');
                    //PrivateBeta_Accesslist.put('lbitoy@gmail.com', 'Leo Bitoy');
                    //PrivateBeta_Accesslist.put('@companieshouse.gov.uk','CH');
                    //PrivateBeta_Accesslist.put('@methodsdigital.co.uk','Methds');
                    //PrivateBeta_Accesslist.put('@methods.co.uk','Methods');
                    //PrivateBeta_Accesslist.put('01testdocu@gmail.com','STEST');
                    //PrivateBeta_Accesslist.put('ceri.counter@companyregistrations.co.uk','CHPRESENTERTESTER'); 
                    Boolean AccessGranted = PrivateBeta_Accesslist.containsKey(userProfileName);
                    Boolean chUser = PrivateBeta_Accesslist.containsKey('@'+userProfileName.subStringAfter('@'));
                    
                    if(Test.isRunningTest())   { 
                        If (AccessGranted == false && chUser == false) {
                            PageReference unauthorised = new PageReference('/unauthorized');
                            unauthorised.setRedirect(true);
                            return unauthorised;
                        }
                    }
                                                     

                    //Put back the c parameter from the cookies
                    Boolean containsCookie = ApexPages.currentPage().getCookies().containsKey('c');

                    if(containsCookie)
                    {
                        //Get the cookie
                        Cookie cParamCookie = ApexPages.currentPage().getCookies().get('c');   
                        String cParam = cParamCookie.getValue();
                        cParamGeneral = cParam;
                        ApexPages.currentPage().getParameters().put('c', cParam);
                    }
                    SecurityManager.createSessionValidityCookie(userProfileName);

                }   
            }

            if(!String.isEmpty(cParamGeneral))
            {
                securityMgr = new SecurityManager();
                // parse the query string and search for the company auth by the noncevalue
                // if null redirect to company search page for auth
                if (companyAuth == null) {


                    String cParam = cParamGeneral;

                    String paramValue = SecurityManager.decryptText(cParam);                    

                    // Submission state.
                    String submissionId = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[0];
                    List<Transaction__c> transac = [Select Id,Transaction_Type__c,Presenter__c,ContactEmail__c,Company__r.Id,Company__r.Name,Form_Name__c,Company__r.CompanyNumber__c, Status__c,Historical_Valid_Step_Ids__c,isDigitalSignatureNeeded__c,isSigningFinished__c From Transaction__c Where Id = :submissionId Limit 1];
                    if(transac.size() == 0)
                        return null;

                    Cookie cParamCookie = new Cookie('c', cParam, '', 480, true);

                    ApexPages.currentPage().setCookies(new Cookie[]{cParamCookie});

                    // need to check for company number/ parameters and if they don't exist then throw an error to show up on the docstatus page in apex messages
                    return securityMgr.getReviewStatusAuthRedirect(transac[0].Company__r.CompanyNumber__c, transac[0].Transaction_Type__c);
                    
                }
                if(companyAuth != null)
                {
                    //Put back the c parameter from the cookies
                    Boolean containsCookie = ApexPages.currentPage().getCookies().containsKey('c');

                    if(containsCookie)
                    {
                        //Get the cookie
                        Cookie cParamCookie = ApexPages.currentPage().getCookies().get('c');   
                        String cParam = cParamCookie.getValue();

                        ApexPages.currentPage().getParameters().put('c', cParam);

                        Cookie authOKCookie = new Cookie('auth', 'AuthOK', '', 7, true);


                        PageReference pg = new PageReference('/Review');
                        pg.getParameters().put('c', cParam);
                        pg.setCookies(new Cookie[]{authOKCookie});
                        pg.setRedirect(true);

                        return pg;

                    }
                }
            }
        }

        PageReference res = initialiseAction();

        if(res != null)
            return res;

        if (!submissionMgr.submission.Form_Name__c.contains('DS01')) {
            buildPDF();
        }

        return null;
    }
    public void buildPDF() {

        Attachment pdfAttachment = new Attachment();
        Blob pdfBlob;
        String pageName;
        pageName = submissionMgr.submission.Form_Name__c;
        if (submissionMgr.submission.Attachments.size() > 0) {
            try {
                Delete[Select id, name from Attachment where ParentId = :submissionMgr.submission.id and Name = :pageName + '.pdf'];
            } catch (DmlException e) {
                System.debug('DML Error in deleting' + pageName + 'Error Details are' + ' ' + e.getMessage());
            } catch (Exception e) {
                System.debug('General Error in deleting' + pageName + 'Error Details are' + ' ' + e.getMessage());
            }
        }
        PageReference pageRef = new PageReference('/apex/' + pageName);
        pageRef.getParameters().put('id', submissionMgr.submission.Id);
        if (Test.IsRunningTest()) pdfBlob = Blob.valueOf('This is a test');
        else pdfBlob = pageRef.getContent();
        pdfAttachment.ParentId = submissionMgr.submission.Id;
        pdfAttachment.Name = pageName + '.pdf';
        pdfAttachment.Description = pageName;
        pdfAttachment.Body = pdfBlob;
        try {
            insert pdfAttachment;
        } catch (DmlException e) {
            System.debug('DML Error in inserting' + pageName + 'Error Details are' + ' ' + e.getMessage());
        } catch (Exception e) {
            System.debug('General Error in inserting' + pageName + 'Error Details are' + ' ' + e.getMessage());
        }
    }

    
    private void persistStep() {

        submissionMgr.persist();

    }
    
    public PageReference nextAction() {
        submissionMgr.submission = [select Session_Log__c, PrePaymentIntegrationStatus__c, AmendmentHistory__c, SentreviewURL__c,isSignout__c,AccountAuthorisationCode__c ,shareChangeSelection__c, shareClassSelection__c, errors__c, errorsMessage__c, finishedPart1__c, finishedAttachments__c, prescribedParticular__c, selectShareType__c, Transaction_Type__c, CompanyType__c, Company__r.CompanyNumber__c, CompanyStatus__c, CompanyIncorporationDate__c, officerTerminology__c, isLtdPlc__c, isLP__c, submissionDate__c, submissionTime__c, paymentDate__c, containsPackage__c, Product_Code__c, paymentReference__c, isPaymentAccount__c, isPaymentCard__c, isPaymentPaypal__c, AccountNumber__c, hasPromoter__c, Version_Form__c, Presenter__r.PersonEmail, Company__c, Company__r.Name, Company__r.Id, ApplicationDate__c, trueTransactionName__c, isSigningFinished__c, isDigitalSignatureNeeded__c, isSigningStarted__c, sharecurrencyselection__c, Barcode__c, isBehalfSignatoryEnable__c, isPresenterMultipleDirectors__c, SoleDirectorPresenter__c, OfficerCount__c, hasPaid__c, isPaymentRequired__c, CompanyLocality__c, CompanyCountry__c, CompanyPostCode__c, CompanyRegion__c, CompanyAddress1__c, CompanyAddress2__c, Id, Form_Name__c, Presenter__c, ExpiryDate__c, Presenter__r.Name, isMajorityRequired__c, Expiry_Date_Length__c,
                                     PresenterName__c, PresenterPhoneNumber__c, RequiredOfficerSign__c, ContactEmail__c,
                                     MultipleDirectors__c, Name, Historical_Valid_Step_Ids__c, CompanyNumber__c, finishedAddingShares__c,
                                     Status__c, CompanyName__c, SubmissionId__c, Valid_Step_Ids__c, Amount__c, isLLP__c,
                                     (Select Id, Name, Email__c, DocusignName__c, hasInputBehalfDetails__c, isSignatoryBehalf__c, isPresenter__c, isSignatory__c, RecipientId__c,
                                      AuthorizedSigner__c, isPowerOfAttorney__c, isCorporateDirector__c
                                      From Officers__r),
                                     (SELECT Id, BodyLength, Description, Name FROM Attachments),
                                     (Select Id, Name, Email, DocusignName__c, hasInputBehalfDetails__c, isSignatoryBehalf__c, isPresenter__c, isSignatory__c, RecipientId__c,
                                      AuthorizedSigner__c,RecipientStatus__c, Title, Middlenames__c, FirstName, LastName, isPowerOfAttorney__c, isCorporateDirector__c
                                      From Contacts__r), (SELECT Name, dsfs__DocuSign_Envelope_ID__c, dsfs__Envelope_Link__c, dsfs__Envelope_Status__c, dsfs__Sender__c, dsfs__Sender_Email__c, dsfs__Subject__c FROM DocuSign_Status__r)
                                     from Transaction__c where Id = :submissionMgr.submission.Id];

        PageReference result = authenticatedSession();
        
        if(result != null)
            return result;
                                     
        submissionMgr.submission.SubmissionId__c =  'FE' + submissionMgr.submission.Id;
        if (submissionMgr.submission.Status__c == 'Signed' && submissionMgr.submission.Barcode__c == null) {
            if (Test.isRunningTest()) {
                system.debug('test is running now');


            } else {
                FormAPISubmissionManager submissionMgrAPI = new FormAPISubmissionManager();
                //Turned off at the moment waiting for the new API
                submissionMgr.submission = submissionMgrAPI.sendForm(submissionMgr.submission);

                submissionMgr.submission.AmendmentHistory__c += '<br/>-----------------------------------------------------------------------------------';
                submissionMgr.submission.AmendmentHistory__c += '<br/> Number Of Call static (Integration From Review Page): ' + FormsApiClient.numberOfTimeCalled;
                submissionMgr.submission.AmendmentHistory__c += '<br/>-----------------------------------------------------------------------------------';
            }
        }
        else
        {
            //Fix: We do want as there is a barcode overide the status to be submitted
            if(submissionMgr.submission.PrePaymentIntegrationStatus__c != 'Approved' || submissionMgr.submission.PrePaymentIntegrationStatus__c != 'Rejected' )
            {
                //In this case we have either the duplicatee barcode issue hence we want to proceed to the next page or
                //We just expired from previous session and in this case we didn't submit on success as the status aren't approved or reject
                //BUT we don't want the user to get an email when there is no barcode so we adjust the status to be on error
                //And the confirmation will redirect the user automatically to the error page as there is no barcode...
                if(submissionMgr.submission.Barcode__c != null)
                {
                    submissionMgr.submission.PrePaymentIntegrationStatus__c = AppConstants.REQUEST_STATUS_SUBMITTED;
                }
                else{
                    submissionMgr.submission.PrePaymentIntegrationStatus__c = AppConstants.REQUEST_STATUS_ERROR;
                    
                }   
            }
            persistStep();
            return nextStep();
        }

        system.debug('Before save tx: ' + submissionMgr.submission);
        if (Test.isRunningTest()) {
            system.debug('test is running now');

            // test error in test mode;
            submissionMgr.submission.PrePaymentIntegrationStatus__c = AppConstants.REQUEST_STATUS_ERROR;
        }
        submissionMgr.submission.AmendmentHistory__c += '<br/>-----------------------------------------------------------------------------------';
        submissionMgr.submission.AmendmentHistory__c += '<br/> Number Of Call static (Submit Page): ' + FormsApiClient.numberOfTimeCalled;
        submissionMgr.submission.AmendmentHistory__c += '<br/>-----------------------------------------------------------------------------------';
        persistStep();

        // if(!validatePageState() || submissionMgr.submission.Status__c == AppConstants.REQUEST_STATUS_ERROR)
        //   return Page.TransactionException;

        if (Test.isRunningTest()) {
            system.debug('test is running now');

        } else {
            return nextStep();
        }
        return null;
    }

    public PageReference resetTransaction() {
        //The framework has been decomissioned to now redirect to the company details page once you click the link start again

        if (submissionMgr.submission.Id != null) {
            //update the transaction first
            submissionMgr.submission.Status__c = 'deleteContact';
            //Save the transaction type
            String transactionType = submissionMgr.submission.Transaction_Type__c;
            Id presenterID = submissionMgr.submission.Presenter__c;
            String presenterEmail = submissionMgr.submission.ContactEmail__c;
            Account companyId = submissionMgr.submission.Company__r;
            update submissionMgr.submission;
            delete submissionMgr.submission;
            TransactionManager tr = new TransactionManager(transactionType);
            Id submissionId = submissionMgr.initialise(transactionType, presenterID, presenterEmail, companyId, tr.td);
            return tr == null ? null : tr.firstStep(submissionId);

        }

        return null;
    }
    public PageReference previousAction() {
        if (Test.IsRunningTest()) {
            system.debug('Test is running');

        } else {
            if (!validatePageState()) return Page.TransactionException;

            return previousStep();
        }
        return null;
    }
}