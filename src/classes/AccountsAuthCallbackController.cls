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
    
    private AccountsAPIHelper h;

    public class AccountsAuthCallbackException extends Exception {}	

	// Constructors.
	public AccountsAuthCallbackController(){}
	// End Constructors.

	// Instance methods.
	public PageReference initialiseAction(){
		
		return null;
		
		parseQueryString();
        
        findAuthorisationByNonce();
        
        // Call out to account.companieshouse.gov.uk to swap our auth code for an access token.
        accessTokenApiResponse = h.getAccessToken(authCode);

        // Call out again to get the user profile using the access token. If the authorisation was for a user.
        if (userAuth!=null)
        	userProfileApiResponse = h.getUserProfile(accessTokenApiResponse.accessToken);
        
        // TODO (User Auth)
        // 1. Find the existing Presenter PersonAccount record by the user ID from the profile, if it exists.
        // 2. Create one if not.
        // 3. Put the forename, surname, email address on it.
        // 4. Upsert it, possibly in a @Future, only after we're done calling out.
        // 5. Update the user authorisation record, possibly in a @Future, only after we're done calling out.
        // 6. Drop a cookie (user_auth) - value equal to the encrypted value of the User Auth record Id.
        // 6. Redirect to the Company page (passing transaction type as 't' querystring parameter).
        
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
    
    private void parseQueryString() {
        // Expect a nonce on the query string under the param "state".
        nonce = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_NONCE);        
        if (String.isBlank(nonce)) { throw new AccountsAuthCallbackException('A ' + QUERY_STRING_PARAM_NONCE + ' parameter is required.'); }
        
        authCode = ApexPages.currentPage().getParameters().get(QUERY_STRING_PARAM_AUTH_CODE);        
        if (String.isBlank(authCode)) { throw new AccountsAuthCallbackException('A ' + QUERY_STRING_PARAM_AUTH_CODE + ' parameter is required.'); }
    }
    
    private void findAuthorisationByNonce() {
        try {
        	
			List<User_Authorisation__c> userAuthorisations = [select Id from User_Authorisation__c where Nonce__c=:nonce];
			if (userAuthorisations.size()==1){
				userAuth = userAuthorisations[0];
				return;
			}
        	
			List<Company_Authorisation__c> companyAuthorisations = [select Id from Company_Authorisation__c where Nonce__c=:nonce];
			if (companyAuthorisations.size()==1) companyAuth = companyAuthorisations[0];
        }
        catch (QueryException e) { throw new AccountsAuthCallbackException('Invalid state ' + nonce); }
    }
	// End Instance methods.
}