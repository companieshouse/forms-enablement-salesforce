/*
Name:  AccountsAPIHelper.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Helper class for the Accounts API.

Encapsulates : all Accounts API interactions.

Note - refresh tokens are not used. 
The access token provides a short-lived window of trust after 
which the user must reauthenticate.

======================================================
======================================================
History
------- 
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-04-09  Initial conversion of Eliot Stock code .
*/
public with sharing class AccountsAPIHelper {
	
        SecurityManager securityMgr;

        private TrackUserClass userTracker {
        get;
        set;
    }
    

    public class AccountsApiException extends Exception {}	

    public String getRedirectUrl() {
        String hostname = ApexPages.currentPage().getHeaders().get('Host');
        String redirectUrl = 'https://' + hostname + '/AccountsAuthCallback';
       // String redirectUrl = 'https://c.cs83.visual.force.com/apex/authcallback';
        System.debug('hostname is  ' + hostname); 
               return redirectUrl;
    }	

    public String getDownloadRedirectUrl() {
        String hostname = ApexPages.currentPage().getHeaders().get('Host');
        String downloadredirectUrl = 'https://' + hostname + '/Documents';
        System.debug('hostname is  ' + hostname); 
               return downloadredirectUrl;
    }   
	
    public String getDocumentStatusRedirectUrl() {
        String hostname = ApexPages.currentPage().getHeaders().get('Host');
        String docstatusredirectUrl = 'https://' + hostname + '/Status';
        System.debug('hostname is  ' + hostname); 
               return docstatusredirectUrl;
    }   

	public String getUserAuthUrl(String nonce){

		Account_Api_Settings__c settings = getSettings();
		

        // System.debug('nonce is ' + nonce + ',  ' + ' settings are:  ' + settings );
		
		insert new User_Authorisation__c(Nonce__c=nonce);

        String authUrl = 'https://'+settings.Host__c+'/oauth2/authorise' + '?';
        
        // Response type is always "code"
        authUrl +='response_type=';
        
        // Client ID identifies us to the server and is not secret
        authUrl+='code&client_id='+settings.Client_ID__c;
        
         // Chris Smith's instructions: It is mandatory to pass a state parameter, containing a nonce
        // value. This will be returned to the supplied redirect_ui along with the authorisation
        // code, and must be checked to ensure it is still valid.
        //lb changed the sequence....really shouldn't matter
        authUrl+='&state='+nonce;

        // Redirect URL.
        String redirectUrl = EncodingUtil.urlEncode(getRedirectUrl(), 'UTF-8');        

		 authUrl += '&redirect_uri='+redirectUrl;

         return authUrl;
    }
    
    public String getCompanyAuthUrl(String companyNumber, String transactionType, String nonce){
    	
    	final String SCOPE_PREFIX = 'http://api.companieshouse.gov.uk/company/';

		Account_Api_Settings__c settings = getSettings();


      
             // always insert new company auth when this is called so we can track user and company searched
		insert new Company_Authorisation__c(Company_Number__c=companyNumber, Nonce__c=nonce, Transaction_Type__c=transactionType);

        String authUrl = 'https://'+settings.Host__c+'/oauth2/authorise' + '?';
        
        // Response type is always "code"
        authUrl+='response_type=code';
        
        // Client ID identifies us to the server and is not secret
        authUrl+='&client_id='+settings.Client_Id__c;
        
         // Chris Smith's instructions: It is mandatory to pass a state parameter, containing a nonce
        // value. This will be returned to the supplied redirect_ui along with the authorisation
        // code, and must be checked to ensure it is still valid.
        //lb changed the sequence....really shouldn't matter
        authUrl+='&state='+nonce;
        
        // Redirect URL.
        String redirectUrl = EncodingUtil.urlEncode(getRedirectUrl(), 'UTF-8'); //  EncodingUtil.urlEncode(settings.Callback_Url__c, 'UTF-8');      

		authUrl+='&redirect_uri='+ redirectUrl;  
		authUrl+='&scope='+SCOPE_PREFIX+companyNumber;    	
    	
    	return authUrl;
    }


    public String getCompanyDownloadAuthUrl(String companyNumber, String transactionType, String nonce){
        
        final String SCOPE_PREFIX = 'http://api.companieshouse.gov.uk/company/';

        Account_Api_Settings__c settings = getSettings();


      
             // always insert new company auth when this is called so we can track user and company searched
        insert new Company_Authorisation__c(Company_Number__c=companyNumber, Nonce__c=nonce, Transaction_Type__c=transactionType);

        String authUrl = 'https://'+settings.Host__c+'/oauth2/authorise' + '?';
        
        // Response type is always "code"
        authUrl+='response_type=code';
        
        // Client ID identifies us to the server and is not secret
        authUrl+='&client_id='+settings.Client_Id__c;
        
         // Chris Smith's instructions: It is mandatory to pass a state parameter, containing a nonce
        // value. This will be returned to the supplied redirect_ui along with the authorisation
        // code, and must be checked to ensure it is still valid.
        //lb changed the sequence....really shouldn't matter
        authUrl+='&state='+nonce;
        
        // Redirect URL.
        String redirectUrl = EncodingUtil.urlEncode(getDownloadRedirectUrl(), 'UTF-8'); //  EncodingUtil.urlEncode(settings.Callback_Url__c, 'UTF-8');      

        authUrl+='&redirect_uri='+ redirectUrl;  
        authUrl+='&scope='+SCOPE_PREFIX+companyNumber;      
        
        return authUrl;
    }

public String getDocumentStatusURL(String companyNumber, String transactionType, String nonce){
        
        final String SCOPE_PREFIX = 'http://api.companieshouse.gov.uk/company/';

        Account_Api_Settings__c settings = getSettings();


      
             // always insert new company auth when this is called so we can track user and company searched
        insert new Company_Authorisation__c(Company_Number__c=companyNumber, Nonce__c=nonce, Transaction_Type__c=transactionType);

        String authUrl = 'https://'+settings.Host__c+'/oauth2/authorise' + '?';
        
        // Response type is always "code"
        authUrl+='response_type=code';
        
        // Client ID identifies us to the server and is not secret
        authUrl+='&client_id='+settings.Client_Id__c;
        
         // Chris Smith's instructions: It is mandatory to pass a state parameter, containing a nonce
        // value. This will be returned to the supplied redirect_ui along with the authorisation
        // code, and must be checked to ensure it is still valid.
        //lb changed the sequence....really shouldn't matter
        authUrl+='&state='+nonce;
        
        // Redirect URL.
        String redirectUrl = EncodingUtil.urlEncode(getDocumentStatusRedirectUrl(), 'UTF-8'); //  EncodingUtil.urlEncode(settings.Callback_Url__c, 'UTF-8');      

        authUrl+='&redirect_uri='+ redirectUrl;  
        authUrl+='&scope='+SCOPE_PREFIX+companyNumber;      
        
        return authUrl;
    }
    
    // Look for a custom setting record with the credentials for the server.
    public static Account_Api_Settings__c getSettings() {
        // Return the first active one found.
        for (Account_Api_Settings__c s : Account_Api_Settings__c.getAll().values()) {
            if (s.Is_Active__c) { 
                return s; }
        }


        // Unit tests should not rely on custom settings records.
        if (Test.isRunningTest()) {
            Account_Api_Settings__c s = new Account_Api_Settings__c(
                Host__c = 'account.preprod.companieshouse.gov.uk',
                Client_ID__c = 'unit_test_client_id',
                Client_Secret__c = 'unit_test_client_secret',
                Is_Active__c = true);
            return s;
        }

        System.debug(LoggingLevel.ERROR, 'No active SmartPay Settings records exist under Custom' + ' Settings. Can\'t build a SmartPay URL.');

        return null;
    }
    
    public AccountsApiHelper.Token getAccessToken(String authCode) {
        Account_Api_Settings__c settings = getSettings();
        
        System.debug('settings =  ' + settings);

        HttpRequest request = new HttpRequest();
        String endpoint = 'https://' + settings.Host__c + '/oauth2/token';
        request.setEndpoint(endpoint);
        request.setMethod('POST');

        String body = '';
        
        body += 'code=' + authCode + '&';        
        
        body += 'client_id=' + settings.Client_ID__c + '&';
        body += 'client_secret=' + settings.Client_Secret__c + '&';
        
        String redirectUrl = getRedirectUrl(); //EncodingUtil.urlEncode(getRedirectUrl(), 'UTF-8');        

        body += 'redirect_uri=' + redirectUrl + '&'; //'https://c.cs83.visual.force.com/apex/authcallback'      //settings.Callback_Url__c
        body += 'grant_type=authorization_code';
        
        System.debug(LoggingLevel.INFO, 'Get access token POST to ' + endpoint + ', request body: ' + body);
        
        request.setBody(body);
        request.setTimeout(120000);
 
        Http http = new Http();
        
        // Send the request. This will get us a mock response under the unit test.
        HTTPResponse response = http.send(request);

        System.debug('response  =  ' + response);

        System.debug(LoggingLevel.INFO, 'Response status code: ' + response.getStatusCode());
        System.debug(LoggingLevel.INFO, 'Response body: ' + response.getBody());
        
        if (response.getStatusCode() == 302) {
            throw new AccountsApiException('Redirect response. We don\'t follow redirects. Status: '
                    + response.getStatus() + ', redirecting to: ' + response.getHeader('Location'));
        }
        
        if (response.getBody().length() == 0) {
            throw new AccountsApiException('Empty response body. Status code: '
                    + response.getStatusCode());
        }
        
        if (response.getBody().startsWith('<!DOCTYPE html>')) {
                     //   throw new AccountsApiException('body ======' + response);

            throw new AccountsApiException('HTML response. Expected JSON. Probably an error page. Check the logs for a span tag with id="error-description".');
        }
        
        try {
            AccountsApiHelper.Token token = (AccountsApiHelper.Token)JSON.deserializeStrict(response.getBody(), AccountsApiHelper.Token.class);
            return token;
        }
        catch (JSONException e) {
            throw new AccountsApiException('Not a JSON response:\n\n' + response.getBody());
        }
    }
    
    public AccountsApiHelper.UserProfile getUserProfile(String accessToken) {
        Account_Api_Settings__c settings = getSettings();

        // note need to get user profile email address and then encryp in the cookie and decrypt when accessing it


        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://' + settings.Host__c + '/user/profile');
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + accessToken);
 
        Http http = new Http();
        
        // Send the request. This will get us a mock response under the unit test.
        HTTPResponse response = http.send(request);
        
        System.debug(LoggingLevel.INFO, 'Response status code: ' + response.getStatusCode());
        System.debug(LoggingLevel.INFO, 'Response body: ' + response.getBody());
        
        if (response.getStatusCode() >= 400) {
            throw new AccountsApiException('Error response to user profile request. '
                    + response.getStatusCode() + ': ' + response.getStatus() + '\n'
                    + response.getBody());
            
            // TODO: Chris Smith's instructions:
            // If this returns a 4xx status code, it is likely that the access_token has
            // expired. In which case you should use the refresh_token to obtain a new access
            // token. We can talk about this later, as it can be a bit involved with the user
            // journeys and scenarios, too much for this email.
        }
        
        // TODO: Consider exception handling. Should clients catch parse exceptions?
        AccountsApiHelper.UserProfile profile = (AccountsApiHelper.UserProfile)JSON.deserializeStrict(response.getBody(),AccountsApiHelper.UserProfile.class);

        // note everytime the profile is called it should be inserted in a cookie
        //userTracker.getCurrentUser(profile.email);
        
        return profile;
    }
    
	public class UserProfile {
        public String surname;
        public String forename;
        public String email;
        public String id;
        public String locale;
    } 
    
    public class Token {
        public String access_token;
        // TODO: Consider using an Integer here if this comes across without quotes.
        public String expires_in;
        public String token_type;
        public String refresh_token;
    }     
}