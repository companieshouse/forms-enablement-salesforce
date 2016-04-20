/**
 * May well end up being a short term thing.
 * 
 * Author: eliot.stock@methods.co.uk
 */
public class StartController {

    public String userAuthUrl {
        get;
        private set;
    }
    public String companyAuthUrl {
        get;
        private set;
    }
    public String expectedRedirectUrl {
        get;
        private set;
    }
    public String sessionCounter {
        get;
        private set;
    }
    public Boolean userAuthenticated {
        get;
        private set;
    }

    public class StartException extends Exception {

    }

    private AccountApiClient accountApiClient;
    private String nonce;

    public StartController() {
        accountApiClient = new AccountApiClient();
    }

    public PageReference init() {
        // Experimentation with cookie handling on Sites.
        /*
        Cookie sessionCookie = ApexPages.currentPage().getCookies().get('session');

        if (sessionCookie == null) {
            sessionCookie = new Cookie('session', // name
                    '1',    // value
                    null,   // path
                    -1,     // maxAge
                    false); // isSecure
        }
        else {
            // If this isn't the first time the user is accessing the page
            // create a new cookie, incrementing the value of the original count by 1
            Integer count = Integer.valueOf(sessionCookie.getValue());
            sessionCookie = new Cookie('session', String.valueOf(count+1),null,-1,false);
            sessionCookie = new Cookie('session', // name
                    String.valueOf(count + 1),    // value
                    null,                         // path
                    -1,                           // maxAge
                    false);                       // isSecure
        }
        
        List<Cookie> cookies = new List<Cookie>();
        cookies.add(sessionCookie);
        ApexPages.currentPage().setCookies(cookies);
        
        sessionCounter = sessionCookie.getValue();
        */

        nonce = accountApiClient.getNonce();
        System.debug('start controller nonce = ' + nonce);
        userAuthUrl = accountApiClient.getUserAuthUrl(nonce);
        companyAuthUrl = accountApiClient.getCompanyAuthUrl(nonce, '08906750');

        // LB    hardocoded value - perhaps we can pull from api custom settings for the ?code, etc. with Account_Api_Settings__c customsettings = getSettings();
        // LB then set customsettings.Client_Id as value as these may be subject to changes in the future
        expectedRedirectUrl = accountApiClient.getRedirectUrl() + '?code=dNVI1yHNhIx32YfRx4EMzeru7kT9NFTnQ54MABxZ&state=' + nonce;

        //  LB expectedRedirectUrl = accountApiClient.getRedirectUrl() + '?code=' + customsettings.Client_Id +'&state=' + nonce;

        // Before we can redirect to the auth URL, we need to store a nonce. On the
        // redirect back to us, we're going to check this exists.
        // TODO: Coming this far and not completing auth will leave an access token
        // record with just the nonce on it in the database. Clean up old access
        // tokens in a scheduled job.
        // Old approach:

        Access_Token__c accessToken = new Access_Token__c();
        //  Nonce__c = nonce
       // System.debug('start controller nonce is ' + nonce);

        accessToken.Nonce__c = nonce;

        try {
            insert accessToken;
        } catch (QueryException e) {

            throw new StartException('DML exception at ' + e);

        }


        System.debug('token is ' + accessToken);
        // New approach:
        Session__c s = Session.get(true);
        s.Nonce__c = nonce;
        try {

            update s;
        } catch (QueryException e) {

            throw new StartException('DML exception at ' + e);

        }


        userAuthenticated = Session.isUserAuthenticated();

        return null;
    }

}