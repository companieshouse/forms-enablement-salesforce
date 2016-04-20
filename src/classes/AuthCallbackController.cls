/**
 * Handles the redirect back to us from account.companieshouse.gov.uk following a
 * successful login there.
 * 
 * Author: eliot.stock@methodsdigitial.co.uk
 */
public class AuthCallbackController {

    private static final String QUERY_STRING_PARAM_NONCE = 'state';

    private static final String QUERY_STRING_PARAM_AUTH_CODE = 'code';

    private String nonce;
    private String authCode;
    private String authtype;
    private String companyStatus;

    private AccountApiClient.Token accessTokenApiResponse;
    //made public and cast into current user
    public AccountApiClient.UserProfile userProfileApiResponse;

    // private Access_Token__c accessToken;
    // private AccountApiClient accountApiClient;
    private Access_Token__c accessToken {
        get;
        set;
    }
    private AccountApiClient accountApiClient {
        get;
        set;
    }

    // vforce vars
    // ch user profile for verification
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

    /* public CH_USER_Profile__c setcurrentUserData() {

     CH_USER_Profile__c currentUserData = new CH_USER_Profile__c();

         currentUserData = value;

         return currentUserData;
     }
     */
    //ch identifier
    public String chIDverfier;
    public String chEmailverfier;

    // Required, since Apex code can't throw the standard Exception class.
    public class AuthCallbackException extends Exception {

    }

    public AuthCallbackController() {
        accountApiClient = new AccountApiClient();
    }

    public PageReference SaveCurrentUserData() {

        // redirect after save
        // set redirecturl to warning page
        String companysearchURL = '/apex/CompanySearchPage';
        PageReference companysearchpage = new PageReference(companysearchURL);
        companysearchpage.setRedirect(true);
        // try saving the data
        try {

            this.updateProfile();

            // update currentUserData;

        } catch (System.DMLException e) {

            ApexPages.addMessages(e);

            return null;
        }


        return companysearchpage;
    }

    public CH_USER_Profile__c CheckCurrentUserData() {

        try {
            // set search string using profile email - which should be unique
            string userexistsemail = userProfileApiResponse.email;
            //CH_USER_Profile__c userexists = new CH_USER_Profile__c();
            // get list of existing users with same email
            //  pass current user data to [0] of list
            CH_USER_Profile__c[] userexistslist = [SELECT Id, profileconfirmed__c, companysearched__c, company_found__c, surname__c, forename__c, email__c, chprofileid__c FROM CH_USER_Profile__c WHERE email__c = : userexistsemail LIMIT 1];
            // if the user doesn't exist in SFDC we will insert the current user data
            CH_USER_Profile__c currentUserData = new CH_USER_Profile__c();
            // if the user exists update the record
            // if the user doesn't exist in SFDC insert and move along
            if (userexistslist.size() > 0) {
                System.debug('user exist is =' + userexistslist[0]);
                System.debug('user current is =' + currentUserData);

            if (userexistslist[0].companysearched__c ){
                userexistslist[0].email__c = userProfileApiResponse.email;
                userexistslist[0].surname__c = userProfileApiResponse.surname;
                userexistslist[0].forename__c = userProfileApiResponse.forename;
                userexistslist[0].chprofileid__c = userProfileApiResponse.id;
                userexistslist[0].profileconfirmed__c = true;
                System.debug('user does exist returned' + userexistslist[0]);
                update userexistslist[0];
                } else {
                    goToWarningPage();

                }
            } else {
                currentUserData.email__c = userProfileApiResponse.email;
                currentUserData.surname__c = userProfileApiResponse.surname;
                currentUserData.forename__c = userProfileApiResponse.forename;
                currentUserData.chprofileid__c = userProfileApiResponse.id;
                currentUserData.profileconfirmed__c = true; 
                System.debug('user doesnt exist so new user email =' + currentUserData.email__c);

                upsert currentUserData;
            }
             return null; // currentUserData; 
        } catch (JSONException e) {
            throw new AuthCallbackException('Not a JSON response:' + e);

        } catch (DmlException e) {

            throw new AuthCallbackException('DML ERROR:' + e);

            // DmlException handling code here.

        }
    }

    public void updateProfile() {
        string userexistsemail = userProfileApiResponse.email;

        CH_USER_Profile__c[] currentUserData = [SELECT Id, profileconfirmed__c, companysearched__c, company_found__c,  surname__c, forename__c, email__c, chprofileid__c FROM CH_USER_Profile__c WHERE email__c = :userexistsemail LIMIT 1];


        update currentUserData[0];
    }

    // if there is a user profile already stored verify
    // if not map fields from oauth response from CH and then verifiy.

    public CH_USER_Profile__c getcurrentUserProfile(CH_USER_Profile__c currentUser) { // String chIDverfier, CH_USER_Profile__c currentUser
        /*
            chIDverfier = userProfileApiResponse.id;
            // public CH_USER_Profile__c  currentUser;
        if (currentUser == null || currentUser.Id == null){
         try {
          currentUser = [SELECT Id, surname__c, forename__c, email__c FROM CH_USER_Profile__c WHERE chprofileid__c = :chIDverfier];
        }
        catch (QueryException e) {
            throw new AuthCallbackException('Invalid ID ' + chIDverfier + 'or User does not exist');
        }
        }
         else
        {
            */
        userProfileApiResponse = accountApiClient.getUserProfile(accessToken.Access_Token__c);


        currentUser.surname__c = userProfileApiResponse.surname;
        currentUser.email__c = userProfileApiResponse.email;

        //  }   
        System.debug(currentUser + 'this is the get current user profile');
        return currentUser;
    }

    public PageReference init() {
       // if(companyStatus != null) 
       // accesstoken.userfoudn = true;
       // update accesstoken;
       // user status

       // accesstoken.companyfound = true;
        parseQueryString();

       // System.debug('first nonce is ' + nonce);
        // TODO: Move the nonce from the access token to the session. It doesn't really belong on
        // the access token object.
        findAccessTokenByNonce();

         String authtype = 'warning';
        System.debug('authcode=' + authCode);
        // Call out to account.companieshouse.gov.uk to swap our auth code for an access token.
        accessTokenApiResponse = accountApiClient.getAccessToken(authCode); // ,authtype

        System.debug('token response method =' + accessTokenApiResponse);

        System.debug('accesstokenresponse=' + accessTokenApiResponse);
        // TODO: Once we have working credentials, set fields from the API response on the Access
        // Token record. Careful about DML before calling out.
        accessToken.Access_Token__c = accessTokenApiResponse.access_token;
        accessToken.Refresh_Token__c = accessTokenApiResponse.refresh_token;
        System.Debug('access token is' + accessToken.Access_Token__c);
        System.Debug('refresh token is' + accessToken.Refresh_Token__c);
        //accessToken.Nonce__c = nonce;

        // The API gives us a number of seconds until the access token expires. We should
        // store that as a datetime in the future, on the access token record.
        Datetime now = Datetime.newInstance(System.currentTimeMillis());
        Datetime expires = now.addSeconds(600); // TODO: Use value from API response.
        accessToken.Expires__c = expires;

        // Call out again to get the user profile using the access token.
        userProfileApiResponse = accountApiClient.getUserProfile(accessToken.Access_Token__c);

        //System.Debug('profile is'+ ' ' + userProfileApiResponse);
        //System.Debug('email is'+ ' ' + userProfileApiResponse.email);

        chEmailverfier = userProfileApiResponse.email;
        // System.debug('email = ' + userProfileApiResponse.email);

        // check current user data and upsert it into sfdc before you update it manually just to make sure data is there
        CheckCurrentUserData();

        CH_USER_Profile__c[] userredirect = [SELECT Id, profileconfirmed__c, companysearched__c, company_found__c, surname__c, forename__c, email__c, chprofileid__c FROM CH_USER_Profile__c LIMIT 1];

        System.debug('found company = ' + userredirect[0].company_found__c);
        if(userredirect[0].companysearched__c)
        {
            System.debug('redirect is called');

             //   goToWarningPage();

             String hostname = ApexPages.currentPage().getHeaders().get('Host');
        String warningURL = 'https://' + hostname + '/apex/Form_DS0Page0' + '?companynumber=' + userredirect[0].company_found__c + '&useremail=' +userredirect[0].email__c;

        PageReference warningpage = new PageReference(warningURL);
                System.debug('redirect is = ' + warningURL);

        warningpage.setRedirect(true);

        return warningpage;
        }

        else {
        // CheckCurrentUserStatus();
        //tracks user position throughout process for demo purposes this acts like a cookie
        // to track the user position for userprofile and company searched and then switch to 
        // warning paget regarding the transaction/docusign/payment portions of the journey

        // TODO:
        // 1. Find the existing Presenter record by the user ID from the profile, if it exists.
        // 2. Create one if not.
        // 3. Put the forename, surname, email address on it.
        // 4. Upsert it, possibly in a @Future, only after we're done calling out.
        // 5. Update the access token, possibly in a @Future, only after we're done calling out.
        // 6. Redirect to whereever the user was originally going. Store that as an intent URL
        // in the session.

        //upsert accessToken;

        return null;
    }
    }



    private void parseQueryString() {
        // Expect a nonce on the query string under the param "state".
        nonce = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_NONCE);
            System.debug('The real nonce is ' + nonce);
        if (nonce == null || nonce.length() == 0) {
            throw new AuthCallbackException('A ' + QUERY_STRING_PARAM_NONCE + ' parameter is required.');
        }

        authCode = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_AUTH_CODE);

        if (authCode == null || authCode.length() == 0) {
            throw new AuthCallbackException('A ' + QUERY_STRING_PARAM_AUTH_CODE + ' parameter is required.');
        }
    }


    private void findAccessTokenByNonce() {
                System.debug('found nonce = ' + nonce);

         try {
        accessToken = [SELECT Id FROM Access_Token__c WHERE Nonce__c = :nonce];
         } catch (QueryException e) {
           throw new AuthCallbackException('Invalid state ' + e + 'and the nonce is' + nonce);
        }
    }


    public PageReference goToWarningPage() {

        String hostname = ApexPages.currentPage().getHeaders().get('Host');
        String warningURL = 'https://' + hostname + '/apex/Start';

        PageReference warningpage = new PageReference(warningURL);
                System.debug('redirect is = ' + warningURL);

        warningpage.setRedirect(true);

        return warningpage;

    }

}