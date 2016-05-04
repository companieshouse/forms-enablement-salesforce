/**
 * DocuSign Status Trigger Handler
 * Update Transaction Status to completed when Envelope is completed
 *
 * Author: antonio.bravo@golligo.co.uk
 * ab
 **/
public class DocuSignStatusTriggerHandler{

    public static void beforeUpdate(List<dsfs__DocuSign_Status__c> newList){
        
        Set<Id> txIds = new Set<Id>();
        List<Transaction__c> transactionToUpdate = new List<Transaction__c>();

    
        for(dsfs__DocuSign_Status__c dss : newList){
            if(dss.dsfs__Envelope_Status__c == AppConstants.DOCUSIGN_STATUS_COMPLETED)
                txIds.add(dss.Transaction__c);
        }

        //Update Transactions on DRAFTSTATUS
        for(Transaction__c tx : [Select Id, Status__c from Transaction__c where Id IN :txIds]) {
            if(tx.Status__c == AppConstants.REQUEST_STATUS_DRAFT){
                tx.Status__c = AppConstants.REQUEST_STATUS_SIGNED;
                transactionToUpdate.add(tx);
            }
        }
         
        //Update Transactions
        if(!transactionToUpdate.isEmpty())
            update transactionToUpdate;

    }
}