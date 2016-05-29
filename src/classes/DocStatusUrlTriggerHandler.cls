/**
 * Submission URL
 *
 * Author: leo.bitoy@methods.digital.co.uk
 * 
 *  This trigger handler builds a Document Signing Status URL for the user to track DocuSign Recipient Status view
 *
 *
 *
 *
 **/
public with sharing class DocStatusUrlTriggerHandler {

    private static Environment_Variables__c getSettings() {

        for (Environment_Variables__c s: Environment_Variables__c.getAll().values()) {
            return s;
        }

        System.debug(LoggingLevel.ERROR, 'No active Environment Variables in Custom Settings' + 'Can\'t build the system Host URL.');

        return null;
    }

    public DocStatusUrlTriggerHandler() {
		
	}


    public static void afterUpdateandafterInsert(List < Transaction__c > transactionsList) {

        for (Transaction__c transactionupdater: transactionsList) {
            // list of transactions to update at the end
            if (transactionupdater.Status__c == AppConstants.REQUEST_STATUS_PENDING_SIGNATURES) {
                // loop through transactions from trigger and find the signed status
                Environment_Variables__c settings = getSettings();

                // parameters needed for C value
                String baseURL = settings.Host_Address__c;
                String transactionID = transactionupdater.Id;
                String transactiontype = transactionupdater.Form_Name__c;
                String companyname = transactionupdater.CompanyName__c;
                String contactemail = transactionupdater.ContactEmail__c;
                String companyNumber = transactionupdater.CompanyNumber__c;
                String parametername = baseURL;

                parametername += '/Status?documentsigningstatus=';

                parametername += SecurityManager.encryptText(transactiontype + AppConstants.ID_DELIM_CHAR + contactemail + AppConstants.ID_DELIM_CHAR + transactionID + AppConstants.ID_DELIM_CHAR + companyNumber);

                PageReference downloadreference = new PageReference(parametername);

                System.debug('your signing status url is' + downloadreference);

                transactionupdater.SignerStatus__c = parametername;
            }
        }
    }
}