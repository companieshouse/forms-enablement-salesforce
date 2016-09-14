/*
Name:  DocumentController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller Class for Authenticated Attachment Downloads
======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Leo Bitoy    2016-05-19  Initial development.
*/
public with sharing class DocumentController {
    private static final String QUERY_STRING_PARAM_AUTH_CODE = 'code';

    @TestVisible private AccountsAPIHelper.Token accessTokenApiResponse;
    @TestVisible private AccountsAPIHelper.UserProfile userProfileApiResponse;

    @TestVisible private AccountsAPIHelper h {
        get;
        set;
    }

    public String authCode {get; set;}
    public String cookiestatus {
        get;
        set;
    }
    public String transactionType {
        get;
        set;
    }
    public String contactemail {
        get;
        set;
    }
    public String transactionID {
        get;
        set;
    }
    public String companyNumber {
        get;
        set;
    }
    public Transaction__c currenttransaction {
        get;
        set;
    }

    public Transaction__c tx {
        get;
        set;
    }
    public String title {
        get;
        private set;
    }
    public Id attachmentId {
        get;
        private set;
    }
    public String size {
        get;
        private set;
    }
    @testvisible
    private String nonce;

    @testvisible
    private Company_Authorisation__c companyAuth;
    private static final String QUERY_STRING_PARAM_NONCE = 'state';

    SecurityManager securityMgr;

    public with sharing class DocumentControllerCallbackException extends Exception
    {}

    public DocumentController() {
                h = new AccountsAPIHelper();

    }
    public PageReference initialiseController() {

        if (Test.isRunningTest()) {
            system.debug('test is running now');
            nonce = 'testNonce';

        } else {

            parseQueryString();

            findCompanyAuthByNonce();
        }

         securityMgr = new SecurityManager();

        if(authCode == null)
        {
            //We need to get the parameter and inject it as a cookies
            String cParam = ApexPages.currentPage().getParameters().get('documentdownload');

            Cookie cParamCookie = new Cookie('documentdownload', cParam, '', 480, true);

            ApexPages.currentPage().setCookies(new Cookie[]{cParamCookie});

            String hostname = ApexPages.currentPage().getHeaders().get('Host');
            String redirectUrl = 'https://' + hostname + ApexPages.currentPage().getUrl().substringBefore('?');
            System.debug(redirectUrl);
            return securityMgr.getUserAuthRedirect(redirectUrl);
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
                PrivateBeta_Accesslist.put('clarejady@hulljady.co.uk', 'Clare Jady');
                PrivateBeta_Accesslist.put('sophie@taxexpert.co.uk', 'Sophie Dickinson');
                PrivateBeta_Accesslist.put('catherine@mcmillanaccountants.com', 'Cathy Wolff');
                PrivateBeta_Accesslist.put('barneyq@cueandco.eu', 'Bernard Cue');
                PrivateBeta_Accesslist.put('esoussi@jordanstrustcompany.com', 'Evia Soussi');
                PrivateBeta_Accesslist.put('brenda.bardwell@morrisowen.com', 'Brenda Bardwell');
                PrivateBeta_Accesslist.put('fiona.sweeting@osborneclarke.com', 'Fiona Sweeting');
                PrivateBeta_Accesslist.put('karen.vickery@osborneclarke.com', 'Karen Vickery');
                PrivateBeta_Accesslist.put('ton.shaw@radius.com', 'Tom Shaw');
                PrivateBeta_Accesslist.put('ann.williams@carillionplc.com', 'Ann Williams');
                PrivateBeta_Accesslist.put('pevans@liffordhall.co.uk', 'Paul Evans');
                PrivateBeta_Accesslist.put('marks@luckmans.com', 'Mark Spafford');
                PrivateBeta_Accesslist.put('claireselman@ormerodrutter.co.uk', 'Claire Selman');
                PrivateBeta_Accesslist.put('wendy.wilkes@squirepb.com', 'Wendy Wilkes');
                PrivateBeta_Accesslist.put('lynette.bridgens@squirepb.com', 'Lynette Bridgens');
                PrivateBeta_Accesslist.put('sandram@amterson.com', 'Sandra Murphy');
                PrivateBeta_Accesslist.put('stewart.halton@argentsaccountants.co.uk', 'Stewart Halton');
                PrivateBeta_Accesslist.put('chris.stubbins@mapartners.co.uk', 'Chris Stubbins');
                PrivateBeta_Accesslist.put('fiona.bradford@mills-reeve.com', 'Fiona Bradford');
                PrivateBeta_Accesslist.put('rachel.collins@mills-reeve.com', 'Rachel Collins');
                PrivateBeta_Accesslist.put('julie.marquiss@externalservices.com', 'Julie Marquiss');
                PrivateBeta_Accesslist.put('sylvain.picory@methodsdigital.co.uk', 'Sylvain Picory');
                PrivateBeta_Accesslist.put('lbitoy@gmail.com', 'Leo Bitoy');
                PrivateBeta_Accesslist.put('@companieshouse.gov.uk','CH');
                PrivateBeta_Accesslist.put('@methodsdigital.co.uk','Methds');
                PrivateBeta_Accesslist.put('@methods.co.uk','Methods');
                PrivateBeta_Accesslist.put('01testdocu@gmail.com','STEST');
                PrivateBeta_Accesslist.put('ceri.counter@companyregistrations.co.uk','CHPRESENTERTESTER'); 
                Boolean AccessGranted = PrivateBeta_Accesslist.containsKey(userProfileName);
                Boolean chUser = PrivateBeta_Accesslist.containsKey('@'+userProfileName.subStringAfter('@'));
                If (AccessGranted == false && chUser == false) {
                    PageReference unauthorised = new PageReference('/unauthorized');
                    unauthorised.setRedirect(true);
                    return unauthorised;
                }

                //Put back the c parameter from the cookies
                Boolean containsCookie = ApexPages.currentPage().getCookies().containsKey('documentdownload');

                if(containsCookie)
                {
                    //Get the cookie
                    Cookie cParamCookie = ApexPages.currentPage().getCookies().get('documentdownload');   
                    String cParam = cParamCookie.getValue();

                    ApexPages.currentPage().getParameters().put('documentdownload', cParam);
                }
                SecurityManager.createSessionValidityCookie(userProfileName);

            }   
        }

        // parse the query string and search for the company auth by the noncevalue
        // if null redirect to company search page for auth
        if (companyAuth != null) {

            // get transaction and attachment and set vforcepage
            getDocumentDownloadTransaction();

            tx = currenttransaction;

            if (tx.attachments != null) {
                if (tx.attachments.size() > 0) {
                    //showDoc = true;
                    attachmentId = tx.attachments[0].Id;
                    title = tx.attachments[0].Name;
                    Integer sizeInt = tx.attachments[0].BodyLength;
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

            // clear cookies

            DestroyCookies();

            return null;

        } else {
            // set the cookiestatus and then redirect to companypage and call SecurityManager.getDownloadAuthRedirect();
            // to be sent back and captured in the above
            securityMgr = new SecurityManager();

            CreateDocumentDownloadCookies();
            system.debug('transactiontype= ' + transactionType + 'company number=' + companyNumber);

            if (Test.isRunningTest()) {
                system.debug('test is running now');

                Company_Authorisation__c testAuth = new Company_Authorisation__c();

                companyAuth = testAuth;
                return initialiseController();

            } else {
                return securityMgr.getDownloadAuthRedirect(companyNumber, transactionType);
            }
            // company page search redirect
            /*
            PageReference pr = new PageReference('/Company');
            pr.getParameters().put('t', transactionType);
            return pr;
            */
        }
    }

    public String CreateDocumentDownloadCookies() {

        String dvalueparameter = ApexPages.currentPage().getParameters().get('documentdownload');
        //throw new Form_CustomException(' d value param is ' + '  ' + dvalueparameter);

        if (dvalueparameter.contains(' ')) {
            dvalueparameter = dvalueparameter.replace(' ', '+');
        }

        String paramValue = SecurityManager.decryptText(dvalueparameter);

        transactionType = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[0];

        contactemail = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[1];

        transactionID = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[2];

        companyNumber = paramValue.split(AppConstants.ID_DELIM_SPLIT_CHAR)[3];

        cookiestatus = 'setauth';

        Cookie d_valueTType = new Cookie('d_valueTType', SecurityManager.encryptText(transactionType), null, -1, true);

        Cookie d_valueEmail = new Cookie('d_valueEmail', SecurityManager.encryptText(contactemail), null, -1, true);

        Cookie d_valueId = new Cookie('d_valueId', SecurityManager.encryptText(transactionID), null, -1, true);

        Cookie d_valueCookieStatus = new Cookie('d_valueCookieStatus', SecurityManager.encryptText(cookiestatus), null, -1, true);

        ApexPages.currentPage().setCookies(new Cookie[] {
                                               d_valueTType,
                                               d_valueEmail,
                                               d_valueId,
                                               d_valueCookieStatus
                                           });

        return null;
    }

    public sObject getDocumentDownloadTransaction() {

        Cookie a = ApexPages.currentPage().getCookies().get('d_valueTType');

        Cookie b = ApexPages.currentPage().getCookies().get('d_valueEmail');

        Cookie c = ApexPages.currentPage().getCookies().get('d_valueId');

        transactiontype = SecurityManager.decryptText(a.getValue());

        contactemail = SecurityManager.decryptText(b.getValue());

        transactionID = SecurityManager.decryptText(c.getValue());

        List < Transaction__c > recs = [select Id, Form_Name__c, Presenter__c, Presenter__r.Name, isMajorityRequired__c, PresenterName__c, PresenterPhoneNumber__c, RequiredOfficerSign__c, ContactEmail__c, MultipleDirectors__c, Name, Historical_Valid_Step_Ids__c, CompanyNumber__c, Status__c, CompanyName__c, SubmissionId__c, Amount__c, (SELECT Id, BodyLength, Name FROM Attachments), (Select Id, Name, Email__c, isPresenter__c, isSignatory__c From Officers__r) from Transaction__c where Id = : transactionID];
        if (recs.size() == 1) currenttransaction = recs[0];


        return currenttransaction;
    }

    public String DestroyCookies() {

        Cookie d_valueTType = new Cookie('d_valueTType', 'empty', null, 0, true);

        Cookie d_valueEmail = new Cookie('d_valueEmail', 'empty', null, 0, true);

        Cookie d_valueId = new Cookie('d_valueId', 'empty', null, 0, true);

        return null;
    }
    @testvisible
    private void parseQueryString() {
        // Expect a nonce on the query string under the param "state".
        nonce = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_NONCE);
        if (String.isBlank(nonce)) {

            // not authenticated so call authentication



        }
        authCode = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_AUTH_CODE);

        //throw new DocumentControllerCallbackException('A ' + QUERY_STRING_PARAM_NONCE + ' parameter is required.'); }
    }
    @testvisible
    private void findCompanyAuthByNonce() {
        try {

            List < Company_Authorisation__c > companyAuthorisations = [select Id from Company_Authorisation__c where Nonce__c = : nonce];
            if (companyAuthorisations.size() == 1) {
                companyAuth = companyAuthorisations[0];
                return;
            }
        } catch (QueryException e) {
            throw new DocumentControllerCallbackException('Invalid state ' + nonce);
        }
    }
}