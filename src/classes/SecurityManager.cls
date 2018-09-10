/*
Name:  SecurityManager.cls
Copyright © 2016  Methods Digital
======================================================
======================================================
Purpose:
-------

Manager class for all Security functions.

======================================================
======================================================
History
-------
Ver. Author        Date        Detail
1.0  Mark Cane&    2016-02-09  Initial development.
*/
public with sharing class SecurityManager {

  // Public properties.

  // Private class members.
  @testvisible
  private String nonce;
  final static String DEFAULT_PRIVATE_KEY_TEXT = '12345678901234567890123456789012';
  public final static String DEFAULT_SF_CHS_COOKIE_NAME = 'SFCHS';
 
  // Constructors.
  public SecurityManager() {}

  // End Constructors.

  // Instance methods.
  public Boolean validateAuthenticatedState(String companyAuthId, String userAuthId) {
    return false;
  }

  public PageReference getUserAuthRedirect(String redirectURL) {
    AccountsAPIHelper h = new AccountsAPIHelper();

    nonce = getNonce();

    return new PageReference(h.getUserAuthUrl(nonce, redirectURL));
  }

  public PageReference getCompanyAuthRedirect(String companyNumber, String transactionType) {
    AccountsAPIHelper h = new AccountsAPIHelper();

    // String tempcompanyinformation =  TrackUserClass.getSearchedCompany(companyNumber);
    // always create/update a cookie when new company search is called

    nonce = getNonce();

    return new PageReference(h.getCompanyAuthUrl(companyNumber, transactionType, nonce));
  }

  public PageReference getDownloadAuthRedirect(String companyNumber, String transactionType) {
    AccountsAPIHelper h = new AccountsAPIHelper();

    // String tempcompanyinformation =  TrackUserClass.getSearchedCompany(companyNumber);
    // always create/update a cookie when new company search is called

    nonce = getNonce();

    return new PageReference(h.getCompanyDownloadAuthUrl(companyNumber, transactionType, nonce));
  }

  public PageReference getDocumentStatusAuthRedirect(String companyNumber, String transactionType) {
    AccountsAPIHelper h = new AccountsAPIHelper();

    // String tempcompanyinformation =  TrackUserClass.getSearchedCompany(companyNumber);
    // always create/update a cookie when new company search is called

    nonce = getNonce();

    return new PageReference(h.getDocumentStatusURL(companyNumber, transactionType, nonce));
  }

  public PageReference getReviewStatusAuthRedirect(String companyNumber, String transactionType) {
    AccountsAPIHelper h = new AccountsAPIHelper();

    // String tempcompanyinformation =  TrackUserClass.getSearchedCompany(companyNumber);
    // always create/update a cookie when new company search is called

    nonce = getNonce();

    return new PageReference(h.getReviewStatusURL(companyNumber, transactionType, nonce));
  }
  @testvisible
  private String getNonce() {

    final Integer NONCE_LENGTH = 16;

    final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';

    String nonce = '';

    while (nonce.length() < NONCE_LENGTH) {
      Integer i = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
      nonce += chars.substring(i, i + 1);
    }

    return nonce;
  }

  // End Instance methods.

  // Static methods.
  public static String decryptText(String encodedCipherText) {
    CryptoSettings__c cryptoOrgSettings = CryptoSettings__c.getOrgDefaults();
    String k = String.isBlank(cryptoOrgSettings.Encryption_Private_Key__c) ? DEFAULT_PRIVATE_KEY_TEXT : cryptoOrgSettings.Encryption_Private_Key__c;

    //32 byte string. since characters used are ascii, each char is 1 byte.
    Blob key = Blob.valueOf(k);
    Blob encodedEncryptedBlob = EncodingUtil.base64Decode(encodedCipherText);
    Blob decryptedBlob = Crypto.decryptWithManagedIV('AES256', key, encodedEncryptedBlob);

    String clearText = decryptedBlob.toString();
    System.debug(clearText);
    return clearText;
  }

  public static String encryptText(String clearText) {
    CryptoSettings__c cryptoOrgSettings = CryptoSettings__c.getOrgDefaults();
    String k = String.isBlank(cryptoOrgSettings.Encryption_Private_Key__c) ? DEFAULT_PRIVATE_KEY_TEXT : cryptoOrgSettings.Encryption_Private_Key__c;

    //32 byte string. since characters used are ascii, each char is 1 byte.
    Blob key = Blob.valueOf(k);
    Blob cipherText = Crypto.encryptWithManagedIV('AES256', key, Blob.valueOf(clearText));

    String encodedCipherText = EncodingUtil.base64Encode(cipherText);
    System.debug(LoggingLevel.ERROR, encodedCipherText);
    return encodedCipherText;
  }

  //This methods will control the session validity from SF for each page displayed based on a cookie
  //
  public static PageReference checkSessionValidityCookie(String emailPresenter, Transaction__c submission, TransactionManager transactionMgr, String infos){
    //Check for the cookie existence
    //
    Boolean sessionValidity = false;

    Map<String, String> headersInfo = new Map<String, String>();
    headersInfo = ApexPages.currentPage().getHeaders();
    
    LogSessionManager.addLog('<br/> Entering method: checkSessionValidityCookie: ');
    LogSessionManager.addLog('<br/> Printing caller Infos: ' + infos);
    
    for(String key :headersInfo.keySet())
    {
      LogSessionManager.addLog('<br/> Printing User Tech Infos: Key => ' + key);
      LogSessionManager.addLog('<br/> Printing User Tech Infos: Value => ' + headersInfo.get(key));
    }
    
    LogSessionManager.addLog('<br/> Transaction Id: ' + (submission != null ? ('' + submission.Id) : ('No Transaction Id')));
    LogSessionManager.addLog('<br/> Company Number: ' + (submission != null ?  ('' + submission.CompanyNumber__c) : 'No Company Number'));
    LogSessionManager.addLog('<br/> Step Triggering: ' + (transactionMgr != null ? ('' +transactionMgr.currentStep.Id) : 'No Transaction Manager') + ' Number: ' + (transactionMgr != null ? ('' + transactionMgr.currentStep.Step_Number__c) : 'No Transaction Manager'));
    LogSessionManager.addLog('<br/> URL Triggering: ' + ApexPages.currentPage().getUrl());
    LogSessionManager.addLog('<br/> ------ Check if the cookie exist: Starting ' + System.now());
    Boolean containsCookie = ApexPages.currentPage().getCookies().containsKey(DEFAULT_SF_CHS_COOKIE_NAME);
    LogSessionManager.addLog('<br/> ------ Check if the cookie exist: Result: containsCookie: ' + containsCookie);
    

    if(containsCookie)
    {
      LogSessionManager.addLog('<br/> ------ ------ Check the session validity: Starting ' + System.now());
      sessionValidity = validateSession(emailPresenter);
      LogSessionManager.addLog('<br/> ------ ------ Check the session validity: Result: sessionValidity: ' + sessionValidity);
      

      //Refresh the cookie
      if(sessionValidity)
      {
          LogSessionManager.addLog('<br/> ------ ------ ------ Refresh the session validity: Starting ' + System.now());
          createSessionValidityCookie(emailPresenter, submission, transactionMgr, infos, true);
          LogSessionManager.addLog('<br/> ------ ------ ------ Refresh the session validity: Finished ' + System.now());
        
      }
      LogSessionManager.addLog('<br/> ------ ------ Check the session validity: Finished ' + System.now());
    }
    LogSessionManager.addLog('<br/> ------ Check if the cookie exist: Finished ' + System.now());

    if(sessionValidity)
      return null;


    LogSessionManager.commitChangeToTransaction(submission, transactionMgr);

    PageReference pg = new PageReference('/SessionExpired');
    pg.setRedirect(true);
    return pg;
    

  }

  //This methods will validate the cookie
  public static Boolean validateSession(String emailPresenter)
  {
    //Get the cookie
    LogSessionManager.addLog('<br/> ------ Entering method: validateSession: ');
    LogSessionManager.addLog('<br/> ------ Getting the Cookie: Starting ' + System.now());
    Cookie sessionValidity = ApexPages.currentPage().getCookies().get(DEFAULT_SF_CHS_COOKIE_NAME);
    LogSessionManager.addLog('<br/> ------ Getting the Cookie: Result: sessionValidity: ' + sessionValidity);
    LogSessionManager.addLog('<br/> ------ Getting the Cookie: Finished ' + System.now());

    //Decrypt the value
    LogSessionManager.addLog('<br/> ------ Decrypting Result: Starting ' + System.now());
    String result = SecurityManager.decryptText(sessionValidity.getValue());
    LogSessionManager.addLog('<br/> ------ Decrypting Result: Result: ' + result);
    LogSessionManager.addLog('<br/> ------ Decrypting Result: Finished ' + System.now());

    //Split the result
    LogSessionManager.addLog('<br/> ------ Spliting Result (No results displayed): Starting ' + System.now());
    String[] valueDecrypt = result.split(AppConstants.ID_DELIM_SPLIT_CHAR);
    LogSessionManager.addLog('<br/> ------ Spliting Result: Finished ' + System.now());

    LogSessionManager.addLog('<br/> ------ Email Presenter equality: Starting ' + System.now());
    LogSessionManager.addLog('<br/> ------ Email Presenter equality: Result: ' + emailPresenter.equals(valueDecrypt[0]));
    if(emailPresenter.equals(valueDecrypt[0]))
    {
      
      LogSessionManager.addLog('<br/> ------ Value Saved Against must be in past: Starting ' + System.now());
      LogSessionManager.addLog('<br/> ------ Value Saved Against must be in past: Result: ' + (Datetime.now().getTime() > Long.valueOf(valueDecrypt[1])));
      if(Datetime.now().getTime() > Long.valueOf(valueDecrypt[1]))
      {
        LogSessionManager.addLog('<br/> ------ Getting Time Difference in Milliseconds: Starting ' + System.now());
        Long milliseconds = Datetime.now().getTime() - Long.valueOf(valueDecrypt[1]);
        LogSessionManager.addLog('<br/> ------ Getting Time Difference in Milliseconds: Result: milliseconds: ' + milliseconds);
        LogSessionManager.addLog('<br/> ------ Getting Time Difference in Milliseconds: Finished ' + System.now());

        LogSessionManager.addLog('<br/> ------ Getting Time Difference in Seconds: Starting ' + System.now());
        Long seconds = milliseconds / 1000;
        LogSessionManager.addLog('<br/> ------ Getting Time Difference in Seconds: Result: seconds:' + seconds);
        LogSessionManager.addLog('<br/> ------ Getting Time Difference in Seconds: Finished ' + System.now());

        LogSessionManager.addLog('<br/> ------ Getting Time Difference in Minutes: Starting ' + System.now());
        Long minutes = seconds / 60;
        LogSessionManager.addLog('<br/> ------ Getting Time Difference in Seconds: Result: minutes: ' + minutes);
        LogSessionManager.addLog('<br/> ------ Getting Time Difference in Seconds: Finished ' + System.now());

        LogSessionManager.addLog('<br/> ------ Does 12 minutes have passed?: Starting ' + System.now());
        LogSessionManager.addLog('<br/> ------ Does 12 minutes have passed?: Result: ' + (minutes > 12));
        if(minutes > 1200)
        {
          LogSessionManager.addLog('<br/> ------ INVALID SESSION False Returned ' + System.now());

          return false;
        }
        LogSessionManager.addLog('<br/> ------ Does 12 minutes have passed?: Finished ' + System.now());

        LogSessionManager.addLog('<br/> ------ VALID SESSION True Returned ' + System.now());

        return true;
      }
      LogSessionManager.addLog('<br/> ------ Value Saved Against must be in past: Finished ' + System.now());
    }
    LogSessionManager.addLog('<br/> ------ Email Presenter equality: Finished ' + System.now());

    LogSessionManager.addLog('<br/> ------ INVALID SESSION False Returned ' + System.now());

    return false;
  }

  public static void createSessionValidityCookie(String emailPresenter)
  {
    createSessionValidityCookie(emailPresenter, null, null, null);
  }

  public static void createSessionValidityCookie(String emailPresenter, Transaction__c submission, TransactionManager transactionMgr, String infos)
  {
    createSessionValidityCookie(emailPresenter, submission, transactionMgr, infos, false);
  }

  //This methods will create a cookie for the session validity
  public static void createSessionValidityCookie(String emailPresenter, Transaction__c submission, TransactionManager transactionMgr, String infos, Boolean isPartOfValidation)
  {
    LogSessionManager.addLog('<br/> ------ ------ Entering method: createSessionValidityCookie: ');
    //Create the cookie
    LogSessionManager.addLog('<br/> ------ ------ Printing caller Infos: ' + infos);
    LogSessionManager.addLog('<br/> Transaction Id: ' + (submission != null ? ('' + submission.Id) : ('No Transaction Id')));
    LogSessionManager.addLog('<br/> Company Number: ' + (submission != null ?  ('' + submission.CompanyNumber__c) : 'No Company Number'));
    LogSessionManager.addLog('<br/> Step Triggering: ' + (transactionMgr != null ? ('' +transactionMgr.currentStep.Id) : 'No Transaction Manager') + ' Number: ' + (transactionMgr != null ? ('' + transactionMgr.currentStep.Step_Number__c) : 'No Transaction Manager'));
    LogSessionManager.addLog('<br/> URL Triggering: ' + ApexPages.currentPage().getUrl());
    LogSessionManager.addLog('<br/> ------ ------ Creating the Cookie: Starting ' + System.now());
    Cookie sessionValidity = new Cookie(DEFAULT_SF_CHS_COOKIE_NAME, encryptText(emailPresenter + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())), '', 72000, true);
    LogSessionManager.addLog('<br/> ------ ------ Creating the Cookie: Result: sessionValidity: ' + sessionValidity);
    LogSessionManager.addLog('<br/> ------ ------ Creating the Cookie: Finished ' + System.now());

    LogSessionManager.addLog('<br/> ------ ------ Adding the Cookie to the page: Starting ' + System.now());
    ApexPages.currentPage().setCookies(new Cookie[]{sessionValidity});
    LogSessionManager.addLog('<br/> ------ ------ Adding the Cookie to the page: Finished ' + System.now());


    if(!isPartOfValidation)
    {
      LogSessionManager.commitChangeToTransaction(submission, transactionMgr);
    }

  }
  public static void removeSessionValidityCookie()
  {
    removeSessionValidityCookie( null, null, null, false);
  }

  public static void removeSessionValidityCookie( Transaction__c submission, TransactionManager transactionMgr, String infos, Boolean isPartOfValidation)
  {
    LogSessionManager.addLog('<br/> ------ ------ Entering method: removeSessionValidityCookie: ');
    //Create the cookie
    LogSessionManager.addLog('<br/> ------ ------ Printing caller Infos: ' + infos);
    LogSessionManager.addLog('<br/> Transaction Id: ' + (submission != null ? ('' + submission.Id) : ('No Transaction Id')));
    LogSessionManager.addLog('<br/> Company Number: ' + (submission != null ?  ('' + submission.CompanyNumber__c) : 'No Company Number'));
    LogSessionManager.addLog('<br/> Step Triggering: ' + (transactionMgr != null ? ('' +transactionMgr.currentStep.Id) : 'No Transaction Manager') + ' Number: ' + (transactionMgr != null ? ('' + transactionMgr.currentStep.Step_Number__c) : 'No Transaction Manager'));
    LogSessionManager.addLog('<br/> URL Triggering: ' + ApexPages.currentPage().getUrl());
    //Create the cookie
    LogSessionManager.addLog('<br/> ------ ------ Creating the Cookie with an expiry date at 0: Starting ' + System.now());
    Cookie sessionValidity = new Cookie(DEFAULT_SF_CHS_COOKIE_NAME, encryptText(String.valueOf(DateTime.now().getTime())), '', 0, true);
    LogSessionManager.addLog('<br/> ------ ------ Creating the Cookie: Result: sessionValidity: ' + sessionValidity);
    LogSessionManager.addLog('<br/> ------ ------ Creating the Cookie: Finished ' + System.now());

    LogSessionManager.addLog('<br/> ------ ------ Adding the Cookie to the page: Starting ' + System.now());
    ApexPages.currentPage().setCookies(new Cookie[]{sessionValidity});

    LogSessionManager.addLog('<br/> ------ ------ Adding the Cookie to the page: Finished ' + System.now());

    if(!isPartOfValidation)
    {
      LogSessionManager.commitChangeToTransaction(submission, transactionMgr);
    }
  }
  // End Static methods.
}