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

    public static void afterUpdate(List <Transaction__c> transactionsList) {

       // Set<Id> triggerIDs = Trigger.newMap.keyset();

        //List<dsfs__DocuSign_Status__c> transactionStatuses = [SELECT Transaction__c,Transaction__r.CompanyNumber__c , Transaction__r.ContactEmail__c,Transaction__r.CompanyName__c, Transaction__r.Form_Name__c, Transaction__r.Id, Transaction__r.Name, dsfs__Envelope_Status__c, dsfs__DocuSign_Envelope_ID__c FROM dsfs__DocuSign_Status__c Where Transaction__r.Id = :triggerIDs];

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

                parametername += SecurityManager.encryptText(transactiontype+AppConstants.ID_DELIM_CHAR+contactemail+AppConstants.ID_DELIM_CHAR+transactionID+AppConstants.ID_DELIM_CHAR+companyNumber);// + AppConstants.ID_DELIM_CHAR + envelopeID);

                PageReference statusreference = new PageReference(parametername);

                System.debug('your signing status url is' + statusreference);

                transactionupdater.SignerStatus__c = parametername;
            }
        }
    }
}