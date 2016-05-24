/**
 * Review Redirect URL for multiple Directors
 *
 * Author: leo.bitoy@methods.digital.co.uk
 * 
 *  This transaction__c review handler trigger builds a review redirect on records with multiple directors
 *
 *
 *
 *
 **/

public class ReviewNotificationTriggerHandler {

    private static Environment_Variables__c getSettings() {

        for (Environment_Variables__c s: Environment_Variables__c.getAll().values()) {
            return s;
        }

        System.debug(LoggingLevel.ERROR, 'No active Environment Variables in Custom Settings' + 'Can\'t build the system Host URL.');

        return null;
    }

    // pass transactions to update list to this method from the trigger being called after update/insert
    public static void afterUpdateandafterInsert(List < Transaction__c > transactionsList) {

            Environment_Variables__c settings = getSettings();


        List < Transaction__c > transactionsToUpdate = new List < Transaction__c > ();

        List < Transaction__c > transactionListRecords = [Select Id, Valid_Step_Ids__c, Status__c, MultipleDirectors__c From Transaction__c Where Id IN: transactionsList AND Status__c = : AppConstants.REQUEST_STATUS_SIGNED AND MultipleDirectors__c = true];

        for (Transaction__c transactionupdater: transactionListRecords) {
            // list of transactions to update at the end

            // loop through transactions from trigger and find the signed status

            // parameters needed for C value
            String redirectReviewURL = settings.Host_Address__c; 
            // note need to pull the base sites url either a query or a custom setting.
            String subIDs = transactionupdater.Id;
            String[] stepsId = transactionupdater.Valid_Step_Ids__c.split(AppConstants.ID_DELIM_SPLIT_CHAR);
            String docuSignStepID = stepsId[stepsId.size() - 1];

            TransactionManager reviewerManager = new TransactionManager((Id) docuSignStepID);

            PageReference pr = reviewerManager.nextStep(subIDs);

            redirectReviewURL += pr.getUrl();

            System.debug('your redirect url is' + redirectReviewURL);

            transactionupdater.MultipleDirectors__c = false;
            transactionupdater.ReviewRedirect__c = redirectReviewURL;

            System.debug('These transactions are signed and have multiple directors' + transactionupdater.ContactEmail__c);

            Transaction__c transactionshim = new Transaction__c();
            transactionshim.Id = transactionupdater.Id;
            transactionshim.MultipleDirectors__c = transactionupdater.MultipleDirectors__c;
            transactionshim.ReviewRedirect__c = transactionupdater.ReviewRedirect__c;
            transactionsToUpdate.add(transactionshim);
        }
        if (!transactionListRecords.isEmpty()) {

            update transactionsToUpdate;
        }

    }


}