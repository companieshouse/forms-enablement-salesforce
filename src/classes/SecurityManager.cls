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
  final static String DEFAULT_SF_CHS_COOKIE_NAME = 'SFCHS';
 
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
  public static PageReference checkSessionValidityCookie(String emailPresenter){
    //Check for the cookie existence
    //
    system.debug('COOKIE:' + ApexPages.currentPage().getCookies());
    Boolean containsCookie = ApexPages.currentPage().getCookies().containsKey(DEFAULT_SF_CHS_COOKIE_NAME);

    if(containsCookie)
    {
      //Refresh the cookie
      if(validateSession(emailPresenter))
      {
        createSessionValidityCookie(emailPresenter);
        return null;
      }
    }
    PageReference pg = new PageReference('/SessionExpired');
    pg.setRedirect(true);
    return pg;
    

  }

  //This methods will validate the cookie
  public static Boolean validateSession(String emailPresenter)
  {
    //Get the cookie
    Cookie sessionValidity = ApexPages.currentPage().getCookies().get(DEFAULT_SF_CHS_COOKIE_NAME);

    //Decrypt the value
    String result = SecurityManager.decryptText(sessionValidity.getValue());

    //Split the result
    String[] valueDecrypt = result.split(AppConstants.ID_DELIM_SPLIT_CHAR);

    system.debug(valueDecrypt[0] + ' Validate against:' + emailPresenter);

    if(emailPresenter.equals(valueDecrypt[0]))
    {
      if(Datetime.now().getTime() > Long.valueOf(valueDecrypt[1]))
      {
        Long milliseconds = Datetime.now().getTime() - Long.valueOf(valueDecrypt[1]);
        Long seconds = milliseconds / 1000;
        Long minutes = seconds / 60;
        if(minutes > 8)
        {
          return false;
        }
        return true;
      }
    }

    return false;
  }

  //This methods will create a cookie for the session validity
  public static void createSessionValidityCookie(String emailPresenter)
  {
    //Create the cookie
    Cookie sessionValidity = new Cookie(DEFAULT_SF_CHS_COOKIE_NAME, encryptText(emailPresenter + AppConstants.ID_DELIM_CHAR + String.valueOf(DateTime.now().getTime())), '', 480, true);

    ApexPages.currentPage().setCookies(new Cookie[]{sessionValidity});

  }

  public static void removeSessionValidityCookie()
  {
    //Create the cookie
    Cookie sessionValidity = new Cookie(DEFAULT_SF_CHS_COOKIE_NAME, encryptText(String.valueOf(DateTime.now().getTime())), '', 0, true);

    ApexPages.currentPage().setCookies(new Cookie[]{sessionValidity});
  }
  // End Static methods.
}