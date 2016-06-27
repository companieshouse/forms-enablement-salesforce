public class DocusignTecipientTriggerStatusHandler {
/*
	public static void beforeUpdate(List<dsfs__DocuSign_Recipient_Status__c> recipientList){
        
        Set<Id> txIds = new Set<Id>();
        Set<Id> dSignStatus = new Set<Id>();
        List<Transaction__c> transactionsforStatus = new List<Transaction__c>();
        // note this needs to be more dynamic 
    
        for(dsfs__DocuSign_Recipient_Status__c dssRecipStatus : recipientList){
            if(dssRecipStatus.dsfs__Envelope_Status__c == AppConstants.DOCUSIGN_STATUS_COMPLETED)
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
                rejectedtransactions.Status__c = AppConstants.DOCUSIGN_STATUS_DECLINED_SIG; //AppConstants.DOCUSIGN_STATUS_REJECTED;
                transactionToUpdate.add(rejectedtransactions);
            //} 
        }

        
         
        //Update Transactions
        if(!transactionToUpdate.isEmpty())
            update transactionToUpdate;

    }
    */
}