/*
Name:  AccountsAuthCallbackController.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Controller class for the AccountsAuthCallback page

Encapsulates : handles OAuth callbacks for Company and User.

Note - refresh tokens are not used. 
The access token provides a short-lived window of trust after 
which the user must reauthenticate.

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-04-09  Initial conversion of Eliot Stock code.
*/
public with sharing class AccountsAuthCallbackController {

    // Private class members.
    private static final String QUERY_STRING_PARAM_NONCE = 'state';
    private static final String QUERY_STRING_PARAM_AUTH_CODE = 'code';

    private String nonce;
    private String authCode;

    private AccountsAPIHelper.Token accessTokenApiResponse;
    private AccountsAPIHelper.UserProfile userProfileApiResponse;

    private User_Authorisation__c userAuth;
    private Company_Authorisation__c companyAuth;

    Sobject presenterInfo;
    String transactionType;
    Id presenterID;
    String presenterEmail;
    Sobject companyNumberId;

    public AppConstants constants;

    private AccountsAPIHelper h {
        get;
        set;
    }

    private TrackUserClass u {
        get;
        set;
    }

    private SubmissionManager submissionMgr {
        get;
        set;
    }

    private TransactionManager transactionMgr {
        get;
        set;
    }

    public class AccountsAuthCallbackException extends Exception {}

    // Constructors.
    public AccountsAuthCallbackController() {

            h = new AccountsAPIHelper();

            u = new TrackUserClass();

            submissionMgr = new SubmissionManager();

        }
        // End Constructors.

    // Instance methods.
    public PageReference initialiseAction() {

        //return null;

        parseQueryString();

        findUserAuthByNonce();

        findCompanyAuthByNonce();

        // is working // System.debug('authcode is -- ' + authCode);
        // is working //
        System.debug('user auth is ' + userAuth);
        System.debug('company auth is ' + companyAuth);

        // Call out to account.companieshouse.gov.uk to swap our auth code for an access token.
        System.debug('authcode should b e ' + authcode);

        
        accessTokenApiResponse = h.getAccessToken(authCode);

        System.debug('api response is ' + accessTokenApiResponse);

        //System.debug('access token is  ' + accessTokenApiResponse);
        // Call out again to get the user profile using the access token. If the authorisation was for a user.
        if (userAuth != null)
            userProfileApiResponse = h.getUserProfile(accessTokenApiResponse.access_token); //System.debug('profile is -- ' + userProfileApiResponse);
        // need better error handling/redirection on failure to pull profile/token

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
            Boolean AccessGranted = PrivateBeta_Accesslist.containsKey(userProfileName);
            Boolean chUser = PrivateBeta_Accesslist.containsKey('@'+userProfileName.subStringAfter('@'));
            If (AccessGranted == false && chUser == false) {
                return CallPageRedirect();
            }


            

            System.debug(LoggingLevel.ERROR,'Cookies Saving:' + userProfileName);
            u.getCurrentUser(userProfileName); ///=> useless code as there is no usage of the return... setting the cookies...
            // throw new AccountsAuthCallbackException('presenter info' + userProfileName);
            /*        public String surname;
        public String forename;
        public String email;
        public String id;
        public String locale;*/
            RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Person Account' and SObjectType = 'Account'];
            
            Account newPersonAccount = new Account();
            newPersonAccount.userIDChips__c = userProfileApiResponse.id;
            newPersonAccount.PersonEmail = userProfileApiResponse.email;
            newPersonAccount.FirstName = (userProfileApiResponse.forename== null ? '' :userProfileApiResponse.forename );
            newPersonAccount.LastName = userProfileApiResponse.id;//userProfileApiResponse.surname; 
            newPersonAccount.RecordType = personAccountRecordType;
            
            Schema.SObjectField f = Account.Fields.userIDChips__c;
            Database.UpsertResult cr = Database.upsert(newPersonAccount,f,false);


            transactionType = u.getUserDocument();

            System.debug('transaction type is ' + transactionType);
            String hostname = ApexPages.currentPage().getHeaders().get('Host');
            String startjourneyURL = 'https://' + hostname + '/company?t=' + transactionType;
            PageReference startjourney = new PageReference(startjourneyURL);
            System.debug('redirect is = ' + startjourney);
            // redirect to the framework once userprofile is given
            // note this presenter information is minimal (e.g. locale, email address, etc.)
            // will only drop a cookie with the profile information and access token 
            startjourney.setRedirect(true);

            return startjourney;
        }

        if (userAuth == null && companyAuth != null) {

            // insert account here

            // List<Accounts> userAccounts = [select Id from Accounts where Account.name=:userEmail];

            System.debug('you have entered the company auth code redirect and here is the authcode' + companyAuth);

            //  insert submission record

            //pass a submission ID and a Step ID
            //
            transactionType = u.getUserDocument();

            transactionMgr = new TransactionManager(transactionType);


            presenterInfo = u.returnCurrentUser();

            //throw new AccountsAuthCallbackException('presenter info' + presenterInfo);
            // todo error here check it out

            presenterID = presenterInfo.Id; // will get from cookie

            presenterEmail = String.valueof(presenterInfo.get('PersonEmail')); //presenterInfo.Name;

            companyNumberId = u.returnCurrentCompanyObject(); //will get from cookie


            Id submissionId = submissionMgr.initialise(transactionType, presenterID, presenterEmail, companyNumberId, transactionMgr.td);
            System.debug('submission  is  ' + submissionMgr.submission);
            System.debug('transactiontype  is  ' + transactionType);
            System.debug('presenterID  is  ' + presenterID);
            System.debug('presenterEmail  is  ' + presenterEmail);
            System.debug('companyNumberId  is  ' + companyNumberId);
            System.debug('transactionMgr.td  is  ' + transactionMgr.td);

            if (submissionMgr.submission.Valid_Step_Ids__c != null)
            {

                String split = submissionMgr.submission.Valid_Step_Ids__c;

                String[] res = split.split(AppConstants.ID_DELIM_SPLIT_CHAR);
                System.debug('split  ' + split);
                System.debug('res  ' + res);

                TransactionManager t = new TransactionManager((Id)res[res.size() - 1]);

                return t.getCurrentStep(submissionId);
            } else {
                return transactionMgr == null ? null : transactionMgr.firstStep(submissionId);

            }
            //PageReference transactioninformation =  TransactionManager.firstStep(submissionId); // firstStep(submissionId);
            // System.debug('transaction information ' + transactioninformation);
            //PageReference pr = getNextStepPageReference(0,submissionId);

            //return pr;

        }
        // TODO (Company Auth)
        // 1. Find the existing Company Account record by the company number, if it exists.
        // 2. Create one if not.
        // 3. Put the company name on it (from where?)
        // 4. Upsert it, possibly in a @Future, only after we're done calling out.
        // 5. Update the company authorisation record, possibly in a @Future, only after we're done calling out.
        // 6. Drop a cookie (company_auth) - value equal to the encrypted value of the Company Auth record Id.
        // 7. Create a Submission record for the user/company/transaction type if required
        // 8. Drop a cookie (submission) - value equal to the encrypted value of the Transaction_Submission__c record Id.
        // 9. Redirect to the first step for the transaction type as held on the company auth record (using encrypted 'c' querystring parameter).

        return null;
    }

    Public PageReference CallPageRedirect() {
        PageReference unauthorised = new PageReference('/unauthorized');
        unauthorised.setRedirect(true);
        return unauthorised;
    }

    private void parseQueryString() {
        // Expect a nonce on the query string under the param "state".
        nonce = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_NONCE);
        if (String.isBlank(nonce)) {
            throw new AccountsAuthCallbackException('A ' + QUERY_STRING_PARAM_NONCE + ' parameter is required.');
        }

        authCode = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_AUTH_CODE);
        if (String.isBlank(authCode)) {
            throw new AccountsAuthCallbackException('A ' + QUERY_STRING_PARAM_AUTH_CODE + ' parameter is required.');
        }
    }

    private void findUserAuthByNonce() {
        try {

            List < User_Authorisation__c > userAuthorisations = [select Id from User_Authorisation__c where Nonce__c = : nonce];
            if (userAuthorisations.size() == 1) {
                userAuth = userAuthorisations[0];

                return;
            }

        } catch (QueryException e) {
            throw new AccountsAuthCallbackException('Invalid state ' + nonce);
        }
    }

    private void findCompanyAuthByNonce() {
        try {

            List < Company_Authorisation__c > companyAuthorisations = [select Id from Company_Authorisation__c where Nonce__c = : nonce];
            if (companyAuthorisations.size() == 1) {
                companyAuth = companyAuthorisations[0];
                return;
            }
        } catch (QueryException e) {
            throw new AccountsAuthCallbackException('Invalid state ' + nonce);
        }
    }




    // End Instance methods.
}