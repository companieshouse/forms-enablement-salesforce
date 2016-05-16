public with sharing class CompanySearchPage {


    private Access_Token__c accessToken {
        get;
        set;
    }
    private AccountApiClient accountApiClient {
        get;
        set;
    }
    public String userAuthUrl {
        get;
        private set;
    }
    public String companyAuthUrl {
        get;
        private set;
    }
    private String nonce;

    public String hardcodedsearch {
        get;
        set;
    }
    public String dynamiccodesearch {
        get;
        set;
    }
    public Integer len {
        get;
        set;
    }

     public class CompanySearchPageException extends Exception {

    }

    public AccountApiClient.UserProfile userProfileApiResponse;

    /*
    public CH_USER_Profile__c currentUserData { set; }

    public CH_USER_Profile__c getcurrentUserData() {

        CH_USER_Profile__c currentUserData = new CH_USER_Profile__c();

        // create currentUserData object and set CH data to this object for verification

        currentUserData.forename__c = userProfileApiResponse.forename;
        currentUserData.chprofileid__c = userProfileApiResponse.id;
        currentUserData.surname__c = userProfileApiResponse.surname;
        currentUserData.email__c = userProfileApiResponse.email;

        return currentUserData;
    }
*/


    public PageReference init() {

        hardcodedsearch = '05448736';

        nonce = accountApiClient.getNonce();
// warning test ///
        //companyAuthUrl = accountApiClient.getCompanyAuthUrl(nonce, dynamiccodesearch);


        userAuthUrl = accountApiClient.getUserAuthUrl(nonce);
        accountApiClient = new AccountApiClient();


        Access_Token__c accessToken = new Access_Token__c();
        //  Nonce__c = nonce
        // System.debug('start controller nonce is ' + nonce);

        accessToken.Nonce__c = nonce;

        try {
            insert accessToken;
        } catch (QueryException e) {

            throw new CompanySearchPageException('DML exception at ' + e);

        }


        System.debug('token is ' + accessToken);
        // New approach:
        Session__c s = Session.get(true);
        s.Nonce__c = nonce;
        try {

            update s;
        } catch (QueryException e) {

            throw new CompanySearchPageException('DML exception at ' + e);

        }
        // purely for verification responses
       // userProfileApiResponse = accountApiClient.getUserProfile(accessToken.Access_Token__c);



        return null;
    }

    public CompanySearchPage() {

        accountApiClient = new AccountApiClient();
    }

    public PageReference SearchCompany() {

        System.Debug('value is ' + dynamiccodesearch);

        if (dynamiccodesearch != null) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Must be 8 Characters');
        }

        System.debug('len is ' + len);

        Integer len = dynamiccodesearch.length();

        System.debug('length is ' + len);

        if (len != 8) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Must be 8 Characters');
        }


        System.Debug('query string is =' + dynamiccodesearch);

        //nonce = accountApiClient.getNonce();
        userAuthUrl = accountApiClient.getUserAuthUrl(nonce);
        companyAuthUrl = accountApiClient.getCompanyAuthUrl(nonce, dynamiccodesearch);

            CH_USER_Profile__c[] userexistslist = [SELECT Id, profileconfirmed__c, companysearched__c, company_found__c, surname__c, forename__c, email__c, chprofileid__c FROM CH_USER_Profile__c LIMIT 1];
            // if the user doesn't exist in SFDC we will insert the current user data
            //CH_USER_Profile__c currentUserData = new CH_USER_Profile__c();
            // if the user exists update the record
            // if the user doesn't exist in SFDC insert and move along
            if (userexistslist.size() > 0) {
                System.debug('user exist is =' + userexistslist[0]);
                // tracking state - in future will be an encrypted cookie
                // find the current user/ update with the company searched and found
                // set value and pass to transactions
                // delete after transactions to track future progress
               //if (userexistslist[0].company_found__c != null)
                //{
                userexistslist[0].profileconfirmed__c = true;
                userexistslist[0].company_found__c = dynamiccodesearch;
                userexistslist[0].companysearched__c = true;
                System.debug('user does exist returned' + userexistslist[0]);
                update userexistslist[0];
                //}
            } 

        ///////////////////////////////

        /////////////////////////////

        System.Debug('nonce =' + nonce);
        System.Debug('user auth url =' + userAuthUrl);
        System.Debug('company auth url=' + companyAuthUrl);

        PageReference foundcompanypage = new PageReference(companyAuthUrl);
        foundcompanypage.setRedirect(true);


        return foundcompanypage;
    }
}