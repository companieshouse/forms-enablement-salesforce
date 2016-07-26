/**
 * DocuSign Status Trigger Handler
 * Update Transaction Status to completed when Envelope is completed
 *
 * Author: antonio.bravo@golligo.co.uk
 * ab
 * LB: May 9 2016 - Updated Trigger handler for rejected statuses
 * SP: June 30 2016 - Removed useless query and change the code to be more readable
 **/
public class DocuSignStatusTriggerHandler{

    public static void beforeUpdate(List<dsfs__DocuSign_Status__c> newList){
        
        updateDocusignStatus(newList);
    }

    public static void beforeInsert(List<dsfs__DocuSign_Status__c> newList){
        
        updateDocusignStatus(newList);
    }    

    public static void updateDocusignStatus(List<dsfs__DocuSign_Status__c> newList)
    {
        List<Transaction__c> transactionToUpdate = new List<Transaction__c>();
        
        //Iterate the list of envelope   
        for(dsfs__DocuSign_Status__c dss : newList)
        {
            //Look for the envelope to be completed
            if(dss.dsfs__Envelope_Status__c == AppConstants.DOCUSIGN_STATUS_COMPLETED)
            {
                transactionToUpdate.add(new Transaction__c(Id = dss.Transaction__c, Status__c = AppConstants.REQUEST_STATUS_SIGNED));
            }
            else if (dss.dsfs__Envelope_Status__c == AppConstants.DOCUSIGN_STATUS_REJECTED)
            { 
                transactionToUpdate.add(new Transaction__c(Id = dss.Transaction__c, Status__c = AppConstants.DOCUSIGN_STATUS_REJECTED));
            }
        }

        //Update Transactions
        if(!transactionToUpdate.isEmpty())
            update transactionToUpdate;

    }
}