/**
 * Work in progress! Can't be tested very well until we have some of the OAuth2 flow working.
 * 
 * Author: eliot.stock@methods.digital.co.uk.
 */
public class Session {
    
    private static final String SESSION_COOKIE_NAME = 'ch_session';
    
    /**
     * Behaviour modelled on that of a J2EE servlet engine.
     */
    public static Session__c get(Boolean create) {
        Cookie sessionCookie = ApexPages.currentPage().getCookies().get(SESSION_COOKIE_NAME);
        
        if (sessionCookie == null || sessionCookie.getValue() == null) {
            if (create) {
				Session__c session = create();
                return session;
            }
            else {
	            return null;                
            }
        }
        
        try {
	        Session__c session = [SELECT Access_Token__c FROM Session__c WHERE Id = :sessionCookie.getValue()];
            return session;
        }
        catch (QueryException e) {
            if (create) {
				Session__c session = create();
                return session;
            }
            else {
	            return null;                
            }
        }
    }
    
    public static Boolean isUserAuthenticated() {
		Session__c session = get(false);
        
        if (session == null) {
            return false;
        }
        
        // Check whether an access token exists for this session.
        Access_Token__c token = null;
        
        try {
            token = [SELECT Expires__c FROM Access_Token__c WHERE Id = :session.Access_Token__c];
        }
        catch (QueryException e) {
            return false;
        }
        
        // Check whether access token has expired yet.
        if (token.Expires__c < Datetime.now()) {
            return false;
        }
        
        return true;
    }
    
    public static Boolean isCompanyAuthenticated(String companyNumber) {
        // TODO
        return false;
    }
    
    private static Session__c create() {
        Session__c session = new Session__c();
        insert session;
        
        Cookie sessionCookie = new Cookie(SESSION_COOKIE_NAME, // name
                                   session.Id,    // value
                                   null,          // path
                                   -1,            // maxAge
                                   false);        // isSecure
        
        List<Cookie> cookies = new List<Cookie>();
        cookies.add(sessionCookie);
        ApexPages.currentPage().setCookies(cookies);
        
        return session;
    }

}