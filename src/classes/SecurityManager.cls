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
public with sharing class SecurityManager
{

    // Public properties.

    // Private class members.
    private String nonce;
    final static String DEFAULT_PRIVATE_KEY_TEXT = '12345678901234567890123456789012';

    // Constructors.
    public SecurityManager()
    {}

    // End Constructors.

    // Instance methods.      
    public Boolean validateAuthenticatedState(String companyAuthId, String userAuthId)
    {
        return false;
    }

    public PageReference getUserAuthRedirect()
    {
        AccountsAPIHelper h = new AccountsAPIHelper();

        nonce = getNonce();

        return new PageReference(h.getUserAuthUrl(nonce));
    }

    public PageReference getCompanyAuthRedirect(String companyNumber, String transactionType)
    {
        AccountsAPIHelper h = new AccountsAPIHelper();

        // String tempcompanyinformation =  TrackUserClass.getSearchedCompany(companyNumber);
        // always create/update a cookie when new company search is called

        nonce = getNonce();

        return new PageReference(h.getCompanyAuthUrl(companyNumber, transactionType, nonce));
    }

    public PageReference getDownloadAuthRedirect(String companyNumber, String transactionType)
    {
        AccountsAPIHelper h = new AccountsAPIHelper();

        // String tempcompanyinformation =  TrackUserClass.getSearchedCompany(companyNumber);
        // always create/update a cookie when new company search is called

        nonce = getNonce();

        return new PageReference(h.getCompanyDownloadAuthUrl(companyNumber, transactionType, nonce));
    }

    public PageReference getDocumentStatusAuthRedirect(String companyNumber, String transactionType)
    {
        AccountsAPIHelper h = new AccountsAPIHelper();

        // String tempcompanyinformation =  TrackUserClass.getSearchedCompany(companyNumber);
        // always create/update a cookie when new company search is called

        nonce = getNonce();

        return new PageReference(h.getDocumentStatusURL(companyNumber, transactionType, nonce));
    }

    private String getNonce()
    {

        final Integer NONCE_LENGTH = 16;

        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';

        String nonce = '';

        while (nonce.length() < NONCE_LENGTH)
        {
            Integer i = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            nonce += chars.substring(i, i + 1);
        }

        return nonce;
    }

    // End Instance methods.

    // Static methods.
    public static String decryptText(String encodedCipherText)
    {
         //return encodedCipherText;

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

    public static String encryptText(String clearText)
        {
              //return clearText;

            CryptoSettings__c cryptoOrgSettings = CryptoSettings__c.getOrgDefaults();
            String k = String.isBlank(cryptoOrgSettings.Encryption_Private_Key__c) ? DEFAULT_PRIVATE_KEY_TEXT : cryptoOrgSettings.Encryption_Private_Key__c;

            //32 byte string. since characters used are ascii, each char is 1 byte.
            Blob key = Blob.valueOf(k);
            Blob cipherText = Crypto.encryptWithManagedIV('AES256', key, Blob.valueOf(clearText));

            String encodedCipherText = EncodingUtil.base64Encode(cipherText);
            System.debug(LoggingLevel.ERROR, encodedCipherText);
            return encodedCipherText;
        }
        // End Static methods.
}
