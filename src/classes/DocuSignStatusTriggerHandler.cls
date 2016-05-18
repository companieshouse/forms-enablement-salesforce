/**
 * DocuSign Status Trigger Handler
 * Update Transaction Status to completed when Envelope is completed
 *
 * Author: antonio.bravo@golligo.co.uk
 * ab
 * LB: May 9 2016 - Updated Trigger handler for rejected statuses
 **/
public class DocuSignStatusTriggerHandler{

    public static void beforeUpdate(List<dsfs__DocuSign_Status__c> newList){
        
        Set<Id> txIds = new Set<Id>();
        Set<Id> rejectedtxIds = new Set<Id>();
        List<Transaction__c> transactionToUpdate = new List<Transaction__c>();
        // note this needs to be more dynamic 
    
        for(dsfs__DocuSign_Status__c dss : newList){
            if(dss.dsfs__Envelope_Status__c == AppConstants.DOCUSIGN_STATUS_COMPLETED)
              {  txIds.add(dss.Transaction__c);}
             else if (dss.dsfs__Envelope_Status__c == AppConstants.DOCUSIGN_STATUS_REJECTED)
             { rejectedtxIds.add(dss.Transaction__c);}
        }

        //Update Transactions on DRAFTSTATUS
        for(Transaction__c tx : [Select Id, Status__c from Transaction__c where Id IN :txIds]) {
            if(tx.Status__c != AppConstants.REQUEST_STATUS_SIGNED){
                tx.Status__c = AppConstants.REQUEST_STATUS_SIGNED;
                transactionToUpdate.add(tx);
            } 
        }

         //   TODO: Make more dynamic to handle all of the possible STATUSES
        // update rejected statuses on the Transaction object
       for(Transaction__c rejectedtransactions : [Select Id, Status__c from Transaction__c where Id IN :rejectedtxIds]) {
            //if(rejectedtransactions.Status__c == AppConstants.REQUEST_STATUS_DRAFT){
                rejectedtransactions.Status__c = AppConstants.DOCUSIGN_STATUS_REJECTED;
                transactionToUpdate.add(rejectedtransactions);
            //} 
            } 
        }

         //   TODO: Make more dynamic to handle all of the possible STATUSES
        // update rejected statuses on the Transaction object
       for(Transaction__c rejectedtransactions : [Select Id, Status__c from Transaction__c where Id IN :rejectedtxIds]) {
            //if(rejectedtransactions.Status__c == AppConstants.REQUEST_STATUS_DRAFT){
                rejectedtransactions.Status__c = AppConstants.DOCUSIGN_STATUS_DECLINED_SIG; //AppConstants.DOCUSIGN_STATUS_REJECTED;
                transactionToUpdate.add(rejectedtransactions);
            //} 
        }

        
         
        //Update Transactions
        if(!transactionToUpdate.isEmpty())
            update transactionToUpdate;

    }

}