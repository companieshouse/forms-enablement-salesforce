/**
 * TRANSACTION TRIGGER HANDLER
 * Author: leo.bitoy@methods.digital.co.uk
 * 
 *  This trigger handler builds a Document Signing Status URL for the user to track DocuSign Recipient Status view
 *
 *
 * updates transaction with ReviewNotiicationTriggerHandler
 * Builds the Review URL field when the multi-director signing process has been successful
 * After this trigger a workflow is fired off with an email allowing the user to review their status
 * and continue the process.
 *  This trigger handler builds the base url for all environments
 */
public with sharing class TransactionTriggerHandler {
	

    public static void beforeUpdate(List <Transaction__c> transactionsList) {

       // Set<Id> triggerIDs = Trigger.newMap.keyset();

        //List<dsfs__DocuSign_Status__c> transactionStatuses = [SELECT Transaction__c,Transaction__r.CompanyNumber__c , Transaction__r.ContactEmail__c,Transaction__r.CompanyName__c, Transaction__r.Form_Name__c, Transaction__r.Id, Transaction__r.Name, dsfs__Envelope_Status__c, dsfs__DocuSign_Envelope_ID__c FROM dsfs__DocuSign_Status__c Where Transaction__r.Id = :triggerIDs];

        for (Transaction__c transactionupdater: transactionsList) {
            // list of transactions to update at the end
            if( transactionupdater.Status__c == 'deleteContact')
            {
                //Get the associated contacts as I know there will be only one contact then I can do a DML in a for loop
                List<Transaction__c> tCont = [Select Id, (SELECT Id FROM Contacts__r) From Transaction__c where Id = :transactionupdater.Id];

                if(tCont[0].Contacts__r != null)  
                {
                    delete tCont[0].Contacts__r;
                }
            }
            if (transactionupdater.Status__c == AppConstants.REQUEST_STATUS_PENDING_SIGNATURES) {
                // loop through transactions from trigger and find the signed status

                // parameters needed for C value
                String baseURL = transactionupdater.ApplicationBaseURL__c.substringBefore('/start');
                String transactionID = transactionupdater.Id;
                String transactiontype = transactionupdater.Form_Name__c;
                String companyname = transactionupdater.CompanyName__c;
                String contactemail = transactionupdater.ContactEmail__c;
                String companyNumber = transactionupdater.CompanyNumber__c;
                String parametername = baseURL.substringBefore('/apex');

                parametername += '/Status?documentsigningstatus=';

                parametername += SecurityManager.encryptText(transactiontype+AppConstants.ID_DELIM_CHAR+contactemail+AppConstants.ID_DELIM_CHAR+transactionID+AppConstants.ID_DELIM_CHAR+companyNumber);// + AppConstants.ID_DELIM_CHAR + envelopeID);

                PageReference statusreference = new PageReference(parametername);

                System.debug('your signing status url is' + statusreference);

                transactionupdater.SignerStatus__c = parametername;
            }

            if (transactionupdater.ApplicationBaseURL__c == null) {

                // parameters needed for C value
                String baseURL = Site.getBaseUrl();
                String parametername = baseURL;

                parametername += '/start?t=';

                parametername += transactionupdater.Form_Name__c;

                PageReference basereference = new PageReference(parametername);

                System.debug('your base url is' + basereference);

                transactionupdater.ApplicationBaseURL__c = parametername;
            }

            if (transactionupdater.Status__c == AppConstants.REQUEST_STATUS_SUBMITTED) {
                // loop through transactions from trigger and find the signed status
                // parameters needed for C value
                String baseURL = transactionupdater.ApplicationBaseURL__c.substringBefore('/start');
                // note need to pull the base sites url either a query or a custom setting.
                String transactionID = transactionupdater.Id;
                String transactiontype = transactionupdater.Form_Name__c;
                String companyname = transactionupdater.CompanyName__c;
                String contactemail = transactionupdater.ContactEmail__c;
                String companyNumber = transactionupdater.CompanyNumber__c;
                String parametername = baseURL;

                parametername += '/documents?documentdownload=';

                parametername += SecurityManager.encryptText(transactiontype+AppConstants.ID_DELIM_CHAR+contactemail+AppConstants.ID_DELIM_CHAR+transactionID+AppConstants.ID_DELIM_CHAR+companyNumber);

                PageReference downloadreference = new PageReference(parametername);

                System.debug('your redirect url is' + downloadreference);

                transactionupdater.DownloadLink__c = parametername;
            }
        }
    }

    public static void afterUpdate(List <Transaction__c> transactionsList)
    {

        System.debug('LISTDEBUG' + transactionsList);
        List < Transaction__c > transactionsToUpdate = new List < Transaction__c > ();
        List < Transaction__c > transactionListRecords = [Select Id, ApplicationBaseURL__c,Valid_Step_Ids__c, Status__c, MultipleDirectors__c From Transaction__c Where Id IN: transactionsList AND Status__c = : AppConstants.REQUEST_STATUS_SIGNED AND SentreviewURL__c = false And isReviewTrigger__c = false AND SoleDirectorPresenter__c = false];
        for (Transaction__c transactionupdater: transactionListRecords) {
            // list of transactions to update at the end

            // loop through transactions from trigger and find the signed status

            // parameters needed for C value
            String redirectReviewURL = transactionupdater.ApplicationBaseURL__c.substringBefore('/start'); 
            // note need to pull the base sites url either a query or a custom setting.
            String subIDs = transactionupdater.Id;
            String[] stepsId = transactionupdater.Valid_Step_Ids__c.split(AppConstants.ID_DELIM_SPLIT_CHAR);
            String docuSignStepID = stepsId[stepsId.size() - 1];

            TransactionManager reviewerManager = new TransactionManager((Id) docuSignStepID);
                
            Transaction_Type_Step__mdt nextStep;
            
            for (Transaction_Type_Step__mdt step : reviewerManager.stepsById.values()){
                if (step.Step_Number__c > Integer.valueOf(reviewerManager.currentStep.Step_Number__c)){
                    
                    
                    if (step.Step_Type__c.equalsIgnoreCase(AppConstants.TRANSACTION_TYPE_VISUALFORCE_PAGE)){
                        nextStep = step;
                        break;
                            
                    } else if (step.Step_Type__c.equalsIgnoreCase(AppConstants.TRANSACTION_TYPE_APEX_CODE)){
                        
                        Id nextStepId = reviewerManager.getNextStepIdByApex(step.Apex_Class_Name__c,subIDs );
                        nextStep = reviewerManager.stepsById.get(nextStepId);
                        break;
                                            
                    }           
                }
            }
                        
            PageReference pr = new PageReference('/'+nextStep.Visualforce_Page_Name__c);
            pr.getParameters().put('c', SecurityManager.encryptText(subIDs+AppConstants.ID_DELIM_CHAR+nextStep.Id+AppConstants.ID_DELIM_CHAR+String.valueOf(DateTime.now().getTime())));              
                    
            //PageReference pr = reviewerManager.nextStep(subIDs);

            redirectReviewURL += pr.getUrl();

            System.debug('your redirect url is' + redirectReviewURL);

            transactionupdater.MultipleDirectors__c = false;
            transactionupdater.ReviewRedirect__c = redirectReviewURL;
            System.debug('These transactions are signed and have multiple directors' + transactionupdater.ContactEmail__c);

            Transaction__c transactionshim = new Transaction__c();
            transactionshim.Id = transactionupdater.Id;
            transactionshim.isSigningFinished__c = true;
            transactionshim.isReviewTrigger__c = true;
            transactionshim.Valid_Step_Ids__c = transactionupdater.Valid_Step_Ids__c + AppConstants.ID_DELIM_CHAR + nextStep.Id;
            transactionshim.MultipleDirectors__c = transactionupdater.MultipleDirectors__c;
            transactionshim.ReviewRedirect__c = transactionupdater.ReviewRedirect__c;
            transactionsToUpdate.add(transactionshim);
        }
        if (!transactionListRecords.isEmpty()) {

            update transactionsToUpdate;
        }

    }
}